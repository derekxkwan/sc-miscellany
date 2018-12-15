// =====================================================================
// SuperCollider Workspace
// =====================================================================

Synth(\dxkCymb808_2);

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
var lpd_setlop, lpd_sethip, lpd_setdownsamp, lpd_setbitres, lpd_setpregain;
var lpd_setfb, lpd_setdelwet, lpd_setdelaytime, lpd_setdellop;
var lpd_mapvel = {arg ipt_vel;
	var vel_range = 127 - 70;
	var scaled_vel = ((max(ipt_vel - 70, 0)/vel_range) * 0.95) + 0.05;
	scaled_vel;
};

var lpd_createsynth = {arg idx, ipt_vel;
	var return_synth;
	var cur_buf = ~buf[idx];
	var scaled_vel = lpd_mapvel.value(ipt_vel);
	
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
~buf = Array.fill(8, {~japan1});

//chimes1
//~loc = [0.134, 0.235, 0.5505, 0.5, 0.56, 0.555, 0.91, 0.3505];
//~rate = [0.5, 1, 0.5, 0.5, 0.5, 0.5, 1, 1];


/*
MIDIdef.noteOn(\lpd8_noteon, {|vel, num, chan|
	var low_num = 36;
	var cur_idx = num - low_num;
	var cur_synth = lpd_createsynth.value(cur_idx, vel);

});
	*/

//drums ver
MIDIdef.noteOn(\lpd8_noteon, {|vel, num, chan|
	var low_num = 36;
	var switch_num = num - low_num;
	var real_vel = lpd_mapvel.value(vel);
	switch(switch_num,
		0, {Synth(\dxkBd3, [\amp, real_vel, \out, 30], addAction: \addToHead)},
		1, {Synth(\dxkSd2, [\amp, real_vel, \out, 30], addAction: \addToHead)},
		2, {Synth(\dxkHh1, [\amp, real_vel * 1.5, \out, 30], addAction: \addToHead)},
		3, {Synth(\dxkHh1, [\amp, real_vel * 1.5, \out, 30, \len, 0.5], addAction: \addToHead)},
		4, {Synth(\dxkBd2, [\amp, real_vel, \basefreq, 100, \out, 30], addAction: \addToHead)},
		5, {Synth(\dxkClap1, [\amp, real_vel, \out, 30], addAction: \addToHead)},
		6, {Synth(\dxkCowbell1, [\amp, real_vel, \out, 30], addAction: \addToHead)},
		7, {Synth(\dxkCymb808_2, [\amp, real_vel, \out, 30], addAction: \addToHead)}
	);
});
	
~decim_out = Synth(\dxkBitcrushS, [\in, 30, \out, 32, \downsamp, 1, \bitres, 24], addAction: \addToTail);
~delay_out = Synth(\dxkFbDellopCS, [\in, 32, \out, 34, \fb, 0.5, \wet, 0, \maxdelay, 2, \delaytime, 0.75, \lop, 1000, \delaylag, 0.01], addAction: \addToTail);
~clip_out = Synth(\dxkClipS, [\in, 34, \out, 36, \pregain, 1, \distort, 1], addAction: \addToTail);
~filt_out = Synth(\dxkHLPFS, [\in, 36, \out, 0], addAction: \addToTail);

lpd_setlop = {arg in_val;
	var min_freq = 100;
	var max_freq = 15000;
	var cur_range = max_freq - min_freq;
	var cur_val = linexp(in_val, 0, 127, min_freq, max_freq);
	~filt_out.set(\freq_hi, cur_val);


};

lpd_sethip = {arg in_val;
	var min_freq = 100;
	var max_freq = 15000;
	var cur_range = max_freq - min_freq;
	var cur_val = linexp(in_val, 0, 127, min_freq, max_freq);
	~filt_out.set(\freq_lo, cur_val);


};

lpd_setdownsamp = {arg in_val;
	var min_downsamp = 1;
	var max_downsamp = 24;
	var cur_val = linlin(in_val, 0, 127, min_downsamp, max_downsamp);
	~decim_out.set(\downsamp, cur_val);
};

lpd_setbitres = {arg in_val;
	var min_bitres = 8;
	var max_bitres = 24;
	var cur_range = abs(max_bitres - min_bitres);
	var map_val = 127 - in_val;
	var cur_val = linlin(map_val, 0, 127, min_bitres, max_bitres);
	~decim_out.set(\bits, cur_val);
};

lpd_setfb = {arg in_val;

	var cur_val = linlin(in_val, 0, 127, 0, 1);
	~delay_out.set(\fb, cur_val);
};


lpd_setdelaytime = {arg in_val;
	var min_delaytime = 0.001;
	var max_delaytime = 2;
	var cur_val = linlin(in_val, 0, 127, min_delaytime, max_delaytime);
	~delay_out.set(\delaytime, cur_val);
};

lpd_setdelwet = {arg in_val;

	var cur_val = linlin(in_val, 0, 127, 0, 1);
	~delay_out.set(\wet, cur_val);
};

lpd_setdellop = {arg in_val;
	var min_freq = 100;
	var max_freq = 5000;
	var cur_val = linexp(in_val, 0, 127, min_freq, max_freq);
	~delay_out.set(\lop, cur_val);


};

lpd_setpregain = {arg in_val;
	var min_pregain = 1;
	var max_pregain = 10;
	var cur_val = linlin(in_val, 0, 127, min_pregain, max_pregain);
	~clip_out.set(\pregain, cur_val);
};

lpd_setlop.value(127);
lpd_sethip.value(0);
lpd_setdownsamp.value(0);
lpd_setbitres.value(0);
lpd_setfb.value(0);
lpd_setdelaytime.value(127 * 0.75);
lpd_setdelwet.value(0);
lpd_setdellop.value(64);
lpd_setpregain.value(0);




MIDIdef.cc(\lpd8_cc, {|val, knob, ccNum|
	//[val, knob].postln;

	switch(knob,
		1, {lpd_setlop.value(val);},
		2, {lpd_sethip.value(val);},
		3, {lpd_setdownsamp.value(val);},
		4, {lpd_setpregain.value(val);},
		5, {lpd_setdelwet.value(val);},
		6, {lpd_setdellop.value(val);},
		7, {lpd_setfb.value(val);},
		8, {lpd_setdelaytime.value(val);}
	);
});
	
	

)


