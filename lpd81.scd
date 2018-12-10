// =====================================================================
// SuperCollider Workspace
// =====================================================================

s.options.numOutputBusChannels = 16
s.reboot;
(
~sndir = "/home/dxk/sounds/";
~chimes1.numChannels;
~japan1.numChannels;
~loadsynths.value;
~chimes1 = Buffer.read(s, ~sndir ++ "melodic/chimes/" ++ "95012__jaava73__windlesschime.wav");
~birds1 = Buffer.read(s, ~sndir ++ "animal/birds/" ++ "345851__hargissssound__spring-birds-raw-new-jersey.wav");
//~japan1 = Buffer.read(s, ~sndir ++ "speech/" ++ "339625__carmsie__just-a-dream.wav");
~japan1 = Buffer.read(s, ~sndir ++ "speech/" ++ "japan_speech.aiff");

SynthDescLib.global.browse;
MIDIClient.init;
MIDIClient.sources[3];

MIDIIn.connect(0, MIDIClient.sources[3]);
s.meter;
(
~outs = [4,4,5,5,4,4,5,5];
~pan = -1;

~outs = Array.fill(8, {0});
~pan = Array.fill(8, {0});
~loc = [0.134, 0,.235, 0.55,5 0.5, 0.56, 0.555, 0.91, 0.3505];
)

(
MIDIdef.noteOn(\lpd8, {|vel, num, chan|
	switch(num,
		36, {Synth(\dxkTNobuM, [\buf, ~chimes1, \loc, 0.134, \rate, 0.5, \out, ~outs[0], \pan, ~pan[0]])},
		37, {Synth(\dxkTNobuM, [\buf, ~chimes1, \rate, 1, \loc, 0.235, \rate, 0.5, \out, ~outs[1], \pan, ~pan[1]])},
		38, {Synth(\dxkTNobuM, [\buf, ~chimes1, \rate, 0.5, \loc, 0.5505, \out, ~outs[2], \pan, ~pan[2]])},
		39, {Synth(\dxkTNobuM, [\buf, ~chimes1, \loc, 0.219, \rate, 0.5, \out, ~outs[3], \pan, ~pan[3]])},
		40, {Synth(\dxkTNobuM, [\buf, ~chimes1, \rate, 0.5, \loc, 0.56, \out, ~outs[4], \pan, ~pan[4]])},
		41, {Synth(\dxkTNobuM, [\buf, ~chimes1, \rate, 0.5, \loc, 0.555, \out, ~outs[5], \pan, ~pan[5]])},
		42, {Synth(\dxkTNobuM, [\buf, ~chimes1, \loc, 0.91, \out, ~outs[6], \pan, ~pan[6]])},
		43, {Synth(\dxkTNobuM, [\buf, ~chimes1, \loc, 0.3505, \out, ~outs[7], \pan, ~pan[7]])},


	);

});

)

(
MIDIdef.noteOn(\lpd8, {|vel, num, chan|
	switch(num,
		36, {Synth(\dxkTNobuM, [\buf, ~japan1, \loc, 0.135, \rate, 1, \out, ~outs[0], \pan, ~pan])},
		37, {Synth(\dxkTNobuM, [\buf, ~japan1, \loc, 0.221, \rate, 1, \out, ~outs[1], \an, ~pan,])},
		38, {Synth(\dxkTNobuM, [\buf, ~japan1, \loc, 0.12, \rate, 1, \out, ~outs[2], \pan, ~pan])},
		39, {Synth(\dxkTNobuM, [\buf, ~japan1, \loc, 0.219, \rate, 1, \out, ~outs[3], \pan, ~pan])},
		40, {Synth(\dxkTNobuM, [\buf, ~japan1, \loc, 0.5505, \rate,1, \loc, 0.56, \out, ~outs[4], \pan, ~pan])},
		41, {Synth(\dxkTNobuM, [\buf, ~japan1, \loc, 0.62, \rate, 1, \loc, 0.555, \out, ~outs[5], \pan, ~pan])},
		42, {Synth(\dxkTNobuM, [\buf, ~japan1, \loc, 0.81, \rate, 1, \out, ~outs[6], \pan, ~pan])},
		43, {Synth(\dxkTNobuM, [\buf, ~japan1, \loc, 0.71, \rate, 1, \out, ~outs[7], \pan, ~pan])},


	);

});

)

abs(-3);

