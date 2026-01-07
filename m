Return-Path: <linux-kselftest+bounces-48398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D6ACFDCCC
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 14:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49D52304D492
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 12:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4F2531AAA2;
	Wed,  7 Jan 2026 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A3edUKPJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DjXfCj+2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADF131985D;
	Wed,  7 Jan 2026 12:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767790322; cv=none; b=p2sqX3fAn9KoLYr2wz/yqQPrPuY73U9gp3DRXQAa0SvwLnuThoC036c31//ctbLua+gPBhRUIPAq9KgNfpWxp+g02JZB+L1eBD0If2n+l/WusKN3CfmmTu5zCUpsUhvPNvSbGpAL89vM8qgKiDmrArv1D/wdnLR/jh5y/IMIMh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767790322; c=relaxed/simple;
	bh=HJhZsXlTmc2veY0IwCbLhotyxhySH2PJzKBk2Ppp3H4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KK/kE0N1HFHeq3SKsoBoCuS0EaZXV/hpKj6htuGwul7utc7bA0jNTArHBEoelgyU+MJRytptImNUqIkBwYGaMHVhcwCz0XxWX6zbZanYQYliBKqvouco5NkyqqKYIHiZACCGbfV0wx5NYc15e3UdInT6Or78Xnod0nngGqMaz/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A3edUKPJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DjXfCj+2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767790319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etIdIDT5zFyEzpfGwWUYiWVccSovb37+sWMNfT6wfUk=;
	b=A3edUKPJr3glOKaAiqN4bRa8BwRLO3NP5RkweYjrecwmGn8bzNvxbLrKloI0D/4EoxGRUB
	5AudPQTzVxWp5VdzAt3BTtwz9BWkm7x8T9J5PTurrktj9BQ/p55XRjeZT6vzis0cU8+4gC
	vGX33uAxAxgJkYESF9kdrH5lTXGWi7zHrZoEL3TwrZ7yzBI/LfeFstRU2ysLAxcw3TmG8R
	13y0oURKESo6wTdsMqtSNAm6P4v2dEsFzHdo0InNE3v25X/u2kwVlk7FnpS9bCx2YJ8Z44
	4Ylj/k39OWc/GQVBzgeS1/CypQXsZmOmOLREv+tsQgrXysXvr8CBD+JTni1/UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767790319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etIdIDT5zFyEzpfGwWUYiWVccSovb37+sWMNfT6wfUk=;
	b=DjXfCj+21R5vqKe7pxqtkRfFZ0ocW3dTtYEULwrTt/ZNs1JJ4Ozw455sWfRggQLm7LgBwq
	Bw5GzUzuWGm6ZZBA==
Date: Wed, 07 Jan 2026 13:51:51 +0100
Subject: [PATCH v2 1/2] kunit: tool: test: Rename test_data_path() to
 _test_data_path()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260107-kunit-pytest-v2-1-7d1f8d9a5ffa@linutronix.de>
References: <20260107-kunit-pytest-v2-0-7d1f8d9a5ffa@linutronix.de>
In-Reply-To: <20260107-kunit-pytest-v2-0-7d1f8d9a5ffa@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767790313; l=12368;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=HJhZsXlTmc2veY0IwCbLhotyxhySH2PJzKBk2Ppp3H4=;
 b=mjkkUL2sB8ZAZLqQc4Pa7a3krpslraV/XSSEZAf9JmH/rhgIjcEtpGsVYsIWrTlT6gLZgmmM1
 Asj7kUZV+rqAZwZHUApuJcivMNbYBUnUFxHeZPdgO/CzBk6CEl+aYzn
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Running the KUnit testsuite through pytest fails, as the function
test_data_path() is recognized as a test function. Its execution fails
as pytest tries to resolve the 'path' argument as a fixture which does
not exist.

Rename the function, so the helper function is not incorrectly
recognized as a test function.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 56 +++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bdc51b5c7b10..30ac1cb6c8ed 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -36,7 +36,7 @@ def setUpModule():
 def tearDownModule():
 	shutil.rmtree(test_tmpdir)
 
-def test_data_path(path):
+def _test_data_path(path):
 	return os.path.join(abs_test_data_dir, path)
 
 class KconfigTest(unittest.TestCase):
@@ -52,7 +52,7 @@ class KconfigTest(unittest.TestCase):
 		self.assertFalse(kconfig1.is_subset_of(kconfig0))
 
 	def test_read_from_file(self):
-		kconfig_path = test_data_path('test_read_from_file.kconfig')
+		kconfig_path = _test_data_path('test_read_from_file.kconfig')
 
 		kconfig = kunit_config.parse_file(kconfig_path)
 
@@ -98,7 +98,7 @@ class KUnitParserTest(unittest.TestCase):
 		raise AssertionError(f'"{needle}" not found in {list(backup)}!')
 
 	def test_output_isolated_correctly(self):
-		log_path = test_data_path('test_output_isolated_correctly.log')
+		log_path = _test_data_path('test_output_isolated_correctly.log')
 		with open(log_path) as file:
 			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -109,7 +109,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 1 - example', result)
 
 	def test_output_with_prefix_isolated_correctly(self):
-		log_path = test_data_path('test_pound_sign.log')
+		log_path = _test_data_path('test_pound_sign.log')
 		with open(log_path) as file:
 			result = kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -138,35 +138,35 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 3 - string-stream-test', result)
 
 	def test_parse_successful_test_log(self):
