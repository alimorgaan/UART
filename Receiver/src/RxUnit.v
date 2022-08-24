module RxUnit (
    input serialInput , 
    input [1:0] baudRate , 
    input clock , 
    input rst , 
    input pType , 
    output error , 
    output [7:0] dataOut 
);

wire baudOut ; 
wire ready ; 
wire [8:0] dataParityOut; 

BaudGen BaudGen(
    .baudRate(baudRate),
    .clock(clock), 
    .rst(rst), 
    .baudOut(baudOut)
); 

ReceiverFSM ReceiverFSM(
    .serialInput(serialInput),
    .baudOut(baudOut), 
    .rst(rst), 
    .ready(ready), 
    .dataParityOut(dataParityOut)
);  

Checker Checker(
    .dataParityOut(dataParityOut),
    .ready(ready), 
    .rst(rst), 
    .pType(pType),
    .error(error)
); 

OutReg OutReg(
    .data(dataParityOut[7:0]), 
    .ready(ready), 
    .dataOut(dataOut), 
    .rst(rst)
); 


endmodule