`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2020 03:35:48 PM
// Design Name: 
// Module Name: time_mux_disp
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

module time_mux_disp(
    input logic [5:0] in0,
    input logic [5:0] in1,
    input logic [5:0] in2,
    input logic [5:0] in3,
    input logic [5:0] in4,
    input logic [5:0] in5,
    input logic clk,
    output logic [6:0] sseg,
    output logic dp,
    output logic [5:0] an // Change from 8 bits to 6 bits
    );
    
    // Updated to handle 6 displays
    logic [5:0] to_display;
    logic [19:0] counter_output;
    logic [2:0] controller_counter;
    assign controller_counter = counter_output[19:17] % 6; // Modified to select among 6 displays
    
    binary_counter #(.N(20)) c0(
                    .clk(clk),
                    .reset(1'b0),
                    .en(1'b1),
                    .q(counter_output),
                    .max_tick()
                    );
                    
    mux #(.BITS(6)) mux0(
                    .sel(controller_counter),
                    .mux_out(to_display),
                    
    decoder  #(.N(3)) decoder0(
                    .in(controller_counter),
                    .enable(1'b1),
                    .an(an)); // Output is now 6 bits
                    
    hex2sseg ssegdecoder(
                    .hex_in(to_display[4:1]),
                    .enable(to_display[5]),
                    .sseg(sseg));
                    
    // Decimal point                
    assign dp = to_display[0];
endmodule
