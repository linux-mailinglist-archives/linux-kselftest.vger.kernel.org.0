Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD712A8411
	for <lists+linux-kselftest@lfdr.de>; Thu,  5 Nov 2020 17:55:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgKEQzX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 5 Nov 2020 11:55:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727836AbgKEQzW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 5 Nov 2020 11:55:22 -0500
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370D2C0613D2
        for <linux-kselftest@vger.kernel.org>; Thu,  5 Nov 2020 08:55:21 -0800 (PST)
Received: by mail-io1-xd30.google.com with SMTP id s24so2448316ioj.13
        for <linux-kselftest@vger.kernel.org>; Thu, 05 Nov 2020 08:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=A7eUjExHN7yFyoaaOH3pg+2O9I2/WNz5TXP8df7U/AU=;
        b=Pa96Y8HQAFTdeXzF44bjxCUQjbaznv8o5ypOXpIgK6heAshtGtqSGOxao+3PKFkSRx
         /otUV6A9IE23B8Q6R39Tlwz72+/N2s9oUkEhjcxtz2QyWBaMeNOogYjASRsDL5t2A6WO
         K1dklHqP+H9XFgEZZ4WxUg8Cx+sN1lGObA6J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=A7eUjExHN7yFyoaaOH3pg+2O9I2/WNz5TXP8df7U/AU=;
        b=A3O+xY4y7QWgbPZF6sIeyIcSN/F/appbs0SzExnkChn9HT152RNZ7DyHGruu4x3Fc3
         7+XUMo61mPYk1SLCMUYoCvUE1F2PakrhYASd7qwoGGyu401eUQNXAAyIOIsQpGvXQQ7c
         Uev9W5ACPBwXow3Ibp+xdB6Y8kGTxt35W16Z/ANVH8921XimqyK9V0KBisM46Rc9RQDX
         D3WiVJUn1YZeu83TNk0xEhdOBg9N6palzK6Lvkh7rUP+NqCLDOcZylWKCXrrxhipdh3Z
         LuEQmhXWZ2Fn8LsMEB7gF+4H2qs+evGjpPmwKZtc+IVQrzcAisZ0rF8ITAq8Dy2oL4st
         +ckQ==
X-Gm-Message-State: AOAM5326uitEgyGnhpwTJMg5uSAA0F/xS7WBWzIl5MFpOCh3jdVEuwHk
        OUdR4LWF+uUsnNo5NsdZKyWHtruLqGHWMQ==
X-Google-Smtp-Source: ABdhPJwX9/Bh3gFgoA58NupRasdd4ZB5SGYVYUwRMf9E5jKgnaS8bApkFxnWmUBvuxHF+PoVOwqWRA==
X-Received: by 2002:a5d:9f44:: with SMTP id u4mr2357504iot.141.1604595320351;
        Thu, 05 Nov 2020 08:55:20 -0800 (PST)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id o14sm1385959ilo.80.2020.11.05.08.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2020 08:55:19 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: Kunit fixes update for Linux 5.10-rc3
Message-ID: <6b9e77b0-7272-221e-d475-41b266b22496@linuxfoundation.org>
Date:   Thu, 5 Nov 2020 09:55:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------88FCE3E17F17B05CCCEE4A29"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------88FCE3E17F17B05CCCEE4A29
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kunit fixes update for Linux 5.10-rc3

This Kunit update for Linux 5.10-rc3 consists of several kunit_tool
and documentation fixes.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

   Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-fixes-5.10-rc3

