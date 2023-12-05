Return-Path: <linux-kselftest+bounces-1199-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1A5C805DF1
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32C721F21111
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:46:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9544357880;
	Tue,  5 Dec 2023 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RuxDTTPc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E56C0
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801965;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CfSpnYy4oKsXzvE3S4cKH6fDl4J4nm+5m3oSRUCkKP4=;
	b=RuxDTTPcBF0tHtTEDleznNugqm1XXzHk4+UtjFFFtWrlXWEz418Ucz3JnolbKfzmIZ3np/
	9L4EzoFmAAU1hPlEQ6aRTQj1HfBTRiCgzv/tUUWy8L8fcprQJDv3Mmhnnq013Dgt4q1ril
	IZ9LdbBDYECOL4AKwGZFgjeN5CfKSDw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-kxiglrEjPbC8QQ1GeR3YAw-1; Tue, 05 Dec 2023 13:46:02 -0500
X-MC-Unique: kxiglrEjPbC8QQ1GeR3YAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2B3DF185A785;
	Tue,  5 Dec 2023 18:46:02 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 30955492BE6;
	Tue,  5 Dec 2023 18:45:59 +0000 (UTC)
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
Subject: [RFC PATCH v2 10/10] MAINTAINERS: Add proposal strength to V: entries
Date: Tue,  5 Dec 2023 20:03:06 +0200
Message-ID: <20231205184503.79769-11-Nikolai.Kondrashov@redhat.com>
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

