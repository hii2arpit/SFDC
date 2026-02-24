public with sharing class UpdateAccountWithMaxAmountOpportunity {
    
    public static void updateAccount(list<Opportunity> newOpp, Map<Id,opportunity> oldMapOpp) {

        Set<String> allAccountsId = New Set<String>();
        For(Opportunity opp:newOpp)
        {
            if(oldMapOpp != null)
            {
                if(oldMapOpp.get(opp.Id).AccountId != opp.AccountId)
                {
                    allAccountsId.add(oldMapOpp.get(opp.Id).AccountId);
                    allAccountsId.add(opp.AccountId);
                }else{
                    allAccountsId.add(opp.AccountId);
                }
            }else{
                allAccountsId.add(opp.AccountId);
            }
        }

        list<Account> accountRecords = [Select Id,Name,AnnualRevenue,(Select Id,name,Amount From Opportunities order by Amount Desc limit 1) from account 
        where Id IN:allAccountsId];

        System.debug('Logsss---'+accountRecords.size());
        list<Account> accountNeedsToUpdate = New List<Account>();
        For(Account acc:accountRecords)
        {
            System.debug('Account Name---'+acc.name);
            System.debug('Opportunity Name---'+acc.Opportunities[0].name);
            System.debug('Opportunity Amount---'+acc.Opportunities[0].Amount);
            if(acc.Opportunities.size() > 0)
            {
                acc.AnnualRevenue = acc.Opportunities[0].Amount;
                accountNeedsToUpdate.add(acc);
            }else{
                acc.AnnualRevenue = 0.0;
            }
           
        }
        
        if(accountNeedsToUpdate.size() > 0)
        {
            update accountNeedsToUpdate;
        }
    }

    public static void updateMinAndMaxSalary(list<Contact> cont, Map<Id,contact> oldMap)
    {
        set<String> contactAccountIdList = new Set<String>();

        for(Contact con:cont){
            if(oldMap != null)
            {
                contact oldContact =  oldMap.get(con.Id);
                if(oldContact.AccountId != con.AccountId)
                {
                    contactAccountIdList.Add(oldContact.AccountId);
                    contactAccountIdList.Add(con.AccountId);
                }else{
                    contactAccountIdList.Add(con.AccountId);
                }
            }else{
                contactAccountIdList.Add(con.AccountId);
            }
        }

        list<AggregateResult> aggrResult = [Select AccountId aggrId,Max(Salary__c) aggrMax,MIN(Salary__c) aggrMin from 
        contact where AccountId IN:contactAccountIdList Group by AccountId];

        Map<Id,Account> updateAccountMap = New Map<Id,Account>();
        for(String ids:contactAccountIdList)
        {
            Account acc = new Account();
            acc.Max_Salary__c = 0;
            acc.Min_Salary__c = 0;
            acc.Id= ids;
            updateAccountMap.put(ids,acc);
        }

        for(AggregateResult agr:aggrResult)
        {
            System.debug('Max---'+(Decimal)agr.get('aggrMax'));
            System.debug('Min---'+(Decimal)agr.get('aggrMin'));
            System.debug('AccountId---'+(Id)agr.get('aggrId'));
            Account acc = new Account();
            acc.Max_Salary__c = (Decimal)agr.get('aggrMax');
            acc.Min_Salary__c = (Decimal)agr.get('aggrMin');
            acc.Id= (Id)agr.get('aggrId');
            updateAccountMap.put(acc.Id,acc);
        }

        if(!updateAccountMap.isEmpty())
        {
            update updateAccountMap.values();
        }
    }
}