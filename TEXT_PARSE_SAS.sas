%Let fpath = C:\Path\To\Working\Directory;

** READ IN TEXT;
data TXTdata;
    infile "&fpath\TEXT\Input.txt" truncover;
    input Line $255.;
run;

** CLEANING OUT SPECIAL CHARACTERS;
data TXTdata;
	set TXTdata;
	pattern_num=prxparse("s/[^A-Za-z]/ /"); 
	NewLine=prxchange(pattern_num, -1, Line); 

	NewLine = strip(tranwrd(tranwrd(tranwrd(NewLine, "      ", ""), "  ",""), "  ",""));
	NewLine = strip(tranwrd(tranwrd(NewLine, "o er", "o'er"), " s ","'s "));
	if NewLine ~= "";
run;

** OUTPUT PARSED FILE;
data _null_ ;         
    set Work.TXTdata ;
    FILE  "&fpath\TEXT\Output_SAS.txt";
    PUT NewLine;
run ;
