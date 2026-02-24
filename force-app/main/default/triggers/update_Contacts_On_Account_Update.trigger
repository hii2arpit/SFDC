trigger update_Contacts_On_Account_Update on Account (After update,After Insert) {
    // if(Trigger.isAfter && Trigger.isUpdate)
    // {
    //     Map<Id,String> accountIdAndPhone = New Map<Id,String>();
    //     for(Account acc:Trigger.new)
    //     {
    //         if(acc.phone != trigger.oldMap.get(acc.id).Phone)
    //         {
    //             accountIdAndPhone.put(acc.Id,acc.Phone);
    //         }
    //     }

    //     if(accountIdAndPhone.keySet().size() > 0)
    //     {
    //         updateAccountChildRecords.updateContact(accountIdAndPhone);
    //     }
    // }

    // If(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate))
    // {
    //     updateAccountChildRecords.updateAccountPrincipalField(Trigger.new);
    // }

    // If(Trigger.isInsert && Trigger.isAfter)
    // {
    //     updateAccountChildRecords.createdContact(Trigger.new);
    // }
}