for you to fetch changes up to 0d0d245104a42e593adcf11396017a6420c08ba8:

   kunit: tools: fix kunit_tool tests for parsing test plans (2020-10-26 
13:25:40 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.10-rc3

This Kunit update for Linux 5.10-rc3 consists of several kunit_tool
and documentation fixes.

----------------------------------------------------------------
Andy Shevchenko (1):
       kunit: Don't fail test suites if one of them is empty

Brendan Higgins (1):
       kunit: tools: fix kunit_tool tests for parsing test plans

David Gow (1):
       kunit: Fix kunit.py --raw_output option

Mauro Carvalho Chehab (1):
       kunit: test: fix remaining kernel-doc warnings

SeongJae Park (1):
       Documentation: kunit: Update Kconfig parts for KUNIT's module support

  Documentation/dev-tools/kunit/start.rst            |   2 +-
  Documentation/dev-tools/kunit/usage.rst            |   5 ++++
  include/kunit/test.h                               |  16 +++++------
  tools/testing/kunit/kunit_parser.py                |   3 +-
  tools/testing/kunit/kunit_tool_test.py             |  32 
++++++++++++++++-----
  .../kunit/test_data/test_config_printk_time.log    | Bin 1584 -> 1605 
bytes
  .../test_data/test_interrupted_tap_output.log      | Bin 1982 -> 2003 
bytes
  .../test_data/test_kernel_panic_interrupt.log      | Bin 1321 -> 1342 
bytes
  .../kunit/test_data/test_multiple_prefixes.log     | Bin 1832 -> 1861 
bytes
  .../kunit/test_data/test_pound_no_prefix.log       | Bin 1193 -> 1200 
bytes
  tools/testing/kunit/test_data/test_pound_sign.log  | Bin 1656 -> 1676 
bytes
  11 files changed, 40 insertions(+), 18 deletions(-)

----------------------------------------------------------------

--------------88FCE3E17F17B05CCCEE4A29
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.10-rc3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.10-rc3.diff"

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index d23385e3e159..454f307813ea 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -197,7 +197,7 @@ Now add the following to ``drivers/misc/Kconfig``:
 
 	config MISC_EXAMPLE_TEST
 		bool "Test for my example"
-		depends on MISC_EXAMPLE && KUNIT
+		depends on MISC_EXAMPLE && KUNIT=y
 
 and the following to ``drivers/misc/Makefile``:
 
diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
index 961d3ea3ca19..62142a47488c 100644
--- a/Documentation/dev-tools/kunit/usage.rst
+++ b/Documentation/dev-tools/kunit/usage.rst
@@ -561,6 +561,11 @@ Once the kernel is built and installed, a simple
 
 ...will run the tests.
 
+.. note::
+   Note that you should make sure your test depends on ``KUNIT=y`` in Kconfig
+   if the test does not support module build.  Otherwise, it will trigger
+   compile errors if ``CONFIG_KUNIT`` is ``m``.
+
 Writing new tests for other architectures
 -----------------------------------------
 
diff --git a/include/kunit/test.h b/include/kunit/test.h
index 9197da792336..db1b0ae666c4 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -252,13 +252,14 @@ static inline int kunit_run_all_tests(void)
 }
 #endif /* IS_BUILTIN(CONFIG_KUNIT) */
 
+#ifdef MODULE
 /**
- * kunit_test_suites() - used to register one or more &struct kunit_suite
- *			 with KUnit.
+ * kunit_test_suites_for_module() - used to register one or more
+ *			 &struct kunit_suite with KUnit.
  *
- * @suites_list...: a statically allocated list of &struct kunit_suite.
+ * @__suites: a statically allocated list of &struct kunit_suite.
  *
- * Registers @suites_list with the test framework. See &struct kunit_suite for
+ * Registers @__suites with the test framework. See &struct kunit_suite for
  * more information.
  *
  * If a test suite is built-in, module_init() gets translated into
@@ -267,7 +268,6 @@ static inline int kunit_run_all_tests(void)
  * module_{init|exit} functions for the builtin case when registering
  * suites via kunit_test_suites() below.
  */
