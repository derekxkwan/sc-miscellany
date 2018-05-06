//a way to load and execute all files within a directory matching certain parameters
//here i'm loading everything i have in my dxkSynthDefs repo
{
	var path, files;
	path = "/home/user/dxkSynthDefs/";
	files = pathMatch(path ++ "dxk*.scd") ++ pathMatch(path ++ "not*.scd");
	files.size.postln;
	files.do({|curfile|
		this.executeFile(curfile);
	});
}.value;
