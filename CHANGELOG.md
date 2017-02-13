commerce-contractor-management CHANGELOG
==============================
This file is used to list changes made in each version of the commerce-contractor-management cookbook.

0.5.9
-----
- Carl Eichhorn - updated the cookbook to use ruby-deployment v 4.3.0 and gd-base-linux 3.2.4

0.5.8
-----
- William Spencer - updated the cookbook to use ruby-deployment v 4.2.1

0.5.7
-----
- Alfred Macaraeg - updating env variables to not include secrets since those are being pulled in via s3 now

0.5.6
-----
- William Spencer - changed the nginx port to be a default attribute

0.5.5
-----
- William Spencer - updated the cookbook to use ruby-deployment v 2.4.0

0.5.4
-----
- Alfred Macaraeg - parameterizing attributes to be generic

0.5.3
-----
- William Spencer - updated the cookbook to use ruby-deployment v 2.3.0 and set the appropriate data elements

0.5.2
-----
- Carl Eichhorn  - Modified datadog settings to use variables instead of hard coded..

0.5.1
-----
- William Spencer - bumping the version of the ruby-deployment cookbook used to 2.0.0

0.5.0
-----
- Alfred Macaraeg  - Including datadog content checks and process checks.

0.4.1
-----
- Alfred Macaraeg  - Updating changelog and metadata to reflect changes made by commerce solutions.

0.3.1
-----
- Carl Eichhorn  - Fixed pinned versions and dependancies, updated splunk helper.

0.2.3
-----
- Jim Moore - Added port forward to .kitchen.yml, link to documentation, removed unnecessary config.

0.2.2
-----
- Alfred Macaraeg - Adding serverspec test back in.  Removed gd-test-helper pin.  Updated yml files.

0.1.2
-----
- Alfred Macaraeg - Adding additional datadog attributes.

0.1.1
-----
- Alfred Macaraeg - Removing serverspec test that's failing in Jenkins PR test but not locally.

0.1.0
-----
Initial release of commerce-contractor-management
