Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1C293FE2BA
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 Sep 2021 21:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbhIATHZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Sep 2021 15:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhIATHZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Sep 2021 15:07:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7FE7C061760
        for <linux-kselftest@vger.kernel.org>; Wed,  1 Sep 2021 12:06:27 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b84-20020a253457000000b0059e6b730d45so405759yba.6
        for <linux-kselftest@vger.kernel.org>; Wed, 01 Sep 2021 12:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hwgH0hZ6bYBMwCYA6q2p76/Yd73l6Jq5cQjZvYc29j4=;
        b=GoVWSegoGApx7Jd+5dIYArJZBSMdEd4Et9oEssIoMTE6yq0doL6WTvfBbOucJLmKO3
         if6hbIgA0CYRx+HlKZleY9JjTyhPrcRz5GgB/VNEGY13rZItg69bi0aHUZzpaiH43+J9
         8BG/i4hehdHgii0/IDoYWxuLhiiKOkJ2aI2T/sq4peAaiH1PzLdzXtDI33uoAZFWmiUL
         2JH4Jz7JdXSITjDuD0viJ/GRurQjnMr9/40NeNlXXvaKLR+0NcJQkfoSna8RpxwuR3HH
         GXFFQ0L9uJFHdCSYZPzMNpGpSXYSjajSUZPC/QU9cSjNU+gQ1+A3aXb2SIqRphqsJnfn
         /3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hwgH0hZ6bYBMwCYA6q2p76/Yd73l6Jq5cQjZvYc29j4=;
        b=AQEiQO9B7JE5piMe5u/8uSKzAPNg6ZiMQCrK04Ix4gMNate5IEsFe4qN18HkL/VMwx
         yAMRbHAQpO+OO7Pt4cUqQzmxTZLf/MZB1i/5Orw0Rw9sFNKw7U/2kSFeX8jTo+h/kKss
         2Qna442oq2pbLWWXJdHYFv7s9fHAtPR8ss4e+IEOrzOAK08tA2gJaPmUaRAs7D/vBwWQ
         HAd9PIZ36uKVEWz3KFd2D7Y2qQqLleSiFqR5sRSZr/s9nJZQOmBwpJlsM+IPA+vuIVUm
         zhfuEeSbDZ4cnGA3UGreVyMjYzItfYwLq9wo0ZN1hdG77xEvgTT83RWYvIJA4W1ihLXI
         Ua0A==
X-Gm-Message-State: AOAM533uxw+kPr9vkGt1Juoq3cjr+/ZweiBnKpaBkb32ZRv2rB2kh9fb
        /34wL44loaCKt8RBkrAcLqXppgClXw==
X-Google-Smtp-Source: ABdhPJxoStSpwInXG/BIS76f46qhStejpELpExKH2KuNMsyxrihdRVMBXE0avnYhq8O5O/echY/ARlhrhA==
X-Received: from sunrae.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2814])
 (user=rmoar job=sendgmr) by 2002:a5b:48e:: with SMTP id n14mr1417748ybp.444.1630523186988;
 Wed, 01 Sep 2021 12:06:26 -0700 (PDT)
Date:   Wed,  1 Sep 2021 19:06:23 +0000
Message-Id: <20210901190623.315736-1-rmoar@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.259.gc128427fd7-goog
Subject: [PATCH v3] kunit: tool: improve compatibility of kunit_parser with
 KTAP specification
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, shuah@kernel.org
Cc:     Tim.Bird@sony.com, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update to kunit_parser to improve compatibility with KTAP
specification including arbitrarily nested tests. Patch accomplishes
three major changes:

- Use a general Test object to represent all tests rather than TestCase
and TestSuite objects. This allows for easier implementation of arbitrary
levels of nested tests and promotes the idea that both test suites and test
cases are tests.

- Print errors incrementally rather than all at once after the
parsing finishes to maximize information given to the user in the
case of the parser given invalid input and to increase the helpfulness
of the timestamps given during printing. Note that kunit.py parse does
not print incrementally yet. However, this fix brings us closer to
this feature.

- Increase compatibility for different formats of input. Arbitrary levels
of nested tests supported. Also, test cases and test suites are now
supported to be present on the same level of testing.

This patch now implements the KTAP specification as described here:
https://lore.kernel.org/linux-kselftest/CA+GJov6tdjvY9x12JsJT14qn6c7NViJxqaJk+r-K1YJzPggFDQ@mail.gmail.com/.

This patch adjusts the kunit_tool_test.py file to check for
the correct outputs from the new parser and adds a new test to check
the parsing for a KTAP result log with correct format for multiple nested
subtests (test_is_test_passed-all_passed_nested.log).

This patch also alters the kunit_json.py file to allow for arbitrarily
nested tests.

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

---

Change log from v2:
https://lore.kernel.org/linux-kselftest/20210826195505.3066755-1-rmoar@google.com/
- Fixes bug of type disagreement in kunit_json.py for build_dir
- Removes raw_output()
- Changes docstrings in kunit_parser.py (class docstring, LineStream
  docstrings, add_error(), total(), get_status(), all parsing methods)
- Fixes bug of not printing diagnostic log in the case of end of lines
- Sets default status of all tests to TEST_CRASHED
- Adds and prints empty tests with crashed status in case of missing
  tests
- Prints 'subtest' in instance of 1 subtest instead of 'subtests'
- Includes checking for 'BUG:' message in search of crash messages in
  log (note that parse_crash_in_log method could be removed but would
  require deleting tests in kunit_tool_test.py that include the crash
  message that is no longer used. If removed, parser would still print
  log in cases of test crashed or failure, which would now include
  missing subtests)
- Fixes bug of including directives (other than SKIP) in test name
  when matching name in result line for subtests

---

Change log from v1:
https://lore.kernel.org/linux-kselftest/20210820200032.2178134-1-rmoar@google.com/
- Rebase onto kselftest/kunit branch
- Add tests to kunit_tool_test.py to check parser is correctly stripping
  hyphen, producing correct json objects with nested tests, correctly
  passing kselftest TAP output, and correctly deals with missing test plan.
- Fix bug to correctly match test name in instance of a missing test plan.
- Fix bug in kunit_tool_test.py pointed out by Daniel where it was not
  correctly checking for a proper match to the '0 tests run!' error
  message. Reverts changes back to original.
- A few minor changes to commit message using Daniel's comments.
- Change docstrings using Daniel's comments to reduce:
  - Shortens some docstrings to be one-line or just description if it is
    self explanatory.
  - Remove explicit respecification of types of parameters and returns
    because this is already specified in the function annoations. However,
    some descriptions of the parameters and returns remain and some contain
    the type for context. Additionally, the types of public attributes of
    classes remain.
  - Remove any documentation of 'Return: None'
  - Remove docstrings of helper methods within other methods
---
 tools/testing/kunit/kunit_json.py             |   56 +-
 tools/testing/kunit/kunit_parser.py           | 1022 ++++++++++++-----
 tools/testing/kunit/kunit_tool_test.py        |  132 ++-
 .../test_is_test_passed-all_passed_nested.log |   34 +
 .../test_is_test_passed-kselftest.log         |   14 +
 .../test_is_test_passed-missing_plan.log      |   31 +
 .../kunit/test_data/test_strip_hyphen.log     |   16 +
 7 files changed, 925 insertions(+), 380 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
 create mode 100644 tools/testing/kunit/test_data/test_strip_hyphen.log

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index f5cca5c38cac..746bec72b9ac 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -11,47 +11,47 @@ import os
 
 import kunit_parser
 
