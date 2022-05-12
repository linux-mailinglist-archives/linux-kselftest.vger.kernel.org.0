Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD065254F3
	for <lists+linux-kselftest@lfdr.de>; Thu, 12 May 2022 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357708AbiELSfu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 12 May 2022 14:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357709AbiELSft (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 12 May 2022 14:35:49 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D9715FCD
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:35:48 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f7ee6bc6ddso52506437b3.1
        for <linux-kselftest@vger.kernel.org>; Thu, 12 May 2022 11:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=SidjaeLltkRbDBELlZ8bKr9H1JAqOBDWVEO14927GyI=;
        b=A2ERi4ku4zhqWOlWCPybWStRNXTkdG2DtBVymreb4ROsX6VEWjLvpqBPK/kqWbNFur
         uRZNIMsq4WzDmlA7mba5ERI+xP5xQCd80dAXqfWtMjVW9GdnyE6guCgcB7whpp1uZSLV
         Ol1JbLqgCv3ZNzGoDBVE8Y7tCy7JGQE+XgKZDCLZJVW55EhF3L48iaK4UfVZTgeqGy8O
         pR7vbLKm4kR6FBr9GwFlljJr2x5Q6mS1/U+KDrlsPcLciikBC89y/A+szG6sSNJYZJc9
         QFEh08T9cImGFyEAEy2hmaA8LEUqSWpgyX0sNaNOMBQvFMGMfz0IpSQqxksNsoq2xRst
         JmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=SidjaeLltkRbDBELlZ8bKr9H1JAqOBDWVEO14927GyI=;
        b=B0ioZTfd2OdJ5MRWpKNmz1a99UCBuXT+IwIqM0YsD7w5luPb5DGs/FxnmhC/LlLMI6
         99mywm/I8aTMVZmF6QTc25W1jCBdggBXDJZ1wDuEvsTjea145K7T21zENUYp/oCs+V+Z
         1jBBiEL1uiKqYOzoRwsnLMWkduyRWeJS0exmrph0xiK4H1INREBnogd+tHUJsrqsPtET
         QOTJfWDCzsa6K6/CCLUolKjWSNQ3L9cjSjJrc7sdhPjG3uyzpwL0P3jK2UqaUacrhqrs
         gDKt/HDbz4rmVhVINI6dQsWGUFfmKV/xNQ2ZJnzbq0AR9qfTLOauJj9nyK/9rcW8938l
         2emA==
X-Gm-Message-State: AOAM532z1r1vgggDo9ClBlJuADe2/Upv1ogKRK6sIqpG5ycvDKQWqGfF
        Cp6DUamfmzfAyoMjPZYOmamaTRStHvVhTg==
X-Google-Smtp-Source: ABdhPJzFPdg5t/6kjhor0OfRDTgulq0Sj2XKyFGTWJULnP0zF9fQ4IpZFh0HjIToRf+B2L2cUvDeYiM751dOzQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:648d:cdc5:d51:4873])
 (user=dlatypov job=sendgmr) by 2002:a25:33d6:0:b0:64a:9d22:f005 with SMTP id
 z205-20020a2533d6000000b0064a9d22f005mr1172243ybz.54.1652380547371; Thu, 12
 May 2022 11:35:47 -0700 (PDT)
Date:   Thu, 12 May 2022 11:35:36 -0700
Message-Id: <20220512183538.3787321-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v2 1/3] kunit: tool: remove dead parse_crash_in_log() logic
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This logic depends on the kernel logging a message containing
'kunit test case crashed', but there is no corresponding logic to do so.

This is likely a relic of the revision process KUnit initially went
through when being upstreamed.

Delete it given
1) it's been missing for years and likely won't get implemented
2) the parser has been moving to be a more general KTAP parser,
   kunit-only magic like this isn't how we'd want to implement it.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: rebase onto -kselftest/kunit branch, no changes
