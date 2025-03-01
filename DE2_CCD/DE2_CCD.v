// --------------------------------------------------------------------
// Copyright (c) 2005 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE2 CMOS Camera Demo
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny Chen       :| 06/01/06  :|      Initial Revision
//   V1.1 :| Johnny Chen       :| 06/02/06  :|      Modify Image Quality
//   V1.2 :| Johnny Chen       :| 06/03/22  :|      Change Pin Assignment For New Sensor
//   V1.3 :| Johnny Chen       :| 06/03/22  :|      Fixed to Compatible with Quartus II 6.0
//
//   last modified Yuan Ma		 :| 17/11/24  :|		 adapt for the code De2-115
// --------------------------------------------------------------------

module DE2_CCD
	(
		////////////////////	Clock Input	 	////////////////////	 
		CLOCK_27,						//	27 MHz
		CLOCK_50,						//	50 MHz
		EXT_CLOCK,						//	External Clock
		////////////////////	Push Button		////////////////////
		KEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		SW,								//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		HEX0,							//	Seven Segment Digit 0
		HEX1,							//	Seven Segment Digit 1
		HEX2,							//	Seven Segment Digit 2
		HEX3,							//	Seven Segment Digit 3
		HEX4,							//	Seven Segment Digit 4
		HEX5,							//	Seven Segment Digit 5
		HEX6,							//	Seven Segment Digit 6
		HEX7,							//	Seven Segment Digit 7
		////////////////////////	LED		////////////////////////
		LEDG,							//	LED Green[8:0]
		LEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		UART_TXD,						//	UART Transmitter
		UART_RXD,						//	UART Receiver
		////////////////////////	IRDA	////////////////////////
		IRDA_TXD,						//	IRDA Transmitter							// NOT FOUND
		IRDA_RXD,						//	IRDA Receiver							
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 16 Bits
		DRAM_ADDR,						//	SDRAM Address bus 12 Bits
		DRAM_LDQM,						//	SDRAM Low-byte Data Mask 				// NOT FOUND CHECK DRAM_DQM[0] PIN_U2
		DRAM_UDQM,						//	SDRAM High-byte Data Mask				// NOT FOUND CHECK DRAM_DQM[1] PIN_W4
		DRAM_WE_N,						//	SDRAM Write Enable
		DRAM_CAS_N,						//	SDRAM Column Address Strobe
		DRAM_RAS_N,						//	SDRAM Row Address Strobe
		DRAM_CS_N,						//	SDRAM Chip Select
		DRAM_BA_0,						//	SDRAM Bank Address 0						// NOT FOUND CHECK DRAM_BA[0] PIN_U7
		DRAM_BA_1,						//	SDRAM Bank Address 0						// NOT FOUND CHECK DRAM_BA[1] PIN_R4
		DRAM_CLK,						//	SDRAM Clock
		DRAM_CKE,						//	SDRAM Clock Enable
		////////////////////	Flash Interface		////////////////
		FL_DQ,							//	FLASH Data bus 8 Bits
		FL_ADDR,						//	FLASH Address bus 22 Bits
		FL_WE_N,						//	FLASH Write Enable
		FL_RST_N,						//	FLASH Reset									// NOT FOUND
		FL_OE_N,						//	FLASH Output Enable
		FL_CE_N,						//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data bus 16 Bits
		SRAM_ADDR,						//	SRAM Address bus 18 Bits
		SRAM_UB_N,						//	SRAM High-byte Data Mask 
		SRAM_LB_N,						//	SRAM Low-byte Data Mask 
		SRAM_WE_N,						//	SRAM Write Enable
		SRAM_CE_N,						//	SRAM Chip Enable
		SRAM_OE_N,						//	SRAM Output Enable
		////////////////////	ISP1362 Interface	////////////////
//		OTG_DATA,						//	ISP1362 Data bus 16 Bits
//		OTG_ADDR,						//	ISP1362 Address 2 Bits
//		OTG_CS_N,						//	ISP1362 Chip Select
//		OTG_RD_N,						//	ISP1362 Write
//		OTG_WR_N,						//	ISP1362 Read						   // NOT FOUND CHECK
//		OTG_RST_N,						//	ISP1362 Reset
//		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
//		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
//		OTG_INT0,						//	ISP1362 Interrupt 0					// NOT FOUND
//		OTG_INT1,						//	ISP1362 Interrupt 1					// NOT FOUND
//		OTG_DREQ0,						//	ISP1362 DMA Request 0				// NOT FOUND
//		OTG_DREQ1,						//	ISP1362 DMA Request 1				// NOT FOUND
//		OTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0			// NOT FOUND CHECK OTG_DACK_N[0] PIN_C4
//		OTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1			// NOT FOUND CHECK OTG_DACK_N[1] PIN_D4
		////////////////////	LCD Module 16X2		////////////////
		LCD_ON,							//	LCD Power ON/OFF
		LCD_BLON,						//	LCD Back Light ON/OFF
		LCD_RW,							//	LCD Read/Write Select, 0 = Write, 1 = Read
		LCD_EN,							//	LCD Enable
		LCD_RS,							//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_DATA,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
//		SD_DAT,							//	SD Card Data							// NOT FOUND
//		SD_DAT3,						//	SD Card Data 3								// NOT FOUND
//		SD_CMD,							//	SD Card Command Signal
//		SD_CLK,							//	SD Card Clock
		////////////////////	USB JTAG link	////////////////////
//		TDI,  							// CPLD -> FPGA (data in)				// NOT FOUND
//		TCK,  							// CPLD -> FPGA (clk)					// NOT FOUND
//		TCS,  							// CPLD -> FPGA (CS)						// NOT FOUND
//	   TDO,  							// FPGA -> CPLD (data out)				// NOT FOUND
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		I2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
//		PS2_DAT,						//	PS2 Data										// NOT FOUND
//		PS2_CLK,						//	PS2 Clock									// NOT FOUND
		////////////////////	VGA		////////////////////////////
		VGA_CLK,   						//	VGA Clock
		VGA_HS,							//	VGA H_SYNC
		VGA_VS,							//	VGA V_SYNC
		VGA_BLANK,						//	VGA BLANK
		VGA_SYNC,						//	VGA SYNC
		VGA_R,   						//	VGA Red[9:0]
		VGA_G,	 						//	VGA Green[9:0]
		VGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
//		ENET_DATA,						//	DM9000A DATA bus 16Bits										//NOT FOUND
//		ENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data	//NOT FOUND
//		ENET_CS_N,						//	DM9000A Chip Select											//NOT FOUND
//		ENET_WR_N,						//	DM9000A Write													//NOT FOUND
//		ENET_RD_N,						//	DM9000A Read													//NOT FOUND
//		ENET_RST_N,						//	DM9000A Reset													//NOT FOUND
//		ENET_INT,						//	DM9000A Interrupt												//NOT FOUND
//		ENET_CLK,						//	DM9000A Clock 25 MHz											//NOT FOUND
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		AUD_ADCDAT,						//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		AUD_DACDAT,						//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		AUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		TD_DATA,    					//	TV Decoder Data bus 8 bits
		TD_HS,							//	TV Decoder H_SYNC
		TD_VS,							//	TV Decoder V_SYNC
		TD_RESET,						//	TV Decoder Reset						// NOT FOUND
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0						// NOT FOUND
		GPIO								//	GPIO Connection 1						// NOT FOUND chang from GPIO_1 to GPIO 
	);

