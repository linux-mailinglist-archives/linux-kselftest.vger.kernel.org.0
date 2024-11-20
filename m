Return-Path: <linux-kselftest+bounces-22379-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC89D43EA
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 23:29:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC631F2225F
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Nov 2024 22:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 412B31BDAB5;
	Wed, 20 Nov 2024 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0UQ6LCop"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADB418A6B2
	for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 22:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732141749; cv=none; b=BUSqMpdEg9mXsqpPNOqs8Zfce6KuDSi7Xa9KhV/W4v7LtMeMuLZx0Twao96CARB+22bVNo+sjvKUu4SOf6lnoytwgJiaNaGO2U5SDIym+V9hzk0pGcSPCryxgtixeUrf/2OTQMQgDtjc95iAjumY6BL11Z0r4ab/H59RS24lIL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732141749; c=relaxed/simple;
	bh=dNs7zyleH5muBJk2j1dv70bkNTql38X5yiD3o4/G9/s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CiiFFHd/8AN3hT+HjjGYKuwaWaPLIKiqqQ9qFOl0Znz0mkW76dzUmzMAMtTCUWGXCcjIcNZg11ZEMfiHZGyY3I3WC4ka5FKCvufQwBQ7ddSvQ24HRKXGT1iOZ3j68IfuEbUHjhi1o1dUZfiu5VR19w2FjjI6h540qanraXh0GcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0UQ6LCop; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmoar.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6eeb754bc7cso3100957b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Nov 2024 14:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732141745; x=1732746545; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z19SPCdCvyg/Sfi8WLBvqOOaRMHvIMAmmrBlnIvZGlo=;
        b=0UQ6LCop+FUa5MVZ+kVcXLFDTrjVX5PEXcx0IJCL/YPXlImXWZQjHhJruU49nSeuV5
         ZIoIF5htzDhrnScYtpK+W6UUebzmf/6ysji6WSsWeczEDrN1m1xAJmUH4TOejoo5yp+d
         CGFn7uqaGfVMD2AanjV20V0o6SDQWVC/pZ1NpWqch4Cd9xIH1S9geU3sa7chXAcMeoFi
         oENJ0xmApD/JmwVPnilyjwitj/nnKIqkMZF3lulY3iOSkFTVsTmKwjlnzZgo4UaZe3Uf
         o+E/1ZnWRlQNwl6WikYT3gevUMcUbDyQLyHazbWyEFV5OwWaJs1IaUKEp8+oJXQDt1S9
         la4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732141745; x=1732746545;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z19SPCdCvyg/Sfi8WLBvqOOaRMHvIMAmmrBlnIvZGlo=;
        b=qkIX1iG9UlEOPNgRbqfQamiZWmMMy2sb9KFAxW3I17+g6sun28QCuuvAWJMbbOng4n
         L69pv3mHPY1EapjOBLsqyOkwF2o0HAAS8sg1XbhunTOeLRm0slVDQByzvDlt97GLX6Em
         CcUWxrJ6bg62I7/O/9PkoXhtgpDtTDK/O8trIDtxoesrtdTigC9Ry3Aixz3vpiACK50j
         +2juhujKDgMzz6s8957EfKnGAuQys/ezbx08VPd7C/oJkI8GF2guMNm7MbLxSQMf63t0
         k07xIi/VrUJzmAq0Amo/MuA7SHjeAIe9fVzHQwsITdssYW7vPgKaC1L6seniMIjw6K6C
         UENQ==
X-Gm-Message-State: AOJu0YwdE4h3Iyqj0PcJSUmfQs25tC+0SD4sUHcGt+BSrDw+4EBV2oqX
	/MShQZwjg3KwUgrIpDghNFS2thsS3IAuR5a4Vb9hUfbNdM8WtBjFzYhfRNM8vxf/Frjr6O/bTg=
	=
X-Google-Smtp-Source: AGHT+IH3OYPwESQunMIPXDAVmY0yzlGDWn8eWLUiiuZgzj5P3Fswciylc/4i5BIF2Dpu+akUsObcPzALRw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:d3:4d64:ac12:6a5d])
 (user=rmoar job=sendgmr) by 2002:a25:ab14:0:b0:e38:cc94:b252 with SMTP id
 3f1490d57ef6-e38cc94b49bmr1550276.10.1732141745405; Wed, 20 Nov 2024 14:29:05
 -0800 (PST)
Date: Wed, 20 Nov 2024 22:28:55 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241120222855.2317507-1-rmoar@google.com>
Subject: [PATCH] kunit: tool: add ability to parse test metadata
From: Rae Moar <rmoar@google.com>
To: shuah@kernel.org, davidgow@google.com, brendanhiggins@google.com
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"

Add ability for kunit parser to parse test metadata introduced in
KTAPv2.

