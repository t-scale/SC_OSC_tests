(
~audioIns=ServerOptions.inDevices;
~audioOuts=ServerOptions.outDevices;
~port=57120;
~addr="127.0.0.1";
~mididev="IAC Driver";
~midiport="Bus 1";

s.options.inDevice_(~audioIns[1]);
s.options.outDevice_(~audioOuts[1]);
s.options.numInputBusChannels_(2);
s.options.numOutputBusChannels_(2);
n=NetAddr(~addr, ~port);
MIDIIn.connectAll;

s.meter;
StageLimiter.activate;

s.waitForBoot(
	(

		~sc_track = 2; // TRACK # IN REAPER
		~gLag = 0.01; // global smoothing

		~cBus1 = Bus.control(s,1);
		~cBus2 = Bus.control(s,1);
		~cBus3 = Bus.control(s,1);
		~cBus4 = Bus.control(s,1);
		~cBus5 = Bus.control(s,1);
		~cBus6 = Bus.control(s,1);
		~cBus7 = Bus.control(s,1);
		~cBus8 = Bus.control(s,1);
		~cBus9 = Bus.control(s,1);
		~cBus10 = Bus.control(s,1);
		~cBus11 = Bus.control(s,1);
		~cBus12 = Bus.control(s,1);
		~cBus13 = Bus.control(s,1);
		~cBus14 = Bus.control(s,1);
		~cBus15 = Bus.control(s,1);
		~cBus16 = Bus.control(s,1);

		MIDIdef.noteOn(\notein,{|vel note chan|
			{
				var frq = Lag.kr(In.kr(~cBus1),~gLag);
				var hrm = Lag.kr(In.kr(~cBus2),~gLag);
				var att = Lag.kr(In.kr(~cBus3),~gLag);
				var rel = Lag.kr(In.kr(~cBus4),~gLag);
				var mfq = Lag.kr(In.kr(~cBus5),~gLag);
				var mod = Lag.kr(In.kr(~cBus6),~gLag);
				var fenv = Lag.kr(In.kr(~cBus7),~gLag);
				var fdepth = Lag.kr(In.kr(~cBus8),~gLag);
				var fm = SinOsc.ar(note.midicps+(mfq*1500),0,mod*2000);
				var sig = Blip.ar((fenv*(fdepth*10000))+note.midicps*0.33+fm*(frq*10)+1.0.xrand2,hrm*64*(vel/127));
				var env = EnvGen.kr(Env.perc(att,rel*2),doneAction:2);
				sig = sig*env;
				Out.ar(0,sig!2);
			}.play;
		},chan:0);


		OSCdef.new(\p1,{|val|val.postln;~cBus1.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/1/value");
		OSCdef.new(\p2,{|val|~cBus2.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/2/value");
		OSCdef.new(\p3,{|val|~cBus3.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/3/value");
		OSCdef.new(\p4,{|val|~cBus4.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/4/value");
		OSCdef.new(\p5,{|val|~cBus5.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/5/value");
		OSCdef.new(\p6,{|val|~cBus6.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/6/value");
		OSCdef.new(\p7,{|val|~cBus7.set(val[1])},"/track/"++~sc_track++"/fx/2/fxparam/6/value");
		OSCdef.new(\p8,{|val|~cBus8.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/8/value");
		OSCdef.new(\p9,{|val|~cBus9.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/9/value");
		OSCdef.new(\p10,{|val|~cBus10.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/10/value");
		OSCdef.new(\p11,{|val|~cBus11.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/11/value");
		OSCdef.new(\p12,{|val|~cBus12.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/12/value");
		OSCdef.new(\p13,{|val|~cBus13.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/13/value");
		OSCdef.new(\p14,{|val|~cBus14.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/14/value");
		OSCdef.new(\p15,{|val|~cBus15.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/15/value");
		OSCdef.new(\p16,{|val|~cBus16.set(val[1])},"/track/"++~sc_track++"/fx/1/fxparam/16/value");
	)
)
)