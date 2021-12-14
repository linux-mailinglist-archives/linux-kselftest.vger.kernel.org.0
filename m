Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D980E474BDF
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 20:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237407AbhLNT01 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 14:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbhLNT01 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 14:26:27 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D1FC06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:26:26 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s7-20020a5b0447000000b005fb83901511so38435440ybp.11
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zkTU98TBmXlIBYgAxBTuuPHlO0Cbj3Txj9arSdJ8iwk=;
        b=MDBc9xyqiaz/VjsubaFFxfHERh785fAyJWseO+87jc3DybVvAUihqoG0DIUArHUYVD
         CK7vbyoxEjQyYluK8UTILJyD4k6/NRsgs+PwyzdsfHEeFtbjVMrOFc2PUqR0Jo2cnrBP
         RgcaeuLOK7N6EvrKijReVGXdL6016C2+RS2DY+pLlzGl5lAWE1KNKZ+v2p7+I7dP0ys7
         D+AHNgVlT6SrGnxCCs398wI9hFyIQuH8OA7MQD3FhH/jNwA1zwF+IJptESzJdzuz1HP9
         tp2jtSOdtEVhECQ4dMn488Ft+JKu+8XjnsYFCUPcsd1g4n3chSWxcq68UkoGv/YM44Bl
         kTRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zkTU98TBmXlIBYgAxBTuuPHlO0Cbj3Txj9arSdJ8iwk=;
        b=tdX0NFEObPUCcUZdTc88rR5Eic88Ok3L/Zfwu4MjdFoH7iAXXc8pz9+qBfRCvskkPN
         c1xViTRD97cqCnukeqPpMmRRI74H05hzLfb6K//q4x/u3snfXtNT4XRYlu76E1ZBbuce
         6QQ55FdiALHwvTFX3OV1McCK9A7zB1Pau8C618AsXVFp0AMIEhnes/oD4uy/yVyX2Ix9
         4sp5lanrY6fCLmCI+gHDmmDPagy6eOi5uTUH5+MtlE+L9Ybfdi9qS6ZTM0Hf6T3lz9T2
         /6MPKRfGI1axllkC5by0WpZ0H1sd65GGsh4m1Ju/Xjxrh/DW9EUKUOOgaEHUUILY3PTG
         AtcA==
X-Gm-Message-State: AOAM531igJd2nL672jK0h7LzmXE4OoWQPxUgQuirewqq5GFGnvnfhWYU
        nPRem5sNOz0ggpfD38FmJZsOVXZP/OqeZg==
X-Google-Smtp-Source: ABdhPJx4FRc7tUXYGQ0cYCTrlH5zYR7QkU6hEnCpSe/vgQGD1n2mm70HsukxPm0cgAcorK0qldQ7TU3z+5h6tA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a10:bb1b:63e:864a])
 (user=dlatypov job=sendgmr) by 2002:a25:8181:: with SMTP id
 p1mr989002ybk.384.1639509986065; Tue, 14 Dec 2021 11:26:26 -0800 (PST)
Date:   Tue, 14 Dec 2021 11:26:12 -0800
In-Reply-To: <20211214192612.134306-1-dlatypov@google.com>
Message-Id: <20211214192612.134306-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20211214192612.134306-1-dlatypov@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2 2/2] kunit: tool: delete kunit_parser.TestResult type
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The `log` field is unused, and the `status` field is accessible via
`test.status`.

So it's simpler to just return the main `Test` object directly.

And since we're no longer returning a namedtuple, which has no type
annotations, this hopefully means typecheckers are better equipped to
find any errors.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: rebase onto linux-kselftest kunit branch.
More uses of `result.test` were introduced, flatten to just `result`.
---
 tools/testing/kunit/kunit.py           | 14 +++++------
 tools/testing/kunit/kunit_json.py      |  6 ++---
 tools/testing/kunit/kunit_parser.py    | 10 +++-----
 tools/testing/kunit/kunit_tool_test.py | 34 +++++++++++++-------------
 4 files changed, 29 insertions(+), 35 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 4f5c7984cf3f..417dc2d11f4f 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -172,7 +172,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 		test_end = time.time()
 		exec_time += test_end - test_start
 
-		test_counts.add_subtest_counts(result.result.test.counts)
+		test_counts.add_subtest_counts(result.result.counts)
 
 	if len(filter_globs) == 1 and test_counts.crashed > 0:
 		bd = request.build_dir
@@ -181,7 +181,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 				bd, bd, kunit_kernel.get_outfile_path(bd), bd, sys.argv[0]))
 
 	kunit_status = _map_to_overall_status(test_counts.get_status())
-	return KunitResult(status=kunit_status, result=result.result, elapsed_time=exec_time)
+	return KunitResult(status=kunit_status, result=result, elapsed_time=exec_time)
 
 def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
@@ -192,14 +192,12 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
 	parse_start = time.time()
 
-	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
-					      kunit_parser.Test(),
-					      'Tests not Parsed.')
+	test_result = kunit_parser.Test()
 
 	if request.raw_output:
 		# Treat unparsed results as one passing test.
