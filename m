Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B26C3CBF8E
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Jul 2021 01:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbhGPXGF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Jul 2021 19:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230227AbhGPXGF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Jul 2021 19:06:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F42DC06175F
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jul 2021 16:03:09 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r18so1356811iot.4
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Jul 2021 16:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=9jrSo/8w4ZCyJI243w1I54Is0297tr4Ud/P9+xiX6eE=;
        b=SsH/xAX97+mE4HIlPmRWMrsSaKYL7CnI25zlXncZ/Joe8TDagLltXlI/nbzs0EdBK+
         /69OsEZ1gUKkf1Pe32AKN2h/7gp9LZ7YaYIVno84Hc7uiPgsPjvidrMKyi6LcfJ4lB4h
         6g1XEouAuZ0Tb5xhxjXyflZKISIow2oNJUHPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=9jrSo/8w4ZCyJI243w1I54Is0297tr4Ud/P9+xiX6eE=;
        b=pUVYRRzXxt8YM6O7thCiCcJc+Mi/LIhloxxhc3N6et/9pu3VY/bYRuYDZWmHG9UTD1
         gvFM68Kew64PYvSfBAMP5+8mh6M4xNfHXokPnPEKWa77a/ro9iunUfT38FVeyAK1dAJN
         NN+yMQcE2nMEWOs3W6+Y+3UQcs5xzuYqg2knFgwPhpNlYfieXSzEWRc5kcQ4LL44dz00
         bvH1WnapZhdWVx7qCnRkhNylZbzDUw/kYgd+3chEOceJuTOkLUu+Fe6o0cWWihsOCLQ9
         84Ly0uKOjdFfH2rACKVLyYubtgAObYjO0sapsX77csoLPBY6FzB9XRFXbL8cYmLmmLLM
         Q3Cg==
X-Gm-Message-State: AOAM532FZjcSG7i8SKKJaaKN1mA2A3h+nViP/wehIHKGQ3Ti3peVQ26k
        0tn1FlgfBhsxkoYoTajTl2CRcYhkBwE2yg==
X-Google-Smtp-Source: ABdhPJz/uXbJmFOka0AfPkhR3l74/AAI6WqOujq8+f6egYKl60jtIhEYlQSd1pnv1uM+qSvDFVtgxw==
X-Received: by 2002:a6b:db18:: with SMTP id t24mr9340306ioc.163.1626476588913;
        Fri, 16 Jul 2021 16:03:08 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id j13sm1209421ila.38.2021.07.16.16.03.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jul 2021 16:03:08 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.14-rc2
Message-ID: <9d9ebe39-8860-4d1a-2489-e6a1a1f0cbbb@linuxfoundation.org>
Date:   Fri, 16 Jul 2021 17:03:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------1A7C8D7B520404FE15E7C549"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------1A7C8D7B520404FE15E7C549
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit fixes update for Linux 5,14-rc2

This KUnit fixes update for Linux 5.14-rc2 consists of fixes to kunit
tool and documentation:

-- asserts on older python versions.
-- fixes to misleading error messages when TAP header format is
    incorrect or when file is missing.
-- fixes documentation dropping obsolete information about uml_abort
    coverage.
-- removing unnecessary annotations

diff is attached.

Thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-fixes-5.14-rc2

for you to fetch changes up to df4b0807ca1a62822342d404b863eff933d15762:

   kunit: tool: Assert the version requirement (2021-07-12 14:02:32 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.14-rc2

This KUnit fixes update for Linux 5.14-rc2 consists of fixes to kunit
tool and documentation:

-- asserts on older python versions.
-- fixes to misleading error messages when TAP header format is
    incorrect or when file is missing.
-- fixes documentation dropping obsolete information about uml_abort
    coverage.
-- removing unnecessary annotations

----------------------------------------------------------------
Daniel Latypov (2):
       Documentation: kunit: drop obsolete note about uml_abort for coverage
       kunit: tool: remove unnecessary "annotations" import

Rae Moar (1):
       kunit: tool: Fix error messages for cases of no tests and wrong TAP header

SeongJae Park (1):
       kunit: tool: Assert the version requirement

  Documentation/dev-tools/kunit/running_tips.rst           | 14 +-------------
  tools/testing/kunit/kunit.py                             |  2 ++
  tools/testing/kunit/kunit_kernel.py                      |  6 ++----
  tools/testing/kunit/kunit_parser.py                      |  6 ++++--
  tools/testing/kunit/kunit_tool_test.py                   | 16 +++++++++++++---
  ...og => test_is_test_passed-no_tests_run_no_header.log} |  0
  .../test_is_test_passed-no_tests_run_with_header.log     |  2 ++
  7 files changed, 24 insertions(+), 22 deletions(-)
  rename tools/testing/kunit/test_data/{test_is_test_passed-no_tests_run.log => test_is_test_passed-no_tests_run_no_header.log} (100%)
  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
----------------------------------------------------------------