-from kunit_parser import TestStatus
-
-def get_json_result(test_result, def_config, build_dir, json_path) -> str:
-	sub_groups = []
-
-	# Each test suite is mapped to a KernelCI sub_group
-	for test_suite in test_result.suites:
-		sub_group = {
-			"name": test_suite.name,
-			"arch": "UM",
-			"defconfig": def_config,
-			"build_environment": build_dir,
-			"test_cases": [],
-			"lab_name": None,
-			"kernel": None,
-			"job": None,
-			"git_branch": "kselftest",
-		}
-		test_cases = []
-		# TODO: Add attachments attribute in test_case with detailed
-		#  failure message, see https://api.kernelci.org/schema-test-case.html#get
-		for case in test_suite.cases:
-			test_case = {"name": case.name, "status": "FAIL"}
-			if case.status == TestStatus.SUCCESS:
+from kunit_parser import Test, TestResult, TestStatus
+from typing import Any, Dict, Optional
+
+JsonObj = Dict[str, Any]
+
+def _get_group_json(test: Test, def_config: str,
+		build_dir: Optional[str]) -> JsonObj:
+	sub_groups = []  # List[JsonObj]
+	test_cases = []  # List[JsonObj]
+
+	for subtest in test.subtests:
+		if len(subtest.subtests):
+			sub_group = _get_group_json(subtest, def_config,
+				build_dir)
+			sub_groups.append(sub_group)
+		else:
+			test_case = {"name": subtest.name, "status": "FAIL"}
+			if subtest.status == TestStatus.SUCCESS:
 				test_case["status"] = "PASS"
-			elif case.status == TestStatus.TEST_CRASHED:
+			elif subtest.status == TestStatus.TEST_CRASHED:
 				test_case["status"] = "ERROR"
 			test_cases.append(test_case)
-		sub_group["test_cases"] = test_cases
-		sub_groups.append(sub_group)
+
 	test_group = {
-		"name": "KUnit Test Group",
+		"name": test.name,
 		"arch": "UM",
 		"defconfig": def_config,
 		"build_environment": build_dir,
 		"sub_groups": sub_groups,
+		"test_cases": test_cases,
 		"lab_name": None,
 		"kernel": None,
 		"job": None,
 		"git_branch": "kselftest",
 	}
+	return test_group
+
+def get_json_result(test_result: TestResult, def_config: str,
+		build_dir: Optional[str], json_path: str) -> str:
+	test_group = _get_group_json(test_result.test, def_config, build_dir)
+	test_group["name"] = "KUnit Test Group"
 	json_obj = json.dumps(test_group, indent=4)
 	if json_path != 'stdout':
 		with open(json_path, 'w') as result_path:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 6310a641b151..f1b28def3e78 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -1,11 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Parses test results from a kernel dmesg log.
+# Parses KTAP test results from a kernel dmesg log and incrementally prints
+# results with reader-friendly format. Stores and returns test results in a
+# Test object.
 #
 # Copyright (C) 2019, Google LLC.
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
+# Author: Rae Moar <rmoar@google.com>
 
+from __future__ import annotations
 import re
 
 from collections import namedtuple
@@ -14,33 +18,52 @@ from enum import Enum, auto
 from functools import reduce
 from typing import Iterable, Iterator, List, Optional, Tuple
 
-TestResult = namedtuple('TestResult', ['status','suites','log'])
-
-class TestSuite(object):
+TestResult = namedtuple('TestResult', ['status','test','log'])
+
+class Test(object):
+	"""
+	A class to represent a test parsed from KTAP results. All KTAP
+	results within a test log are stored in a main Test object as
+	subtests.
+
+	Attributes:
+	status : TestStatus - status of the test
+	name : str - name of the test
+	expected_count : int - expected number of subtests (0 if single
+		test case and None if unknown expected number of subtests)
+	subtests : List[Test] - list of subtests
+	log : List[str] - log of KTAP lines that correspond to the test
+	counts : TestCounts - counts of the test statuses and errors of
+		subtests or of the test itself if the test is a single
+		test case.
+	"""
 	def __init__(self) -> None:
-		self.status = TestStatus.SUCCESS
-		self.name = ''
-		self.cases = []  # type: List[TestCase]
-
-	def __str__(self) -> str:
-		return 'TestSuite(' + str(self.status) + ',' + self.name + ',' + str(self.cases) + ')'
-
-	def __repr__(self) -> str:
-		return str(self)
-
-class TestCase(object):
-	def __init__(self) -> None:
-		self.status = TestStatus.SUCCESS
+		"""Creates Test object with default attributes."""
+		self.status = TestStatus.TEST_CRASHED
 		self.name = ''
+		self.expected_count = 0  # type: Optional[int]
+		self.subtests = []  # type: List[Test]
 		self.log = []  # type: List[str]
+		self.counts = TestCounts()
 
 	def __str__(self) -> str:
-		return 'TestCase(' + str(self.status) + ',' + self.name + ',' + str(self.log) + ')'
+		"""Returns string representation of a Test class object."""
+		return ('Test(' + str(self.status) + ', ' + self.name +
+			', ' + str(self.expected_count) + ', ' +
+			str(self.subtests) + ', ' + str(self.log) + ', ' +
+			str(self.counts) + ')')
 
 	def __repr__(self) -> str:
+		"""Returns string representation of a Test class object."""
 		return str(self)
 
+	def add_error(self, error_message: str) -> None:
+		"""Records an error that occurred while parsing this test."""
+		self.counts.errors += 1
+		print_error('Test ' + self.name + ': ' + error_message)
+
 class TestStatus(Enum):
+	"""An enumeration class to represent the status of a test."""
 	SUCCESS = auto()
 	FAILURE = auto()
 	SKIPPED = auto()
@@ -48,381 +71,754 @@ class TestStatus(Enum):
 	NO_TESTS = auto()
 	FAILURE_TO_PARSE_TESTS = auto()
 
