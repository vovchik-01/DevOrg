trigger DedupeLead on Lead (before insert) {
    List<Group> dataQualityGroups = [SELECT Id
                                FROM Group
                               WHERE DeveloperName = 'Data_Quality'
                               LIMIT 1];
    for(Lead myLead : Trigger.new){
        if(myLead.Email != null){
        List<Contact> matchingContacts = [SELECT ID,
                                                 FirstName,
                                                 LastName,
                                                 Account.Name
                                            FROM Contact
                                           WHERE Email = :myLead.Email];
        System.debug(matchingContacts.size() + 'contact(s) found.');
        
        if(!matchingContacts.isEmpty()){
            if(!dataQualityGroups.isEmpty()){
               myLead.OwnerId = dataQualityGroups.get(0).Id; 
            }
           
            String dupeContactsMessage = 'Duplicate contact(s) found:\n';
            for(Contact matchingContact : matchingContacts){
                dupeContactsMessage += matchingContact.FirstName + ' '
                                     + matchingContact.LastName + ', '
                                     + matchingContact.Account.Name + ' ('
                                     + matchingContact.Id + ')\n';
            }
            if(myLead.Description!= null){
                dupeContactsMessage += '\n' + myLead.Description;
            }
            myLead.Description = dupeContactsMessage;
        }
        }
    }
}