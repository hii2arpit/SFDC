import { LightningElement } from 'lwc';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
//import WernerMap from '@salesforce/resourceUrl/WernerMap';
import trimblemaps from '@salesforce/resourceUrl/MapJS';
import bootstrap from '@salesforce/resourceUrl/bootstrap';

export default class ShowMap extends LightningElement {

    connectedCallback() {
        alert('Connected Callback---'+trimblemaps);
        Promise.all([
            loadScript(this, trimblemaps + '/WarnerMap/WM.js'),
           // loadStyle(this, trimblemaps + '/WarnerMap/WM.css')
        ]).then(() => {
            alert('loaded');  
            this.draw();     
        }).catch(err => {
          alert('not loaded')
          console.log('Error-------'+err);
         });
    }

    draw()
    {
        alert('Inside Draw'); 
        trimblemaps.APIKey = "8B61C94BD27D964CAE17F7B5B6A54C55";
        const myMap = new trimblemaps.Map({
        container: "myMap",
        center: new trimblemaps.LngLat(-96, 35),
        zoom: 3
        });
    }
}