+class TestCounts:
+	"""
+	Tracks the counts of statuses of all test cases and any errors within
+	a Test.
+
+	Attributes:
+	passed : int - the number of tests that have passed
+	failed : int - the number of tests that have failed
+	crashed : int - the number of tests that have crashed
+	skipped : int - the number of tests that have skipped
+	errors : int - the number of errors in the test and subtests
+	"""
+	def __init__(self):
+		"""Creates TestCounts object with counts of all test
+		statuses and test errors set to 0.
+		"""
+		self.passed = 0
+		self.failed = 0
+		self.crashed = 0
+		self.skipped = 0
+		self.errors = 0
+
+	def __str__(self) -> str:
+		"""Returns the string representation of a TestCounts object.
+		"""
+		return ('Passed: ' + str(self.passed) +
+			', Failed: ' + str(self.failed) +
+			', Crashed: ' + str(self.crashed) +
+			', Skipped: ' + str(self.skipped) +
+			', Errors: ' + str(self.errors))
+
+	def total(self) -> int:
+		"""Returns the total number of test cases within a test
+		object, where a test case is a test with no subtests.
+		"""
+		return (self.passed + self.failed + self.crashed +
+			self.skipped)
+
+	def add_subtest_counts(self, counts: TestCounts) -> None:
+		"""
+		Adds the counts of another TestCounts object to the current
+		TestCounts object. Used to add the counts of a subtest to the
+		parent test.
+
+		Parameters:
+		counts - a different TestCounts object whose counts
+			will be added to the counts of the TestCounts object
+		"""
+		self.passed += counts.passed
+		self.failed += counts.failed
+		self.crashed += counts.crashed
+		self.skipped += counts.skipped
+		self.errors += counts.errors
+
+	def get_status(self) -> TestStatus:
+		"""Returns the aggregated status of a Test using test
+		counts.
+		"""
+		if self.crashed:
+			# If one of the subtests crash, the expected status
+			# of the Test is crashed.
+			return TestStatus.TEST_CRASHED
+		elif self.failed:
+			# Otherwise if one of the subtests fail, the
+			# expected status of the Test is failed.
+			return TestStatus.FAILURE
+		elif self.passed:
+			# Otherwise if one of the subtests pass, the
+			# expected status of the Test is passed.
+			return TestStatus.SUCCESS
+		else:
+			# Finally, if none of the subtests have failed,
+			# crashed, or passed, the expected status of the
+			# Test is skipped.
+			return TestStatus.SKIPPED
+
+	def add_status(self, status: TestStatus) -> None:
+		"""
+		Increments count of inputted status.
+
+		Parameters:
+		status - status to be added to the TestCounts object
+		"""
+		if status == TestStatus.SUCCESS or \
+				status == TestStatus.NO_TESTS:
+			# if status is NO_TESTS the most appropriate
+			# attribute to increment is passed because
+			# the test did not fail, crash or get skipped.
+			self.passed += 1
+		elif status == TestStatus.FAILURE:
+			self.failed += 1
+		elif status == TestStatus.SKIPPED:
+			self.skipped += 1
+		else:
+			self.crashed += 1
+
 class LineStream:
-	"""Provides a peek()/pop() interface over an iterator of (line#, text)."""
+	"""
+	A class to represent the lines of kernel output.
+	Provides a peek()/pop() interface over an iterator of
+	(line#, text).
+	"""
 	_lines: Iterator[Tuple[int, str]]
 	_next: Tuple[int, str]
 	_done: bool
 
 	def __init__(self, lines: Iterator[Tuple[int, str]]):
+		"""Creates a new LineStream that wraps the given iterator."""
 		self._lines = lines
 		self._done = False
 		self._next = (0, '')
 		self._get_next()
 
 	def _get_next(self) -> None:
+		"""Advances the LineSteam to the next line or sets the _done
+		attribute if the LineStream has reached the end of the lines.
+		"""
 		try:
 			self._next = next(self._lines)
 		except StopIteration:
 			self._done = True
 
 	def peek(self) -> str:
+		"""Returns the current line, without advancing the LineStream.
+		"""
 		return self._next[1]
 
 	def pop(self) -> str:
+		"""Returns the current line and advances the LineStream to
+		the next line.
+		"""
 		n = self._next
 		self._get_next()
 		return n[1]
 
 	def __bool__(self) -> bool:
+		"""Returns True if stream has more lines."""
 		return not self._done
 
 	# Only used by kunit_tool_test.py.
 	def __iter__(self) -> Iterator[str]:
+		"""Empties all lines stored in LineStream object into
+		Iterator object and returns the Iterator object.
+		"""
 		while bool(self):
 			yield self.pop()
 
 	def line_number(self) -> int:
+		"""Returns the line number of the current line."""
 		return self._next[0]
 
-kunit_start_re = re.compile(r'TAP version [0-9]+$')
-kunit_end_re = re.compile('(List of all partitions:|'
-			  'Kernel panic - not syncing: VFS:|reboot: System halted)')
+# Parsing helper methods:
+
+KTAP_START = re.compile(r'KTAP version ([0-9]+)$')
+TAP_START = re.compile(r'TAP version ([0-9]+)$')
+KTAP_END = re.compile('(List of all partitions:|'
+	'Kernel panic - not syncing: VFS:|reboot: System halted)')
 
 def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
-	def isolate_kunit_output(kernel_output: Iterable[str]) -> Iterator[Tuple[int, str]]:
+	"""Extracts KTAP lines from inputted kernel output in LineStream
+	object."""
+	def isolate_ktap_output(kernel_output: Iterable[str]) \
+			-> Iterator[Tuple[int, str]]:
 		line_num = 0
 		started = False
 		for line in kernel_output:
 			line_num += 1
-			line = line.rstrip()  # line always has a trailing \n
-			if kunit_start_re.search(line):
+			line = line.rstrip()  # remove trailing \n
+			if not started and KTAP_START.search(line):
+				# start extracting KTAP lines and set prefix
+				# to number of characters before version line
+				prefix_len = len(
+					line.split('KTAP version')[0])
+				started = True
+				yield line_num, line[prefix_len:]
+			elif not started and TAP_START.search(line):
+				# start extracting KTAP lines and set prefix
+				# to number of characters before version line
 				prefix_len = len(line.split('TAP version')[0])
 				started = True
 				yield line_num, line[prefix_len:]
-			elif kunit_end_re.search(line):
+			elif started and KTAP_END.search(line):
+				# stop extracting KTAP lines
 				break
 			elif started:
-				yield line_num, line[prefix_len:]
-	return LineStream(lines=isolate_kunit_output(kernel_output))
-
-DIVIDER = '=' * 60
-
-RESET = '\033[0;0m'
-
-def red(text) -> str:
-	return '\033[1;31m' + text + RESET
-
-def yellow(text) -> str:
-	return '\033[1;33m' + text + RESET
-
-def green(text) -> str:
-	return '\033[1;32m' + text + RESET
-
-def print_with_timestamp(message) -> None:
-	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
+				# remove prefix and any indention and yield
+				# line with line number
+				line = line[prefix_len:].lstrip()
+				yield line_num, line
+	return LineStream(lines=isolate_ktap_output(kernel_output))
+
+KTAP_VERSIONS = [1]
+TAP_VERSIONS = [13, 14]
+
+def check_version(version_num: int, accepted_versions: List[int],
+			version_type: str, test: Test) -> None:
+	"""
+	Adds error to test object if version number is too high or too
+	low.
+
+	Parameters:
+	version_num - The inputted version number from the parsed KTAP or TAP
+		header line
+	accepted_version - List of accepted KTAP or TAP versions
+	version_type - 'KTAP' or 'TAP' depending on the type of
+		version line.
+	test - Test object for current test being parsed
+	"""
+	if version_num < min(accepted_versions):
+		test.add_error(version_type +
+			' version lower than expected!')
+	elif version_num > max(accepted_versions):
+		test.add_error(
+			version_type + ' version higher than expected!')
+
+def parse_ktap_header(lines: LineStream, test: Test) -> bool:
+	"""
+	Parses KTAP/TAP header line and checks version number.
+	Returns False if fails to parse KTAP/TAP header line.
+
+	Accepted formats:
+	- 'KTAP version [version number]'
+	- 'TAP version [version number]'
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
+
+	Return:
+	True if successfully parsed KTAP/TAP header line
+	"""
+	ktap_match = KTAP_START.match(lines.peek())
+	tap_match = TAP_START.match(lines.peek())
+	if ktap_match:
+		version_num = int(ktap_match.group(1))
+		check_version(version_num, KTAP_VERSIONS, 'KTAP', test)
+	elif tap_match:
+		version_num = int(tap_match.group(1))
+		check_version(version_num, TAP_VERSIONS, 'TAP', test)
+	else:
+		return False
+	test.log.append(lines.pop())
+	return True
 
