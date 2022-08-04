//                       ************************************** This module is created by Mohamed Maged **************************************
//Chipions program's final project for phase(001) "verilog", UART-Tx.
//Undergraduate student, ECE department, Alexandria university.

module PisoReg (
  input [1:0]   parity_type, 
	input 		    stop_bits, 	//low when using 1 stop bit, high when using two stop bits.
	input 		    data_length, 	//low when using 7 data bits, high when using 8.
  input         send, rst,      
  input [10:0]  FrameOut,
  input         BaudOut,

  output reg 	data_out, 		//Serial data_out
	output reg 	p_parity_out, 	//parallel odd parity output, low when using the frame parity.
	output reg 	tx_active, 		//high when Tx is transmitting, low when idle.
	output reg 	tx_done 		//high when transmission is done, low when not.
);

//Internal declarations
integer   SerialPos    = 0;  
integer   FrameLength  = 0;
//  integer   DataInLength = 0;
reg       ParHolder;
reg [7:0] DataIn;
reg [1:0] SelSize;

//This part holds all the possible sizes of the frame
always @(data_length,stop_bits,parity_type) begin
    SelSize      = {data_length,stop_bits};
    if (parity_type = 'b00 || parity_type = 'b11 ) begin    //Calculates the length with no parity bit
        case (SelSize)
          'b01  : begin           // 7-bits for data_length, 2-bits for stop_bits
            FrameLength  = 10;
            //DataInLength = 7;
          end
          'b10  : begin           // 8-bits for data_length, 1-bit for stop_bits
            FrameLength  = 10;
            //DataInLength = 8;
          end 
        endcase
    end
    else begin                  //Calculates the length with parity bit
      case (SelSize)
          'b01  : begin           // 7-bits for data_length, 2-bits for stop_bits, 1-bit for parity
            FrameLength  = 11;
            //DataInLength = 7;
          end
          'b10  : begin           // 8-bits for data_length, 1-bit for stop_bits, 1-bit for parity
            FrameLength  = 11;
            //DataInLength = 8;
          end 
        endcase
    end
end

//This part handles the odd parity check for the output p_parity_out
always @(data_length) begin
    if (data_length) 
        DataIn = FrameOut[8:1];
    else 
        DataIn = FrameOut[7:1];
// prepare the parallel odd parity
    if(^DataIn)
        ParHolder = 1'b0;
    else
        ParHolder = 1'b1;
end


//This part handles the outputs
always @(posedge rst, posedge BaudOut) begin
    
    if (rst) begin
    data_out        = 'b1;
    p_parity_out    = 'b0;
    tx_active       = 'b0;
    tx_done         = 'b1;
    end
    else begin
        if (send) begin
            tx_done   = 1'b0;
            tx_active = 1'b1;
            data_out         = FrameOut[SerialPos];
            SerialPos        = SerialPos + 1;
            if (SerialPos == (FrameLength - 1)) begin
                tx_done   = 1'b1;
                tx_active = 1'b0;
            end
            else begin
                tx_done   = 1'b0;
                tx_active = 1'b1;
            end
            if (parity_type  = 'b00 || parity_type = 'b11 ) begin
                p_parity_out = ParHolder;
            end
            else begin
                p_parity_out = 'b0;
            end
        end
        else begin
        tx_done   = 1'b1;
        tx_active = 1'b0;
        end
    end  
end

endmodule