Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E53F226F
	for <lists+linux-kselftest@lfdr.de>; Thu, 19 Aug 2021 23:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbhHSVo6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 19 Aug 2021 17:44:58 -0400
Received: from smtprelay0095.hostedemail.com ([216.40.44.95]:36108 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232769AbhHSVo5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 19 Aug 2021 17:44:57 -0400
Received: from omf10.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 1D1DA182B0301;
        Thu, 19 Aug 2021 21:44:20 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf10.hostedemail.com (Postfix) with ESMTPA id EAFD52351F6;
        Thu, 19 Aug 2021 21:44:18 +0000 (UTC)
Message-ID: <8db9a7d938b2b1a1bdbd0224246e047c83581334.camel@perches.com>
Subject: Re: [RFC PATCH 1/5] checkpatch: improve handling of revert commits
From:   Joe Perches <joe@perches.com>
To:     Denis Efremov <efremov@linux.com>, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>, Jiri Kosina <jkosina@suse.cz>,
        Willy Tarreau <w@1wt.eu>
Date:   Thu, 19 Aug 2021 14:44:17 -0700
In-Reply-To: <c31b2007-26a9-34e0-8c9a-8e11a00ce69f@linux.com>
References: <20210818154646.925351-1-efremov@linux.com>
         <20210818154646.925351-2-efremov@linux.com>
         <cc5801790fea258e20fa6b7e26de7806ae8e0dda.camel@perches.com>
         <3d347d4b-1576-754f-8633-ba6084cc0661@linux.com>
         <23c8ebaa0921d5597df9fc1d6cbbcc4f354f80c5.camel@perches.com>
         <c31b2007-26a9-34e0-8c9a-8e11a00ce69f@linux.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: EAFD52351F6
X-Stat-Signature: t1zx9hhwubbw8oxjsooka7fycowycjj3
X-Spam-Status: No, score=5.20
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX189U7Bie0w4hCCQnlgtLr596sKKfNprumI=
X-HE-Tag: 1629409458-37529
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 2021-08-19 at 22:52 +0300, Denis Efremov wrote:
> Hi,
> 
> On 8/19/21 12:22 AM, Joe Perches wrote:
> > Hey Denis:
> > 
> > Try this one please and let me know what you think...
> 
> Looks good to me. Couple of nitpicks below

yeah, thanks.

How about this one:
---
 scripts/checkpatch.pl | 72 ++++++++++++++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 161ce7fe5d1e5..4988515a0dfb3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1181,7 +1181,8 @@ sub git_commit_info {
 #		    git log --format='%H %s' -1 $line |
 #		    echo "commit $(cut -c 1-12,41-)"
 #		done
-	} elsif ($lines[0] =~ /^fatal: ambiguous argument '$commit': unknown revision or path not in the working tree\./) {
+	} elsif ($lines[0] =~ /^fatal: ambiguous argument '$commit': unknown revision or path not in the working tree\./ ||
+		 $lines[0] =~ /^fatal: bad object $commit/) {
 		$id = undef;
 	} else {
 		$id = substr($lines[0], 0, 12);
@@ -2587,6 +2588,8 @@ sub process {
 	my $reported_maintainer_file = 0;
 	my $non_utf8_charset = 0;
 
+	my $last_git_commit_id_linenr = -1;
+
 	my $last_blank_line = 0;
 	my $last_coalesced_string_linenr = -1;
 
@@ -3173,7 +3176,8 @@ sub process {
 		if ($in_commit_log && !$commit_log_possible_stack_dump &&
 		    $line !~ /^\s*(?:Link|Patchwork|http|https|BugLink|base-commit):/i &&
 		    $line !~ /^This reverts commit [0-9a-f]{7,40}/ &&
-		    ($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
+		    (($line =~ /\bcommit\s+[0-9a-f]{5,}\b/i ||
+		      ($line =~ /\bcommit\s*$/i && defined($rawlines[$linenr]) && $rawlines[$linenr] =~ /^\s*[0-9a-f]{5,}\b/i)) ||
 		     ($line =~ /(?:\s|^)[0-9a-f]{12,40}(?:[\s"'\(\[]|$)/i &&
 		      $line !~ /[\<\[][0-9a-f]{12,40}[\>\]]/i &&
 		      $line !~ /\bfixes:\s*[0-9a-f]{12,40}/i))) {
@@ -3183,49 +3187,59 @@ sub process {
 			my $long = 0;
 			my $case = 1;
 			my $space = 1;
-			my $hasdesc = 0;
 			my $hasparens = 0;
 			my $id = '0123456789ab';
 			my $orig_desc = "commit description";
 			my $description = "";
+			my $herectx = $herecurr;
+			my $has_parens = 0;
+
+			my $input = $line;
+			if ($line =~ /(?:\bcommit\s+[0-9a-f]{5,}|\bcommit\s*$)/i) {
+				for (my $n = 0; $n < 2; $n++) {
+					if ($input =~ /\bcommit\s+[0-9a-f]{5,}\s*$balanced_parens/i) {
+						$has_parens = 1;
+						last;
+					}
+					last if ($#lines < $linenr + $n);
+					$input .= " " . trim($rawlines[$linenr + $n]);
+					$herectx .= "$rawlines[$linenr + $n]\n";
+				}
+				$herectx = $herecurr if (!$has_parens);
+			}
 
-			if ($line =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
+			if ($input =~ /\b(c)ommit\s+([0-9a-f]{5,})\b/i) {
 				$init_char = $1;
 				$orig_commit = lc($2);
-			} elsif ($line =~ /\b([0-9a-f]{12,40})\b/i) {
+				$short = 0 if ($input =~ /\bcommit\s+[0-9a-f]{12,40}/i);
+				$long = 1 if ($input =~ /\bcommit\s+[0-9a-f]{41,}/i);
+				$space = 0 if ($input =~ /\bcommit [0-9a-f]/i);
+				$case = 0 if ($input =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
+
+				if ($input =~ /\bcommit\s+[0-9a-f]{5,}\s+($balanced_parens)/i) {
+					$orig_desc = $1;
+					# Always strip leading/trailing parens then double quotes if existing
+					$orig_desc = substr($orig_desc, 1, -1);
+					if ($orig_desc =~ /^".*"$/) {
+						$orig_desc = substr($orig_desc, 1, -1);
+						$hasparens = 1;
+					}
+				}
+			} elsif ($input =~ /\b([0-9a-f]{12,40})\b/i) {
 				$orig_commit = lc($1);
 			}
 
-			$short = 0 if ($line =~ /\bcommit\s+[0-9a-f]{12,40}/i);
-			$long = 1 if ($line =~ /\bcommit\s+[0-9a-f]{41,}/i);
-			$space = 0 if ($line =~ /\bcommit [0-9a-f]/i);
-			$case = 0 if ($line =~ /\b[Cc]ommit\s+[0-9a-f]{5,40}[^A-F]/);
-			if ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)"\)/i) {
-				$orig_desc = $1;
-				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s*$/i &&
-				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*\("([^"]+)"\)/) {
-				$orig_desc = $1;
-				$hasparens = 1;
-			} elsif ($line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("[^"]+$/i &&
-				 defined $rawlines[$linenr] &&
-				 $rawlines[$linenr] =~ /^\s*[^"]+"\)/) {
-				$line =~ /\bcommit\s+[0-9a-f]{5,}\s+\("([^"]+)$/i;
-				$orig_desc = $1;
-				$rawlines[$linenr] =~ /^\s*([^"]+)"\)/;
-				$orig_desc .= " " . $1;
-				$hasparens = 1;
-			}
-
 			($id, $description) = git_commit_info($orig_commit,
 							      $id, $orig_desc);
 
 			if (defined($id) &&
-			   ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens)) {
+			    ($short || $long || $space || $case || ($orig_desc ne $description) || !$hasparens) &&
+			    $last_git_commit_id_linenr != $linenr - 1) {
 				ERROR("GIT_COMMIT_ID",
-				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herecurr);
+				      "Please use git commit description style 'commit <12+ chars of sha1> (\"<title line>\")' - ie: '${init_char}ommit $id (\"$description\")'\n" . $herectx);
 			}
+			#don't report the next line if this line ends in commit and the sha1 hash is the next line
+			$last_git_commit_id_linenr = $linenr if ($line =~ /\bcommit\s*$/i);
 		}
 
 # Check for added, moved or deleted files


