Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1D3B3CDF
	for <lists+linux-kselftest@lfdr.de>; Fri, 25 Jun 2021 08:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbhFYHAp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Jun 2021 03:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhFYHAn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Jun 2021 03:00:43 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4E7C061574
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 23:58:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l132-20020a25258a0000b029054fc079d46eso2998324ybl.20
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Jun 2021 23:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=sT+c813HHmm0185Q/IxRevZGTihou63ahO6DGTxCJdw=;
        b=mE9xVW4RWRv8B7mn1exqKDfYLl+RFvNlr1iNXcqeIPaYAojma+lA17QqWpic2NV+Y0
         2iZru0fsgoDvshpyqVFyExcbu0qHqtn38wwdzBQb4uHtrS6X4bSy8Os/pMFPR9ICR+MO
         doTpds1GEDlnGx9OmlooJda0kwCMo+uKzZ0/OF/zyCaU/uBik9mXN275+goAnWpW7ZN1
         kYJ2px7MpmzwC0fwwImHOObGB6lt+DwaIyKn39Zt5Lmu+BpH3vQv2RKdgFgfp7ePSVmk
         66Cirie47RimesBICB3G6NlY+YH58lh4kaNrGgOxhrk/vR3zC00/Ayc4fjlKDYN/s5vW
         mqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=sT+c813HHmm0185Q/IxRevZGTihou63ahO6DGTxCJdw=;
        b=dpZQ2f0cJYM7VVi22jowj2QQwJfd/tfthuaebk83dT9XWYxHkK8NRuKwidv0fqeCE1
         clhKL7nsk0iZ67+j04wf48wD1AWd+rLrFECfQvvckvRabN7qk5Wjy40yt3m5os1shugS
         hvIyB3XZeabHo6kqzu2iNyFfbVfOZhJm/1WlCVCd2SEpCSf/XyIci4juqUvSGFIBECa7
         3gTU7rqDNkoIUCa3hytJqw/zjaQ8EG+6f6+smYTzVnHCygG09MHqUEKN5vBqJovHI406
         O0fHy75cG1rctSBEqKNKN/Xix0kZVu5++hGBRnv3bPI3frMqEcxF8UgD3TWlFJM3uBz9
         +LuQ==
X-Gm-Message-State: AOAM531hFbNh4olD8IVQutfR3SKdpisSOuQjqnCuqnMvzRsL0LJGmmxC
        ViPe+l+WdBFdGaGiNOVZDOu02UHUrnLgIw==
X-Google-Smtp-Source: ABdhPJzucZpPE+gAlNRpvXf4jrPS9PRMMqWLON0qYC3AGkHCkX4qwcyc3H6k6qRHlk1dsOPhJFe5Q7jgGN+KPw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:bd17:f9ad:979a:a3a9])
 (user=davidgow job=sendgmr) by 2002:a25:8003:: with SMTP id
 m3mr10151110ybk.30.1624604302809; Thu, 24 Jun 2021 23:58:22 -0700 (PDT)
Date:   Thu, 24 Jun 2021 23:58:13 -0700
In-Reply-To: <20210625065815.322131-1-davidgow@google.com>
Message-Id: <20210625065815.322131-2-davidgow@google.com>
Mime-Version: 1.0
References: <20210625065815.322131-1-davidgow@google.com>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH kunit-fixes v5 2/4] kunit: tool: Support skipped tests in kunit_tool
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marco Elver <elver@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for the SKIP directive to kunit_tool's TAP parser.

Skipped tests now show up as such in the printed summary. The number of
skipped tests is counted, and if all tests in a suite are skipped, the
suite is also marked as skipped. Otherwise, skipped tests do affect the
suite result.

Example output:
[00:22:34] ======== [SKIPPED] example_skip ========
[00:22:34] [SKIPPED] example_skip_test # SKIP this test should be skipped
[00:22:34] [SKIPPED] example_mark_skipped_test # SKIP this test should be skipped
[00:22:34] ============================================================
[00:22:34] Testing complete. 2 tests run. 0 failed. 0 crashed. 2 skipped.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since v4:
https://lore.kernel.org/linux-kselftest/20210611070802.1318911-2-davidgow@google.com/
- Rebased on top of kselftest/kunit-fixes as of c1610aae49 ("kunit: tool: internal refactor of parser input handling")
  - There were a couple of conflicts with that patch in kunit_parser.py, which have been resolved.

No changes since v3:
https://lore.kernel.org/linux-kselftest/20210608065052.610009-1-davidgow@google.com/

