`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/18/2025
// Design Name: Vending Machine
// Module Name: vending_machine_3_items
// Description: Vending machine with 3 items and proper change handling
// 
//////////////////////////////////////////////////////////////////////////////////

module vending_machine_3_items(
    input clk,                   // Clock signal
    input rst,                   // Reset signal
    input [7:0] coin_in,         // Coin amount in ₹ (supports up to 255)
    input [1:0] select,          // Item selection: 00 - Chocolate, 01 - Chips, 10 - Cold drink
    output reg out,              // 1 if item dispensed, 0 otherwise
    output reg [7:0] change,     // Change in ₹
    output reg [3:0] item_dispensed  // 4-bit signal for dispensed item
    );

    // Parameters for item prices
    parameter CHOCOLATE = 8'd5;      // ₹5
    parameter CHIPS = 8'd10;         // ₹10
    parameter COLD_DRINK = 8'd20;    // ₹20
    parameter ICE_CREAM = 8'd50;     // ₹50

    // Item identifiers
    parameter ITEM1 = 2'b00;   // Chocolate
    parameter ITEM2 = 2'b01;   // Chips
    parameter ITEM3 = 2'b10;   // Cold drink
    parameter ITEM4 = 2'b11;   // Ice cream

    // States
    parameter IDLE = 2'b00;
    parameter PROCESS = 2'b01;
    parameter DISPENSE = 2'b10;
    parameter RETURN_CHANGE = 2'b11;

    reg [1:0] c_state, n_state;

    // State transition on clock or reset
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            c_state <= IDLE;
            out <= 0;
            change <= 8'd0;
            item_dispensed <= 4'b0000;
        end 
        else begin
            c_state <= n_state;
        end
    end

    // Combinational logic
    always @(*) begin
        out = 0;                    
        item_dispensed = 4'b0000;   
        change = 8'd0;             

        case (c_state)
            IDLE: begin
                if (coin_in > 0) 
                    n_state = PROCESS;
                else 
                    n_state = IDLE;
            end

            PROCESS: begin
                case (select)
                    ITEM1: begin  // Chocolate ₹5
                        if (coin_in >= CHOCOLATE) begin
                            n_state = DISPENSE;
                            change = coin_in - CHOCOLATE;
                            item_dispensed = 4'b0001;  
                            out = 1;
                        end 
                        else 
                            n_state = IDLE;  
                    end

                    ITEM2: begin  // Chips ₹10
                        if (coin_in >= CHIPS) begin
                            n_state = DISPENSE;
                            change = coin_in - CHIPS;
                            item_dispensed = 4'b0010;  
                            out = 1;
                        end 
                        else 
                            n_state = IDLE;  
                    end

                    ITEM3: begin  // Cold drink ₹20
                        if (coin_in >= COLD_DRINK) begin
                            n_state = DISPENSE;
                            change = coin_in - COLD_DRINK;
                            item_dispensed = 4'b0100;  
                            out = 1;
                        end 
                        else 
                            n_state = IDLE;  
                    end

                    ITEM4: begin  // Ice cream ₹50
                        if (coin_in >= ICE_CREAM) begin
                            n_state = DISPENSE;
                            change = coin_in - ICE_CREAM;
                            item_dispensed = 4'b1000;  
                            out = 1;
                        end 
                        else 
                            n_state = IDLE;  
                    end

                    default: begin
                        n_state = IDLE;
                    end
                endcase
            end

            DISPENSE: begin
                n_state = RETURN_CHANGE;
            end

            RETURN_CHANGE: begin
                n_state = IDLE;   
            end

            default: begin
                n_state = IDLE;
            end
        endcase
    end

endmodule
