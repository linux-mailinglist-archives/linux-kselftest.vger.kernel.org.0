Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B300E3B8AFE
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jul 2021 01:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhF3XnH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 30 Jun 2021 19:43:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236738AbhF3XnG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 30 Jun 2021 19:43:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D074BC0617A8
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 16:40:17 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z9-20020a0569020549b029054f17cb50f3so6040085ybs.14
        for <linux-kselftest@vger.kernel.org>; Wed, 30 Jun 2021 16:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=226YhLrtPsM+oDAFsh4aHlKR6GWSTsDUiT3rX/tB3l8=;
        b=eD0JLp/wThW0X3IZnITyXnsxqyXeQoImKsaL7NfcSau/u6KOKKFJj6lOADaNd717HK
         0FwFYII0Xd713WO9wlcu3fEAjNe12PVhuuHTjjZQh3V9m4+XgUMLKo32Ix0srIWYJUGT
         ZPQbZy9TVnL+7nugc0dbBsXCzsA5dmarzVT+94wK/YmVvmOIMhR7D8akx0ucExOD/KmS
         HZpFj4YItrSDGmcL1OkMpxgAvDT0TFDEy8/jrD59xneMIa7oFTcUHzMkgAVgucjlLV0j
         I6XuXbvXDFh8BjAoIfsAGYWwuDgSkzkGmLEU8gIDYdaQpeFFI6zQuq8vDnSS74CjhPRg
         VrOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=226YhLrtPsM+oDAFsh4aHlKR6GWSTsDUiT3rX/tB3l8=;
        b=SxKfGbVe95hX1tBxgLwMfK2G5Mc5QMUTGl8R/T5J2CGp5h0sbXHLzVG4RhbRQFOIU5
         fMgqPRY2eqw5npmRm3HMglVEQSzsDJdlWM1TdlXDLT6+KsB5Sc3RGxCjN3X/eNGQPJy+
         EGkv7DS/SbeXPZeRCsFW67o1n7S7n51i5rsMrnezyEu0E/rSBjPAc3QSeMZ0JbI6LGjd
         vpiAdLBqDwF6uXHjWqOblInPcyh81b7uKpoiK97Tj+XqBRTVm6uweuF8FmXfy+2vKyNo
         5Qs9CRMkNmBA/01WHsZSA/Jr1Dz0dRE7HpX9WeSt4Lh3or4OwlHnRGoaH55PIITLpjz6
         U/6w==
X-Gm-Message-State: AOAM533DzuhMGleH7Zb+3XVCDtcKxgn5avQ1J8gmUXqbOABsaFmMGR8j
        cO4q3fzUeZZtwY6nA+dZIc6777F3NQ==
X-Google-Smtp-Source: ABdhPJwdDWxjG+0IqPKGg/Uu1HouRogwWvBOpBzlCgr/uXRIFA1xZudcRWzY8hyAbjUb6tfwDcsqs50Ptw==
X-Received: from sunrae.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2814])
 (user=rmoar job=sendgmr) by 2002:a25:f20f:: with SMTP id i15mr47248583ybe.119.1625096416848;
 Wed, 30 Jun 2021 16:40:16 -0700 (PDT)
Date:   Wed, 30 Jun 2021 23:39:50 +0000
Message-Id: <20210630233950.1638536-1-rmoar@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] kunit: tool: Fix error messages for cases of no tests and
 wrong TAP header
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        dlatypov@google.com, shuah@kernel.org
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch addresses misleading error messages reported by kunit_tool in
two cases. First, in the case of TAP output having an incorrect header
format or missing a header, the parser used to output an error message of
'no tests run!'. Now the parser outputs an error message of 'could not
parse test results!'.

As an example:

Before:
$ ./tools/testing/kunit/kunit.py parse /dev/null
[ERROR] no tests run!
...

After:
$ ./tools/testing/kunit/kunit.py parse /dev/null
[ERROR] could not parse test results!
...

Second, in the case of TAP output with the correct header but no
tests, the parser used to output an error message of 'could not parse
test results!'. Now the parser outputs an error message of 'no tests
run!'.

As an example:

Before:
$ echo -e 'TAP version 14\n1..0' | ./tools/testing/kunit/kunit.py parse
[ERROR] could not parse test results!

After:
$ echo -e 'TAP version 14\n1..0' | ./tools/testing/kunit/kunit.py parse
[ERROR] no tests run!

Additionally, this patch also corrects the tests in kunit_tool_test.py
and adds a test to check the error in the case of TAP output with the
correct header but no tests (the log for this test was simplified from
the first version of this patch).

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit_parser.py              |  6 ++++--
 tools/testing/kunit/kunit_tool_test.py           | 16 +++++++++++++---
 ...st_is_test_passed-no_tests_run_no_header.log} |  0
 ...t_is_test_passed-no_tests_run_with_header.log |  2 ++
 4 files changed, 19 insertions(+), 5 deletions(-)
 rename tools/testing/kunit/test_data/{test_is_test_passed-no_tests_run.log => test_is_test_passed-no_tests_run_no_header.log} (100%)
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_run_with_header.log

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
-- 
2.32.0.93.g670b81a890-goog

