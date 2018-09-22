// you can group parameters in Pbinds
(
~p1 = Pbind(\instrument, \default,
	[\midinote,\dur], Pwrand([Pseq([[40, 1], [42,1], [43,0.5]]), Pseq([[40,1],[42,1],[44,0.25], [43,0.25]])],
		[7,5].normalizeSum, 4)
);
)
~p1.play;

//you can nest pbinds for sequencing fun
(
~p2 = Array.new(2);
~p2.insert(0,
	Pbind(\instrument,\default,
		\dur, Pseq([1,1,0.5]),
		\midinote, Pseq([40,41,43])
	)
);

~p2.insert(1,
	Pbind(\instrument,\default,
		\dur, Pseq([1,1,0.5]),
		\midinote, Pwrand([Pseq([40,41,47]), Pseq([40,42,46])], [7,5].normalizeSum)
	)
);
)

~p2master = Pwrand([Pn(~p2[0], 4), Pn(~p2[1], 4)], [5,5].normalizeSum, 2);
~p2master.play;


// here's how to generate random length patterns with Prout

(
Pbind(\instrument, \default,
	\scale, Scale.major,
	\dur, 0.1,
	\octave, 5,
	\degree, Prout({ loop {rrand(5,10).do({|i| i.yield;}); }}),
	
).play;
)

// using Pcollect to detect when our random length pattern starts over,
// we can use Pgate to have patterns that advance only at these new starts

(
Pbind(\instrument, \default,
	\scale, Scale.minor,
	\dur, 0.1,
	\octave, 5,
	\degree, Prout({ loop {rrand(5,10).do({|i| i.yield;}); }}),
	\newval, Pcollect({|i| i ==0}, Pkey(\degree)),
	\pan, Pgate(Pwhite(-1.0,1.0),inf, \newval)
	
).play;
)