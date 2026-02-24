public with sharing class ContactController {

    // @AuraEnabled
    // public static List<Contact> findNearby(Double latitude, Double longitude, Double maxDistance) {
    //     return Database.query('SELECT Id, Name, MailingStreet, MailingCity, MailingState, MailingPostalCode, MailingCountry, Phone FROM contact' +
    //                    ' WHERE DISTANCE(Location__c, GEOLOCATION(' + latitude + ',' + longitude + '), \'mi\') < '+ maxDistance +
    //                    ' ORDER BY DISTANCE(Location__c, GEOLOCATION(' + latitude + ',' + longitude + '), \'mi\')');
        
    // }

    public static void checkduplicateContact(list<contact> newcontList, Map<Id,contact> oldContMap)
    {
       
        Map<String,contact> EmailandContactMap = new Map<String,Contact>();
        String ErrorMEssage = 'This is a duplicate contact';
        for(contact c:newcontList){
            if(oldContMap != null){
                
                if(c.email != oldContMap.get(c.Id).email){
                    if(EmailandContactMap.containsKey(c.Email)){
                        c.AddError(ErrorMEssage+' coming from data loader with Same Email');
                    }else{
                    EmailandContactMap.put(c.Email,c);
                    }
                }
            }else{
                
                if(EmailandContactMap.containsKey(c.Email)){
                    c.AddError(ErrorMEssage+' coming from data loader with Same Email');
                }else{
                    EmailandContactMap.put(c.Email,c);
                }
            }
        }
        
        
        list<Contact> existingcont = [Select Name,Email from contact where Email IN: EmailandContactMap.keySet() WITH USER_MODE];
        
     
       // String ErrorMEssage = 'This is a duplicate contact with the same email';
        if(existingcont.size()>0){
            
            for(Contact cont:existingcont){
                
                if(EmailandContactMap.get(cont.Email) != null)
                {
                    contact con = EmailandContactMap.get(cont.Email);
                    con.description = ErrorMEssage;
                    con.addError(ErrorMEssage+' existing in the system with same Email');
                }
            }
        }
    }
}