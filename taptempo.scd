~taptempo = {
	var time_now, cur_win, bpsbox, bpmbox, secbox, win, tap_button, tap_callback;
	time_now = AppClock.beats;
	tap_callback = {|evt|
		var cur_time = AppClock.beats;
		var time_since = cur_time - time_now;
		time_now = cur_time;
		secbox.value = time_since;
		bpsbox.value = 1.0/time_since;
		bpmbox.value = 1.0/time_since * 60.0;
	};
	cur_win = Window.new("taptempo", Rect(50, 500, 200, 200));
	secbox = EZNumber(cur_win, Rect(0, 0, 200, 30),"sec", ControlSpec(0,99999),initVal: 1);
	bpsbox = EZNumber(cur_win, Rect(0, 30, 200, 30),"bps", ControlSpec(0,99999),initVal: 1);
	bpmbox = EZNumber(cur_win, Rect(0, 60, 200, 30),"bpm", ControlSpec(0,99999),initVal: 60);
	tap_button = Button(cur_win, Rect(0, 100,2000,100));
	tap_button.states = [["TAP", Color.black, Color.green]];
	tap_button.action = {|evt| tap_callback.value(evt)};
	

	cur_win.front;

};


