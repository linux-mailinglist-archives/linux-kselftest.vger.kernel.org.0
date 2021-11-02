Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84103442864
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 08:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhKBHc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 03:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbhKBHc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 03:32:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C854C061767
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 00:30:23 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z65-20020a256544000000b005c21b35717dso12789411ybb.10
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 00:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=r67IhOqyj23m1j3onGz6pLQJdGY+9rfgyvIDQST2m8U=;
        b=Lj7w1D1h/wTVKyHIvCyMUPEkedWGM63l9Yq/LVPAMhKRbLxO7S8AniIHGLxjEnwRuq
         ym3IkpF8F38ecL6DvC0JeCEhd/kzQDfPaszuBU1ntSYdfo4qJb+V3sh27rNSsLps5pZF
         Eh8iM1jDcjUfQpOQ/CtAeWQo/XMQhZvT36Y9XThhTn+1V/THyjuL++ZJISKVcFrXkWQ7
         NbdSWbhFnXbRrdNmGufI4XGeiYB9kL9y+xOJBlc+WnJs4aRTBQsFD0KUa3dguaNZKQDn
         7D4Qvdu3W8ZS0jPCw/O7fPC2ZYV9IxCQXvXLg05tg9rXb1fvh39NkARZ6okME8RRMc/9
         3DSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=r67IhOqyj23m1j3onGz6pLQJdGY+9rfgyvIDQST2m8U=;
        b=0x3AGCNUMZ9IuRrpUCwihUhEswnTyYcI3lEkqAGPqQiiR66EFD6KixTHr01SzOA3eZ
         VKdpcdo6KmctmFBEYY1cuFCdvEU6dhDGYq6weRRowitQL4+pLjFOXlBkwLyxMoCd/rrI
         XSSF+8Wec4GRa0ggntPZN8/w+iBPXXhUgO/lWPj2jW8NaBn3901aBoJ68jmkAROumcwf
         CGQg5/lY1fNJq9NH1EAD2MP33okddHtG5HECvGBlfPxQiQdhRuA1l+UyzO5cc9TYUyjo
         lS7d8c3/LH271Gp5ZFdtD9RIK7BrRWARe96qBsBcFkkT7K15oBlkjZtM/QEPuSpH2eaR
         fjiw==
X-Gm-Message-State: AOAM530qkf0wPFkEDBz8e3cJAD8xwSGILWbpxAoCU3g7Iorjd3P800Ym
        Ob9JMnnTxwCzjEv1xaM3L5NxfDEHDAFkTQ==
X-Google-Smtp-Source: ABdhPJyj8XA6od3S1FncSK4TcD9GW5PQJl6JIhwoKluHinUhs+iUV0ZapSiA8MQ6VlvGoT0Wr2L3KGSy8q0WhQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:524f:74d8:b474:2517])
 (user=davidgow job=sendgmr) by 2002:a25:9090:: with SMTP id
 t16mr20605936ybl.57.1635838222390; Tue, 02 Nov 2021 00:30:22 -0700 (PDT)
Date:   Tue,  2 Nov 2021 00:30:12 -0700
In-Reply-To: <20211102073014.2901870-1-davidgow@google.com>
Message-Id: <20211102073014.2901870-2-davidgow@google.com>
Mime-Version: 1.0
References: <20211102073014.2901870-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v4 2/4] kunit: tool: Report an error if any test has no subtests
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

It's possible for a test to have a subtest header, but zero valid
subtests. We used to error on this if the test plan had no subtests
listed, but it's possible to have subtests without a test plan (indeed,
this is how parameterised tests work).

Tests with 0 subtests now have the result NO_TESTS, and will report an
error (which does not halt test execution, but is printed in a scary red
colour and is noted in the results summary).

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20211028064154.2301049-2-davidgow@google.com/
- Split up and expanded the tests, as suggested by Daniel.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20211027013702.2039566-2-davidgow@google.com/
- Report NO_TESTS as '[NO TESTS RUN]' in yellow, instead of '[FAILED]'
  in red, particularly since it doesn't get counted as a failure.


 tools/testing/kunit/kunit_parser.py              | 16 +++++++++++-----
 tools/testing/kunit/kunit_tool_test.py           | 12 ++++++++++++
 .../test_is_test_passed-no_tests_no_plan.log     |  7 +++++++
 3 files changed, 30 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 50ded55c168c..68c847e8ca58 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -360,9 +360,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	test.log.append(lines.pop())
 	expected_count = int(match.group(1))
 	test.expected_count = expected_count
-	if expected_count == 0:
-		test.status = TestStatus.NO_TESTS
-		test.add_error('0 tests run!')
 	return True
 
 TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
@@ -589,6 +586,8 @@ def format_test_result(test: Test) -> str:
 		return (green('[PASSED] ') + test.name)
 	elif test.status == TestStatus.SKIPPED:
 		return (yellow('[SKIPPED] ') + test.name)
+	elif test.status == TestStatus.NO_TESTS:
+		return (yellow('[NO TESTS RUN] ') + test.name)
 	elif test.status == TestStatus.TEST_CRASHED:
 		print_log(test.log)
 		return (red('[CRASHED] ') + test.name)
@@ -731,6 +730,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 		# test plan
 		test.name = "main"
 		parse_test_plan(lines, test)
+		parent_test = True
 	else:
 		# If KTAP/TAP header is not found, test must be subtest
 		# header or test result line so parse attempt to parser
@@ -744,7 +744,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
-	while expected_count is None or test_num <= expected_count:
+	while parent_test and (expected_count is None or test_num <= expected_count):
 		# Loop to parse any subtests.
 		# Break after parsing expected number of tests or
 		# if expected number of tests is unknown break when test
@@ -779,9 +779,15 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 			parse_test_result(lines, test, expected_num)
 		else:
 			test.add_error('missing subtest result line!')
+
+	# Check for there being no tests
+	if parent_test and len(subtests) == 0:
+		test.status = TestStatus.NO_TESTS
+		test.add_error('0 tests run!')
+
 	# Add statuses to TestCounts attribute in Test object
 	bubble_up_test_results(test)
-	if parent_test:
+	if parent_test and not main:
 		# If test has subtests and is not the main test object, print
 		# footer.
 		print_test_footer(test)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bc8793145713..9de2072089e6 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -209,6 +209,18 @@ class KUnitParserTest(unittest.TestCase):
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
 
+	def test_no_tests_no_plan(self):
+		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
+		with open(no_plan_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.extract_tap_lines(file.readlines()))
+		self.assertEqual(0, len(result.test.subtests[0].subtests[0].subtests))
+		self.assertEqual(
+			kunit_parser.TestStatus.NO_TESTS,
+			result.test.subtests[0].subtests[0].status)
+		self.assertEqual(1, result.test.counts.errors)
+
+
 	def test_no_kunit_output(self):
 		crash_log = test_data_path('test_insufficient_memory.log')
 		print_mock = mock.patch('builtins.print').start()
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
new file mode 100644
index 000000000000..dd873c981108
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
@@ -0,0 +1,7 @@
+TAP version 14
+1..1
+  # Subtest: suite
+  1..1
+    # Subtest: case
+  ok 1 - case # SKIP
+ok 1 - suite
-- 
2.33.1.1089.g2158813163f-goog

