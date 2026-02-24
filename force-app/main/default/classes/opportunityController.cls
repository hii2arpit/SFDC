public class opportunityController{

	public static void checkProductSerialNumber(list<Opportunity> newOppList, Map<Id,Opportunity> oldOppMap){
	
		Set<Id> OpportunityIdSet = New set<Id>();
		Map<Id,Opportunity> MapofIdandOpportunity = new Map<Id,Opportunity>();
		for(Opportunity opp:newOppList){
			if((opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost' ) && 
			(oldOppMap.get(Opp.Id).StageName!='Closed Won' ||oldOppMap.get(Opp.Id).StageName!='Closed Lost')){
				OpportunityIdSet.add(Opp.Id);
                MapofIdandOpportunity.put(opp.Id,Opp);
			}
		}
		
		list<OpportunityLineItem> oli = [Select Id,Serial_No__c,OpportunityId from opportunitylineItem where OpportunityId IN:OpportunityIdSet 
		and Serial_No__c = null];
		
		if(oli.size()>0){
			
			For(opportunitylineItem o:oli){
			
				Opportunity opp = MapofIdandOpportunity.get(o.OpportunityId);
				opp.addError('It cannot be closed as SerialNumber is Empty');
			}
		}
	}
}