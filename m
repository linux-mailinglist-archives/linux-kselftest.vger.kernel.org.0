Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53FD02CC643
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 20:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389676AbgLBTJq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 14:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389599AbgLBTJq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 14:09:46 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E855AC0617A7
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 11:09:05 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id m186so2959551ybm.22
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 11:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=d9ODsGy71UxS1scEvGTz4NCozRGDYn/BsJFydzZu0V0=;
        b=dm5FdKlSIuxUi4iLenNKFWMujqwqankdTmdkODUJuiHoLawGQEiQYIlCsPA196Zy5s
         rJ03obABD3u8Q3lABqlHBI08yEr3pL8Hwdv1f+NnXPVmFwdZn0VdbbpsxCKacL58cOsf
         2K9qn3WjkeW/Vxhz6Z3LMNidcFYPXIh/q8TfQ8aBjP4Cgb+LmgppN4kyjCuo0Gp6ZZ9u
         3fuLgKBkULfSfv42PD05FLsXvhPJGUSSex8Sk2qXGJgjhARC6jrne1bB09543UR464Kr
         Y1nO8tsaSexhUXeMwgV8AVn9NlC53AwAtGqznDMKxTRRTr0hEuzel7fqh67UJxVi+Aw4
         D8vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d9ODsGy71UxS1scEvGTz4NCozRGDYn/BsJFydzZu0V0=;
        b=sLrYrosf3D3DWBxAhT92DVMoindycQsXyLd8T6C+iAmev+2asHfe645PJydPWNtXfm
         7Ap1TpBaf1scvR3BJ6Ev8mobIPR/AlShKVo+vmACaP4aldg2j04Hkk5qkL3T3Hks/2kO
         EEBOoAm8usNQUVIFuLaPDiEuemg5Cyu15eDZpddI0/p1IlPzYvjwQHqnyj486ovyyDUh
         s9m7s1RgpUs+gREE6kr1u3yAk/xw3TZTvdR+NZpwqkBUn/kHYnGWxPnxMBR4/xpvFcUY
         1BeKAt+AlQbwplkcBG5AWrzxXtd/Nh2NCMibYwB6CJNvSO1bLubwIvQ7Zd5g5U/ReKQx
         OqAg==
X-Gm-Message-State: AOAM532HD+3pQZtIq8/ze6atatJxSKw4izNnuqxp7+YRNI80nLvqwjWJ
        Id4vymBjafrDfCZCkHQOsBVPCvOq3DCNBw==
X-Google-Smtp-Source: ABdhPJwmsBhISZbu0nVZxEfBTeDWYTD4iqql23LY1CiDCmUOfcfU0O8RYn2iUSu71C7BW1OylAiUFpjYE9ItZA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:d251:: with SMTP id
 j78mr5578186ybg.193.1606936145223; Wed, 02 Dec 2020 11:09:05 -0800 (PST)
Date:   Wed,  2 Dec 2020 11:08:23 -0800
In-Reply-To: <20201202190824.1309398-1-dlatypov@google.com>
Message-Id: <20201202190824.1309398-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v2 3/4] kunit: tool: use `with open()` in unit test
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The use of manual open() and .close() calls seems to be an attempt to
keep the contents in scope.
But Python doesn't restrict variables like that, so we can introduce new
variables inside of a `with` and use them outside.

Do so to make the code more Pythonic.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 33 +++++++++++---------------
 1 file changed, 14 insertions(+), 19 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 3a74e5612cf9..cf160914bc55 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -100,15 +100,14 @@ class KUnitParserTest(unittest.TestCase):
 	def test_output_isolated_correctly(self):
 		log_path = get_absolute_path(
 			'test_data/test_output_isolated_correctly.log')
-		file = open(log_path)
-		result = kunit_parser.isolate_kunit_output(file.readlines())
+		with open(log_path) as file:
+			result = kunit_parser.isolate_kunit_output(file.readlines())
 		self.assertContains('TAP version 14', result)
 		self.assertContains('	# Subtest: example', result)
 		self.assertContains('	1..2', result)
 		self.assertContains('	ok 1 - example_simple_test', result)
 		self.assertContains('	ok 2 - example_mock_test', result)
 		self.assertContains('ok 1 - example', result)
-		file.close()
 
 	def test_output_with_prefix_isolated_correctly(self):
 		log_path = get_absolute_path(
@@ -143,42 +142,39 @@ class KUnitParserTest(unittest.TestCase):
 	def test_parse_successful_test_log(self):
 		all_passed_log = get_absolute_path(
 			'test_data/test_is_test_passed-all_passed.log')
-		file = open(all_passed_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(all_passed_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
-		file.close()
 
 	def test_parse_failed_test_log(self):
 		failed_log = get_absolute_path(
 			'test_data/test_is_test_passed-failure.log')
-		file = open(failed_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(failed_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
 			kunit_parser.TestStatus.FAILURE,
 			result.status)
-		file.close()
 
 	def test_no_tests(self):
 		empty_log = get_absolute_path(
 			'test_data/test_is_test_passed-no_tests_run.log')
-		file = open(empty_log)
-		result = kunit_parser.parse_run_tests(
-			kunit_parser.isolate_kunit_output(file.readlines()))
+		with open(empty_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.isolate_kunit_output(file.readlines()))
 		self.assertEqual(0, len(result.suites))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
-		file.close()
 
 	def test_no_kunit_output(self):
 		crash_log = get_absolute_path(
 			'test_data/test_insufficient_memory.log')
-		file = open(crash_log)
 		print_mock = mock.patch('builtins.print').start()
-		result = kunit_parser.parse_run_tests(
-			kunit_parser.isolate_kunit_output(file.readlines()))
+		with open(crash_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.isolate_kunit_output(file.readlines()))
 		print_mock.assert_any_call(StrContains('no tests run!'))
 		print_mock.stop()
 		file.close()
@@ -186,12 +182,11 @@ class KUnitParserTest(unittest.TestCase):
 	def test_crashed_test(self):
 		crashed_log = get_absolute_path(
 			'test_data/test_is_test_passed-crash.log')
-		file = open(crashed_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(crashed_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
 			kunit_parser.TestStatus.TEST_CRASHED,
 			result.status)
-		file.close()
 
 	def test_ignores_prefix_printk_time(self):
 		prefix_log = get_absolute_path(
-- 
2.29.2.576.ga3fc446d84-goog

