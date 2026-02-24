trigger testEventTrigger on Test_Event__e (after insert) {
    
    for(Test_Event__e ev:Trigger.New)
    {
        System.debug(ev);
    }
}