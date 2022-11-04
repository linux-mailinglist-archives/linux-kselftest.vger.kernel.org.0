Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF0861A171
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Nov 2022 20:48:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiKDTsO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Nov 2022 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiKDTsN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Nov 2022 15:48:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E52C64E
        for <linux-kselftest@vger.kernel.org>; Fri,  4 Nov 2022 12:48:11 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-36f8318e4d0so55099227b3.20
        for <linux-kselftest@vger.kernel.org>; Fri, 04 Nov 2022 12:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YmVRWe+ZTvwocJ5amMSffx0ArVbnRwoqLEK5+eLfveU=;
        b=jlNwOGLxD0ZiiRzt9L5CK1CIgnMFD1Ckz7GE1zr0Y8clOhfuxHMOrSYu5cOtErUNaB
         jBNAE3PPRVGCDl6ZjOfWBOdfslMVmsgQThSWS3UvVdKAACpTPrkVfy2kXngFwX3nlvup
         beg1Lt2JWfvIvE580th65ST33V46vAqANvBijnpUQn2NU3WsT95Xkm1wQ531nUtVS/aQ
         6mOnqGjD30XiJsQduYOHGHJTdHVJtnyxCP0G64OIG7E6z0m1ogoI/AMTX8RfBKu9jj8g
         dISoDNGZPsezZ675elUOR3Kril2TtHvqU6V5A2/gs/PHQpG8BdegcgTnV3TpovWrt/HF
         aq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YmVRWe+ZTvwocJ5amMSffx0ArVbnRwoqLEK5+eLfveU=;
        b=msoJGi07ZDY5UGEp3YOHedC15fbb6ZM3/sR7C06TlwM97t3WZ8M9AzfaZO5ycR6lEH
         /9yPQjtElpZMHMLbB6rIuvipUP28L8l3bR6Iq4rCcJgsig2Htd4ULgNbuTyV6n0JS+Cj
         ud7oQhpaNVW1gIhy7GvtShfDZyYTV02s+iBJNIplRlZw5/qK9i7OShbx7FdKcuIYZcmC
         VC1yUHNKTVzt07fLtp4FzXf2cbtuJr/4d8nskkr9nokZzGml/Egjs3X6u2CMGvKmAOfD
         ATxG0wASPAWIbEbaKOJdnuwhJNblAtMYT6aQdYKZk2vuYEdN0Q419l9YSOqxTHdrAl4K
         EiAQ==
X-Gm-Message-State: ACrzQf27owfK1d51bca/ftzbp6VUzL4dh18gyDriGv36csKxGHYbSjnx
        qVZAz/MAjUY7RCgQwBtP8zb+APvSBA==
X-Google-Smtp-Source: AMsMyM4/jPA/yYgxJ+uh7v5hYcn8VQ1YgzKTIFd1WNlYq2WWgE46cxveKEPxKfb4/NUiNiYFYfF15SAqCg==
X-Received: from rmoar.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:4259])
 (user=rmoar job=sendgmr) by 2002:a25:4fc2:0:b0:6be:afb4:d392 with SMTP id
 d185-20020a254fc2000000b006beafb4d392mr33870585ybb.604.1667591291143; Fri, 04
 Nov 2022 12:48:11 -0700 (PDT)
Date:   Fri,  4 Nov 2022 19:47:05 +0000
In-Reply-To: <20221104194705.3245738-1-rmoar@google.com>
Mime-Version: 1.0
References: <20221104194705.3245738-1-rmoar@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221104194705.3245738-2-rmoar@google.com>
Subject: [PATCH v1 2/2] kunit: tool: parse KTAP compliant test output
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, mauro.chehab@linux.intel.com,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Change the KUnit parser to be able to parse test output that complies with
the KTAP version 1 specification format found here:
https://kernel.org/doc/html/latest/dev-tools/ktap.html. Ensure the parser
is able to parse tests with the original KUnit test output format as
well.

KUnit parser now accepts any of the following test output formats:

Original KUnit test output format:

 TAP version 14
 1..1
   # Subtest: kunit-test-suite
   1..3
   ok 1 - kunit_test_1
   ok 2 - kunit_test_2
   ok 3 - kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 - kunit-test-suite

