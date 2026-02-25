public with sharing class AccountController {
    // public static List<Account> getAllActiveAccounts() {
    //   return [SELECT Id,Name,Active__c FROM Account WHERE Active__c = 'Yes'];
    // }

    public static void checkContact(list<Account> newAccounts, Map<Id,Account>oldAccountMap){
		
      set<Id> accountIdSet = new set<Id>();
      Map<Id,Account> accountIDandAccountMap = new Map<Id,Account>();
      For(Account acc:newAccounts){
        Account a = [Select ID,Name,AccountId,phone from contact where accountID =: acc.Id];
        If(acc.Status__c != oldAccountMap.get(acc.Id).Status__c){
          accountIdSet.add(acc.Id);
          accountIDandAccountMap.put(acc.Id,acc);
        }
      }
      
      list<contact> cont = [Select ID,Name,AccountId from contact where accountID IN: accountIdSet];
      
      if(cont.size()>0){
        
        for(Contact con:cont){
          
          Account acnt = accountIDandAccountMap.get(con.AccountId);
          acnt.addError('This Account has contact');
        }
      }
    }
  }