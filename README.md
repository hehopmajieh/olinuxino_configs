#OLinuXino Configs  
=======================

 Configurations are ordered by Board name :
 > For. ex :   
 > * A20-OLinuXino-MICRO
 >  + Android - Android Configs/Tutorials
 >  + Linux   - Linux Configs/Tutorials 
 >  + Tools   - Additional tools 


##A20-OLinuXino-MICRO & A20-OLinuXIno-LIME2 & A20-OLinuXIno-LIME
--------------------------------------------------  

### Android:  
+ Installing required packages /Ubuntu or Debian, tested on ubuntu 12.04/ :
  You can follow official google documentation : [Google Link]
  [Google Link]: <http://source.android.com/source/initializing.html> 
			  

+  Getting Sources
      Sources are available by BitTorrent. Links to Source Archives :  
      + Android Source by Allwinner: [Android Link]
      + Lichee Sources             : [Lichee Link]  
      + BSP for A20 Board          : [BSP Link]         


  [Android Link]: <https://www.olimex.com/wiki/images/f/fd/Android4.2-v3.0.torrent>    
  [Lichee Link]: <https://www.olimex.com/wiki/images/0/0c/Lichee-v3.0.torrent>
  [BSP Link]: <https://github.com/hehopmajieh/olinuxino_configs/raw/master/A20-OLinuXino-MICRO/Android/olinuxino-a20.tgz>

+ Extracting & Building
 ```bash
  $ mkdir ~/allwinner
  $ cd ~/allwiiner
  $ tar zxfv Android*.tar.gz
  $ tar zxfv Lichee*.tar.gz
  $ cd lichee
  $ ./build.sh -psun7i_android #If you want to change some kernel config options 
                               #before running build.shcd linux-3.4 
                               # and run kernel menuconfig ex. <make menuconfig>
  $ cd ../android4.2
  $ cd device/softwinner/ 
  $ tar zxfv olinuxino-a20.tgz # Refer to Download location
  $ cd ../../
  $ source build/envsetup.sh
$ lunch #select olinuxino-a20_eng
$ extract-bsp
$ make -j4                              
    ```

+ Notes
  According to you board version /with or w/o NAND/, you must schange default 
  fex file, located at :
    ```sh
    lichee/tools/pack/chips/sun7i/configs/android/
    ```
  You can use files provided by pack.tgz in Android Directory, or manualy to change fex file "storage_type" parameter
to 1 ex. 

    ```sh
    storage_type = 1
    ```
 storage_type: 0 = nand, 1 = SDCard, 2 = SPI-nor


 Reference: http://linux-sunxi.org/Fex_Guide
### Linux:

+ Linux Configurations
	Linux Configurations can be found in Linux directory

Build Linux Kernel and Bootloader:

https://github.com/OLIMEX/OLINUXINO/tree/master/SOFTWARE/A20/A20-build

