//example of sending osc out from a synthdef (indirectly)

c = Bus.control(s, 1);
n = NetAddr("127.0.0.1", 3000);
(
SynthDef(\busTest, {|bus|
	var x = LFNoise0.ar(0.5, 100, 200);
	var y = SinOsc.ar(x);
	Out.kr(bus, Pitch.kr(y, 200, 100, 300));
}).add;
)
(
r = Routine({
	inf.do({
		var val = c.getSynchronous;
		n.sendMsg(\pitch, val);
		0.01.wait;
	});
});
)	

b = Synth(\busTest, [\bus, c]);
r.play;