No changes since v2:
https://lore.kernel.org/linux-kselftest/20210528075932.347154-2-davidgow@google.com/

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210526081112.3652290-2-davidgow@google.com/
- Include missing test logs for kunit_tool_test
- Encapsulate test counts in a class (Thanks Daniel Latypov)
  - Fix a type hinting issue in the process


 tools/testing/kunit/kunit_parser.py           | 77 +++++++++++++------
 tools/testing/kunit/kunit_tool_test.py        | 22 ++++++
 .../kunit/test_data/test_skip_all_tests.log   | 15 ++++
 .../kunit/test_data/test_skip_tests.log       | 15 ++++
 4 files changed, 105 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_skip_all_tests.log
 create mode 100644 tools/testing/kunit/test_data/test_skip_tests.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 2b7dbba4fb7f..c3c524b79db8 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -43,6 +43,7 @@ class TestCase(object):
 class TestStatus(Enum):
 	SUCCESS = auto()
 	FAILURE = auto()
+	SKIPPED = auto()
 	TEST_CRASHED = auto()
 	NO_TESTS = auto()
 	FAILURE_TO_PARSE_TESTS = auto()
@@ -149,6 +150,8 @@ def save_non_diagnostic(lines: LineStream, test_case: TestCase) -> None:
 
 OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
+OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
+
 OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
@@ -166,6 +169,10 @@ def parse_ok_not_ok_test_case(lines: LineStream, test_case: TestCase) -> bool:
 	if match:
 		test_case.log.append(lines.pop())
 		test_case.name = match.group(2)
+		skip_match = OK_NOT_OK_SKIP.match(line)
+		if skip_match:
+			test_case.status = TestStatus.SKIPPED
+			return True
 		if test_case.status == TestStatus.TEST_CRASHED:
 			return True
 		if match.group(1) == 'ok':
@@ -229,16 +236,16 @@ def parse_subtest_plan(lines: LineStream) -> Optional[int]:
 		return None
 
 def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
-	if left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
+	if left == right:
+		return left
+	elif left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
 		return TestStatus.TEST_CRASHED
 	elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
 		return TestStatus.FAILURE
-	elif left != TestStatus.SUCCESS:
-		return left
-	elif right != TestStatus.SUCCESS:
+	elif left == TestStatus.SKIPPED:
 		return right
 	else:
