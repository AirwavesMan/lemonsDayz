Global minx#
Global miny#
Global maxx#
Global maxy#
Global count

minx=Input(">Enter the Min X position.")
maxx=Input(">Enter the Max X position.")

miny=Input(">Enter the Min Y position.")
maxy=Input(">Enter the Max Y position.")

count=Input("Enter amount to create")


fileout = WriteFile("chopperlist.txt")
	
	WriteLine(fileout,"		_staticcoords =	[")
	
	For loop=1 To count
		nx# = Rnd(minx#,maxx#)
		ny# = Rnd(miny#,maxy#)
		
		WriteLine( fileout,"							["+nx+","+ny+"]")
	Next
	
	WriteLine(fileout,"		]")
	CloseFile( fileout )
	
	Print "Created "+count+" new co-ords and saved them as chopperlist.txt"
	Print "Hit anykey to close."
	WaitKey()