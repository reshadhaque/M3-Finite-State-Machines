`timescale 1ns/1ps

module displayhex(
    input logic [3:0] q,
    output logic [6:0] sseg
);

always_comb
begin
        case (q)
            4'h0: sseg = 7'b1000000; // Display "0"
            4'h1: sseg = 7'b1111001; // Display "1"
            4'h2: sseg = 7'b0100100; // Display "2"
            4'h3: sseg = 7'b0110000; // Display "3"
            4'h4: sseg = 7'b0011001; // Display "4"
            4'h5: sseg = 7'b0010010; // Display "5"
            4'h6: sseg = 7'b0000010; // Display "6"
            4'h7: sseg = 7'b1111000; // Display "7"
            4'h8: sseg = 7'b0000000; // Display "8"
            4'h9: sseg = 7'b0010000; // Display "9"
            4'hA: sseg = 7'b0001000; // Display "A"
            4'hB: sseg = 7'b0000011; // Display "B"
            4'hC: sseg = 7'b1000110; // Display "C"
            4'hD: sseg = 7'b0100001; // Display "D"
            4'hE: sseg = 7'b0000110; // Display "E"
            4'hF: sseg = 7'b0001110; // Display "F"
            default: sseg = 7'b1111111; // Turn off all segments for invalid input
        endcase
end

endmodule