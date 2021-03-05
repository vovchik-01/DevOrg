@isTest
public class AccountManagerTest {
    @isTest 
    static void testGetAccById() {
        Id recordId = createTestRecord();
        // Set up a test request
        RestRequest request = new RestRequest();
        request.requestUri =
            'https://yourInstance.salesforce.com/services/apexrest/Accounts/'
            + recordId;
        request.httpMethod = 'GET';
        RestContext.request = request;
        // Call the method to test
        Account thisAcc = AccountManager.getAccount();
        // Verify results
        System.assert(thisAcc != null);
        System.assertEquals('Test record', thisAcc.Name);
    }
    
    static Id createTestRecord() {
        // Create test record
        Account AccTest = new Account(
            Name='Test record',
            Phone='New'
                       );
        insert AccTest;
        return AccTest.Id;
    }          
}