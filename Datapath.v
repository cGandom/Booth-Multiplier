module Datapath(clk, rst, ldX, ldY, ldA, initA, initYminusOne,aBarS, shRA, shRY, ldYminusOne, selR, selL,inBus, Y0YminusOne, outBus);
input clk;
input rst;
input ldX;
input ldY;
input ldA;
input initA;
input initYminusOne;
input aBarS;
input shRA;
input shRY;
input ldYminusOne;
input selR;
input selL;
input [5:0]inBus;
output Y0YminusOne;
output [5:0]outBus;
	wire [5:0]Xout,Yout,Aout;
	wire Asign,A0,Y0;
	wire YminusOne;
	wire [5:0]res;

	shreg6 X(
		.clk(clk),
		.rst(rst),
		.ld(ldX),
		.sh(),
		.serin(),
		.serout(),
		.parin(inBus),
		.parout(Xout)
		);
	shreg6 Y(
		.clk(clk),
		.rst(rst),
		.ld(ldY),
		.sh(shRY),
		.serin(A0),
		.serout(Y0),
		.parin(inBus),
		.parout(Yout)
		);
	assign Asign=Aout[5];
	shreg6 A(
		.clk(clk),
		.rst(rst),
		.ld(ldA),
		.sh(shRA),
		.serin(Asign),
		.serout(A0),
		.parin(res),
		.parout(Aout)
		);
	reg1 YminusOneReg(
		.clk(clk),
		.rst(rst),
		.init(initYminusOne),
		.ld(ldYminusOne),
		.in(Y0),
		.out(YminusOne)
		);
	adder adder (
		.sel(aBarS),
		.A(Aout),
		.B(Xout),
		.C(res)
		);
	bufif6 buf6L (
		.sel(selL),
		.in(Aout),
		.out(outBus)
		);
	bufif6 buf6R (
		.sel(selR),
		.in(Yout),
		.out(outBus)
		);
	assign Y0YminusOne={Y0,YminusOne};
endmodule
