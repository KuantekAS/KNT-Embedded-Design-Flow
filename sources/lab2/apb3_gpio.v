///////////////////////////////////////////////////////////////////////////////////
// Copyright (c) 2022 github-efx
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
///////////////////////////////////////////////////////////////////////////////////

`timescale 1ns / 1ps
/*
module apb3_gpio #(
   parameter   ADDR_WIDTH  = 16,
   parameter   DATA_WIDTH  = 32,
   parameter   NUM_REG     = 10
) (
	output   	[3:0]         	leds_control,
	input   	[1:0]          	butons,
	input                   	clk,
	input                   	resetn,
	input  [ADDR_WIDTH-1:0] 	PADDR,
	input                   	PSEL,
	input                   	PENABLE,
	output                  	PREADY,
	input                   	PWRITE,
	input  [DATA_WIDTH-1:0] 	PWDATA,
	output [DATA_WIDTH-1:0] 	PRDATA,
	output                  	PSLVERROR
);

///////////////////////////////////////////////////////////////////////////////

localparam [1:0] IDLE   = 2'b00,
                 SETUP  = 2'b01,
                 ACCESS = 2'b10;

reg [1:0]            busState, 
                     busNext;
reg [DATA_WIDTH-1:0] slaveReg [0:NUM_REG-1];
reg [DATA_WIDTH-1:0] slaveRegOut;
reg                  slaveReady;
wire                 actWrite,
                     actRead;
integer              byteIndex;

///////////////////////////////////////////////////////////////////////////////

   always@(posedge clk or negedge resetn)
   begin
      if(!resetn) 
         busState <= IDLE; 
      else
         busState <= busNext; 
   end

   always@(*)
   begin
      busNext = busState;
   
      case(busState)
         IDLE:
         begin
            if(PSEL && !PENABLE)
               busNext = SETUP;
            else
               busNext = IDLE;
         end
         SETUP:
         begin
            if(PSEL && PENABLE)
               busNext = ACCESS;
            else
               busNext = IDLE;
         end
         ACCESS:
         begin
            if(PREADY)
               busNext = IDLE;
            else
               busNext = ACCESS;
         end
         default:
         begin
            busNext = IDLE;
         end
      endcase
   end

   assign actWrite   = PWRITE  & (busState == ACCESS);
   assign actRead    = !PWRITE & (busState == ACCESS);
   assign PSLVERROR  = 1'b0; //FIXME
   assign PRDATA     = slaveRegOut;
   assign PREADY     = slaveReady & & (busState !== IDLE);

   always@ (posedge clk)
   begin
      slaveReady <= actWrite | actRead;
   end

   always@ (posedge clk or negedge resetn)
   begin
      if(!resetn)
         for(byteIndex = 0; byteIndex < NUM_REG; byteIndex = byteIndex + 1)
            slaveReg[byteIndex] <= {{DATA_WIDTH}{1'b0}};
      else begin
         for(byteIndex = 0; byteIndex < NUM_REG; byteIndex = byteIndex + 1)
            if(actWrite && PADDR[ADDR_WIDTH-1:0] == (byteIndex*4))
               slaveReg[byteIndex] <= PWDATA;
            else
               slaveReg[byteIndex] <= slaveReg[byteIndex];
      end
   end

   always@ (posedge clk or negedge resetn)
   begin
      if(!resetn)
         slaveRegOut <= {{DATA_WIDTH}{1'b0}};
      else begin
         if (actRead) begin
            case(PADDR[7:2])
               5'd1  : slaveRegOut <= {29'b0,butons};
               5'd2 : slaveRegOut <= 32'hABCD_5678;   //To verify correct slave read operation
               default: begin slaveRegOut <= slaveRegOut; end
            endcase
         end
         else
            slaveRegOut <= slaveRegOut;
      end
   end

   //custom logic starts here
   assign leds_control              = slaveReg[0][3:0];

   
endmodule*/

module apb3_slave #(
	// user parameter starts here
	//
	parameter	ADDR_WIDTH	= 16,
	parameter	DATA_WIDTH	= 32,
	parameter	NUM_REG		= 4
) (
	// user logic starts here
	input				     clk,
	input				     resetn,
	input	[ADDR_WIDTH-1:0] PADDR,
	input				     PSEL,
	input				     PENABLE,
	output				     PREADY,
	input				     PWRITE,
	input 	[DATA_WIDTH-1:0] PWDATA,
	output	[DATA_WIDTH-1:0] PRDATA,
	output				     PSLVERROR

);


///////////////////////////////////////////////////////////////////////////////

localparam [1:0]	IDLE   = 2'b00,
			        SETUP  = 2'b01,
			        ACCESS = 2'b10;

integer			     byteIndex;
reg [DATA_WIDTH-1:0] slaveReg [0:NUM_REG-1];
reg [DATA_WIDTH-1:0] slaveRegOut;
reg [1:0] 		     busState, 
			         busNext;
reg			         slaveReady;
wire	 		     actWrite,
			         actRead;
reg [31:0]           lfsr;
wire                 lfsr_stop;


///////////////////////////////////////////////////////////////////////////////

	always@(posedge clk or negedge resetn)
	begin
		if(!resetn) 
			busState <= IDLE; 
		else
			busState <= busNext; 
	end

	always@(*)
	begin
		busNext = busState;

		case(busState)
			IDLE:
			begin
				if(PSEL && !PENABLE)
					busNext = SETUP;
				else
					busNext = IDLE;
			end
			SETUP:
			begin
				if(PSEL && PENABLE)
					busNext = ACCESS;
				else
					busNext = IDLE;
			end
			ACCESS:
			begin
				if(PREADY)
					busNext = IDLE;
				else
					busNext = ACCESS;
			end
			default:
			begin
				busNext = IDLE;
			end
		endcase
	end


	assign actWrite = PWRITE  & (busState == ACCESS);
	assign actRead  = !PWRITE & (busState == ACCESS);
	assign PSLVERROR = 1'b0; 
	assign PRDATA = slaveRegOut;
	assign PREADY = slaveReady & & (busState !== IDLE);

	always@ (posedge clk)
	begin
		slaveReady <= actWrite | actRead;
	end

	always@ (posedge clk or negedge resetn)
	begin
		if(!resetn)
			for(byteIndex = 0; byteIndex < NUM_REG; byteIndex = byteIndex + 1)
			slaveReg[byteIndex] <= {DATA_WIDTH{1'b0}};
		else 
        begin
			if(actWrite) 
            begin
			    for(byteIndex = 0; byteIndex < NUM_REG; byteIndex = byteIndex + 1)
                if (PADDR[3:0] == (byteIndex*4))
				    slaveReg[byteIndex] <= PWDATA;
            end
			else
            begin
				slaveReg[0] <= lfsr;
                for(byteIndex = 1; byteIndex < NUM_REG; byteIndex = byteIndex + 1)
                slaveReg[byteIndex] <= slaveReg[byteIndex];
            end
		end
	end

	always@ (posedge clk or negedge resetn)
	begin
		if(!resetn)
			slaveRegOut <= {DATA_WIDTH{1'b0}};
		else begin
			if(actRead)
				slaveRegOut <= slaveReg[PADDR[7:2]];
			else
				slaveRegOut <= slaveRegOut;
				
		end

	end

    assign lfsr_stop = slaveReg[1][0];
//custom logics

    always@(posedge clk or negedge resetn)
    begin 
        if (!resetn)
            lfsr <= 'd1;
        else
        begin
            if(!lfsr_stop)
            begin
                lfsr[31] <= lfsr[0];
                lfsr[30] <= lfsr[31];
                lfsr[29] <= lfsr[30];
                lfsr[28] <= lfsr[29];
                lfsr[27] <= lfsr[28];
                lfsr[26] <= lfsr[27];
                lfsr[25] <= lfsr[26];
                lfsr[24] <= lfsr[25];
                lfsr[23] <= lfsr[24];
                lfsr[22] <= lfsr[23];
                lfsr[21] <= lfsr[22];
                lfsr[20] <= lfsr[21];
                lfsr[19] <= lfsr[20];
                lfsr[18] <= lfsr[19];
                lfsr[17] <= lfsr[18];
                lfsr[16] <= lfsr[17];
                lfsr[15] <= lfsr[16];
                lfsr[14] <= lfsr[15];
                lfsr[13] <= lfsr[14];
                lfsr[12] <= lfsr[13];
                lfsr[11] <= lfsr[12];
                lfsr[10] <= lfsr[11];
                lfsr[9 ] <= lfsr[10];
                lfsr[8 ] <= lfsr[9 ];
                lfsr[7 ] <= lfsr[8 ];
                lfsr[6 ] <= lfsr[7 ];
                lfsr[5 ] <= lfsr[6 ];
                lfsr[4 ] <= lfsr[5 ];
                lfsr[3 ] <= lfsr[4 ] ^ lfsr[0];
                lfsr[2 ] <= lfsr[3 ];
                lfsr[1 ] <= lfsr[2 ];
                lfsr[0 ] <= lfsr[1 ] ^ lfsr[0];
            end
            else
            begin
                lfsr <= lfsr;
            end
        end
    end

endmodule