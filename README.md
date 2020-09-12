# manual-svn
to me


### SVN 저장소 to Ubuntu 18.04
sudo apt-get install -y subversion  
svn // install test  
svn --version // install test  
sudo mkdir svn  
cd svn  
sudo svnadmin create --fs-type fsfs repos  
cd repos  
ls -lt  
  
### 1. conf/svnserv.conf
```yaml
#인증되지않은(즉 계정이 없는) 사용자에 대해 접근
anon-access = read

#인증된 사용자에 대해 쓰기 권한
auth-access = write

#인증된 사용자에 대한 계정 정보(아이디/패스) 정보가 기록된 파일명을 의미한다.(기본값 passwd)
password-db = passwd

#인증된 사용자에 대해 저장소에 대한 권한 설정이 기록된 파일명(기본값)
authz-db = authz
```

### 2. conf/passwd
```
admin=admin
guest=guest
```

### 3. conf/authz
```
[/]
admin=rw
guest=r
```

### 4. SVN_EDITOR
```
SVN_EDITOR=/usr/bin/vim
export SVN_EDITOR
```


