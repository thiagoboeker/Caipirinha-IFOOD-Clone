const WebSocket = require('ws')
const connection = new WebSocket('ws://localhost:9000/business/ws')

connection.onopen = () => {
    connection.send(JSON.stringify({uid: "123123"}))
}

connection.onmessage = (evt) => {
    console.log(evt.data)
}


