trigger AccountPhoneUpdateOnContactCreation on Contact (before insert) 
{
    If(Trigger.isBefore && Trigger.isInsert)
    {
        For(Contact cont:Trigger.new)
        {
            System.debug('Account Id --- '+cont.AccountId);
            if(cont.AccountId != null)
            {
                List<Contact> contList = New List<Contact>();
                contList.add(cont);
                updateAccountChildRecords.updateContactOtherPhoneNumber(contList);
            }
        }
    }
}