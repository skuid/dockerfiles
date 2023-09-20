#!/bin/bash
if ! command -v envsubst &> /dev/null
then
	echo "This script requires envsubst from package gettext."
	exit 1
fi

# get a comma-separated list of environment variables that are replaceable
ENVVARS=$(awk 'BEGIN{for(v in ENVIRON) print "$" v}' |paste -sd "," -)

# input directory
INDIR=$1
if [ -z $INDIR ]
then
	INDIR=/tmp/templates
fi
if [ ! -d $INDIR ]
then
	mkdir $INDIR
fi

# if there are template files, process them
COUNT=`ls -1 $INDIR/*.template |wc -l`
if [ $COUNT -gt 0 ]
then
	OUTDIR=$2
	if [ -z $OUTDIR ]
	then
		OUTDIR=/tmp
	fi
	if [ ! -d $OUTDIR ]
	then
		mkdir $OUTDIR
	fi

	# loop over template files
	for i in $INDIR/*.template
	do
		NEWNAME=$(basename $i ".template")	
		DEST="$OUTDIR/$NEWNAME"

		# read the first line of the template
		read -r DEST_COMMENT<$i
		# if we have a comment in the first line that starts with #dest, then the rest is the output path
		if [[ $DEST_COMMENT == \#dest* ]] 
		then
		  DEST=${DEST_COMMENT:6}
		fi
		DESTFOLDER=`dirname $DEST`
		if [ ! -d $DESTFOLDER ]
		then
			mkdir $DESTFOLDER
		fi

		# substitute everything appearing in $ENVVARS in the template
		cat $i | envsubst "$ENVVARS" > $DEST
	done
fi

exec nginx -c /etc/nginx/nginx.conf
