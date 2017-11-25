# HTML5 Arduino Pong Game
This is a documentation for a web application, which is a HTML5 game controlled by arduino in real-time on localhost.

# What this application does
We can control the paddle in the game using a potentiometer,start/pause the game using two buttons. If the ball in the game hits either bricks or paddle, the buzzer would produce a sound. If the user breaks the record, his/her score would become the highest and the Green LED would turn on; if not, the red LED would turn on.

The initial life is always 5, but when you level up, you would get 3 more lifes, and the map for the level would be different from last level.

# What did I use
For the arduino side, I upload StandardFirmata Sketch in order to support cylon.js,a JavaScript framework to command and get input from devices like Arduino.

For the server side, I mainly use two node.js modules, express and socket.io(HTTP protocol),to transmit the data I get from the Arduino to client and give command to Arduino to respond the client's action. For example, when the user breaks the record of the game, the green LED would turn on; When the user reset the game, the LED would turn off.

For the client side, I use HTML5, css and JavaScript(JQuery) to create the whole front-end, and I also use the socket.io to receive data/send out events.

# Prerequisite
If running this web application locally, we need to get node.js installed and port 9000 should be free.

Also, we need to modify the serial port for Arduino connection(in server.js). In my case, the port is COM4 for Windows. For Linux it may be something like '/dev/ACM0' and for Mac should be '/dev/tty.* ' We need to set this properly before we can communicate to our Arduino.

# How to set up the circuit
A diagram named ArduinoCircuitSketch.fzz shows the set up of my arduino web app. Following that would get the application framework

# About OpenSCAD
I created a box with a lid used to protect Arduino, and all the wires/add-ons should be able to connect Arduino inside this box
