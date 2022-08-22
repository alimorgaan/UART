
/*----baudRate----*/
// 00	2400 baud.		10417 / 16 = 651								
// 01	4800 baud.		5208 / 16 = 325								
// 10	9600 baud.		2604 / 16 = 162							
// 11	19.2K baud.     1302 / 16 = 81
/*----------------*/
// we want it 16 time faster to use oversampling 

module BaudGen (
input [1:0] baudRate , 
input clock ,
input rst , 
output reg baudOut 
);
    
reg [13 : 0] counter ; 
reg [13 : 0] limit ; 

always @(posedge clock , negedge rst) begin
    if(!rst) begin
        counter = 0 ; 
        baudOut = 0 ; 
    end 
    
    else begin
        counter = counter + 'd1 ;
        if (counter == limit) begin
        counter = 0 ; 
        baudOut = ~baudOut ; 
        end 
    end 
    
end
always @(baudRate) begin
    case (baudRate)
        2'b00 : limit = 'd651 ; 
        2'b01 : limit = 'd325 ; 
        2'b10 : limit = 'd162 ; 
        2'b11 : limit = 'd81 ;  
        default: limit = 0 ; 
    endcase
end
endmodule