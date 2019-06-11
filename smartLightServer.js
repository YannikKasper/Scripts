var express = require('express');
var app = express();
var exec = require("child_process").exec;
anaus="aus"
whiskyLicht="aus"

console.log("test")

	app.use(function(req,res,next){
	
	res.header("Access-Control-Allow-Origin","*");
	res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  	next();
	
	})
	



	app.get('/an',function(req,res){

		exec("wiringPi/433.92-Raspberry-Pi/./send",function(error,stdout,stderr){

		})
		res.send("an")
		anaus="an"	
		console.log("An")
	})
	app.get('/aus',function(req,res){

		exec("wiringPi/433.92-Raspberry-Pi/./send -f",function(error,stdout,stderr){
	
		})
		anaus="aus"
		console.log("Aus")
		res.send("aus")
	})
	app.get('/anaus',function(req,res){
		console.log("anaus " + new Date())	
		if(anaus=="an"){
		
			exec("wiringPi/433.92-Raspberry-Pi/./send -f",function(error,stdout,stderr){})
			anaus="aus"
			res.send("aus")
		}else{
		
			exec("wiringPi/433.92-Raspberry-Pi/./send",function(error,stdout,stderr){})
			anaus="an"
			res.send("an")
		}
		
	})


	app.get('/whisky',function(req,res){
		if(whiskyLicht=="aus"){
			exec("python3 lampAn.py") 		
			whiskyLicht="an"
		}else{
	
			exec("python3 lampAus.py")
			whiskyLicht="aus"
		}
		res.send("whisky")	
	
	})
	

app.listen(8080)