-def format_suite_divider(message) -> str:
-	return '======== ' + message + ' ========'
+TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
 
-def print_suite_divider(message) -> None:
-	print_with_timestamp(DIVIDER)
-	print_with_timestamp(format_suite_divider(message))
+def parse_test_header(lines: LineStream, test: Test) -> bool:
+	"""
+	Parses test header and stores test name in test object.
+	Returns False if fails to parse test header line.
 
-def print_log(log) -> None:
-	for m in log:
-		print_with_timestamp(m)
+	Accepted format:
+	- '# Subtest: [test name]'
 
-TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*# (Subtest:|.*: kunit test case crashed!)).*$')
+	Parameters:
+	lines - LineStream of ktap output to parse
+	test - Test object for current test being parsed
 
-def consume_non_diagnostic(lines: LineStream) -> None:
-	while lines and not TAP_ENTRIES.match(lines.peek()):
-		lines.pop()
-
-def save_non_diagnostic(lines: LineStream, test_case: TestCase) -> None:
-	while lines and not TAP_ENTRIES.match(lines.peek()):
-		test_case.log.append(lines.peek())
-		lines.pop()
+	Return:
+	True if successfully parsed test header line
+	"""
+	match = TEST_HEADER.match(lines.peek())
+	if not match:
+		return False
+	test.log.append(lines.pop())
+	test.name = match.group(1)
+	return True
 
-OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
+TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
 
-OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
+def parse_test_plan(lines: LineStream, test: Test) -> bool:
+	"""
+	Parses test plan line and stores the expected number of subtests in
+	test object. Reports an error if expected count is 0.
+	Returns False and reports missing test plan error if fails to parse
+	test plan.
 
-OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
+	Accepted format:
+	- '1..[number of subtests]'
 
-OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
+	Parameters:
+	lines - LineStream of ktap output to parse
+	test - Test object for current test being parsed
 
-def parse_ok_not_ok_test_case(lines: LineStream, test_case: TestCase) -> bool:
-	save_non_diagnostic(lines, test_case)
-	if not lines:
-		test_case.status = TestStatus.TEST_CRASHED
-		return True
-	line = lines.peek()
-	match = OK_NOT_OK_SUBTEST.match(line)
-	while not match and lines:
-		line = lines.pop()
-		match = OK_NOT_OK_SUBTEST.match(line)
-	if match:
-		test_case.log.append(lines.pop())
-		test_case.name = match.group(2)
-		skip_match = OK_NOT_OK_SKIP.match(line)
-		if skip_match:
-			test_case.status = TestStatus.SKIPPED
-			return True
-		if test_case.status == TestStatus.TEST_CRASHED:
-			return True
-		if match.group(1) == 'ok':
-			test_case.status = TestStatus.SUCCESS
-		else:
-			test_case.status = TestStatus.FAILURE
-		return True
-	else:
+	Return:
+	True if successfully parsed test plan line
+	"""
+	match = TEST_PLAN.match(lines.peek())
+	if not match:
+		test.expected_count = None
+		test.add_error('missing plan line!')
 		return False
-
-SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
-DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
-
-def parse_diagnostic(lines: LineStream, test_case: TestCase) -> bool:
-	save_non_diagnostic(lines, test_case)
-	if not lines:
+	test.log.append(lines.pop())
+	expected_count = int(match.group(1))
+	test.expected_count = expected_count
+	if expected_count == 0:
+		test.status = TestStatus.NO_TESTS
+		test.add_error('0 tests run!')
+	return True
+
+TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
+
+TEST_RESULT_SKIP = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
+
+def peek_test_name_match(lines: LineStream, test: Test) -> bool:
+	"""
+	Matches current line with the format of a test result line and checks
+	if the name matches the name of the current test.
+	Returns False if fails to match format or name.
+
+	Accepted format:
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
+
+	Return:
+	True if matched a test result line and the name matching the
+		expected test name
+	"""
+	line = lines.peek()
+	match = TEST_RESULT.match(line)
+	if not match:
 		return False
+	name = match.group(4)
+	return (name == test.name)
+
+def parse_test_result(lines: LineStream, test: Test,
+			expected_num: int) -> bool:
+	"""
+	Parses test result line and stores the status and name in the test
+	object. Reports an error if the test number does not match expected
+	test number.
+	Returns False if fails to parse test result line.
+
+	Note that the SKIP directive is the only direction that causes a
+	change in status.
+
+	Accepted format:
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	test - Test object for current test being parsed
+	expected_num - expected test number for current test
+
+	Return:
+	True if successfully parsed a test result line.
+	"""
 	line = lines.peek()
-	match = SUBTEST_DIAGNOSTIC.match(line)
-	if match:
-		test_case.log.append(lines.pop())
-		crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
-		if crash_match:
-			test_case.status = TestStatus.TEST_CRASHED
-		return True
-	else:
+	match = TEST_RESULT.match(line)
+	skip_match = TEST_RESULT_SKIP.match(line)
+
+	# Check if line matches test result line format
+	if not match:
 		return False
+	test.log.append(lines.pop())
 
-def parse_test_case(lines: LineStream) -> Optional[TestCase]:
-	test_case = TestCase()
-	save_non_diagnostic(lines, test_case)
-	while parse_diagnostic(lines, test_case):
-		pass
-	if parse_ok_not_ok_test_case(lines, test_case):
-		return test_case
+	# Set name of test object
+	if skip_match:
+		test.name = skip_match.group(4)
 	else:
-		return None
-
-SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
-
-def parse_subtest_header(lines: LineStream) -> Optional[str]:
-	consume_non_diagnostic(lines)
-	if not lines:
-		return None
-	match = SUBTEST_HEADER.match(lines.peek())
-	if match:
-		lines.pop()
-		return match.group(1)
+		test.name = match.group(4)
+
+	# Check test num
+	num = int(match.group(2))
+	if num != expected_num:
+		test.add_error('Expected test number ' +
+			str(expected_num) + ' but found ' + str(num))
+
+	# Set status of test object
+	status = match.group(1)
+	if skip_match:
+		test.status = TestStatus.SKIPPED
+	elif status == 'ok':
+		test.status = TestStatus.SUCCESS
 	else:
