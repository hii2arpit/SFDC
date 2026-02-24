({
	Init : function(component,event,helper) {
		var strLabel = $A.get("$Label.c.OpportunityFields");
        console.log(strLabel);
        var str_array = strLabel.split(',');
		component.set("v.customLabelValue", str_array);
        
        
        var relatedOpportunityRecords = component.get("c.getRelatedOpportunityList");
        relatedOpportunityRecords.setParams({recordId: component.get("v.recordId")});
        relatedOpportunityRecords.setCallback(this, function(data) 
        {
           if(data.getReturnValue())
           {
           		component.set("v.opportunityList", data.getReturnValue());    
           }
        });
        $A.enqueueAction(relatedOpportunityRecords);
	},
	opportunityRecord: function(component,event,helper)
	{

        var action = component.get("c.createOppoprtunityRecord");
        action.setParams({
            recordId: component.get("v.recordId")
        });

        action.setCallback(this, function(response)
        {
            var state = response.getState();
            if(state === 'SUCCESS')
            {
                var toastReference = $A.get("e.force:showToast");
                toastReference.setParams({
                    "type":"Success",
                    "title":"Success",
                    "message": "Opportunity is created.",
                    "mode": "dismissible"
                });
                toastReference.fire();
				helper.Init(component,event,helper);
            }else{
                console.log("Error during saving the record! "+state);
            }
        });
        $A.enqueueAction(action);
	}
})