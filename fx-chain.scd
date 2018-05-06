//effects chain
//use replaceout instead of out
(
SynthDef(\bob, {|out = 0, freq = 440, tphase = 0|
	var sound, env;
	sound = SinOsc.ar(freq);
	env = EnvGen.ar(Env.perc(), Impulse.kr(1, tphase));
	Out.ar(out, sound*env);
}).add;


SynthDef(\delay, {|in = 0, out = 0|
	ReplaceOut.ar(out, CombC.ar(In.ar(in, 1), 0.5, 0.2, 5));}).add;

SynthDef(\filt, {|in = 0, out = 0|
	ReplaceOut.ar(out, LPF.ar(In.ar(in, 1),100);)}).add;

SynthDef(\panner, {|in = 0, out = 0, pan = 0|
	Out.ar(out, Pan2.ar(In.ar(in, 1),pan));}).add;
)


//use buses (one for each signal branch) since we are doing ReplaceOut
(
~bus = Bus.audio(s, 2);
~bus2 = Bus.audio(s,2);
)

//be aware of diff ways of specifying location in graph
(
~a = Synth(\bob, [\out, 0, \freq, 440, \out, ~bus]);
~a2 = Synth(\bob, [\freq, 880, \out, ~bus, \tphase, 0.5]);
~c = Synth(\filt, [\out, ~bus, \in, ~bus], addAction: \addToTail);
~p1 = Synth(\panner, [\in, ~bus, \out, ~bus], addAction: \addToTail);


~b = Synth.before(~a, \delay, [\in, ~bus, \out, ~bus]);


~a3 = Synth(\bob, [\out, 0, \freq, 330, \out, ~bus2]);
~a4 = Synth(\bob, [\freq, 350, \out, ~bus2, \tphase, 0.5]);
~b2 = Synth(\delay, [\in, ~bus2, \out, ~bus2], addAction: \addToTail);

~c2 = Synth(\filt, [\out, ~bus2, \in, ~bus2], addAction: \addToTail);
~p2 = Synth(\panner, [\in, ~bus2, \out, ~bus2], addAction: \addToTail);

)

//SUM BUSES

//single channel
Ndef(\mix, {~bus.ar + ~bus2.ar}).play;

//mult channel

Ndef(\mix, {Out.ar(0, ~bus.ar + ~bus2.ar)}).play;

//OR

~busses = Array.fill(2, {Bus.audio(s,2)});
//be aware of diff ways of specifying location in graph
(
~a = Synth(\bob, [\out, 0, \freq, 440, \out, ~busses[0]]);
~a2 = Synth(\bob, [\freq, 880, \out, ~busses[0], \tphase, 0.5]);
~c = Synth(\filt, [\out, ~busses[0], \in, ~busses[0]], addAction: \addToTail);
~p1 = Synth(\panner, [\in, ~busses[0], \out, ~busses[0]], addAction: \addToTail);


~b = Synth.before(~a, \delay, [\in, ~busses[0], \out, ~busses[0]]);


~a3 = Synth(\bob, [\out, 0, \freq, 330, \out, ~busses[1]]);
~a4 = Synth(\bob, [\freq, 350, \out, ~busses[1], \tphase, 0.5]);
~b2 = Synth(\delay, [\in, ~busses[1], \out, ~busses[1]], addAction: \addToTail);

~c2 = Synth(\filt, [\out, ~busses[1], \in, ~busses[1]], addAction: \addToTail);
~p2 = Synth(\panner, [\in, ~busses[1], \out, ~busses[1]], addAction: \addToTail);

)

//SUM BUSES

//single channel
Ndef(\mix, {~busses.sum({|i| i.ar})}).play;
(
//free stuff
~a.free;
~a2.free;
~c.free;
~b.free;
~bus.free;
~bus2.free;
~busses.free;
Ndef(\mix).free;

)