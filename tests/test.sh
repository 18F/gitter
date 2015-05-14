#! /bin/bash
# Usage: ./tests.sh

testFilesExist()
{
	assertTrue 'The readme was not found' "[ -f 'responses/18f/readme.md' ]"
	assertTrue 'The repository was not found' "[ -f 'responses/18f/18f.tar.gz' ]"
}

testLoadedToS3 ()
{
	HITS="$(s3cmd --config tests/s3.conf ls s3://test/18f/ | grep -c 18f.tar.gz )"
	assertEquals 1 $HITS
	
	HITS="$(s3cmd --config tests/s3.conf ls s3://test/18f/ | grep -c readme.md )"
	assertEquals 1 $HITS
}

oneTimeSetUp() {
	bash lib/fakes3init.sh start
	sleep 2
	export CONFIG="--config=tests/s3.conf"

	s3cmd --config tests/s3.conf mb s3://test
	bash gitter.sh tests/test.csv
}

oneTimeTearDown () {
	rm -rf responses/18f
	rm -rf /tmp/fakes3_root/test
}

. lib/shunit2