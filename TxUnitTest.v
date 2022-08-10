`timescale 1ns/1ns 
module TxUnitTest ();


//regs to derive the inputs 

reg rst ;
reg stop_bits ; 
reg data_length ; 
reg send ; 
reg clock ; 

reg [1:0] parity_type ; 
reg [1:0] baud_rate ;
reg [10:0] data_in ; 

//wires to recive the output 

wire data_out ; 
wire p_parity_out; 
wire tx_active ; 
wire tx_done; 

initial begin
    //reseting the system for 10ns 
    rst = 1 ; 
    #10 ; 
    rst = 0 ; 

    
end


//50Mhz clock 20ns period (10ns low - 10ns high )
always begin
    clock = 0 ; 
    #10 ; 
    clock = 1 ; 
    #10 ; 
end

endmodule