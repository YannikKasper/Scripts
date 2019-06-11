echo password
read pass
if [ $pass = "hallo" ]
then 
echo "ok"
else
exit
fi
sudo fdisk -l
echo "Welche Platte willst du einhängen? BSP. sda2"
read z
mkdir -p /mnt/ntfs
sudo mount /dev/$z /mnt/ntfs
cd /
cd /mnt/ntfs/Windows/System32/config/
sudo chntpw -l SAM
echo welchen Benutzer?
read v
sudo chntpw -u "$v" SAM
cd /home
sudo umount /dev/$z/
echo "Neustart?  j/n"
read neu

if [ $neu = "j" ] 
then
sudo reboot
fi

