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
        Integer countContAfterUpdate = 0;
       
        AddPrimaryContact adder = new AddPrimaryContact(new Contact(LastName = 'TestQueue'), 'CA');

        
        Test.startTest();
        System.enqueueJob(adder);
        Test.stopTest();
        
        List<Account> accs = [SELECT id, (SELECT Id FROM Contacts)FROM Account WHERE BillingState='CA'];
        
        
        for(Account acc : accs){
            if(acc.Contacts.size()==1){
                countContAfterUpdate++;
            } 
        }
        
        
        System.assertEquals(50, countContAfterUpdate);
    }
    
    
}