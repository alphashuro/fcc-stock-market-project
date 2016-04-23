'use strict';

var express = require('express');
var app = express();
var server = require('http').Server(app);
var io = require('socket.io')(server);
var _ = require('underscore');

require('es6-promise').polyfill();
require('isomorphic-fetch');

app.use(express.static('app'));

var port = process.env.PORT || 8080;

server.listen(port, function () {
  return console.log('Listening at docker:'+port);
});

var stocks = [];

io.on('connection', function (socket) {
  socket.emit('initial-stocks', stocks);
  socket.on('add-stock', function (code) {
    console.log('adding ' + code + ' to ' + stocks);
    stocks.push(code);
    io.emit('add-stock', code);
  });
  socket.on('remove-stock', function (code) {
    console.log('removing ' + code + ' from ' + stocks);
    var index = stocks.indexOf(code);
    stocks.splice(index, 1);
    io.emit('remove-stock', code);
  });
});