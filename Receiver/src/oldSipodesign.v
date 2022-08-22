module Sipo (
    input serialInput , 
    input baudRateOut, 
    input rst , 
    output reg [7:0] parallelOutput 
);
    
reg idleFlag ;
reg startFlag ;  
reg [3:0] counter ;
reg [7:0] temp ; 
reg [3:0] recivedDataCount ; 
reg [3:0] recivedBitsCount ; 
always @(negedge serialInput) begin
     if(idleFlag) begin 
         idleFlag = 0 ; 
     end 
end
always @(posedge baudRateOut) begin
    if(!idleFlag)begin
        if(!startFlag)begin
            counter = counter + 1 ;
            if(counter == 7) startFlag = 1 ; 
            counter = 0 ;   
        end 
        else begin 
            counter = counter + 1 ; 
            if(counter == 15) begin
                if(recivedDataCount < 8) begin
                    temp = parallelOutput >> 1 ; 
                    parallelOutput = {serialInput , temp[6:0]} ; 
                    counter = 0 ; 
                    recivedDataCount = recivedDataCount + 1 ; 
                    recivedBitsCount = recivedBitsCount + 1 ; 
                end
                if(recivedBitsCount == 11)begin
                    idleFlag = 1 ; 
                    startFlag = 0 ; 
                    recivedBitsCount = 0 ; 
                    recivedDataCount = 0 ; 
                end
            end
        end
    end 
end


always @(negedge rst) begin
    idleFlag = 1 ; 
    startFlag = 0 ; 
    counter = 0 ;
    recivedDataCount = 0 ;   
    recivedBitsCount = 0 ; 
    parallelOutput = 8'b00000000; 
end

endmodule