// a simple sound loader

~sndload = {
FileDialog.new(
	{|paths|
			if( b.class != Array, {b = [];});
		paths.do({|path|
			b = b.add(Buffer.read(s,path));
		});
	});
	b.postln;
};