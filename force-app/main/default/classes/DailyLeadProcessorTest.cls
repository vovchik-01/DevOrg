@isTest
public class DailyLeadProcessorTest {
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
static testmethod void testScheduledJob() {
        // Create some out of date Opportunity records
        List<Lead> leads = new List<Lead>();
        for (Integer i=0; i<200; i++) {
            Lead l = new Lead( LastName = 'Lead '+i,
                               Company  = 'Test Company ' + i,
                               Status   = 'Open');
            leads.add(l);
        }
        insert leads;
       
        Test.startTest();

        String jobId = System.schedule('ScheduledApexTest',
                                        CRON_EXP,
                                        new DailyLeadProcessor());
        List<Lead> ls = [SELECT Id
            FROM Lead
            WHERE LeadSource='Dreamforce'];
        System.assertEquals(0, ls.size());
        Test.stopTest();
    
        ls = [SELECT Id
            FROM Lead
            WHERE LeadSource='Dreamforce'];
        System.assertEquals(200,ls.size());
    }
}