---
 tools/testing/kunit/kunit_parser.py           | 21 ------
 tools/testing/kunit/kunit_tool_test.py        | 17 ++---
 .../test_data/test_is_test_passed-crash.log   | 70 -------------------
 3 files changed, 4 insertions(+), 104 deletions(-)
 delete mode 100644 tools/testing/kunit/test_data/test_is_test_passed-crash.log

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index e16331a5bec4..c8c0df56cc51 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -475,26 +475,6 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 		log.append(lines.pop())
 	return log
 
-DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^# .*?: kunit test case crashed!$')
-
-def parse_crash_in_log(test: Test) -> bool:
-	"""
-	Iterate through the lines of the log to parse for crash message.
-	If crash message found, set status to crashed and return True.
-	Otherwise return False.
-
-	Parameters:
-	test - Test object for current test being parsed
-
-	Return:
-	True if crash message found in log
-	"""
-	for line in test.log:
-		if DIAGNOSTIC_CRASH_MESSAGE.match(line):
-			test.status = TestStatus.TEST_CRASHED
-			return True
-	return False
-
 
 # Printing helper methods:
 
@@ -682,7 +662,6 @@ def bubble_up_test_results(test: Test) -> None:
 	Parameters:
 	test - Test object for current test being parsed
 	"""
-	parse_crash_in_log(test)
 	subtests = test.subtests
 	counts = test.counts
 	status = test.status
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index aebda46bcad8..b417eceeda74 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -230,15 +230,6 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock.stop()
 		self.assertEqual(0, len(result.subtests))
 
-	def test_crashed_test(self):
-		crashed_log = test_data_path('test_is_test_passed-crash.log')
-		with open(crashed_log) as file:
-			result = kunit_parser.parse_run_tests(
-				file.readlines())
-		self.assertEqual(
-			kunit_parser.TestStatus.TEST_CRASHED,
-			result.status)
-
 	def test_skipped_test(self):
 		skipped_log = test_data_path('test_skip_tests.log')
 		with open(skipped_log) as file:
@@ -478,10 +469,10 @@ class KUnitJsonTest(unittest.TestCase):
 			result["sub_groups"][1]["test_cases"][0])
 
 	def test_crashed_test_json(self):
-		result = self._json_for('test_is_test_passed-crash.log')
+		result = self._json_for('test_kernel_panic_interrupt.log')
 		self.assertEqual(
-			{'name': 'example_simple_test', 'status': 'ERROR'},
-			result["sub_groups"][1]["test_cases"][0])
+			{'name': '', 'status': 'ERROR'},
+			result["sub_groups"][2]["test_cases"][1])
 
 	def test_skipped_test_json(self):
 		result = self._json_for('test_skip_tests.log')
@@ -562,7 +553,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_no_tests(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
 		with self.assertRaises(SystemExit) as e:
-                  kunit.main(['run'], self.linux_source_mock)
+		  kunit.main(['run'], self.linux_source_mock)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-crash.log b/tools/testing/kunit/test_data/test_is_test_passed-crash.log
deleted file mode 100644
index 4d97f6708c4a..000000000000
--- a/tools/testing/kunit/test_data/test_is_test_passed-crash.log
+++ /dev/null
@@ -1,70 +0,0 @@
-printk: console [tty0] enabled
-printk: console [mc-1] enabled
-TAP version 14
-1..2
-	# Subtest: sysctl_test
-	1..8
-	# sysctl_test_dointvec_null_tbl_data: sysctl_test_dointvec_null_tbl_data passed
-	ok 1 - sysctl_test_dointvec_null_tbl_data
-	# sysctl_test_dointvec_table_maxlen_unset: sysctl_test_dointvec_table_maxlen_unset passed
-	ok 2 - sysctl_test_dointvec_table_maxlen_unset
-	# sysctl_test_dointvec_table_len_is_zero: sysctl_test_dointvec_table_len_is_zero passed
-	ok 3 - sysctl_test_dointvec_table_len_is_zero
-	# sysctl_test_dointvec_table_read_but_position_set: sysctl_test_dointvec_table_read_but_position_set passed
-	ok 4 - sysctl_test_dointvec_table_read_but_position_set
-	# sysctl_test_dointvec_happy_single_positive: sysctl_test_dointvec_happy_single_positive passed
-	ok 5 - sysctl_test_dointvec_happy_single_positive
-	# sysctl_test_dointvec_happy_single_negative: sysctl_test_dointvec_happy_single_negative passed
-	ok 6 - sysctl_test_dointvec_happy_single_negative
-	# sysctl_test_dointvec_single_less_int_min: sysctl_test_dointvec_single_less_int_min passed
-	ok 7 - sysctl_test_dointvec_single_less_int_min
-	# sysctl_test_dointvec_single_greater_int_max: sysctl_test_dointvec_single_greater_int_max passed
-	ok 8 - sysctl_test_dointvec_single_greater_int_max
-kunit sysctl_test: all tests passed
-ok 1 - sysctl_test
-	# Subtest: example
-	1..2
-init_suite
-	# example_simple_test: initializing
-Stack:
- 6016f7db 6f81bd30 6f81bdd0 60021450
- 6024b0e8 60021440 60018bbe 16f81bdc0
- 00000001 6f81bd30 6f81bd20 6f81bdd0
-Call Trace:
- [<6016f7db>] ? kunit_try_run_case+0xab/0xf0
- [<60021450>] ? set_signals+0x0/0x60
- [<60021440>] ? get_signals+0x0/0x10
- [<60018bbe>] ? kunit_um_run_try_catch+0x5e/0xc0
- [<60021450>] ? set_signals+0x0/0x60
- [<60021440>] ? get_signals+0x0/0x10
- [<60018bb3>] ? kunit_um_run_try_catch+0x53/0xc0
- [<6016f321>] ? kunit_run_case_catch_errors+0x121/0x1a0
- [<60018b60>] ? kunit_um_run_try_catch+0x0/0xc0
- [<600189e0>] ? kunit_um_throw+0x0/0x180
- [<6016f730>] ? kunit_try_run_case+0x0/0xf0
- [<6016f600>] ? kunit_catch_run_case+0x0/0x130
- [<6016edd0>] ? kunit_vprintk+0x0/0x30
- [<6016ece0>] ? kunit_fail+0x0/0x40
- [<6016eca0>] ? kunit_abort+0x0/0x40
- [<6016ed20>] ? kunit_printk_emit+0x0/0xb0
- [<6016f200>] ? kunit_run_case_catch_errors+0x0/0x1a0
- [<6016f46e>] ? kunit_run_tests+0xce/0x260
- [<6005b390>] ? unregister_console+0x0/0x190
- [<60175b70>] ? suite_kunit_initexample_test_suite+0x0/0x20
- [<60001cbb>] ? do_one_initcall+0x0/0x197
- [<60001d47>] ? do_one_initcall+0x8c/0x197
- [<6005cd20>] ? irq_to_desc+0x0/0x30
- [<60002005>] ? kernel_init_freeable+0x1b3/0x272
- [<6005c5ec>] ? printk+0x0/0x9b
- [<601c0086>] ? kernel_init+0x26/0x160
- [<60014442>] ? new_thread_handler+0x82/0xc0
-
-	# example_simple_test: kunit test case crashed!
-	# example_simple_test: example_simple_test failed
-	not ok 1 - example_simple_test
-	# example_mock_test: initializing
-	# example_mock_test: example_mock_test passed
-	ok 2 - example_mock_test
-kunit example: one or more tests failed
-not ok 2 - example
-List of all partitions:

base-commit: 9660209d9418f2295d31fea0d32e313e9b2c1200
-- 
2.36.0.550.gb090851708-goog

