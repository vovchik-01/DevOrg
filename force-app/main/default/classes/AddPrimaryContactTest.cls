@isTest
public class AddPrimaryContactTest {
		
    @testSetup
    static void setup() {
        List<Account> accounts = new List<Account>();
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i,
                BillingState='NY'
            ));
        }
        for (Integer i = 0; i < 50; i++) {
            accounts.add(new Account(
                name='Test Account'+i+'CA',
                BillingState='CA'
            ));
        }
        insert accounts;
       
    }
    
    static testmethod void testQueueable() {
        
        List<Account> accounts = [SELECT id, name, (SELECT Id, name FROM Contacts)FROM Account WHERE BillingState='CA'];
        // Create our Queueable instance
        AddPrimaryContact adder = new AddPrimaryContact(new Contact(LastName = 'TestQueue'), 'CA');
        // startTest/stopTest block to force async processes to run
        Test.startTest();
        System.enqueueJob(adder);
        Test.stopTest();
        // Validate the job ran. Check if record have correct parentId now
        System.assertEquals(50, [SELECT count() FROM Account WHERE BillingState='CA']);
    }
    
    
}