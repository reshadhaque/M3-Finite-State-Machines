`timescale 1ns / 1ps


module top(
    input logic [9:0]SW,
    input logic [3:0]KEY,
    input logic CLOCK_50,
    output logic [9:0]LEDR
);

delayed_debouncer deb(.sw(SW[0]), .reset(KEY[0]), .clk(CLOCK_50), .db(LEDR[0]));


endmodule