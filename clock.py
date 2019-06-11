import datetime
import time

while(1 == 1):
    now = datetime.datetime.now()
    print("{0:08b}".format(now.hour)[3:] + ":" +
          "{0:08b}".format(now.minute)[2:], end="\r")
    time.sleep(5)