-		return None
+		test.status = TestStatus.FAILURE
+	return True
+
+def parse_diagnostic(lines: LineStream) -> List[str]:
+	"""
+	Parse lines that do not match the format of a test result line or
+	test header line and returns them in list.
+
+	Line formats that are not parsed:
+	- '# Subtest: [test name]'
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+
+	Return:
+	Log of diagnostic lines
+	"""
+	log = []  # type: List[str]
+	while lines and not TEST_RESULT.match(lines.peek()) and not \
+			TEST_HEADER.match(lines.peek()):
+		log.append(lines.pop())
+	return log
+
+DIAGNOSTIC_CRASH_MESSAGE = re.compile(
+		r'^(BUG:|# .*?: kunit test case crashed!$)')
+
+def parse_crash_in_log(test: Test) -> bool:
+	"""
+	Iterate through the lines of the log to parse for crash message.
+	If crash message found, set status to crashed and return True.
+	Otherwise return False.
+
+	Parameters:
+	test - Test object for current test being parsed
+
+	Return:
+	True if crash message found in log
+	"""
+	for line in test.log:
+		if DIAGNOSTIC_CRASH_MESSAGE.match(line):
+			test.status = TestStatus.TEST_CRASHED
+			return True
+	return False
 
-SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
-def parse_subtest_plan(lines: LineStream) -> Optional[int]:
-	consume_non_diagnostic(lines)
-	match = SUBTEST_PLAN.match(lines.peek())
-	if match:
-		lines.pop()
-		return int(match.group(1))
-	else:
-		return None
-
-def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
-	if left == right:
-		return left
-	elif left == TestStatus.TEST_CRASHED or right == TestStatus.TEST_CRASHED:
-		return TestStatus.TEST_CRASHED
-	elif left == TestStatus.FAILURE or right == TestStatus.FAILURE:
-		return TestStatus.FAILURE
-	elif left == TestStatus.SKIPPED:
-		return right
-	else:
-		return left
+# Printing helper methods:
 
-def parse_ok_not_ok_test_suite(lines: LineStream,
-			       test_suite: TestSuite,
-			       expected_suite_index: int) -> bool:
-	consume_non_diagnostic(lines)
-	if not lines:
-		test_suite.status = TestStatus.TEST_CRASHED
-		return False
-	line = lines.peek()
-	match = OK_NOT_OK_MODULE.match(line)
-	if match:
-		lines.pop()
-		if match.group(1) == 'ok':
-			test_suite.status = TestStatus.SUCCESS
-		else:
-			test_suite.status = TestStatus.FAILURE
-		skip_match = OK_NOT_OK_SKIP.match(line)
-		if skip_match:
-			test_suite.status = TestStatus.SKIPPED
-		suite_index = int(match.group(2))
-		if suite_index != expected_suite_index:
-			print_with_timestamp(
-				red('[ERROR] ') + 'expected_suite_index ' +
-				str(expected_suite_index) + ', but got ' +
-				str(suite_index))
-		return True
-	else:
-		return False
+DIVIDER = '=' * 60
 
-def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
-	return reduce(max_status, status_list, TestStatus.SKIPPED)
+RESET = '\033[0;0m'
 
-def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
-	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
-	return max_status(max_test_case_status, test_suite.status)
+def red(text: str) -> str:
+	"""Returns inputted string with red color code."""
+	return '\033[1;31m' + text + RESET
 
-def parse_test_suite(lines: LineStream, expected_suite_index: int) -> Optional[TestSuite]:
-	if not lines:
-		return None
-	consume_non_diagnostic(lines)
-	test_suite = TestSuite()
-	test_suite.status = TestStatus.SUCCESS
-	name = parse_subtest_header(lines)
-	if not name:
-		return None
-	test_suite.name = name
-	expected_test_case_num = parse_subtest_plan(lines)
-	if expected_test_case_num is None:
-		return None
-	while expected_test_case_num > 0:
-		test_case = parse_test_case(lines)
-		if not test_case:
-			break
-		test_suite.cases.append(test_case)
-		expected_test_case_num -= 1
-	if parse_ok_not_ok_test_suite(lines, test_suite, expected_suite_index):
-		test_suite.status = bubble_up_test_case_errors(test_suite)
-		return test_suite
-	elif not lines:
-		print_with_timestamp(red('[ERROR] ') + 'ran out of lines before end token')
-		return test_suite
-	else:
-		print(f'failed to parse end of suite "{name}", at line {lines.line_number()}: {lines.peek()}')
-		return None
+def yellow(text: str) -> str:
+	"""Returns inputted string with yellow color code."""
+	return '\033[1;33m' + text + RESET
 
-TAP_HEADER = re.compile(r'^TAP version 14$')
+def green(text: str) -> str:
+	"""Returns inputted string with green color code."""
+	return '\033[1;32m' + text + RESET
 
-def parse_tap_header(lines: LineStream) -> bool:
-	consume_non_diagnostic(lines)
-	if TAP_HEADER.match(lines.peek()):
-		lines.pop()
-		return True
-	else:
-		return False
+ANSI_LEN = len(red(''))
 
-TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
+def print_with_timestamp(message: str) -> None:
+	"""Prints message with timestamp at beginning."""
+	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
 
-def parse_test_plan(lines: LineStream) -> Optional[int]:
-	consume_non_diagnostic(lines)
-	match = TEST_PLAN.match(lines.peek())
-	if match:
-		lines.pop()
-		return int(match.group(1))
-	else:
-		return None
-
-def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
-	return bubble_up_errors(x.status for x in test_suites)
-
-def parse_test_result(lines: LineStream) -> TestResult:
-	consume_non_diagnostic(lines)
-	if not lines or not parse_tap_header(lines):
-		return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
-	expected_test_suite_num = parse_test_plan(lines)
-	if expected_test_suite_num == 0:
-		return TestResult(TestStatus.NO_TESTS, [], lines)
-	elif expected_test_suite_num is None:
-		return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
-	test_suites = []
-	for i in range(1, expected_test_suite_num + 1):
-		test_suite = parse_test_suite(lines, i)
-		if test_suite:
-			test_suites.append(test_suite)
+def format_test_divider(message: str, len_message: int) -> str:
+	"""
+	Returns string with message centered in fixed width divider.
+
+	Example:
+	'===================== message example ====================='
+
+	Parameters:
+	message - message to be centered in divider line
+	len_message - length of the message to be printed such that
+		any characters of the color codes are not counted
+
+	Return:
+	String containing message centered in fixed width divider
+	"""
+	default_count = 3  # default number of dashes
+	len_1 = default_count
+	len_2 = default_count
+	difference = len(DIVIDER) - len_message - 2  # 2 spaces added
+	if difference > 0:
+		# calculate number of dashes for each side of the divider
+		len_1 = int(difference / 2)
+		len_2 = difference - len_1
+	return ('=' * len_1) + ' ' + message + ' ' + ('=' * len_2)
+
+def print_test_header(test: Test) -> None:
+	"""
+	Prints test header with test name and optionally the expected number
+	of subtests.
+
+	Example:
+	'=================== example (2 subtests) ==================='
+
+	Parameters:
+	test - Test object representing current test being printed
+	"""
+	message = test.name
+	if test.expected_count:
+		if test.expected_count == 1:
+			message += (' (' + str(test.expected_count) +
+				' subtest)')
 		else:
