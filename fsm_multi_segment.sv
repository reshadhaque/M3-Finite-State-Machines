`timescale 1ns / 1ps

module fsm_multi_segment(
    input logic clk, reset,
    input logic a, b,
    output logic y0, y1
);

typedef enum {s0, s1, s2} state_type;
//signal declaration
state_type state_reg, state_next;
//1. State Register
always_ff@(posedge clk, posedge reset)
begin
    if(reset)
        state_reg <= s0;
    else
        state_reg <= state_next;
end

//2. Next State Logic
always_comb begin
    case(state_reg)
    s0: 
        if(a)
            if(b)
                state_next = s2;
            else    
                state_next = s1;
        else
            state_next = s0;

    s1:
        if(a)
            state_next = s0;
        else 
            state_next = s1;

    s2:
        state_next = s0;
    default: state_next <= s0;
    endcase
end

//3. Mealy Output
assign y0 = (state_reg == s0) & a & b;
//4. Moore Output
assign y1 = (state_reg == s0) || (state_reg == s1);

endmodule