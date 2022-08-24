`timescale 1ns/1ns

module CheckerTest ();

  reg [8:0] dataParityOut ; 
  reg rst ;
  reg ready ; 
  reg pType ; 
  wire error ;

    Checker CheckerUT(
        .dataParityOut(dataParityOut), 
        .rst(rst), 
        .ready(ready), 
        .pType(pType),
        .error(error)
    ); 


    initial begin
        dataParityOut = 0 ;
        ready = 0 ; 
        pType = 0 ; 
        /////////////////////////////

        rst = 1 ; 
        #300; 
        rst = 0 ; 
        #300
        rst = 1 ; 

        #1000 ; 
        dataParityOut = 9'b010011110 ; 
        pType = 1'b1 ; 
        
        ready = 1 ; 
        #300 ; 
        ready = 0 ; 
    end

endmodule