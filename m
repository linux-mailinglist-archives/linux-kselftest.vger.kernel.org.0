Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145032C92A9
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Dec 2020 00:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388865AbgK3Xd5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 30 Nov 2020 18:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388826AbgK3Xd5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 30 Nov 2020 18:33:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D3BC0613D6
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:33:10 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id i184so161645ybg.7
        for <linux-kselftest@vger.kernel.org>; Mon, 30 Nov 2020 15:33:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=0KYas3tPhykALeKTm8edVjXNVmbCSCmca7ClUP4eXMo=;
        b=uWrzZ3L5l8JGMxjpGqoOGQThfztMVVyio24+z4hyLineNn8Q3on23eMqPmHzL1+fE8
         tYzBsWHgd1RouAMkhoOV6C7Nz9R83Z57yADIdHzeJwHZ/zYB4/WjREPVvPWMeS20Qtjv
         9asL5BNi1fjvGH6ApGv0OruWB3PGUSnaYSe5fdImdElFR7lk59/2jvtq9QWnpK0/HL2Q
         piL4Uu9J1tkFPIlsQGt58rBARzjhDBKS35ULzwFqYVZOe8xvqjZy7AO27Wqjr+4nkzVx
         4IjVHn+SaaNyzgGM0vY1g+LKC7O0m+0uaJdVytvjkLEcWwbRKmg9/naa+IDfvq/AQ8gI
         biPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=0KYas3tPhykALeKTm8edVjXNVmbCSCmca7ClUP4eXMo=;
        b=S9fSH8hHp0CiXGxVhwu4fme6me363NY/hetlez92NPlSZJgwJfKOsQzAQxRMWNIYY/
         /1vSRy2aSd/kuiwgRNBVZygJNm21gI7+tL1XNPkcfE+opjsd5YHkePN18ael2xsdkS1T
         6yq6PXSGLNiGwH0P4YuNydUp1kxZfKtYs4xCZvYInFqgozaQaQFGjCv+zrOKdX7R01WI
         MonkPkruPw9sZhZ1U8m+RkHIZsfjKRhw3MOW4x4iRRN4C8LFvSLUdtTVMnH9t/1/tnMt
         09lVY3u+j1tnyvlW+rrushoLWVYp6Hy3HqDNTm3bTw7Td50xaCpYKW5QqYCU9zftCjJN
         sUJQ==
X-Gm-Message-State: AOAM533aDDNUDZmsp1qO8W12AxvYW7TR5/JCICGL8aisMeoOKEfFp/yR
        fd1hISpXT8WLJmSLeny9FQ6749PuJtUWJg==
X-Google-Smtp-Source: ABdhPJznJdjUXOSfNtQ53KVDEiGtw92OfprpN3x+DzArFxffCeEA8U78XywoW4Zcte/nnkxMKHZaqhSZ4+nsBw==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:390:: with SMTP id
 138mr30858438ybd.28.1606779190196; Mon, 30 Nov 2020 15:33:10 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:32:40 -0800
In-Reply-To: <20201130233242.78413-1-dlatypov@google.com>
Message-Id: <20201130233242.78413-3-dlatypov@google.com>
Mime-Version: 1.0
References: <20201130233242.78413-1-dlatypov@google.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
Subject: [PATCH 3/5] kunit: tool: stop using bare asserts in unit test
From:   Daniel Latypov <dlatypov@google.com>
To:     davidgow@google.com
Cc:     brendanhiggins@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use self.assertEqual/assertNotEqual() instead.
Besides being more appropriate in a unit test, it'll also give a better
error message by show the unexpected values.

Also
* Delete redundant check of exception types. self.assertRaises does this.
* s/kall/call. There's no reason to name it this way.
  * This is probably a misunderstanding from the docs which uses it
  since `mock.call` is in scope as `call`.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 50 +++++++++++++-------------
 1 file changed, 24 insertions(+), 26 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 9f1f1e1b772a..e527ce9d3295 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -308,26 +308,26 @@ class KUnitMainTest(KUnitTest):
 
 	def test_config_passes_args_pass(self):
 		kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 0
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 0
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
-		assert self.linux_source_mock.run_kernel.call_count == 0
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
 		kunit.main(['exec'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 0
-		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
 		kunit.main(['run'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			build_dir='.kunit', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
@@ -336,35 +336,33 @@ class KUnitMainTest(KUnitTest):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
 			kunit.main(['exec'], self.linux_source_mock)
-		assert type(e.exception) == SystemExit
-		assert e.exception.code == 1
+		self.assertEqual(e.exception.code, 1)
 
 	def test_run_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
 			kunit.main(['run'], self.linux_source_mock)
-		assert type(e.exception) == SystemExit
-		assert e.exception.code == 1
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.assertEqual(e.exception.code, 1)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
 
 	def test_exec_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		kunit.main(['exec', '--raw_output'], self.linux_source_mock)
-		assert self.linux_source_mock.run_kernel.call_count == 1
-		for kall in self.print_mock.call_args_list:
-			assert kall != mock.call(StrContains('Testing complete.'))
-			assert kall != mock.call(StrContains(' 0 tests run'))
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		for call in self.print_mock.call_args_list:
+			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		kunit.main(['run', '--raw_output'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
-		assert self.linux_source_mock.run_kernel.call_count == 1
-		for kall in self.print_mock.call_args_list:
-			assert kall != mock.call(StrContains('Testing complete.'))
-			assert kall != mock.call(StrContains(' 0 tests run'))
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
+		for call in self.print_mock.call_args_list:
+			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
+			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
 	def test_exec_timeout(self):
 		timeout = 3453
@@ -375,7 +373,7 @@ class KUnitMainTest(KUnitTest):
 	def test_run_timeout(self):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			build_dir='.kunit', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
@@ -383,7 +381,7 @@ class KUnitMainTest(KUnitTest):
 	def test_run_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
@@ -391,7 +389,7 @@ class KUnitMainTest(KUnitTest):
 	def test_config_builddir(self):
 		build_dir = '.kunit'
 		kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
-		assert self.linux_source_mock.build_reconfig.call_count == 1
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 
 	def test_build_builddir(self):
 		build_dir = '.kunit'
-- 
2.29.2.454.gaff20da3a2-goog

