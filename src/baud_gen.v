
/*----baud_rate----*/
// 00	2400 baud.		10417								
// 01	4800 baud.		5208								
// 10	9600 baud.		2604							
// 11	19.2K baud.     1302
/*----------------*/

module baud_gen (
input [1:0] baud_rate , 
input clock ,
input reset , 
output baud_out 
);
    
reg [13 : 0] counter ; 
reg [13 : 0] limit ; 

always @(posedge clock , negedge reset) begin
    if(!reset) begin
        counter = 0 ; 
        baud_out = 0 ; 
    end 
    
    else begin
        counter = counter + 'd1 ;
        if (counter == limit) begin
        counter = 0 ; 
        baud_out = ~baud_out ; 
        end 
    end 
    
end

always @(baud_rate) begin
    case (baud_rate)
        2'b00 : limit = 'd10417 ; 
        2'b01 : limit = 'd5208 ; 
        2'b10 : limit = 'd2604 ; 
        2'b11 : limit = 'd1302 ;  
        default: limit = 0 ; 
    endcase
end

endmodule