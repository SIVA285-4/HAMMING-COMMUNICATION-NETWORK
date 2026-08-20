`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2026 10:23:08
// Design Name: 
// Module Name: hamming_decoder
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


module hamming_decoder(
    input  [6:0] received,
    output [3:0] data_out,
    output [2:0] syndrome,
    output       error_detected,
    output [6:0] corrected
);
    wire s1, s2, s3;

    assign s1 = received[0] ^ received[2] ^ received[4] ^ received[6];
    assign s2 = received[1] ^ received[2] ^ received[5] ^ received[6];
    assign s3 = received[3] ^ received[4] ^ received[5] ^ received[6];

    assign syndrome       = {s3, s2, s1};
    assign error_detected = |syndrome;

    assign corrected      = (error_detected) ? (received ^ (7'b1 << (syndrome - 1))) : received;

    assign data_out[0] = corrected[2];
    assign data_out[1] = corrected[4];
    assign data_out[2] = corrected[5];
    assign data_out[3] = corrected[6];
endmodule
