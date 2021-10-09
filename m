Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA71427583
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Oct 2021 03:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244113AbhJIB4R (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 21:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232078AbhJIB4Q (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 21:56:16 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A95EC061570
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Oct 2021 18:54:20 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h8-20020a05620a284800b0045ec745583cso9773851qkp.6
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Oct 2021 18:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/BFuDxjBhHOhIxtZh16h2WKXDrqK0nM9uXbgauSX0cE=;
        b=Exhl9qN4bHilVV3EMRGH9uFWiU4Obdd5CEjxgNTxD6CCpxzzrn9UbEvRxhwc8bZgvH
         abj1E4CAZBVgmwx++uks7jsxPmHt8LuAckbBR+Kd+TkK1H6JZVh212BijTZ0/9SE9XiQ
         1G47jKOGEtyACOLK8aTA2ic9tZKDafWmNx+19X8mI7r9VvQpqdRzrA1qRWks9q3/e9cm
         ibgINR+TbotiXN1XopZQQfLuuNoEqLiadY89xccv06VRWwrjB8tMjGJqVXe9sBMi9rl3
         VLMAn007CgF31vS8NIIGorb6heJUppfel4EyR0F3SNIY4fh3tcEddfcxuW+7Nz/wVVjQ
         8jEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/BFuDxjBhHOhIxtZh16h2WKXDrqK0nM9uXbgauSX0cE=;
        b=nYl7vHwUnp9/oyqdW03wmNTVj48wepNPdhS2ZpvS1s5KAqX8r/dl2aiHzrkTssOH8Q
         z6D0uTtXi6jDB79m5KkM5dRcte3f04ndbDBtHtdesIuv6x+1pvVldBnB1mQDhOE5kqWU
         MlUqxuSYmaFXrec88QMwu+8o4aVW/C6dmDG9jo0PJ3AoMwcP6cXzuMPXCFVReSjzvJrK
         OWMxOO3aNfhvl1AffZ/QEyO67De9bWZi6pEgFHIbNZD5irn7EAX+y3Jg1T5SWFUTYI8D
         vInvWQEBtuUj9oZUu5qjtP5DvmvTvizc/XXFqEt4UuTVH59vV3/RvxkEaMYbWsjMBWOx
         INlg==
X-Gm-Message-State: AOAM532mLoDx9rceetQHV3lnbD1SQfHsHZ3qi4ltiGSVKd8F7N1zC822
        zAbubK/t/vKAC19AkxvurAjPFCQkNLvVPA==
X-Google-Smtp-Source: ABdhPJx3JkLFfb6HNWrDZycGSjzK+wvmW+wxFcD65PEQ2s9rB7S8aKTKKkVILNC0Wd+YFhk+bZtOu+Ob7eevGQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:fc52:cec:3819:b41f])
 (user=dlatypov job=sendgmr) by 2002:ac8:138c:: with SMTP id
 h12mr1781731qtj.357.1633744459494; Fri, 08 Oct 2021 18:54:19 -0700 (PDT)
Date:   Fri,  8 Oct 2021 18:54:06 -0700
In-Reply-To: <20211009015406.1311319-1-dlatypov@google.com>
Message-Id: <20211009015406.1311319-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20211009015406.1311319-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 2/2] kunit: tool: delete kunit_parser.TestResult type
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
---
 tools/testing/kunit/kunit.py           | 14 ++++++--------
 tools/testing/kunit/kunit_json.py      |  6 +++---
 tools/testing/kunit/kunit_parser.py    | 10 +++-------
 tools/testing/kunit/kunit_tool_test.py | 26 +++++++++++++-------------
 4 files changed, 25 insertions(+), 31 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f879414a13c4..72ba4ec20244 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -172,10 +172,10 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 		test_end = time.time()
 		exec_time += test_end - test_start
 
-		test_counts.add_subtest_counts(result.result.test.counts)
+		test_counts.add_subtest_counts(result.result.counts)
 
 	kunit_status = _map_to_overall_status(test_counts.get_status())
-	return KunitResult(status=kunit_status, result=result.result, elapsed_time=exec_time)
+	return KunitResult(status=kunit_status, result=result, elapsed_time=exec_time)
 
 def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
@@ -186,14 +186,12 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
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
@@ -211,7 +209,7 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitR
 
 	if request.json:
 		json_obj = kunit_json.get_json_result(
-					test_result=test_result,
+					test=test_result,
 					def_config='kunit_defconfig',
 					build_dir=request.build_dir,
 					json_path=request.json)
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 746bec72b9ac..31d76030f5c2 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -11,7 +11,7 @@ import os
 
 import kunit_parser
 
-from kunit_parser import Test, TestResult, TestStatus
+from kunit_parser import Test, TestStatus
 from typing import Any, Dict, Optional
 
 JsonObj = Dict[str, Any]
@@ -48,9 +48,9 @@ def _get_group_json(test: Test, def_config: str,
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
index f01fd565f978..0b2626cc0628 100644
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
@@ -796,7 +793,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 		print_test_result(test)
 	return test
 
-def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
+def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	"""
 	Using kernel output, extract KTAP lines, parse the lines for test
 	results and print condensed test results and summary line .
@@ -805,8 +802,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
 	kernel_output - Iterable object contains lines of kernel output
 
 	Return:
-	TestResult - Tuple containg status of main test object, main test
-		object with all subtests, and log of all KTAP lines.
+	Test - the main test object with all subtests.
 	"""
 	print_with_timestamp(DIVIDER)
 	lines = extract_tap_lines(kernel_output)
@@ -820,4 +816,4 @@ def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
 			test.status = test.counts.get_status()
 	print_with_timestamp(DIVIDER)
 	print_summary_line(test)
-	return TestResult(test.status, test, lines)
+	return test
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 2540bb10b4e8..6aa625a55a1b 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -179,7 +179,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
 			result.status)
@@ -191,7 +191,7 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(
 				file.readlines()))
-		self.assertEqual(2, result.test.counts.errors)
+		self.assertEqual(2, result.counts.errors)
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
@@ -203,7 +203,7 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(
 				file.readlines()))
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
@@ -217,7 +217,7 @@ class KUnitParserTest(unittest.TestCase):
 				file.readlines()))
 		print_mock.assert_any_call(StrContains('invalid KTAP input!'))
 		print_mock.stop()
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 
 	def test_crashed_test(self):
 		crashed_log = test_data_path('test_is_test_passed-crash.log')
@@ -258,10 +258,10 @@ class KUnitParserTest(unittest.TestCase):
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
 
 
@@ -272,7 +272,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
@@ -281,7 +281,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
@@ -290,7 +290,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
@@ -299,7 +299,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
@@ -308,7 +308,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.TEST_CRASHED,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
@@ -317,7 +317,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 class LinuxSourceTreeTest(unittest.TestCase):
 
@@ -368,7 +368,7 @@ class KUnitJsonTest(unittest.TestCase):
 		with open(test_data_path(log_file)) as file:
 			test_result = kunit_parser.parse_run_tests(file)
 			json_obj = kunit_json.get_json_result(
-				test_result=test_result,
+				test=test_result,
 				def_config='kunit_defconfig',
 				build_dir=None,
 				json_path='stdout')
-- 
2.33.0.882.g93a45727a2-goog

