import { LightningElement,api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import getTrainings from '@salesforce/apex/training.getTrainings';
export default class TrainingData extends NavigationMixin(LightningElement)  {

    trainingList;
    @api trainingType;
    courseLink;

    connectedCallback(){

        this.getTrainingData();
    }

    getTrainingData(){
        getTrainings({trainingType: this.trainingType})
        .then(result => {
            // alert('Result --- '+JSON.stringify(result));
            this.trainingList = result;
        })
    }

    handleClick(event)
    {
        this.courseLink = event.target.dataset.name;
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: this.courseLink
            }
        });
    }
}