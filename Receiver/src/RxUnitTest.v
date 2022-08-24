`timescale 1ns/1ns

module RxUnitTest ();
    
reg serialInput; 
reg [1:0] baudRate ; 
reg clock ; 
reg rst ; 
reg pType ; 
wire error ; 
wire [7:0] dataOut ; 

RxUnit RxUnitUT(
    .serialInput(serialInput), 
    .baudRate(baudRate), 
    .clock(clock), 
    .rst(rst), 
    .pType(pType), 
    .error(error), 
    .dataOut(dataOut)
);

initial begin
    serialInput = 1 ; 
    baudRate = 2'b00 ; 
    pType = 0 ; 
    ///////////////// reset the system //////////////
    rst = 1 ; 
    #200 ; 
    rst = 0 ; 
    #200 ; 
    rst = 1 ; 
    ////////////  sending a frame in 2400 bits/second rate    ///////////////////
    ////////////  odd parity 
    pType = 0 ; 

        //idle 
        serialInput = 1 ; 
        #416666 ;
        //sending a frame 

        //start bit 
        serialInput = 0 ; 
        #416666 ; 
        //d0
        serialInput = 1 ; 
        #416666 ;
        //d1
        serialInput = 0 ; 
        #416666 ;
        //d2
        serialInput = 1 ; 
        #416666 ;
        //d3
        serialInput = 0 ; 
        #416666 ;
        //d4
        serialInput = 1 ; 
        #416666 ;
        //d5
        serialInput = 0 ; 
        #416666 ;
        //d6
        serialInput = 1 ; 
        #416666 ;
        //d7
        serialInput = 0 ; 
        #416666 ;
        //parity
        serialInput = 1 ; 
        #416666 ;
        //stop
        serialInput = 1 ; 
        #416666 ;
        //idle 
        serialInput = 1 ; 
        #416666 ;


        ////////////////// sending a frame in 19200 bits/second rate /////////////////

        baudRate = 2'b11 ; 
        pType = 1 ; //even parity  

        //start bit 
        serialInput = 0 ; 
        #52083; 
        //d0
        serialInput = 1 ; 
        #52083; 
        //d1
        serialInput = 1 ; 
        #52083; 
        //d2
        serialInput = 1 ; 
        #52083; 
        //d3
        serialInput = 1 ; 
        #52083; 
        //d4
        serialInput = 0 ; 
        #52083; 
        //d5
        serialInput = 0 ; 
        #52083; 
        //d6
        serialInput = 0 ; 
        #52083; 
        //d7
        serialInput = 0 ; 
        #52083; 
        //parity
        serialInput = 0 ; 
        #52083; 
        //stop
        serialInput = 1 ; 
        #52083; 
        //idle 
        serialInput = 1 ; 
        #416666 ;

end


always begin
    clock = 0 ; 
    #10; 
    clock = 1 ; 
    #10 ; 
end

endmodule