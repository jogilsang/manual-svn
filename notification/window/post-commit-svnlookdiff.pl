#!perl

# Copyright 2021 jo_gilsang
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use warnings;
use strict;

use HTTP::Request::Common qw(POST);
use HTTP::Status qw(is_client_error);
use LWP::UserAgent;
use JSON;

# 한글 사용을 위해 추가
use Encode;
use Encode::Guess;

# [0] path to repo
# [1] revision committed

print $ARGV[0];
print $ARGV[1];

# Origin
my $log = `svnlook log -r $ARGV[1] $ARGV[0]`;  # Perl 코드 저장형식에 따라서
$log = decode("cp949", $log); # cp949 형식으로 decoding이 필요. 한글이 깨짐
my $who = `svnlook author -r $ARGV[1] $ARGV[0]`;
chomp $who;
my $revision = "$ARGV[1]";
my $diff = `svnlook diff -r $ARGV[1] $ARGV[0] --no-diff-added --no-diff-deleted`;
$diff = decode("cp949", $diff); 

# Binding
my $svn_revision = $revision;
my $svn_author = $who;
my $svn_message = $log;
my $svn_diff = $diff;

# code-snippet-Notification
my $slack_channels = ""; # 채널이름 혹은 채널코드
my $slack_filename = $svn_revision.'_'.$svn_author; 
my $slack_filetype = "diff";
my $slack_initial_comment = ":bulb: ".$svn_author." [".$svn_revision."]"."\n".$svn_message;
my $slack_title = $svn_revision.'_'.$svn_author;

SlackAPI_files_upload($slack_channels, $svn_diff, $slack_filename,$slack_filetype, $slack_initial_comment,$slack_title);

sub SlackAPI_files_upload {

  # TODO : 슬랙 앱 등록 후, scope 설정필요. user token이나 bot token 가져오기
  my $slack_token = 'xoxb-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx';

  # Token (Required)
  # $_[0] -> channels (Optional)
  # $_[1] -> content (Optional)
  # $_[2] -> filename (Optional) 
  # $_[3] -> filetype (Optional)
  # $_[4] -> initial_comment (Optional)
  # $_[5] -> title (Optional)

    if(!$_[0]) {
        print STDERR `ERROR : SlackAPI_files_upload Method, channel needed $_[1]`;
        exit(1);
    }

    if(!$_[1]) {
        print STDERR `ERROR : SlackAPI_files_upload Method, contents needed $_[2]`;
        exit(1);
    }

    if(!$_[2]) {
        print STDERR `ERROR : SlackAPI_files_upload Method, filename needed $_[3]`;
        exit(1);
    }

    if(!$_[3]) {
        print STDERR `ERROR : SlackAPI_files_upload Method, filetype needed $_[4]`;
        exit(1);
    }

    if(!$_[4]) {
        print STDERR `ERROR : SlackAPI_files_upload Method, initial_comment needed $_[5]`;
        exit(1);
    }

    if(!$_[5]) {
        print STDERR `ERROR : SlackAPI_files_upload Method, title needed $_[6]`;
        exit(1);
    }

    my $ua = LWP::UserAgent->new;
    $ua->timeout(15);

    my $body = [
      channels=> "$_[0]", 
      content=> "$_[1]", 
      filename=> "$_[2]", 
      filetype=> "$_[3]", 
      initial_comment=> "$_[4]", 
      title=> "$_[5]", 
    ];
    my $url = "https://slack.com/api/files.upload";
    my $req = POST $url, $body ;

    $req->content_type('application/x-www-form-urlencoded');
    $req->authorization('Bearer '.$slack_token);

    my $s = $req->as_string;
    print STDERR "Request:\n$s\n";

    my $res = $ua->request($req);
    $s = $res->as_string;
    print STDERR "Response:\n$s\n";

}
