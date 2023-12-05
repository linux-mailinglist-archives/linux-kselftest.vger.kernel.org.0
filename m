Return-Path: <linux-kselftest+bounces-1195-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E1B805DED
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 19:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AB641F216C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Dec 2023 18:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBFA35789F;
	Tue,  5 Dec 2023 18:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="geMsWfyZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF8B194
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Dec 2023 10:45:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701801954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D/3FU+psVxeFvo/nAcRzqPHgzPOCqZqJqnGBfx/xpzA=;
	b=geMsWfyZZU7cOJutiq+jew+Wv7d0wWd6LSuYx69A0q0KTtoS+mfafGG6qRYz/Coba/YMOI
	jkg75TDVqScpkBLeskC5RPLkXyEIBwnUFAJSGJKveRRPK0IVB6mGK2P29VOeisg4bj/RLF
	UJUFLzG1G793KoTzHXFetwsRnRZL5Ws=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-oKcDfZUYP92HLE1XibBcBg-1; Tue, 05 Dec 2023 13:45:51 -0500
X-MC-Unique: oKcDfZUYP92HLE1XibBcBg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40F95102F00D;
	Tue,  5 Dec 2023 18:45:50 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A5A08492BE6;
	Tue,  5 Dec 2023 18:45:47 +0000 (UTC)
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
Subject: [RFC PATCH v2 06/10] MAINTAINERS: Support referencing test docs in V:
Date: Tue,  5 Dec 2023 20:03:02 +0200
Message-ID: <20231205184503.79769-7-Nikolai.Kondrashov@redhat.com>
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

Support referencing test suite documentation in the V: entries of
MAINTAINERS file. Use the '*<name>' syntax (like C pointer dereference),
where '<name>' is a second-level heading in the new
Documentation/process/tests.rst file, with the suite's description.
This syntax allows distinguishing the references from test commands.

Add a boiler-plate Documentation/process/tests.rst file, describing a
way to add structured info to the test suites in the form of field
lists. Apart from a "summary" and "command" fields, they can also
contain a "superset" field specifying the superset of the test suite,
helping reuse documentation and express both wider and narrower test
sets.

Make scripts/checkpatch.pl load the tests from the file, along with the
structured data, validate the references in MAINTAINERS, dereference
them, and output the test suite information in the CHECK messages
whenever the corresponding subsystems are changed. But only if there was
no corresponding Tested-with: tag in the commit message, certifying it
was executed successfully already.

This is supposed to help propose executing test suites which cannot be
executed immediately, and need extra setup, as well as provide a place
for extra documentation and information on directly-available suites.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 Documentation/process/index.rst              |   1 +
 Documentation/process/submitting-patches.rst |  21 +++-
 Documentation/process/tests.rst              |  41 +++++++
 MAINTAINERS                                  |   9 +-
 scripts/checkpatch.pl                        | 122 +++++++++++++++++--
 5 files changed, 177 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/process/tests.rst

diff --git a/Documentation/process/index.rst b/Documentation/process/index.rst
index a1daa309b58d0..3eda2e7432fdb 100644
--- a/Documentation/process/index.rst
+++ b/Documentation/process/index.rst
@@ -49,6 +49,7 @@ Other guides to the community that are of interest to most developers are:
    :maxdepth: 1
 
    changes
+   tests
    stable-api-nonsense
    management-style
    stable-kernel-rules
diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 2004df2ac1b39..45bd1a713ef33 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -233,27 +233,42 @@ Test your changes
 
 Test the patch to the best of your ability. Check the MAINTAINERS file for the
 subsystem(s) you are changing to see if there are any **V:** entries
-proposing particular test suite commands. E.g.::
+proposing particular test suites, either directly as commands, or via
+documentation references.
+
+Test suite references start with a ``*`` (similar to C pointer dereferencing),
+followed by the name of the test suite, which would be documented in the
+Documentation/process/tests.rst under the corresponding heading. E.g.::
+
+  V: *xfstests
+
+Anything not starting with a ``*`` is considered a command. E.g.::
 
   V: tools/testing/kunit/run_checks.py
 
 Supplying the ``--test`` option to ``scripts/get_maintainer.pl`` adds **V:**
 entries to its output.
 
-Execute the commands, if any, to test your changes.
+Execute the (referenced) test suites, if any, to test your changes.
 
 All commands must be executed from the root of the source tree. Each command
 outputs usage information, if an -h/--help option is specified.
 
 If a test suite you've executed completed successfully, add a ``Tested-with:
-<command>`` to the message of the commit you tested. E.g.::
+<command>`` or ``Tested-with: *<reference>`` to the message of the commit you
+tested. E.g.::
 
   Tested-with: tools/testing/kunit/run_checks.py
 
