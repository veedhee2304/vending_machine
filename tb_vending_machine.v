`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2025
// Design Name: Vending Machine Testbench
// Module Name: tb_vending_machine
// Description: Testbench for the vending machine with 3 items
// 
//////////////////////////////////////////////////////////////////////////////////

module tb_vending_machine;

    // Inputs
    reg clk;
    reg rst;
    reg [7:0] coin_in;         // Coin amount in ₹
    reg [1:0] select;           // Item selection

    // Outputs
    wire out;                   // Dispense indicator
    wire [7:0] change;          // Change in ₹
    wire [3:0] item_dispensed;  // Dispensed item

    // Instantiate the vending machine module
    vending_machine_3_items uut (
        .clk(clk),
        .rst(rst),
        .coin_in(coin_in),
        .select(select),
        .out(out),
        .change(change),
        .item_dispensed(item_dispensed)
    );

    // Clock generation
    always #5 clk = ~clk;    // Clock period: 10ns

    // Test sequence
    initial begin
        $display("Starting Vending Machine Testbench...");

        // Initialize signals
        clk = 0;
        rst = 1;
        coin_in = 0;
        select = 2'b00;
        
        #10 rst = 0;       // De-assert reset
        
        // Test Case 1: Buy Chocolate (₹5) with ₹10
        $display("Test Case 1: Buying Chocolate with ₹10");
        coin_in = 8'd10;
        select = 2'b00;     // Chocolate
        #10;
        $display("Out: %b, Change: %d, Item Dispensed: %b", out, change, item_dispensed);
        
        // Test Case 2: Buy Chips (₹10) with ₹10
        $display("Test Case 2: Buying Chips with ₹10");
        coin_in = 8'd10;
        select = 2'b01;     // Chips
        #10;
        $display("Out: %b, Change: %d, Item Dispensed: %b", out, change, item_dispensed);

        // Test Case 3: Buy Cold Drink (₹20) with ₹50
        $display("Test Case 3: Buying Cold Drink with ₹50");
        coin_in = 8'd50;
        select = 2'b10;     // Cold drink
        #10;
        $display("Out: %b, Change: %d, Item Dispensed: %b", out, change, item_dispensed);
        
        // Test Case 4: Buy Ice Cream (₹50) with ₹50
        $display("Test Case 4: Buying Ice Cream with ₹50");
        coin_in = 8'd50;
        select = 2'b11;     // Ice cream
        #10;
        $display("Out: %b, Change: %d, Item Dispensed: %b", out, change, item_dispensed);
        
        // Test Case 5: Insufficient funds for Ice Cream (₹50) with ₹20
        $display("Test Case 5: Insufficient funds for Ice Cream with ₹20");
        coin_in = 8'd20;
        select = 2'b11;     // Ice cream
        #10;
        $display("Out: %b, Change: %d, Item Dispensed: %b", out, change, item_dispensed);
        
        // Test Case 6: Buy Chips (₹10) with ₹15 → Expect ₹5 change
        $display("Test Case 6: Buying Chips with ₹15");
        coin_in = 8'd15;
        select = 2'b01;     // Chips
        #10;
        $display("Out: %b, Change: %d, Item Dispensed: %b", out, change, item_dispensed);
        
        $stop;
    end

endmodule
