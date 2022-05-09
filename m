Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19DE1520630
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 May 2022 22:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiEIUxK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 May 2022 16:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiEIUxK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 May 2022 16:53:10 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F242B1DC6
        for <linux-kselftest@vger.kernel.org>; Mon,  9 May 2022 13:49:15 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 9-20020a250909000000b006484b89c979so12844913ybj.21
        for <linux-kselftest@vger.kernel.org>; Mon, 09 May 2022 13:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DdWL+K69RGBxVV+YpYaylPWI27Ouc2sd88qIVeZCW1s=;
        b=JBM/5kB8DjaKxRzr2CHrI2zPGRoGHkKuDurhzpU9F/YvXLDknLsJnTjPjqNHd/qB97
         2OWwGcOoIzXnEAuqeMWMjPKkFS2xjqXObHepcbbvi3iFPbS+UMiuGo2h2TXb7f/XUj6J
         AbTSt22X7HD+CmFry7dO+ugbxeINJoZqh5mHZB6ZrAW+OehznomFtQKfB6rcGuXBonWf
         TOjCVxH5V9UJ/G2QSOA+t4jzkPAPZTG1aJnRBqJ8odmQUYOn2GTK3B3o9aWhbgmmSrB2
         +xux9jUrRwvSxjPkGZKNlO0b3Oy33PsE7x4NwHZHnADjVAwpLZH3eGHcBFbJ3/tQ3CGQ
         N7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DdWL+K69RGBxVV+YpYaylPWI27Ouc2sd88qIVeZCW1s=;
        b=iR7ckrNYJDkRBEaZnr2HZTY0dMEVmuh9qS1GD7uVpaNNfiv6P1LRdDeEpQh9h0cBkJ
         R8JL1LomILBMGgyCQEi/FaPHg5rhWB8XtH1+JAwRIXtAKwbT4oQq2c/9Ht3qR43iJj2V
         VXe9N/eJz+tRDqlYFDxEVt2FF8MgfL39oGp5FaZSCa/OSUf/iW7K4IkvDHhZ7BGu9+wy
         jCUpuQsx2lZHF3CsH7hPAkKDPf4Cag9uFAWkDxfzURnadXBydQks0LxqiDcrEa3FzvZz
         6v5sDI2XS1EjFbCYfpujdA/tIjp5rhMY7353Jp6dFZ4HNTOJSgrkDRq7PMlMn/4/QjQ/
         1Guw==
X-Gm-Message-State: AOAM5305S6G4FrFHtzZ5HsIXLWQBpU92kCZkGYlaBtnxri9QyOaw8yic
        6awZcRHBqt2tZKcCgRPgbRjltLX0VYfOnw==
X-Google-Smtp-Source: ABdhPJxMlSanARZOwF6kIoB5dSPyikJDeEQN4VRjIyVGVfEbokx2g/pLRydD/YbToLiDepoxboDvUY8lHElwqA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:3c85:660a:cf6:3204])
 (user=dlatypov job=sendgmr) by 2002:a25:8703:0:b0:648:4b50:2044 with SMTP id
 a3-20020a258703000000b006484b502044mr14103434ybl.437.1652129354283; Mon, 09
 May 2022 13:49:14 -0700 (PDT)
Date:   Mon,  9 May 2022 13:49:09 -0700
Message-Id: <20220509204909.2464496-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH] kunit: tool: misc cleanups
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This primarily comes from running pylint over kunit tool code and
ignoring some warnings we don't care about.
If we ever got a fully clean setup, we could add this to run_checks.py,
but we're not there yet.

Fix things like
* Drop unused imports
* check `is None`, not `== None` (see PEP 8)
* remove redundant parens around returns
* remove redundant `else` / convert `elif` to `if` where appropriate
* rename make_arch_qemuconfig() param to base_kunitconfig (this is the
  name used in the subclass, and it's a better one)
* kunit_tool_test: check the exit code for SystemExit (could be 0)

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
Note: this patch only applies cleanly on top of https://lore.kernel.org/linux-kselftest/20220426173334.3871399-3-dlatypov@google.com
---
 tools/testing/kunit/kunit.py           |  9 +++----
 tools/testing/kunit/kunit_config.py    | 12 ++++-----
 tools/testing/kunit/kunit_json.py      |  5 +---
 tools/testing/kunit/kunit_kernel.py    | 10 +++----
 tools/testing/kunit/kunit_parser.py    | 37 ++++++++++++--------------
 tools/testing/kunit/kunit_tool_test.py | 10 ++++---
 tools/testing/kunit/run_checks.py      |  2 +-
 7 files changed, 39 insertions(+), 46 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 6dc710d3996b..13bd72e47da8 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -124,7 +124,7 @@ def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest)
 	lines.pop()
 
 	# Filter out any extraneous non-test output that might have gotten mixed in.
