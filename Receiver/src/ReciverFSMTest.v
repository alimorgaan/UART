
`timescale 1ns/1ns 

module ReciverFSMTest ();



    reg baudRateOut ; 
    reg serialInput ; 
    reg rst ; 
    wire [8:0] dataParityOut ; 
    wire ready ; 

    ReciverFSM ReciverFSMUT(
        .baudRateOut(baudRateOut), 
        .serialInput(serialInput), 
        .rst(rst), 
        .dataParityOut(dataParityOut),
        .ready(ready) 
    );  

    initial begin
        //reset the system 
        rst = 0 ; 
        #200 ; 
        rst = 1 ; 
        ////////////////////////////////
        //idle for 200 ns 
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

    end



    //testing 2400 bit/second speed
    //oversampling ---> 16*2400 ---> 26041 ns
    always begin
        baudRateOut = 0 ; 
        #13020.3333 ; 
        baudRateOut = 1 ; 
        #13020.3333 ; 
    end

endmodule