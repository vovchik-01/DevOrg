@isTest
public class LeadProcessorTest {

    @testSetup
    static void setup(){
        List<Lead> leads = new List<Lead>();
        for(Integer i = 0; i<200; i++){
            leads.add(new Lead(LastName = 'Lead '+i,
                               Company  = 'Test Company ' + i,
                               Status   = 'Open'
                              ));
        }
        insert leads;
    }
    
    @isTest static void test() {
        Test.startTest();
        LeadProcessor lp = new LeadProcessor();
        Id batchId = Database.executeBatch(lp);
        Test.stopTest();
        // after the testing stops, assert records were updated properly
        List <Lead> res = [SELECT Id, LastName FROM Lead WHERE LeadSource = 'Dreamforce'];
        System.assertEquals(200, res.size());
    }
    
    
    
}