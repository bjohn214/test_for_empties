from pyLCIO import IOIMPL

reader = IOIMPL.LCFactory.getInstance().createLCReader()

total = 0
for k in [10, 50, 100, 500, 1000, 5000]:

	directory='/collab/project/snowmass21/data/muonc/fmeloni/DataMuC_MuColl_v1/pionGun_'+str(k)+'/reco/'
	print('Opening pionGun_'+str(k)+' now...')	
	empty_list = []
	empty_counter = 0	

	for j in range(0,1000,10):
		
		slcio_file = directory + 'pionGun_'+str(k)+'_reco_' + str(j) + '.slcio'		
		fileo = open("pionGun_"+str(k)+"_empty_counter.txt","w")
		reader.open(slcio_file)

		i=0
		for event in reader:
			i += 1

		if i == 0:
			empty_list.append(slcio_file+"\n")	
			empty_counter += 1
			
	total += empty_counter
	print('pionGun_'+str(k)+' has '+str(empty_counter)+' empty files')
	print() 

	fileo.write("This directory contains "+str(empty_counter)+ " empty files \n")
	fileo.writelines(empty_list)
	fileo.close()	

print(str(total)+' total empty files out of 600')