////////////////////////	Clock Input	 	////////////////////////
input			CLOCK_27;				//	27 MHz
input			CLOCK_50;				//	50 MHz
input			EXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	[3:0]	KEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	SW;						//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	HEX0;					//	Seven Segment Digit 0
output	[6:0]	HEX1;					//	Seven Segment Digit 1
output	[6:0]	HEX2;					//	Seven Segment Digit 2
output	[6:0]	HEX3;					//	Seven Segment Digit 3
output	[6:0]	HEX4;					//	Seven Segment Digit 4
output	[6:0]	HEX5;					//	Seven Segment Digit 5
output	[6:0]	HEX6;					//	Seven Segment Digit 6
output	[6:0]	HEX7;					//	Seven Segment Digit 7
////////////////////////////	LED		////////////////////////////
output	[8:0]	LEDG;					//	LED Green[8:0]
output	[17:0]	LEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			UART_TXD;				//	UART Transmitter
input			UART_RXD;				//	UART Receiver
////////////////////////////	IRDA	////////////////////////////
output			IRDA_TXD;				//	IRDA Transmitter
input			IRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	[15:0]	DRAM_DQ;				//	SDRAM Data bus 16 Bits
output	[11:0]	DRAM_ADDR;				//	SDRAM Address bus 12 Bits
output			DRAM_LDQM;				//	SDRAM Low-byte Data Mask 
output			DRAM_UDQM;				//	SDRAM High-byte Data Mask
output			DRAM_WE_N;				//	SDRAM Write Enable
output			DRAM_CAS_N;				//	SDRAM Column Address Strobe
output			DRAM_RAS_N;				//	SDRAM Row Address Strobe
output			DRAM_CS_N;				//	SDRAM Chip Select
output			DRAM_BA_0;				//	SDRAM Bank Address 0
output			DRAM_BA_1;				//	SDRAM Bank Address 0
output			DRAM_CLK;				//	SDRAM Clock
output			DRAM_CKE;				//	SDRAM Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	[7:0]	FL_DQ;					//	FLASH Data bus 8 Bits
output	[21:0]	FL_ADDR;				//	FLASH Address bus 22 Bits
output			FL_WE_N;				//	FLASH Write Enable
output			FL_RST_N;				//	FLASH Reset
output			FL_OE_N;				//	FLASH Output Enable
output			FL_CE_N;				//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	[15:0]	SRAM_DQ;				//	SRAM Data bus 16 Bits
output	[17:0]	SRAM_ADDR;				//	SRAM Address bus 18 Bits
output			SRAM_UB_N;				//	SRAM High-byte Data Mask 
output			SRAM_LB_N;				//	SRAM Low-byte Data Mask 
output			SRAM_WE_N;				//	SRAM Write Enable
output			SRAM_CE_N;				//	SRAM Chip Enable
output			SRAM_OE_N;				//	SRAM Output Enable
////////////////////	ISP1362 Interface	////////////////////////
//inout	[15:0]	OTG_DATA;				//	ISP1362 Data bus 16 Bits
//output	[1:0]	OTG_ADDR;				//	ISP1362 Address 2 Bits
//output			OTG_CS_N;				//	ISP1362 Chip Select
//output			OTG_RD_N;				//	ISP1362 Write
//output			OTG_WR_N;				//	ISP1362 Read
//output			OTG_RST_N;				//	ISP1362 Reset
//output			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
//output			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
//input			OTG_INT0;				//	ISP1362 Interrupt 0
//input			OTG_INT1;				//	ISP1362 Interrupt 1
//input			OTG_DREQ0;				//	ISP1362 DMA Request 0
//input			OTG_DREQ1;				//	ISP1362 DMA Request 1
//output			OTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
//output			OTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	[7:0]	LCD_DATA;				//	LCD Data bus 8 bits
output			LCD_ON;					//	LCD Power ON/OFF
output			LCD_BLON;				//	LCD Back Light ON/OFF
output			LCD_RW;					//	LCD Read/Write Select, 0 = Write, 1 = Read
output			LCD_EN;					//	LCD Enable
output			LCD_RS;					//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
//inout			SD_DAT;					//	SD Card Data
//inout			SD_DAT3;				//	SD Card Data 3
//inout			SD_CMD;					//	SD Card Command Signal
//output			SD_CLK;					//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			I2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
//input		 	PS2_DAT;				//	PS2 Data
//input			PS2_CLK;				//	PS2 Clock
////////////////////	USB JTAG link	////////////////////////////
//input  			TDI;					// CPLD -> FPGA (data in)
//input  			TCK;					// CPLD -> FPGA (clk)
//input  			TCS;					// CPLD -> FPGA (CS)
//output 			TDO;					// FPGA -> CPLD (data out)
////////////////////////	VGA			////////////////////////////
output			VGA_CLK;   				//	VGA Clock
output			VGA_HS;					//	VGA H_SYNC
output			VGA_VS;					//	VGA V_SYNC
output			VGA_BLANK;				//	VGA BLANK
output			VGA_SYNC;				//	VGA SYNC
output	[7:0]	VGA_R;   				//	VGA Red[9:0]						// turn to 8 bits
output	[7:0]	VGA_G;	 				//	VGA Green[9:0]						// turn to 8 bits
output	[7:0]	VGA_B;   				//	VGA Blue[9:0]						// turn to 8 bits
////////////////	Ethernet Interface	////////////////////////////
//inout	[15:0]	ENET_DATA;				//	DM9000A DATA bus 16Bits
//output			ENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
//output			ENET_CS_N;				//	DM9000A Chip Select
//output			ENET_WR_N;				//	DM9000A Write
//output			ENET_RD_N;				//	DM9000A Read
//output			ENET_RST_N;				//	DM9000A Reset
//input			ENET_INT;				//	DM9000A Interrupt
//output			ENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			AUD_ADCDAT;				//	Audio CODEC ADC Data
inout			AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			AUD_DACDAT;				//	Audio CODEC DAC Data
inout			AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			AUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input	[7:0]	TD_DATA;    			//	TV Decoder Data bus 8 bits
input			TD_HS;					//	TV Decoder H_SYNC
input			TD_VS;					//	TV Decoder V_SYNC
output			TD_RESET;				//	TV Decoder Reset
////////////////////////	GPIO	////////////////////////////////
inout	[35:0]	GPIO_0;					//	GPIO Connection 0				// NOT FOUND
inout	[35:0]	GPIO;					//	GPIO Connection 1					// NOT FOUND chang from GPIO_1 to GPIO 

