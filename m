Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0C1A43BF15
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 03:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237600AbhJ0Bji (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Oct 2021 21:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237588AbhJ0Bjh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Oct 2021 21:39:37 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C4BC061745
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:37:13 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id i128-20020a252286000000b005beea522aa8so1449059ybi.17
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Oct 2021 18:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KbePLBSXjJc+ItO7+3Jnjlde8rtlRhHvWKH0kKd5B80=;
        b=CL35BVEpYmt7VeoOZOl3RV+eDnImtLHSZOMLTZp55viCQSTRJNmRrF8NG8os4UrC3U
         KRPCb4C31XIg7gqpkIZvAb/MpRDtkzcAURmeOPm5OvdRazmBGez2bjuL47tSXpt6je3T
         fBHrStjoUKnyny8Ii1LE8VvfVfsQ2E04hPavmu04JaZHy9DMp23l1VAcLAfOhVeZwwQy
         F44ryA5xwg/M3M2UDIAmU+LaKuEQDby2QSPAsdkp9kDkdAGhrA4Lm6E1wdvrBt9uDbDD
         8Prno9NKc3Qn3ToEe29ZI1p4eDVkTiobB2ucDC8Ep7m4JmR4jHj63JQ8tH2QHQCLDb8E
         v+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KbePLBSXjJc+ItO7+3Jnjlde8rtlRhHvWKH0kKd5B80=;
        b=fszFY2heuHviGWAzctKMGLvn93ig2uJqoIWUfUhPyakiD//UNhi02AxXHE3y8j6OBn
         dxg5nVV7Y/WcnBaupsPPlqK2sUkN6+v0rtioJ6tz/+XkvgQYUd001fm9Wet/a1oB/63q
         +siYnLF8BIVZWcOnkiHODLM7mrU2yDuoLcQCntnUt0FFsVN0h+uA6Gad6/s7G8M2ZDDF
         AP/whq/yKlHBUgGXVQbEvAS0OwBXolZM/5KtwCFgS9YB0GMae9+8M8cZielYBV8x/Wse
         4VzsjwXV9BbcCAupJ8C7Frktci0l+sszUcTp/6aZhnjVSSrBIrB15yRyrZbaJpF5Wv0t
         YuOg==
X-Gm-Message-State: AOAM531ye8Bq7Ap5YKRVtzJoCEpv5OhyRGTKvk246yAReezM+zBvImxn
        9CQVKOPnlfi+TqVPVmLfFxCHe5q5hGga8w==
X-Google-Smtp-Source: ABdhPJwFvLepJVEy6r7oUTHD+UvCDDphjgm3QnJT5artkyBGE5h2xv2USvnTsN5zO4Wdsh2SXiKYRa3E0+tzyw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:c628:e925:d58d:6232])
 (user=davidgow job=sendgmr) by 2002:a25:afcd:: with SMTP id
 d13mr29514222ybj.504.1635298632637; Tue, 26 Oct 2021 18:37:12 -0700 (PDT)
Date:   Tue, 26 Oct 2021 18:37:00 -0700
In-Reply-To: <20211027013702.2039566-1-davidgow@google.com>
Message-Id: <20211027013702.2039566-2-davidgow@google.com>
Mime-Version: 1.0
References: <20211027013702.2039566-1-davidgow@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v2 2/4] kunit: tool: Report an error if any test has no subtests
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
---
 tools/testing/kunit/kunit_parser.py                | 14 +++++++++-----
 tools/testing/kunit/kunit_tool_test.py             |  9 +++++++++
 .../test_is_test_passed-no_tests_no_plan.log       |  7 +++++++
 3 files changed, 25 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 50ded55c168c..3a838423c381 100644
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
@@ -731,6 +728,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 		# test plan
 		test.name = "main"
 		parse_test_plan(lines, test)
+		parent_test = True
 	else:
 		# If KTAP/TAP header is not found, test must be subtest
 		# header or test result line so parse attempt to parser
@@ -744,7 +742,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
-	while expected_count is None or test_num <= expected_count:
+	while parent_test and (expected_count is None or test_num <= expected_count):
 		# Loop to parse any subtests.
 		# Break after parsing expected number of tests or
 		# if expected number of tests is unknown break when test
@@ -779,9 +777,15 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
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
index bc8793145713..c59fe0777387 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -208,6 +208,15 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
+		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
+		with open(no_plan_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.extract_tap_lines(file.readlines()))
+		self.assertEqual(0, len(result.test.subtests[0].subtests[0].subtests))
+		self.assertEqual(
+			kunit_parser.TestStatus.NO_TESTS,
+			result.test.subtests[0].subtests[0].status)
+
 
 	def test_no_kunit_output(self):
 		crash_log = test_data_path('test_insufficient_memory.log')
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
2.33.0.1079.g6e70778dc9-goog

