trigger checkOpportunityProductSerialNumber on Opportunity(Before update){
	
	if(trigger.isupdate && trigger.isbefore){
		
		opportunityController.checkProductSerialNumber(Trigger.New, Trigger.OldMap);
	}
}