-			print_with_timestamp(
-				red('[ERROR] ') + ' expected ' +
-				str(expected_test_suite_num) +
-				' test suites, but got ' + str(i - 2))
-			break
-	test_suite = parse_test_suite(lines, -1)
-	if test_suite:
-		print_with_timestamp(red('[ERROR] ') +
-			'got unexpected test suite: ' + test_suite.name)
-	if test_suites:
-		return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
-	else:
-		return TestResult(TestStatus.NO_TESTS, [], lines)
+			message += (' (' + str(test.expected_count) +
+				' subtests)')
+	print_with_timestamp(format_test_divider(message, len(message)))
 
-class TestCounts:
-	passed: int
-	failed: int
-	crashed: int
-	skipped: int
+def print_log(log: Iterable[str]) -> None:
+	"""
+	Prints all strings in saved log for test in yellow.
 
-	def __init__(self):
-		self.passed = 0
-		self.failed = 0
-		self.crashed = 0
-		self.skipped = 0
-
-	def total(self) -> int:
-		return self.passed + self.failed + self.crashed + self.skipped
-
-def print_and_count_results(test_result: TestResult) -> TestCounts:
-	counts = TestCounts()
-	for test_suite in test_result.suites:
-		if test_suite.status == TestStatus.SUCCESS:
-			print_suite_divider(green('[PASSED] ') + test_suite.name)
-		elif test_suite.status == TestStatus.SKIPPED:
-			print_suite_divider(yellow('[SKIPPED] ') + test_suite.name)
-		elif test_suite.status == TestStatus.TEST_CRASHED:
-			print_suite_divider(red('[CRASHED] ' + test_suite.name))
-		else:
-			print_suite_divider(red('[FAILED] ') + test_suite.name)
-		for test_case in test_suite.cases:
-			if test_case.status == TestStatus.SUCCESS:
-				counts.passed += 1
-				print_with_timestamp(green('[PASSED] ') + test_case.name)
-			elif test_case.status == TestStatus.SKIPPED:
-				counts.skipped += 1
-				print_with_timestamp(yellow('[SKIPPED] ') + test_case.name)
-			elif test_case.status == TestStatus.TEST_CRASHED:
-				counts.crashed += 1
-				print_with_timestamp(red('[CRASHED] ' + test_case.name))
-				print_log(map(yellow, test_case.log))
-				print_with_timestamp('')
+	Parameters:
+	log - Iterable object with all strings saved in log for test
+	"""
+	for m in log:
+		print_with_timestamp(yellow(m))
+
+def format_test_result(test: Test) -> str:
+	"""
+	Returns string with formatted test result with colored status and test
+	name.
+
+	Example:
+	'[PASSED] example'
+
+	Parameters:
+	test - Test object representing current test being printed
+
+	Return:
+	String containing formatted test result
+	"""
+	if test.status == TestStatus.SUCCESS:
+		return (green('[PASSED] ') + test.name)
+	elif test.status == TestStatus.SKIPPED:
+		return (yellow('[SKIPPED] ') + test.name)
+	elif test.status == TestStatus.TEST_CRASHED:
+		print_log(test.log)
+		return (red('[CRASHED] ') + test.name)
+	else:
+		print_log(test.log)
+		return (red('[FAILED] ') + test.name)
+
+def print_test_result(test: Test) -> None:
+	"""
+	Prints result line with status of test.
+
+	Example:
+	'[PASSED] example'
+
+	Parameters:
+	test - Test object representing current test being printed
+	"""
+	print_with_timestamp(format_test_result(test))
+
+def print_test_footer(test: Test) -> None:
+	"""
+	Prints test footer with status of test.
+
+	Example:
+	'===================== [PASSED] example ====================='
+
+	Parameters:
+	test - Test object representing current test being printed
+	"""
+	message = format_test_result(test)
+	print_with_timestamp(format_test_divider(message,
+		len(message) - ANSI_LEN))
+
+def print_summary_line(test: Test) -> None:
+	"""
+	Prints summary line of test object. Color of line is dependent on
+	status of test. Color is green if test passes, yellow if test is
+	skipped, and red if the test fails or crashes. Summary line contains
+	counts of the statuses of the tests subtests or the test itself if it
+	has no subtests.
+
+	Example:
+	"Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0,
+	Errors: 0"
+
+	test - Test object representing current test being printed
+	"""
+	if test.status == TestStatus.SUCCESS or \
+			test.status == TestStatus.NO_TESTS:
+		color = green
+	elif test.status == TestStatus.SKIPPED:
+		color = yellow
+	else:
+		color = red
+	counts = test.counts
+	print_with_timestamp(color('Testing complete. ' + str(counts)))
+
+def print_error(error_message: str) -> None:
+	"""
+	Prints error message with error format.
+
+	Example:
+	"[ERROR] Test example: missing test plan!"
+
+	Parameters:
+	error_message - message describing error
+	"""
+	print_with_timestamp(red('[ERROR] ') + error_message)
+
+# Other methods:
+
+def bubble_up_test_results(test: Test) -> None:
+	"""
+	If the test has subtests, add the test counts of the subtests to the
+	test and check if any of the tests crashed and if so set the test
+	status to crashed. Otherwise if the test has no subtests add the
+	status of the test to the test counts.
+
+	Parameters:
+	test - Test object for current test being parsed
+	"""
+	parse_crash_in_log(test)
+	subtests = test.subtests
+	counts = test.counts
+	status = test.status
+	for t in subtests:
+		counts.add_subtest_counts(t.counts)
+	if counts.total() == 0:
+		counts.add_status(status)
+	elif test.counts.get_status() == TestStatus.TEST_CRASHED:
+		test.status = TestStatus.TEST_CRASHED
+
+def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
+	"""
+	Finds next test to parse in LineStream, creates new Test object,
+	parses any subtests of the test, populates Test object with all
+	information (status, name) about the test and the Test objects for
+	any subtests, and then returns the Test object. The method accepts
+	three formats of tests:
+
+	Accepted test formats:
+
+	- Main KTAP/TAP header
+
+	Example:
+
+	KTAP version 1
+	1..4
+	[subtests]
+
+	- Subtest header line
+
+	Example:
+
+	# Subtest: name
+	1..3
+	[subtests]
+	ok 1 name
+
+	- Test result line
+
+	Example:
+
+	ok 1 - test
+
+	Parameters:
+	lines - LineStream of KTAP output to parse
+	expected_num - expected test number for test to be parsed
+	log - list of strings containing any preceding diagnostic lines
+		corresponding to the current test
+
+	Return:
+	Test object populated with characteristics and any subtests
+	"""
+	test = Test()
+	test.log.extend(log)
+	parent_test = False
+	main = parse_ktap_header(lines, test)
+	if main:
+		# If KTAP/TAP header is found, attempt to parse
+		# test plan
+		test.name = "main"
+		parse_test_plan(lines, test)
+	else:
+		# If KTAP/TAP header is not found, test must be subtest
+		# header or test result line so parse attempt to parser
+		# subtest header
+		parent_test = parse_test_header(lines, test)
+		if parent_test:
+			# If subtest header is found, attempt to parse
+			# test plan and print header
+			parse_test_plan(lines, test)
+			print_test_header(test)
+	expected_count = test.expected_count
+	subtests = []
+	test_num = 1
+	while expected_count is None or test_num <= expected_count:
+		# Loop to parse any subtests.
+		# Break after parsing expected number of tests or
+		# if expected number of tests is unknown break when test
+		# result line with matching name to subtest header is found
+		# or no more lines in stream.
+		sub_log = parse_diagnostic(lines)
+		sub_test = Test()
+		if not lines or (peek_test_name_match(lines, test) and
+				not main):
+			if expected_count and test_num <= expected_count:
+				# If parser reaches end of test before
+				# parsing expected number of subtests, print
+				# crashed subtest and record error
+				test.add_error('missing expected subtest!')
+				sub_test.log.extend(sub_log)
+				test.counts.add_status(
+					TestStatus.TEST_CRASHED)
+				print_test_result(sub_test)
 			else:
