var Cylon = require('cylon');
var express = require('express');
var http = require('http');
var app = express();
var server = http.Server(app);
var io = require('socket.io')(server);
var port = process.env.PORT || 9000;
//Use express to build a menu for local files
app.use(express.static(__dirname+'/client'));
app.get('/',function(req,res){
  res.sendFile(__dirname + '/client/index.html');
});
server.listen(port,function(){
  console.log("Poat listening...",port);
});
Cylon.api('http');
Cylon.robot({
    connections: {
      arduino: { adaptor: 'firmata', port: 'COM4' } // Set the port for your own computer, mine is COM4 which is for windows.
    },
    //Set up the arduino inputs and outputs
    devices: {
      potentiometer: { driver: 'analog-sensor', pin: 0, lowerLimit: 0, upperLimit: 1023 },//Get the potentiometer analog reading from A0
      led_red: { driver: 'led', pin: 11 },
      led_green: { driver: 'led', pin: 10 },
      btn1: { driver: 'button' , pin: 3 },
      btn2: { driver: 'button' , pin: 4 },
      buzzer: { driver: 'direct-pin' , pin: 5}
    },
work: function(my) {
  var moveData = 0;
  //Socket connection handler
  io.on('connection', function(socket){
    every((0.5).second(), function() {
	  //Send my potentiometer's reading to my client
      moveData = my.potentiometer.analogRead();
      io.emit('movement', moveData);
    });
	//if left button is pushed, send a message to my client to start the game
	my.btn1.on('push',function(){
		io.emit('start');
	});
	//if right button is pushed, send a message to my client to pause the game
	my.btn2.on('push',function(){
		io.emit('pause');
		console.log('paused');
	});
	//if the highest score record breaks, green led would turn on
	//if it doesn't then we turn the red led on.
    socket.on('win', function (data) {
	  my.led_green.turnOn();
      console.log('WIN');
    });
    socket.on('lose', function (data) {
      my.led_red.turnOn();
      console.log('LOSE');
    });

	//When the user reset the game, we turn off all the led
	socket.on('stop',function(data){
		if(my.led_red.isOn()){
			my.led_red.turnOff();
			console.log('TurnOff');
		}else if(my.led_green.isOn()){
			my.led_green.turnOff();
			console.log('TurnOff');
		}
	});
	// Make the buzzer beep
	socket.on('beep',function(){
        my.buzzer.pwmWrite(255);   	
	});
	  
    console.log('a user connected');
    socket.on('disconnect', function(){
      console.log('user disconnected');
    });
  });
}
}).start();