-		test_result.test.status = kunit_parser.TestStatus.SUCCESS
-		test_result.test.counts.passed = 1
+		test_result.status = kunit_parser.TestStatus.SUCCESS
+		test_result.counts.passed = 1
 
 		output: Iterable[str] = input_data
 		if request.raw_output == 'all':
@@ -217,7 +215,7 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitR
 
 	if request.json:
 		json_obj = kunit_json.get_json_result(
-					test_result=test_result,
+					test=test_result,
 					def_config='kunit_defconfig',
 					build_dir=request.build_dir,
 					json_path=request.json)
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index b6e66c5d64d1..6862671709bc 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -11,7 +11,7 @@ import os
 
 import kunit_parser
 
-from kunit_parser import Test, TestResult, TestStatus
+from kunit_parser import Test, TestStatus
 from typing import Any, Dict, Optional
 
 JsonObj = Dict[str, Any]
@@ -50,9 +50,9 @@ def _get_group_json(test: Test, def_config: str,
 	}
 	return test_group
 
-def get_json_result(test_result: TestResult, def_config: str,
+def get_json_result(test: Test, def_config: str,
 		build_dir: Optional[str], json_path: str) -> str:
-	test_group = _get_group_json(test_result.test, def_config, build_dir)
+	test_group = _get_group_json(test, def_config, build_dir)
 	test_group["name"] = "KUnit Test Group"
 	json_obj = json.dumps(test_group, indent=4)
 	if json_path != 'stdout':
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8e42b6ef3fe3..66a7f2fb314a 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,14 +12,11 @@
 from __future__ import annotations
 import re
 
-from collections import namedtuple
 from datetime import datetime
 from enum import Enum, auto
 from functools import reduce
 from typing import Iterable, Iterator, List, Optional, Tuple
 
-TestResult = namedtuple('TestResult', ['status','test','log'])
-
 class Test(object):
 	"""
 	A class to represent a test parsed from KTAP results. All KTAP
@@ -805,7 +802,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 		print_test_result(test)
 	return test
 
-def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
+def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	"""
 	Using kernel output, extract KTAP lines, parse the lines for test
 	results and print condensed test results and summary line .
@@ -814,8 +811,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
 	kernel_output - Iterable object contains lines of kernel output
 
 	Return:
-	TestResult - Tuple containg status of main test object, main test
-		object with all subtests, and log of all KTAP lines.
+	Test - the main test object with all subtests.
 	"""
 	print_with_timestamp(DIVIDER)
 	lines = extract_tap_lines(kernel_output)
@@ -829,4 +825,4 @@ def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
 			test.status = test.counts.get_status()
 	print_with_timestamp(DIVIDER)
 	print_summary_line(test)
-	return TestResult(test.status, test, lines)
+	return test
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index e30e162bd084..1f6b177ca5c2 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -178,7 +178,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
 			result.status)
@@ -191,9 +191,9 @@ class KUnitParserTest(unittest.TestCase):
 				kunit_parser.extract_tap_lines(
 				file.readlines()))
 		# A missing test plan is not an error.
-		self.assertEqual(0, result.test.counts.errors)
+		self.assertEqual(0, result.counts.errors)
 		# All tests should be accounted for.
-		self.assertEqual(10, result.test.counts.total())
+		self.assertEqual(10, result.counts.total())
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
@@ -203,7 +203,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(header_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
@@ -213,11 +213,11 @@ class KUnitParserTest(unittest.TestCase):
 		with open(no_plan_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.test.subtests[0].subtests[0].subtests))
+		self.assertEqual(0, len(result.subtests[0].subtests[0].subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
-			result.test.subtests[0].subtests[0].status)
-		self.assertEqual(1, result.test.counts.errors)
+			result.subtests[0].subtests[0].status)
+		self.assertEqual(1, result.counts.errors)
 
 
 	def test_no_kunit_output(self):
@@ -228,7 +228,7 @@ class KUnitParserTest(unittest.TestCase):
 				kunit_parser.extract_tap_lines(file.readlines()))
 		print_mock.assert_any_call(StrContains('invalid KTAP input!'))
 		print_mock.stop()
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 
 	def test_crashed_test(self):
 		crashed_log = test_data_path('test_is_test_passed-crash.log')
@@ -269,10 +269,10 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
 		self.assertEqual(
 			"sysctl_test",
-			result.test.subtests[0].name)
+			result.subtests[0].name)
 		self.assertEqual(
 			"example",
-			result.test.subtests[1].name)
+			result.subtests[1].name)
 		file.close()
 
 
@@ -283,7 +283,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
@@ -292,7 +292,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
@@ -301,7 +301,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
@@ -310,7 +310,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
@@ -319,7 +319,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.TEST_CRASHED,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
@@ -328,7 +328,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
@@ -467,7 +467,7 @@ class KUnitJsonTest(unittest.TestCase):
 		with open(test_data_path(log_file)) as file:
 			test_result = kunit_parser.parse_run_tests(file)
 			json_obj = kunit_json.get_json_result(
-				test_result=test_result,
+				test=test_result,
 				def_config='kunit_defconfig',
 				build_dir=None,
 				json_path='stdout')
-- 
2.34.1.173.g76aa8bc2d0-goog

