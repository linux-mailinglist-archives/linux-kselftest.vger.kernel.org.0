Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9499C391256
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 May 2021 10:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhEZIbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 May 2021 04:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbhEZIbV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 May 2021 04:31:21 -0400
Received: from mail-vs1-xe49.google.com (mail-vs1-xe49.google.com [IPv6:2607:f8b0:4864:20::e49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C643C061574
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 01:29:50 -0700 (PDT)
Received: by mail-vs1-xe49.google.com with SMTP id t3-20020a67d9030000b02902367c8db155so35459vsj.19
        for <linux-kselftest@vger.kernel.org>; Wed, 26 May 2021 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=uv/7bltUeushyiUJI3XMV8ebb17Dm4iR1F3Nn+e+GG4=;
        b=HP9Wh4GPFhP/5zteaCXmMTThWMuVJ8X7JJwEito+EIZPPaBDoWa9hIGrmSIt/jlkxv
         F74hcPL2E19TJXa4xvSL2+ibMtfgSA//8I8x4m4zoepAg+/pHyCBS3jI81ZX9IXZWFQw
         Ne/69OWEarZFmp1RGO1ZNr6pHlM22VFD+iUugLL1swYZNfzexRrvbaCOdFKhEWzLnH/h
         6+jdYkYkFVoyTmBP6mLscpXuMZKNlvBmByd3VfsQvZPtYN+C2vZFdJS0uLscUEaIjjBo
         e/GKUMyUyxYATtqDLtI1IEwRZvlIlIhjuYwYH0JQjlHut80dQ0uf/3qPdCyrcojeoZF2
         ixdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=uv/7bltUeushyiUJI3XMV8ebb17Dm4iR1F3Nn+e+GG4=;
        b=tztgRthGoGDqg6fPnl60TQhCJUE1PNQnLq3Kpk047hda0aoTO7rUJ/OpG9Scqx501h
         kOcdl2hIlXOtdnNYr4Q0B9w7kqSS+/cdaogRlRy0NrqT0vFnExKbDW1vTV8s38SxOvO1
         2+s0H63+iML8p0lCmBYiuZWzZpsUr4eTGXTUzrMmYsOY1zPIo00OC5IECzGGdAlJ5V6w
         P2rmRUsIlRFn6ZsHYChoG1xg6JJuXzDuf1YRtwsM2pIfM1D5g63LssmIPaQhz/nR6qh7
         d1l1akg80qz6PUWNSOMja64/R28sQ6lg/yhAJca2IKTvbu/gIQCfzEP3CaywaQeMPPD/
         TeVg==
X-Gm-Message-State: AOAM533YuUn6XNfUIPyvMDh7GPaEhhV4Sz0sbx1JoIrO8SDNA/unz+3k
        dph5lXqhz/Ev267HFtYciI1fd2v9K6gXpw==
X-Google-Smtp-Source: ABdhPJxw24SEfSwnGGnfSI3l/Ql7bMz2BXzHpE/dKZKoLXKepuPlWPnet+dWdzhGGAvwoLo9l8dlYm0HN2CP3w==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7196:39a3:ddf7:eeb7])
 (user=dlatypov job=sendgmr) by 2002:a25:cc5:: with SMTP id
 188mr46384197ybm.59.1622017345378; Wed, 26 May 2021 01:22:25 -0700 (PDT)
Date:   Wed, 26 May 2021 01:22:17 -0700
Message-Id: <20210526082217.333194-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
Subject: [PATCH v2] kunit: tool: internal refactor of parser input handling
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Note: this does not change the parser behavior at all (except for making
one error message more useful). This is just an internal refactor.

The TAP output parser currently operates over a List[str].
This works, but we only ever need to be able to "peek" at the current
line and the ability to "pop" it off.

Also, using a List means we need to wait for all the output before we
can start parsing. While this is not an issue for most tests which are
really lightweight, we do have some longer (~5 minutes) tests.

This patch introduces an LineStream wrapper class that
* Exposes a peek()/pop() interface instead of manipulating an array
  * this allows us to more easily add debugging code [1]
