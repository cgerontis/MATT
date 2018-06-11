const readline = require('readline');
var msg = '';
var index = 0;

const rl = readline.createInterface({
  input: process.stdin,
  output: process.stdout
});

  rl.on('line', (input) => {

  index = input.indexOf(',');

  msg = 'X-' + input.slice(0,index) + '\n' + 'Y-' + input.slice(index+1, input.length) + '\r';

  console.log(msg);

});
