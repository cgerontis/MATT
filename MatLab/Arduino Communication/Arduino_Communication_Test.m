s=serial('COM12'); % Make sure the baud rate and COM port is 
fopen(s);

servalue = 'f';

while(strcmp(servalue,'') == 0)           

servalue= input('Enter the value 100 to turn ON LED & 101 to turn OFF LED :','s');

disp(servalue);

fprintf(s,servalue);          %This command will send entered value to Arduino 

response = fgets(s);

disp(response); 


end
fclose(s);