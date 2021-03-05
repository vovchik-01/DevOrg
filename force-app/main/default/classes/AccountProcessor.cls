global class AccountProcessor {
	@future
    public static void countContacts(List<Id> accId) {
        List<Account> accForUpdate = new List<Account>();
        for(Id i : accId){
           Account acc = [SELECT Id, Name, (SELECT Id, LastName FROM Contacts)
                                  FROM Account WHERE Id = :i]; 
            Integer countCont = acc.Contacts.size();
            acc.Number_of_Contacts__c = countCont;
            accForUpdate.add(acc);
        }
        if(accForUpdate.size() > 0){
            update accForUpdate;
        }
        
    }
}