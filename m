Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBDDB391217
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 10:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhEZINK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 04:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232667AbhEZIMx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 04:12:53 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C23C061342
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 01:11:21 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id i12-20020ac860cc0000b02901cb6d022744so176739qtm.20
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 01:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zC0VjEIebXU/vHiFx345QbhW1ocgS/SgslGF3jZMPUU=;
        b=sUij9nv37oMzc0oF1n+m1Emj35hwuScrv4VIwPftsuWsFYNtraa9w50tn0Shz6RFFz
         skpr93cZDGQ/MUHEZvGnMjRFCJyJ52/eOPJ7lUdDpSy5sOfVpxBACmUudxf8zwK+bmUX
         AKSduGl4T0HQYX+bKxbHpYd4OuXgszdPfKPps7BJ5wZ0MIG+HYJ/AdhRPdnDgtBazxHd
         8RhhbD99VVJsrjwz+fLhz7YVL/Hzw7xi0jOzyS3xI0PQErsMX0sVTVq1KvM0PU+urE7d
         l/9PbOSQzZArzCu9okrXMB6vr1YXHhYD73I1/fzIrvCFOqceotlpamwOIrHKoDsfXgnZ
         pylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zC0VjEIebXU/vHiFx345QbhW1ocgS/SgslGF3jZMPUU=;
        b=tTm+8KTFdJmLISdwjson9oT8xXDdvTVEQMsSgSgitvWUHZhdsolvrXNwVxD6nAtmL8
         DqPURuiQRyGaAAL7FpHpVD9pN19P31CA+mlM1aAKkjqTsonIEmeFohwVy9Se6gY/Xalx
         YZbUlXGdWg7IWYbUHgyWnOtII1ZgUqp4RhviSYD9JyWoUZe4ll4ZahqbSEjJyCBX/X3S
         6zoMSnv0GcqlHh362iyqZv0mHv5Dotn/065FD8M+Az2XYY9ddkSo6YxgVXIhlBLBgtif
         84qbftQa2iAPLUJcBvmB+P1jgGH08mC0ZDbc1Xv8qEuetKPdOcQCkyzEsOqfa4Q41E5P
         DosA==
X-Gm-Message-State: AOAM531burc1mpL6Kj3buX3gA5hm2MPlSe6bjY1GsRfhuC1j88uKPZvy
        02sY+hfAAMyyJ8vk5Ok6KSvbiK3tIMvYpA==
X-Google-Smtp-Source: ABdhPJy6zUhQ6Z6Ot5BvpcV5R77SyArEoL0OBXtnsFnxGgebMbYX9Taznu+g2T2zEz6eXSgqzscnIJncWTmX+w==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:90cb:eafc:a44d:da3d])
 (user=davidgow job=sendgmr) by 2002:a0c:9e24:: with SMTP id
 p36mr41545289qve.60.1622016680599; Wed, 26 May 2021 01:11:20 -0700 (PDT)
Date:   Wed, 26 May 2021 01:11:11 -0700
In-Reply-To: <20210526081112.3652290-1-davidgow@google.com>
Message-Id: <20210526081112.3652290-2-davidgow@google.com>
Mime-Version: 1.0
References: <20210526081112.3652290-1-davidgow@google.com>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH 2/3] kunit: tool: Support skipped tests in kunit_tool
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Alan Maguire <alan.maguire@oracle.com>
Cc:     David Gow <davidgow@google.com>,
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
---
 tools/testing/kunit/kunit_parser.py    | 47 +++++++++++++++++++-------
 tools/testing/kunit/kunit_tool_test.py | 22 ++++++++++++
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index e8bcc139702e..6b5dd26b479d 100644
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
@@ -108,6 +109,8 @@ def save_non_diagnostic(lines: List[str], test_case: TestCase) -> None:
 
 OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
+OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
+
 OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
@@ -125,6 +128,10 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 	if match:
 		test_case.log.append(lines.pop(0))
 		test_case.name = match.group(2)
+		skip_match = OK_NOT_OK_SKIP.match(line)
+		if skip_match:
+			test_case.status = TestStatus.SKIPPED
+			return True
 		if test_case.status == TestStatus.TEST_CRASHED:
 			return True
 		if match.group(1) == 'ok':
@@ -188,16 +195,16 @@ def parse_subtest_plan(lines: List[str]) -> Optional[int]:
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
 
 def parse_ok_not_ok_test_suite(lines: List[str],
 			       test_suite: TestSuite,
@@ -214,6 +221,9 @@ def parse_ok_not_ok_test_suite(lines: List[str],
 			test_suite.status = TestStatus.SUCCESS
 		else:
 			test_suite.status = TestStatus.FAILURE
+		skip_match = OK_NOT_OK_SKIP.match(line)
+		if skip_match:
+			test_suite.status = TestStatus.SKIPPED
 		suite_index = int(match.group(2))
 		if suite_index != expected_suite_index:
 			print_with_timestamp(
@@ -224,8 +234,8 @@ def parse_ok_not_ok_test_suite(lines: List[str],
 	else:
 		return False
 
-def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
-	return reduce(max_status, statuses, TestStatus.SUCCESS)
+def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
+	return reduce(max_status, status_list, TestStatus.SKIPPED)
 
 def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
@@ -315,9 +325,12 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
 	total_tests = 0
 	failed_tests = 0
 	crashed_tests = 0
+	skipped_tests = 0
 	for test_suite in test_result.suites:
 		if test_suite.status == TestStatus.SUCCESS:
 			print_suite_divider(green('[PASSED] ') + test_suite.name)
+		elif test_suite.status == TestStatus.SKIPPED:
+			print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
 		elif test_suite.status == TestStatus.TEST_CRASHED:
 			print_suite_divider(red('[CRASHED] ' + test_suite.name))
 		else:
@@ -326,6 +339,9 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
 			total_tests += 1
 			if test_case.status == TestStatus.SUCCESS:
 				print_with_timestamp(green('[PASSED] ') + test_case.name)
+			elif test_case.status == TestStatus.SKIPPED:
+				skipped_tests += 1
+				print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
 			elif test_case.status == TestStatus.TEST_CRASHED:
 				crashed_tests += 1
 				print_with_timestamp(red('[CRASHED] ' + test_case.name))
@@ -336,12 +352,13 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
 				print_with_timestamp(red('[FAILED] ') + test_case.name)
 				print_log(map(yellow, test_case.log))
 				print_with_timestamp('')
-	return total_tests, failed_tests, crashed_tests
+	return total_tests, failed_tests, crashed_tests, skipped_tests
 
 def parse_run_tests(kernel_output) -> TestResult:
 	total_tests = 0
 	failed_tests = 0
 	crashed_tests = 0
+	skipped_tests = 0
 	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
 	if test_result.status == TestStatus.NO_TESTS:
 		print(red('[ERROR] ') + yellow('no tests run!'))
@@ -350,10 +367,16 @@ def parse_run_tests(kernel_output) -> TestResult:
 	else:
 		(total_tests,
 		 failed_tests,
-		 crashed_tests) = print_and_count_results(test_result)
+		 crashed_tests,
+		 skipped_tests) = print_and_count_results(test_result)
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
+		    (total_tests, failed_tests, crashed_tests, skipped_tests)))
 	return test_result
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 2e809dd956a7..a51e70cafcc1 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -183,6 +183,28 @@ class KUnitParserTest(unittest.TestCase):
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
-- 
2.31.1.818.g46aad6cb9e-goog

