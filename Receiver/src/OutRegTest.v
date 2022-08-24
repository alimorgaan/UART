`timescale 1ns/1ns 

module OutRegTest ();
    

    reg [7:0] data ; 
    reg ready  ;
    reg rst ;
    wire [7:0] dataOut; 

    OutReg OutRegUT(
        .data(data), 
        .ready(ready) , 
        .rst(rst), 
        .dataOut(dataOut)
    );

    initial begin
        data = 0 ; 
        ready = 0 ; 
        rst = 0 ; 
        #500;
        rst = 1 ; 

        data = 8'b00110011; 

        ready = 1 ; 
        #200 ;
        ready = 0 ; 
        #200 ; 

        
        data = 8'b10111011;

        ready = 1 ; 
        #200 ;
        ready = 0 ; 
        #200; 


    end
endmodule