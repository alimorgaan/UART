`timescale 1ns/1ns 
module BaudGenTest ();

reg [1:0] baudRate  ; 
reg clock ; 
reg rst ; 
wire baudOut ; 

BaudGen BaudGenUT(
    .baudRate(baudRate) , 
    .clock(clock) ,
    .rst(rst) , 
    .baudOut(baudOut)
);  

initial begin
    rst = 1 ; 
    #10; 
    rst = 0 ; 
    #10; 
    rst = 1 ; 

    $display("time:{%0t} testing 19.2k b/s baud rate", $time); 
    baudRate = 2'b11 ; 
    #500000; 
    $display("time:{%0t} testing 9600 b/s baud rate" , $time); 
    baudRate = 2'b10 ; 
    #500000;
    $display("time:{%0t} testing 4800 b/s baud rate" , $time); 
    baudRate = 2'b01 ; 
    #500000;
    $display("time:{%0t} testing 2400 b/s baud rate" , $time); 
    baudRate = 2'b00 ; 
    #500000;

end

always begin
    clock = 0 ; 
    #10 ; 
    clock = 1 ; 
    #10 ; 
end

endmodule