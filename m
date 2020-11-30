Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EE52C92B2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 00:34:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388945AbgK3XeW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 18:34:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388914AbgK3XeW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 18:34:22 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACEFC061A49
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:33:18 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id z2so9637679pgb.23
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=tPyi5TbCnaLx4c6NuJcjtfwgBCGdJGeWRYgusfy50Nk=;
        b=DoM0PqYstFLAA0BaFUNnbtKFubGPLMbYCC65Q+75vsd9cuUh5iTzj+M1U6x4W8yMSM
         XLwrTXZio3JF9Bsw/GDxQPU9eWrmSt8UkbzFdJmcX0+Cs7aYWG6d75haz/rcW3+KVzb+
         nO2c7FkCepVPQGE2RVFGjRkkoRDn9h43OQvqOGUW1b1GtcynYggN6Tl+1wUE66NYIkq0
         qgoypLESoiHSkSjl0mZqCAm7IlyJZt4b9zOM2uiJO9cvxQH+sa11nj0kbVvKYGano1li
         XPryg7cvZe0RnUzCuWjVm8ApHEZCgkwJseCM12yiuLHUg/NmyFWJX/Qm4Pnzmj8DHsbi
         eB0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tPyi5TbCnaLx4c6NuJcjtfwgBCGdJGeWRYgusfy50Nk=;
        b=NTYmVdNMnp5o1jv4LCyryuwFbCiZ4ucDKvA0KseilQYMbBd/U6YOoQ3Ct//cP/57rs
         c0QajWFnbNjljyK3xepSXwe2BlMf9RCRjRYc9MZqLCV5mTfYC7BEjviFjAR/Kkv6kcNk
         ggbBtRyjvWTVfTizCIrpDPmt93Po+p6nvNviXlgjdqF1CQE8whaIO0Ma0157mhJYvOo0
         hjb30i4f4plU22d52rmDFQVqXRbZbuBmBCNzuQBUbDxlQJX20HKZLLadbozGUlStNRH1
         WoFVzKpo9asam9KvJ5naUWmmEPGCKCEHh4XMeY/t+dDq/W7HjyEhJ8lZoQ1WygYuUhX9
         XweA==
X-Gm-Message-State: AOAM531Qhrq0DJd+urFD5DPSd7PkzZYaGBi9p39WW2SmowSP11M0bV5E
        +OpAqhCK1y2evv8EsO3kiCIjkw0gEn/MLA==
X-Google-Smtp-Source: ABdhPJxql+DTawc886oD+pqmP8ptUulIHrpVO14UnXuIN4CRV4TnFVJ8oQpngl5W8hMKLcIMK5HEGjR/L+99PA==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:782:: with SMTP id
 l2mr189686pjz.91.1606779197523; Mon, 30 Nov 2020 15:33:17 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:32:42 -0800
In-Reply-To: <20201130233242.78413-1-dlatypov@google.com>
Message-Id: <20201130233242.78413-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 5/5] minor: kunit: tool: s/get_absolute_path/test_data_path in
 unit test
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

1. the name is a lie. It gives relative paths, e.g. if I run from the
same dir as the test file, it gives './test_data/<file>'

2. it's only used for generating paths to tools/testing/kunit/test_data/
So we can tersen things by making it less general.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 56 ++++++++++----------------
 1 file changed, 21 insertions(+), 35 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index f2c12d96caa1..fbd8cd974554 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -29,8 +29,8 @@ def setUpModule():
 def tearDownModule():
 	shutil.rmtree(test_tmpdir)
 
-def get_absolute_path(path):
-	return os.path.join(os.path.dirname(__file__), path)
+def test_data_path(path):
+	return os.path.join(os.path.dirname(__file__), 'test_data', path)
 
 class KUnitTest(unittest.TestCase):
 	"""Contains common setup, like stopping main() from calling chdir."""
@@ -52,8 +52,7 @@ class KconfigTest(KUnitTest):
 
 	def test_read_from_file(self):
 		kconfig = kunit_config.Kconfig()
-		kconfig_path = get_absolute_path(
-			'test_data/test_read_from_file.kconfig')
+		kconfig_path = test_data_path('test_read_from_file.kconfig')
 
 		kconfig.read_from_file(kconfig_path)
 
@@ -104,8 +103,7 @@ class KUnitParserTest(KUnitTest):
 			str(needle) + '" not found in "' + str(haystack) + '"!')
 
 	def test_output_isolated_correctly(self):
