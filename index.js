const express = require('express');
const app = express();
const server = require('http').Server(app);
const io = require('socket.io')(server);
const _ = require('underscore');

require('es6-promise').polyfill();
require('isomorphic-fetch');

app.use(express.static('app'));

server.listen(8000, () => console.log('Listening at 8000'));

var stocks = [];

io.on('connection', socket => {
  socket.emit('initial-stocks', stocks );
  socket.on('add-stock', code => {
  	console.log('adding '+code+' to '+stocks);
  	stocks.push(code);
  	io.emit('add-stock', code );
  });
  socket.on('remove-stock', code => {
  	console.log('removing '+code+' from '+stocks);
    const index = stocks.indexOf(code);
  	stocks.splice(index, 1);
  	io.emit('remove-stock', code );
  })
});