-	return [l for l in lines if re.match('^[^\s.]+\.[^\s.]+$', l)]
+	return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
 
 def _suites_from_test_list(tests: List[str]) -> List[str]:
 	"""Extracts all the suites from an ordered list of tests."""
@@ -188,8 +188,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
 		return KunitStatus.SUCCESS
-	else:
-		return KunitStatus.TEST_FAILURE
+	return KunitStatus.TEST_FAILURE
 
 def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
 	parse_start = time.time()
@@ -353,7 +352,7 @@ def add_exec_opts(parser) -> None:
 			    'a non-hermetic test, one that might pass/fail based on '
 			    'what ran before it.',
 			    type=str,
-			    choices=['suite', 'test']),
+			    choices=['suite', 'test'])
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
@@ -497,7 +496,7 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'parse':
-		if cli_args.file == None:
+		if cli_args.file is None:
 			sys.stdin.reconfigure(errors='backslashreplace')  # pytype: disable=attribute-error
 			kunit_output = sys.stdin
 		else:
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index ca33e4b7bcc5..75a8dc1683d4 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -20,16 +20,15 @@ class KconfigEntry:
 
 	def __str__(self) -> str:
 		if self.value == 'n':
-			return r'# CONFIG_%s is not set' % (self.name)
-		else:
-			return r'CONFIG_%s=%s' % (self.name, self.value)
+			return f'# CONFIG_{self.name} is not set'
+		return f'CONFIG_{self.name}={self.value}'
 
 
 class KconfigParseError(Exception):
 	"""Error parsing Kconfig defconfig or .config."""
 
 
-class Kconfig(object):
+class Kconfig:
 	"""Represents defconfig or .config specified using the Kconfig language."""
 
 	def __init__(self) -> None:
@@ -49,7 +48,7 @@ class Kconfig(object):
 				if a.value == 'n':
 					continue
 				return False
-			elif a.value != b:
+			if a.value != b:
 				return False
 		return True
 
@@ -91,6 +90,5 @@ def parse_from_string(blob: str) -> Kconfig:
 
 		if line[0] == '#':
 			continue
-		else:
-			raise KconfigParseError('Failed to parse: ' + line)
+		raise KconfigParseError('Failed to parse: ' + line)
 	return kconfig
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 1212423fe6bc..10ff65689dd8 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -8,12 +8,9 @@
 
 from dataclasses import dataclass
 import json
-import os
-
-import kunit_parser
+from typing import Any, Dict
 
 from kunit_parser import Test, TestStatus
-from typing import Any, Dict
 
 @dataclass
 class Metadata:
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 483f78e15ce9..93446a2b6414 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -37,7 +37,7 @@ class BuildError(Exception):
 	"""Represents an error trying to build the Linux kernel."""
 
 
-class LinuxSourceTreeOperations(object):
+class LinuxSourceTreeOperations:
 	"""An abstraction over command line operations performed on a source tree."""
 
 	def __init__(self, linux_arch: str, cross_compile: Optional[str]):
@@ -52,7 +52,7 @@ class LinuxSourceTreeOperations(object):
 		except subprocess.CalledProcessError as e:
 			raise ConfigError(e.output.decode())
 
-	def make_arch_qemuconfig(self, kconfig: kunit_config.Kconfig) -> None:
+	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
 		pass
 
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
@@ -180,7 +180,7 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
 	config_path = os.path.join(QEMU_CONFIGS_DIR, arch + '.py')
 	if arch == 'um':
 		return LinuxSourceTreeOperationsUml(cross_compile=cross_compile)
-	elif os.path.isfile(config_path):
+	if os.path.isfile(config_path):
 		return get_source_tree_ops_from_qemu_config(config_path, cross_compile)[1]
 
 	options = [f[:-3] for f in os.listdir(QEMU_CONFIGS_DIR) if f.endswith('.py')]
@@ -211,7 +211,7 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
 	return params.linux_arch, LinuxSourceTreeOperationsQemu(
 			params, cross_compile=cross_compile)
 
