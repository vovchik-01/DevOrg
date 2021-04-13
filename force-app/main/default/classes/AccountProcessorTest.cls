@isTest
public class AccountProcessorTest {
    @IsTest
    private static void testAccountProcessor() {
        List<Account> res = new List<Account>();
        for(Integer i = 0; i<250; i++){
            Account acc = new Account(Name='Test Name1'+i);
            Contact con = new Contact(LastName = 'NewName'+i,
                                      Id = acc.Id);
            
            res.add(acc);
        }
        
        insert res;
        
        List<Id> accId = new List<Id>();
        for(Account a : res){
            Id id = a.Id;
            accId.add(id);
        }
        Test.startTest();
        AccountProcessor.countContacts(accId);
        Test.stopTest();
        
        Integer countCorrectUpdatedAccounts=0;
        List <Account> accAfterUpdate = [SELECT Id,
                                                (SELECT Id 
                                                 FROM Contacts)
                                         FROM Account 
                                         WHERE Id IN :accId];
        
        for(Account acc : accAfterUpdate){
            if(acc.Contacts.size()==acc.Number_of_Contacts__c){
                countCorrectUpdatedAccounts++;
            } 
        }
        System.assertEquals(250, countCorrectUpdatedAccounts);
        
    }
}