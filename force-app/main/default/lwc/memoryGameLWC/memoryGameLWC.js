import { LightningElement } from 'lwc';
import {loadStyle} from 'lightning/platformResourceLoader'
import fontawesome from '@salesforce/resourceUrl/fontawesome'
export default class MemoryGameLWC extends LightningElement {

    isLoaded = false
    opnedCards = []
    moves=0
    matchedCard = []
    action
    cards=[
        {id:1, listClass:"card", type:'diamond', icon:'fa fa-diamond'},
        {id:2, listClass:"card", type:'plane', icon:'fa fa-paper-plane-o'},
        {id:3, listClass:"card", type:'anchor', icon:'fa fa-anchor'},
        {id:4, listClass:"card", type:'bolt', icon:'fa fa-bolt'},
        {id:5, listClass:"card", type:'cube', icon:'fa fa-cube'},
        {id:6, listClass:"card", type:'anchor', icon:'fa fa-anchor'},
        {id:7, listClass:"card", type:'leaf', icon:'fa fa-leaf'},
        {id:8, listClass:"card", type:'bicycle', icon:'fa fa-bicycle'},
        {id:9, listClass:"card", type:'diamond', icon:'fa fa-diamond'},
        {id:10, listClass:"card", type:'bomb', icon:'fa fa-bomb'},
        {id:11, listClass:"card", type:'leaf', icon:'fa fa-leaf'},
        {id:12, listClass:"card", type:'bomb', icon:'fa fa-bomb'},
        {id:13, listClass:"card", type:'bolt', icon:'fa fa-bolt'},
        {id:14, listClass:"card", type:'bicycle', icon:'fa fa-bicycle'},
        {id:15, listClass:"card", type:'plane', icon:'fa fa-paper-plane-o'},
        {id:16, listClass:"card", type:'cube', icon:'fa fa-cube'},
      ]



    renderedCallback(){
        if(this.isLoaded)
        {
            return
        }else{
            loadStyle(this,fontawesome+'/fontawesome/css/font-awesome.min.css').then(()=>{
                console.log("Loaded Successfully")
            }).catch(error=>{
                console.log(error)
            })
            this.isLoaded  = true;
        }
        
    }
    displayCard(event){
        let currCard = event.target;
        currCard.classList.add("open", "show", "disabled");
        this.opnedCards = this.opnedCards.concat(event.target);
        const len = this.opnedCards.length;
        if(len === 2)
        {
            this.moves = this.moves+1
            alert('Tets --- '+this.opnedCards[0].type );
            if(this.opnedCards[0].type === this.opnedCards[i].type){
                this.matchedCard = this.matchedCard.concat(this.opnedCards[0],this.opnedCards[1]);
                this.matched();
            }else{
                this.unmatched();
            }
        }
    }

    matched(){
        this.opnedCards[0].classList.add("match","disabled")
        this.opnedCards[1].classList.add("match","disabled")
        this.opnedCards[0].classList.remove("show","open")
        this.opnedCards[1].classList.remove("show","open")
        this.opnedCards=[];
    }
    unmatched(){
        this.opnedCards[0].classList.add("unmatched")
        this.opnedCards[1].classList.add("unmatched")
        this.action('DISABLE')
        setTimeout(()=>{
            this.opnedCards[0].classList.remove("show","open","unmatched")
            this.opnedCards[1].classList.remove("show","open","unmatched")
            this.action('ENABLE')
            this.opnedCards=[];
        },1100)
        
    }
    action(){
        let  cards = this.template.querySelectorAll('.card')
        Array.from(cards).forEach(item=>{
            if(action === 'ENABLE'){
            let isMatch =  item.classList.contains('match')
            if(!isMatch){
                item.classList.remoeve('disabled')
            }
            }
            if(action === 'DISABLE'){
                item.classList.add('disabled')
            }
        })
    }
}