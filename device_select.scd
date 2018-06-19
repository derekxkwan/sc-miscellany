~device_select = {
var w = Window.new.front;
var in_ch = EZNumber(w, Rect(0,0,150,20), "in_ch",ControlSpec.new(0,64,\lin,1),
	{|ez| var val = ez.value;  s.options.numInputBusChannels = val;},
	2,
	true).setColors(Color.grey,Color.white);
var out_ch = EZNumber(w, Rect(0,30,150,20), "out_ch",ControlSpec.new(0,64,\lin,1),
	{|ez| var val = ez.value;  s.options.numOutputBusChannels = val;},
	2,
	true).setColors(Color.grey,Color.white);

};