# UART
## Implementaion of UART Transmitter & Receiver Using Verilog

### Transmitter Architecture

![Architecture (1)](https://user-images.githubusercontent.com/32411364/184368156-fef717d7-9a34-4214-93ca-485cb9c555f7.png)

### Transmitter Testbench Simulation 

![top_module](https://user-images.githubusercontent.com/32411364/184368352-e7f8750c-ee09-4de1-989b-9199bdbbfc9a.JPG)

### Transmitter Features

- 4 Baud Rates (2400, 4800, 9600, 19200) bit/second 
- 4 different parity options (no parity, odd parity, even parity, parallel odd parity)
- Two modes for data (7 bits with 2 stop bits, 8 bits with 1 stop bit)

***

### Receiver Architecture

![uartReciver](https://user-images.githubusercontent.com/32411364/186517384-0be894b8-45b4-440d-84bf-ce2f00dbd532.png)

### Receiver FSM

![fsm](https://user-images.githubusercontent.com/32411364/186527438-f673238d-ff57-4415-9099-c25d6854d879.PNG)

- using oversamplig to generate 16 tick for each bit. 
- when the state reach tick 8 (in the middle of bit time period) we capture the bit and save it in internal register. 

### Receiver Testbench Simulation 

![topModule](https://user-images.githubusercontent.com/32411364/186517450-ae63ca16-44ce-4892-ae88-e7cabcff486f.PNG)

### Reciver Features

- 4 Baud Rates (2400, 4800, 9600, 19200) bit/second 
- Detecting errors using odd/parity checking
