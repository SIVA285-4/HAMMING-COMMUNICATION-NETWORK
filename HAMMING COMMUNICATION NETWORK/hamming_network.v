`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2026 10:24:16
// Design Name: 
// Module Name: hamming_network
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


module hamming_network(
    input        clk,
    input        rst,
    input  [3:0] data_in,
    input  [2:0] error_bit,
    input        inject_error,
    output [3:0] data_out,
    output [6:0] encoded,
    output [6:0] received,
    output [6:0] corrected,
    output [2:0] syndrome,
    output       error_detected
);
    reg [3:0] data_reg;
    reg [2:0] err_bit_reg;
    reg       inject_reg;

    wire [6:0] enc_wire;
    wire [6:0] rec_wire;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_reg    <= 4'b0;
            err_bit_reg <= 3'b0;
            inject_reg  <= 1'b0;
        end else begin
            data_reg    <= data_in;
            err_bit_reg <= error_bit;
            inject_reg  <= inject_error;
        end
    end

    hamming_encoder enc_inst (
        .data_in     (data_reg),
        .encoded_out (enc_wire)
    );

    hamming_error_injector inj_inst (
        .encoded_in  (enc_wire),
        .error_bit   (err_bit_reg),
        .inject_error(inject_reg),
        .encoded_out (rec_wire)
    );

    hamming_decoder dec_inst (
        .received      (rec_wire),
        .data_out      (data_out),
        .syndrome      (syndrome),
        .error_detected(error_detected),
        .corrected     (corrected)
    );

    assign encoded  = enc_wire;
    assign received = rec_wire;

endmodule