--------------1A7C8D7B520404FE15E7C549
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.14-rc2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.14-rc2.diff"

diff --git a/Documentation/dev-tools/kunit/running_tips.rst b/Documentation/dev-tools/kunit/running_tips.rst
index 7d99386cf94a..d1626d548fa5 100644
--- a/Documentation/dev-tools/kunit/running_tips.rst
+++ b/Documentation/dev-tools/kunit/running_tips.rst
@@ -86,19 +86,7 @@ Generating code coverage reports under UML
 .. note::
 	TODO(brendanhiggins@google.com): There are various issues with UML and
 	versions of gcc 7 and up. You're likely to run into missing ``.gcda``
-	files or compile errors. We know one `faulty GCC commit
-	<https://github.com/gcc-mirror/gcc/commit/8c9434c2f9358b8b8bad2c1990edf10a21645f9d>`_
-	but not how we'd go about getting this fixed. The compile errors still
-	need some investigation.
-
-.. note::
-	TODO(brendanhiggins@google.com): for recent versions of Linux
-	(5.10-5.12, maybe earlier), there's a bug with gcov counters not being
-	flushed in UML. This translates to very low (<1%) reported coverage. This is
-	related to the above issue and can be worked around by replacing the
-	one call to ``uml_abort()`` (it's in ``os_dump_core()``) with a plain
-	``exit()``.
-
+	files or compile errors.
 
 This is different from the "normal" way of getting coverage information that is
 documented in Documentation/dev-tools/gcov.rst.
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index be8d8d4a4e08..6276ce0c0196 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -12,6 +12,8 @@ import sys
 import os
 import time
 
+assert sys.version_info >= (3, 7), "Python version is too old"
+
 from collections import namedtuple
 from enum import Enum, auto
 
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 90bc007f1f93..2c6f916ccbaf 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -6,15 +6,13 @@
 # Author: Felix Guo <felixguoxiuping@gmail.com>
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
-from __future__ import annotations
 import importlib.util
 import logging
 import subprocess
 import os
 import shutil
 import signal
-from typing import Iterator
-from typing import Optional
+from typing import Iterator, Optional, Tuple
 
 from contextlib import ExitStack
 
@@ -208,7 +206,7 @@ def get_source_tree_ops(arch: str, cross_compile: Optional[str]) -> LinuxSourceT
 		raise ConfigError(arch + ' is not a valid arch')
 
 def get_source_tree_ops_from_qemu_config(config_path: str,
-					 cross_compile: Optional[str]) -> tuple[
+					 cross_compile: Optional[str]) -> Tuple[
 							 str, LinuxSourceTreeOperations]:
 	# The module name/path has very little to do with where the actual file
 	# exists (I learned this through experimentation and could not find it
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index c3c524b79db8..b88db3f51dc5 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -338,9 +338,11 @@ def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
 def parse_test_result(lines: LineStream) -> TestResult:
 	consume_non_diagnostic(lines)
 	if not lines or not parse_tap_header(lines):
-		return TestResult(TestStatus.NO_TESTS, [], lines)
+		return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
 	expected_test_suite_num = parse_test_plan(lines)
-	if not expected_test_suite_num:
+	if expected_test_suite_num == 0:
+		return TestResult(TestStatus.NO_TESTS, [], lines)
+	elif expected_test_suite_num is None:
 		return TestResult(TestStatus.FAILURE_TO_PARSE_TESTS, [], lines)
 	test_suites = []
 	for i in range(1, expected_test_suite_num + 1):
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bdae0e5f6197..75045aa0f8a1 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -157,8 +157,18 @@ class KUnitParserTest(unittest.TestCase):
 			kunit_parser.TestStatus.FAILURE,
 			result.status)
 
+	def test_no_header(self):
+		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
+		with open(empty_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.extract_tap_lines(file.readlines()))
+		self.assertEqual(0, len(result.suites))
+		self.assertEqual(
+			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
+			result.status)
+
 	def test_no_tests(self):
-		empty_log = test_data_path('test_is_test_passed-no_tests_run.log')
+		empty_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
@@ -173,7 +183,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		print_mock.assert_any_call(StrContains('no tests run!'))
+		print_mock.assert_any_call(StrContains('could not parse test results!'))
 		print_mock.stop()
 		file.close()
 
@@ -309,7 +319,7 @@ class KUnitJsonTest(unittest.TestCase):
 			result["sub_groups"][1]["test_cases"][0])
 
 	def test_no_tests_json(self):
-		result = self._json_for('test_is_test_passed-no_tests_run.log')
+		result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
 		self.assertEqual(0, len(result['sub_groups']))
 
 class StrContains(str):
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_no_header.log
similarity index 100%
rename from tools/testing/kunit/test_data/test_is_test_passed-no_tests_run.log
rename to tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_no_header.log
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
new file mode 100644
index 000000000000..5f48ee659d40
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log
@@ -0,0 +1,2 @@
+TAP version 14
+1..0

--------------1A7C8D7B520404FE15E7C549--
