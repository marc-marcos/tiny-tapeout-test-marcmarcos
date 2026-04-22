/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  reg [7:0] ram [0:31];
   reg [7:0] uo_out_s;


  always @(posedge clk) begin
        if (uio_in[7]) begin
            // Write operation
            ram[uio_in[4:0]] <= ui_in;
        end
        // Read operation (Synchronous)
        uo_out_s <= ram[uio_in[3:0]];

    end
  // All output pins must be assigned. If not used, assign to 0.
  assign uio_out = 0;
  assign uio_oe  = 0;


   assign uo_out = uo_out_s;

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, uio_in[6:4], 1'b0};

endmodule
