Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF042CC646
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Dec 2020 20:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389529AbgLBTKZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Dec 2020 14:10:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387967AbgLBTKY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Dec 2020 14:10:24 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDD84C061A48
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Dec 2020 11:09:07 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id h189so2020640qke.19
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Dec 2020 11:09:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=XfUwdLBf1qrMT7Mo76z45utfEuCPvJ6tn0QOg+7yY44=;
        b=D4JV3G6WUyCqsuacWw8GzqoiJcY1MVj6QVkWwFtVrCC3HTiB5KarrybY9sxKABGm85
         LEvkzwkiGJUWx9ca0iAdCdwb4Yomi1qt8kfZMT9whlM1saWv/9oAhhyzP6vga5BX0Ii6
         qpmS3S0kJopMMZ9EoOxgOlfVwDhbZ/C0twzx2M/W3dqIduArX9ClzR/dTtU3GgtYXuQv
         DedoEPSAc0XrOlH8hGDjmUvGI7srBcn1okWbVn7AlRGdnpjnX8QMykUB3AgWRsnvdePZ
         0GPaMZ//LBGvgatvCF8Zrzn4sZ49yhJBSObtAGDeFymhqj6+oUMC4AxX1kgeKhnRfgRa
         wJYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=XfUwdLBf1qrMT7Mo76z45utfEuCPvJ6tn0QOg+7yY44=;
        b=Mljwn51r7Ia/loW+t1rhPK3ynxWudXqpuMYxY4saUPWVpesYOxPjG8AgY64sTSYMG0
         sSUnityTOU0e481nExed7jKFS/mVHJ/36ONq1vf0MRnfkL/J5MSgqKAAz13ngiPgLDdj
         v1A9J5B1LRQViP2AGU0plDN668tfQsDUwFzfy6PVHT6QMRwlwxo8WQoWUJ+TAlp8eS8c
         DWmu9RI9gdyPFkC+g9b/HzikW7Mav4s2UqyaO/JWli/by06Kukm4/kIdmSfA+C4Uya2x
         MkWwGgQC0dGeYdxbfsRLYhOS6TqrpnesoSfcUgzHZmh8nhi2+lzERpPixTjjS4lVN8yi
         0LdQ==
X-Gm-Message-State: AOAM531RyAkZX3mtkUNRBY83wdKt7xZkY3BaXuto7liHQRgaeIJP9maq
        pLgR64bQGZxjFEazMjkmsILJQH+X0wDA2w==
X-Google-Smtp-Source: ABdhPJxVEvgUcIFLR1PPQYBty2WAMvkxuvAvnow8NaiOjNi9FQ5ebQQ9Z/aJCsAgbs1yB1kFOS9kyv155dlBlw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a05:6214:18d0:: with SMTP id
 cy16mr3954245qvb.3.1606936146978; Wed, 02 Dec 2020 11:09:06 -0800 (PST)
Date:   Wed,  2 Dec 2020 11:08:24 -0800
In-Reply-To: <20201202190824.1309398-1-dlatypov@google.com>
Message-Id: <20201202190824.1309398-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20201202190824.1309398-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH v2 4/4] minor: kunit: tool: fix unit test so it can run from
 non-root dir
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Also take this time to rename get_absolute_path() to test_data_path().

1. the name is currently a lie. It gives relative paths, e.g. if I run
from the same dir as the test file, it gives './test_data/<file>'

See https://docs.python.org/3/reference/import.html#__file__, which
doesn't stipulate that implementations provide absolute paths.

2. it's only used for generating paths to tools/testing/kunit/test_data/
So we can tersen things by making it less general.

Cache the absolute path to the test data files per suggestion from  [1].
Using relative paths, the tests break because of this code in kunit.py
  if get_kernel_root_path():
  =C2=A0 =C2=A0 =C2=A0 =C2=A0 os.chdir(get_kernel_root_path())