-				counts.failed += 1
-				print_with_timestamp(red('[FAILED] ') + test_case.name)
-				print_log(map(yellow, test_case.log))
-				print_with_timestamp('')
-	return counts
+				test.log.extend(sub_log)
+				break
+		else:
+			sub_test = parse_test(lines, test_num, sub_log)
+		subtests.append(sub_test)
+		test_num += 1
+	test.subtests = subtests
+	if not main:
+		# If not main test, look for test result line
+		test.log.extend(parse_diagnostic(lines))
+		if (parent_test and peek_test_name_match(lines, test)) or \
+				not parent_test:
+			parse_test_result(lines, test, expected_num)
+		else:
+			test.add_error('missing subtest result line!')
+	# Add statuses to TestCounts attribute in Test object
+	bubble_up_test_results(test)
+	if parent_test:
+		# If test has subtests and is not the main test object, print
+		# footer.
+		print_test_footer(test)
+	elif not main:
+		print_test_result(test)
+	return test
 
 def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
-	counts = TestCounts()
+	"""
+	Using kernel output, extract KTAP lines, parse the lines for test
+	results and print condensed test results and summary line .
+
+	Parameters:
+	kernel_output - Iterable object contains lines of kernel output
+
+	Return:
+	TestResult - Tuple containg status of main test object, main test
+		object with all subtests, and log of all KTAP lines.
+	"""
+	print_with_timestamp(DIVIDER)
 	lines = extract_tap_lines(kernel_output)
-	test_result = parse_test_result(lines)
-	if test_result.status == TestStatus.NO_TESTS:
-		print(red('[ERROR] ') + yellow('no tests run!'))
-	elif test_result.status == TestStatus.FAILURE_TO_PARSE_TESTS:
-		print(red('[ERROR] ') + yellow('could not parse test results!'))
+	test = Test()
+	if not lines:
+		test.add_error('invalid KTAP input!')
+		test.status = TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
-		counts = print_and_count_results(test_result)
+		test = parse_test(lines, 0, [])
+		if test.status != TestStatus.NO_TESTS:
+			test.status = test.counts.get_status()
 	print_with_timestamp(DIVIDER)
-	if test_result.status == TestStatus.SUCCESS:
-		fmt = green
-	elif test_result.status == TestStatus.SKIPPED:
-		fmt = yellow
-	else:
-		fmt =red
-	print_with_timestamp(
-		fmt('Testing complete. %d tests run. %d failed. %d crashed. %d skipped.' %
-		    (counts.total(), counts.failed, counts.crashed, counts.skipped)))
-	return test_result
+	print_summary_line(test)
+	return TestResult(test.status, test, lines)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 619c4554cbff..2a8b0b5f4269 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -106,10 +106,10 @@ class KUnitParserTest(unittest.TestCase):
 		with open(log_path) as file:
 			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
-		self.assertContains('	# Subtest: example', result)
-		self.assertContains('	1..2', result)
-		self.assertContains('	ok 1 - example_simple_test', result)
-		self.assertContains('	ok 2 - example_mock_test', result)
+		self.assertContains('# Subtest: example', result)
+		self.assertContains('1..2', result)
+		self.assertContains('ok 1 - example_simple_test', result)
+		self.assertContains('ok 2 - example_mock_test', result)
 		self.assertContains('ok 1 - example', result)
 
 	def test_output_with_prefix_isolated_correctly(self):
@@ -117,28 +117,28 @@ class KUnitParserTest(unittest.TestCase):
 		with open(log_path) as file:
 			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
-		self.assertContains('	# Subtest: kunit-resource-test', result)
-		self.assertContains('	1..5', result)
-		self.assertContains('	ok 1 - kunit_resource_test_init_resources', result)
-		self.assertContains('	ok 2 - kunit_resource_test_alloc_resource', result)
-		self.assertContains('	ok 3 - kunit_resource_test_destroy_resource', result)
-		self.assertContains(' foo bar 	#', result)
-		self.assertContains('	ok 4 - kunit_resource_test_cleanup_resources', result)
-		self.assertContains('	ok 5 - kunit_resource_test_proper_free_ordering', result)
+		self.assertContains('# Subtest: kunit-resource-test', result)
+		self.assertContains('1..5', result)
+		self.assertContains('ok 1 - kunit_resource_test_init_resources', result)
+		self.assertContains('ok 2 - kunit_resource_test_alloc_resource', result)
+		self.assertContains('ok 3 - kunit_resource_test_destroy_resource', result)
+		self.assertContains('foo bar 	#', result)
+		self.assertContains('ok 4 - kunit_resource_test_cleanup_resources', result)
+		self.assertContains('ok 5 - kunit_resource_test_proper_free_ordering', result)
 		self.assertContains('ok 1 - kunit-resource-test', result)