-		return TestStatus.SUCCESS
+		return left
 
 def parse_ok_not_ok_test_suite(lines: LineStream,
 			       test_suite: TestSuite,
@@ -255,6 +262,9 @@ def parse_ok_not_ok_test_suite(lines: LineStream,
 			test_suite.status = TestStatus.SUCCESS
 		else:
 			test_suite.status = TestStatus.FAILURE
+		skip_match = OK_NOT_OK_SKIP.match(line)
+		if skip_match:
+			test_suite.status = TestStatus.SKIPPED
 		suite_index = int(match.group(2))
 		if suite_index != expected_suite_index:
 			print_with_timestamp(
@@ -265,8 +275,8 @@ def parse_ok_not_ok_test_suite(lines: LineStream,
 	else:
 		return False
 
-def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
-	return reduce(max_status, statuses, TestStatus.SUCCESS)
+def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
+	return reduce(max_status, status_list, TestStatus.SKIPPED)
 
 def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
@@ -352,37 +362,53 @@ def parse_test_result(lines: LineStream) -> TestResult:
 	else:
 		return TestResult(TestStatus.NO_TESTS, [], lines)
 
-def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
-	total_tests = 0
-	failed_tests = 0
-	crashed_tests = 0
+class TestCounts:
+	passed: int
+	failed: int
+	crashed: int
+	skipped: int
+
+	def __init__(self):
+		self.passed = 0
+		self.failed = 0
+		self.crashed = 0
+		self.skipped = 0
+
+	def total(self) -> int:
+		return self.passed + self.failed + self.crashed + self.skipped
+
+def print_and_count_results(test_result: TestResult) -> TestCounts:
+	counts = TestCounts()
 	for test_suite in test_result.suites:
 		if test_suite.status == TestStatus.SUCCESS:
 			print_suite_divider(green('[PASSED] ') + test_suite.name)
+		elif test_suite.status == TestStatus.SKIPPED:
+			print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
 		elif test_suite.status == TestStatus.TEST_CRASHED:
 			print_suite_divider(red('[CRASHED] ' + test_suite.name))
 		else:
 			print_suite_divider(red('[FAILED] ') + test_suite.name)
 		for test_case in test_suite.cases:
-			total_tests += 1
 			if test_case.status == TestStatus.SUCCESS:
+				counts.passed += 1
 				print_with_timestamp(green('[PASSED] ') + test_case.name)
+			elif test_case.status == TestStatus.SKIPPED:
+				counts.skipped += 1
+				print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
 			elif test_case.status == TestStatus.TEST_CRASHED:
-				crashed_tests += 1
+				counts.crashed += 1
 				print_with_timestamp(red('[CRASHED] ' + test_case.name))
 				print_log(map(yellow, test_case.log))
 				print_with_timestamp('')
 			else:
-				failed_tests += 1
+				counts.failed += 1
 				print_with_timestamp(red('[FAILED] ') + test_case.name)
 				print_log(map(yellow, test_case.log))
 				print_with_timestamp('')
-	return total_tests, failed_tests, crashed_tests
+	return counts
 
 def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
-	total_tests = 0
-	failed_tests = 0
-	crashed_tests = 0
+	counts = TestCounts()
 	lines = extract_tap_lines(kernel_output)
 	test_result = parse_test_result(lines)
 	if test_result.status == TestStatus.NO_TESTS:
@@ -390,12 +416,15 @@ def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
 	elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
 		print(red('[ERROR] ') + yellow('could not parse test results!'))
 	else:
-		(total_tests,
-		 failed_tests,
-		 crashed_tests) = print_and_count_results(test_result)
+		counts = print_and_count_results(test_result)
 	print_with_timestamp(DIVIDER)
-	fmt = green if test_result.status == TestStatus.SUCCESS else red
+	if test_result.status == TestStatus.SUCCESS:
+		fmt = green
+	elif test_result.status == TestStatus.SKIPPED:
+		fmt = yellow
+	else:
+		fmt =red
 	print_with_timestamp(
-		fmt('Testing complete. %d tests run. %d failed. %d crashed.' %
-		    (total_tests, failed_tests, crashed_tests)))
+		fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
+		    (counts.total(), counts.failed, counts.crashed, counts.skipped)))
 	return test_result
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 40ff281140d1..bdae0e5f6197 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -185,6 +185,28 @@ class KUnitParserTest(unittest.TestCase):
 			kunit_parser.TestStatus.TEST_CRASHED,
 			result.status)
 
+	def test_skipped_test(self):
+		skipped_log = test_data_path('test_skip_tests.log')
+		file = open(skipped_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+
+		# A skipped test does not fail the whole suite.
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+		file.close()
+
+	def test_skipped_all_tests(self):
+		skipped_log = test_data_path('test_skip_all_tests.log')
+		file = open(skipped_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+
+		self.assertEqual(
+			kunit_parser.TestStatus.SKIPPED,
+			result.status)
+		file.close()
+
+
 	def test_ignores_prefix_printk_time(self):
 		prefix_log = test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
diff --git a/tools/testing/kunit/test_data/test_skip_all_tests.log b/tools/testing/kunit/test_data/test_skip_all_tests.log
new file mode 100644
index 000000000000..2ea6e6d14fff
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_skip_all_tests.log
@@ -0,0 +1,15 @@
+TAP version 14
+1..2
+    # Subtest: string-stream-test
+    1..3
+    ok 1 - string_stream_test_empty_on_creation # SKIP all tests skipped
+    ok 2 - string_stream_test_not_empty_after_add # SKIP all tests skipped
+    ok 3 - string_stream_test_get_string # SKIP all tests skipped
+ok 1 - string-stream-test # SKIP
+    # Subtest: example
+    1..2
+    # example_simple_test: initializing
+    ok 1 - example_simple_test # SKIP all tests skipped
+    # example_skip_test: initializing
+    ok 2 - example_skip_test # SKIP this test should be skipped
+ok 2 - example # SKIP
diff --git a/tools/testing/kunit/test_data/test_skip_tests.log b/tools/testing/kunit/test_data/test_skip_tests.log
new file mode 100644
index 000000000000..79b326e31274
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_skip_tests.log
@@ -0,0 +1,15 @@
+TAP version 14
+1..2
+    # Subtest: string-stream-test
+    1..3
+    ok 1 - string_stream_test_empty_on_creation
+    ok 2 - string_stream_test_not_empty_after_add
+    ok 3 - string_stream_test_get_string
+ok 1 - string-stream-test
+    # Subtest: example
+    1..2
+    # example_simple_test: initializing
+    ok 1 - example_simple_test
+    # example_skip_test: initializing
+    ok 2 - example_skip_test # SKIP this test should be skipped
+ok 2 - example
-- 
2.32.0.93.g670b81a890-goog

