public class AddPrimaryContact implements Queueable{

     private Contact cont;
    private String state;
    
    public AddPrimaryContact(Contact cont, String state) {
        this.cont = cont;
        this.state = state;
    }
    
    public void execute(QueueableContext context) {
        List<Account> accounts = [SELECT Id, Name FROM Account WHERE BillingState = :state];
        for (Account account : accounts) {
              Contact added = cont.clone();
              added.AccountId = account.Id;
       			insert added;
        }
        update accounts;
    }
}