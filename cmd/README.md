


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
