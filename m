Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99CD2C92B0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 00:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbgK3XeT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 18:34:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388945AbgK3XeS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 18:34:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC98BC061A04
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:33:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id u37so137355ybi.15
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iVfC7CXfzzWY2c3nxjQ95SBnfThb5LdHUv97Cb716JQ=;
        b=LwffgpbLmDvXPKj9JQ/iLtSDqUyT25tNrUl0UD+DapAPc/7RUXisuPvHI/JanAJ+q8
         /lSHHhxuWCFBeFVGen2pk2QoDNVmm2xAulg3RQdiLwIa/ztaU2efYnt/EXCvDH7mO9Hj
         Onxvq3IRjZn4rzif43KM/PB0ABXE3qOr/UDUhUBD9BlpLtAmbp8Fhforv7QdP1QP9ogB
         +SVl0nJuFugdf0mGt2o0zoVEck/e8iX6ACdusbr3tk7kgDTohuHkPuerHnCtgN1cIYEA
         eeG7UMIcxkMnkW8v0hL9x76XUs26gc3pdHOJOChCEv6qcDMxtC5LH7EEbgI2mxITPNnG
         Sehg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iVfC7CXfzzWY2c3nxjQ95SBnfThb5LdHUv97Cb716JQ=;
        b=b0oz+DMivBAUF1SLRDk3ov/Uk3gCg9XNLCHps5FSvxmkX94MhP0o6FHja8luoElCZM
         pmtW5Q3x1kzFJ58xoFHo9oaynKPQYs33BuKQrQ20PDEHA1D3HxtGcxuuhaaCxY2oRFce
         pWCVzBkWtLXzV3EjjWLnjTRDRtfpaGsKHu/Cqfrlr4yatT8ClD6ldvXSfkNSs+ATB15a
         uKqnnFMrfn7hSYrPvT1D1dleuyrsWbRfI92qi+1jSU8oGuVkX/ftlmMioE9wf6lMTu+0
         JajG0qLJezv0tRRJGZBF8DsQtEPOf+BgeYwca/Sq4qwcL3vtHhTuOZncYckO2diT54oN
         FkGA==
X-Gm-Message-State: AOAM533NNSgGVXfVB5pHkTS71Aw26p3kbOnapxbvKedmy+IzKjaNVETo
        hXkeoPvz/2Xgs5Fm5JENMD8AfEW7H6Yjug==
X-Google-Smtp-Source: ABdhPJwXgJSsoGTEu58lnkEBF5v9/GrYMHY3lTxuvByMkr+Ycm+3v1l92oE76H77kFU9pkVlq2K8EXIKlqujEw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:c010:: with SMTP id
 c16mr25433504ybf.142.1606779193971; Mon, 30 Nov 2020 15:33:13 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:32:41 -0800
In-Reply-To: <20201130233242.78413-1-dlatypov@google.com>
Message-Id: <20201130233242.78413-4-dlatypov@google.com>
Mime-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 4/5] kunit: tool: use `with open()` in unit test
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
index e527ce9d3295..f2c12d96caa1 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -106,15 +106,14 @@ class KUnitParserTest(KUnitTest):
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
@@ -149,42 +148,39 @@ class KUnitParserTest(KUnitTest):
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
@@ -192,12 +188,11 @@ class KUnitParserTest(KUnitTest):
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
2.29.2.454.gaff20da3a2-goog

