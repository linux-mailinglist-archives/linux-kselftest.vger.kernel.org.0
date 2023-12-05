Return-Path: <linux-kselftest+bounces-1191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3676E805DE8
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4230281EB5
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B504B5AC;
	Tue,  5 Dec 2023 18:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DFVwtO1P"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827D2D42
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h0xsKhI0wzHBAAOeUnC7iGjFcCTKbd/XMTGm0IplGwU=;
	b=DFVwtO1PtiFt98KanekSSP3tNvET64x232Fh20+wdUWfZTx+UvQdYWQ4ROGp5VswzPc5KR
	AuVOCyYqyGP+j8JxJJyWWQFZulmXd50sUBpBDlcG8pQFRkpvZKDqVquXvrRxiNoZQjwxme
	UjfW40Mrbe0apBjv++TyI3Md0tBBEH8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-_NId1kzSMCao43sJDzfOXQ-1; Tue, 05 Dec 2023 13:45:39 -0500
X-MC-Unique: _NId1kzSMCao43sJDzfOXQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B129488B78D;
	Tue,  5 Dec 2023 18:45:38 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 19F3B492BE6;
	Tue,  5 Dec 2023 18:45:35 +0000 (UTC)
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
To: workflows@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Joe Perches <joe@perches.com>,
	Andy Whitcroft <apw@canonical.com>,
	Theodore Ts'o <tytso@mit.edu>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Brown <broonie@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Darrick J . Wong" <djwong@kernel.org>
Cc: kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	Veronika Kabatova <vkabatov@redhat.com>,
	CKI <cki-project@redhat.com>,
	kernelci@lists.linux.dev,
	Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
Subject: [RFC PATCH v2 02/10] MAINTAINERS: Introduce V: entry for tests
Date: Tue,  5 Dec 2023 20:02:58 +0200
Message-ID: <20231205184503.79769-3-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
 <20231205184503.79769-1-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Introduce a new 'V:' ("Verify") entry to MAINTAINERS. The entry accepts
a test suite command which is proposed to be executed for each
contribution to the subsystem.

Extend scripts/get_maintainer.pl to support retrieving the V: entries
when '--test' option is specified.

Require the entry values to not contain the '@' character, so they could
be distinguished from emails (always) output by get_maintainer.pl. Make
scripts/checkpatch.pl check that they don't.

Update entry ordering in both scripts/checkpatch.pl and
scripts/parse-maintainers.pl.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 Documentation/process/submitting-patches.rst | 18 ++++++++++++++++++
 MAINTAINERS                                  |  7 +++++++
 scripts/checkpatch.pl                        | 10 +++++++++-
 scripts/get_maintainer.pl                    | 17 +++++++++++++++--
 scripts/parse-maintainers.pl                 |  3 ++-
 5 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 86d346bcb8ef0..f034feaf1369e 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -228,6 +228,24 @@ You should be able to justify all violations that remain in your
 patch.
 
 
+Test your changes
+-----------------
+
+Test the patch to the best of your ability. Check the MAINTAINERS file for the
+subsystem(s) you are changing to see if there are any **V:** entries
+proposing particular test suite commands. E.g.::
+
+  V: tools/testing/kunit/run_checks.py
+
+Supplying the ``--test`` option to ``scripts/get_maintainer.pl`` adds **V:**
+entries to its output.
+
+Execute the commands, if any, to test your changes.
+
+All commands must be executed from the root of the source tree. Each command
+outputs usage information, if an -h/--help option is specified.
+
+
 Select the recipients for your patch
 ------------------------------------
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 788be9ab5b733..e6d0777e21657 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -59,6 +59,13 @@ Descriptions of section entries and preferred order
 	      matches patches or files that contain one or more of the words
 	      printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
+	V: *Test suite* proposed for execution. The command that could be
+	   executed to verify changes to the maintained subsystem.
+	   Must be executed from the root of the source tree.
+	   Must support the -h/--help option.
+	   Cannot contain '@' character.
+	   V: tools/testing/kunit/run_checks.py
+	   One test suite per line.
 
 Maintainers List
 ----------------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda1128..a184e576c980b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3657,7 +3657,7 @@ sub process {
 				}
 			}
 # check MAINTAINERS entries for the right ordering too
