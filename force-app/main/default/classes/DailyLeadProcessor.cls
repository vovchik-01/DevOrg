global class DailyLeadProcessor implements Schedulable{
    global void execute(SchedulableContext ctx) {
        List<Lead> leads = [SELECT Id, Name
                            FROM Lead
                            WHERE LeadSource = null];
        for(Lead lead : leads){
            lead.LeadSource = 'Dreamforce';
        }
        update leads;
    }

}