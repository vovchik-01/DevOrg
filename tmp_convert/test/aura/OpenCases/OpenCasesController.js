({
    doInit : function(cmp, event, helper) {
        var action = cmp.get("c.getCasesDB");
        console.log('calling doInit');
        action.setCallback(this, function(response){
           var state = response.getState();
                           if(cmp.isValid() && state === "SUCCESS"){
            console.log('getting cases');
            cmp.set("v.cases", response.getReturnValue());
        }
                                          });
    $A.enqueueAction(action);
    },
    
    goToRecord : function(cmp, event, helper) {
        var sObjectEvent = $A.get("e.force:navigateToSObject");
        sObjectEvent.setParams({
            "recordId": cmp.get("v.case.Id"),
            "slideDevName": 'detail'
        })
        sObjectEvent.fire();
    }
    
    
})