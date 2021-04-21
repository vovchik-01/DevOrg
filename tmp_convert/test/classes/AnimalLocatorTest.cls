@isTest
public class AnimalLocatorTest {
@isTest 
    static  void testGetCallout() {
        Test.setMock(HttpCalloutMock.class, new AnimalLocatorMock()); 
        // Create the mock response based on a static resource
        String res = AnimalLocator.getAnimalNameById(2);
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('GetAnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, mock);
        // Call method to test
        // Verify mock response is not null
        System.assertNotEquals(null,res,
            'The callout returned a null response.');     
        System.assertEquals('bear', res);          
    }   
}