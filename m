Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA8021FEC4
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jul 2020 22:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbgGNUln (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Jul 2020 16:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727104AbgGNUll (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Jul 2020 16:41:41 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C9CC061755
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 13:41:41 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id n32so13209397pgb.22
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Jul 2020 13:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6s+MXnvd3oZrHD1TWsZDFjEGlJK3au/LhRDIVmT50mg=;
        b=GSTmdPmZs5/LuQS+PqoOMDxWmVCXOYNaPR0TT0mmTF3Cn4HxGa4a2g15XgvJGe02D1
         N36LC5t8VLDWbjMIAyqQOB2xbnvpkdHoU/yhc+NqUoVxl0rK+h/pDQjGbIWn1qaeUV9T
         ymE/p+Tg4/Qb1kTQt7Ga33WAxrsA0qutY5MLeffP03E9QFFTBmWRSoZQTaDl+Zi21dAQ
         /3L1oq4o8N+LfGMVK19VPsJQ7qSAO7T8f+5J0yITXEb4xrVpItGDtvxOalsLEeTAp7BB
         3cOyxAXiMXfiRfltwNzvQMqsQjjfCTzD+Nn16pbOF6H06ESJTjETootvdO8gHoKxVX7u
         rpTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6s+MXnvd3oZrHD1TWsZDFjEGlJK3au/LhRDIVmT50mg=;
        b=V+LLVqW72y8mUpOC5Vs2jkDcAPbt/S4z5GzbTB9XDR9ssV6jcxmo04knmDqL0AK+El
         6AJqwZ6lpnFe2/CB6niQ5QnEsZZG7APsKn8ToMWieSTc+pJnzqboOoAE2IpmiVXVgu1n
         KkarwjF2HFgghLbjr2t2g+lvKvQgpUxy6vXuqTPX6UlDQm1+Q2Q21nU9cFRlTOt8tQcJ
         SAG6IMYwfZceOOsVyZGeSbQmYckw9wVBmDRvLT30Pd2TunxwBTZbT9sPs8hoUPsZZi7E
         QivEVRei3AA/f9FWDsxZAB504TWn5/BTBQxEo8pPvzfpYADULKNWDm/np/8bNSaK+OM5
         6WRw==
X-Gm-Message-State: AOAM533O7tHJrF8XbMNABGZYceThL5Dt2+v+K0R8TzZKoayrHMfqEsIE
        K/bsKOEoEeRO6FOppnRY4GDlHdnjNCQd6hU7j2AEjQ==
X-Google-Smtp-Source: ABdhPJy1xaopIsv9GnReFpKEXHapYr4apuN7LZkkOxgiLsmHv25JyILfxJ5xfbB9S0anhxhhkiXVGim/7x7t0OkqdnN8vw==
X-Received: by 2002:a17:90a:2465:: with SMTP id h92mr6080491pje.26.1594759300840;
 Tue, 14 Jul 2020 13:41:40 -0700 (PDT)
Date:   Tue, 14 Jul 2020 13:41:30 -0700
In-Reply-To: <20200714204130.54729-1-brendanhiggins@google.com>
Message-Id: <20200714204130.54729-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200714204130.54729-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.27.0.389.gc38d7665816-goog
Subject: [PATCH v1 2/2] kunit: tool: fix improper treatment of file location
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

Commits 01397e822af4 ("kunit: Fix TabError, remove defconfig code and
handle when there is no kunitconfig") and 45ba7a893ad8 ("kunit:
kunit_tool: Separate out config/build/exec/parse") introduced two
closely related issues which built off of each other: they excessively
created the build directory when not present and modified a constant
(constants in Python only exist by convention).

Together these issues broken a number of unit tests for KUnit tool, so
fix them.

Fixes: 01397e822af4 ("kunit: Fix TabError, remove defconfig code and handle when there is no kunitconfig")
Fixes: 45ba7a893ad8 ("kunit: kunit_tool: Separate out config/build/exec/parse")
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py           | 24 ------------------------
 tools/testing/kunit/kunit_tool_test.py |  4 ++--
 2 files changed, 2 insertions(+), 26 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index f9b769f3437dd..425ef40067e7e 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -240,12 +240,6 @@ def main(argv, linux=None):
 	if cli_args.subcommand == 'run':
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
-		kunit_kernel.kunitconfig_path = os.path.join(
-			cli_args.build_dir,
-			kunit_kernel.kunitconfig_path)
-
-		if not os.path.exists(kunit_kernel.kunitconfig_path):
-			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -263,12 +257,6 @@ def main(argv, linux=None):
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
-				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
-
-		if not os.path.exists(kunit_kernel.kunitconfig_path):
-			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -285,12 +273,6 @@ def main(argv, linux=None):
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
-				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
-
-		if not os.path.exists(kunit_kernel.kunitconfig_path):
-			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -309,12 +291,6 @@ def main(argv, linux=None):
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
-			kunit_kernel.kunitconfig_path = os.path.join(
-				cli_args.build_dir,
-				kunit_kernel.kunitconfig_path)
-
-		if not os.path.exists(kunit_kernel.kunitconfig_path):
-			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index ee942d80bdd02..287c74d821c33 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -251,7 +251,7 @@ class KUnitMainTest(unittest.TestCase):
 		pass
 
 	def test_config_passes_args_pass(self):
-		kunit.main(['config'], self.linux_source_mock)
+		kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 0
 
@@ -326,7 +326,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_builddir(self):
 		build_dir = '.kunit'
-		kunit.main(['run', '--build_dir', build_dir], self.linux_source_mock)
+		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			build_dir=build_dir, timeout=300)
-- 
2.27.0.389.gc38d7665816-goog

