

### SVN BOOK
http://svnbook.red-bean.com/
http://svnbook.red-bean.com/en/1.7/svn-book.pdf

### SVN 세팅
https://taisou.tistory.com/130


### SVN 서버 윈도우세팅
svnadmin create C:\svn\window

sc create svn binpath= "\"C:\Program Files (x86)\Subversion\bin\svnserve.exe\" --service -r C:\svn\window" displayname= "Subversion Server" depend= Tcpip start= auto
sc delete svn
