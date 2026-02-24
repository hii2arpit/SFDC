trigger getContactMaxAndMinSalaryAndUpdateAcc on Contact (After insert,After Update,After Delete, After Undelete) {

    // If(Trigger.isAfter && Trigger.isUpdate)
    // {
    //     UpdateAccountWithMaxAmountOpportunity.updateMinAndMaxSalary(Trigger.new,Trigger.oldMap);
    // }
    // If(Trigger.isAfter && Trigger.isDelete)
    // {
    //     UpdateAccountWithMaxAmountOpportunity.updateMinAndMaxSalary(Trigger.New,null);
    // }Else{
    //     UpdateAccountWithMaxAmountOpportunity.updateMinAndMaxSalary(Trigger.New,null);
    // }
}