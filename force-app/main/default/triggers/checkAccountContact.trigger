trigger checkAccountContact on Account(before update){
	If(trigger.isbefore && trigger.isUpdate){
		AccountController.checkContact(Trigger.New,Trigger.OldMap);
	}
}