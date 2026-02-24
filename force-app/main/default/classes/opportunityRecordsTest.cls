/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 10-17-2022
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
@isTest
public without sharing class opportunityRecordsTest {
    
    @testSetup static void setup()
    {
        Account acc = New Account(Name='Test');
        insert acc;

        list<opportunity> opportunityList = new list<opportunity>();

        for(Integer i = 0; i< 5; i++)
        {
            Date d = System.today() + 30;
            Opportunity opp = New Opportunity(Name='New Opp'+i+1,StageName='Prospecting',CloseDate = d);
            opportunityList.add(opp);
        }
        insert opportunityList;
    }

    static testMethod void getRelatedOpportunityListTest() 
    {
        Account acc = [select id,Name from Account];
        Test.startTest();
        opportunityRecords.getRelatedOpportunityList(acc.Id);
        Test.stopTest();
    }

    static testMethod void createOppoprtunityRecordTest() 
    {
        Account acc = [select id,Name from Account];
        Test.startTest();
        opportunityRecords.createOppoprtunityRecord(acc.Id);
        Test.stopTest();
    }
    
}