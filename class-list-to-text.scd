//one liner to write all classes installed as list to a file (haven't figured out how to get rid of quotes yet)
//written for making a dict file for emacs' auto-complete plugin

Class.allClasses.collect({|i| i.asString;}).join("\n").writeArchive(PathName.new("~/scclasslist.txt").fileName);
