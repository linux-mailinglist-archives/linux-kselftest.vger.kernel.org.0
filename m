Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B762529110
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 22:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346536AbiEPTyS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 15:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348111AbiEPTwk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 15:52:40 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5786042A2C
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 12:48:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id p5-20020a254205000000b0064da2110759so3342072yba.12
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 12:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qkMagrCYhDvtLyDsd8F7XnfxM1NIcJ2pwnO5NphdbhI=;
        b=R+Cbi8vh1FWzpmHGszIrK/mPMMrYBicM5/wdLVGEgT8cx7e/pIHsZlFAQWoqtJZSuO
         JjrutD0nbrUpHZHkPdpDaIZJJMsYIbNYBP02wjMcOlG8BMEthpYfd4K9ISuqc2y+iGES
         JlNDilfQ1rTzR6jfA4a863KcPE1nfD2JRsJBA7XyHQ/U2Y1lErtBetbzxpgFBOYMPcXI
         GGvpGB0r/WoH0TILI82Ebv0nbNOBY7yDUbNt7BPNdIP8rJRIF2QL0PGcPTBp+riJaY5y
         QOGH7uN67VVHYVJLa/fzsHzrBuzkgwW4ExoXukKxf/iu15jDMQ7DznpwKkXcgqudH0RL
         z4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qkMagrCYhDvtLyDsd8F7XnfxM1NIcJ2pwnO5NphdbhI=;
        b=gF/mv+tib9vJvuWoFicpXVllBRnlIdlJ+ki0XB+4Whi9qcKGfaxnmgm0KfBWXYLzhR
         ZY32HsDpCu7zuPGP79U0rMGV2ilw77S1beq+WZ3HDxXDuykdu+d5IrGSXLbWQMqtEGK2
         kJFd5dB+vy1tNzcM4o3mcyLnf4Prh7bc3jn55s49Ta5OZ5FWuWZ7tK0+YQL1HW3jNDSp
         hvGaczmoJozMbe+BGDrXsh2bgPzPdSsAhDj8hTtrQ5RmZPnCner5A7HSBvqW5GkkAawh
         3RfZxLlrFMtTSYpIcC7ZiDV3b4kghHYdFpitEu9488VPUS1ifiQAaLsJm59+zTDsGDW4
         Me8w==
X-Gm-Message-State: AOAM530YmzmaTie40vYejjhaiFPsKEsfTSGvvZjhO9Cx9pSBvja0fjZx
        6I7ugtkXNxgWiAcRAUvXDPXFfrHuqgUfqQ==
X-Google-Smtp-Source: ABdhPJwD4u/VC+mqJgfcWG/vdo2xoLNI/LLl+TrOD7WjQVLBiLlM01tHuqxPjAppx3iYfdBNr7sAILIDp0vLNA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8f91:3848:5672:cb59])
 (user=dlatypov job=sendgmr) by 2002:a25:9347:0:b0:64d:b414:3c29 with SMTP id
 g7-20020a259347000000b0064db4143c29mr6341048ybo.256.1652730494148; Mon, 16
 May 2022 12:48:14 -0700 (PDT)
Date:   Mon, 16 May 2022 12:47:30 -0700
In-Reply-To: <20220516194730.1546328-1-dlatypov@google.com>
Message-Id: <20220516194730.1546328-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 3/3] kunit: tool: refactoring printing logic into kunit_printer.py
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

Context:
* kunit_kernel.py is importing kunit_parser.py just to use the
  print_with_timestamp() function
* the parser is directly printing to stdout, which will become an issue
  if we ever try to run multiple kernels in parallel

This patch introduces a kunit_printer.py file and migrates callers of
kunit_parser.print_with_timestamp() to call
kunit_printer.stdout.print_with_timestamp() instead.

