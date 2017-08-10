#!/usr/bin/env bash

# Get latest tag for Express repo
git fetch --tags
OUTPUT="$(git describe --tags `git rev-list --tags --max-count=1`)"
echo "${OUTPUT}"

# Checkout that release. The bundle will be deployed to prod with the latest Express release.
git checkout $OUTPUT

# If latest tag file does not exist, then create one and install site.
if [ ! -f $HOME/cache/latest-tag.txt ]; then
    echo "Latest tag not found!"

    touch $HOME/cache/latest-tag.txt
    echo "${OUTPUT}" >> $HOME/cache/latest-tag.txt
    echo "Latest tag saved."

    drush si express --db-url=mysql://root:@127.0.0.1/drupal --account-name=admin --account-pass=admin --site-mail=admin@example.com --site-name="Express" express_profile_configure_form.express_core_version=cu_testing_core --yes
    drush sql-dump --result-file=$HOME/cache/express.sql
    echo "Backup exported."

# If the tag does exist, check to see if the latest tag is the same.
else
    echo "Latest tag file found!"
    latestTag=`cat $HOME/cache/latest-tag.txt`

    # Check if tags match
    if [ "$latestTag" =  "$OUTPUT" ]; then
        echo "Tags match."

        drush sql-cli < $HOME/cache/express.sql
        echo "Backup imported."
    else
        echo "Tags do not match."

        drush si express --db-url=mysql://root:@127.0.0.1/drupal --account-name=admin --account-pass=admin --site-mail=admin@example.com --site-name="Express" express_profile_configure_form.express_core_version=cu_testing_core --yes
        drush sql-dump --result-file=$HOME/cache/express.sql
        echo "Backup exported."

        rm $HOME/cache/latest-tag.txt
        touch $HOME/cache/latest-tag.txt
        echo "${OUTPUT}" >> $HOME/cache/latest-tag.txt
        echo "Latest tag saved."
    fi
fi
