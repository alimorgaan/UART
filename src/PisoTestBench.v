//                       ************************************** This module is created by Mohamed Maged **************************************
//Chipions program's final project for phase(001) "verilog", UART-Tx.
//Undergraduate student, ECE department, Alexandria university.

module PisoTest;

//Test Inputs
reg TStopBits, TDataLength, Tsend,Trst, TBaudOut;
reg [1:0]   TParityType;
reg [10:0]  TFrameOut;

//Test outputs
wire TDataOut, TParllParity, TActive, TDone;

//Instantiation of the designed block
PisoReg MyTest(
    .parity_type(TParityType), .BaudOut(TBaudOut),
    .stop_bits(TStopBits), .data_length(TDataLength),
    .send(Tsend), .rst(Trst), 

    .data_out(TDataOut), .p_parity_out(TParllParity),
    .tx_active(TActive), .tx_done(TDone)
);


//Monitorin the outputs and the inputs
initial begin
    $monitor($time, "The Outputs:  DataOut = %b   ParallelParity = %b  ActiveFlag = %b   DoneFlag = %b  
    The Inputs: StopBit = %b  DataLength = %b  Send = %b  Reset = %b   ParityType = %b ",
     TDataOut, TParllParity, TActive, TDone, TStopBits, TDataLength, Tsend, Trst, TParityType[1:0] );
end


//Set up the reset
initial begin
    Trst = 1'b0;
    #10 Trst = 1'b1;
    #200 Trst = 1'b0;
end


//Set up the send signal
initial begin
    Tsend = 1'b0;
    #10 Tsend = 1'b1;
    #50 Tsend = 1'b0;
    #10 Tsend = 1'b1;
    #150 Tsend = 1'b0;
end


//Set up a clock "Baudrate"
initial begin
    TBaudOut = 1'b0;
    forever #10 TBaudOut = ~TBaudOut;
end 


//Varying the stopits, datalength, paritytype >>> 4-bits with 16 different cases with 8 ignored cases <<<
initial begin
    //TStopBits = 1'b0, TDataLength = 1'b1, TParityType = 2'b00;
    {TStopBits, TDataLength, TParityType[1:0]} = 4'b0100;
    #20 {TStopBits, TDataLength, TParityType[1:0]} = 4'b0101;
    #20 {TStopBits, TDataLength, TParityType[1:0]} = 4'b0110;
    #20 {TStopBits, TDataLength, TParityType[1:0]} = 4'b0111;
    #20 {TStopBits, TDataLength, TParityType[1:0]} = 4'b1000;
    #20 {TStopBits, TDataLength, TParityType[1:0]} = 4'b1001;
    #20 {TStopBits, TDataLength, TParityType[1:0]} = 4'b1010;
    #20 {TStopBits, TDataLength, TParityType[1:0]} = 4'b1011;
end


//various Frames 
initial begin
    TFrameOut = 'b11010010100;             //1-bit stop bit, 8-bits data bits, no parity bit
    #20 TFrameOut = 'b11010010100;         //1-bit stop bit, 8-bits data bits, odd parity
    #20 TFrameOut = 'b10010010100;         //1-bit stop bit, 8-bits data bits, even parity
    #20 TFrameOut = 'b11010010100;         //1-bit stop bit, 8-bits data bits, no parity bit
    #20 TFrameOut = 'b11010010100;         //2-bit stop bit, 7-bits data bits, no parity bit
    #20 TFrameOut = 'b10010010100;         //2-bit stop bit, 7-bits data bits, odd parity
    #20 TFrameOut = 'b11010010100;         //2-bit stop bit, 7-bits data bits, even parity
    #20 TFrameOut = 'b11010010100;         //2-bit stop bit, 7-bits data bits, no parity bit
    
end


endmodule