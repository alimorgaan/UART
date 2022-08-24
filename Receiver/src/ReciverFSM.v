module ReciverFSM (
    input baudRateOut ,
    input serialInput ,
    input rst , 
    output reg [8:0] dataParityOut , 
    output reg ready 
);
    

    reg [3:0] state ; 
    reg [3:0] counter ; 

    always @(posedge baudRateOut)begin
        case (state)
            4'b0000:begin //idle
                $display("im idle but baud is working"); 
            end
            4'b0001:begin //start bit
                if(counter == 15) begin
                state =  4'b0010 ; 
                counter = 0 ;
                end else 
                counter = counter + 1; 
            end
            4'b0010:begin //d0
                if(counter == 8) begin 
                    dataParityOut[0] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b0011 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end
            end
            4'b0011:begin //d1
                
               if(counter == 8) begin 
                    dataParityOut[1] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b0100 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end
            end
            4'b0100:begin //d2
                
              if(counter == 8) begin 
                    dataParityOut[2] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b0101 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end
            end
            4'b0101:begin //d3
                
               if(counter == 8) begin 
                    dataParityOut[3] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b0110 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end
            end
            4'b0110:begin //d4
                
               if(counter == 8) begin 
                    dataParityOut[4] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b0111 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end
            end
            4'b0111:begin //d5
                
               if(counter == 8) begin 
                    dataParityOut[5] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b1000 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end
            end
            4'b1000:begin //d6
               if(counter == 8) begin 
                    dataParityOut[6] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b1001 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end
            end
            4'b1001:begin  //d7
                
               if(counter == 8) begin 
                    dataParityOut[7] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b1010 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end
            end 
            4'b1010:begin // parity 
                if(counter == 8) begin 
                    dataParityOut[8] = serialInput ;
                    counter = counter + 1 ; 
                end else 
                if(counter == 15)begin
                    state =  4'b1011 ; 
                    ready = 1 ; 
                    counter = 0 ;
                end else 
                begin
                    counter = counter + 1 ;
                end           
            end
            4'b1011:begin // stop
                if(counter == 15) begin 
                    state =  4'b0000 ; 
                    ready = 0 ; 
                    counter = 0 ;
                end else 
                counter = counter + 1; 
            end
            default: state = 4'b0000; 
        endcase
    end



    always @(negedge serialInput)begin
        if(state == 4'b0000) state = 4'b0001 ; 
    end

    always @(negedge rst) begin
        state = 4'b0000 ;
        counter = 4'b0000 ;
        dataParityOut = 8'b00000000; 
        ready = 0 ; 
    end
endmodule