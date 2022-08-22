`timescale 1ns/1ns 
//run the simulation for 1ms 

module baud_test ();

reg [1:0] baud_rate ;
reg clock ;
reg reset ;  
wire baud_out ;  

baud_gen baudUT(
    baud_rate , 
    clock , 
    reset , 
    baud_out
); 

initial begin
    reset = 0 ; 
    #10; 
    reset = 1 ; 

    $display("time:{%0t} testing 19.2k b/s baud rate", $time); 
    baud_rate = 2'b11 ; 
    #250000; 
    $display("time:{%0t} testing 9600 b/s baud rate" , $time); 
    baud_rate = 2'b10 ; 
    #250000;
    $display("time:{%0t} testing 4800 b/s baud rate" , $time); 
    baud_rate = 2'b01 ; 
    #250000;
    $display("time:{%0t} testing 2400 b/s baud rate" , $time); 
    baud_rate = 2'b00 ; 
    #250000;

end

always begin
    clock = 0 ; 
    #10 ; 
    clock = 1 ; 
    #10 ; 
end

endmodule