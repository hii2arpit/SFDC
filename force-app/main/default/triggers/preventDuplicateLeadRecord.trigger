trigger preventDuplicateLeadRecord on Lead (before insert, before update) {

    if(Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)){
        updateAccountChildRecords.checkDuplicateLead(Trigger.New);
    }
}