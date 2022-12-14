//                       ************************************** This module is created by Mohamed Maged **************************************
//Chipions program's final project for phase(001) "verilog", UART-Tx.
//Undergraduate student, ECE department, Alexandria university.
//This is the top module of the UART-Tx unit

module TxUnit(
    input   rst, stop_bits, data_length, send, clock,
    input   [1:0]   parity_type, baud_rate,
    input   [7:0]  data_in,

    output data_out, p_parity_out, tx_active, tx_done
);

//interconnection 
wire    ParOutUnit, BaudOutUnit;
wire    [10:0]  FramOutUnit;


//Parity unit instantiation 
parity Unit1(
    .rst(rst), .data_in(data_in), .parity_type(parity_type),    //inputs
    
    .parity_out(ParOutUnit)     //output
);

//Frame generator unit instantiation
Framer Unit2(
    .rst(rst), .data_in(data_in), .parity_type(parity_type), .stop_bits(stop_bits),
     .data_length(data_length), .parity_out(ParOutUnit),     //inputs
    
    .frame_out(FramOutUnit)     //output
);

//Baud generator unit instantiation
baud_gen Unit3(
    .baud_rate(baud_rate), .clock(clock), .rst(rst),        //inputs
    
    .baud_out(BaudOutUnit)      //output
);

//PISO shift register unit instantiation
PISO Unit4(
    .parity_type(parity_type), .rst(rst), .stop_bits(stop_bits), .data_length(data_length), .send(send),
    .FrameOut(FramOutUnit), .BaudOut(BaudOutUnit) ,            //inputs

    .data_out(data_out), .p_parity_out(p_parity_out), .tx_active(tx_active), .tx_done(tx_done)      //outputs
);

endmodule