assign	LCD_ON		=	1'b1;
assign	LCD_BLON	=	1'b1;
assign	TD_RESET	=	1'b1;


//	All inout port turn to tri-state
assign	FL_DQ		=	8'hzz;
assign	SRAM_DQ		=	16'hzzzz;
assign	OTG_DATA	=	16'hzzzz;
assign	LCD_DATA	=	8'hzz;
//assign	SD_DAT		=	1'bz;
assign	I2C_SDAT	=	1'bz;
//assign	ENET_DATA	=	16'hzzzz;
assign	AUD_ADCLRCK	=	1'bz;
assign	AUD_DACLRCK	=	1'bz;
assign	AUD_BCLK	=	1'bz;

//	CCD
wire	[9:0]	CCD_DATA;
wire			CCD_SDAT;
wire			CCD_SCLK;
wire			CCD_FLASH;
wire			CCD_FVAL;
wire			CCD_LVAL;
wire			CCD_PIXCLK;
reg				CCD_MCLK;	//	CCD Master Clock

wire	[15:0]	Read_DATA1;
wire	[15:0]	Read_DATA2;
wire			VGA_CTRL_CLK;
wire			AUD_CTRL_CLK;
wire	[9:0]	mCCD_DATA;
wire			mCCD_DVAL;
wire			mCCD_DVAL_d;
wire	[10:0]	X_Cont;
wire	[10:0]	Y_Cont;
wire	[9:0]	X_ADDR;
wire	[31:0]	Frame_Cont;
wire	[9:0]	mCCD_R;
wire	[9:0]	mCCD_G;
wire	[9:0]	mCCD_B;
wire			DLY_RST_0;
wire			DLY_RST_1;
wire			DLY_RST_2;
wire			Read;
reg		[9:0]	rCCD_DATA;
reg				rCCD_LVAL;
reg				rCCD_FVAL;
wire	[9:0]	sCCD_R;
wire	[9:0]	sCCD_G;
wire	[9:0]	sCCD_B;
wire			sCCD_DVAL;


