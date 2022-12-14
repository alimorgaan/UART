module parity_Tb;
    
 reg [7:0] data_in;
 reg rst;
 reg [1:0] parity_type;
 wire parity_out;

parity Mo (
.data_in(data_in),
.rst(rst),
.parity_type(parity_type),
.parity_out(parity_out)
);

initial begin
    data_in = 8'b00000000;
    rst = 1;
    parity_type = 2'b00;

    #10
    data_in = 8'b11100000 ;
    rst = 1;
    parity_type = 2'b01 ;

       #10
    data_in = 8'b11100000 ;
    rst = 1;
    parity_type = 2'b10  ;

       #10
    data_in = 8'b11100000 ;
    rst = 1;
    parity_type = 2'b11  ;

       #10
    data_in = 8'b00001111 ;
    rst = 1;
    parity_type = 2'b01  ;

       #10
    data_in = 8'b00001111 ;
    rst = 0;
    parity_type = 2'b01  ;

       #10
    data_in = 8'b10110000    ;
    rst = 1;
    parity_type = 2'b00  ;

       #10
    data_in = 8'b10110000  ;
    rst = 0;
    parity_type = 2'b10  ;

       #10
    data_in = 8'b10110000  ;
    rst = 1;
    parity_type = 2'b10  ;

       #10
    data_in = 8'b01010101    ;
    rst = 1;
    parity_type = 2'b10  ;

       #10
    data_in = 8'b01010101    ;
    rst = 1;
    parity_type = 2'b01  ;

       #10
    data_in = 8'b00000000    ;
    rst = 1;
    parity_type = 2'b01  ;

       #10
    data_in = 8'b00000000    ;
    rst = 1;
    parity_type = 2'b10  ;

   #10
    data_in = 8'b11111111    ;
    rst = 1;
    parity_type = 2'b01  ;

   #10
    data_in = 8'b11111111    ;
    rst = 1;
    parity_type = 2'b10  ;

end

//another way to perform verification
/*always begin
#50
data_in = $random %256;
rst = $random %2;
parity_type = $random %4;
end

initial #1000 $finish;*/


endmodule