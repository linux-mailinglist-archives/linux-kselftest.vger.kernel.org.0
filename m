Return-Path: <linux-kselftest+bounces-48012-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3168ECE9B69
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 13:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28F05301E911
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Dec 2025 12:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FBA1C862E;
	Tue, 30 Dec 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="msH+8SZS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y1v2n4GE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36DC1A0BF1;
	Tue, 30 Dec 2025 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767099408; cv=none; b=EUMLM5uDOvz24pEExj3MOQxXxziCl+Egub8WTspTS010sUd+7HnURaHmKMdzOJD3s2z8u5BJbGNKrjUxg8Yie996DqIHaZmoYqnmUW75wPwupmYJZdIzI8GF/yOILkDkM7B/qtYdxjf/j8uMioUbhodV+Sp9UVT5CURRYbwQGp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767099408; c=relaxed/simple;
	bh=aQk/k+/jxY0Jhp4+7QkNzjn0JzS7X4QWMy9CY9djLN4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DHtu6S7x4WJSJvATQlb+ZRKmr7wu7hnQe0YuywaRcWBeVSc/KpLJ9ieEMvHv0jAlMJx+jzlCLRzd2zJb60whi2UygXlSNkmFMrTokWGGEJMtYn+mh7T+TtQMy0LsMVqtRHMLQfoDilLXUsdYJDpC6OeJoJB+4DcygDoNDbYUWos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=msH+8SZS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y1v2n4GE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1767099405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqpa8UitD/zEH1Id2oykTZQknDuFWyP3Tm9yE7vObsM=;
	b=msH+8SZSuJjckvS23tWabTemy+NnQcPTojXAyh7KupyTZPFvQ1HjSzjZVDazmQrNASBCNu
	mLVYSgI5m6jmSOKgb3vc9hZvkVXCvaSlQoLDCd0+UhNl9W40Cx6kG43v4UIV4h+5YKdmyJ
	qyj/Kd+EIjLv12rlFyUXY5C7ol2imX9v5h7qQ1eVqfqqUn3uBH3SsTeqUVcTYcJH6iC0RN
	ZqDL1qu0815zIXN3O5DLX3NkkXoRF/spPBL4BFShvcWIkNwcprA4ZmsSQUs0IS7OXsq0lU
	vb/veTJ1C6zazXqduZCos+rBjmsATPx7/Oq5yHM6rNM4rZkXGe73+Ym+BeB6Iw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1767099405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pqpa8UitD/zEH1Id2oykTZQknDuFWyP3Tm9yE7vObsM=;
	b=Y1v2n4GEygzX5mNtBPweVqRawKjmwhnVQbR/aZB23XP2s7ie2b/IjopMmsa79+BOS4GMhF
	KGwT1TnX5HJgxEDQ==
Date: Tue, 30 Dec 2025 13:56:42 +0100
Subject: [PATCH 1/2] kunit: tool: test: Rename test_data_path() to
 _test_data_path()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251230-kunit-pytest-v1-1-e2dae0dae200@linutronix.de>
References: <20251230-kunit-pytest-v1-0-e2dae0dae200@linutronix.de>
In-Reply-To: <20251230-kunit-pytest-v1-0-e2dae0dae200@linutronix.de>
To: Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767099404; l=11792;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=aQk/k+/jxY0Jhp4+7QkNzjn0JzS7X4QWMy9CY9djLN4=;
 b=1kAyn0QGgdTXt3N8usPJlBlx1x85It387ZrQiFKlgHcaQplpjt+cwMw9xUt4sKlRHT2KGY0yH
 nWdxBJkbQP8ARVEKHFZ8HL2pSKUqrSmIkYt0xQuewy+TAlELkMnYA3/
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Running the KUnit testsuite through pytest fails, as the function
test_data_path() is recognized as a test function. Its execution fails
as pytest tries to resolve the 'path' argument as a fixture which does
not exist.

Rename the function, so the helper function is not incorrectly
recognized as a test function.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/testing/kunit/kunit_tool_test.py | 54 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index bbba921e0eac..fd7ca89596c0 100755
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
 
 	def test_no_header(self):
-		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
+		empty_log = _test_data_path('test_is_test_passed-no_tests_run_no_header.log')
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -175,7 +175,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
 
 	def test_missing_test_plan(self):