// VGA R/G/B
wire [9:0] VGA_R9;
wire [9:0] VGA_G9;
wire [9:0] VGA_B9;
//modified
wire 		cansend;			//added internal logic
wire		[9:0]	H_Cont;
wire		[9:0]	V_Cont;
wire		dataready;
wire		[0:44999] midrec;
wire		[4:0]	drawrec;	


assign VGA_R = {VGA_B9[9],VGA_B9[8],VGA_B9[7],VGA_B9[6],VGA_B9[5],VGA_B9[4],VGA_B9[3],VGA_B9[2]} ;
assign VGA_G = {VGA_B9[9],VGA_B9[8],VGA_B9[7],VGA_B9[6],VGA_B9[5],VGA_B9[4],VGA_B9[3],VGA_B9[2]} ;
assign VGA_B = {VGA_B9[9],VGA_B9[8],VGA_B9[7],VGA_B9[6],VGA_B9[5],VGA_B9[4],VGA_B9[3],VGA_B9[2]} ;

//	For Sensor 1
assign	CCD_DATA[0]	=	GPIO[0];
assign	CCD_DATA[1]	=	GPIO[1];
assign	CCD_DATA[2]	=	GPIO[5];
assign	CCD_DATA[3]	=	GPIO[3];
assign	CCD_DATA[4]	=	GPIO[2];
assign	CCD_DATA[5]	=	GPIO[4];
assign	CCD_DATA[6]	=	GPIO[6];
assign	CCD_DATA[7]	=	GPIO[7];
assign	CCD_DATA[8]	=	GPIO[8];
assign	CCD_DATA[9]	=	GPIO[9];
assign	GPIO[11]	=	CCD_MCLK; 		// change from GPIO[11] to GPIO[13]
//assign	GPIO_1[15]	=	CCD_SDAT;
//assign	GPIO_1[14]	=	CCD_SCLK;
assign	CCD_FVAL	=	GPIO[13];		// change from GPIO[13] to GPIO[15]
assign	CCD_LVAL	=	GPIO[12];		// change from GPIO[12] to GPIO[14]
assign	CCD_PIXCLK	=	GPIO[10]; // change from GPIO[10] to GPIO[12]
//	For Sensor 2
/*
assign	CCD_DATA[0]	=	GPIO_1[0+20];
assign	CCD_DATA[1]	=	GPIO_1[1+20];
assign	CCD_DATA[2]	=	GPIO_1[5+20];
assign	CCD_DATA[3]	=	GPIO_1[3+20];
assign	CCD_DATA[4]	=	GPIO_1[2+20];
assign	CCD_DATA[5]	=	GPIO_1[4+20];
assign	CCD_DATA[6]	=	GPIO_1[6+20];
assign	CCD_DATA[7]	=	GPIO_1[7+20];
assign	CCD_DATA[8]	=	GPIO_1[8+20];
assign	CCD_DATA[9]	=	GPIO_1[9+20];
assign	GPIO_1[11+20]	=	CCD_MCLK;
assign	GPIO_1[15+20]	=	CCD_SDAT;
assign	GPIO_1[14+20]	=	CCD_SCLK;
assign	CCD_FVAL	=	GPIO_1[13+20];
assign	CCD_LVAL	=	GPIO_1[12+20];
assign	CCD_PIXCLK	=	GPIO_1[10+20];
*/
assign	LEDR		=	SW;
assign	LEDG		=	Y_Cont;
assign	VGA_CTRL_CLK=	CCD_MCLK;
assign	VGA_CLK		=	~CCD_MCLK;

