`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2026 10:20:26
// Design Name: 
// Module Name: hamming_encoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module hamming_encoder(
input  [3:0] data_in,
output [6:0] encoded_out
);
    wire p1, p2, p3;

    assign p1 = data_in[0] ^ data_in[1] ^ data_in[3];
    assign p2 = data_in[0] ^ data_in[2] ^ data_in[3];
    assign p3 = data_in[1] ^ data_in[2] ^ data_in[3];

    assign encoded_out[0] = p1;
    assign encoded_out[1] = p2;
    assign encoded_out[2] = data_in[0];
    assign encoded_out[3] = p3;
    assign encoded_out[4] = data_in[1];
    assign encoded_out[5] = data_in[2];
    assign encoded_out[6] = data_in[3];

    
endmodule
