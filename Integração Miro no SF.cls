Integração SF --> MIRO

Método em que consiste na incorporação de quadros miro no SF

public without sharing class cmpControllerLinkMiro {
    public cmpControllerLinkMiro() {

    }
    @AuraEnabled
	public static String getLinkMiro(id thisAccountId){
        String result = '';
        try {
            Account acc = [SELECT Id, Name, Link_Miro__c FROM Account WHERE Id =:thisAccountId ];
            return acc.Link_Miro__c;

        } catch (Exception ex ) {
            System.debug(ex.getCause());
            System.debug(ex.getMessage());
            System.debug(ex.getLineNumber());

            return result;
        }
	}
}

<aura:component implements="force:hasRecordId,force:appHostable,flexipage:availableForAllPageTypes" access="global" controller= "cmpControllerLinkMiro">

    <aura:attribute name="linkmiro" type="String"/> 
    <aura:attribute name="recordId"	type="Id" />

    <aura:handler name="init" value="{!this}" action="{!c.init}" /> 

    <lightning:card >        
          <iFrame src="{!v.linkmiro}" frameBorder="0" width="100%" height="500px;" scrolling="no" />   
    </lightning:card>  

</aura:component>

({
    init : function(component,event, helper){
		helper.getLinkMiro(component, event);
	},
})

({
    getLinkMiro : function(component, event){
		var action = component.get("c.getLinkMiro");
		action.setParams({
			"thisAccountId" : component.get("v.recordId"),
		});	
        
        action.setCallback(this,function(response){
			var state = response.getState();
			if(state === "SUCCESS"){
				component.set("v.linkmiro", response.getReturnValue());               
			}
		});

		$A.enqueueAction(action);
	}
})

