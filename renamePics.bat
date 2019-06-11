@echo off
setlocal enabledelayedexpansion	
Set /A count=1


for /f "tokens=*" %%A IN ('dir /B *.jpg *.png') do (
	set formatValue=0000!count!
	set file=%%A
	set typ=!file:~-4!
	set newfile=img!formatValue:~-3!!typ!
	ren !file! !newfile!
	set /A count+=1

	)

