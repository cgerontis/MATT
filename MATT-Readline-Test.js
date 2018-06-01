/*
MATT-Readline-Test, routine
Constantinos Gerontis, June 2018
*/
//Readline
const readline = require('readline');
var msg = '';
var index = 0;

// Serial port
var SerialPort = require('serialport');
var port_xy = new SerialPort('/dev/cu.usbmodem1421', {
  baudRate: 9600
});

// Use a Readline parser
var parsers = SerialPort.parsers;
var parser = new parsers.Readline({
  delimiter: '\r\n'
});

// Port open errors will be emitted as an error event
port_xy.on('error', function(err) {
  console.log('Error: ', err.message);
})

// Swith port open to flowing mode and pipe to parser.
port_xy.on('open', () => console.log('Port open'));
// pipe to parser
port_xy.pipe(parser);
parser.on('data', console.log);

// Home first
setTimeout(start_homing, 2000);
function start_homing() {
  port_xy.write('$H\r', function(err) {
    if (err) {
      return console.log('Error on write: ', err.message);
    }
    console.log('Homing');
  });
}

// Then start routine
setTimeout(start_loop, 30000);

function MATT_routine() {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

    rl.on('line', (input) => {

    index = input.indexOf(',');

    msg = 'X-' + input.slice(0,index) + '\n' + 'Y-' + input.slice(index+1, input.length) + '\r';

    console.log(msg);
    MATT_routine();
  });
  }


  port_xy.write(msg, function(err) {
    if (err) {
      return console.log('Error on write: ', err.message);
    }
    console.log('Wrote: ',msg);
  });
}