Future changes:
If we want to support showing results for parallel runs, we could then
create new Printer's that don't directly write to stdout and refactor
the code to pass around these Printer objects.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           | 17 +++----
 tools/testing/kunit/kunit_kernel.py    |  8 ++--
 tools/testing/kunit/kunit_parser.py    | 63 ++++++++------------------
 tools/testing/kunit/kunit_printer.py   | 48 ++++++++++++++++++++
 tools/testing/kunit/kunit_tool_test.py |  4 +-
 5 files changed, 82 insertions(+), 58 deletions(-)
 create mode 100644 tools/testing/kunit/kunit_printer.py

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 8a90d80ee66e..114e548e4f04 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -22,6 +22,7 @@ from typing import Iterable, List, Optional, Sequence, Tuple
 import kunit_json
 import kunit_kernel
 import kunit_parser
+from kunit_printer import stdout
 
 class KunitStatus(Enum):
 	SUCCESS = auto()
@@ -72,7 +73,7 @@ def get_kernel_root_path() -> str:
 
 def config_tests(linux: kunit_kernel.LinuxSourceTree,
 		 request: KunitConfigRequest) -> KunitResult:
-	kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
+	stdout.print_with_timestamp('Configuring KUnit Kernel ...')
 
 	config_start = time.time()
 	success = linux.build_reconfig(request.build_dir, request.make_options)
@@ -85,7 +86,7 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 
 def build_tests(linux: kunit_kernel.LinuxSourceTree,
 		request: KunitBuildRequest) -> KunitResult:
