trigger preventContactDuplicate on Contact(before insert,before update){
	
	if(trigger.isBefore && Trigger.isUpdate){
		contactController.checkduplicateContact(Trigger.new,trigger.oldMap);
	}else{
		contactController.checkduplicateContact(Trigger.new,null);
	}
	
}