-		self.assertContains(' foo bar 	# non-kunit output', result)
-		self.assertContains('	# Subtest: kunit-try-catch-test', result)
-		self.assertContains('	1..2', result)
-		self.assertContains('	ok 1 - kunit_test_try_catch_successful_try_no_catch',
+		self.assertContains('foo bar 	# non-kunit output', result)
+		self.assertContains('# Subtest: kunit-try-catch-test', result)
+		self.assertContains('1..2', result)
+		self.assertContains('ok 1 - kunit_test_try_catch_successful_try_no_catch',
 				    result)
-		self.assertContains('	ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
+		self.assertContains('ok 2 - kunit_test_try_catch_unsuccessful_try_does_catch',
 				    result)
 		self.assertContains('ok 2 - kunit-try-catch-test', result)
-		self.assertContains('	# Subtest: string-stream-test', result)
-		self.assertContains('	1..3', result)
-		self.assertContains('	ok 1 - string_stream_test_empty_on_creation', result)
-		self.assertContains('	ok 2 - string_stream_test_not_empty_after_add', result)
-		self.assertContains('	ok 3 - string_stream_test_get_string', result)
+		self.assertContains('# Subtest: string-stream-test', result)
+		self.assertContains('1..3', result)
+		self.assertContains('ok 1 - string_stream_test_empty_on_creation', result)
+		self.assertContains('ok 2 - string_stream_test_not_empty_after_add', result)
+		self.assertContains('ok 3 - string_stream_test_get_string', result)
 		self.assertContains('ok 3 - string-stream-test', result)
 
 	def test_parse_successful_test_log(self):
@@ -148,6 +148,13 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
+	def test_parse_successful_nested_tests_log(self):
+		all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
+		with open(all_passed_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
 
 	def test_parse_failed_test_log(self):
 		failed_log = test_data_path('test_is_test_passed-failure.log')
@@ -162,17 +169,31 @@ class KUnitParserTest(unittest.TestCase):
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.suites))
+		self.assertEqual(0, len(result.test.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
 			result.status)
 
+	def test_missing_test_plan(self):
+		missing_plan_log = test_data_path('test_is_test_passed-'
+			'missing_plan.log')
+		with open(missing_plan_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.extract_tap_lines(
+				file.readlines()))
+		self.assertEqual(2, result.test.counts.errors)
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+
 	def test_no_tests(self):
-		empty_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
-		with open(empty_log) as file:
+		header_log = test_data_path('test_is_test_passed-'
+			'no_tests_run_with_header.log')
+		with open(header_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.suites))
+				kunit_parser.extract_tap_lines(
+				file.readlines()))
+		self.assertEqual(0, len(result.test.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
@@ -182,15 +203,17 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock = mock.patch('builtins.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
-				kunit_parser.extract_tap_lines(file.readlines()))
-		print_mock.assert_any_call(StrContains('could not parse test results!'))
+				kunit_parser.extract_tap_lines(
+				file.readlines()))
+		print_mock.assert_any_call(StrContains('invalid KTAP input!'))
 		print_mock.stop()
 		file.close()
 
 	def test_crashed_test(self):
 		crashed_log = test_data_path('test_is_test_passed-crash.log')
 		with open(crashed_log) as file:
-			result = kunit_parser.parse_run_tests(file.readlines())
+			result = kunit_parser.parse_run_tests(
+				file.readlines())
 		self.assertEqual(
 			kunit_parser.TestStatus.TEST_CRASHED,
 			result.status)
@@ -216,6 +239,23 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
 		file.close()
 
+	def test_ignores_hyphen(self):
+		hyphen_log = test_data_path('test_strip_hyphen.log')
+		file = open(hyphen_log)
+		result = kunit_parser.parse_run_tests(file.readlines())
+
+		# A skipped test does not fail the whole suite.
+		self.assertEqual(
+			kunit_parser.TestStatus.SUCCESS,
+			result.status)
+		self.assertEqual(
+			"sysctl_test",
+			result.test.subtests[0].name)
+		self.assertEqual(
+			"example",
+			result.test.subtests[1].name)
+		file.close()
+
 
 	def test_ignores_prefix_printk_time(self):
 		prefix_log = test_data_path('test_config_printk_time.log')
@@ -224,7 +264,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
@@ -233,7 +273,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
@@ -242,7 +282,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
@@ -251,7 +291,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
@@ -260,7 +300,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.TEST_CRASHED,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
@@ -269,7 +309,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 class LinuxSourceTreeTest(unittest.TestCase):
 
@@ -291,6 +331,14 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				pass
 			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 
+	def test_kselftest_nested(self):
+		kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
+		with open(kselftest_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+
 	# TODO: add more test cases.
 
 
@@ -322,6 +370,12 @@ class KUnitJsonTest(unittest.TestCase):
 		result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
 		self.assertEqual(0, len(result['sub_groups']))
 
+	def test_nested_json(self):
+		result = self._json_for('test_is_test_passed-all_passed_nested.log')
+		self.assertEqual(
+			{'name': 'example_simple_test', 'status': 'PASS'},
+			result["sub_groups"][0]["sub_groups"][0]["test_cases"][0])
+
 class StrContains(str):
 	def __eq__(self, other):
 		return self in other
@@ -380,7 +434,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(e.exception.code, 1)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
-		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
+		self.print_mock.assert_any_call(StrContains('invalid KTAP input!'))
 
 	def test_exec_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
@@ -388,7 +442,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
-			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run!')))
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
@@ -397,7 +451,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
-			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run!')))
 
 	def test_run_raw_output_kunit(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log b/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
new file mode 100644
index 000000000000..9d5b04fe43a6
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log
@@ -0,0 +1,34 @@
+TAP version 14
+1..2
+	# Subtest: sysctl_test
+	1..4
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+		# Subtest: example
+		1..2
+	init_suite
+		# example_simple_test: initializing
+		# example_simple_test: example_simple_test passed
+		ok 1 - example_simple_test
+		# example_mock_test: initializing
+		# example_mock_test: example_mock_test passed
+		ok 2 - example_mock_test
+	kunit example: all tests passed
+	ok 2 - example
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: all tests passed
+ok 2 - example
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
new file mode 100644
index 000000000000..65d3f27feaf2
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-kselftest.log
@@ -0,0 +1,14 @@
+TAP version 13
+1..2
+# selftests: membarrier: membarrier_test_single_thread
+# TAP version 13
+# 1..2
+# ok 1 sys_membarrier available
+# ok 2 sys membarrier invalid command test: command = -1, flags = 0, errno = 22. Failed as expected
+ok 1 selftests: membarrier: membarrier_test_single_thread
+# selftests: membarrier: membarrier_test_multi_thread
+# TAP version 13
+# 1..2
+# ok 1 sys_membarrier available
+# ok 2 sys membarrier invalid command test: command = -1, flags = 0, errno = 22. Failed as expected
+ok 2 selftests: membarrier: membarrier_test_multi_thread
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
new file mode 100644
index 000000000000..5cd17b7f818a
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-missing_plan.log
@@ -0,0 +1,31 @@
+KTAP version 1
+	# Subtest: sysctl_test
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
+	ok 2 - sysctl_test_dointvec_table_maxlen_unset
+	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
+	ok 3 - sysctl_test_dointvec_table_len_is_zero
+	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
+	ok 4 - sysctl_test_dointvec_table_read_but_position_set
+	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
+	ok 5 - sysctl_test_dointvec_happy_single_positive
+	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
+	ok 6 - sysctl_test_dointvec_happy_single_negative
+	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
+	ok 7 - sysctl_test_dointvec_single_less_int_min
+	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
+	ok 8 - sysctl_test_dointvec_single_greater_int_max
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..2
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 - example_simple_test
+	# example_mock_test: initializing
+	# example_mock_test: example_mock_test passed
+	ok 2 - example_mock_test
+kunit example: all tests passed
+ok 2 - example
diff --git a/tools/testing/kunit/test_data/test_strip_hyphen.log b/tools/testing/kunit/test_data/test_strip_hyphen.log
new file mode 100644
index 000000000000..92ac7c24b374
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_strip_hyphen.log
@@ -0,0 +1,16 @@
+KTAP version 1
+1..2
+	# Subtest: sysctl_test
+	1..1
+	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
+	ok 1 - sysctl_test_dointvec_null_tbl_data
+kunit sysctl_test: all tests passed
+ok 1 - sysctl_test
+	# Subtest: example
+	1..1
+init_suite
+	# example_simple_test: initializing
+	# example_simple_test: example_simple_test passed
+	ok 1 example_simple_test
+kunit example: all tests passed
+ok 2 example
-- 
2.33.0.259.gc128427fd7-goog