-		missing_plan_log = test_data_path('test_is_test_passed-'
+		missing_plan_log = _test_data_path('test_is_test_passed-'
 			'missing_plan.log')
 		with open(missing_plan_log) as file:
 			result = kunit_parser.parse_run_tests(
@@ -186,7 +186,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 
 	def test_no_tests(self):
-		header_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
+		header_log = _test_data_path('test_is_test_passed-no_tests_run_with_header.log')
 		with open(header_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -195,7 +195,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
 
 	def test_no_tests_no_plan(self):
-		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
+		no_plan_log = _test_data_path('test_is_test_passed-no_tests_no_plan.log')
 		with open(no_plan_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -207,7 +207,7 @@ class KUnitParserTest(unittest.TestCase):
 
 
 	def test_no_kunit_output(self):
-		crash_log = test_data_path('test_insufficient_memory.log')
+		crash_log = _test_data_path('test_insufficient_memory.log')
 		print_mock = mock.patch('kunit_printer.Printer.print').start()
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
@@ -218,7 +218,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
 
 	def test_skipped_test(self):
-		skipped_log = test_data_path('test_skip_tests.log')
+		skipped_log = _test_data_path('test_skip_tests.log')
 		with open(skipped_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
@@ -227,7 +227,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=4, skipped=1))
 
 	def test_skipped_all_tests(self):
-		skipped_log = test_data_path('test_skip_all_tests.log')
+		skipped_log = _test_data_path('test_skip_all_tests.log')
 		with open(skipped_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
@@ -235,7 +235,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts, kunit_parser.TestCounts(skipped=5))
 
 	def test_ignores_hyphen(self):
-		hyphen_log = test_data_path('test_strip_hyphen.log')
+		hyphen_log = _test_data_path('test_strip_hyphen.log')
 		with open(hyphen_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 
@@ -249,7 +249,7 @@ class KUnitParserTest(unittest.TestCase):
 			result.subtests[1].name)
 
 	def test_ignores_prefix_printk_time(self):
-		prefix_log = test_data_path('test_config_printk_time.log')
+		prefix_log = _test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -257,7 +257,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_ignores_multiple_prefixes(self):
-		prefix_log = test_data_path('test_multiple_prefixes.log')
+		prefix_log = _test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -265,7 +265,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_prefix_mixed_kernel_output(self):
-		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
+		mixed_prefix_log = _test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -273,7 +273,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_prefix_poundsign(self):
-		pound_log = test_data_path('test_pound_sign.log')
+		pound_log = _test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -281,7 +281,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
 
 	def test_kernel_panic_end(self):
-		panic_log = test_data_path('test_kernel_panic_interrupt.log')
+		panic_log = _test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
@@ -289,7 +289,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertGreaterEqual(result.counts.errors, 1)
 
 	def test_pound_no_prefix(self):
-		pound_log = test_data_path('test_pound_no_prefix.log')
+		pound_log = _test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -318,7 +318,7 @@ class KUnitParserTest(unittest.TestCase):
 			'Failures: all_failed_suite, some_failed_suite.test2')
 
 	def test_ktap_format(self):
-		ktap_log = test_data_path('test_parse_ktap_output.log')
+		ktap_log = _test_data_path('test_parse_ktap_output.log')
 		with open(ktap_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3))
@@ -327,13 +327,13 @@ class KUnitParserTest(unittest.TestCase):
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
 
@@ -555,7 +555,7 @@ class KUnitJsonTest(unittest.TestCase):
 		self.addCleanup(mock.patch.stopall)
 
 	def _json_for(self, log_file):
-		with open(test_data_path(log_file)) as file:
+		with open(_test_data_path(log_file)) as file:
 			test_result = kunit_parser.parse_run_tests(file, stdout)
 			json_obj = kunit_json.get_json_result(
 				test=test_result,
@@ -596,7 +596,7 @@ class StrContains(str):
 
 class KUnitMainTest(unittest.TestCase):
 	def setUp(self):
-		path = test_data_path('test_is_test_passed-all_passed.log')
+		path = _test_data_path('test_is_test_passed-all_passed.log')
 		with open(path) as file:
 			all_passed_log = file.readlines()
 

-- 
2.52.0


