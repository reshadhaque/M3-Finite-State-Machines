`timescale 1ns / 1ps

module rising_edge_detect_mealy(
    input logic clk, reset,
    input logic level,
    output logic tick
);

typedef enum {zero, one} state_type;
state_type state_reg, state_next;

//State register 
always_ff@(posedge clk, posedge reset)
begin
    if(reset)
        state_reg <= zero;
    else
        state_reg <= state_next;
end
//Next state logic
always_comb
begin
    tick = 1'b0;
    state_next = zero;
    case(state_reg)
    zero:
        if(level)
        begin
            tick = 1'b1;
            state_next = one;
        end
        else
            state_next = zero;
    one:
        if(level)
            state_next = one;
        else
            state_next = zero;
    endcase
end
endmodule