+or::
+
+  Tested-with: *xfstests
+
 Optionally, add a '#' character followed by a publicly-accessible URL
 containing the test results, if you make them available. E.g.::
 
   Tested-with: tools/testing/kunit/run_checks.py # https://kernelci.org/test/2239874
+  Tested-with: *xfstests # https://kernelci.org/test/2239324
 
 
 Select the recipients for your patch
diff --git a/Documentation/process/tests.rst b/Documentation/process/tests.rst
new file mode 100644
index 0000000000000..4ae5000e811c8
--- /dev/null
+++ b/Documentation/process/tests.rst
@@ -0,0 +1,41 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _tests:
+
+Tests you can run
+=================
+
+There are many automated tests available for the Linux kernel, and some
+userspace tests which happen to also test the kernel. Here are some of them,
+along with the instructions on where to get them and how to run them for
+various purposes.
+
+This document has to follow a certain structure to allow tool access.
+Second-level headers (underscored with dashes '-') must contain test suite
+names, and the corresponding section must contain the test description.
+
+The test suites can be referenced by name, preceded with a '*', in the "V:"
+lines in the MAINTAINERS file, as well as in the "Tested-with:" tag in commit
+messages. E.g::
+
+  V: *xfstests
+
+and::
+
+  Tested-with: *xfstests
+
+Additionally, test suite names cannot contain '@' or '#' characters, the same
+as "V:" entries.
+
+The test suite description should contain the test documentation in general:
+where to get the test, how to run it, and how to interpret its results, but
+could also start with a "field list", containing single-line entries, with the
+following ones recognized by the tools (regardless of the case):
+
+:Summary: a single-line summary of the test suite (singular, non-capitalized)
+:Superset: the name of the test suite this one is a subset of
+:Command: a shell command executing the test suite, not requiring setup
+          beyond the kernel tree and regular developer environment
+          (even if only to report what else needs setting up)
+
+Any other entries are accepted, but not processed.
diff --git a/MAINTAINERS b/MAINTAINERS
index 28fbb0eb335ba..3ed15d8327919 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -60,11 +60,14 @@ Descriptions of section entries and preferred order
 	      printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
 	V: *Test suite* proposed for execution. The command that could be
-	   executed to verify changes to the maintained subsystem.
-	   Must be executed from the root of the source tree.
-	   Must support the -h/--help option.
+	   executed to verify changes to the maintained subsystem, or a reference
+	   to a test suite documented in Documentation/process/tests.txt.
+	   Commands must be executed from the root of the source tree.
+	   Commands must support the -h/--help option.
+	   References must be preceded with a '*'.
 	   Cannot contain '@' or '#' characters.
 	   V: tools/testing/kunit/run_checks.py
+	   V: *xfstests
 	   One test suite per line.
 
 Maintainers List
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 1da617e1edb5f..bfeb4c33b5424 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -66,6 +66,9 @@ my $codespellfile = "/usr/share/codespell/dictionary.txt";
 my $user_codespellfile = "";
 my $conststructsfile = "$D/const_structs.checkpatch";
 my $docsfile = "$D/../Documentation/dev-tools/checkpatch.rst";
+my $testsrelfile = "Documentation/process/tests.rst";
+my $testsfile = "$D/../$testsrelfile";
+my %tests = ();
 my $typedefsfile;
 my $color = "auto";
 my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANCE
@@ -282,6 +285,39 @@ sub load_docs {
 	close($docs);
 }
 
