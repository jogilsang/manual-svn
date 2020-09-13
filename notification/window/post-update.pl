#!/usr/bin/perl


# Copyright 2013 Tiny Speck, Inc
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
use Encode qw(decode_utf8);

 
#
# Customizable vars. Set these to the information for your team
#

my $opt_domain = ""; # Your team's domain
my $opt_token = ""; # The token from your SVN services page


# 한글 사용을 위해 변경
# my $log = qx|export LC_ALL="ko_KR.UTF-8"; /usr/bin/svnlook log -r $ARGV[1] $ARGV[0]|;
# $log = decode_utf8($log);

# my $files = `/usr/bin/svnlook changed -r $ARGV[1] $ARGV[0]`;
# my $who = `/usr/bin/svnlook author -r $ARGV[1] $ARGV[0]`;
# my $url = "http://www.naver.com/?op=revision&rev=$ARGV[1]"; # optionally set this to the url of your internal commit browser. Ex: http://svnserver/wsvn/main/?op=revision&rev=$ARGV[1]
# chomp $who;

# Post-commit
# $ARGV[0] = PATH
# $ARGV[1] = DEPTH
# $ARGV[2] = MESSAGEFILE
# $ARGV[3] = REVISION
# $ARGV[4] = ERROR
# $ARGV[5] = CWD

# Post-update
# $ARGV[0] = PATH
# $ARGV[1] = DEPTH
# $ARGV[2] = REVISION
# $ARGV[3] = ERROR
# $ARGV[4] = CWD
# $ARGV[5] = RESULTPATH


# my $revision = '0126';
my $revision = $ARGV[2];
my $url = '';
my $who = $ARGV[5];
my $log = $ARGV[5];

my $payload = {
	'revision'	=> $revision,
	'url'		=> $url,
	'author'	=> $who,
	'log'		=> $log,
};

# my $payload = {
# 	'revision'	=> $files.'['.$ARGV[1].']',
# 	'url'		=> $url,
# 	'author'	=> $who,
# 	'log'		=> $log,
# };

my $ua = LWP::UserAgent->new;
$ua->timeout(15);



my $req = POST( "https://${opt_domain}/services/hooks/subversion?token=${opt_token}", ['payload' => encode_json($payload)] );
my $s = $req->as_string;
print STDERR "Request:\n$s\n";

my $resp = $ua->request($req);
$s = $resp->as_string;
print STDERR "Response:\n$s\n";

