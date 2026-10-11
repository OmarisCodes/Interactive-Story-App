//Begin by defining the variables that are managing the timer
let timer = null; 
let isRunning = false; 
let startTime = 0;
let elapsedTime = 0; 
let runners = JSON.parse(localStorage.getItem('runners')) || [];

const displayTime = document.getElementById('timerDisplay'); 
const runnerList = document.getElementById('runnerList');

//Formatting time into "HH:MM:SS.mmm"
function formatTime(elapsedTime){
    const milliseconds = elapsedTime % 1000;
    const seconds = Math.floor(elapsedTime / 1000) % 60;
    const minutes = Math.floor(elapsedTime / (1000 * 60)) % 60;
    const hours = Math.floor(elapsedTime / (1000 * 60 * 60));
    return `${pad(hours)}:${pad(minutes)}:${pad(seconds)}.${padMs(milliseconds)}`;
}

//Pads numbers for Hours Minutes & Seconds to two digits
function pad(number){
    return number.toString().padStart(2, '0');
}

//Pads milliseconds to three digit .mmmm
function padMs(number){
    return number.toString().padStart(3, '0');
}

//Saves the runners to a localStorage
function saveRunners(){
    localStorage.setItem('runners', JSON.stringify(runners));
}

//loads runners from the localstorage into the list
function loadRunners(){
    //For each individual runner provides an input box for "runnerId" and "finishTime"
    runnerList.innerHTML = '';
    runners.forEach(({ runnerId, finishTime }, index) => {
        const li = document.createElement('li');//list item container
        const input = document.createElement('input');//Input Box Used To Edit runnerId in the list
        input.type = 'text';
        input.value = runnerId;
        input.placeholder = 'Enter Runner name/ID';

        //Updates runnerId whenever a change is made via input
        input.addEventListener('change', (e) => {
            runners[index].runnerId = e.target.value.trim();
            saveRunners();
        })
        
        //Span is used here to have the finish time next to the runners name
        const finishTimeText = document.createElement('span');
        finishTimeText.textContent = ` - ${finishTime}`

        //Appends the runners name, input and finish time into the list
        li.appendChild(document.createTextNode(`${index + 1}. `));
        li.appendChild(input);
        li.appendChild(finishTimeText);
        runnerList.appendChild(li);//adds list to the User Interface
    });
}

function startTimer(){
    if (!isRunning){
        isRunning = true;
        //if timer was paused calculates the start time to resume timer
        startTime = Date.now() - elapsedTime;
        //Set Interval updates the timer display every 50 milliseconds
        timer = setInterval(updateTimer, 50);
    }
}

function pauseTimer(){
    if (isRunning){
        isRunning = false;
        clearInterval(timer);//Stops Interval Updates
        updateTimer();// Updates display with elapsed time
    }
}
//Clears runner data and resets the timer
function resetTimer(){
    isRunning = false;
    clearInterval(timer);//Stops Interval updates
    elapsedTime = 0;//Resets the time to 0
    updateTimer();//Updates timer to default
    runners = [];//Clears runners data with an empty list
    saveRunners();//Saves current empty list to the database
    loadRunners();//Reloads runners list updating it to empty
}
//Every 50 milliseconds updates timer display
function updateTimer() {
    if (isRunning) {
        elapsedTime = Date.now() - startTime; // Finds the elapsed time
    }
    displayTime.textContent = formatTime(elapsedTime); //Updates the timer
}
//Records and adds finishing time to runnerList
function finishingTime(){
    if (!isRunning){
        alert('Timer is not running!');//Doesn't allow adding finishingTime if timer is paused
        return;
    }
    const runnerId = '';//Empty to be filled with UserInput later
    const finishTime = formatTime(elapsedTime);//Calculates current time to get finishing time for runner
    runners.push({ runnerId, finishTime});//Adds runners result to array
    saveRunners();//Saves runners list to local storage 
    loadRunners();//Refreshes User Interface with new data
}
// Uses POST to send runner results to the backend
async function uploadResults() {
    if (runners.length === 0){
        alert('Unable to upload results!');//If there is no data to upload error message appears
        return;
    }
    try{
        const response = await fetch('http://localhost:8080/results', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json'},
            body: JSON.stringify({  results: runners }),// Sends the Runners data as a JSON
        });
        if (!response.ok) throw new Error('Upload failed');
        await response.json();// Parse the servers' response
        alert(`${runners.length} uploaded successfully!`);
        runners = [];// Clear local runner data
        saveRunners(); //Saves runners data to storate (empty list)
        loadRunners(); // Refreshes User Interface to show clear list
    } catch (err) {
        console.error('Error Uploading!:', err);
        alert('Results have not been uploaded to the database but are being saved to the device.')
    }
}
//Deletes backend Results
async function clearDatabase(){
    try{
        const response = await fetch('http://localhost:8080/results',{
        method: 'DELETE',
    });
    if (!response.ok) throw new Error('Unable to clear previous database results');
    alert('Previous Race Results have been cleared!');
    } catch (error){
        console.error('Unable to clear database results:', error);
        alert('Unable to clear database results!');
    }};
//CLears backend and local runner data 
async function clearResults(){
    runners = []; //Clears Runner List
    saveRunners(); //Saves Cleared Runners List
    loadRunners(); // Reloads User Interface to display cleared list
    await clearDatabase(); // Clears the results on the backend
}
// Sets upp button event listeners. Buttons used to
document.getElementById("buttonStartRace").addEventListener("click", startTimer);
document.getElementById("buttonStopTimer").addEventListener("click", pauseTimer);
document.getElementById("buttonResetTimer").addEventListener("click", resetTimer);
document.getElementById("buttonFinishingTime").addEventListener("click", finishingTime);
document.getElementById("buttonUploadResults").addEventListener("click", uploadResults);
document.getElementById("buttonClearResults").addEventListener("click", clearResults);
document.getElementById("buttonExportCSV").addEventListener("click", () => {
    window.open('http://localhost:8080/export-csv', '_blank')
});
//When page is loaded initialize the runner list and updates the timer 
window.addEventListener('load', () => {
    loadRunners();
    updateTimer();
});