+sub load_tests {
+	open(my $tests, '<', "$testsfile")
+	    or warn "$P: Can't read the tests file $testsfile $!\n";
+
+	my $name = undef;
+	my $prev_line = undef;
+	my $in_field_list = 0;
+
+	while (<$tests>) {
+		my $line = $_;
+		$line =~ s/\s+$//;
+
+		# If the previous line was a second-level header (test name)
+		if ($line =~ /^-+$/ &&
+		    defined($prev_line) &&
+		    length($line) == length($prev_line)) {
+			$name = $prev_line;
+			$tests{$name} = {};
+			$in_field_list = 1;
+		# Else, if we're parsing the test's header field list
+		} elsif ($in_field_list) {
+			if ($line =~ /^:([^:]+):\s+(.*)/) {
+				$tests{$name}{lc($1)} = $2;
+			} else {
+				$in_field_list = !$line;
+			}
+		}
+
+		$prev_line = $line;
+	}
+	close($tests);
+}
+
 # Perl's Getopt::Long allows options to take optional arguments after a space.
 # Prevent --color by itself from consuming other arguments
 foreach (@ARGV) {
@@ -372,6 +408,7 @@ if ($color =~ /^[01]$/) {
 
 load_docs() if ($verbose);
 list_types(0) if ($list_types);
+load_tests();
 
 $fix = 1 if ($fix_inplace);
 $check_orig = $check;
@@ -1160,10 +1197,22 @@ sub get_file_proposed_tests {
 		my $output = `$command 2>/dev/null`;
 		# But regenerate stderr on failure
 		die "Failed retrieving tests proposed for changes to \"$filename\":\n" . `$command 2>&1 >/dev/null` if ($?);
-		$files_proposed_tests{$filename} = [grep { !/@/ } split("\n", $output)]
+		$file_proposed_tests = [grep { !/@/ } split("\n", $output)];
+		# Validate and normalize all references
+		for my $index (0 .. scalar @$file_proposed_tests - 1) {
+			my $test = $file_proposed_tests->[$index];
+			if ($test =~ /^\*\s*(.*)$/) {
+				my $name = $1;
+				die "Test $name referenced in MAINTAINERS not found in $testsrelfile\n"
+					if (!exists $tests{$name});
+				$file_proposed_tests->[$index] = "*" . $name;
+			}
+		}
+		$files_proposed_tests{$filename} = $file_proposed_tests;
+	} else {
+		$file_proposed_tests = $files_proposed_tests{$filename};
 	}
 
-	$file_proposed_tests = $files_proposed_tests{$filename};
 	return @$file_proposed_tests;
 }
 
@@ -2936,11 +2985,33 @@ sub process {
 			# Check if tests are proposed for changes to the file
 			foreach my $test (get_file_proposed_tests($realfile)) {
 				next if exists $dont_propose_tests{$test};
-				CHK("TEST_PROPOSAL",
-				    "Running the following test suite is proposed for changes to $realfile:\n" .
-				    "$test\n" .
-				    "Add the following to the tested commit's message, IF IT PASSES:\n" .
-				    "Tested-with: $test\n");
+				my $name;
+				my $title;
+				my $command;
+				my $message;
+				# If this is a reference to a documented test suite
+				if ($test =~ /^\*\s*(.*)/) {
+					$name = $1;
+					$title = $tests{$name}{"summary"} // "$name test suite";
+					$command = $tests{$name}{"command"};
+				# Else it's a test command
+				} else {
+					$title = "test suite";
+					$command = $test;
+				}
+				if ($command) {
+					$message = "Execute the $title " .
+						"proposed for verifying changes to $realfile:\n" .
+						"$command\n";
+				} else {
+					$message = "The $title is proposed for verifying changes to $realfile\n";
+				}
+				if ($name) {
+					$message .= "See instructions under \"$name\" in $testsrelfile\n";
+				}
+				$message .= "Add the following to the tested commit's message, " .
+					"IF IT PASSES:\nTested-with: $test\n";
+				CHK("TEST_PROPOSAL", $message);
 				$dont_propose_tests{$test} = 1;
 			}
 
@@ -3272,8 +3343,28 @@ sub process {
 
 # Check and accumulate executed test suites (stripping URLs off the end)
 		if (!$in_commit_log && $line =~ /^\s*Tested-with:\s*(.*?)\s*#.*$/i) {
-			# Do not propose this certified-passing test suite
-			$dont_propose_tests{$1} = 1;
+			my $test = $1;
+			# If the test is a reference
+			if ($test =~ /^\*\s*(.*)$/) {
+				# Do not propose (normalized references to)
+				# the test and its subsets
+				local *dont_propose_test_name = sub {
+					my ($name) = @_;
+					$dont_propose_tests{"*" . $name} = 1;
+					foreach my $sub_name (keys %tests) {
+						my $sub_data = $tests{$sub_name};
+						my $superset = $sub_data->{"superset"};
+						if (defined($superset) and $superset eq $name) {
+							dont_propose_test($sub_name);
+						}
+					}
+				};
+				dont_propose_test_name($1);
+			# Else it's a command
+			} else {
+				# Do not propose the test
+				$dont_propose_tests{$test} = 1;
+			}
 		}
 
 # Check email subject for common tools that don't need to be mentioned
@@ -3728,8 +3819,17 @@ sub process {
 			}
 # check MAINTAINERS V: entries are valid
 			if ($rawline =~ /^\+V:\s*(.*)/) {
-				my $name = $1;
-				if ($name =~ /[@#]/) {
+				my $entry = $1;
+				# If this is a valid entry value
+				if ($entry =~ /^[^@#]*$/) {
+					# If the test in the entry is a reference
+					if ($entry =~ /^\*\s*(.*)$/) {
+						my $name = $1;
+						ERROR("TEST_PROPOSAL_INVALID",
+						      "Test $name referenced in MAINTAINERS not found in $testsrelfile\n" .
+						      $herecurr) if (!exists $tests{$name});
+					}
+				} else {
 					ERROR("TEST_PROPOSAL_INVALID",
 					      "Test proposal cannot contain '\@' or '#' characters\n" . $herecurr);
 				}
-- 
2.42.0


