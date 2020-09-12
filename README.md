# manual-svn
https://zetawiki.com/wiki/Svnserve_%EC%8B%9C%EC%9E%91/%EC%A4%91%EC%A7%80
https://zetawiki.com/wiki/CentOS_%EC%84%9C%EB%B8%8C%EB%B2%84%EC%A0%84_%EC%84%9C%EB%B2%84_%EC%84%A4%EC%B9%98_%EB%B0%8F_%EC%84%A4%EC%A0%95_(svn)

### 포트
```
http:// 로 시작 하면 80번 포트를 열어야 합니다.
https:// 로 시작하면 443번 포트를 열어야 합니다.
svn:// 으로 시작하면 3690번 포트를 여셔야 합니다.
svn+ssh:// 로 시작하면 22번포트를 여셔야 합니다.
```

### SVN 저장소 to Ubuntu 18.04 
### 설치
sudo apt-get install -y subversion  
svn // install test  
svn --version // install test  
sudo mkdir svn  
cd svn  
sudo svnadmin create --fs-type fsfs repos  
cd repos  
ls -lt  


### 설치 후 세팅  
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
### *** 1. error (line19 : Option expected error)
```
앞에 공백 다 제거해야함.
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

### 5. SVN 시작
```
sudo svnserve -d -r svn/repos
```

### 6. SVN 종료 및 재시작
```
ps -ef | grep svnserve
kill -9 1684 1
sudo svnserve -d -r svn/repos
```


