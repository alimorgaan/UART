module frame_tester;
reg [7:0] Din_t;
reg [1:0] p_t;
reg p_o; 
wire [10:0] f_t;
reg rst_t, tx_t, dL_t, s_t;

initial begin
rst_t = 1; tx_t = 1;
Din_t = 8'b10101011;  p_t = 2'b01; dL_t = 1'b0; s_t = 1'b1; p_o = 1'b1; //Odd parity, 7-bit data, 2 stop bits
#50					; p_t = 2'b10; p_o = 1'b0;				//Even parity, 7-bit data, 2 stop bits
#50					; p_t = 2'b01; dL_t = 1'b1; s_t = 1'b0; p_o = 1'b0;//Odd parity, 8-bit data, 1 stop bit
#50					; p_t = 2'b10; p_o = 1'b1;				//Even parity, 8-bit data, 1 stop bit
#50					;
Din_t = 8'b01101101 ; p_t = 2'b00; dL_t = 1'b0; s_t = 1'b1;//No parity, 7-bit data, 2 stop bits
#50 				; p_t = 2'b11; p_o = 1'b1;
#50					; p_t = 2'b00; dL_t = 1'b1; s_t = 1'b0;//No parity, 8-bit data, 1 stop bit
#50					; p_t = 2'b11; p_o = 1'b1;
#100				;
rst_t = 0;	#50	rst_t = 1; #50; //It is expected for the whole frame to be idle, with no chance of coming back to its previous state
tx_t  = 0;  #50 tx_t  = 1; #50; //The deactivation and activation of tx brings makes the whole frame idle, then retrun it back.
rst_t = 0; tx_t = 0;	   #50;
rst_t = 1; tx_t = 1;			//Activating them both after being set LOW sets data back
								//And That's the normal operation mode.
								
//Testing bizzare situations: All HIGH and All LOW
Din_t = 8'b11111111;  p_t = 2'b01; dL_t = 1'b0; s_t = 1'b1; p_o = 1'b0; //Odd parity, 7-bit data, 2 stop bits
#50					; p_t = 2'b10;	p_o = 1'b1;				//Even parity, 7-bit data, 2 stop bits
#50					; p_t = 2'b01; dL_t = 1'b1; s_t = 1'b0; p_o = 1'b1;//Odd parity, 8-bit data, 1 stop bit
#50					; p_t = 2'b10;  p_o  = 1'b0;				//Even parity, 8-bit data, 1 stop bit
#50					;
					  p_t = 2'b00; dL_t = 1'b0; s_t = 1'b1;//No parity, 7-bit data, 2 stop bits
#50 				; p_t = 2'b11;	p_o = 1'b1;
#50					; p_t = 2'b00; dL_t = 1'b1; s_t = 1'b0;//No parity, 8-bit data, 1 stop bit
#50					; p_t = 2'b11;	p_o = 1'b1;

#100;


Din_t = 8'b00000000; p_t = 2'b01; dL_t = 1'b0; s_t = 1'b1; p_o = 1'b1; //Odd parity, 7-bit data, 2 stop bits
#50					; p_t = 2'b10;	p_o = 1'b0;				//Even parity, 7-bit data, 2 stop bits
#50					; p_t = 2'b01; dL_t = 1'b1; s_t = 1'b0; p_o = 1'b1;//Odd parity, 8-bit data, 1 stop bit
#50					; p_t = 2'b10;	p_o = 1'b0;							//Even parity, 8-bit data, 1 stop bit
#50					;
					  p_t = 2'b00; dL_t = 1'b0; s_t = 1'b1;//No parity, 7-bit data, 2 stop bits
#50 				; p_t = 2'b11; p_o = 1'b1;
#50					; p_t = 2'b00; dL_t = 1'b1; s_t = 1'b0;//No parity, 8-bit data, 1 stop bit
#50					; p_t = 2'b11; p_o = 1'b1;

#100;
end
Framer U1 (Din_t, rst_t,p_o, f_t, dL_t, p_t, s_t);

endmodule
