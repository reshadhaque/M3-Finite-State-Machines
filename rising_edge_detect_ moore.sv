`timescale 1ns / 1ps

module rising_edge_detect_moore(
    input logic clk, reset;
    input logic level;
    output logic tick;
);

typedef enum (zero, edg, one) state_type;
state_type state_reg, state_next;


//State Register
always_ff@(posedge_clk, posedge reset)
begin
    if(reset)
        state_reg <= zero;
    else
        state_reg <= state_next;
end

//Next state logic
always_comb
begin
    case(state_reg)
    zero:
        if(level)
            state_next = edg;
        else
            state_next = zero;
    edg:
    begin
        if(level)
            state_next = one;
        else
            state_next = zero;
    end
    one:
        if(level)
            state_next = one;
        else
            state_next = zero;
    default: state_next = zero;
    endcase
end
//Mealy output
assign tick = (state_reg == edg);
endmodule