-#ifdef MODULE
 #define kunit_test_suites_for_module(__suites)				\
 	static int __init kunit_test_suites_init(void)			\
 	{								\
@@ -294,7 +294,7 @@ static inline int kunit_run_all_tests(void)
  * kunit_test_suites() - used to register one or more &struct kunit_suite
  *			 with KUnit.
  *
- * @suites: a statically allocated list of &struct kunit_suite.
+ * @__suites: a statically allocated list of &struct kunit_suite.
  *
  * Registers @suites with the test framework. See &struct kunit_suite for
  * more information.
@@ -308,10 +308,10 @@ static inline int kunit_run_all_tests(void)
  * module.
  *
  */
-#define kunit_test_suites(...)						\
+#define kunit_test_suites(__suites...)						\
 	__kunit_test_suites(__UNIQUE_ID(array),				\
 			    __UNIQUE_ID(suites),			\
-			    __VA_ARGS__)
+			    ##__suites)
 
 #define kunit_test_suite(suite)	kunit_test_suites(&suite)
 
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8019e3dd4c32..84a1af2581f5 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -66,7 +66,6 @@ def isolate_kunit_output(kernel_output):
 def raw_output(kernel_output):
 	for line in kernel_output:
 		print(line)
-		yield line
 
 DIVIDER = '=' * 60
 
@@ -242,7 +241,7 @@ def parse_test_suite(lines: List[str], expected_suite_index: int) -> TestSuite:
 		return None
 	test_suite.name = name
 	expected_test_case_num = parse_subtest_plan(lines)
-	if not expected_test_case_num:
+	if expected_test_case_num is None:
 		return None
 	while expected_test_case_num > 0:
 		test_case = parse_test_case(lines)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 99c3c5671ea4..0b60855fb819 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -179,7 +179,7 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock = mock.patch('builtins.print').start()
 		result = kunit_parser.parse_run_tests(
 			kunit_parser.isolate_kunit_output(file.readlines()))
-		print_mock.assert_any_call(StrContains("no kunit output detected"))
+		print_mock.assert_any_call(StrContains('no tests run!'))
 		print_mock.stop()
 		file.close()
 
@@ -198,39 +198,57 @@ class KUnitParserTest(unittest.TestCase):
 			'test_data/test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = get_absolute_path(
 			'test_data/test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = get_absolute_path(
 			'test_data/test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_prefix_poundsign(self):
 		pound_log = get_absolute_path('test_data/test_pound_sign.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_kernel_panic_end(self):
 		panic_log = get_absolute_path('test_data/test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.TEST_CRASHED,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_pound_no_prefix(self):
 		pound_log = get_absolute_path('test_data/test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual('kunit-resource-test', result.suites[0].name)
+			self.assertEqual(
+				kunit_parser.TestStatus.SUCCESS,
+				result.status)
+			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 class KUnitJsonTest(unittest.TestCase):
 
diff --git a/tools/testing/kunit/test_data/test_config_printk_time.log b/tools/testing/kunit/test_data/test_config_printk_time.log
index c02ca773946d..6bdb57f76eac 100644
Binary files a/tools/testing/kunit/test_data/test_config_printk_time.log and b/tools/testing/kunit/test_data/test_config_printk_time.log differ
diff --git a/tools/testing/kunit/test_data/test_interrupted_tap_output.log b/tools/testing/kunit/test_data/test_interrupted_tap_output.log
index 5c73fb3a1c6f..1fb677728abe 100644
Binary files a/tools/testing/kunit/test_data/test_interrupted_tap_output.log and b/tools/testing/kunit/test_data/test_interrupted_tap_output.log differ
diff --git a/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log
index c045eee75f27..a014ffe9725e 100644
Binary files a/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log and b/tools/testing/kunit/test_data/test_kernel_panic_interrupt.log differ
diff --git a/tools/testing/kunit/test_data/test_multiple_prefixes.log b/tools/testing/kunit/test_data/test_multiple_prefixes.log
index bc48407dcc36..0ad78481a0b4 100644
Binary files a/tools/testing/kunit/test_data/test_multiple_prefixes.log and b/tools/testing/kunit/test_data/test_multiple_prefixes.log differ
diff --git a/tools/testing/kunit/test_data/test_pound_no_prefix.log b/tools/testing/kunit/test_data/test_pound_no_prefix.log
index 2ceb360be7d5..dc4cf09a96d0 100644
Binary files a/tools/testing/kunit/test_data/test_pound_no_prefix.log and b/tools/testing/kunit/test_data/test_pound_no_prefix.log differ
diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
index 28ffa5ba03bf..3f358e3a7ba0 100644
Binary files a/tools/testing/kunit/test_data/test_pound_sign.log and b/tools/testing/kunit/test_data/test_pound_sign.log differ

--------------88FCE3E17F17B05CCCEE4A29--