[1] https://lore.kernel.org/linux-kselftest/CABVgOSnH0gz7z5JhRCGyG1wg0zDDBT=
LoSUCoB-gWMeXLgVTo2w@mail.gmail.com/

Fixes: 5578d008d9e0 ("kunit: tool: fix running kunit_tool from outside kern=
el tree")
Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 60 +++++++++++---------------
 1 file changed, 24 insertions(+), 36 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/k=
unit_tool_test.py
index cf160914bc55..1cd127b225a9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -21,16 +21,18 @@ import kunit_json
 import kunit
=20
 test_tmpdir =3D ''
+abs_test_data_dir =3D ''
=20
 def setUpModule():
-	global test_tmpdir
+	global test_tmpdir, abs_test_data_dir
 	test_tmpdir =3D tempfile.mkdtemp()
+	abs_test_data_dir =3D os.path.abspath(os.path.join(os.path.dirname(__file=
__), 'test_data'))
=20
 def tearDownModule():
 	shutil.rmtree(test_tmpdir)
=20
-def get_absolute_path(path):
-	return os.path.join(os.path.dirname(__file__), path)
+def test_data_path(path):
+	return os.path.join(abs_test_data_dir, path)
=20
 class KconfigTest(unittest.TestCase):
=20
@@ -46,8 +48,7 @@ class KconfigTest(unittest.TestCase):
=20
 	def test_read_from_file(self):
 		kconfig =3D kunit_config.Kconfig()
-		kconfig_path =3D get_absolute_path(
-			'test_data/test_read_from_file.kconfig')
+		kconfig_path =3D test_data_path('test_read_from_file.kconfig')
=20
 		kconfig.read_from_file(kconfig_path)
=20
@@ -98,8 +99,7 @@ class KUnitParserTest(unittest.TestCase):
 			str(needle) + '" not found in "' + str(haystack) + '"!')
=20
 	def test_output_isolated_correctly(self):