KTAP version 1 test output format:

 KTAP version 1
 1..1
   KTAP version 1
   1..3
   ok 1 kunit_test_1
   ok 2 kunit_test_2
   ok 3 kunit_test_3
 ok 1 kunit-test-suite

New KUnit test output format (preferred for KUnit tests):

 KTAP version 1
 1..1
   # Subtest: kunit-test-suite
   KTAP version 1
   1..3
   ok 1 kunit_test_1
   ok 2 kunit_test_2
   ok 3 kunit_test_3
 # kunit-test-suite: pass:3 fail:0 skip:0 total:3
 # Totals: pass:3 fail:0 skip:0 total:3
 ok 1 kunit-test-suite

Signed-off-by: Rae Moar <rmoar@google.com>
---
Note: this patch is based on the linux-kselftest/kunit branch.
---
tools/testing/kunit/kunit_parser.py           | 69 ++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py        |  8 +++
 .../test_data/test_parse_ktap_output.log      |  8 +++
 3 files changed, 60 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_parse_ktap_output.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index a56c75a973b5..abb69f898263 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -441,6 +441,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	- '# Subtest: [test name]'
 	- '[ok|not ok] [test number] [-] [test name] [optional skip
 		directive]'
+	- 'KTAP version [version number]'
 
 	Parameters:
 	lines - LineStream of KTAP output to parse
@@ -449,8 +450,9 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	Log of diagnostic lines
 	"""
 	log = []  # type: List[str]
-	while lines and not TEST_RESULT.match(lines.peek()) and not \
-			TEST_HEADER.match(lines.peek()):
+	non_diagnostic_lines = [TEST_RESULT, TEST_HEADER, KTAP_START]
+	while lines and not any(re.match(lines.peek())
+			for re in non_diagnostic_lines):
 		log.append(lines.pop())
 	return log
 
@@ -496,6 +498,12 @@ def print_test_header(test: Test) -> None:
 	test - Test object representing current test being printed
 	"""
 	message = test.name
+	if message == "":
+		# KUnit tests print a Subtest header line that provides the name
+		# of the test suite. But the subtest header line isn't required
+		# by the KTAP spec, so use a placeholder name "Test suite" in that
+		# case.
+		message = "Test suite"
 	if test.expected_count:
 		if test.expected_count == 1:
 			message += ' (1 subtest)'
@@ -647,13 +655,13 @@ def bubble_up_test_results(test: Test) -> None:
 	elif test.counts.get_status() == TestStatus.TEST_CRASHED:
 		test.status = TestStatus.TEST_CRASHED
 
