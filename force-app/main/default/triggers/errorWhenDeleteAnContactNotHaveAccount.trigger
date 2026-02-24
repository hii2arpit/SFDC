trigger errorWhenDeleteAnContactNotHaveAccount on Contact (before delete) {
    if(Trigger.isBefore && Trigger.isDelete)
    {
        updateAccountChildRecords.delteContactWithoutAccount(Trigger.old);
    }

}