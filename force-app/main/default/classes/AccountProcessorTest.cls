@isTest
public class AccountProcessorTest {
   @IsTest
  private static void testAccountProcessor() {
      List<Account> res = new List<Account>();
      for(Integer i = 0; i<3; i++){
          Account acc = new Account(Name='Test Name'+i);
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
  }
}