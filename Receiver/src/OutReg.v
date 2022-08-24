module OutReg (
    input [7:0] data , 
    input ready , 
    input rst , 
    output reg [7:0] dataOut 
);
    
always @(negedge ready , negedge rst) begin
    if(~rst) begin 
        dataOut = 0 ; 
    end
    else begin
        dataOut = data ; 
    end
    
end

endmodule