Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 474703F34E6
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Aug 2021 22:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238757AbhHTUBv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Aug 2021 16:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238656AbhHTUBs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Aug 2021 16:01:48 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEC0C061756
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 13:01:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i32-20020a25b2200000b02904ed415d9d84so10702017ybj.0
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Aug 2021 13:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=F1k3K11bnONblZiBQc5r+h4xDNmxviChrG2LEtf13SM=;
        b=hIvXBe03/E0TGEFqfIM1rAJD9XIL+lUVuk20Dr0mpCGD7g9jlrT+oSXdT5wg8t0fSm
         wJeb6TRFg6yvfc8dyVtkTnwqn0xjW7u72UNAcLELUojzNHf/RnbmyThqJNu21MmiUk6X
         o5Urk97lZU59YcOfosATRkSFGf9rMS+alpmkeTTN7jVWcR+jTgBRH1SV0w3lPgr3Jz/W
         HoaoFdSxgF8U2QYgnmqbNVjQMSyU9jbjY06HPJLp5R6uTyBzeU7Fk6QUbMzZd26cIJlT
         1R8HrfaxUiOadtgoUfZMl6r9j4maCpypQ63XQryje3vBejGQmLQLq34w1Au+q4LDt8nM
         daYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=F1k3K11bnONblZiBQc5r+h4xDNmxviChrG2LEtf13SM=;
        b=E07IuEj+gpuPQTzvE2Y6pJuLHT9Pzvvt60dEMGZUspBk9FN0LGY0jJLo0ftFHojKQg
         GfVEi/4J6JALpLhsVekyzjOYfTHSomcbbCOwePeDk17X9kMLonbPhTD1GCtTOxVcFgLH
         X7Kx4bjQ4iinVys6QY0cZAufACkEvo8lAxYaf8vSeIIUXTG527o5CjgsrU6tyCFDuUOv
         924gVBACbD2bzUrGLr7V248x5Cgg1P4yJ032ssVtlzMYi9WGzH3G9Mll1c3EZJK+MooM
         gc0b7CpOyDq6j5ETk7CJIv/1IkSvBRFjwJT9dUgH5L+hwkyKO+nI4xKldWMWh4sO8Py3
         K8bQ==
X-Gm-Message-State: AOAM532aLR1hgjFaBlUMzjifqczVSLqpKvHHz5/YCcpqAsqZKGgEeM4h
        /ecg/Z6NrSWrmnrtESPa4z859evfxg==
X-Google-Smtp-Source: ABdhPJzUBCr2+CwBnLNAMvw3ZXACnbs8s0FBjYtb0BW2Wx7eLf1wUPlHSTSp+OwzRBmMTao6WvRSCVae1w==
X-Received: from sunrae.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2814])
 (user=rmoar job=sendgmr) by 2002:a5b:443:: with SMTP id s3mr17406385ybp.299.1629489669747;
 Fri, 20 Aug 2021 13:01:09 -0700 (PDT)
Date:   Fri, 20 Aug 2021 20:00:32 +0000
Message-Id: <20210820200032.2178134-1-rmoar@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.rc2.250.ged5fa647cd-goog
Subject: [PATCH] kunit: tool: improve compatibility of kunit_parser with KTAP specification
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Update to kunit_parser to improve compatibility with KTAP
specification including arbitrarily nested tests. Patch accomplishes
three major changes:

- Use a general Test object to represent all tests rather than TestCase
and TestSuite objects. This allows for easier implementation of arbitrary
levels of nested test and promotes the idea that both test suites and test
cases are tests.

- Print errors incrementally rather than all at once after the
parsing finishes to maximize information given to the user in the
case of the parser given invalid input and to increase the helpfulness
of the timestamps given during printing.

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
---
 tools/testing/kunit/kunit_json.py             |   54 +-
 tools/testing/kunit/kunit_parser.py           | 1191 ++++++++++++-----
 tools/testing/kunit/kunit_tool_test.py        |   91 +-
 .../test_is_test_passed-all_passed_nested.log |   34 +
 4 files changed, 986 insertions(+), 384 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-all_passed_nested.log

diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index f5cca5c38cac..cc4bc9cc6e0f 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -11,47 +11,45 @@ import os
 
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
+from typing import Any, Dict
+
+JsonObj = Dict[str, Any]
+
+def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
+	sub_groups = []  # List[JsonObj]
+	test_cases = []  # List[JsonObj]
+
+	for subtest in test.subtests:
+		if len(subtest.subtests):
+			sub_group = _get_group_json(subtest, def_config, build_dir)
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
+def get_json_result(test_result: TestResult, def_config: str, build_dir: str, \
+		json_path: str) -> str:
+	test_group = _get_group_json(test_result.test, def_config, build_dir)
+	test_group["name"] = "KUnit Test Group"
 	json_obj = json.dumps(test_group, indent=4)
 	if json_path != 'stdout':
 		with open(json_path, 'w') as result_path:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index b88db3f51dc5..bca4d19f7636 100644
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
@@ -14,33 +18,84 @@ from enum import Enum, auto
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
+		"""
+		Contructs the default attributes of a Test class object.
 
-	def __repr__(self) -> str:
-		return str(self)
+		Parameters:
+		None
 
-class TestCase(object):
-	def __init__(self) -> None:
+		Return:
+		None
+		"""
 		self.status = TestStatus.SUCCESS
 		self.name = ''
+		self.expected_count = 0  # type: Optional[int]
+		self.subtests = []  # type: List[Test]
 		self.log = []  # type: List[str]
+		self.counts = TestCounts()
 
 	def __str__(self) -> str:
-		return 'TestCase(' + str(self.status) + ',' + self.name + ',' + str(self.log) + ')'
+		"""
+		Returns string representation of a Test class object.
+
+		Parameters:
+		None
+
+		Return:
+		str - string representation of the Test class object
+		"""
+		return ('Test(' + str(self.status) + ', ' + self.name + ', ' +
+			str(self.expected_count) + ', ' + str(self.subtests) +
+			', ' + str(self.log) + ', ' + str(self.counts) + ')')
 
 	def __repr__(self) -> str:
+		"""
+		Returns string representation of a Test class object.
+
+		Parameters:
+		None
+
+		Return:
+		str - string representation of the Test class object
+		"""
 		return str(self)
 
+	def add_error(self, message: str):
+		"""
+		Adds error to test object by printing the error and
+		incrementing the error count.
+
+		Parameters:
+		message : str - error message to print
+
+		Return:
+		None
+		"""
+		print_error('Test ' + self.name + ': ' + message)
+		self.counts.errors += 1
+
 class TestStatus(Enum):
+	"""An enumeration class to represent the status of a test."""
 	SUCCESS = auto()
 	FAILURE = auto()
 	SKIPPED = auto()
@@ -48,385 +103,889 @@ class TestStatus(Enum):
 	NO_TESTS = auto()
 	FAILURE_TO_PARSE_TESTS = auto()
 
