#!perl


# soure of link : https://github.com/tinyspeck/services-examples/blob/master/subversion.pl
# modifyed source of link : https://blog.hkwon.me/slack-subversion-intergration/

# Copyright 2020 CHO_GILSANG
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


#
# An SVN post-commit handler for posting to Slack. Setup the channel and get the token
# from your team's services page. Change the options below to reflect your team's settings.
#
# Requires these perl modules:
# HTTP::Request
# LWP::UserAgent
# JSON


# Submits the following post to the slack servers

# POST https: //foo.slack.com/services/hooks/subversion?token=xxxxxx
# Content-Type: application/x-www-form-urlencoded
# Host: foo.slack.com
# Content-Length: 101
#
# payload=%7B%22revision%22%3A1%2C%22url%22%3A%22http%3A%2F%2Fsvnserver%22%2C%22author%22%3A%22digiguru%22%2C%22log%22%3A%22Log%20info%22%7D

#
# I am not a perl programmer. Beware.
#

use warnings;
use strict;

use HTTP::Request::Common qw(POST);
use HTTP::Status qw(is_client_error);
use LWP::UserAgent;
use JSON;

# 한글 사용을 위해 추가
use Encode;

my $opt_domain = ""; # Your team's domain
my $opt_token = ""; # The token from your SVN services page

#
# this script gets called by the SVN post-commit handler
# with these args:
#
# [0] path to repo
# [1] revision committed
#
# we need to find out what happened in that revision and then act on it
#

print $ARGV[0];
print $ARGV[1];

# Perl 코드가 UTF-8 형식으로 저장되어있다면
# cp949 형식으로 decoding이 필요
my $log = `svnlook log -r $ARGV[1] $ARGV[0]`; # 글자가 꺠짐
my $string = decode("cp949", $log);

my $files = `svnlook changed -r $ARGV[1] $ARGV[0]`;
my $who = `svnlook author -r $ARGV[1] $ARGV[0]`;
my $url = "http://svn.dev/repos/kcx/?op=revision&rev=$ARGV[1]"; # optionally set this to the url of your internal commit browser. Ex: http://svnserver/wsvn/main/?op=revision&rev=$ARGV[1]
chomp $who;

# added 파일들과 revision 번호
my $revision = $files.'['.$ARGV[1].']';

my @cats = split / U /, $revision;
my $result = join("\n", @cats);
$revision = $result;

# 보내는 양식
my $payload = {
	'revision'	=> $revision,
	'url'		=> $url,
	'author'	=> "\n".$who,
	'log'		=> $string
};

my $ua = LWP::UserAgent->new;
$ua->timeout(15);

my $req = POST( "https://${opt_domain}/services/hooks/subversion?token=${opt_token}", ['payload' => encode_json($payload)] );

my $s = $req->as_string;
print STDERR "Request:\n$s\n";

my $resp = $ua->request($req);
$s = $resp->as_string;
print STDERR "Response:\n$s\n";