-	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
+	stdout.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
 	success = linux.build_kernel(request.alltests,
@@ -158,7 +159,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 	test_counts = kunit_parser.TestCounts()
 	exec_time = 0.0
 	for i, filter_glob in enumerate(filter_globs):
-		kunit_parser.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
+		stdout.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
 
 		test_start = time.time()
 		run_result = linux.run_kernel(
@@ -221,7 +222,7 @@ def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input
 		else:
 			with open(request.json, 'w') as f:
 				f.write(json_str)
-			kunit_parser.print_with_timestamp("Test results stored in %s" %
+			stdout.print_with_timestamp("Test results stored in %s" %
 				os.path.abspath(request.json))
 
 	if test_result.status != kunit_parser.TestStatus.SUCCESS:
@@ -245,7 +246,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 
 	run_end = time.time()
 
-	kunit_parser.print_with_timestamp((
+	stdout.print_with_timestamp((
 		'Elapsed time: %.3fs total, %.3fs configuring, %.3fs ' +
 		'building, %.3fs running\n') % (
 				run_end - run_start,
@@ -446,7 +447,7 @@ def main(argv):
 		request = KunitConfigRequest(build_dir=cli_args.build_dir,
 					     make_options=cli_args.make_options)
 		result = config_tests(linux, request)
-		kunit_parser.print_with_timestamp((
+		stdout.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
 				result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
@@ -458,7 +459,7 @@ def main(argv):
 					    jobs=cli_args.jobs,
 					    alltests=cli_args.alltests)
 		result = config_and_build_tests(linux, request)
-		kunit_parser.print_with_timestamp((
+		stdout.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
 				result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
@@ -474,7 +475,7 @@ def main(argv):
 						kernel_args=cli_args.kernel_args,
 						run_isolated=cli_args.run_isolated)
 		result = exec_tests(linux, exec_request)
-		kunit_parser.print_with_timestamp((
+		stdout.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 8bc8305ba817..b51ce102d82e 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -18,7 +18,7 @@ import threading
 from typing import Iterator, List, Optional, Tuple
 
 import kunit_config
-import kunit_parser
+from kunit_printer import stdout
 import qemu_config
 
 KCONFIG_PATH = '.config'
@@ -138,7 +138,7 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 		super().__init__(linux_arch='um', cross_compile=cross_compile)
 
 	def make_allyesconfig(self, build_dir: str, make_options) -> None:
-		kunit_parser.print_with_timestamp(
+		stdout.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
 		command = ['make', 'ARCH=um', 'O=' + build_dir, 'allyesconfig']
 		if make_options:
@@ -148,13 +148,13 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 			stdout=subprocess.DEVNULL,
 			stderr=subprocess.STDOUT)
 		process.wait()
-		kunit_parser.print_with_timestamp(
+		stdout.print_with_timestamp(
 			'Disabling broken configs to run KUnit tests...')
 
 		with open(get_kconfig_path(build_dir), 'a') as config:
 			with open(BROKEN_ALLCONFIG_PATH, 'r') as disable:
 				config.write(disable.read())
-		kunit_parser.print_with_timestamp(
+		stdout.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index c5569b367c69..12d3ec77f427 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -13,10 +13,11 @@ from __future__ import annotations
 import re
 import sys
 
-import datetime
 from enum import Enum, auto
 from typing import Iterable, Iterator, List, Optional, Tuple
 
+from kunit_printer import stdout
+
 class Test:
 	"""
 	A class to represent a test parsed from KTAP results. All KTAP
@@ -55,7 +56,7 @@ class Test:
 	def add_error(self, error_message: str) -> None:
 		"""Records an error that occurred while parsing this test."""
 		self.counts.errors += 1
-		print_with_timestamp(red('[ERROR]') + f' Test: {self.name}: {error_message}')
+		stdout.print_with_timestamp(stdout.red('[ERROR]') + f' Test: {self.name}: {error_message}')
 
 class TestStatus(Enum):
 	"""An enumeration class to represent the status of a test."""
@@ -461,32 +462,6 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 
 DIVIDER = '=' * 60
 
-RESET = '\033[0;0m'
-
-def red(text: str) -> str:
-	"""Returns inputted string with red color code."""
-	if not sys.stdout.isatty():
-		return text
-	return '\033[1;31m' + text + RESET
-
-def yellow(text: str) -> str:
-	"""Returns inputted string with yellow color code."""
-	if not sys.stdout.isatty():
-		return text
-	return '\033[1;33m' + text + RESET
-
-def green(text: str) -> str:
-	"""Returns inputted string with green color code."""
-	if not sys.stdout.isatty():
-		return text
-	return '\033[1;32m' + text + RESET
-
-ANSI_LEN = len(red(''))
-
-def print_with_timestamp(message: str) -> None:
-	"""Prints message with timestamp at beginning."""
-	print('[%s] %s' % (datetime.datetime.now().strftime('%H:%M:%S'), message))
-
 def format_test_divider(message: str, len_message: int) -> str:
 	"""
 	Returns string with message centered in fixed width divider.
@@ -529,12 +504,12 @@ def print_test_header(test: Test) -> None:
 			message += ' (1 subtest)'
 		else:
 			message += f' ({test.expected_count} subtests)'
-	print_with_timestamp(format_test_divider(message, len(message)))
+	stdout.print_with_timestamp(format_test_divider(message, len(message)))
 
 def print_log(log: Iterable[str]) -> None:
 	"""Prints all strings in saved log for test in yellow."""
 	for m in log:
-		print_with_timestamp(yellow(m))
+		stdout.print_with_timestamp(stdout.yellow(m))
 
 def format_test_result(test: Test) -> str:
 	"""
@@ -551,16 +526,16 @@ def format_test_result(test: Test) -> str:
 	String containing formatted test result
 	"""
 	if test.status == TestStatus.SUCCESS:
-		return green('[PASSED] ') + test.name
+		return stdout.green('[PASSED] ') + test.name
 	if test.status == TestStatus.SKIPPED:
-		return yellow('[SKIPPED] ') + test.name
+		return stdout.yellow('[SKIPPED] ') + test.name
 	if test.status == TestStatus.NO_TESTS:
-		return yellow('[NO TESTS RUN] ') + test.name
+		return stdout.yellow('[NO TESTS RUN] ') + test.name
 	if test.status == TestStatus.TEST_CRASHED:
 		print_log(test.log)
-		return red('[CRASHED] ') + test.name
+		return stdout.red('[CRASHED] ') + test.name
 	print_log(test.log)
-	return red('[FAILED] ') + test.name
+	return stdout.red('[FAILED] ') + test.name
 
 def print_test_result(test: Test) -> None:
 	"""
@@ -572,7 +547,7 @@ def print_test_result(test: Test) -> None:
 	Parameters:
 	test - Test object representing current test being printed
 	"""
-	print_with_timestamp(format_test_result(test))
+	stdout.print_with_timestamp(format_test_result(test))
 
 def print_test_footer(test: Test) -> None:
 	"""
@@ -585,8 +560,8 @@ def print_test_footer(test: Test) -> None:
 	test - Test object representing current test being printed
 	"""
 	message = format_test_result(test)
-	print_with_timestamp(format_test_divider(message,
-		len(message) - ANSI_LEN))
+	stdout.print_with_timestamp(format_test_divider(message,
+		len(message) - stdout.color_len()))
 
 def print_summary_line(test: Test) -> None:
 	"""
@@ -603,12 +578,12 @@ def print_summary_line(test: Test) -> None:
 	test - Test object representing current test being printed
 	"""
 	if test.status == TestStatus.SUCCESS:
-		color = green
+		color = stdout.green
 	elif test.status in (TestStatus.SKIPPED, TestStatus.NO_TESTS):
-		color = yellow
+		color = stdout.yellow
 	else:
-		color = red
-	print_with_timestamp(color(f'Testing complete. {test.counts}'))
+		color = stdout.red
+	stdout.print_with_timestamp(color(f'Testing complete. {test.counts}'))
 
 # Other methods:
 
@@ -762,7 +737,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	Return:
 	Test - the main test object with all subtests.
 	"""
-	print_with_timestamp(DIVIDER)
+	stdout.print_with_timestamp(DIVIDER)
 	lines = extract_tap_lines(kernel_output)
 	test = Test()
 	if not lines:
@@ -773,6 +748,6 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 		test = parse_test(lines, 0, [])
 		if test.status != TestStatus.NO_TESTS:
 			test.status = test.counts.get_status()
-	print_with_timestamp(DIVIDER)
+	stdout.print_with_timestamp(DIVIDER)
 	print_summary_line(test)
 	return test
diff --git a/tools/testing/kunit/kunit_printer.py b/tools/testing/kunit/kunit_printer.py
new file mode 100644
index 000000000000..5f1cc55ecdf5
--- /dev/null
+++ b/tools/testing/kunit/kunit_printer.py
@@ -0,0 +1,48 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# Utilities for printing and coloring output.
+#
+# Copyright (C) 2022, Google LLC.
+# Author: Daniel Latypov <dlatypov@google.com>
+
+import datetime
+import sys
+import typing
+
+_RESET = '\033[0;0m'
+
+class Printer:
+	"""Wraps a file object, providing utilities for coloring output, etc."""
+
+	def __init__(self, output: typing.IO):
+		self._output = output
+		self._use_color = output.isatty()
+
+	def print(self, message: str) -> None:
+		print(message, file=self._output)
+
+	def print_with_timestamp(self, message: str) -> None:
+		ts = datetime.datetime.now().strftime('%H:%M:%S')
+		self.print(f'[{ts}] {message}')
+
+	def _color(self, code: str, text: str) -> str:
+		if not self._use_color:
+			return text
+		return code + text + _RESET
+
+	def red(self, text: str) -> str:
+		return self._color('\033[1;31m', text)
+
+	def yellow(self, text: str) -> str:
+		return self._color('\033[1;33m', text)
+
+	def green(self, text: str) -> str:
+		return self._color('\033[1;32m', text)
+
+	def color_len(self) -> int:
+		"""Returns the length of the color escape codes."""
+		return len(self.red(''))
+
+# Provides a default instance that prints to stdout
+stdout = Printer(sys.stdout)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index baee11d96474..2973402c5053 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -222,7 +222,7 @@ class KUnitParserTest(unittest.TestCase):
 
 	def test_no_kunit_output(self):
 		crash_log = test_data_path('test_insufficient_memory.log')
-		print_mock = mock.patch('builtins.print').start()
+		print_mock = mock.patch('kunit_printer.Printer.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
@@ -500,7 +500,7 @@ class KUnitMainTest(unittest.TestCase):
 		with open(path) as file:
 			all_passed_log = file.readlines()
 
-		self.print_mock = mock.patch('builtins.print').start()
+		self.print_mock = mock.patch('kunit_printer.Printer.print').start()
 		self.addCleanup(mock.patch.stopall)
 
 		self.mock_linux_init = mock.patch.object(kunit_kernel, 'LinuxSourceTree').start()
-- 
2.36.1.124.g0e6072fb45-goog

