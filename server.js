const express = require('express');
const cors = require('cors');
const parser = require('body-parser');
const path = require('path');
const database = require('./db');

const server = express();
const PORT = process.env.PORT || 8080;

server.use(cors());
server.use(parser.json());
(async () => {await database.initDatabase();})();

server.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'index.html'));
});
server.get('/script.js', (req, res) => {
    res.sendFile(path.join(__dirname, 'script.js'));
});



server.get('/export-csv', async (req, res) => {
    try{
        const results = await database.orderedResults();
        let createCSV = 'id,runnerId,finishTime,time\n'
        results.forEach(row => {
            const runnerId = `"${row.runnerId.replace(/"/g, '""')}"`;
            const finishTime = `"${row.finishTime.replace(/"/g, '""')}"`
            const time = `"${row.time}"`;
            createCSV += `${row.id},${runnerId},${finishTime},${time}\n`;
        });
        res.setHeader('Content-Type', 'text/csv');
        res.setHeader('Content-Disposition', 'attachment; filename="race_results.csv"');
        res.send(createCSV);
    } catch (err){
        console.error('CSV has not been exported successfully', err);
        res.status(500).send('CSV has not been exported successfully')
    }
});

server.post('/results', async (req, res) =>{
    try{
        const results = req.body.results;
        if (!Array.isArray(results) || results.length === 0){
            return res.status(400).json({ error: 'Results are null'})
        }
        const saveRunnerId = [];
        for (const { runnerId, finishTime } of results){ 
            if (!runnerId || !finishTime){
                continue;
            }
            const id = await database.saveTimes(runnerId, finishTime);
            saveRunnerId.push(id);
        }
        res.status(201).json({ message: `Saved ${saveRunnerId.length}`, ids: saveRunnerId });
    } catch (err) {
        console.error('Unable to save current results!', err);
        res.status(500).json({ error: 'Unable to save current results!'});
    }
});

server.get('/results', async (req, res) => {
    try{
        const results = await database.orderedResults();
        res.json(results);
    } catch (err) {
        console.error('Error While Fetching The Results!:', err);
        res.status(500).json({ error: 'Failed to fetch results'});
    }
});

server.delete('/results', async (req, res) => {
    try{
        await database.resetResults();
        res.json({ message: 'Results have been successfully cleared!'});
    } catch (err){
        console.error({ message: 'Unable To Clear Current Results!:', err});
        res.status(500).json({ error: 'Failure to clear results'});
    }
});

server.listen(PORT, () => {
    console.log(`Server Is Currently Running on http://localhost:${PORT}`);
});