-		log_path =3D get_absolute_path(
-			'test_data/test_output_isolated_correctly.log')
+		log_path =3D test_data_path('test_output_isolated_correctly.log')
 		with open(log_path) as file:
 			result =3D kunit_parser.isolate_kunit_output(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -110,8 +110,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 1 - example', result)
=20
 	def test_output_with_prefix_isolated_correctly(self):
-		log_path =3D get_absolute_path(
-			'test_data/test_pound_sign.log')
+		log_path =3D test_data_path('test_pound_sign.log')
 		with open(log_path) as file:
 			result =3D kunit_parser.isolate_kunit_output(file.readlines())
 		self.assertContains('TAP version 14', result)
@@ -140,8 +139,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertContains('ok 3 - string-stream-test', result)
=20
 	def test_parse_successful_test_log(self):
-		all_passed_log =3D get_absolute_path(
-			'test_data/test_is_test_passed-all_passed.log')
+		all_passed_log =3D test_data_path('test_is_test_passed-all_passed.log')
 		with open(all_passed_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
@@ -149,8 +147,7 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
=20
 	def test_parse_failed_test_log(self):
-		failed_log =3D get_absolute_path(
-			'test_data/test_is_test_passed-failure.log')
+		failed_log =3D test_data_path('test_is_test_passed-failure.log')
 		with open(failed_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
@@ -158,8 +155,7 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
=20
 	def test_no_tests(self):
-		empty_log =3D get_absolute_path(
-			'test_data/test_is_test_passed-no_tests_run.log')
+		empty_log =3D test_data_path('test_is_test_passed-no_tests_run.log')
 		with open(empty_log) as file:
 			result =3D kunit_parser.parse_run_tests(
 				kunit_parser.isolate_kunit_output(file.readlines()))
@@ -169,8 +165,7 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
=20
 	def test_no_kunit_output(self):
-		crash_log =3D get_absolute_path(
-			'test_data/test_insufficient_memory.log')
+		crash_log =3D test_data_path('test_insufficient_memory.log')
 		print_mock =3D mock.patch('builtins.print').start()
 		with open(crash_log) as file:
 			result =3D kunit_parser.parse_run_tests(
@@ -180,8 +175,7 @@ class KUnitParserTest(unittest.TestCase):
 		file.close()
=20
 	def test_crashed_test(self):
-		crashed_log =3D get_absolute_path(
-			'test_data/test_is_test_passed-crash.log')
+		crashed_log =3D test_data_path('test_is_test_passed-crash.log')
 		with open(crashed_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual(
@@ -189,8 +183,7 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
=20
 	def test_ignores_prefix_printk_time(self):
-		prefix_log =3D get_absolute_path(
-			'test_data/test_config_printk_time.log')
+		prefix_log =3D test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -199,8 +192,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
=20
 	def test_ignores_multiple_prefixes(self):
-		prefix_log =3D get_absolute_path(
-			'test_data/test_multiple_prefixes.log')
+		prefix_log =3D test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -209,8 +201,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
=20
 	def test_prefix_mixed_kernel_output(self):
-		mixed_prefix_log =3D get_absolute_path(
-			'test_data/test_interrupted_tap_output.log')
+		mixed_prefix_log =3D test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -219,7 +210,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
=20
 	def test_prefix_poundsign(self):
-		pound_log =3D get_absolute_path('test_data/test_pound_sign.log')
+		pound_log =3D test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -228,7 +219,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
=20
 	def test_kernel_panic_end(self):
-		panic_log =3D get_absolute_path('test_data/test_kernel_panic_interrupt.l=
og')
+		panic_log =3D test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -237,7 +228,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual('kunit-resource-test', result.suites[0].name)
=20
 	def test_pound_no_prefix(self):
-		pound_log =3D get_absolute_path('test_data/test_pound_no_prefix.log')
+		pound_log =3D test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result =3D kunit_parser.parse_run_tests(file.readlines())
 			self.assertEqual(
@@ -248,7 +239,7 @@ class KUnitParserTest(unittest.TestCase):
 class KUnitJsonTest(unittest.TestCase):
=20
 	def _json_for(self, log_file):
-		with(open(get_absolute_path(log_file))) as file:
+		with open(test_data_path(log_file)) as file:
 			test_result =3D kunit_parser.parse_run_tests(file)
 			json_obj =3D kunit_json.get_json_result(
 				test_result=3Dtest_result,
@@ -258,22 +249,19 @@ class KUnitJsonTest(unittest.TestCase):
 		return json.loads(json_obj)
=20
 	def test_failed_test_json(self):
-		result =3D self._json_for(
-			'test_data/test_is_test_passed-failure.log')
+		result =3D self._json_for('test_is_test_passed-failure.log')
 		self.assertEqual(
 			{'name': 'example_simple_test', 'status': 'FAIL'},
 			result["sub_groups"][1]["test_cases"][0])
=20
 	def test_crashed_test_json(self):
-		result =3D self._json_for(
-			'test_data/test_is_test_passed-crash.log')
+		result =3D self._json_for('test_is_test_passed-crash.log')
 		self.assertEqual(
 			{'name': 'example_simple_test', 'status': 'ERROR'},
 			result["sub_groups"][1]["test_cases"][0])
=20
 	def test_no_tests_json(self):
-		result =3D self._json_for(
-			'test_data/test_is_test_passed-no_tests_run.log')
+		result =3D self._json_for('test_is_test_passed-no_tests_run.log')
 		self.assertEqual(0, len(result['sub_groups']))
=20
 class StrContains(str):
@@ -282,7 +270,7 @@ class StrContains(str):
=20
 class KUnitMainTest(unittest.TestCase):
 	def setUp(self):
-		path =3D get_absolute_path('test_data/test_is_test_passed-all_passed.log=
')
+		path =3D test_data_path('test_is_test_passed-all_passed.log')
 		with open(path) as file:
 			all_passed_log =3D file.readlines()
=20
--=20
2.29.2.576.ga3fc446d84-goog

