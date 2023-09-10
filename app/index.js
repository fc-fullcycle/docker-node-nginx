const express = require('express')
const app = express()
const bodyParser = require('body-parser')
const mysql = require('mysql')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))

const port = 3000

const config = {
    host: 'database',
    user: 'root',
    password: 'root',
    database: 'nodedb',
}

app.get('/', (req, res) => {
    addPerson('João');

    const connection = mysql.createConnection(config);
    connection.query(`SELECT name FROM people`, (error, rows) => {
        if (error) {
            console.error(error);
            res.status(503).send('<h1> Internal server error </h1>')
        } else if (rows.length === 0) {
            res.status(200).send(`<h1>Full Cycle Rocks!</h1>`)
        } else {
            let message = `<h1>Full Cycle Rocks!</h1> <br/>`;
            message += `<ul>`;
            for (row of rows){
                const {name} = row
                message += `<li>${name}</li>`
            }
            message += `</ul>`;
            res.send(message)
        }
    })
    connection.end()
})

function addPerson(name) {
    const connection = mysql.createConnection(config)
    connection.query(`INSERT IGNORE INTO people (name) values (?)`, [name])
    connection.end()
}

app.post('/', (req, res) => {
    const body = req.body
    addPerson(body);
    res.sendStatus(200)
})

app.listen(port, () => {
    console.log(`app is runing in port ${port}`)
})
