
## [svn tagging auto](http://developerautomation.com/jenkins-job-automate-svn-tagging/)

```shell
VERSION_TAG=my_special_version-${VERSION}
FROM=${BASE_PATH}/trunk
TO=${BASE_PATH}/tags/${VERSION_TAG}
svn copy ${FROM} ${TO} --username ${SVN_USER} --password ${SVN_PASS} -m "Creating ${TO} from ${FROM}"
```

## svnlook
### svnlook history
```
svnlook history -r 100 D:\project\svn\test --show-ids
```


## svn
### svn commit
```
D:\project\svn\checkout>svn commit -m "test"
Sending        branches\develop\status_check_fass_v5.sh
Transmitting file data .done
Committing transaction...
Committed revision 122.
```
### svn diff
```
D:\project\svn\test>svnlook diff -r 122 D:\project\svn\test --no-diff-added --no-diff-deleted --ignore-properties
```
