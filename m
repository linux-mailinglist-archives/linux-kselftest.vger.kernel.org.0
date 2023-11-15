Return-Path: <linux-kselftest+bounces-171-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D247EC9E9
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 18:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 516BD1F250F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Nov 2023 17:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0B73EA94;
	Wed, 15 Nov 2023 17:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YxnWM2Mi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE534196
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Nov 2023 09:52:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700070741;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RGY5m2i7v+rVS6Y5PaFN8uLoi5lV4RCp7T3pzd50WwE=;
	b=YxnWM2Mi/Siyu7vGWWYqXRpBQK1cjy2kMfOWigmGEDTkjwP03veQtZkuJ920QYob8eMpGa
	J/KvfLkDZcM3iDy7rhzzcLa2D/srnTE5iYsASQraafUOb6cvF6+7bqmALYb01AdkPNie+a
	yHSDCQXJONZrcKhweet0ZQFKBsWpKSk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-uStCWqEHNYm22IQd3oF3Vg-1; Wed, 15 Nov 2023 12:52:15 -0500
X-MC-Unique: uStCWqEHNYm22IQd3oF3Vg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C06BD811E92;
	Wed, 15 Nov 2023 17:52:14 +0000 (UTC)
Received: from ruby.redhat.com (unknown [10.39.192.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 58D041121306;
	Wed, 15 Nov 2023 17:52:12 +0000 (UTC)
From: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
To: workflows@vger.kernel.org,
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
Subject: [PATCH 1/3] MAINTAINERS: Introduce V: field for required tests
Date: Wed, 15 Nov 2023 19:43:49 +0200
Message-ID: <20231115175146.9848-2-Nikolai.Kondrashov@redhat.com>
In-Reply-To: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
References: <20231115175146.9848-1-Nikolai.Kondrashov@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Introduce a new 'V:' ("Verify") field to MAINTAINERS. The field accepts
a name of a test suite which is required to be executed for each
contribution to the subsystem.

Each referenced test suite is expected to be documented in the new
Documentation/process/tests.rst file, which must have enough structure
(documented inside) for the tools to make use of it. Apart from basic
data, each test can refer to its "superset" - a test suite which this
one is a part of. The expected use is to describe both a large test
suite and its subsets, so the former would also be accepted, if a
subsystem requires only a subset.

Introduce a new tag, 'Tested-with:', documented in the
Documentation/process/submitting-patches.rst file. The tag is expected
to reference the documented test suites, similarly to the 'V:' field,
and to certify that the submitter executed the test suite on the change,
and that it passed.

Make scripts/checkpatch.pl ensure any added V: fields reference
documented test suites only, and output a warning if a change to a
subsystem doesn't certify the required test suites were executed,
if any.

If the test suite description includes a "Command", then checkpatch.pl
will output it as the one executing the suite. The command should run
with only the kernel tree and the regular developer environment set up.
But, at the same time, could simply output instructions for installing
any extra dependencies (or pull some automatically). The idea is to
get the developer into feedback loop quicker and easier, so they have
something to run and iterate on, even if it involves installing some
more stuff first. Therefore it's a good idea to add such wrappers to the
kernel tree proper and refer to them from the tests.rst.

Extend scripts/get_maintainer.pl to support retrieving the V: fields,
and scripts/parse-maintainers.pl to maintain their ordering.

Signed-off-by: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>
---
 Documentation/process/submitting-patches.rst |  19 +++
 Documentation/process/tests.rst              |  35 ++++++
 MAINTAINERS                                  |   6 +
 scripts/checkpatch.pl                        | 118 ++++++++++++++++++-
 scripts/get_maintainer.pl                    |  17 ++-
 scripts/parse-maintainers.pl                 |   3 +-
 6 files changed, 194 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/process/tests.rst

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 86d346bcb8ef0..8f0f3c9f753dd 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -228,6 +228,25 @@ You should be able to justify all violations that remain in your
 patch.
 
 
+Test your changes
+-----------------
+
+Test the patch to the best of your ability. Check the MAINTAINERS file for the
+subsystem(s) you are changing to see if there are any **V:** entries requiring
+particular test suites to be executed. If any are required, follow the
+instructions in the Documentation/process/tests.rst under the headings
+matching the V: entries.
+
+If you ran any test suites documented in the Documentation/process/tests.rst
+file, and they passed, add a 'Tested-with: <test_suite>' line to the messages
+of the commits you tested, one for every test suite, substituting
+'<test_suite>' with their names.
+
+If a subsystem you're changing requires a test suite to be executed and the
+commit lacks the 'Tested-with:' line referring to it (or its documented
+superset), scripts/checkpatch.pl will produce a WARNING reminding you to run
+it.
+
 Select the recipients for your patch
 ------------------------------------
 
diff --git a/Documentation/process/tests.rst b/Documentation/process/tests.rst
new file mode 100644
index 0000000000000..907311e91ec45
--- /dev/null
+++ b/Documentation/process/tests.rst
@@ -0,0 +1,35 @@
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
+The test suites can be referred to by name, from the "V:" lines in the
+MAINTAINERS file, as well as from the "Tested-with:" tag in commit messages.
+
+The test suite description should contain the test documentation in general:
+where to get the test, how to run it, and how to interpret its results, but
+could also start with a "field list", with the following entries recognized by
+the tools (regardless of the case):
+
+:Summary: A single-line summary of the test suite
+:Superset: The name of the test suite this one is a subset of
+:Command: A shell command executing the test suite, not requiring setup
+          beyond the kernel tree and regular developer environment
+          (even if only to report what else needs setting up)
+
+Any other entries are accepted, but not processed. The following could be
+particularly useful:
+
+:Source: A URL pointing to the source code of the test suite
+:Docs: A URL pointing to further test suite documentation
diff --git a/MAINTAINERS b/MAINTAINERS
index 5c9f868e13b6e..2565c04f0490e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -59,6 +59,12 @@ Descriptions of section entries and preferred order
 	      matches patches or files that contain one or more of the words
 	      printk, pr_info or pr_err
 	   One regex pattern per line.  Multiple K: lines acceptable.
+	V: *Test* recommended for execution. The name of a test suite
+	   that should be executed for changes to the maintained subsystem.
+	   The test suite must be documented in a structured way in
+	   Documentation/process/tests.rst under a heading of the same name.
+	   V: xfstests
+	   One test suite per line.
 
 Maintainers List
 ----------------
diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 25fdb7fda1128..92ee221caa4d3 100755
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
@@ -1144,6 +1181,26 @@ sub is_maintained_obsolete {
 	return $maintained_status{$filename} =~ /obsolete/i;
 }
 
+# Test suites required per changed file
+our %file_required_tests = ();
+
+# Return a list of test suites required for execution for a particular file
+sub get_file_required_tests {
+	my ($filename) = @_;
+	my $file_required_tests;
+
+	return () if (!$tree || !(-e "$root/scripts/get_maintainer.pl"));
+
+	if (!exists($file_required_tests{$filename})) {
+		my $output = `perl $root/scripts/get_maintainer.pl --test --multiline --nogit --nogit-fallback -f $filename 2>&1`;
+		die "Failed retrieving tests required for changes to \"$filename\":\n$output" if ($?);
+		$file_required_tests{$filename} = [grep { !/@/ } split("\n", $output)]
+	}
+
+	$file_required_tests = $file_required_tests{$filename};
+	return @$file_required_tests;
+}
+
 sub is_SPDX_License_valid {
 	my ($license) = @_;
 
@@ -2689,6 +2746,9 @@ sub process {
 	my @setup_docs = ();
 	my $setup_docs = 0;
 
+	# Test suites which should not be required for execution
+	my %not_required_tests = ();
+
 	my $camelcase_file_seeded = 0;
 
 	my $checklicenseline = 1;
@@ -2907,6 +2967,27 @@ sub process {
 				}
 			}
 
+			# Check if tests are required for changes to the file
+			foreach my $name (get_file_required_tests($realfile)) {
+				next if exists $not_required_tests{$name};
+				my $test_ref = "\"$name\"";
+				my $summary = $tests{$name}{"summary"};
+				my $command = $tests{$name}{"command"};
+				my $instructions = "";
+				if (defined($summary)) {
+					$test_ref = "$summary ($test_ref)";
+				}
+				if (defined($command)) {
+					$instructions .= "\nRun the test with \"$command\".";
+				}
+				$instructions .= "\nSee $testsrelfile for instructions.";
+				WARN("TEST_REQUIRED",
+				     "Changes to $realfile require running $test_ref, " .
+				     "but no corresponding Tested-with: tag found." .
+				     "$instructions");
+				$not_required_tests{$name} = 1;
+			}
+
 			next;
 		}
 
@@ -3233,6 +3314,29 @@ sub process {
 			}
 		}
 
+# Check and accumulate executed test suites
+		if (!$in_commit_log && $line =~ /^\s*Tested-with:\s*(.*)/i) {
+			my $name = $1;
+			my $sub_found = 0;
+			if (!exists $tests{$name}) {
+				ERROR("TEST_NAME",
+				      "Test suite \"$name\" not documented in $testsrelfile\n" . $herecurr);
+			}
+			# Do not require this test suite and all its subsets
+			local *dont_require_test = sub {
+				my ($name) = @_;
+				$not_required_tests{$name} = 1;
+				foreach my $sub_name (keys %tests) {
+					my $sub_data = $tests{$sub_name};
+					my $superset = $sub_data->{"superset"};
+					if (defined($superset) and $superset eq $name) {
+						dont_require_test($sub_name);
+					}
+				}
+			};
+			dont_require_test($name);
+		}
+
 # Check email subject for common tools that don't need to be mentioned
 		if ($in_header_lines &&
 		    $line =~ /^Subject:.*\b(?:checkpatch|sparse|smatch)\b[^:]/i) {
@@ -3657,7 +3761,7 @@ sub process {
 				}
 			}
 # check MAINTAINERS entries for the right ordering too
-			my $preferred_order = 'MRLSWQBCPTFXNK';
+			my $preferred_order = 'MRLSWQBCPVTFXNK';
 			if ($rawline =~ /^\+[A-Z]:/ &&
 			    $prevrawline =~ /^[\+ ][A-Z]:/) {
 				$rawline =~ /^\+([A-Z]):\s*(.*)/;
@@ -3683,6 +3787,18 @@ sub process {
 					}
 				}
 			}
