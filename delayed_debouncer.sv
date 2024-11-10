`timescale 1ns / 1ps

module delayed_debouncer(
    input logic sw,
    input logic reset,
    input logic clk,
    output logic db
);
//10ms m_tick generator
//assuming clk is 50Mhz (clock period is 50MHz OR 20 ns on Cyclone V FPGA)
//10ms / 20 ns is 10e-3 / 20e-9 which is 500_000
logic m_tick;
mod_m_count #(.M(500_000)) ticker (
    .clk(clk),
    .reset(reset),
    .q(),
    .max_tick(m_tick)
);

//There is a bug somewhere here: If you click the switch too many times and fast enough, the output disappears
typedef enum {zero, wait1_1, wait1_2, wait1_3, one, wait0_1, wait0_2, wait0_3} state_type;
//Signal Declaration
state_type state_reg, state_next;

//State Register
always_ff@(posedge clk, posedge reset)
begin
    if(reset)
        state_reg <= zerol
    else
        state_reg <= state_next;
end

//Next State Logic

always_comb 
begin
    case(state_reg)
    zero:
        if(sw)
            state_next = wait1_1;
        else
            state_next = zero;
    wait1_1:
        if(sw)
            if(m_tick)
                state_next = wait1_2;
            else
                state_next = wait1_1;
        else
            state_next = zero;
    wait1_2:

    wait1_3:
    one:
    wait0_1:
    wait0_2:
    wait0_3:
    endcase
    default: state_next = zero;
end


endmodule