Require the MAINTAINERS V: entries to begin with a keyword, one of
SUGGESTED/RECOMMENDED/REQUIRED, signifying how strongly the test is
proposed for verifying the subsystem changes, prompting
scripts/checkpatch.pl to produce CHECK/WARNING/ERROR messages
respectively, whenever the commit message doesn't have the corresponding
Tested-with: tag.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 Documentation/process/submitting-patches.rst | 11 ++-
 MAINTAINERS                                  | 20 +++--
 scripts/checkpatch.pl                        | 83 ++++++++++++--------
 3 files changed, 71 insertions(+), 43 deletions(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 45bd1a713ef33..199fadc50cf62 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -233,18 +233,21 @@ Test your changes
 
 Test the patch to the best of your ability. Check the MAINTAINERS file for the
 subsystem(s) you are changing to see if there are any **V:** entries
-proposing particular test suites, either directly as commands, or via
-documentation references.
+proposing particular test suites.
+
+The **V:** entries start with a proposal strength keyword
+(SUGGESTED/RECOMMENDED/REQUIRED), followed either by a command, or a
+documentation reference.
 
 Test suite references start with a ``*`` (similar to C pointer dereferencing),
 followed by the name of the test suite, which would be documented in the
 Documentation/process/tests.rst under the corresponding heading. E.g.::
 
-  V: *xfstests
+  V: SUGGESTED *xfstests
 
 Anything not starting with a ``*`` is considered a command. E.g.::
 
-  V: tools/testing/kunit/run_checks.py
+  V: RECOMMENDED tools/testing/kunit/run_checks.py
 
 Supplying the ``--test`` option to ``scripts/get_maintainer.pl`` adds **V:**
 entries to its output.
diff --git a/MAINTAINERS b/MAINTAINERS
index 84e90ec015090..3a35e320b5a5b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -59,15 +59,19 @@ Descriptions of section entries and preferred order
 	      matches patches or files that contain one or more of the words
 	      printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
-	V: *Test suite* proposed for execution. The command that could be
-	   executed to verify changes to the maintained subsystem, or a reference
-	   to a test suite documented in Documentation/process/tests.txt.
+	V: *Test suite* proposed for execution for verifying changes to the
+	   maintained subsystem. Must start with a proposal strength keyword:
+	   (SUGGESTED/RECOMMENDED/REQUIRED), followed by the test suite command,
+	   or a reference to a test suite documented in
+	   Documentation/process/tests.txt.
+	   Proposal strengths correspond to checkpatch.pl message levels
+	   (CHECK/WARNING/ERROR respectively, whenever Tested-with: is missing).
 	   Commands must be executed from the root of the source tree.
 	   Commands must support the -h/--help option.
 	   References must be preceded with a '*'.
 	   Cannot contain '@' or '#' characters.
-	   V: tools/testing/kunit/run_checks.py
-	   V: *xfstests
+	   V: SUGGESTED tools/testing/kunit/run_checks.py
+	   V: RECOMMENDED *xfstests
 	   One test suite per line.
 
 Maintainers List
@@ -7978,7 +7982,7 @@ L:	linux-ext4@vger.kernel.org
 S:	Maintained
 W:	http://ext4.wiki.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-ext4/list/
-V:	*kvm-xfstests smoke
+V:	RECOMMENDED *kvm-xfstests smoke
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git
 F:	Documentation/filesystems/ext4/
 F:	fs/ext4/
@@ -11628,7 +11632,7 @@ L:	linux-kselftest@vger.kernel.org
 L:	kunit-dev@googlegroups.com
 S:	Maintained
 W:	https://google.github.io/kunit-docs/third_party/kernel/docs/
-V:	tools/testing/kunit/run_checks.py
+V:	RECOMMENDED tools/testing/kunit/run_checks.py
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git kunit-fixes
 F:	Documentation/dev-tools/kunit/
@@ -18367,7 +18371,7 @@ REGISTER MAP ABSTRACTION
 M:	Mark Brown <broonie@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
-V:	*kunit
+V:	RECOMMENDED *kunit
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git
 F:	Documentation/devicetree/bindings/regmap/
 F:	drivers/base/regmap/
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index bfeb4c33b5424..9438e4f452a6c 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1181,39 +1181,57 @@ sub is_maintained_obsolete {
 	return $maintained_status{$filename} =~ /obsolete/i;
 }
 
-# Test suites proposed per changed file
+# A list of test proposal strength keywords, weakest to strongest
+our @test_proposal_strengths = qw(suggested recommended required);
+# A regular expression string matching test proposal strength keywords
+my $test_proposal_strengths_res = join('|', @test_proposal_strengths);
+# A regular expression matching valid values of MAINTAINERS V: entries
+# Puts proposal strength into $1 and the test into $2
+my $test_proposal_entry_re = qr/^\s*($test_proposal_strengths_res)\s+([^@#]+?)\s*$/i;
+
+# A hashmap of changed files and references to hashmaps of test suites and the
+# strength (0-2) of their proposal
 our %files_proposed_tests = ();
 
-# Return a list of test suites proposed for execution for a particular file
+# Return a reference to a hashmap of test suites proposed for execution for a
+# particular file, and their proposal strengths - 0, 1, or 2 for
+# SUGGESTED/RECOMMENDED/REQUIRED respectively.
 sub get_file_proposed_tests {
 	my ($filename) = @_;
-	my $file_proposed_tests;
 
-	return () if (!$tree || !(-e "$root/scripts/get_maintainer.pl"));
+	return {} if (!$tree || !(-e "$root/scripts/get_maintainer.pl"));
 
 	if (!exists($files_proposed_tests{$filename})) {
+		# Retrieve and parse the entries
+		my %file_proposed_tests = ();
 		my $command = "perl $root/scripts/get_maintainer.pl --test --multiline --nogit --nogit-fallback -f $filename";
 		# Ignore warnings on stderr
 		my $output = `$command 2>/dev/null`;
 		# But regenerate stderr on failure
 		die "Failed retrieving tests proposed for changes to \"$filename\":\n" . `$command 2>&1 >/dev/null` if ($?);
-		$file_proposed_tests = [grep { !/@/ } split("\n", $output)];
-		# Validate and normalize all references
-		for my $index (0 .. scalar @$file_proposed_tests - 1) {
-			my $test = $file_proposed_tests->[$index];
-			if ($test =~ /^\*\s*(.*)$/) {
-				my $name = $1;
-				die "Test $name referenced in MAINTAINERS not found in $testsrelfile\n"
-					if (!exists $tests{$name});
-				$file_proposed_tests->[$index] = "*" . $name;
+		# For each non-email line (a V: entry)
+		foreach my $entry (grep { !/@/ } split("\n", $output)) {
+			# Extract the strength and the test
+			if ($entry =~ $test_proposal_entry_re) {
+				my $strength = grep { $test_proposal_strengths[$_] eq lc($1) }
+						0..$#test_proposal_strengths;
+				my $test = $2;
+				# Validate and normalize references
+				if ($test =~ /^\*\s*(.*)$/) {
+					my $name = $1;
+					die "Test $name referenced in MAINTAINERS not found in $testsrelfile\n"
+						if (!exists $tests{$name});
+					$test = "*" . $name;
+				}
+				$file_proposed_tests{$test} = $strength;
+			} else {
+				die "Invalid MAINTAINERS V: entry: $entry\n";
 			}
 		}
-		$files_proposed_tests{$filename} = $file_proposed_tests;
-	} else {
-		$file_proposed_tests = $files_proposed_tests{$filename};
+		$files_proposed_tests{$filename} = \%file_proposed_tests;
 	}
 
-	return @$file_proposed_tests;
+	return $files_proposed_tests{$filename};
 }
 
 sub is_SPDX_License_valid {
@@ -2761,7 +2779,7 @@ sub process {
 	my @setup_docs = ();
 	my $setup_docs = 0;
 
-	# Test suites which should not be proposed for execution
+	# Maximum strength (0-2) of test proposals to be ignored
 	my %dont_propose_tests = ();
 
 	my $camelcase_file_seeded = 0;
@@ -2983,8 +3001,10 @@ sub process {
 			}
 
 			# Check if tests are proposed for changes to the file
-			foreach my $test (get_file_proposed_tests($realfile)) {
-				next if exists $dont_propose_tests{$test};
+			my $file_proposed_tests = get_file_proposed_tests($realfile);
+			foreach my $test (keys %$file_proposed_tests) {
+				my $strength = $file_proposed_tests->{$test};
+				next if $strength <= ($dont_propose_tests{$test} // -1);
 				my $name;
 				my $title;
 				my $command;
@@ -3000,19 +3020,19 @@ sub process {
 					$command = $test;
 				}
 				if ($command) {
-					$message = "Execute the $title " .
-						"proposed for verifying changes to $realfile:\n" .
-						"$command\n";
+					$message = "Execute the $title $test_proposal_strengths[$strength] " .
+						"for verifying changes to $realfile:\n$command\n";
 				} else {
-					$message = "The $title is proposed for verifying changes to $realfile\n";
+					$message = "The $title is $test_proposal_strengths[$strength] " .
+						"for verifying changes to $realfile\n";
 				}
 				if ($name) {
 					$message .= "See instructions under \"$name\" in $testsrelfile\n";
 				}
 				$message .= "Add the following to the tested commit's message, " .
 					"IF IT PASSES:\nTested-with: $test\n";
-				CHK("TEST_PROPOSAL", $message);
-				$dont_propose_tests{$test} = 1;
+				(\&CHK, \&WARN, \&ERROR)[$strength]("TEST_PROPOSAL", $message);
+				$dont_propose_tests{$test} = $strength;
 			}
 
 			next;
@@ -3350,7 +3370,7 @@ sub process {
 				# the test and its subsets
 				local *dont_propose_test_name = sub {
 					my ($name) = @_;
-					$dont_propose_tests{"*" . $name} = 1;
+					$dont_propose_tests{"*" . $name} = 2;
 					foreach my $sub_name (keys %tests) {
 						my $sub_data = $tests{$sub_name};
 						my $superset = $sub_data->{"superset"};
@@ -3363,7 +3383,7 @@ sub process {
 			# Else it's a command
 			} else {
 				# Do not propose the test
-				$dont_propose_tests{$test} = 1;
+				$dont_propose_tests{$test} = 2;
 			}
 		}
 
@@ -3821,9 +3841,10 @@ sub process {
 			if ($rawline =~ /^\+V:\s*(.*)/) {
 				my $entry = $1;
 				# If this is a valid entry value
-				if ($entry =~ /^[^@#]*$/) {
+				if ($entry =~ $test_proposal_entry_re) {
+					my $test = $2;
 					# If the test in the entry is a reference
-					if ($entry =~ /^\*\s*(.*)$/) {
+					if ($test =~ /^\*\s*(.*)$/) {
 						my $name = $1;
 						ERROR("TEST_PROPOSAL_INVALID",
 						      "Test $name referenced in MAINTAINERS not found in $testsrelfile\n" .
@@ -3831,7 +3852,7 @@ sub process {
 					}
 				} else {
 					ERROR("TEST_PROPOSAL_INVALID",
-					      "Test proposal cannot contain '\@' or '#' characters\n" . $herecurr);
+					      "Invalid test proposal entry: $entry\n" . $herecurr);
 				}
 			}
 		}
-- 
2.42.0


