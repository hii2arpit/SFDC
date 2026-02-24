public with sharing class updateAccountChildRecords {

    public static void updateContact(Map<Id,String> accountIdAndPhone)
    {

        List<Contact> contactList = [Select Id,Name,phone,AccountId from contact where AccountId IN:accountIdAndPhone.keySet()];
        For(Contact cont:contactList)
        {
            System.debug('Id --- '+cont.Id);
            System.debug('Name --- '+cont.Name);
            System.debug('Phone --- '+cont.Phone);
            System.debug('AccountId --- '+cont.AccountId);

            cont.phone = accountIdAndPhone.get(cont.AccountId);
        }

        update contactList;
    }

    public static void updateContactOtherPhoneNumber(list<Contact> contList)
    {
        List<String> accountId = new list<String>();
        for(Contact con:contList)
        {
            accountId.add(con.AccountId);
        }

        Map<Id,Account> mapOfAcc = new Map<Id,Account>([Select id,name,phone from Account Where ID IN: accountId]);
        For(Contact con:contList)
        {
            if(mapOfAcc.size() >0 && con.AccountId != NULL && mapOfAcc.containsKey(con.AccountId))
            {
                System.debug('inside condition----');
                con.OtherPhone = mapOfAcc.get(con.AccountId).phone;
            }
                
        }
    }

    public static void checkDuplicateLead(List<lead> leadList)
    {
        System.debug('Calling From Trigger');
        set<String> leadEmailSet = new set<String>();
        for(Lead leadRecord:leadList){
            if(leadRecord.email != null)
            {
                leadEmailSet.add(leadRecord.email);
            }
        }
        List<Lead> existingLeadRecords = [Select id,name,email from lead Where Email IN:leadEmailSet];
        System.debug('existingLeadRecords.size()---'+existingLeadRecords.size());
        List<String> leadEmails = new List<String>();
        for(Lead lRecord:existingLeadRecords)
        {
            System.debug('Old email --- '+lRecord.email);
            leadEmails.add(lRecord.email);
        }

        For(Lead newRecord:leadList)
        {
            System.debug('newRecord.Email --- '+newRecord.Email);
            If(leadEmails.contains(newRecord.Email))
            {
                newRecord.addError('This email is already exist');
            }
        }
    }

    public static void updateAccountPrincipalField(list<Account> accountList)
    {
        list<String> ownerIdList = new List<String>();
        For(Account acc:accountList)
        {
            ownerIdList.add(acc.OwnerId);
        }

        list<user> userList = [Select Id,name from user where Id IN:ownerIdList];
        Map<String,String> userMap = New Map<String,String>();
        For(user u:userList)
        {
            userMap.put(u.Id,U.name);
        }

        For(Account acc:accountList)
        {
            acc.Site = userMap.get(acc.OwnerId);
            acc.Principal_Id__c = acc.OwnerId;
        }
    }

    public static void updateOpportunity(list<Opportunity> opportunityList, Map<Id,Opportunity> OldMap)
    {
        For(opportunity opp:opportunityList)
        {
            if((opp.StageName != oldMap.get(opp.Id).StageName) && opp.StageName == 'Closed Won')
            {  
                    Opp.CloseDate = System.today();
                    opp.Type = 'New Customer';
            }

            If(Opp.StageName == 'Closed Won' && oldMap.get(opp.Id).StageName != 'Closed Won' )
            {
                opp.Active_Customer_project__c = true;
            }else{
                opp.addError('You cannot make Active Customer Porject Checkbox to true if stage is not closed Won');
            }
        }
    }

    public static void createdContact(list<Account> accRecord)
    {
        list<Contact> contactlist = New List<Contact>();
        for(Account acc:accRecord)
        {
            If(acc.Industry == 'Banking')
            {
                Contact cont = new Contact(); 
                cont.LastName = acc.name;
                cont.phone = acc.Phone;
                cont.AccountId = acc.Id;
                contactList.add(cont);
            }
        }

        if(contactlist.size() > 0)
        {
            insert contactlist;
        }

    }

    public static void delteContactWithoutAccount(list<Contact> conList)
    {
        // for(Contact cont:conList)
        // {
        //     if(cont.AccountId != null)
        //     {
        //         cont.addError('You cannnot delete this contact.');
        //     }
        // }
    }


}