`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2026 10:21:56
// Design Name: 
// Module Name: hamming_error_injector
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


module hamming_error_injector(
    input  [6:0] encoded_in,
    input  [2:0] error_bit,
    input        inject_error,
    output [6:0] encoded_out
);
    assign encoded_out = inject_error ? (encoded_in ^ (7'b1 << error_bit)) : encoded_in;

endmodule
