`timescale 1ns / 1ps

module rising_edge_detect_tb();
//Declarations
localparam T = 10; //Clock period 10ps

logic clk, reset, level;
logic tick_mealy, tick_moore;

//Instantiate Designs Under Test
//Mealy
rising_edge_detect_mealy mealy_dut(.clk(clk), .reset(reset), .level(level), .tick(tick_mealy));
//Moore
rising_edge_detect_moore moore_dut(.clk(clk), .reset(reset), .level(level), .tick(tick_moore));


//Test Vectors
//10ns clock running forever
always
begin
    clk = 1'b1;
    #(T/2);
    clk = 1'b0;
    #(T/2);
end
//Reset for the first half cycle
initial
begin
    reset = 1'b1;
    #(T/2);
    reset = 1'b0;
end

//Generate Stimuli (Just the tick)
initial
begin
    repeat(3) @(negedge clk);
    #2;
    level = 1'b1;

    @(negedge clk);
    level = 1'b0;

    repeat(4) @(negedge clk);
    level = 1'b1;

    @(posedge clk);
    level = 1'b0;

    repeat(3) @(posedge clk);

    $finish;
end

endmodule