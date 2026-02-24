/**
 * @description       : 
 * @author            : ArpitJain
 * @group             : 
 * @last modified on  : 10-17-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public class opportunityRecords {
    
    @AuraEnabled
    public static list<Opportunity> getRelatedOpportunityList(Id recordId)
    {
        List<Opportunity> opportunityList = [Select id,Name,CloseDate,StageName from opportunity where AccountId=: recordId and StageName='Prospecting'];
        return opportunityList;
    }

    @AuraEnabled
    public static void createOppoprtunityRecord(Id recordId)
    {
        Opportunity opp = new Opportunity();
        opp.Name = 'New Opp';
        opp.StageName = 'Prospecting';
        Opp.CloseDate = System.today() + 60;
        Opp.AccountId = recordId;
        opp.CreatedDate = System.today();
        try{
            insert opp;
        }catch(Exception e)
        {
            System.debug('Error while inserting opportunity record ---- '+e);
        }
    }
}