+class TestCounts:
+	"""
+	A class to represent the counts of statuses and test errors of
+	subtests or of the test itself if the test is a single test case with
+	no subtests. Note that the sum of the counts of passed, failed,
+	crashed, and skipped should sum to the total number of subtests for
+	the test.
+
+	Attributes:
+	passed : int - the number of tests that have passed
+	failed : int - the number of tests that have failed
+	crashed : int - the number of tests that have crashed
+	skipped : int - the number of tests that have skipped
+	errors : int - the number of errors in the test and subtests
+	"""
+	def __init__(self):
+		"""
+		Contructs the default attributes of a TestCounts class object.
+		Sets the counts of all test statuses and test errors to be 0.
+
+		Parameters:
+		None
+
+		Return:
+		None
+		"""
+		self.passed = 0
+		self.failed = 0
+		self.crashed = 0
+		self.skipped = 0
+		self.errors = 0
+
+	def __str__(self) -> str:
+		"""
+		Returns total number of subtests or 1 if the test object has
+		no subtests. This number is calculated by the sum of the
+		passed, failed, crashed, and skipped subtests.
+
+		Parameters:
+		None
+
+		Return:
+		str - string representing TestCounts object.
+		"""
+		return ('Passed: ' + str(self.passed) + ', Failed: ' +
+			str(self.failed) + ', Crashed: ' + str(self.crashed) +
+			', Skipped: ' + str(self.skipped) + ', Errors: ' +
+			str(self.errors))
+
+	def total(self) -> int:
+		"""
+		Returns total number of subtests or 1 if the test object has
+		no subtests. This number is calculated by the sum of the
+		passed, failed, crashed, and skipped subtests.
+
+		Parameters:
+		None
+
+		Return:
+		int - the total number of subtests or 1 if the test object has
+			no subtests
+		"""
+		return self.passed + self.failed + self.crashed + self.skipped
+
+	def add_subtest_counts(self, counts: TestCounts) -> None:
+		"""
+		Adds the counts of another TestCounts object to the current
+		TestCounts object. Used to add the counts of a subtest to the
+		parent test.
+
+		Parameters:
+		counts : TestCounts - another TestCounts object whose counts
+		will be added to the counts of the TestCounts object
+
+		Return:
+		None
+		"""
+		self.passed += counts.passed
+		self.failed += counts.failed
+		self.crashed += counts.crashed
+		self.skipped += counts.skipped
+		self.errors += counts.errors
+
+	def get_status(self) -> TestStatus:
+		"""
+		Returns the expected status of a Test using test counts.
+
+		Parameters:
+		None
+
+		Return:
+		TestStatus - expected status of a Test given test counts
+		"""
+		if self.crashed:
+			# If one of the subtests crash, the expected status of
+			# the Test is crashed.
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
+		Given inputted status, increments corresponding attribute of
+		TestCounts object.
+
+		Parameters:
+		status : TestStatus - status to be added to the TestCounts
+			object
+
+		Return:
+		None
+		"""
+		if status == TestStatus.SUCCESS or \
+				status == TestStatus.NO_TESTS:
+			# if status is NO_TESTS the most appropriate attribute
+			# to increment is passed because the test did not
+			# fail, crash or get skipped.
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
+
+	Attributes:
+	_lines : Iterator[Tuple[int, str]] - Iterator containing tuple of
+		line number and line of kernel output
+	_next : Tuple[int, str] - Tuple containing next line and the
+		corresponding line number
+	_done : bool - boolean denoting whether the LineStream has reached
+		the end of the lines
+	"""
 	_lines: Iterator[Tuple[int, str]]
 	_next: Tuple[int, str]
 	_done: bool
 
 	def __init__(self, lines: Iterator[Tuple[int, str]]):
+		"""Set defaults for LineStream object and sets _lines
+		attribute to lines parameter.
+		"""
 		self._lines = lines
 		self._done = False
 		self._next = (0, '')
 		self._get_next()
 
 	def _get_next(self) -> None:
+		"""Sets _next attribute to the upcoming Tuple of line and
+		line number in the LineStream.
+		"""
 		try:
 			self._next = next(self._lines)
 		except StopIteration:
 			self._done = True
 
 	def peek(self) -> str:
+		"""Returns the line stored in the _next attribute."""
 		return self._next[1]
 
 	def pop(self) -> str:
+		"""Returns the line stored in the _next attribute and sets the
+		_next attribute to the following line and line number Tuple.
+		"""
 		n = self._next
 		self._get_next()
 		return n[1]
 
 	def __bool__(self) -> bool:
+		"""Returns whether the LineStream has reached the end of the
+		lines.
+		"""
 		return not self._done
 
 	# Only used by kunit_tool_test.py.
 	def __iter__(self) -> Iterator[str]:
+		"""Returns an Iterator object containing all of the lines
+		stored in the LineStream object. This method also empties the
+		LineStream so it reaches the end of the lines.
+		"""
 		while bool(self):
 			yield self.pop()
 
 	def line_number(self) -> int:
+		"""Returns the line number of the upcoming line."""
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
+	"""
+	Returns LineStream object of extracted ktap lines within
+	inputted kernel output.
+
+	Parameters:
+	kernel_output : Iterable[str] - iterable object contains lines
+		of kernel output
+
+	Return:
+	LineStream - LineStream object containing extracted ktap lines.
+	"""
+	def isolate_ktap_output(kernel_output: Iterable[str]) \
+			-> Iterator[Tuple[int, str]]:
+		"""
+		Helper method of extract_tap_lines that yields extracted
+		ktap lines within inputted kernel output. Output is used to
+		create LineStream object in isolate_ktap_output.
+
+		Parameters:
+		kernel_output : Iterable[str] - iterable object contains lines
+			of kernel output
+
+		Return:
+		Iterator[Tuple[int, str]] - Iterator object containing tuples
+		with extracted ktap lines and their correesponding line
+		number.
+		"""
 		line_num = 0
 		started = False
 		for line in kernel_output:
 			line_num += 1
