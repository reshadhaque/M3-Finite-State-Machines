`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/29/2020 02:51:09 PM
// Design Name: 
// Module Name: top
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


module top(
        input logic KEY[3:0],
        input logic CLOCK_50, // genrally the 100MHz
        output logic [6:0] HEX0,
        output logic [6:0] HEX1
    );
    
logic db;
logic tick;
logic dbtick;
logic q;
logic dbq;

delayed_debouncer debouncer(.sw(~KEY[0]), .reset(~KEY[1]), .clk(CLOCK_50), .db(db));

rising_edge_detect_mealy sw_edge(.clk(CLOCK_50), .reset(~KEY[1]), .level(KEY[0]), .tick(tick));

rising_edge_detect_mealy dw_edge(.clk(CLOCK_50), .reset(~KEY[1]), .level(db), .tick(dbtick));

binary_counter #(4)sw_counter(.clk(CLOCK_50), .reset(~KEY[1]), .en(tick), .max_tick(), .q(q));

binary_counter #(4)sw_counter(.clk(CLOCK_50), .reset(~KEY[1]), .en(dbtick), .max_tick(), .q(dbq));

displayhex hex1(.q(q), .sseq(HEX0));

displayhex hex2(.q(dbq), .sseq(HEX1));


endmodule