#!/bin/bash

BASEDIR=`pwd`
WORKINGDIR=".deploy"
STAGEDIR="icanhazrandomnumber"
HOST="binarylionstudios.com"
TARFILE="icanhazrandomnumber.tar"
GZTARFILE="${TARFILE}.gz"

vagrant ssh <<ENDSSH
cd /vagrant/icanhazrandomnumber
cabal build
ENDSSH

mkdir $WORKINGDIR
pushd $WORKINGDIR
mkdir $STAGEDIR
cp $BASEDIR/dist/build/icanhazrandomnumber/icanhazrandomnumber $STAGEDIR/
cp -r $BASEDIR/static $STAGEDIR
tar cvvf $TARFILE $STAGEDIR
gzip $TARFILE
scp $GZTARFILE $HOST:/var/www
ssh $HOST <<ENDSSH
pushd /var/www
tar xzvf $GZTARFILE
pushd $STAGEDIR
nohup ./icanhazrandomnumber &
popd
rm $GZTARFILE
popd
ENDSSH
popd
rm -rf $WORKINGDIR
