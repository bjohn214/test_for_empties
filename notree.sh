#!/usr/bin/bash



k=0 #counts total number of empties

for item in 10 100 1000 50 500 5000; do #loop over each pionGun directory
	i=0                             #counts number of empties

	echo "Opening pionGun_$item now..."	

	outputFile='pionGun_'$item'_info.txt'
	echo -e 'The following .root files have no TTree:\n' > $outputFile

	directory="/collab/project/snowmass21/data/muonc/fmeloni/DataMuC_MuColl_v1/pionGun_$item/reco_k4/"	
        file_num=$(ls $directory | wc -l) #number of files in pionGun_(Something)/reco_k4 directory 

		
	rootls $directory/*.root  | paste -s -d" \n" | sort --version-sort | awk -F': ' '{print $2}' | awk '{print NF}'  > filter_rootls_output.txt       #opens files | condenses the two lines of output of each file to one | sorts by numerical value. --version-sort ensures that it doesn't go 0 10 100 110 ... | prints everything after colon | prints how many words are after the colon > outputs that number to a file  
	
	counter=0        #counter to keep track of each file
	while read line; do
		reco_count=$(echo $counter'*10' | bc)  #bc takes a string and does math 

		if [ $line = 1 ]; then      #if there's only one file in .root file
			i=$(($i+1))
			k=$(($k+1))
			echo '/collab/project/snowmass21/data/muonc/fmeloni/DataMuC_MuColl_v1/pionGun_'$item'/reco_k4/pionGun_'$item'_reco_'$reco_count'.root' >> $outputFile  #appends empty file names to the outputfile
		fi
		
		counter=$(($counter+1))
	done < filter_rootls_output.txt
	
	echo -e "This directory contains $i empty .root files out of $file_num \n$(cat $outputFile)" > $outputFile #writes string I want, then cats the rest of the .txt file then overwrites original file. 	
	
	rm filter_rootls_output.txt
	
	echo "There are $i out of 100 empty .root files in pionGun_$item"
	echo ""
done

echo "there are a total of $k empty files out of 600" 	
