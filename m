Return-Path: <linux-kselftest+bounces-48362-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84C97CFBA55
	for <lists+linux-kselftest@lfdr.de>; Wed, 07 Jan 2026 03:01:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 17829303524F
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jan 2026 01:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8723645D;
	Wed,  7 Jan 2026 01:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wGkcpozI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9D7235358
	for <linux-kselftest@vger.kernel.org>; Wed,  7 Jan 2026 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767751181; cv=none; b=XRUVMam0PRomXwP4z2T5RKMRaq05cUoHy3W3cDZryZR67499ylmz1Sla99NnNHE4chwbLhouQ+WtXCksX9gSmJnC+BINlUU0h7QdW/4aRzwWlXSfWoXlcuqFQchDDW2/I2WO07chXu+MOgMmcrbthU31u+8jr5yGNsWZFPHJuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767751181; c=relaxed/simple;
	bh=t4buKnNQwsxPy2MTy5wlU9u5anWs334IMI90CN2l4JY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=T97Vrhv5yuG/jIdmeKTHg98wP2dri5RszpVRYs0cirn7hlJsy/ZRQNwa3RHGMiMHGJQpPxFfI/nW3vTv8FLD2isUZI0/PI9bhQGwo8AKAPTqUPHQAxd3TvxAdQENymxORjwFtvWuQKRm4Arr1jgJblXe1uJWI9hvLfINdpmxSBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wGkcpozI; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7b6b194cf71so2429965b3a.3
        for <linux-kselftest@vger.kernel.org>; Tue, 06 Jan 2026 17:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767751179; x=1768355979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tYskBwTQMpFafWJZwtpgwewaptxdyWbgvR6qD16sOjQ=;
        b=wGkcpozIZIOK4pARF2SnFtEPmRTB7BRzoBu2QrVKojtg5ZSTfvyGFHx4Cmpiyw2UV3
         gvnVAv78y3ZT3QnQBUvBrBl4zNtjn7t62tkg/BN+VuJHxhDl5U1tyaWGYBqQglGz+TEt
         X0pwNVmN4tPz33Ad63FWPWBlp5X1uRLpbvBCMwhN2VY63h6Jj8pVmVxLo/zmPJio5s/5
         c39whpfLbqnFUBlEukvlcNz024UNc6M9iIRDoyTvba/PnAJXeXFQvjbvQ31n/pnC7YL7
         46tgRbURnmTmXQMfg67lloxQLjMyYuEjs0+4IbmAiLGkvYJR1FRoka+SUUZZJlUbUhgG
         NxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767751179; x=1768355979;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tYskBwTQMpFafWJZwtpgwewaptxdyWbgvR6qD16sOjQ=;
        b=gV+h5q0fzpkV8WhDaOyYQnsncMM63vqOe6wWpsMGMQWHJPIq7OCvZyE3do1BqH5DzH
         ByfHoEwvvEtfrLor2BtjP+sOKtIdeopT46X1YGvKY5vfiuPBjIpWB4Wd/JDX3iZbGQcL
         D5rq4C9njraz5jxprEy1lHA11w+4yXG75gNxps3RNEKSDEXsRzKXz05dK+UBKu8x6/XV
         LVhP7vF7bwgs4VMLQx1fanX8vJDmy9xxsLopcCzy1H/LE8xfSMpvff/bdL6PhFUuLLZw
         PLZYBVuGn1MugUOaTFUPUxf6Hvgo1jBKIOJTR5jZT0Ci8b3V673SoOlDFMC3PNc58go8
         aoZA==
X-Gm-Message-State: AOJu0Yyrh9eMgAqfOo5mOuiEhke1BiFPTBdG+vHcSisSY7bzXXDed/MT
	TlORhLGTr0KKobeOErj6HdJc8haiOb0F/fafVZ75xBP2ym3PDTzpjqwl0NVd7Z3ruajALPdD5T6
	0txWnONCtsd71/g==
X-Google-Smtp-Source: AGHT+IGXTs7zvEEarvnBDDl9tIEUAb/fBPf/lrWFpbcyHdIue/lhFNNH+wJ2jUs2VTI5Wo7wL3pPeBD5TmO6sw==
X-Received: from pfbfj18.prod.google.com ([2002:a05:6a00:3a12:b0:800:bf04:ffb1])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1d90:b0:7e8:4471:ae60 with SMTP id d2e1a72fcca58-81b7f6e21demr762580b3a.44.1767751179291;
 Tue, 06 Jan 2026 17:59:39 -0800 (PST)
Date: Wed,  7 Jan 2026 09:59:33 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260107015936.2316047-1-davidgow@google.com>
Subject: [PATCH v2 1/2] kunit: tool: test: Rename test_data_path() to _test_data_path()
From: David Gow <davidgow@google.com>
To: shuah@kernel.org, 
	"=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?=" <thomas.weissschuh@linutronix.de>, 
	Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <raemoar63@gmail.com>
Cc: linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>