always@(posedge CLOCK_50)	CCD_MCLK	<=	~CCD_MCLK;

always@(posedge CCD_PIXCLK)
begin
	rCCD_DATA	<=	CCD_DATA;
	rCCD_LVAL	<=	CCD_LVAL;
	rCCD_FVAL	<=	CCD_FVAL;
end
/*modified*/
ImageRead myImageRead(
								.pixclk(VGA_CTRL_CLK),
								.RESET(1'b0), 
								.cansend(cansend),
								.hsync(H_Cont),
								.vsync(V_Cont),
								.pixvalue(Read_DATA1[9:0]), // read blue data
								.dataready(dataready),
								.image(midrec)
							);

MaskLayer myMaskLayer(
								.CLK(CLOCK_50),
								.RESET(1'b0),
								.image(midrec),
								.start(dataready),
								.done(cansend),
								.confidence(drawrec)
							);
VGA_Controller		u1	(	//	Host Side
							.oRequest(Read),
							.iRed(Read_DATA2[9:0]),
							.iGreen({Read_DATA1[14:10],Read_DATA2[14:10]}),
							.iBlue(Read_DATA1[9:0]),
							//	VGA Side
							.oVGA_R(VGA_R9),
							.oVGA_G(VGA_G9),
							.oVGA_B(VGA_B9),
							.oVGA_H_SYNC(VGA_HS),
							.oVGA_V_SYNC(VGA_VS),
							.oVGA_SYNC(VGA_SYNC),
							.oVGA_BLANK(VGA_BLANK),
							//	Control Signal
							.iCLK(VGA_CTRL_CLK),
							.iRST_N(DLY_RST_2),
							.H_Cont(H_Cont),
							.V_Cont(V_Cont),
							.drawrec(drawrec),
							// for debugging
							//.image(midrec),
							//.cansend(cansend)
							);

/*modified*/
//VGA_Controller		u1	(	//	Host Side
//							.oRequest(Read),
//							.iRed(Read_DATA2[9:0]),
//							.iGreen({Read_DATA1[14:10],Read_DATA2[14:10]}),
//							.iBlue(Read_DATA1[9:0]),
//							//	VGA Side
//							.oVGA_R(VGA_R9),
//							.oVGA_G(VGA_G9),
//							.oVGA_B(VGA_B9),
//							.oVGA_H_SYNC(VGA_HS),
//							.oVGA_V_SYNC(VGA_VS),
//							.oVGA_SYNC(VGA_SYNC),
//							.oVGA_BLANK(VGA_BLANK),
//							//	Control Signal
//							.iCLK(VGA_CTRL_CLK),
//							.iRST_N(DLY_RST_2)	);
//
Reset_Delay			u2	(	.iCLK(CLOCK_50),
							.iRST(KEY[0]),
							.oRST_0(DLY_RST_0),
							.oRST_1(DLY_RST_1),
							.oRST_2(DLY_RST_2)	);

CCD_Capture			u3	(	.oDATA(mCCD_DATA),
							.oDVAL(mCCD_DVAL),
							.oX_Cont(X_Cont),
							.oY_Cont(Y_Cont),
							.oFrame_Cont(Frame_Cont),
							.iDATA(rCCD_DATA),
							.iFVAL(rCCD_FVAL),
							.iLVAL(rCCD_LVAL),
							.iSTART(!KEY[3]),
							.iEND(!KEY[2]),
							.iCLK(CCD_PIXCLK),
							.iRST(DLY_RST_1)	);

RAW2RGB				u4	(	.oRed(mCCD_R),
							.oGreen(mCCD_G),
							.oBlue(mCCD_B),
							.oDVAL(mCCD_DVAL_d),
							.iX_Cont(X_Cont),
							.iY_Cont(Y_Cont),
							.iDATA(mCCD_DATA),
							.iDVAL(mCCD_DVAL),
							.iCLK(CCD_PIXCLK),
							.iRST(DLY_RST_1)	);

SEG7_LUT_8 			u5	(	.oSEG0(HEX0),.oSEG1(HEX1),
							.oSEG2(HEX2),.oSEG3(HEX3),
							.oSEG4(HEX4),.oSEG5(HEX5),
							.oSEG6(HEX6),.oSEG7(HEX7),
							.iDIG(Frame_Cont) );

Sdram_Control_4Port	u6	(	//	HOST Side
						    .REF_CLK(CLOCK_50),
						    .RESET_N(1'b1),
							//	FIFO Write Side 1
						    .WR1_DATA(	{sCCD_G[9:5],
										 sCCD_B[9:0]}),
							.WR1(sCCD_DVAL),
							.WR1_ADDR(0),
							.WR1_MAX_ADDR(640*512),
							.WR1_LENGTH(9'h100),
							.WR1_LOAD(!DLY_RST_0),
							.WR1_CLK(CCD_PIXCLK),
							//	FIFO Write Side 2
						    .WR2_DATA(	{sCCD_G[4:0],
										 sCCD_R[9:0]}),
							.WR2(sCCD_DVAL),
							.WR2_ADDR(22'h100000),
							.WR2_MAX_ADDR(22'h100000+640*512),
							.WR2_LENGTH(9'h100),
							.WR2_LOAD(!DLY_RST_0),
							.WR2_CLK(CCD_PIXCLK),
							//	FIFO Read Side 1
						    .RD1_DATA(Read_DATA1),
				        	.RD1(Read),
				        	.RD1_ADDR(640*16),
							.RD1_MAX_ADDR(640*496),
							.RD1_LENGTH(9'h100),
				        	.RD1_LOAD(!DLY_RST_0),
							.RD1_CLK(VGA_CTRL_CLK),
							//	FIFO Read Side 2
						    .RD2_DATA(Read_DATA2),
				        	.RD2(Read),
				        	.RD2_ADDR(22'h100000+640*16),
							.RD2_MAX_ADDR(22'h100000+640*496),
							.RD2_LENGTH(9'h100),
				        	.RD2_LOAD(!DLY_RST_0),
							.RD2_CLK(VGA_CTRL_CLK),
							//	SDRAM Side
						    .SA(DRAM_ADDR),
						    .BA({DRAM_BA_1,DRAM_BA_0}),
						    .CS_N(DRAM_CS_N),
						    .CKE(DRAM_CKE),
						    .RAS_N(DRAM_RAS_N),
				            .CAS_N(DRAM_CAS_N),
				            .WE_N(DRAM_WE_N),
						    .DQ(DRAM_DQ),
				            .DQM({DRAM_UDQM,DRAM_LDQM}),
							.SDR_CLK(DRAM_CLK)	);

I2C_CCD_Config 		u7	(	//	Host Side
							.iCLK(CLOCK_50),
							.iRST_N(KEY[1]),
							.iExposure(SW[15:0]),
							//	I2C Side
							.I2C_SCLK(GPIO[14]), // change from GPIO[14] to GPIO[16]
							.I2C_SDAT(GPIO[15])	);	// change from GPIO[15] to GPIO[17]

Mirror_Col			u8	(	//	Input Side
							.iCCD_R(mCCD_R),
							.iCCD_G(mCCD_G),
							.iCCD_B(mCCD_B),
							.iCCD_DVAL(mCCD_DVAL_d),
							.iCCD_PIXCLK(CCD_PIXCLK),
							.iRST_N(DLY_RST_1),
							//	Output Side
							.oCCD_R(sCCD_R),
							.oCCD_G(sCCD_G),
							.oCCD_B(sCCD_B),
							.oCCD_DVAL(sCCD_DVAL));

endmodule
						
