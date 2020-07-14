Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40921FEC2
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 22:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgGNUlk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 16:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgGNUlj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 16:41:39 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9982BC061755
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 13:41:39 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id k1so13929308qko.14
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 13:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rJt5ovSTMz7G2VZjYNzh69nF3iFTY3dkO7HTEhyGrdo=;
        b=Zy1V71plqmAkPYMcUoLCETjZ4SBhTvXoo7im64OokW04LYUIsyrJt69U1FcJndkP3x
         0AoBKi2urhNe8IcN7fd7chmUIK5jFz6jyT2axji+O3l31gFM/os6kADVzlahumEuzN4Y
         aC+qSRCxoRsqUGkvsYgK2AE0yLgb3YlxE5DDUJyjief+rOOdpwK7NU3xcHZKzHY9gOPO
         NvmTppsjOcm28PMXJCtdpqyLPCZEYyfoENj5wJ4AUQDlCpggfx/chuh2rfPKfq51MVyp
         dDZiiqnUbdX81UNi82/+ND9BjimZognIzNk5YM4EaR6/XbKAAwsF+krL68ZJ1W++Lo5A
         iGEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rJt5ovSTMz7G2VZjYNzh69nF3iFTY3dkO7HTEhyGrdo=;
        b=IVwq45kK0DnMAbUN0H327oeVMjODxNqb2lj8zSiSMlXr5yy4XZRT203GUaeDCY4nLQ
         2zMv/0yzjqEg5G8oK/xCvFjVdCTWC1IPlqGuglabkYb8aL8pRh3qnMcUEkNeuCz6rmCD
         hIeXCJ/5JsDsuM4pOPYugELYVgw2PK2u6LfNfDqHpzPzJ2biNvHPe8kkdchQac0El5Pp
         ZVAo5lIySn5CMKQuubCr+DpSv1ghmLeMAGpLRWN3wLGbqjwd7p39M0MCzwS60ibpgOzU
         mtb4Xw9ofa/kCUNhCxRpOzIPztktbp8F8l35/mCWkRVHd7iONGAzd1IH260QahOmN/OZ
         jIlg==
X-Gm-Message-State: AOAM530uF3IdEs2Oz88QpnxzNgfK59AB77t/gFkJ+bgJC5nnCl4PgmdT
        cNBa3qDVQIyNhID9zmpzw68AW1mBksPQR5M/XC/twA==
X-Google-Smtp-Source: ABdhPJzdC1TQxJrTIZOZxQTLrI6CP3Ilr7aTn18Y6mWGirKrbLsVH6XhwZY9qWBUkPUaN346rev2NIN1dB4OyP/Kkus44A==
X-Received: by 2002:a05:6214:108c:: with SMTP id o12mr6465155qvr.168.1594759298801;
 Tue, 14 Jul 2020 13:41:38 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:41:29 -0700
In-Reply-To: <20200714204130.54729-1-brendanhiggins@google.com>
Message-Id: <20200714204130.54729-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200714204130.54729-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH v1 1/2] kunit: tool: fix broken default args in unit tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com, vitor@massaru.org
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Commit ddbd60c779b4 ("kunit: use --build_dir=.kunit as default") changed
the default build directory for KUnit tests, but failed to update
associated unit tests for kunit_tool, so update them.

Fixes: ddbd60c779b4 ("kunit: use --build_dir=.kunit as default")
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit_tool_test.py | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index f9eeaea94cad1..ee942d80bdd02 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -258,14 +258,14 @@ class KUnitMainTest(unittest.TestCase):
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 0
-		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '', None)
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '.kunit', None)
 		assert self.linux_source_mock.run_kernel.call_count == 0
 
 	def test_exec_passes_args_pass(self):
 		kunit.main(['exec'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 0
 		assert self.linux_source_mock.run_kernel.call_count == 1
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
@@ -273,7 +273,7 @@ class KUnitMainTest(unittest.TestCase):
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='', timeout=300)
+			build_dir='.kunit', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_exec_passes_args_fail(self):
@@ -313,7 +313,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
-		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='.kunit', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
@@ -321,7 +321,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			build_dir='', timeout=timeout)
+			build_dir='.kunit', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
-- 
2.27.0.389.gc38d7665816-goog

