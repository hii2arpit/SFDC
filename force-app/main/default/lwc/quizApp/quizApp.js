import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {

    selected={} //Obejct for storing answers
    correctAnswers = 0;
    isSubmitted = false;

    get allNotSelected(){
        return !(Object.keys(this.selected).length === this.myQuestions.length)
    }
    // for applying dynamic styling to our result
    get isScoredFull(){
        return `slds-text-heading_large ${this.myQuestions.length === this.correctAnswers?
            'slds-text-color_success':'slds-text-color_error'}`
    }

    myQuestions=[
        {
            id:"Question1",
            question:"Which one of the following is not a template loop?",
            answers:{
                a:"for:each",
                b:"iterator",
                c:"map loop"
            },
            correctAnswer:"c"
        },
        {
            id:"Question2",
            question:"Which of the file is invalid in LWC component folder?",
            answers:{
                a:".svg",
                b:".apex",
                c:".js"
            },
            correctAnswer:"b"
        },
        {
            id:"Question3",
            question:"Which of the following is not a directive?",
            answers:{
                a:"for:each",
                b:"if:true",
                c:"@track"
            },
            correctAnswer:"c"
        }

    ]

    changeHandler(event)
    {
        const{name, value} = event.target;
        this.selected = {...this.selected, [name]:value};
    }

    submitHandler(event)
    {
        event.preventDefault();
        let correct = this.myQuestions.filter(item=>this.selected[item.id] === item.correctAnswer)
        this.correctAnswers = correct.length;
        this.isSubmitted = true;
    }

    resetHandler(event)
    {
        this.selected={};
        this.correctAnswers = 0;
        this.isSubmitted = false;
    }
}