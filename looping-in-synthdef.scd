//inspired by: http://electro-music.com/forum/topic-35243.html
// you can have a function that has a looping control structure to make a synthdef!

(
f = { |repeats = 4|
	SynthDef(\iter ++ repeats, {
		arg out = 0, freq = 440;
		var sound;
		
		sound = SinOsc.ar(freq);
		
		repeats.do({
			arg i;
			var curfreq = freq/(i+1);
			sound = sound * SinOsc.ar(curfreq);
		});
		
		Out.ar(out, sound);
	}).add;};
)

f.value(4);

x = Synth(\iter4);