Example of test metadata:

 KTAP version 2
 #:ktap_test: test_name_example
 #:ktap_speed: slow
 #:ktap_test_file: /sys/kernel/...
 1..1
 ok 1 test

Also add tests for this feature.

Note this patch would no longer allow the case where the main test is
missing a test plan and the subtest does not use a KTAP version line in
the header. However, this is also not an accepted KTAP format. Example:

 KTAP version 2
 // missing test plan
   // missing KTAP version line
   # Subtest: test_suite
   1..1
   ok 1 test
 ok 1 test_suite

Signed-off-by: Rae Moar <rmoar@google.com>
---
 lib/kunit/attributes.c                        | 23 ++++--
 lib/kunit/debugfs.c                           |  2 +-
 lib/kunit/test.c                              |  9 +--
 tools/testing/kunit/kunit_parser.py           | 79 +++++++++++++------
 tools/testing/kunit/kunit_tool_test.py        | 12 ++-
 .../test_is_test_passed-missing_plan.log      |  2 +
 .../kunit/test_data/test_parse_attributes.log |  6 +-
 .../kunit/test_data/test_parse_metadata.log   | 11 +++
 8 files changed, 106 insertions(+), 38 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_parse_metadata.log

diff --git a/lib/kunit/attributes.c b/lib/kunit/attributes.c
index 2cf04cc09372..85db4555d332 100644
--- a/lib/kunit/attributes.c
+++ b/lib/kunit/attributes.c
@@ -286,11 +286,17 @@ void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level
 {
 	int i;
 	bool to_free = false;
+	bool printed = false;
 	void *attr;
 	const char *attr_name, *attr_str;
 	struct kunit_suite *suite = is_test ? NULL : test_or_suite;
 	struct kunit_case *test = is_test ? test_or_suite : NULL;
 
+	if (suite) {
+		kunit_log(KERN_INFO, suite, "%*s#:ktap_test: %s",
+					KUNIT_INDENT_LEN * test_level, "", suite->name);
+	}
+
 	for (i = 0; i < ARRAY_SIZE(kunit_attr_list); i++) {
 		if (kunit_attr_list[i].print == PRINT_NEVER ||
 				(test && kunit_attr_list[i].print == PRINT_SUITE))
@@ -300,12 +306,19 @@ void kunit_print_attr(void *test_or_suite, bool is_test, unsigned int test_level
 			attr_name = kunit_attr_list[i].name;
 			attr_str = kunit_attr_list[i].to_string(attr, &to_free);
 			if (test) {
-				kunit_log(KERN_INFO, test, "%*s# %s.%s: %s",
-					KUNIT_INDENT_LEN * test_level, "", test->name,
-					attr_name, attr_str);
+				if (!printed) {
+					kunit_log(KERN_INFO, test, "%*s#:ktap_test: %s",
+							KUNIT_INDENT_LEN * test_level, "",
+							test->name);
+					printed = true;
+				}
+				kunit_log(KERN_INFO, test, "%*s#:ktap_%s: %s",
+						KUNIT_INDENT_LEN * test_level, "",
+						attr_name, attr_str);
 			} else {
-				kunit_log(KERN_INFO, suite, "%*s# %s: %s",
-					KUNIT_INDENT_LEN * test_level, "", attr_name, attr_str);
+				kunit_log(KERN_INFO, suite, "%*s#:ktap_%s: %s",
+						KUNIT_INDENT_LEN * test_level, "",
+						attr_name, attr_str);
 			}
 
 			/* Free to_string of attribute if needed */
diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
index af71911f4a07..035cdae9d8b8 100644
--- a/lib/kunit/debugfs.c
+++ b/lib/kunit/debugfs.c
@@ -78,7 +78,7 @@ static int debugfs_print_results(struct seq_file *seq, void *v)
 
 	/* Print suite header because it is not stored in the test logs. */
 	seq_puts(seq, KUNIT_SUBTEST_INDENT "KTAP version 1\n");
-	seq_printf(seq, KUNIT_SUBTEST_INDENT "# Subtest: %s\n", suite->name);
+	seq_printf(seq, KUNIT_SUBTEST_INDENT "#:ktap_test: %s\n", suite->name);
 	seq_printf(seq, KUNIT_SUBTEST_INDENT "1..%zd\n", kunit_suite_num_test_cases(suite));
 
 	kunit_suite_for_each_test_case(suite, test_case)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 089c832e3cdb..4fcc39e87983 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -158,8 +158,6 @@ static void kunit_print_suite_start(struct kunit_suite *suite)
 	 * representation.
 	 */
 	pr_info(KUNIT_SUBTEST_INDENT "KTAP version 1\n");
-	pr_info(KUNIT_SUBTEST_INDENT "# Subtest: %s\n",
-		  suite->name);
 	kunit_print_attr((void *)suite, false, KUNIT_LEVEL_CASE);
 	pr_info(KUNIT_SUBTEST_INDENT "1..%zd\n",
 		  kunit_suite_num_test_cases(suite));
@@ -627,9 +625,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 		if (test_case->status == KUNIT_SKIPPED) {
 			/* Test marked as skip */
 			test.status = KUNIT_SKIPPED;
+			kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
 			kunit_update_stats(&param_stats, test.status);
 		} else if (!test_case->generate_params) {
 			/* Non-parameterised test. */
+			kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
 			test_case->status = KUNIT_SKIPPED;
 			kunit_run_case_catch_errors(suite, test_case, &test);
 			kunit_update_stats(&param_stats, test.status);
@@ -641,7 +641,8 @@ int kunit_run_tests(struct kunit_suite *suite)
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
 				  "KTAP version 1\n");
 			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
-				  "# Subtest: %s", test_case->name);
+				  "#:ktap_test: %s", test_case->name);
+			kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
 
 			while (test.param_value) {
 				kunit_run_case_catch_errors(suite, test_case, &test);
@@ -669,8 +670,6 @@ int kunit_run_tests(struct kunit_suite *suite)
 			}
 		}
 
