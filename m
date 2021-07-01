Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1D43B95B3
	for <lists+linux-kselftest@lfdr.de>; Thu,  1 Jul 2021 19:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbhGARzG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Jul 2021 13:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhGARzG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Jul 2021 13:55:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A7B7C061762
        for <linux-kselftest@vger.kernel.org>; Thu,  1 Jul 2021 10:52:35 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 67-20020a2514460000b029053a9edba2a6so9780914ybu.7
        for <linux-kselftest@vger.kernel.org>; Thu, 01 Jul 2021 10:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=TWNh4NT6Sbv641LYm1mUzBahkZ28Mzb42DLCx2xe0ZA=;
        b=rorNy/OC3D360vKowzuz0ZoBEw2kDS1Upmd1ElNP0uIi9b26hzxAgHOCj0FS7VKRPu
         vsw0AVfuOP4sABf7Qi3KMugltLve4mUZBIMCE1nk086fF6eNjR7cT03uc8j3GTZCw8e9
         4V+j2OebhHSLMTzoPR470rJ8PGEoByuQPQGIKN74rNDMzuAd7W2zPXqE4cSAsNAf1gDv
         o2Ag6lQcEZDhr6lJgtJ8FhYzzhCWhzk69jxo7iyYfs3MF5a3N27KHGPQhZlkLTpZ2Xdw
         LzMz43NbR9jLLeka0KB+kdGmGHDgh+GJ+eNG8q8l2fevWYuHFbIdrxTAer4nQkK/e5c6
         afoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=TWNh4NT6Sbv641LYm1mUzBahkZ28Mzb42DLCx2xe0ZA=;
        b=DDLTi1mzObWXndFCAyU7d4Ocvua4ohEWxOWgzEIiCoU0+cTENS2Ut2WkbrCRW2XTWd
         bKEJEboSRQcqQzCqzYKFz71h7j0ygCHpzkxUA17vDIS8mB7ob/Inmc7offFdzj2PaH20
         LVxveBYOeNv26gWrlnzYZmdoCdiIhWjBy/lJ3hzNgIsvhzWgS1lgCboSfmyUHetR2ks3
         zHK11sCm4LgCms44on/DpTPEzC0S2NnQgsPeBqDgT/EOD6EbN221FXJbAhfpyufuJovc
         QRXhxH/puxP0r9zfyTfsMwTPuwVj5nCjl20pMqkArYrpqusihHGs2o+fFqdR0uyaR1u3
         G0Sg==
X-Gm-Message-State: AOAM532y3NZYXhXrAdfbguIEBhVj6s82FPBnW0vRBwTLJ+/wRxOlVuB4
        8UDfD6L1LYC7PEmodgCrQ90rDQxBlw==
X-Google-Smtp-Source: ABdhPJwzUH1jDy+ConAfg2kmOkKeATvngbBVRVpd7xyX5m8KKlAAxSJE+3BlxrO0EKHLtG59HlgoRj6tDA==
X-Received: from sunrae.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2814])
 (user=rmoar job=sendgmr) by 2002:a25:814b:: with SMTP id j11mr1360198ybm.212.1625161954632;
 Thu, 01 Jul 2021 10:52:34 -0700 (PDT)
Date:   Thu,  1 Jul 2021 17:52:31 +0000
Message-Id: <20210701175231.1734589-1-rmoar@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH v2] kunit: tool: Fix error messages for cases of no tests and
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
correct header but no tests.

Signed-off-by: Rae Moar <rmoar@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---
V1 -> V2:
* Simplified log for the test for TAP output with the correct header
  but no tests
* Added examples in commit message of error messages before and after
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