-			line = line.rstrip()  # line always has a trailing \n
-			if kunit_start_re.search(line):
+			line = line.rstrip()  # remove trailing \n
+			if not started and KTAP_START.search(line):
+				prefix_len = len(
+					line.split('KTAP version')[0])
+				started = True
+				yield line_num, line[prefix_len:]
+			elif not started and TAP_START.search(line):
 				prefix_len = len(line.split('TAP version')[0])
 				started = True
 				yield line_num, line[prefix_len:]
-			elif kunit_end_re.search(line):
+			elif started and KTAP_END.search(line):
 				break
 			elif started:
-				yield line_num, line[prefix_len:]
-	return LineStream(lines=isolate_kunit_output(kernel_output))
-
-def raw_output(kernel_output) -> None:
+				# remove prefix and indention
+				line = line[prefix_len:].lstrip()
+				yield line_num, line
+	return LineStream(lines=isolate_ktap_output(kernel_output))
+
+def raw_output(kernel_output: Iterable[str]) -> None:
+	"""
+	Prints all of given kernel output.
+
+	Parameters:
+	kernel_output : Iterable[str] - iterable object contains lines
+		of kernel output
+
+	Return:
+	None
+	"""
 	for line in kernel_output:
 		print(line.rstrip())
 
-DIVIDER = '=' * 60
-
-RESET = '\033[0;0m'
-
-def red(text) -> str:
-	return '\033[1;31m' + text + RESET
-
-def yellow(text) -> str:
-	return '\033[1;33m' + text + RESET
+KTAP_VERSIONS = [1]
+TAP_VERSIONS = [13, 14]
+
+def check_version(version_num: int, accepted_versions: List[int], \
+		version_type: str, test: Test) -> None:
+	"""
+	Adds errors to the test if the version number is too high or too low.
+
+	Parameters:
+	version_num : int - The inputted version number from the parsed
+		ktap or tap header line
+	accepted_version : List[int] - List of accepted ktap or tap versions
+	version_type : str - 'KTAP' or 'TAP' depending on the type of
+		version line.
+	test : Test - Test object representing current test object being
+		parsed
+
+	Return:
+	None
+	"""
+	if version_num < min(accepted_versions):
+		test.add_error(version_type + ' version lower than expected!')
+	elif version_num > max(accepted_versions):
+		test.add_error(
+			version_type + ' version higher than expected!')
+
+def parse_ktap_header(lines: LineStream, test: Test) -> bool:
+	"""
+	If the next line in LineStream matches the format of ktap or tap
+	header line, the version number is checked, the line is popped,
+	and returns True. Otherwise the method returns False.
+
+	Accepted formats:
+	- 'KTAP version [version number]'
+	- 'TAP version [version number]'
+
+	Parameters:
+	lines : LineStream - LineStream object containing ktap lines from
+		kernel output
+	test : Test - Test object representing current test object being
+		parsed
+
+	Return:
+	bool : Represents if the next line in the LineStream was parsed as
+		the ktap or tap header line
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
+
+TEST_HEADER = re.compile(r'^# Subtest: (.*)$')
+
+def parse_test_header(lines: LineStream, test: Test) -> bool:
+	"""
+	If the next line in LineStream matches the format of a test
+	header line, the name of test is set, the line is popped,
+	and returns True. Otherwise the method returns False.
+
+	Accepted format:
+	- '# Subtest: [test name]'
+
+	Parameters:
+	lines : LineStream - LineStream object containing ktap lines from
+		kernel output
+	test : Test - Test object representing current test object being
+		parsed
+
+	Return:
+	bool : Represents if the next line in the LineStream was parsed as
+		a test header
+	"""
+	match = TEST_HEADER.match(lines.peek())
+	if not match:
+		return False
+	test.log.append(lines.pop())
+	test.name = match.group(1)
+	return True
+
+TEST_PLAN = re.compile(r'1\.\.([0-9]+)')
+
+def parse_test_plan(lines: LineStream, test: Test) -> bool:
+	"""
+	If the next line in LineStream matches the format of a test
+	plan line, the expected number of subtests is set in test object, an
+	error is thrown if there are 0 tests, the line is popped,
+	and returns True. Otherwise the method adds an error that the test
+	plan is missing to the test object and returns False.
+
+	Accepted format:
+	- '1..[number of subtests]'
+
+	Parameters:
+	lines : LineStream - LineStream object containing ktap lines from
+		kernel output
+	test : Test - Test object representing current test object being
+		parsed
+
+	Return:
+	bool : Represents if the next line in the LineStream was parsed as
+		a test plan
+	"""
+	match = TEST_PLAN.match(lines.peek())
+	if not match:
+		test.expected_count = None
+		test.add_error('missing plan line!')
+		return False
+	test.log.append(lines.pop())
+	expected_count = int(match.group(1))
+	test.expected_count = expected_count
+	if expected_count == 0:
+		test.status = TestStatus.NO_TESTS
+		test.add_error('0 tests run!')
+	return True
+
+TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*)$')
+
+TEST_RESULT_SKIP = re.compile(r'^(ok|not ok) ([0-9]+) (- )?(.*) # SKIP(.*)$')
+
+def peek_test_name_match(lines: LineStream, test: Test) -> bool:
+	"""
+	If the next line in LineStream matches the format of a test
+	result line and the name of the result line matches the name of the
+	current test, the method returns True. Otherwise it returns False.
+
+	Accepted format:
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines : LineStream - LineStream object containing ktap lines from
+		kernel output
+	test : Test - Test object representing current test object being
+		parsed
+
+	Return:
+	bool : Represents if the next line in the LineStream matched a test
+		result line and the name matched the test name
+	"""
+	line = lines.peek()
+	match = TEST_RESULT.match(line)
+	if not match:
+		return False
+	name = match.group(4)
+	return (name == test.name)
+
+def parse_test_result(lines: LineStream, test: Test, expected_num: int) \
+		-> bool:
+	"""
+	If the next line in LineStream matches the format of a test
+	result line, the status in the result line is added to the test
+	object, the test number is checked to match the expected test number
+	and if not an error is added to the test object, and returns True.
+	Otherwise it returns False. Note that the skip diirective is the only
+	directive that causes a change in status and otherwise the directive
+	is included in the name of the test.
+
+	Accepted format:
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines : LineStream - LineStream object containing ktap lines from
+		kernel output
+	test : Test - Test object representing current test object being
+		parsed
+	expected_num : int - expected test number for current test
+
+	Return:
+	bool : Represents if the next line in the LineStream was parsed as a
+		test result line.
+	"""
+	line = lines.peek()
+	match = TEST_RESULT.match(line)
+	skip_match = TEST_RESULT_SKIP.match(line)
 
-def green(text) -> str:
-	return '\033[1;32m' + text + RESET
+	# Check if line matches test result line format
+	if not match:
+		return False
+	test.log.append(lines.pop())
 
-def print_with_timestamp(message) -> None:
-	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
+	# Check test num
+	num = int(match.group(2))
+	if num != expected_num:
+		test.add_error('Expected test number ' +
+			str(expected_num) + ' but found ' + str(num))
 
-def format_suite_divider(message) -> str:
-	return '======== ' + message + ' ========'
+	# Set name of test object
+	if skip_match:
+		test.name = skip_match.group(4)
+	else:
+		test.name = match.group(4)
 
-def print_suite_divider(message) -> None:
-	print_with_timestamp(DIVIDER)
-	print_with_timestamp(format_suite_divider(message))
+	# Set status of test object
+	status = match.group(1)
+	if test.status == TestStatus.TEST_CRASHED:
+		return True
+	elif skip_match:
+		test.status = TestStatus.SKIPPED
+	elif status == 'ok':
+		test.status = TestStatus.SUCCESS
+	else:
+		test.status = TestStatus.FAILURE
+	return True
+
+DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^# .*?: kunit test case crashed!$')
+
+def parse_diagnostic(lines: LineStream, test: Test) -> None:
+	"""
+	If the next line in LineStream does not match the format of a test
+	case line or test header line, the line is checked if the test has
+	crashed and if so adds an error message, pops the line and adds it to
+	the log.
+
+	Line formats that are not parsed:
+	- '# Subtest: [test name]'
+	- '[ok|not ok] [test number] [-] [test name] [optional skip
+		directive]'
+
+	Parameters:
+	lines : LineStream - LineStream object containing ktap lines from
+		kernel output
+	test : Test - Test object representing current test object being
+		parsed
+
+	Return:
+	None
+	"""
+	while lines and not TEST_RESULT.match(lines.peek()) and not \
+			TEST_HEADER.match(lines.peek()):
+		if DIAGNOSTIC_CRASH_MESSAGE.match(lines.peek()):
+			test.status = TestStatus.TEST_CRASHED
+		test.log.append(lines.pop())
+
+# Printing helper methods:
 
-def print_log(log) -> None:
-	for m in log:
-		print_with_timestamp(m)
+DIVIDER = '=' * 60
 
-TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
+RESET = '\033[0;0m'
 
-def consume_non_diagnostic(lines: LineStream) -> None:
-	while lines and not TAP_ENTRIES.match(lines.peek()):
-		lines.pop()
+def red(text: str) -> str:
+	"""
+	Returns string with added red ansi color code at beginning and reset
+	code at end.
 