Running the KUnit testsuite through pytest fails, as the function
test_data_path() is recognized as a test function. Its execution fails
as pytest tries to resolve the 'path' argument as a fixture which does
not exist.

Rename the function, so the helper function is not incorrectly
recognized as a test function.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Reviewed-by: David Gow <davidgow@google.com>
Signed-off-by: David Gow <davidgow@google.com>
---

Changes since v1:
https://lore.kernel.org/linux-kselftest/20251230-kunit-pytest-v1-1-e2dae0da=
e200@linutronix.de/
 - Rebase on top of "kunit: tool: Add test for nested test result
   reporting"
   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.gi=
t/commit/?h=3Dkunit&id=3D0c5b86c67fb6898d02c8f92de884186297fd302f

---
 tools/testing/kunit/kunit_tool_test.py | 56 +++++++++++++-------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/k=
unit_tool_test.py
index bdc51b5c7b10..30ac1cb6c8ed 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -36,7 +36,7 @@ def setUpModule():
 def tearDownModule():
 	shutil.rmtree(test_tmpdir)
=20
-def test_data_path(path):
+def _test_data_path(path):
 	return os.path.join(abs_test_data_dir, path)
=20
 class KconfigTest(unittest.TestCase):
@@ -52,7 +52,7 @@ class KconfigTest(unittest.TestCase):
 		self.assertFalse(kconfig1.is_subset_of(kconfig0))
=20
 	def test_read_from_file(self):
-		kconfig_path =3D test_data_path('test_read_from_file.kconfig')
+		kconfig_path =3D _test_data_path('test_read_from_file.kconfig')
=20
 		kconfig =3D kunit_config.parse_file(kconfig_path)
=20
@@ -98,7 +98,7 @@ class KUnitParserTest(unittest.TestCase):
 		raise AssertionError(f'"{needle}" not found in {list(backup)}!')
=20
 	def test_output_isolated_correctly(self):
-		log_path =3D test_data_path('test_output_isolated_correctly.log')
+		log_path =3D _test_data_path('test_output_isolated_correctly.log')
 		with open(log_path) as file:
 			result =3D kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -109,7 +109,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 1 - example', result)
=20
 	def test_output_with_prefix_isolated_correctly(self):