-		log_path = get_absolute_path(
-			'test_data/test_output_isolated_correctly.log')
+		log_path = test_data_path('test_output_isolated_correctly.log')
 		with open(log_path) as file:
 			result = kunit_parser.isolate_kunit_output(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -116,8 +114,7 @@ class KUnitParserTest(KUnitTest):
 		self.assertContains('ok 1 - example', result)
 
 	def test_output_with_prefix_isolated_correctly(self):
-		log_path = get_absolute_path(
-			'test_data/test_pound_sign.log')
+		log_path = test_data_path('test_pound_sign.log')
 		with open(log_path) as file:
 			result = kunit_parser.isolate_kunit_output(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -146,8 +143,7 @@ class KUnitParserTest(KUnitTest):
 		self.assertContains('ok 3 - string-stream-test', result)
 
 	def test_parse_successful_test_log(self):
-		all_passed_log = get_absolute_path(
-			'test_data/test_is_test_passed-all_passed.log')
+		all_passed_log = test_data_path('test_is_test_passed-all_passed.log')
 		with open(all_passed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
@@ -155,8 +151,7 @@ class KUnitParserTest(KUnitTest):
 			result.status)
 
 	def test_parse_failed_test_log(self):
-		failed_log = get_absolute_path(
-			'test_data/test_is_test_passed-failure.log')
+		failed_log = test_data_path('test_is_test_passed-failure.log')
 		with open(failed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
@@ -164,8 +159,7 @@ class KUnitParserTest(KUnitTest):
 			result.status)
 
 	def test_no_tests(self):
-		empty_log = get_absolute_path(
-			'test_data/test_is_test_passed-no_tests_run.log')
+		empty_log = test_data_path('test_is_test_passed-no_tests_run.log')
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.isolate_kunit_output(file.readlines()))
@@ -175,8 +169,7 @@ class KUnitParserTest(KUnitTest):
 			result.status)
 
 	def test_no_kunit_output(self):
-		crash_log = get_absolute_path(
-			'test_data/test_insufficient_memory.log')
+		crash_log = test_data_path('test_insufficient_memory.log')
 		print_mock = mock.patch('builtins.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
@@ -186,8 +179,7 @@ class KUnitParserTest(KUnitTest):
 		file.close()
 
 	def test_crashed_test(self):
-		crashed_log = get_absolute_path(
-			'test_data/test_is_test_passed-crash.log')
+		crashed_log = test_data_path('test_is_test_passed-crash.log')
 		with open(crashed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
@@ -195,8 +187,7 @@ class KUnitParserTest(KUnitTest):
 			result.status)
 
 	def test_ignores_prefix_printk_time(self):
-		prefix_log = get_absolute_path(
-			'test_data/test_config_printk_time.log')
+		prefix_log = test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -205,8 +196,7 @@ class KUnitParserTest(KUnitTest):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_ignores_multiple_prefixes(self):
-		prefix_log = get_absolute_path(
-			'test_data/test_multiple_prefixes.log')
+		prefix_log = test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -215,8 +205,7 @@ class KUnitParserTest(KUnitTest):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
-		mixed_prefix_log = get_absolute_path(
-			'test_data/test_interrupted_tap_output.log')
+		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -225,7 +214,7 @@ class KUnitParserTest(KUnitTest):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_prefix_poundsign(self):
-		pound_log = get_absolute_path('test_data/test_pound_sign.log')
+		pound_log = test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -234,7 +223,7 @@ class KUnitParserTest(KUnitTest):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_kernel_panic_end(self):
-		panic_log = get_absolute_path('test_data/test_kernel_panic_interrupt.log')
+		panic_log = test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -243,7 +232,7 @@ class KUnitParserTest(KUnitTest):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
 
 	def test_pound_no_prefix(self):
-		pound_log = get_absolute_path('test_data/test_pound_no_prefix.log')
+		pound_log = test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -254,7 +243,7 @@ class KUnitParserTest(KUnitTest):
 class KUnitJsonTest(KUnitTest):
 
 	def _json_for(self, log_file):
-		with(open(get_absolute_path(log_file))) as file:
+		with open(test_data_path(log_file)) as file:
 			test_result = kunit_parser.parse_run_tests(file)
 			json_obj = kunit_json.get_json_result(
 				test_result=test_result,
@@ -264,22 +253,19 @@ class KUnitJsonTest(KUnitTest):
 		return json.loads(json_obj)
 
 	def test_failed_test_json(self):
-		result = self._json_for(
-			'test_data/test_is_test_passed-failure.log')
+		result = self._json_for('test_is_test_passed-failure.log')
 		self.assertEqual(
 			{'name': 'example_simple_test', 'status': 'FAIL'},
 			result["sub_groups"][1]["test_cases"][0])
 
 	def test_crashed_test_json(self):
-		result = self._json_for(
-			'test_data/test_is_test_passed-crash.log')
+		result = self._json_for('test_is_test_passed-crash.log')
 		self.assertEqual(
 			{'name': 'example_simple_test', 'status': 'ERROR'},
 			result["sub_groups"][1]["test_cases"][0])
 
 	def test_no_tests_json(self):
-		result = self._json_for(
-			'test_data/test_is_test_passed-no_tests_run.log')
+		result = self._json_for('test_is_test_passed-no_tests_run.log')
 		self.assertEqual(0, len(result['sub_groups']))
 
 class StrContains(str):
@@ -289,7 +275,7 @@ class StrContains(str):
 class KUnitMainTest(KUnitTest):
 	def setUp(self):
 		super().setUp()
-		path = get_absolute_path('test_data/test_is_test_passed-all_passed.log')
+		path = test_data_path('test_is_test_passed-all_passed.log')
 		with open(path) as file:
 			all_passed_log = file.readlines()
 
-- 
2.29.2.454.gaff20da3a2-goog