* Can consume an input from a generator
  * we can now parse results as tests are running (the parser code
  currently doesn't print until the end, so no impact yet).
* Tracks the current line number to print better error messages
* Would allow us to add additional features more easily, e.g. storing
  N previous lines so we can print out invalid lines in context, etc.

[1] The parsing logic is currently quite fragile.
E.g. it'll often say the kernel "CRASHED" if there's something slightly
wrong with the output format. When debugging a test that had some memory
corruption issues, it resulted in very misleading errors from the parser.

Now we could easily add this to trace all the lines consumed and why
+import inspect
...
        def pop(self) -> str:
                n = self._next
+               print(f'popping {n[0]}: {n[1].ljust(40, " ")}| caller={inspect.stack()[1].function}')

Example output:
popping 77: TAP version 14                          | caller=parse_tap_header
popping 78: 1..1                                    | caller=parse_test_plan
popping 79:     # Subtest: kunit_executor_test      | caller=parse_subtest_header
popping 80:     1..2                                | caller=parse_subtest_plan
popping 81:     ok 1 - parse_filter_test            | caller=parse_ok_not_ok_test_case
popping 82:     ok 2 - filter_subsuite_test         | caller=parse_ok_not_ok_test_case
popping 83: ok 1 - kunit_executor_test              | caller=parse_ok_not_ok_test_suite

If we introduce an invalid line, we can see the parser go down the wrong path:
popping 77: TAP version 14                          | caller=parse_tap_header
popping 78: 1..1                                    | caller=parse_test_plan
popping 79:     # Subtest: kunit_executor_test      | caller=parse_subtest_header
popping 80:     1..2                                | caller=parse_subtest_plan
popping 81:     1..2 # this is invalid!             | caller=parse_ok_not_ok_test_case
popping 82:     ok 1 - parse_filter_test            | caller=parse_ok_not_ok_test_case
popping 83:     ok 2 - filter_subsuite_test         | caller=parse_ok_not_ok_test_case
popping 84: ok 1 - kunit_executor_test              | caller=parse_ok_not_ok_test_case
[ERROR] ran out of lines before end token

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2:
* class Input => class LineStream
* get_input() => extract_tap_lines()
---
 tools/testing/kunit/kunit_parser.py    | 136 ++++++++++++++++---------
 tools/testing/kunit/kunit_tool_test.py |  18 ++--
 2 files changed, 99 insertions(+), 55 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index e8bcc139702e..370c0862cc1e 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -47,22 +47,63 @@ class TestStatus(Enum):
 	NO_TESTS = auto()
 	FAILURE_TO_PARSE_TESTS = auto()
 
+class LineStream:
+	"""Provides a peek()/pop() interface over an iterator of (line#, text)."""
+	_lines: Iterator[Tuple[int, str]]
+	_next: Tuple[int, str]
+	_done: bool
+
+	def __init__(self, lines: Iterator[Tuple[int, str]]):
+		self._lines = lines
+		self._done = False
+		self._next = (0, '')
+		self._get_next()
+
+	def _get_next(self) -> None:
+		try:
+			self._next = next(self._lines)
+		except StopIteration:
+			self._done = True
+
+	def peek(self) -> str:
+		return self._next[1]
+
+	def pop(self) -> str:
+		n = self._next
+		self._get_next()
+		return n[1]
+
+	def __bool__(self) -> bool:
+		return not self._done
+
+	# Only used by kunit_tool_test.py.
+	def __iter__(self) -> Iterator[str]:
+		while bool(self):
+			yield self.pop()
+
+	def line_number(self) -> int:
+		return self._next[0]
+
 kunit_start_re = re.compile(r'TAP version [0-9]+$')
 kunit_end_re = re.compile('(List of all partitions:|'
 			  'Kernel panic - not syncing: VFS:)')
 
-def isolate_kunit_output(kernel_output) -> Iterator[str]:
-	started = False
-	for line in kernel_output:
-		line = line.rstrip()  # line always has a trailing \n
-		if kunit_start_re.search(line):
-			prefix_len = len(line.split('TAP version')[0])
-			started = True
-			yield line[prefix_len:] if prefix_len > 0 else line
-		elif kunit_end_re.search(line):
-			break
-		elif started:
-			yield line[prefix_len:] if prefix_len > 0 else line
+def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
+	def isolate_kunit_output(kernel_output: Iterable[str]) -> Iterator[Tuple[int, str]]:
+		line_num = 0
+		started = False
+		for line in kernel_output:
+			line_num += 1
+			line = line.rstrip()  # line always has a trailing \n
+			if kunit_start_re.search(line):
+				prefix_len = len(line.split('TAP version')[0])
+				started = True
+				yield line_num, line[prefix_len:]
+			elif kunit_end_re.search(line):
+				break
+			elif started:
+				yield line_num, line[prefix_len:]
+	return LineStream(lines=isolate_kunit_output(kernel_output))
 
 def raw_output(kernel_output) -> None:
 	for line in kernel_output:
@@ -97,14 +138,14 @@ def print_log(log) -> None:
 
 TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
 
-def consume_non_diagnostic(lines: List[str]) -> None:
-	while lines and not TAP_ENTRIES.match(lines[0]):
-		lines.pop(0)
+def consume_non_diagnostic(lines: LineStream) -> None:
+	while lines and not TAP_ENTRIES.match(lines.peek()):
+		lines.pop()
 
-def save_non_diagnostic(lines: List[str], test_case: TestCase) -> None:
-	while lines and not TAP_ENTRIES.match(lines[0]):
-		test_case.log.append(lines[0])
-		lines.pop(0)
+def save_non_diagnostic(lines: LineStream, test_case: TestCase) -> None:
+	while lines and not TAP_ENTRIES.match(lines.peek()):
+		test_case.log.append(lines.peek())
+		lines.pop()
 
 OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
 
@@ -112,18 +153,18 @@ OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
 
-def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
+def parse_ok_not_ok_test_case(lines: LineStream, test_case: TestCase) -> bool:
 	save_non_diagnostic(lines, test_case)
 	if not lines:
 		test_case.status = TestStatus.TEST_CRASHED
 		return True
-	line = lines[0]
+	line = lines.peek()
 	match = OK_NOT_OK_SUBTEST.match(line)
 	while not match and lines:
-		line = lines.pop(0)
+		line = lines.pop()
 		match = OK_NOT_OK_SUBTEST.match(line)
 	if match:
-		test_case.log.append(lines.pop(0))
+		test_case.log.append(lines.pop())
 		test_case.name = match.group(2)
 		if test_case.status == TestStatus.TEST_CRASHED:
 			return True
@@ -138,14 +179,14 @@ def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
 SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
 DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
 
-def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
+def parse_diagnostic(lines: LineStream, test_case: TestCase) -> bool:
 	save_non_diagnostic(lines, test_case)
 	if not lines:
 		return False
-	line = lines[0]
+	line = lines.peek()
 	match = SUBTEST_DIAGNOSTIC.match(line)
 	if match:
-		test_case.log.append(lines.pop(0))
+		test_case.log.append(lines.pop())
 		crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
 		if crash_match:
 			test_case.status = TestStatus.TEST_CRASHED
@@ -153,7 +194,7 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-def parse_test_case(lines: List[str]) -> Optional[TestCase]:
+def parse_test_case(lines: LineStream) -> Optional[TestCase]:
 	test_case = TestCase()
 	save_non_diagnostic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
@@ -165,24 +206,24 @@ def parse_test_case(lines: List[str]) -> Optional[TestCase]:
 
 SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
 
-def parse_subtest_header(lines: List[str]) -> Optional[str]:
+def parse_subtest_header(lines: LineStream) -> Optional[str]:
 	consume_non_diagnostic(lines)
 	if not lines:
 		return None
-	match = SUBTEST_HEADER.match(lines[0])
+	match = SUBTEST_HEADER.match(lines.peek())
 	if match:
-		lines.pop(0)
+		lines.pop()
 		return match.group(1)
 	else:
 		return None
 
 SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
-def parse_subtest_plan(lines: List[str]) -> Optional[int]:
+def parse_subtest_plan(lines: LineStream) -> Optional[int]:
 	consume_non_diagnostic(lines)
-	match = SUBTEST_PLAN.match(lines[0])
+	match = SUBTEST_PLAN.match(lines.peek())
 	if match:
-		lines.pop(0)
+		lines.pop()
 		return int(match.group(1))
 	else:
 		return None
@@ -199,17 +240,17 @@ def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
 	else:
 		return TestStatus.SUCCESS
 
-def parse_ok_not_ok_test_suite(lines: List[str],
+def parse_ok_not_ok_test_suite(lines: LineStream,
 			       test_suite: TestSuite,
 			       expected_suite_index: int) -> bool:
 	consume_non_diagnostic(lines)
 	if not lines:
 		test_suite.status = TestStatus.TEST_CRASHED
 		return False
-	line = lines[0]
+	line = lines.peek()
 	match = OK_NOT_OK_MODULE.match(line)
 	if match:
-		lines.pop(0)
+		lines.pop()
 		if match.group(1) == 'ok':
 			test_suite.status = TestStatus.SUCCESS
 		else:
@@ -231,7 +272,7 @@ def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
-def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
+def parse_test_suite(lines: LineStream, expected_suite_index: int) -> Optional[TestSuite]:
 	if not lines:
 		return None
 	consume_non_diagnostic(lines)
@@ -257,26 +298,26 @@ def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[Te
 		print_with_timestamp(red('[ERROR] ') + 'ran out of lines before end token')
 		return test_suite
 	else:
-		print('failed to parse end of suite' + lines[0])
+		print(f'failed to parse end of suite "{name}", at line {lines.line_number()}: {lines.peek()}')
 		return None
 
 TAP_HEADER = re.compile(r'^TAP version 14$')
 
-def parse_tap_header(lines: List[str]) -> bool:
+def parse_tap_header(lines: LineStream) -> bool:
 	consume_non_diagnostic(lines)
-	if TAP_HEADER.match(lines[0]):
-		lines.pop(0)
+	if TAP_HEADER.match(lines.peek()):
+		lines.pop()
 		return True
 	else:
 		return False
 
 TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
 
-def parse_test_plan(lines: List[str]) -> Optional[int]:
+def parse_test_plan(lines: LineStream) -> Optional[int]:
 	consume_non_diagnostic(lines)
-	match = TEST_PLAN.match(lines[0])
+	match = TEST_PLAN.match(lines.peek())
 	if match:
-		lines.pop(0)
+		lines.pop()
 		return int(match.group(1))
 	else:
 		return None
@@ -284,7 +325,7 @@ def parse_test_plan(lines: List[str]) -> Optional[int]:
 def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
 	return bubble_up_errors(x.status for x in test_suites)
 
-def parse_test_result(lines: List[str]) -> TestResult:
+def parse_test_result(lines: LineStream) -> TestResult:
 	consume_non_diagnostic(lines)
 	if not lines or not parse_tap_header(lines):
 		return TestResult(TestStatus.NO_TESTS, [], lines)
@@ -338,11 +379,12 @@ def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
 				print_with_timestamp('')
 	return total_tests, failed_tests, crashed_tests
 
-def parse_run_tests(kernel_output) -> TestResult:
+def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
 	total_tests = 0
 	failed_tests = 0
 	crashed_tests = 0
-	test_result = parse_test_result(list(isolate_kunit_output(kernel_output)))
+	lines = extract_tap_lines(kernel_output)
+	test_result = parse_test_result(lines)
 	if test_result.status == TestStatus.NO_TESTS:
 		print(red('[ERROR] ') + yellow('no tests run!'))
 	elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 2e809dd956a7..433cd41d951c 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -11,6 +11,7 @@ from unittest import mock
 
 import tempfile, shutil # Handling test_tmpdir
 
+import itertools
 import json
 import signal
 import os
@@ -92,17 +93,18 @@ class KconfigTest(unittest.TestCase):
 
 class KUnitParserTest(unittest.TestCase):
 
-	def assertContains(self, needle, haystack):
-		for line in haystack:
+	def assertContains(self, needle: str, haystack: kunit_parser.LineStream):
+		# Clone the iterator so we can print the contents on failure.
+		copy, backup = itertools.tee(haystack)
+		for line in copy:
 			if needle in line:
 				return
-		raise AssertionError('"' +
-			str(needle) + '" not found in "' + str(haystack) + '"!')
+		raise AssertionError(f'"{needle}" not found in {list(backup)}!')
 
 	def test_output_isolated_correctly(self):
 		log_path = test_data_path('test_output_isolated_correctly.log')
 		with open(log_path) as file:
-			result = kunit_parser.isolate_kunit_output(file.readlines())
+			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: example', result)
 		self.assertContains('	1..2', result)
@@ -113,7 +115,7 @@ class KUnitParserTest(unittest.TestCase):
 	def test_output_with_prefix_isolated_correctly(self):
 		log_path = test_data_path('test_pound_sign.log')
 		with open(log_path) as file:
-			result = kunit_parser.isolate_kunit_output(file.readlines())
+			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: kunit-resource-test', result)
 		self.assertContains('	1..5', result)
@@ -159,7 +161,7 @@ class KUnitParserTest(unittest.TestCase):
 		empty_log = test_data_path('test_is_test_passed-no_tests_run.log')
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.isolate_kunit_output(file.readlines()))
+				kunit_parser.extract_tap_lines(file.readlines()))
 		self.assertEqual(0, len(result.suites))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
@@ -170,7 +172,7 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock = mock.patch('builtins.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.isolate_kunit_output(file.readlines()))
+				kunit_parser.extract_tap_lines(file.readlines()))
 		print_mock.assert_any_call(StrContains('no tests run!'))
 		print_mock.stop()
 		file.close()

base-commit: c3d0e3fd41b7f0f5d5d5b6022ab7e813f04ea727
-- 
2.31.1.818.g46aad6cb9e-goog