-		log_path =3D test_data_path('test_pound_sign.log')
+		log_path =3D _test_data_path('test_pound_sign.log')
 		with open(log_path) as file:
 			result =3D kunit_parser.extract_tap_lines(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -138,35 +138,35 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 3 - string-stream-test', result)
=20
 	def test_parse_successful_test_log(self):
-		all_passed_log =3D test_data_path('test_is_test_passed-all_passed.log')
+		all_passed_log =3D _test_data_path('test_is_test_passed-all_passed.log')
 		with open(all_passed_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
=20
 	def test_parse_successful_nested_tests_log(self):
-		all_passed_log =3D test_data_path('test_is_test_passed-all_passed_nested=
.log')
+		all_passed_log =3D _test_data_path('test_is_test_passed-all_passed_neste=
d.log')
 		with open(all_passed_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
=20
 	def test_kselftest_nested(self):
-		kselftest_log =3D test_data_path('test_is_test_passed-kselftest.log')
+		kselftest_log =3D _test_data_path('test_is_test_passed-kselftest.log')
 		with open(kselftest_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(result.counts.errors, 0)
=20
 	def test_parse_failed_test_log(self):
-		failed_log =3D test_data_path('test_is_test_passed-failure.log')
+		failed_log =3D _test_data_path('test_is_test_passed-failure.log')
 		with open(failed_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
 		self.assertEqual(result.counts.errors, 0)
=20
 	def test_parse_failed_nested_tests_log(self):
-		nested_log =3D test_data_path('test_is_test_passed-failure-nested.log')
+		nested_log =3D _test_data_path('test_is_test_passed-failure-nested.log')
 		with open(nested_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
@@ -177,7 +177,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.subtests[1].sub=
tests[0].status)
=20
 	def test_no_header(self):
-		empty_log =3D test_data_path('test_is_test_passed-no_tests_run_no_header=
.log')
+		empty_log =3D _test_data_path('test_is_test_passed-no_tests_run_no_heade=
r.log')
 		with open(empty_log) as file:
 			result =3D kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -186,7 +186,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
=20
 	def test_missing_test_plan(self):
-		missing_plan_log =3D test_data_path('test_is_test_passed-'
+		missing_plan_log =3D _test_data_path('test_is_test_passed-'
 			'missing_plan.log')
 		with open(missing_plan_log) as file:
 			result =3D kunit_parser.parse_run_tests(
@@ -197,7 +197,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
=20
 	def test_no_tests(self):
-		header_log =3D test_data_path('test_is_test_passed-no_tests_run_with_hea=
der.log')
+		header_log =3D _test_data_path('test_is_test_passed-no_tests_run_with_he=
ader.log')
 		with open(header_log) as file:
 			result =3D kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -206,7 +206,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
=20
 	def test_no_tests_no_plan(self):
-		no_plan_log =3D test_data_path('test_is_test_passed-no_tests_no_plan.log=
')
+		no_plan_log =3D _test_data_path('test_is_test_passed-no_tests_no_plan.lo=
g')
 		with open(no_plan_log) as file:
 			result =3D kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()), stdout)
@@ -218,7 +218,7 @@ class KUnitParserTest(unittest.TestCase):
=20
=20
 	def test_no_kunit_output(self):
-		crash_log =3D test_data_path('test_insufficient_memory.log')
+		crash_log =3D _test_data_path('test_insufficient_memory.log')
 		print_mock =3D mock.patch('kunit_printer.Printer.print').start()
 		with open(crash_log) as file:
 			result =3D kunit_parser.parse_run_tests(
@@ -229,7 +229,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 1)
=20
 	def test_skipped_test(self):
-		skipped_log =3D test_data_path('test_skip_tests.log')
+		skipped_log =3D _test_data_path('test_skip_tests.log')
 		with open(skipped_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
=20
@@ -238,7 +238,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3D4, skip=
ped=3D1))
=20
 	def test_skipped_all_tests(self):
-		skipped_log =3D test_data_path('test_skip_all_tests.log')
+		skipped_log =3D _test_data_path('test_skip_all_tests.log')
 		with open(skipped_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
=20
@@ -246,7 +246,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts, kunit_parser.TestCounts(skipped=3D5))
=20
 	def test_ignores_hyphen(self):
-		hyphen_log =3D test_data_path('test_strip_hyphen.log')
+		hyphen_log =3D _test_data_path('test_strip_hyphen.log')
 		with open(hyphen_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
=20
@@ -260,7 +260,7 @@ class KUnitParserTest(unittest.TestCase):
 			result.subtests[1].name)
=20
 	def test_ignores_prefix_printk_time(self):
-		prefix_log =3D test_data_path('test_config_printk_time.log')
+		prefix_log =3D _test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -268,7 +268,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
=20
 	def test_ignores_multiple_prefixes(self):
-		prefix_log =3D test_data_path('test_multiple_prefixes.log')
+		prefix_log =3D _test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -276,7 +276,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
=20
 	def test_prefix_mixed_kernel_output(self):
-		mixed_prefix_log =3D test_data_path('test_interrupted_tap_output.log')
+		mixed_prefix_log =3D _test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -284,7 +284,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
=20
 	def test_prefix_poundsign(self):
-		pound_log =3D test_data_path('test_pound_sign.log')
+		pound_log =3D _test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -292,7 +292,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(result.counts.errors, 0)
=20
 	def test_kernel_panic_end(self):
-		panic_log =3D test_data_path('test_kernel_panic_interrupt.log')
+		panic_log =3D _test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
@@ -300,7 +300,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertGreaterEqual(result.counts.errors, 1)
=20
 	def test_pound_no_prefix(self):
-		pound_log =3D test_data_path('test_pound_no_prefix.log')
+		pound_log =3D _test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
@@ -329,7 +329,7 @@ class KUnitParserTest(unittest.TestCase):
 			'Failures: all_failed_suite, some_failed_suite.test2')
=20
 	def test_ktap_format(self):
-		ktap_log =3D test_data_path('test_parse_ktap_output.log')
+		ktap_log =3D _test_data_path('test_parse_ktap_output.log')
 		with open(ktap_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=3D3))
@@ -338,13 +338,13 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual('case_2', result.subtests[0].subtests[1].name)
=20
 	def test_parse_subtest_header(self):
-		ktap_log =3D test_data_path('test_parse_subtest_header.log')
+		ktap_log =3D _test_data_path('test_parse_subtest_header.log')
 		with open(ktap_log) as file:
 			kunit_parser.parse_run_tests(file.readlines(), stdout)
 		self.print_mock.assert_any_call(StrContains('suite (1 subtest)'))
=20
 	def test_parse_attributes(self):
-		ktap_log =3D test_data_path('test_parse_attributes.log')
+		ktap_log =3D _test_data_path('test_parse_attributes.log')
 		with open(ktap_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines(), stdout)
=20
@@ -566,7 +566,7 @@ class KUnitJsonTest(unittest.TestCase):
 		self.addCleanup(mock.patch.stopall)
=20
 	def _json_for(self, log_file):
-		with open(test_data_path(log_file)) as file:
+		with open(_test_data_path(log_file)) as file:
 			test_result =3D kunit_parser.parse_run_tests(file, stdout)
 			json_obj =3D kunit_json.get_json_result(
 				test=3Dtest_result,
@@ -607,7 +607,7 @@ class StrContains(str):
=20
 class KUnitMainTest(unittest.TestCase):
 	def setUp(self):
-		path =3D test_data_path('test_is_test_passed-all_passed.log')
+		path =3D _test_data_path('test_is_test_passed-all_passed.log')
 		with open(path) as file:
 			all_passed_log =3D file.readlines()
=20
--=20
2.52.0.351.gbe84eed79e-goog


