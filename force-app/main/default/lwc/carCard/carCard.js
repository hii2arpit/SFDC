import { LightningElement,wire } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Car__c.Name';
import PICTURE_URL_FIELD from '@salesforce/schema/Car__c.Picture_URL__c';
import CATEGORY_FIELD from '@salesforce/schema/Car__c.Category__c';
import MAKE_FIELD from '@salesforce/schema/Car__c.Make__c';
import MSRP_FIELD from '@salesforce/schema/Car__c.MSRP__c';
import FUEL_FIELD from '@salesforce/schema/Car__c.Fuel_Type__c';
import SEATS_FIELD from '@salesforce/schema/Car__c.Seats__c';
import CONTROL_FIELD from '@salesforce/schema/Car__c.Control__c';

//This function is used to extract field values
import { getFieldValue } from 'lightning/uiRecordApi';
export default class CarCard extends LightningElement {

    categoryField = CATEGORY_FIELD;
    makeField = MAKE_FIELD;
    msrpField = MSRP_FIELD;
    fuelField = FUEL_FIELD;
    seatsField = SEATS_FIELD;
    controlField = CONTROL_FIELD;

    recordId = 'a1FIU00000CIGPo2AP';

    //car fields displayed in specific format

    CarName
    carPictureURL
    handleRecordLoaded(event){
        const {records} = event.detail;
        const recordData = records[this.recordId]; 
        this.CarName =  getFieldValue(recordData, NAME_FIELD);
        this.carPictureURL = getFieldValue(recordData, PICTURE_URL_FIELD);
    }
}