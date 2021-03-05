@RestResource(urlMapping='/Accounts/*/contacts')
global with sharing class AccountManager {
		@HttpGet
    global static Account getAccount() {
        RestRequest request = RestContext.request;
        String accId = request.requestURI.removeEnd('/contacts');
        String res = accId.substring(accId.lastIndexOf('/')+1);
        Account result =  [SELECT Id, Name, (Select Id, Name FROM Contacts)
                        FROM Account
                        WHERE Id = :res];
        return result;
    }

}