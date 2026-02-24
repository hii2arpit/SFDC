public class training
{

    @AuraEnabled  
    public static list<Training__c> getTrainings(string trainingType){
        system.debug('****trainingType'+trainingType);
        list<Training__c> tlist;
          if(string.isBlank(trainingType) || trainingType=='All'){
           tlist =[SELECT ID,Course_Image__c,Course_Name__c,Course_Source__c,
                                          Course_Type__c,Description__c,Status__c,Applicable_for__c,
                                          Course_URL__c
                                     FROM Training__c
                                     Where Status__c='Active'
                                     order by createdDate ASC
                                     ];
           system.debug('tlist'+tlist);
          }
          else{
               tlist =[SELECT ID,Course_Image__c,Course_Name__c,Course_Source__c,
                                          Course_Type__c,Description__c,Status__c,Applicable_for__c,
                                          Course_URL__c
                                     FROM Training__c
                                     Where Status__c='Active'
                                     AND Applicable_for__c INCLUDES (:trainingType)
                                     order by createdDate ASC
                                     ];
           system.debug('tlist'+tlist);
          }
  
        return tlist;
      }
}