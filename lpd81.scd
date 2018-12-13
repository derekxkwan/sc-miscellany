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
MIDIClient.sources;
MIDIClient.sources[3];

MIDIIn.connect(0, MIDIClient.sources[3]);
s.meter;
(
var lpd_setlop, lpd_sethip, lpd_setdownsamp, lpd_setbitres;
var lpd_createsynth = {arg idx, ipt_vel;
	var return_synth;
	var cur_buf = ~buf[idx];
	var vel_range = 127 - 70;
	var scaled_vel = ((max(ipt_vel - 70, 0)/vel_range) * 0.95) + 0.05;
	if(cur_buf.numChannels == 1, {
		return_synth =
		Synth(\dxkTNobuM, [\out, ~outs[idx], \buf, cur_buf, \amp, scaled_vel, \loc, ~loc[idx], \rate, ~rate[idx], \out, ~outs[idx], \pan, ~pan[idx]],
		addAction: \addToHead);
	},
		{
			return_synth = Synth(\dxkTNobuM, [\out, ~outs[idx], \buf, cur_buf, \amp, scaled_vel, \loc, ~loc[idx], \rate, ~rate[idx], \out, ~outs[idx], \pan, ~pan[idx]],
		addAction: \addToHead);
		});
	return_synth;
};



~outs = [4,4,5,5,4,4,5,5];
~pan = -1;

~outs = Array.fill(8, {30});
~pan = Array.fill(8, {0});
~loc = [0.134, 0.235, 0.55, 0.5, 0.56, 0.555, 0.91, 0.3505];
~rate = Array.fill(8, {1});
~buf = Array.fill(8, {~chimes1});

//chimes1
~loc = [0.134, 0.235, 0.5505, 0.5, 0.56, 0.555, 0.91, 0.3505];
~rate = [0.5, 1, 0.5, 0.5, 0.5, 0.5, 1, 1];



MIDIdef.noteOn(\lpd8_noteon, {|vel, num, chan|
	var low_num = 36;
	var cur_idx = num - low_num;
	var cur_synth = lpd_createsynth.value(cur_idx, vel);

});

~decim_out = Synth(\dxkBitcrushS, [\in, 30, \out, 32], addAction: \addToTail);
~filt_out = Synth(\dxkHLPFS, [\in, 32, \out, 0], addAction: \addToTail);

lpd_setlop = {arg in_val;
	var min_freq = 100;
	var max_freq = 15000;
	var cur_range = max_freq - min_freq;
	var cur_val = (((in_val)/127.0) * cur_range) + min_freq;
	~filt_out.set(\freq_hi, cur_val);
	cur_val.postln;

};

lpd_sethip = {arg in_val;
	var min_freq = 100;
	var max_freq = 15000;
	var cur_range = max_freq - min_freq;
	var cur_val = (((in_val)/127.0) * cur_range) + min_freq;
	~filt_out.set(\freq_lo, cur_val);
	cur_val.postln;

};

lpd_setdownsamp = {arg in_val;
	var min_downsamp = 1;
	var max_downsamp = 24;
	var cur_range = abs(max_downsamp - min_downsamp);
	var cur_val = ((in_val/127.0) * cur_range) + min_downsamp;
	cur_val = max(cur_val, min_downsamp);
	~decim_out.set(\downsamp, cur_val);
};

lpd_setbitres = {arg in_val;
	var min_bitres = 8;
	var max_bitres = 24;
	var cur_range = abs(max_bitres - min_bitres);
	var cur_val = ((1.0 - (in_val/127.0)) * cur_range) + min_bitres;
	cur_val = max(cur_val, min_bitres);
	~decim_out.set(\downsamp, cur_val);
};

lpd_setlop.value(127);
lpd_sethip.value(0);
lpd_setdownsamp.value(0);
lpd_setbitres.value(0);




MIDIdef.cc(\lpd8_cc, {|val, knob, ccNum|
	//[val, knob].postln;

	switch(knob,
		1, {lpd_setlop.value(val);},
		2, {lpd_sethip.value(val);},
		3, {lpd_setdownsamp.value(val);},
		4, {lpd_setbitres.value(val);}
	);
});
	
	

)