-			my $preferred_order = 'MRLSWQBCPTFXNK';
+			my $preferred_order = 'MRLSWQBCPVTFXNK';
 			if ($rawline =~ /^\+[A-Z]:/ &&
 			    $prevrawline =~ /^[\+ ][A-Z]:/) {
 				$rawline =~ /^\+([A-Z]):\s*(.*)/;
@@ -3683,6 +3683,14 @@ sub process {
 					}
 				}
 			}
+# check MAINTAINERS V: entries are valid
+			if ($rawline =~ /^\+V:\s*(.*)/) {
+				my $name = $1;
+				if ($name =~ /@/) {
+					ERROR("TEST_PROPOSAL_INVALID",
+					      "Test proposal cannot contain '\@' character\n" . $herecurr);
+				}
+			}
 		}
 
 		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 37901c2298388..804215a7477db 100755
--- a/scripts/get_maintainer.pl
+++ b/scripts/get_maintainer.pl
@@ -53,6 +53,7 @@ my $output_section_maxlen = 50;
 my $scm = 0;
 my $tree = 1;
 my $web = 0;
+my $test = 0;
 my $subsystem = 0;
 my $status = 0;
 my $letters = "";
@@ -270,6 +271,7 @@ if (!GetOptions(
 		'scm!' => \$scm,
 		'tree!' => \$tree,
 		'web!' => \$web,
+		'test!' => \$test,
 		'letters=s' => \$letters,
 		'pattern-depth=i' => \$pattern_depth,
 		'k|keywords!' => \$keywords,
@@ -319,13 +321,14 @@ if ($sections || $letters ne "") {
     $status = 0;
     $subsystem = 0;
     $web = 0;
+    $test = 0;
     $keywords = 0;
     $keywords_in_file = 0;
     $interactive = 0;
 } else {
-    my $selections = $email + $scm + $status + $subsystem + $web;
+    my $selections = $email + $scm + $status + $subsystem + $web + $test;
     if ($selections == 0) {
-	die "$P:  Missing required option: email, scm, status, subsystem or web\n";
+	die "$P:  Missing required option: email, scm, status, subsystem, web or test\n";
     }
 }
 
@@ -634,6 +637,7 @@ my %hash_list_to;
 my @list_to = ();
 my @scm = ();
 my @web = ();
+my @test = ();
 my @subsystem = ();
 my @status = ();
 my %deduplicate_name_hash = ();
@@ -665,6 +669,11 @@ if ($web) {
     output(@web);
 }
 
+if ($test) {
+    @test = uniq(@test);
+    output(@test);
+}
+
 exit($exit);
 
 sub self_test {
@@ -850,6 +859,7 @@ sub get_maintainers {
     @list_to = ();
     @scm = ();
     @web = ();
+    @test = ();
     @subsystem = ();
     @status = ();
     %deduplicate_name_hash = ();
@@ -1072,6 +1082,7 @@ MAINTAINER field selection options:
   --status => print status if any
   --subsystem => print subsystem name if any
   --web => print website(s) if any
+  --test => print test(s) if any
 
 Output type options:
   --separator [, ] => separator for multiple entries on 1 line
@@ -1382,6 +1393,8 @@ sub add_categories {
 		push(@scm, $pvalue . $suffix);
 	    } elsif ($ptype eq "W") {
 		push(@web, $pvalue . $suffix);
+	    } elsif ($ptype eq "V") {
+		push(@test, $pvalue . $suffix);
 	    } elsif ($ptype eq "S") {
 		push(@status, $pvalue . $suffix);
 	    }
diff --git a/scripts/parse-maintainers.pl b/scripts/parse-maintainers.pl
index 2ca4eb3f190d6..dbc2b79bcaa46 100755
--- a/scripts/parse-maintainers.pl
+++ b/scripts/parse-maintainers.pl
@@ -44,6 +44,7 @@ usage: $P [options] <pattern matching regexes>
       B:  URI for bug tracking/submission
       C:  URI for chat
       P:  URI or file for subsystem specific coding styles
+      V:  Test suite name
       T:  SCM tree type and location
       F:  File and directory pattern
       X:  File and directory exclusion pattern
@@ -73,7 +74,7 @@ sub by_category($$) {
 
 sub by_pattern($$) {
     my ($a, $b) = @_;
-    my $preferred_order = 'MRLSWQBCPTFXNK';
+    my $preferred_order = 'MRLSWQBCPVTFXNK';
 
     my $a1 = uc(substr($a, 0, 1));
     my $b1 = uc(substr($b, 0, 1));
-- 
2.42.0


