count=0
dir=`pwd`
echo "The present directory is $dir"
read -p "Do you want to change the directory  1->Yes 0->No  Option:  " opt
if [ $opt == 1 ]
then
	while [ $count -eq 0 ]
	do
		cd ~
		read -p "Enter the directory    "  dir
		if [ -d "$dir" ]
		then
			echo "Directory Exists"
			cd $dir
			echo "Directory changed to $dir   "
				count=1
			else
				        echo "Error!Directory Does Not Exist"
					count=0
					echo "Try again"
				fi
			done
		fi
printf " \n"		
read -p "Enter the name of the file to be compressed and encrypted:  " llist
	filename=file


#
printf "\n Press \n 1 for all possible different formats \n 2 for steganography with password(symmetric) \n 3 for steganography with password(asymmetric) \n 4 for steganography without password \n Enter Choice: "
read mmainopt
###
if [ $mmainopt -eq 1 ]
then
	printf " \n"
	echo "Choose from one of the below file formats"
	printf "1-> ZIP(.zip) \n2-> TAR(.gz) \n3-> TAR(.tar) \n4-> TAR(.tbz) \n5-> BZIP2(.bz2) \n6->GZip(.gz)\n"
	read -p "Enter your option :  " num
	case $num in
		1)
		       	zip -e $filename.zip $llist
       			editedfile=$filename.zip
       			#multiple files
       			#with password
			;;
		2) 
		       	rar a $llist.rar $llist
       			editedfile=$llist.rar
       			#multiple files
       			#with password
       			#autogenerated password also possible
			;;
		3) 
			tar -cvf $filename.tar $llist
			editedfile=$filename.tar
			#no password
			;;
		4) 
			tar -cjvf $filename.tbz $llist
	       		editedfile=$filename.tbz
			#no password
	       		;;
		5) 
			bzip2 $llist
			editedfile=$llist.bz2
			#single file
			#no password
		       	;;
		6)
			gzip $llist
			editedfile=$llist.gz
			#single file
			#no password
		       	;;
		*) echo "Invalid"
			;;
	esac


#######

elif [ $mmainopt -eq 2 ]
then
       	printf " \n STEGANOGRAPHY WITH SYMMETRIC PASSWORD\n"             
                        zip -e $filename.zip $llist
                        editedfile=$filename.zip
                        #multiple files
                        #with password
			

elif [ $mmainopt -eq 3 ]
then
	        printf " \n STEGANOGRAPHY WITH ASYMMETRIC PASSWORD\n"
		read -p "Enter the password: " apassword
		apasswd=`openssl passwd $apassword`
		printf "\n \n"
		echo "Please note down the password & enter is below:"
		echo -e "\e[0;34m $apasswd \e[0m"
		printf "\n \n"
		echo $apasswd >> stegkey.txt
		zip -e $filename.zip $llist
		editedfile=$filename.zip
                mv -t ~/ stegkey.txt
		#multiple files
		#with password
		#autogenerated password also possible
		

########################
else 

        printf " \n STEGANOGRAPHY WITHOUT PASSWORD\n"
        echo "Choose from one of the below file formats"
        printf "1-> ZIP(.zip) \n2-> TAR(.rar) \n3-> TAR(.tar) \n4-> TAR(.tbz) \n5-> BZIP2(.bz2) \n6->GZip(.gz)\n"
        read -p "Enter your option :  " num
        case $num in
                1)
                        zip $filename.zip $llist
                        editedfile=$filename.zip
                        #multiple files
                        #with password
                        ;;
                2)
                        rar a $filename.rar $llist
                        editedfile=$filename.rar
                        #multiple files
                        #with password
                        #autogenerated password also possible
                        ;;
                3)
                        tar -cvf $filename.tar $llist
                        editedfile=$filename.tar
                        #no password
                        ;;
                4)
                        tar -cjvf $filename.tbz $llist
                        editedfile=$filename.tbz
                        #no password
                        ;;
                5)
                        bzip2 $llist
                        editedfile=$llist.bz2
                        #single file
                        #no password
                        ;;
                6)
                        gzip $llist
                        editedfile=$llist.gz
                        #single file
                        #no password
                        ;;
		*)
			echo "Invalid"
	esac

fi
#######
																																																																																																									cd ~
mkdir steganography
cd $dir
mv -t ~/steganography $editedfile
#

read -p "Is the image file located in the current directory  1->Yes  2->No   Enter Choice: " imgopt
if [ $imgopt -eq 1 ]
then
	printf "/n"
else
	countimg=0
	while [ $countimg -eq 0 ]
	do
		cd ~
		read -p "Enter the directory location of the image:  "  dirimg	
		if [ -d "$dirimg" ]
		then
			echo "Directory Exists"						
			countimg=1
		else
			echo "Error!Directory Does Not Exist"
			countimg=0
			echo "Try again"
		fi
	done
	cd $dirimg
fi
	echo "The image files in this directory are:"
	ls | grep -i -e ".gif" -e ".jpg" -e ".jpeg" -e ".bmp" -e ".raw" -e ".png"
	read -p "Enter the image file name:  " imgname
	newimgname=steg$imgname
	cp $imgname $newimgname
mv -t ~/steganography $newimgname
#

cd ~/steganography
cat $newimgname $editedfile > $imgname
mv -t ~/ $imgname
rm $newimgname
rm $editedfile
cd ~
rmdir steganography
if [ $mainopt -eq 3 ]
then
	printf "The Asymmetric password is stored in the text file stegkey.txt"
fi
sleep 1.5s
nautilus ~