+# check MAINTAINERS V: entries are valid and refer to a documented test suite
+			if ($rawline =~ /^\+V:\s*(.*)/) {
+				my $name = $1;
+				if ($name =~ /@/) {
+					ERROR("TEST_NAME",
+					      "Test suite name cannot contain '@' character\n" . $herecurr);
+				}
+				if (!exists $tests{$name}) {
+					ERROR("TEST_NAME",
+					      "Test suite \"$name\" not documented in $testsrelfile\n" . $herecurr);
+				}
+			}
 		}
 
 		if (($realfile =~ /Makefile.*/ || $realfile =~ /Kbuild.*/) &&
diff --git a/scripts/get_maintainer.pl b/scripts/get_maintainer.pl
index 16d8ac6005b6f..d4ae27b67becb 100755
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
 
@@ -630,6 +633,7 @@ my %hash_list_to;
 my @list_to = ();
 my @scm = ();
 my @web = ();
+my @test = ();
 my @subsystem = ();
 my @status = ();
 my %deduplicate_name_hash = ();
@@ -661,6 +665,11 @@ if ($web) {
     output(@web);
 }
 
+if ($test) {
+    @test = uniq(@test);
+    output(@test);
+}
+
 exit($exit);
 
 sub self_test {
@@ -846,6 +855,7 @@ sub get_maintainers {
     @list_to = ();
     @scm = ();
     @web = ();
+    @test = ();
     @subsystem = ();
     @status = ();
     %deduplicate_name_hash = ();
@@ -1068,6 +1078,7 @@ MAINTAINER field selection options:
   --status => print status if any
   --subsystem => print subsystem name if any
   --web => print website(s) if any
+  --test => print test(s) if any
 
 Output type options:
   --separator [, ] => separator for multiple entries on 1 line
@@ -1378,6 +1389,8 @@ sub add_categories {
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


