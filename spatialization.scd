//courtesy of Daniel Mayer on the sc-list, storing here for own personal reference

//spatialization example
(
SynthDef(\bob, {|out = 0, a = #[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0], freq = 440, tphase = 0|
	var sound, env;
	sound = SinOsc.ar(freq);
	env = EnvGen.ar(Env.perc(), Impulse.kr(1, tphase));
	Out.ar(out, sound*env * a * EnvGate.new);
}).add;
)
//use a as array to spatialize output from single channel (do expansion)
// can also be written as
(
SynthDef(\bob, {|out = 0, freq = 440, tphase = 0|
	var sound, env;
	var a = \a.kr(0!20);
	sound = SinOsc.ar(freq);
	env = EnvGen.ar(Env.perc(), Impulse.kr(1, tphase));
	Out.ar(out, sound*env * a * EnvGate.new);
}).add;
)

//use of indicator function to generate array of 1s and 0s for array

i = {|...indices| var size = 20; (0..size-1).collect({|j|   indices.includes(j).if {1} {0} })};

//now we can do

Ndef(\a, \bpb);
Ndef(\a).set(\a, i.(0.1);