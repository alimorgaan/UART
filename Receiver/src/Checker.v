module Checker (
    input [8:0] dataParityOut , 
    input rst , 
    input ready , 
    input pType , //0 odd parity ,,,,,, 1 even parity 
    output reg error 
);
    
    reg [8:0] dataParityOutReg ; 
    reg pTypeReg ; 
    
    always@(dataParityOutReg , pTypeReg)begin
        case (^dataParityOut)
            1'b0: begin //even number of ones
                if(pType)begin
                    error = 0 ;  
                end else 
                    error = 1 ;
            end
            1'b1: begin //odd number of ones
                if(~pType)begin
                    error = 0 ;  
                end else 
                    error = 1 ;
            end
        endcase
    end

    always@(negedge ready)begin
        dataParityOutReg = dataParityOut ; 
        pTypeReg = pType ; 
    end

    always @(negedge rst) begin
        error = 0 ;
        dataParityOutReg = 0 ; 
    end
endmodule