import time
import Adafruit_GPIO.SPI as SPI
import Adafruit_MCP3008
import Adafruit_DHT
import requests

# Hardware SPI configuration:
SPI_PORT   = 0
SPI_DEVICE = 0
mcp = Adafruit_MCP3008.MCP3008(spi=SPI.SpiDev(SPI_PORT, SPI_DEVICE))
sensor = Adafruit_DHT.AM2302


def calibration():
    min = [0.0,0.0,0.0]
    max = [0.0,0.0,0.0]
    value = [0.0,0.0,0.0]

    print("Starte Kalibration")
    for i in range(0,50):
        if i<=25:
            print("Sensor trocken halten")
        else:
            print("Sensor in Wasser tunken")
        for z in range(0,3):
            value[z]=getValue(z)
            if (min[z]==0 or value[z] < min[z]) and value[z]!=0:
                min[z]=value[z]
            elif max[z]==0 or value[z] > max[z]:
                max[z]=value[z]
        time.sleep(1)
    return min,max

#get value of the first sensor
def getValue(z): 
    return  mcp.read_adc_difference(z)

def main():
    import RPi.GPIO as GPIO
    GPIO.setmode(GPIO.BCM)
    GPIO.setup(12,GPIO.IN)
    min =[0.0,0.0,0.0]
    max =[0.0,0.0,0.0]
    min,max = calibration()
    
    light = GPIO.input(12)
    diff=[0.0,0.0,0.0]
    sensors= [0.0,0.0,0.0]
    while True:
        for y in range (0,3):
            diff[y] = max[y]-min[y]
            sensors[y] = round(float(max[y] - getValue(y))/float(diff[y])*100,2)
            print "Sensor "+str(y), sensors[y], "% feucht"
        
        print "Licht", GPIO.input(12)
        humidity, temperature = Adafruit_DHT.read_retry(sensor, 4)
        print 'Temperatur={0:0.1f}*C  Luftfeuchtigkeit={1:0.1f}%'.format(temperature, humidity)
        try:
		jsonrequests = requests.post(
            	'http://192.168.179.146:8080',
            	json={
                	"groupKey": "sensoricus",
                	"values": {
                    	"light": GPIO.input(12),
                    	"humi_temp": 'Temperatur={0:0.1f}*C  Luftfeuchtigkeit={1:0.1f}%'.format(temperature, humidity),
                    	"sensor1": str(sensors[0]),
                    	"sensor2": str(sensors[1]),
                    	"sensor3": str(sensors[2])
                	}
            	},timeout=5)
	except:
		print "Connection not working"
        time.sleep(5)

if __name__=="__main__":
    main()
