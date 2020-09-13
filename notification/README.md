
svn/repos/hooks/
Commit이 되는순간 Notification이 날라가도록 하는 것

### Slack
```
// 펄 설치
sudo apt-get install libjson-perl
sudo apt-get install libwww-perl

```

###
```
Start-commit
커밋 대화 상자가 표시되기 전에 호출됩니다. 후크가 버전이 지정된 파일을 수정하고 커밋 및 / 또는 커밋 메시지가 필요한 파일 목록에 영향을주는 경우이를 사용할 수 있습니다. 그러나 후크가 초기 단계에서 호출되기 때문에 커밋을 위해 선택한 전체 개체 목록을 사용할 수 없다는 점에 유의해야합니다.

Manual Pre-commit
이것이 지정되면 커밋 대화 상자에 클릭하면 지정된 후크 스크립트를 실행하는 후크 실행 버튼이 표시 됩니다. 후크 스크립트는 확인 된 모든 파일 및 폴더 목록과 입력 된 경우 커밋 메시지를받습니다.

Check-commit
사용자 가 커밋 대화 상자에서 확인 을 클릭 한 후 커밋 대화 상자를 닫기 전에 호출 됩니다. 이 후크는 확인 된 모든 파일의 목록을 가져옵니다. 후크가 오류를 반환하면 커밋 대화 상자가 열린 상태로 유지됩니다.

반환 된 오류 메시지에 줄 바꿈으로 구분 된 경로가 포함 된 경우 해당 경로는 오류 메시지가 표시된 후 커밋 대화 상자에서 선택됩니다.

Pre-commit
사용자 가 커밋 대화 상자에서 확인 을 클릭 한 후 실제 커밋이 시작되기 전에 호출 됩니다. 이 후크에는 커밋 될 항목의 목록이 있습니다.

Post-commit
커밋이 성공적으로 완료된 후 호출됩니다.

Start-update
개정으로 업데이트 대화 상자가 표시되기 전에 호출됩니다.

Pre-update
실제 Subversion 업데이트 또는 전환이 시작되기 전에 호출됩니다.

Post-update
업데이트, 스위치 또는 체크 아웃이 완료된 후 호출됩니다 (성공 여부에 관계없이).

Pre-connect
저장소에 연결을 시도하기 전에 호출됩니다. 5 분에 한 번만 호출됩니다.

Pre-lock
파일 잠금을 시도하기 전에 호출됩니다.

Post-lock
파일이 잠긴 후에 호출됩니다.
```

```
notification : post-commit, post-revprop-change 
validation : start-commit, pre-commit 규칙을 통해 커밋완료 전 검증
replication :  pre-revprop-change, 저장소 복제할 경우
```