-class LinuxSourceTree(object):
+class LinuxSourceTree:
 	"""Represents a Linux kernel source tree with KUnit tests."""
 
 	def __init__(
@@ -366,6 +366,6 @@ class LinuxSourceTree(object):
 			waiter.join()
 			subprocess.call(['stty', 'sane'])
 
-	def signal_handler(self, sig, frame) -> None:
+	def signal_handler(self, unused_sig, unused_frame) -> None:
 		logging.error('Build interruption occurred. Cleaning console.')
 		subprocess.call(['stty', 'sane'])
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index d56d530fab24..5c90842d7017 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -15,10 +15,9 @@ import sys
 
 import datetime
 from enum import Enum, auto
-from functools import reduce
 from typing import Iterable, Iterator, List, Optional, Tuple
 
-class Test(object):
+class Test:
 	"""
 	A class to represent a test parsed from KTAP results. All KTAP
 	results within a test log are stored in a main Test object as
@@ -126,17 +125,16 @@ class TestCounts:
 		"""
 		if self.total() == 0:
 			return TestStatus.NO_TESTS
-		elif self.crashed:
+		if self.crashed:
 			# Crashes should take priority.
 			return TestStatus.TEST_CRASHED
-		elif self.failed:
+		if self.failed:
 			return TestStatus.FAILURE
-		elif self.passed:
+		if self.passed:
 			# No failures or crashes, looks good!
 			return TestStatus.SUCCESS
-		else:
-			# We have only skipped tests.
-			return TestStatus.SKIPPED
+		# We have only skipped tests.
+		return TestStatus.SKIPPED
 
 	def add_status(self, status: TestStatus) -> None:
 		"""Increments the count for `status`."""
@@ -381,7 +379,7 @@ def peek_test_name_match(lines: LineStream, test: Test) -> bool:
 	if not match:
 		return False
 	name = match.group(4)
-	return (name == test.name)
+	return name == test.name
 
 def parse_test_result(lines: LineStream, test: Test,
 			expected_num: int) -> bool:
@@ -553,17 +551,16 @@ def format_test_result(test: Test) -> str:
 	String containing formatted test result
 	"""
 	if test.status == TestStatus.SUCCESS:
-		return (green('[PASSED] ') + test.name)
-	elif test.status == TestStatus.SKIPPED:
-		return (yellow('[SKIPPED] ') + test.name)
-	elif test.status == TestStatus.NO_TESTS:
-		return (yellow('[NO TESTS RUN] ') + test.name)
-	elif test.status == TestStatus.TEST_CRASHED:
-		print_log(test.log)
-		return (red('[CRASHED] ') + test.name)
-	else:
+		return green('[PASSED] ') + test.name
+	if test.status == TestStatus.SKIPPED:
+		return yellow('[SKIPPED] ') + test.name
+	if test.status == TestStatus.NO_TESTS:
+		return yellow('[NO TESTS RUN] ') + test.name
+	if test.status == TestStatus.TEST_CRASHED:
 		print_log(test.log)
-		return (red('[FAILED] ') + test.name)
+		return red('[CRASHED] ') + test.name
+	print_log(test.log)
+	return red('[FAILED] ') + test.name
 
 def print_test_result(test: Test) -> None:
 	"""
@@ -607,7 +604,7 @@ def print_summary_line(test: Test) -> None:
 	"""
 	if test.status == TestStatus.SUCCESS:
 		color = green
-	elif test.status == TestStatus.SKIPPED or test.status == TestStatus.NO_TESTS:
+	elif test.status in (TestStatus.SKIPPED, TestStatus.NO_TESTS):
 		color = yellow
 	else:
 		color = red
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 1200e451c418..d2ab24f736f8 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -251,8 +251,8 @@ class KUnitParserTest(unittest.TestCase):
 
 	def test_ignores_hyphen(self):
 		hyphen_log = test_data_path('test_strip_hyphen.log')
-		file = open(hyphen_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(hyphen_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 
 		# A skipped test does not fail the whole suite.
 		self.assertEqual(
@@ -347,7 +347,7 @@ class LineStreamTest(unittest.TestCase):
 		called_times = 0
 		def generator():
 			nonlocal called_times
-			for i in range(1,5):
+			for _ in range(1,5):
 				called_times += 1
 				yield called_times, str(called_times)
 
@@ -553,7 +553,8 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_no_tests(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
 		with self.assertRaises(SystemExit) as e:
-		  kunit.main(['run'], self.linux_source_mock)
+			kunit.main(['run'], self.linux_source_mock)
+		self.assertEqual(e.exception.code, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
@@ -588,6 +589,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
 			kunit.main(['run', '--raw_output=invalid'], self.linux_source_mock)
+		self.assertNotEqual(e.exception.code, 0)
 
 	def test_run_raw_output_does_not_take_positional_args(self):
 		# --raw_output is a string flag, but we don't want it to consume
diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
index 13d854afca9d..066e6f938f6d 100755
--- a/tools/testing/kunit/run_checks.py
+++ b/tools/testing/kunit/run_checks.py
@@ -14,7 +14,7 @@ import shutil
 import subprocess
 import sys
 import textwrap
-from typing import Dict, List, Sequence, Tuple
+from typing import Dict, List, Sequence
 
 ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
 TIMEOUT = datetime.timedelta(minutes=5).total_seconds()
-- 
2.36.0.512.ge40c2bad7a-goog

