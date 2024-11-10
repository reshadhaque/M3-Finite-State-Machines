module mod_m_counter
    #(parameter M = 10)
    (
        input logic clk, reset,
        output logic max_tick,
        output logic [3:0]q
    );

    parameter N = 4;


    logic [N-1:0] r_next, r_reg;

    always_ff@(posedge clk, posedge reset)
    begin
        if (reset)
            r_reg <= 0;
        else 
            r_reg <= r_next;
    end
	 
    assign r_next = (r_reg == M - 1) ? 0: r_reg + 1;

    assign q = r_reg;

    assign max_tick = (r_reg == M - 1) ? 1'b1 : 1'b0;
	 
endmodule
