#! /bin/bash
# Usage: ./tests.sh

testFileExists()
{
	assertTrue 'The files were not found' "[ -f 'responses/18f.tar.gz' ]"
}

testLoadedToS3 ()
{
	HITS="$(s3cmd --config tests/s3.conf ls s3://test | grep -c 18f.tar.gz )"
	assertEquals 1 $HITS
}

oneTimeSetUp() {
	bash lib/fakes3init.sh start
	sleep 2
	export TEST=True

	s3cmd --config tests/s3.conf mb s3://test
	bash gitter.sh tests/test.csv
}

oneTimeTearDown () {
	rm responses/18f.tar.gz
	s3cmd --config tests/s3.conf del s3://test/18f.tar.gz
	s3cmd --config tests/s3.conf rb s3://test
	cat /tmp/fakes3.pid | xargs kill -9
}

. lib/shunit2