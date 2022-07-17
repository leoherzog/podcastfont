/**
* The Podcast Quiz!
* https://podcastfont.com/Quiz.html
* 2022 · Benjamin Bellamy @ Ad Aures
*/

// Number of questions:
const maxQuestion=5;
// Number of possilbe answer for each question:
const maxAnswer=5;
// Quiz number, starting July 18th 2022:
let quizNumber = Math.floor(new Date()/8.64e7) - 19190;

// If we want to load an old quiz:
if(location.hash.startsWith('#')){
  const inputQuizNumber=parseInt(location.hash.substring(1));
  if(inputQuizNumber<quizNumber){
    quizNumber=inputQuizNumber;
  }
}

// Some document elements:
const quizContainer = document.getElementById('quiz');
const resultsContainer = document.getElementById('results');
const submitButton = document.getElementById('submitButton');
const copyButton = document.getElementById('copyButton');

// Pseudo-random function with seed:
let seed = quizNumber*maxQuestion*maxAnswer;
function random(maxValue) {
    const x = Math.sin(seed++) * 10000;
    return Math.floor((x - Math.floor(x))*maxValue);
}

// Copy to Clipboard:
function copyResults(content) {
    navigator.clipboard.writeText(content);
}

// Fetch data from server:
let quizData=null;
let response = await fetch('./quizdata.json');
if (response.ok) {
  quizData = await response.json();
} else {
  alert("HTTP-Error: " + response.status);
}

// Create quiz from json data:
let myQuestions = [];
let correctAnswers = [];
for(let questionNum=0;questionNum<maxQuestion;questionNum++){
  let answers={};
  let correctAnswerNum=random(maxAnswer);
  let correctAnswerId;
  for(let answerNum=0;answerNum<maxAnswer;answerNum++){
    let randomAnswerNum=random(quizData.length)
    // Avoid getting twice the same answer for the same question and twice the same correct answer for the quiz:
    while(answers.hasOwnProperty(quizData[randomAnswerNum].id) || (answerNum==correctAnswerNum && correctAnswers.includes(quizData[randomAnswerNum].id))){
      randomAnswerNum=(randomAnswerNum+1)%quizData.length;
    }
    answers[quizData[randomAnswerNum].id]=quizData[randomAnswerNum].name;
    correctAnswers.push(quizData[randomAnswerNum].id);
    if(answerNum==correctAnswerNum){
      correctAnswerId=quizData[randomAnswerNum].id;
    }
  }
  myQuestions.push(
    {
      answers: answers,
      correctAnswer: correctAnswerId
    });
}

// Generate quiz function:
function generateQuiz(questions, quizContainer, resultsContainer, submitButton){
  function showQuestions(questions, quizContainer){
    let output = [];
    let answers;
    for(let i=0; i<questions.length; i++){
      answers = [];
      for(let letter in questions[i].answers){
        answers.push(
          '<label>'
            + '<input type="radio" name="question'+i+'" value="'+letter+'">'
            + questions[i].answers[letter]
          + '</label><br />'
        );
      }
      output.push(
        '<div class="questionblock"><div class="question"><i class="pi pi-' + questions[i].correctAnswer + '"></i></div>'
        + '<div class="answers">' + answers.join('') + '</div></div>'
      );
    }
    quizContainer.innerHTML = '<h2>Quiz #'+ quizNumber +'</h2>'+output.join('');
    document.getElementById('loading').hidden=true;
  }
  function showResults(questions, quizContainer, resultsContainer){
    let answerContainers = quizContainer.querySelectorAll('.answers');
    let userAnswer = '';
    let numCorrect = 0;
    let score ='';
    for(let i=0; i<questions.length; i++){
      userAnswer = (answerContainers[i].querySelector('input[name=question'+i+']:checked')||{}).value;
      if(userAnswer===questions[i].correctAnswer){
        numCorrect++;
        score+='✅'+(i<questions.length-1?' ':'');
        answerContainers[i].style.color = '#009787';
      }
      else{
        score+='❌'+(i<questions.length-1?' ':'');
        answerContainers[i].style.color = '#ff2040';
      }
    }
    submitButton.hidden=true;
    resultsContainer.innerHTML = 'I scored ' + numCorrect + '/' + questions.length + ' at the #PodcastQuiz number '+quizNumber+'!\n'+score+'\nhttps://podcastfont.com/Quiz.html#'+quizNumber+' by @PodcastFont';
    resultsContainer.style.visibility='visible';
    copyButton.style.visibility='visible';
  }
  showQuestions(questions, quizContainer);
  submitButton.onclick = function(){
    showResults(questions, quizContainer, resultsContainer);
  }
  copyButton.onclick = function(){
    copyResults(document.getElementById('results').innerHTML);
  }
}

// Generate the quiz already!:
generateQuiz(myQuestions, quizContainer, resultsContainer, submitButton);
