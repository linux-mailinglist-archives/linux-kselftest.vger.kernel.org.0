Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06206616988
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Nov 2022 17:45:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231186AbiKBQo5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Nov 2022 12:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiKBQoj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Nov 2022 12:44:39 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9609B10B5
        for <linux-kselftest@vger.kernel.org>; Wed,  2 Nov 2022 09:40:43 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id x11-20020a056a000bcb00b0056c6ec11eefso9347399pfu.14
        for <linux-kselftest@vger.kernel.org>; Wed, 02 Nov 2022 09:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KIew2SL18zFJ6u7nCVq8c3JgfzFW65AAtUvUlav4Acg=;
        b=airvtcUYcZZ8MHdLIhi3pbgBZi6gh+e7/dZtX9JFrnv3hRtBujUKQyyGPN5qk0Y8nt
         phFxU+70nNgIiGjKiWMhXn7b5yoptQzXEk/ouwpXGh75dSrNYJZOiKAWOP5BemNzSyOb
         Tdm7veavPLEGXo+SKLYqgOFO2HTT3xiaufEW51KFiU/3PveV9Ab3/jCb/8ZXNnG8ZvPO
         fqZoPNkoOLVgF7ooqKPcI7pY/L+91nIxxuC+u6uuAIZT3uXaxqRhc1/TtxEUpufDFc7D
         SdR6pl37Hb2iD4VJQ/Xc/ZkU02fVDASFIoCgeLGeG0hmO67+MmID9x2/2hIDUMztta0u
         2K6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KIew2SL18zFJ6u7nCVq8c3JgfzFW65AAtUvUlav4Acg=;
        b=biBT/VVTixiSyc/3oLSZS0/B2VJdsYkrt0OgddO5X9ALXfKjuY28+Vq+XeNux3IZX+
         7Pk4Qxqy1shzmJCIPK/2gFdEhRRNg8Vrxo8YA2Dw8QtV/r/CPELCxGTA4ov074Avt5YO
         GgJJ2aLLKlAZrA20N8R8uCD+ZJHckeEPioHh60ZYUPgAyUym/s8Ft9UwFRVcnIvE7129
         qrXNya+xxtgxZrRWzspvKPbLQEjZ+C32lHey+Z/gJlgKvdEV+3ecpil5ecqSBYI4nPbY
         kRHZiQG6UE+QcuLrIvezRzHgq/u8xzMDlD3phjqEITSWBSk2GNe/HaXteeu4+FRWcomN
         osPg==
X-Gm-Message-State: ACrzQf00FdEogso2vjLE4ycmo/soc3wd3HBjXmG5+wCpELlIjGv5ZbFC
        MS+zBzeYbuOIdhTaIcatxLB8m/gUZD77JA==
X-Google-Smtp-Source: AMsMyM7x+8G0NGet5ElLFPpgVE1ZOycEBuAmGNMhefOHK43o90KXXvGE2DRmoND9PgyrSrJYcU9JTQaesGRpgQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:1bc1:b0:213:e2af:b1f4 with SMTP
 id oa1-20020a17090b1bc100b00213e2afb1f4mr17299469pjb.47.1667407243096; Wed,
 02 Nov 2022 09:40:43 -0700 (PDT)
Date:   Wed,  2 Nov 2022 09:40:04 -0700
In-Reply-To: <20221102164005.2516646-1-dlatypov@google.com>
Mime-Version: 1.0
References: <20221102164005.2516646-1-dlatypov@google.com>
X-Mailer: git-send-email 2.38.1.273.g43a17bfeac-goog
Message-ID: <20221102164005.2516646-2-dlatypov@google.com>
Subject: [PATCH 2/3] kunit: tool: unit tests all check parser errors,
 standardize formatting a bit
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's verify that the parser isn't reporting any errors for valid
inputs.

