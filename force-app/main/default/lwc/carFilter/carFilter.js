import { LightningElement,wire } from 'lwc';
import { getObjectInfo,getPicklistValues} from 'lightning/uiObjectInfoApi';
import CAR_OBJECT from '@salesforce/schema/Car__c';
import CATEGORY_FIELD from '@salesforce/schema/Car__c.Category__c';
import MAKE_FIELD from '@salesforce/schema/Car__c.Make__c';

const CATEGORY_ERROR="Error loading categories";
const MAKE_ERROR="Error loading maek types";
export default class CarFilter extends LightningElement {

    filters={
        searchKey:'',
        maxPrice:999999
    }
    category_Error = CATEGORY_ERROR;
    make_Error = MAKE_FIELD;

/**** Fetching Category Picklist*/
    @wire(getObjectInfo, {objectApiName:CAR_OBJECT})
    carObjectInfo

    @wire(getPicklistValues, {
        recordTypeId:'$carObjectInfo.data.defaultRecordTypeId',
        fieldApiName: CATEGORY_FIELD
    })categories

/**** Fetching Make Picklist*/
    @wire(getPicklistValues, {
        recordTypeId:'$carObjectInfo.data.defaultRecordTypeId',
        fieldApiName: MAKE_FIELD
    })makeType

    /** Search Key Handler */
    handleSearchKeyChange(event){
        console.log(event.target.value);
        this.filters = {...this.filters,"searchKey":event.target.value}
    }
    /** Price Change Handler */
    handleMaxPriceChange(event){
        console.log(event.target.value);
        this.filters = {...this.filters,"maxPrice":event.target.value}
    }
    
    handleCheckbox(event){
        const {name,value} = event.target.dataset;
        console.log("name",name);
        console.log("value",value);
    }
}