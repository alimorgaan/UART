module parity (
    input [7:0] data_in ,
    input rst ,
    input [1:0] parity_type ,
    output reg parity_out 
);
        
always @(*) begin
    
    if (~rst) begin   //active_LOW reset 
        parity_out =0;
    end
    else begin
    
    case (parity_type)
       
        2'b00:
          parity_out<=0;     //No parity

        
        
        2'b01:               //odd parity
            if (^ data_in ) begin
            parity_out<=0;
         end
         else if ( data_in==0 ) begin
            parity_out<=0;
         end
         
         else begin parity_out<=1;
         
         end

    
        2'b10:               //even parity
            
            if (^ data_in ) begin
            parity_out<=1;
         end
         else begin parity_out<=0;
         
         end       
        2'b11:              // no parity on the serial frame
         parity_out<=0;    

        default: parity_out<=0; //for any other unexpected values 
    
    endcase 
    end
end


endmodule