This change also
* does result.status checking on one line
* makes sure we consistently do it outside of the `with` block

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 93 +++++++++++---------------
 1 file changed, 38 insertions(+), 55 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 9fa4babb2506..0063773c0fc4 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -133,33 +133,29 @@ class KUnitParserTest(unittest.TestCase):
 		all_passed_log = test_data_path('test_is_test_passed-all_passed.log')
 		with open(all_passed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_successful_nested_tests_log(self):
 		all_passed_log = test_data_path('test_is_test_passed-all_passed_nested.log')
 		with open(all_passed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_kselftest_nested(self):
 		kselftest_log = test_data_path('test_is_test_passed-kselftest.log')
 		with open(kselftest_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_parse_failed_test_log(self):
 		failed_log = test_data_path('test_is_test_passed-failure.log')
 		with open(failed_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-		self.assertEqual(
-			kunit_parser.TestStatus.FAILURE,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE, result.status)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_no_header(self):
 		empty_log = test_data_path('test_is_test_passed-no_tests_run_no_header.log')
@@ -167,9 +163,8 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
 		self.assertEqual(0, len(result.subtests))
-		self.assertEqual(
-			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS, result.status)
+		self.assertEqual(result.counts.errors, 1)
 
 	def test_missing_test_plan(self):
 		missing_plan_log = test_data_path('test_is_test_passed-'
@@ -180,9 +175,7 @@ class KUnitParserTest(unittest.TestCase):
 				file.readlines()))
 		# A missing test plan is not an error.
 		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 
 	def test_no_tests(self):
 		header_log = test_data_path('test_is_test_passed-no_tests_run_with_header.log')
@@ -190,9 +183,8 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
 		self.assertEqual(0, len(result.subtests))
-		self.assertEqual(
-			kunit_parser.TestStatus.NO_TESTS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.NO_TESTS, result.status)
+		self.assertEqual(result.counts.errors, 1)
 
 	def test_no_tests_no_plan(self):
 		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
@@ -203,7 +195,7 @@ class KUnitParserTest(unittest.TestCase):
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.subtests[0].subtests[0].status)
-		self.assertEqual(1, result.counts.errors)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=1, errors=1))
 
 
 	def test_no_kunit_output(self):
@@ -215,6 +207,7 @@ class KUnitParserTest(unittest.TestCase):
 		print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
 		print_mock.stop()
 		self.assertEqual(0, len(result.subtests))
+		self.assertEqual(result.counts.errors, 1)
 
 	def test_skipped_test(self):
 		skipped_log = test_data_path('test_skip_tests.log')
@@ -222,18 +215,16 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(file.readlines())
 
 		# A skipped test does not fail the whole suite.
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=4, skipped=1))
 
 	def test_skipped_all_tests(self):
 		skipped_log = test_data_path('test_skip_all_tests.log')
 		with open(skipped_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
 
-		self.assertEqual(
-			kunit_parser.TestStatus.SKIPPED,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SKIPPED, result.status)
+		self.assertEqual(result.counts, kunit_parser.TestCounts(skipped=5))
 
 	def test_ignores_hyphen(self):
 		hyphen_log = test_data_path('test_strip_hyphen.log')
@@ -241,9 +232,7 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(file.readlines())
 
 		# A skipped test does not fail the whole suite.
-		self.assertEqual(
-			kunit_parser.TestStatus.SUCCESS,
-			result.status)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
 		self.assertEqual(
 			"sysctl_test",
 			result.subtests[0].name)
@@ -257,55 +246,49 @@ class KUnitParserTest(unittest.TestCase):
 		prefix_log = test_data_path('test_config_printk_time.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
 		with open(prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
 		with open(mixed_prefix_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
 		with open(panic_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.TEST_CRASHED,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.TEST_CRASHED, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertGreaterEqual(result.counts.errors, 1)
 
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
 		with open(pound_log) as file:
 			result = kunit_parser.parse_run_tests(file.readlines())
-			self.assertEqual(
-				kunit_parser.TestStatus.SUCCESS,
-				result.status)
-			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(kunit_parser.TestStatus.SUCCESS, result.status)
+		self.assertEqual('kunit-resource-test', result.subtests[0].name)
+		self.assertEqual(result.counts.errors, 0)
 
 def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
 	return kunit_parser.LineStream(enumerate(strs, start=1))
-- 
2.38.1.273.g43a17bfeac-goog