-		kunit_print_attr((void *)test_case, true, KUNIT_LEVEL_CASE);
-
 		kunit_print_test_stats(&test, param_stats);
 
 		kunit_print_ok_not_ok(&test, KUNIT_LEVEL_CASE, test_case->status,
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 29fc27e8949b..52dcbad52ade 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -247,7 +247,7 @@ def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
 				yield line_num, line
 	return LineStream(lines=isolate_ktap_output(kernel_output))
 
-KTAP_VERSIONS = [1]
+KTAP_VERSIONS = [1, 2]
 TAP_VERSIONS = [13, 14]
 
 def check_version(version_num: int, accepted_versions: List[int],
@@ -324,6 +324,39 @@ def parse_test_header(lines: LineStream, test: Test) -> bool:
 	lines.pop()
 	return True
 
+TEST_METADATA_HEADER = re.compile(r'^\s*#:ktap_test: (.*)$')
+TEST_METADATA = re.compile(r'^\s*#:(ktap_.*): (.*)$')
+
+def parse_test_metadata(lines: LineStream, test: Test) -> bool:
+	"""
+	Parses test metadata and stores test information in test object.
+	Returns False if fails to parse test metadata lines
+
+	Accepted format:
+	- '# [metadata_category]: [metadata]'
+
+	Recognized metadata categories:
+	- 'ktap_test' to indicate test name
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
+
+	Return:
+	True if successfully parsed test metadata
+	"""
+	match = TEST_METADATA_HEADER.match(lines.peek())
+	if not match:
+		return False
+	test.name = match.group(1)
+	test.log.append(lines.pop())
+	non_metadata_lines = [TEST_PLAN, TEST_RESULT, KTAP_START]
+	while lines and not any(re.match(lines.peek())
+			for re in non_metadata_lines):
+		# Add checks for metadata cateories here: Attributes, Files, Other...
+		test.log.append(lines.pop())
+	return True
+
 TEST_PLAN = re.compile(r'^\s*1\.\.([0-9]+)')
 
 def parse_test_plan(lines: LineStream, test: Test) -> bool:
@@ -442,6 +475,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 
 	Line formats that are not parsed:
 	- '# Subtest: [test name]'
+	- '#:ktap_test: [test name]'
 	- '[ok|not ok] [test number] [-] [test name] [optional skip
 		directive]'
 	- 'KTAP version [version number]'
@@ -453,7 +487,8 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	Log of diagnostic lines
 	"""
 	log = []  # type: List[str]
-	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START, TEST_PLAN]
+	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START,
+						 TEST_PLAN, TEST_METADATA_HEADER]
 	while lines and not any(re.match(lines.peek())
 			for re in non_diagnostic_lines):
 		log.append(lines.pop())
@@ -504,7 +539,7 @@ def print_test_header(test: Test, printer: Printer) -> None:
 	message = test.name
 	if message != "":
 		# Add a leading space before the subtest counts only if a test name
-		# is provided using a "# Subtest" header line.
+		# is provided using a "#:ktap_test" or "# Subtest" header line.
 		message += " "
 	if test.expected_count:
 		if test.expected_count == 1:
@@ -702,6 +737,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 	Example:
 
 	KTAP version 1
+	[test metadata]
 	1..4
 	[subtests]
 
@@ -709,10 +745,11 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 	  "# Subtest" header line)
 
 	Example (preferred format with both KTAP version line and
-	"# Subtest" line):
+	"#:ktap_test" line):
 
 	KTAP version 1
-	# Subtest: name
+	#:ktap_test: name
+	[test metadata]
 	1..3
 	[subtests]
 	ok 1 name
@@ -727,6 +764,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 	Example (only KTAP version line, compliant with KTAP v1 spec):
 
 	KTAP version 1
+	[test metadata]
 	1..3
 	[subtests]
 	ok 1 name
@@ -755,26 +793,23 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest:
 	err_log = parse_diagnostic(lines)
 	test.log.extend(err_log)
 
-	if not is_subtest:
-		# If parsing the main/top-level test, parse KTAP version line and
-		# test plan
-		test.name = "main"
-		ktap_line = parse_ktap_header(lines, test, printer)
-		test.log.extend(parse_diagnostic(lines))
-		parse_test_plan(lines, test)
-		parent_test = True
-	else:
-		# If not the main test, attempt to parse a test header containing
-		# the KTAP version line and/or subtest header line
-		ktap_line = parse_ktap_header(lines, test, printer)
-		subtest_line = parse_test_header(lines, test)
+	# If parsing the main/top-level test, parse KTAP version line, any
+	# test metadata, and test plan
+	ktap_line = parse_ktap_header(lines, test, printer)
+	subtest_line = parse_test_header(lines, test)
+	parse_test_metadata(lines, test)
+	parse_test_plan(lines, test)
+
+	# Determine if the test is a parent test
+	if is_subtest:
 		parent_test = (ktap_line or subtest_line)
 		if parent_test:
-			# If KTAP version line and/or subtest header is found, attempt
-			# to parse test plan and print test header
-			test.log.extend(parse_diagnostic(lines))
-			parse_test_plan(lines, test)
 			print_test_header(test, printer)
+	else:
+		parent_test = True
+		if test.name == "":
+			test.name = "main"
+
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 0bcb0cc002f8..6ff422399130 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -345,8 +345,8 @@ class KUnitParserTest(unittest.TestCase):
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
 
 		# Ensure attributes in correct test log
-		self.assertContains('# module: example', result.subtests[0].log)
-		self.assertContains('# test.speed: slow', result.subtests[0].subtests[0].log)
+		self.assertContains('#:ktap_module: example', result.subtests[0].log)
+		self.assertContains('#:ktap_speed: slow', result.subtests[0].subtests[0].log)
 
 	def test_show_test_output_on_failure(self):
 		output = """
@@ -363,6 +363,14 @@ class KUnitParserTest(unittest.TestCase):
 		self.print_mock.assert_any_call(StrContains('  Indented more.'))
 		self.noPrintCallContains('not ok 1 test1')
 
+	def test_metadata(self):
+		name_log = test_data_path('test_parse_metadata.log')
+		with open(name_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual("main_test", result.name)
+		self.assertContains("#:ktap_speed: slow", result.subtests[0].log)
+
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
 
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
index 5cd17b7f818a..1e952b0430e1 100644
--- a/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
+++ b/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
@@ -1,4 +1,5 @@
 KTAP version 1
+	KTAP version 1
 	# Subtest: sysctl_test
 	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
 	ok 1 - sysctl_test_dointvec_null_tbl_data
@@ -18,6 +19,7 @@ KTAP version 1
 	ok 8 - sysctl_test_dointvec_single_greater_int_max
 kunit sysctl_test: all tests passed
 ok 1 - sysctl_test
+	KTAP version 1
 	# Subtest: example
 	1..2
 init_suite
diff --git a/tools/testing/kunit/test_data/test_parse_attributes.log b/tools/testing/kunit/test_data/test_parse_attributes.log
index 1a13c371fe9d..d7961422c66f 100644
--- a/tools/testing/kunit/test_data/test_parse_attributes.log
+++ b/tools/testing/kunit/test_data/test_parse_attributes.log
@@ -1,9 +1,9 @@
 KTAP version 1
 1..1
   KTAP version 1
-  # Subtest: suite
-  # module: example
+  #:ktap_test: suite
+  #:ktap_module: example
   1..1
-  # test.speed: slow
+  #:ktap_speed: slow
   ok 1 test
 ok 1 suite
\ No newline at end of file
diff --git a/tools/testing/kunit/test_data/test_parse_metadata.log b/tools/testing/kunit/test_data/test_parse_metadata.log
new file mode 100644
index 000000000000..2094867110e5
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_parse_metadata.log
@@ -0,0 +1,11 @@
+KTAP version 2
+#:ktap_test: main_test
+#:ktap_module: example
+1..2
+  KTAP version 2
+  #:ktap_test: test_1
+  #:ktap_speed: slow
+  1..1
+  ok 1 subtest_1
+ok 1 test_1
+ok 2 test_2
\ No newline at end of file

base-commit: 62adcae479fe5bc04fa3b6c3f93bd340441f8b25
-- 
2.47.0.338.g60cca15819-goog


