## These variables are defaults.
NP=36
NODES=1
RUN_JOB=srun -n $(NP) -N $(NODES)
LSQPYFLAGS=--mpistyle=srun
ifeq ($(hosttype),UT-TACC)
	RUN_JOB=ibrun
	LSQPYFLAGS=--mpistyle=ibrun
endif
PYTHON=python3 # /usr/tce/bin/python
COMPARE=perl ../../contrib/compare/compare.pl
DLARS_PATH=../../contrib/dlars/src/

cleancurr:
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	rm -f current_output/*

clean:
	rm -f A.txt A.0*.txt b.txt dim.0*.txt params.*.txt *.cmp *.out params.header ff_groups.map

cleangen: clean
	rm -rf correct_output
	mkdir correct_output


# Don't run lasso test by default.  Takes too long, get poor result.
all: cleancurr A.txt svd lassolars dlars ridge ridgecv 
	

all-gen: cleancurr cleangen A.txt svd-gen lassolars-gen dlars-gen ridge-gen ridgecv-gen

generate: all-gen
	cp current_output/* correct_output/
	 

A.txt:
	$(RUN_JOB) ../../build/chimes_lsq fm_setup.in >fm_setup.out
	cp A*txt b*txt params*header fm_setup.out current_output

A.0000.txt:
	$(RUN_JOB) ../../build/chimes_lsq fm_setup.split.in >fm_setup.split.out
	cp A*txt b*txt params*header fm_setup.out current_output

%.cmp : %.txt
	$(COMPARE) current_output/$*.txt correct_output/$*.txt > $*.cmp
	
	
svd-gen: params.svd.1.0e-04.txt params.svd.1.0e-05.txt params.svd.weight.txt

lassolars-gen: params.lassolars.1.0e-04.txt

owlqn-gen: params.owlqn.1.0e-03.txt

dowlqn-gen: params.dowlqn.1.0e-04.txt params.dowlqn.split.txt

ridge-gen: params.ridge.1.0e-03.txt

ridgecv-gen: params.ridgecv.txt

lasso-gen: params.lasso.txt

dlars-gen: params.dlars.1.0e-04.txt params.dlasso.1.0e-04.txt params.dlasso.norm.txt params.dlasso.read.txt


	

svd: params.svd.1.0e-04.cmp params.svd.1.0e-05.cmp params.svd.weight.cmp

lassolars: params.lassolars.1.0e-04.cmp

owlqn: params.owlqn.1.0e-03.cmp

dowlqn: params.dowlqn.1.0e-04.cmp params.dowlqn.split.cmp

ridge: params.ridge.1.0e-03.cmp

ridgecv: params.ridgecv.cmp

lasso: params.lasso.cmp

dlars: params.dlars.1.0e-04.cmp params.dlasso.1.0e-04.cmp params.dlasso.norm.cmp params.dlasso.read.cmp

params.lasso.txt : A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=lasso --alpha=1.0e-04 >params.lasso.txt	
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.lasso.txt current_output/

params.ridgecv.txt : A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=ridgecv >params.ridgecv.txt	
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.ridgecv.txt current_output/

params.svd.weight.txt : A.txt weights.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=svd --weights=weights.txt >params.svd.weight.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.svd.weight.txt current_output/

params.ridge.1.0e-03.txt: A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=ridge --alpha=1.0e-03 >params.ridge.1.0e-03.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.ridge.1.0e-03.txt current_output/

params.lassolars.1.0e-04.txt: A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=lassolars --alpha=1.0e-04 >params.lassolars.1.0e-04.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.lassolars.1.0e-04.txt current_output/

params.owlqn.1.0e-04.txt: A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=owlqn --alpha=1.0e-04 >params.owlqn.1.0e-04.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.owlqn.1.0e-04.txt current_output/

params.owlqn.1.0e-03.txt: A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=owlqn --alpha=1.0e-03 >params.owlqn.1.0e-03.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.owlqn.1.0e-03.txt current_output/

params.dowlqn.1.0e-04.txt: A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=dowlqn --cores=$(NP) --nodes=$(NODES) --alpha=1.0e-04 --tol=1.0e-04 --memory=30 $(LSQPYFLAGS) >params.dowlqn.1.0e-04.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.dowlqn.1.0e-04.txt current_output/

params.dowlqn.split.txt: A.0000.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=dowlqn --cores=$(NP) --nodes=$(NODES) --alpha=1.0e-04 --tol=1.0e-04 --memory=30 --split_files=true $(LSQPYFLAGS) >params.dowlqn.split.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.dowlqn.split.txt current_output/

params.dowlqn.beta.txt: A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=dowlqn --cores=$(NP) --nodes=$(NODES) --alpha=1.0e-04 --tol=1.0e-06 --memory=30 --beta=1.0e-02 $(LSQPYFLAGS) >params.dowlqn.beta.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.dowlqn.beta.txt current_output/

params.svd.1.0e-04.txt: A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=svd --eps=1.0e-04 >params.svd.1.0e-04.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.svd.1.0e-04.txt current_output/

params.svd.1.0e-05.txt: A.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=svd --eps=1.0e-05 >params.svd.1.0e-05.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.svd.1.0e-05.txt current_output/

params.dlars.1.0e-04.txt: A.0000.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=dlars --dlasso_dlars_path=${DLARS_PATH} --alpha=1.0e-04 --cores=$(NP) --nodes=$(NODES) --split_files=true --normalize=false $(LSQPYFLAGS) >params.dlars.1.0e-04.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.dlars.1.0e-04.txt current_output

params.dlasso.1.0e-04.txt: A.0000.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=dlasso --dlasso_dlars_path=${DLARS_PATH} --alpha=1.0e-04 --cores=$(NP) --nodes=$(NODES) --split_files=true --normalize=false $(LSQPYFLAGS) >params.dlasso.1.0e-04.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.dlasso.1.0e-04.txt current_output

params.dlasso.norm.txt: A.0000.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=dlasso --dlasso_dlars_path=${DLARS_PATH} --alpha=1.0e-04 --cores=$(NP) --nodes=$(NODES) --split_files=true --normalize=true $(LSQPYFLAGS) >params.dlasso.norm.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.dlasso.norm.txt current_output

params.dlasso.read.txt: A.0000.txt params.dlasso.norm.txt
	$(PYTHON) ../../src/chimes_lsq.py --algorithm=dlasso --dlasso_dlars_path=${DLARS_PATH} --alpha=1.0e-04 --cores=$(NP) --nodes=$(NODES) --split_files=true --normalize=true --read_output=true $(LSQPYFLAGS) >params.dlasso.read.txt
	if [ ! -d current_output ] ; then mkdir current_output ; fi
	mv params.dlasso.read.txt current_output

