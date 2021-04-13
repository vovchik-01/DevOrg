global class AccountProcessor {
    @future
    public static void countContacts(List<Id> accIdlist) {
        
        List<Account> accForUpdate = new List<Account>();
        
        List <Account> accBeforeUpdate = [SELECT Id,
                                                 (SELECT Id 
                                                 FROM Contacts)
                                          FROM Account 
                                          WHERE Id IN :accIdlist]; 
        
        for(Account acc : accBeforeUpdate){
            acc.Number_of_Contacts__c = acc.Contacts.size();
            accForUpdate.add(acc); 
        }
        
        if(accForUpdate.size() > 0){
            update accForUpdate;
        }
        
    }
}