-def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
+def parse_test(lines: LineStream, expected_num: int, log: List[str], is_subtest: bool) -> Test:
 	"""
 	Finds next test to parse in LineStream, creates new Test object,
 	parses any subtests of the test, populates Test object with all
 	information (status, name) about the test and the Test objects for
 	any subtests, and then returns the Test object. The method accepts
-	three formats of tests:
+	four formats of tests:
 
 	Accepted test formats:
 
@@ -674,6 +682,16 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 	[subtests]
 	ok 1 name
 
+	- KTAP subtest header (in compliance with KTAP specification)
+
+	Example:
+
+    # May include subtest header line here
+	KTAP version 1
+	1..3
+	[subtests]
+	ok 1 name
+
 	- Test result line
 
 	Example:
@@ -685,6 +703,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 	expected_num - expected test number for test to be parsed
 	log - list of strings containing any preceding diagnostic lines
 		corresponding to the current test
+	is_subtest - boolean indicating whether test is a subtest
 
 	Return:
 	Test object populated with characteristics and any subtests
@@ -692,21 +711,22 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 	test = Test()
 	test.log.extend(log)
 	parent_test = False
-	main = parse_ktap_header(lines, test)
-	if main:
-		# If KTAP/TAP header is found, attempt to parse
-		# test plan
+	if not is_subtest:
+		# If parsing the main test, attempt to parse KTAP/TAP header
+		# and test plan
 		test.name = "main"
+		parse_ktap_header(lines, test)
 		parse_test_plan(lines, test)
 		parent_test = True
 	else:
-		# If KTAP/TAP header is not found, test must be subtest
-		# header or test result line so parse attempt to parser
-		# subtest header
-		parent_test = parse_test_header(lines, test)
+		# If test is a subtest, attempt to parse test suite header
+		# (either subtest line and/or KTAP/TAP version line)
+		subtest_line = parse_test_header(lines, test)
+		ktap_line = parse_ktap_header(lines, test)
+		parent_test = subtest_line or ktap_line
 		if parent_test:
-			# If subtest header is found, attempt to parse
-			# test plan and print header
+			# If subtest header and/or KTAP/version line is found, attempt
+			# to parse test plan and print header
 			parse_test_plan(lines, test)
 			print_test_header(test)
 	expected_count = test.expected_count
@@ -721,7 +741,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 		sub_log = parse_diagnostic(lines)
 		sub_test = Test()
 		if not lines or (peek_test_name_match(lines, test) and
-				not main):
+				is_subtest):
 			if expected_count and test_num <= expected_count:
 				# If parser reaches end of test before
 				# parsing expected number of subtests, print
@@ -735,20 +755,19 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 				test.log.extend(sub_log)
 				break
 		else:
-			sub_test = parse_test(lines, test_num, sub_log)
+			sub_test = parse_test(lines, test_num, sub_log, True)
 		subtests.append(sub_test)
 		test_num += 1
 	test.subtests = subtests
-	if not main:
+	if is_subtest:
 		# If not main test, look for test result line
 		test.log.extend(parse_diagnostic(lines))
-		if (parent_test and peek_test_name_match(lines, test)) or \
-				not parent_test:
-			parse_test_result(lines, test, expected_num)
-		else:
+		if subtest_line and not peek_test_name_match(lines, test):
 			test.add_error('missing subtest result line!')
+		else:
+			parse_test_result(lines, test, expected_num)
 
-	# Check for there being no tests
+	# Check for there being no subtests within parent test
 	if parent_test and len(subtests) == 0:
 		# Don't override a bad status if this test had one reported.
 		# Assumption: no subtests means CRASHED is from Test.__init__()
@@ -758,11 +777,11 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 
 	# Add statuses to TestCounts attribute in Test object
 	bubble_up_test_results(test)
-	if parent_test and not main:
+	if parent_test and is_subtest:
 		# If test has subtests and is not the main test object, print
 		# footer.
 		print_test_footer(test)
-	elif not main:
+	elif is_subtest:
 		print_test_result(test)
 	return test
 
@@ -785,7 +804,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 		test.add_error('could not find any KTAP output!')
 		test.status = TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
-		test = parse_test(lines, 0, [])
+		test = parse_test(lines, 0, [], False)
 		if test.status != TestStatus.NO_TESTS:
 			test.status = test.counts.get_status()
 	stdout.print_with_timestamp(DIVIDER)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 90c65b072be9..7c2e2a45f330 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -312,6 +312,14 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser._summarize_failed_tests(result),
 			'Failures: all_failed_suite, some_failed_suite.test2')
 
+	def test_ktap_format(self):
+		ktap_log = test_data_path('test_parse_ktap_output.log')
+		with open(ktap_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3))
+		self.assertEqual('suite', result.subtests[0].name)
+		self.assertEqual('case_1', result.subtests[0].subtests[0].name)
+		self.assertEqual('case_2', result.subtests[0].subtests[1].name)
 
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
diff --git a/tools/testing/kunit/test_data/test_parse_ktap_output.log b/tools/testing/kunit/test_data/test_parse_ktap_output.log
new file mode 100644
index 000000000000..ccdf244e5303
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_parse_ktap_output.log
@@ -0,0 +1,8 @@
+KTAP version 1
+1..1
+  KTAP version 1
+  1..3
+  ok 1 case_1
+  ok 2 case_2
+  ok 3 case_3
+ok 1 suite
-- 
2.38.1.431.g37b22c650d-goog