-def save_non_diagnostic(lines: LineStream, test_case: TestCase) -> None:
-	while lines and not TAP_ENTRIES.match(lines.peek()):
-		test_case.log.append(lines.peek())
-		lines.pop()
+	Parameters:
+	text: str -> text to be made red with ansi color codes
 
-OkNotOkResult = namedtuple('OkNotOkResult', ['is_ok','description', 'text'])
+	Return:
+	str - original text made red with ansi color codes
+	"""
+	return '\033[1;31m' + text + RESET
 
-OK_NOT_OK_SKIP = re.compile(r'^[\s]*(ok|not ok) [0-9]+ - (.*) # SKIP(.*)$')
+def yellow(text: str) -> str:
+	"""
+	Returns string with added yellow ansi color code at beginning and
+	reset code at end.
 
-OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
+	Parameters:
+	text: str -> text to be made yellow with ansi color codes
 
-OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
+	Return:
+	str - original text made yellow with ansi color codes
+	"""
+	return '\033[1;33m' + text + RESET
 
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
-		return False
+def green(text: str) -> str:
+	"""
+	Returns string with added green ansi color code at beginning and reset
+	code at end.
 
-SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
-DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
+	Parameters:
+	text: str -> text to be made green with ansi color codes
 
-def parse_diagnostic(lines: LineStream, test_case: TestCase) -> bool:
-	save_non_diagnostic(lines, test_case)
-	if not lines:
-		return False
-	line = lines.peek()
-	match = SUBTEST_DIAGNOSTIC.match(line)
-	if match:
-		test_case.log.append(lines.pop())
-		crash_match = DIAGNOSTIC_CRASH_MESSAGE.match(line)
-		if crash_match:
-			test_case.status = TestStatus.TEST_CRASHED
-		return True
-	else:
-		return False
+	Return:
+	str - original text made green with ansi color codes
+	"""
+	return '\033[1;32m' + text + RESET
 
-def parse_test_case(lines: LineStream) -> Optional[TestCase]:
-	test_case = TestCase()
-	save_non_diagnostic(lines, test_case)
-	while parse_diagnostic(lines, test_case):
-		pass
-	if parse_ok_not_ok_test_case(lines, test_case):
-		return test_case
-	else:
-		return None
+ANSI_LEN = len(red(''))
 
-SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
+def print_with_timestamp(message: str) -> None:
+	"""
+	Prints message with timestamp at beginning.
 
