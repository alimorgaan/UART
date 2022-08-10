module Framer(data_in, rst, frame_out, data_length, parity_type, stop_bits, tx_active);
input rst;
input tx_active;
input [7:0] data_in;
input [1:0] parity_type;
input data_length, stop_bits; 
/*
	data_length = 0 --->>7-bits
	data_length = 1 --->>8-bits
	
	stop_bits = 0	--->>1-bit
	stop_bits = 1	--->>2-bits
*/
output reg [10:0] frame_out;

reg [3:0] frame_select;


reg parity_bit;

//Deciding the value of parity if allowed
always @(parity_type)begin
	if (parity_type == 2'b01 )		begin//Odd Parity
		if (data_length == 0)
		parity_bit = ^data_in[6:0] ? 1'b0:1'b1;
		else
		parity_bit = ^data_in ? 1'b0:1'b1;
	end
	else if (parity_type == 2'b10 )	begin//Even Parity
		if (data_length == 0)
		parity_bit = ^data_in[6:0] ? 1'b1:1'b0;
		else
		parity_bit = ^data_in ? 1'b1:1'b0;
	end
end


always @ (negedge rst, tx_active, parity_type, data_length, stop_bits, data_in) begin
	frame_select = {parity_type, data_length, stop_bits};
	if(~rst)
	frame_out = {11{1'b1}};
	else if (rst == 1'b1 && tx_active == 1'b1)
	begin
		case (frame_select) 
			4'b0101: frame_out = {2'b11,parity_bit,data_in[6:0],1'b0};	//Odd parity, 7-bit data, 2 stop bits
			4'b1001: frame_out = {2'b11,parity_bit,data_in[6:0],1'b0};	//Even parity, 7-bit data, 2 stop bits
		
			4'b0110: frame_out = {1'b1,parity_bit,data_in[7:0],1'b0};	//Odd parity, 8-bit data, 1 stop bit
			4'b1010: frame_out = {1'b1,parity_bit,data_in[7:0],1'b0};	//Even parity, 8-bit data, 1 stop bit
		
			4'b0001: frame_out = {3'b111,data_in[6:0],1'b0};		//No parity, 7-bit data, 2 stop bits
			4'b1101: frame_out = {3'b111,data_in[6:0],1'b0};		//No parity, 7-bit data, 2 stop bits
		
			4'b0010: frame_out = {2'b11,data_in[7:0],1'b0};		//No parity, 8-bit data, 1 stop bit
			4'b1110: frame_out = {2'b11,data_in[7:0],1'b0};			//No parity, 8-bit data, 1 stop bit
		
			default: frame_out = {11{1'b1}};
		endcase
	end
end
endmodule