-		all_passed_log = test_data_path('test_is_test_passed-all_passed.log')
+		all_passed_log = _test_data_path('test_is_test_passed-all_passed.log')
 		with open(all_passed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_successful_nested_tests_log(self):
-		all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
+		all_passed_log = _test_data_path('test_is_test_passed-all_passed_nested.log')
 		with open(all_passed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_kselftest_nested(self):
-		kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
+		kselftest_log = _test_data_path('test_is_test_passed-kselftest.log')
 		with open(kselftest_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_failed_test_log(self):
-		failed_log = test_data_path('test_is_test_passed-failure.log')
+		failed_log = _test_data_path('test_is_test_passed-failure.log')
 		with open(failed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_failed_nested_tests_log(self):
-		nested_log = test_data_path('test_is_test_passed-failure-nested.log')
+		nested_log = _test_data_path('test_is_test_passed-failure-nested.log')
 		with open(nested_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
@@ -177,7 +177,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].subtests[0].status)
 
 	def test_no_header(self):
-		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
+		empty_log = _test_data_path('test_is_test_passed-no_tests_run_no_header.log')
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -186,7 +186,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
 
 	def test_missing_test_plan(self):
-		missing_plan_log = test_data_path('test_is_test_passed-'
+		missing_plan_log = _test_data_path('test_is_test_passed-'
 			'missing_plan.log')
 		with open(missing_plan_log) as file:
 			result = kunit_parser.parse_run_tests(
@@ -197,7 +197,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 
 	def test_no_tests(self):
-		header_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
+		header_log = _test_data_path('test_is_test_passed-no_tests_run_with_header.log')
 		with open(header_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -206,7 +206,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
 
 	def test_no_tests_no_plan(self):
-		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
+		no_plan_log = _test_data_path('test_is_test_passed-no_tests_no_plan.log')
 		with open(no_plan_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -218,7 +218,7 @@ class KUnitParserTest(unittest.TestCase):
 
 
 	def test_no_kunit_output(self):
-		crash_log = test_data_path('test_insufficient_memory.log')
+		crash_log = _test_data_path('test_insufficient_memory.log')
 		print_mock = mock.patch('kunit_printer.Printer.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
@@ -229,7 +229,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
 
 	def test_skipped_test(self):
-		skipped_log = test_data_path('test_skip_tests.log')
+		skipped_log = _test_data_path('test_skip_tests.log')
 		with open(skipped_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
@@ -238,7 +238,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=4, skipped=1))
 
 	def test_skipped_all_tests(self):
-		skipped_log = test_data_path('test_skip_all_tests.log')
+		skipped_log = _test_data_path('test_skip_all_tests.log')
 		with open(skipped_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
@@ -246,7 +246,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts, kunit_parser.TestCounts(skipped=5))
 
 	def test_ignores_hyphen(self):
-		hyphen_log = test_data_path('test_strip_hyphen.log')
+		hyphen_log = _test_data_path('test_strip_hyphen.log')
 		with open(hyphen_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
@@ -260,7 +260,7 @@ class KUnitParserTest(unittest.TestCase):
 			result.subtests[1].name)
 
 	def test_ignores_prefix_printk_time(self):
-		prefix_log = test_data_path('test_config_printk_time.log')
+		prefix_log = _test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -268,7 +268,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_ignores_multiple_prefixes(self):
-		prefix_log = test_data_path('test_multiple_prefixes.log')
+		prefix_log = _test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -276,7 +276,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_prefix_mixed_kernel_output(self):
-		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
+		mixed_prefix_log = _test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -284,7 +284,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_prefix_poundsign(self):
-		pound_log = test_data_path('test_pound_sign.log')
+		pound_log = _test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -292,7 +292,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_kernel_panic_end(self):
-		panic_log = test_data_path('test_kernel_panic_interrupt.log')
+		panic_log = _test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
@@ -300,7 +300,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertGreaterEqual(result.counts.errors, 1)
 
 	def test_pound_no_prefix(self):
-		pound_log = test_data_path('test_pound_no_prefix.log')
+		pound_log = _test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -329,7 +329,7 @@ class KUnitParserTest(unittest.TestCase):
 			'Failures: all_failed_suite, some_failed_suite.test2')
 
 	def test_ktap_format(self):
-		ktap_log = test_data_path('test_parse_ktap_output.log')
+		ktap_log = _test_data_path('test_parse_ktap_output.log')
 		with open(ktap_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3))
@@ -338,13 +338,13 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual('case_2', result.subtests[0].subtests[1].name)
 
 	def test_parse_subtest_header(self):
-		ktap_log = test_data_path('test_parse_subtest_header.log')
+		ktap_log = _test_data_path('test_parse_subtest_header.log')
 		with open(ktap_log) as file:
 			kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
 
 	def test_parse_attributes(self):
-		ktap_log = test_data_path('test_parse_attributes.log')
+		ktap_log = _test_data_path('test_parse_attributes.log')
 		with open(ktap_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
@@ -566,7 +566,7 @@ class KUnitJsonTest(unittest.TestCase):
 		self.addCleanup(mock.patch.stopall)
 
 	def _json_for(self, log_file):
-		with open(test_data_path(log_file)) as file:
+		with open(_test_data_path(log_file)) as file:
 			test_result = kunit_parser.parse_run_tests(file, stdout)
 			json_obj = kunit_json.get_json_result(
 				test=test_result,
@@ -607,7 +607,7 @@ class StrContains(str):
 
 class KUnitMainTest(unittest.TestCase):
 	def setUp(self):
-		path = test_data_path('test_is_test_passed-all_passed.log')
+		path = _test_data_path('test_is_test_passed-all_passed.log')
 		with open(path) as file:
 			all_passed_log = file.readlines()
 

-- 
2.52.0


