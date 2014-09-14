Attached to this assignment is a partial regression test harness written in Ruby. The purpose of this harness is to give you an example of how a harness, like the one I demonstrated in class, might be structured. There are only two commands in this harness, "restart-harness" and "run-new". The first command moves all existing tests into the test/new directory while the second one will run any tests in the test/new directory and move them and the results into the appropriate unclassified directories.
Your job is to create a regression test harness in any language that you choose. You will implement at least the following capabilities:
Initialize the test harness.
Reinitialize/restart the test harness.
Run all tests.
Run one or more specific tests.
Classify tests, that is specify whether one or more tests should be classified as passed, failed, etc.
If you do the minimum, you will receive a grade of 'C' (approximately 75 points). To receive a grade of 'B' (approximately 85 points) you need to additionally do the following:
Report on the last execution of the test harness (e.g., how many tests passed, how many failed, how many are unclassified, etc.).
Allow the classification of all unclassified tests with one command. For example, if you have 50 tests and 8 have changed and are unclassified, you should be able to run a command such as "pass all" that would classify all of the unclassified tests as having passed.
If you implement the features to receive a 'B', you can implement at least three of the following capabilities to receive a grade of 'A' (approximately 95 points):
Provide a report of all test runs that have been run since the initialization, or reinitialization, of the harness.
Provide a report on the history of a specific test or set of tests.
Provide a command that clearly shows the difference between a previous result and the current result.
Provide a command that will "print out" a specific test for viewing.
Add a tag to tests so that you have the ability to run only tests that contains a specific tag.
After running some tests you decide that something was not done correctly (perhaps you typed in the wrong program to run, the environment was not correct, etc.) allow the user to revert the harness to the state before the tests were run. You may need to constrain this to only allowing the harness reverting before any of the tests that were run have been classified.
You need to write a documment (either text, PDF, or Microsoft Word) that provides instructions for installing your harness and running the commands. Your harness should run on the Linux box that has been provisioned for this class using the Vagrantfile and cs562-bootstrap.sh files that I have provided (see the Course Materials section of these pages). 
You will zip your harness and documentation into an archive file and submit it to this assignment. I will allow you three submissions before the due date. Your last one is the one that will be graded. I do not accept late submissions.
