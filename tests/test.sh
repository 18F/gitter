#! /bin/bash
# Usage: ./tests.sh

testFileExists()
{
	assertTrue 'The files were not found' "[ -f 'responses/18f.tar.gz' ]"
}

oneTimeSetUp() {
	bash gitter.sh tests/test.csv
}


tearDown () {
	rm responses/18f.tar.gz
}

. lib/shunit2