public class ExtensionController {
		private ApexPages.StandardController controller;
    
    public ExtensionController (ApexPages.StandardController controller){
        this.controller = controller;
    }
    
    public PageReference doSomething(){
        return null;
    }
}