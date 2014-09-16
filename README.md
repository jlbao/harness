Useful Commands: (Password: vagrant)

Copy local harness directory into virtual box: 
	scp -r -P 2222 harness vagrant@127.0.0.1:/home/vagrant

ssh to virtual box:
	ssh -l vagrant -p 2222 127.0.0.1	

Install tree command: (This can help to view the directories more clearly)
	sudo apt-get install tree



Harness Usage Requirement:

After ssh into the virtual box, please execute the following commands first before starting the harness. They are used to config the specific environment.

The following commands is to install the latest ruby in order that the ruby lib my code used are valid.
sudo apt-get install curl
\curl -L https://get.rvm.io | bash -s stable --ruby --autolibs=enable --auto-dotfiles
source /home/vagrant/.rvm/scripts/rvm

The following commands is to link /bin/sh to /bin/bash
sudo mv /bin/sh /bin/sh.orig
sudo ln -s /bin/bash /bin/sh

Make sure you get into harness directory

After running the ./init command, it will generate all directories. Please make sure that you put your test files into the test/new directory. (Attention: the extension of the test files should be .test)


C grade Requirement:

Initialize the test harness: (create all directories)
./init

Reinitialize / restart the test harness
./restart-harness

Run all tests: (Run all files, and put them into unclassified directory )
./run-all

Run one or more specific tests: (Run one or several files, and put them into unclassified directory )
./run [test name …]
example: ./run test_hello_assembler test_hello_executes

Classify tests, that is specify whether one or more tests should be classified, failed, etc
./pass [test name …]
example: ./pass test_hello_assembler test_hello_executes

./fail [test name …]
example: ./fail test_hello_assembler test_hello_executes


B grade Requirement:

Report on the last execution of the test harness (e.g., how many tests passed, how many failed, how many are unclassified, etc.).
./report -l  or report -list

Allow the classification of all unclassified tests with one command. For example, if you have 50 tests and 8 have changed and are unclassified, you should be able to run a command such as "pass all" that would classify all of the unclassified tests as having passed.
./pass-all
./fail-all

A grade Requirement:

Provide a report of all test runs that have been run since the initialization, or reinitialization, of the harness.
./report -a  or  ./report -all

Provide a report on the history of a specific test or set of tests.
./report -f [test name …]
example: ./report -f test_hello_assembler

Provide a command that clearly shows the difference between a previous result and the current result.
./report -diff

Provide a command that will "print out" a specific test for viewing.
./print [test name]
example: ./print test_hello_assembler