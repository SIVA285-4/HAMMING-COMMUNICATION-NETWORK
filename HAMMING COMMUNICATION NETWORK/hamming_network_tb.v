`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.05.2026 10:27:37
// Design Name: 
// Module Name: hamming_network_tb
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


module hamming_network_tb;
    reg        clk;
    reg        rst;
    reg  [3:0] data_in;
    reg  [2:0] error_bit;
    reg        inject_error;

    wire [3:0] data_out;
    wire [6:0] encoded;
    wire [6:0] received;
    wire [6:0] corrected;
    wire [2:0] syndrome;
    wire       error_detected;

    hamming_network uut (
        .clk           (clk),
        .rst           (rst),
        .data_in       (data_in),
        .error_bit     (error_bit),
        .inject_error  (inject_error),
        .data_out      (data_out),
        .encoded       (encoded),
        .received      (received),
        .corrected     (corrected),
        .syndrome      (syndrome),
        .error_detected(error_detected)
    );

    always #5 clk = ~clk;

    task apply_and_display;
        input [3:0] d;
        input [2:0] eb;
        input       ie;
        begin
            data_in      = d;
            error_bit    = eb;
            inject_error = ie;
            @(posedge clk); #1;
            @(posedge clk); #1;
            $display("Data_In=%b | Encoded=%b | Received=%b | Corrected=%b | Data_Out=%b | Syndrome=%b | Error=%b",
                      data_in, encoded, received, corrected, data_out, syndrome, error_detected);
        end
    endtask

    integer i;

    initial begin
        clk          = 0;
        rst          = 1;
        data_in      = 0;
        error_bit    = 0;
        inject_error = 0;
        #15;
        rst = 0;

        $display("\n--- No Error Cases ---");
        apply_and_display(4'b0000, 3'd0, 1'b0);
        apply_and_display(4'b1010, 3'd0, 1'b0);
        apply_and_display(4'b1111, 3'd0, 1'b0);
        apply_and_display(4'b0101, 3'd0, 1'b0);

        $display("\n--- Single Bit Error Injection & Correction ---");
        for (i = 0; i < 7; i = i + 1) begin
            apply_and_display(4'b1011, i[2:0], 1'b1);
        end

        $display("\n--- All 4-bit Data Patterns (No Error) ---");
        for (i = 0; i < 16; i = i + 1) begin
            apply_and_display(i[3:0], 3'd0, 1'b0);
        end

        $display("\n--- All 4-bit Data Patterns with bit-2 error ---");
        for (i = 0; i < 16; i = i + 1) begin
            apply_and_display(i[3:0], 3'd2, 1'b1);
        end

        $display("\nSimulation Complete.");
        $finish;
    end

    initial begin
        $dumpfile("hamming_network.vcd");
        $dumpvars(0, hamming_network_tb);
    end

endmodule