-def parse_subtest_header(lines: LineStream) -> Optional[str]:
-	consume_non_diagnostic(lines)
-	if not lines:
-		return None
-	match = SUBTEST_HEADER.match(lines.peek())
-	if match:
-		lines.pop()
-		return match.group(1)
-	else:
-		return None
+	Parameters:
+	message: str -> message to be printed
 
-SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
+	Return:
+	None
+	"""
+	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
 
-def parse_subtest_plan(lines: LineStream) -> Optional[int]:
-	consume_non_diagnostic(lines)
-	match = SUBTEST_PLAN.match(lines.peek())
-	if match:
-		lines.pop()
-		return int(match.group(1))
+def format_test_divider(message: str, len_message: int) -> str:
+	"""
+	Returns string with message centered in fixed width divider.
+
+	Example:
+	'===================== message example ====================='
+
+	Parameters:
+	message: str -> message to be centered in divider line
+	len_message : int -> length of the message to be printed in the
+		divider such that the ansi codes are not counted if the
+		message is colored.
+
+	Return:
+	str - string containing message centered in fixed width divider
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
+	test: Test -> Test object representing current test object being
+		parsed and information used to print test header
+
+	Return:
+	None
+	"""
+	message = test.name
+	if test.expected_count:
+		message += ' (' + str(test.expected_count) + ' subtests)'
+	print_with_timestamp(format_test_divider(message, len(message)))
+
+def print_log(log: Iterable[str]) -> None:
+	"""
+	Prints all strings in saved log for test in yellow.
+
+	Parameters:
+	log: Iterable[str] -> Iterable object with all strings saved in log
+		for test
+
+	Return:
+	None
+	"""
+	for m in log:
+		print_with_timestamp(yellow(m))
+	print_with_timestamp('')
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
+	test: Test -> Test object representing current test object being
+		parsed and information used to print test result
+
+	Return:
+	str - string containing formatted test result
+	"""
+	if test.status == TestStatus.SUCCESS:
+		return (green('[PASSED] ') + test.name)
+	elif test.status == TestStatus.SKIPPED:
+		return (yellow('[SKIPPED] ') + test.name)
+	elif test.status == TestStatus.TEST_CRASHED:
+		print_log(test.log)
+		return (red('[CRASHED] ') + test.name)
 	else:
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
+	test: Test -> Test object representing current test object being
+		parsed and information used to print test result line
+
+	Return:
+	None
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
+	test: Test -> Test object representing current test object being
+		parsed and information used to print test footer
+
+	Return:
+	None
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
+	'Testing complete. Passed: 2, Failed: 0, Crashed: 0, Skipped: 0, \
+	Errors: 0'
+
+	Parameters:
+	test: Test -> Test object representing current test object being
+		parsed and information used to print test summary line
+
+	Return:
+	None
+	"""
+	if test.status == TestStatus.SUCCESS or \
+			test.status == TestStatus.NO_TESTS:
+		color = green
+	elif test.status == TestStatus.SKIPPED:
+		color = yellow
 	else:
-		return left
-
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
+		color = red
+	counts = test.counts
+	print_with_timestamp(color('Testing complete. ' + str(counts)))
+
+def print_error(message: str) -> None:
+	"""
+	Prints message with error format.
+
+	Parameters:
+	message: str -> message to be used as error message
+
+	Return:
+	None
+	"""
+	print_with_timestamp(red('[ERROR] ') + message)
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
+	test : Test - Test object representing current test object being
+		parsed
+
+	Return:
+	None
+	"""
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
+def parse_test(lines: LineStream, expected_num: int) -> Test:
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
+	lines : LineStream - LineStream object containing ktap lines from
+		kernel output
+	expected_num : int - expected test number for test to be parsed
+
+	Return:
+	Test : Test object populated with characteristics and containing any
+		subtests
+	"""
+	test = Test()
+	parent_test = False
+	main = parse_ktap_header(lines, test)
+	if main:
+		# If KTAP/TAP header is found, attempt to parse
+		# test plan
+		parse_test_plan(lines, test)
 	else:
-		return False
-
-def bubble_up_errors(status_list: Iterable[TestStatus]) -> TestStatus:
-	return reduce(max_status, status_list, TestStatus.SKIPPED)
-
-def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
-	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
-	return max_status(max_test_case_status, test_suite.status)
-
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
+		# If KTAP/TAP header is not found, test must be subtest
+		# header or test result line so parse attempt to parser
+		# subtest header
+		parse_diagnostic(lines, test)
+		parent_test = parse_test_header(lines, test)
+		if parent_test:
+			# If subtest header is found, attempt to parse
+			# test plan and print header
+			parse_test_plan(lines, test)
+			print_test_header(test)
+	expected_count = test.expected_count
+	subtests = []
+	test_num = 1
+	while main or expected_count is None or test_num <= expected_count:
+		# Loop to parse any subtests.
+		# If test is main test, do not break until no lines left.
+		# Otherwise, break after parsing expected number of tests or
+		# if expected number of tests is unknown break when found
+		# test result line with matching name to subtest header.
+		if not lines:
+			if expected_count and test_num <= expected_count:
+				test.add_error('missing expected subtests!')
 			break
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
-
-TAP_HEADER = re.compile(r'^TAP version 14$')
-
-def parse_tap_header(lines: LineStream) -> bool:
-	consume_non_diagnostic(lines)
-	if TAP_HEADER.match(lines.peek()):
-		lines.pop()
-		return True
-	else:
-		return False
-
-TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
-
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
-		else:
-			print_with_timestamp(
-				red('[ERROR] ') + ' expected ' +
-				str(expected_test_suite_num) +
-				' test suites, but got ' + str(i - 2))
+		if not expected_count and not main and \
+				peek_test_name_match(lines, test):
 			break
-	test_suite = parse_test_suite(lines, -1)
-	if test_suite:
-		print_with_timestamp(red('[ERROR] ') +
-			'got unexpected test suite: ' + test_suite.name)
-	if test_suites:
-		return TestResult(bubble_up_suite_errors(test_suites), test_suites, lines)
-	else:
-		return TestResult(TestStatus.NO_TESTS, [], lines)
-
-class TestCounts:
-	passed: int
-	failed: int
-	crashed: int
-	skipped: int
-
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
+		subtests.append(parse_test(lines, test_num))
+		test_num += 1
+	test.subtests = subtests
+	if not main:
+		# If not main test, look for test result line
+		parse_diagnostic(lines, test)
+		if (parent_test and peek_test_name_match(lines, test)) or \
+				not parent_test:
+			parse_test_result(lines, test, expected_num)
+			if not parent_test:
+				print_test_result(test)
 		else:
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
-			else:
-				counts.failed += 1
-				print_with_timestamp(red('[FAILED] ') + test_case.name)
-				print_log(map(yellow, test_case.log))
-				print_with_timestamp('')
-	return counts
+			test.add_error('missing subtest result line!')
+	# Add statuses to TestCounts attribute in Test object
+	bubble_up_test_results(test)
+	if parent_test:
+		# If test has subtests and is not the main test object, print
+		# footer.
+		print_test_footer(test)
+	return test
 
 def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
-	counts = TestCounts()
+	"""
+	Using kernel output, extract ktap lines, parse the lines for test
+	results and print condensed test results and summary line .
+
+	Parameters:
+	kernel_output : Iterable[str] - iterable object contains lines
+		of kernel output
+
+	Return:
+	TestResult - Tuple containg status of main test object, main test
+		object with all subtests, and log of all ktap lines.
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
+		test = parse_test(lines, 0)
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
index 75045aa0f8a1..ca760ee32096 100755
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
@@ -162,17 +169,19 @@ class KUnitParserTest(unittest.TestCase):
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.suites))
+		self.assertEqual(0, len(result.test.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
 			result.status)
 
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
@@ -182,15 +191,17 @@ class KUnitParserTest(unittest.TestCase):
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
@@ -224,7 +235,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
@@ -233,7 +244,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
@@ -242,7 +253,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
@@ -251,16 +262,16 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
-				kunit_parser.TestStatus.TEST_CRASHED,
+				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
@@ -269,7 +280,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
 
 class LinuxSourceTreeTest(unittest.TestCase):
 
@@ -380,7 +391,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(e.exception.code, 1)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
-		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
+		self.print_mock.assert_any_call(StrContains('invalid KTAP input!'))
 
 	def test_exec_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
@@ -388,7 +399,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
-			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+			self.assertNotEqual(call, mock.call(StrContains('0 tests run!')))
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
@@ -397,7 +408,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
-			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
+			self.assertNotEqual(call, mock.call(StrContains('0 tests run!')))
 
 	def test_exec_timeout(self):
 		timeout = 3453
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
-- 
2.33.0.rc2.250.ged5fa647cd-goog

