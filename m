Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B7E41B9EF
	for <lists+linux-kselftest@lfdr.de>; Wed, 29 Sep 2021 00:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbhI1WNA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 28 Sep 2021 18:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242622AbhI1WNA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 28 Sep 2021 18:13:00 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50519C06161C
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 15:11:20 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id s10-20020a05621406aa00b003821a333809so995938qvz.21
        for <linux-kselftest@vger.kernel.org>; Tue, 28 Sep 2021 15:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AA3FVIYg28Rh8YuKmqQIoWirPPhEH21EZnU/cofDuqI=;
        b=kHQlxJCABAgZLXFar97YajNky4s9fdSksbKk3IrLXdMhmXQKeQTaGHcCt8JUjASeBk
         TZSZaKsCTY1XQElJ6Q80Nc1n9u5mevlf7HerY8VViSoB9p63BvBE2fMC0HVhCYOj/HJ9
         7brGfuHri3cnE4Dm5+JHftz/1x1feLOEKaFs25BotYF+bxh5lqkMeqXxf9OZQpEAWZg6
         5z8Y3MGR0O3gWslyPknPniXJMiFTXEBNI6ONTbwdgwDh/mgy3g+ptY9g+5gqkmtD2h5N
         XsSsqSKQiAFqffG+QLfeFPgYJUzHG1AXVzYi6T0ffpTX6hvupN5Oqi0itYiu/jl+yuCu
         XdGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AA3FVIYg28Rh8YuKmqQIoWirPPhEH21EZnU/cofDuqI=;
        b=0d7k837F2a5L40vkOmZtLBL2pCN8A/i5HBGPTEaorSt+jKdrHPtLLc3LJwiy4s/NjV
         xe4LphP0r6hyOaGAWuIh6JFas88W0HRmeHro89fUVrvW0uUNYjrsrBryZOSmIDuYy8hB
         nHtwydBDDmw36C297dvyS0lYMG2FK67VLa4zC2nR6WIynHUdPDAyz29csQh+iC6Zrx9+
         jzP7OzfOD1+7gHRQfsqjy7MFVqjHdNnBWbjZfWYkyL4/jathV3jB3dDQkPre2cr8AMd+
         CRjciexjoGdGY2SbqjPEorbqzwVBCoqDe38XBD+JStiwExhR1Ebq5Etzy/PT+dnfcRrI
         8Tug==
X-Gm-Message-State: AOAM532iZQDspEXspBEQnoTazpAlPMn7XSJPFTfJee457gLWeDcWavyp
        nuQ3CzvvhIi/n3AyuliBG3/5F3ZQsVsWcA==
X-Google-Smtp-Source: ABdhPJwSn2knIg8LG9EJni5ZYxD2VCNt282Jn8lBQxcDI3skZXcJT0MQX34+UqVF5VPkLWxfONcQC7SFWfNYhQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:981c:22f3:3855:9bb7])
 (user=dlatypov job=sendgmr) by 2002:a0c:aac2:: with SMTP id
 g2mr7953361qvb.41.1632867079508; Tue, 28 Sep 2021 15:11:19 -0700 (PDT)
Date:   Tue, 28 Sep 2021 15:11:11 -0700
Message-Id: <20210928221111.1162779-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH] kunit: tool: misc fixes (unused vars, imports, leaked files)
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Drop some variables in unit tests that were unused and/or add assertions
based on them.

For ExitStack, it was imported, but the `es` variable wasn't used so it
didn't do anything, and we were leaking the file objects.
Refactor it to just use nested `with` statements to properly close them.

And drop the direct use of .close() on file objects in the kunit tool
unit test, as these can be leaked if test assertions fail.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           |  1 -
 tools/testing/kunit/kunit_kernel.py    | 12 ++++--------
 tools/testing/kunit/kunit_tool_test.py | 18 ++++++++----------
 3 files changed, 12 insertions(+), 19 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 66f67af97971..1b2b7f06bb8c 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -18,7 +18,6 @@ from collections import namedtuple
 from enum import Enum, auto
 from typing import Iterable
 
-import kunit_config
 import kunit_json
 import kunit_kernel
 import kunit_parser
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 2c6f916ccbaf..1870e75ff153 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -14,10 +14,6 @@ import shutil
 import signal
 from typing import Iterator, Optional, Tuple
 
-from contextlib import ExitStack
-
-from collections import namedtuple
-
 import kunit_config
 import kunit_parser
 import qemu_config
@@ -168,10 +164,10 @@ class LinuxSourceTreeOperationsUml(LinuxSourceTreeOperations):
 		process.wait()
 		kunit_parser.print_with_timestamp(
 			'Disabling broken configs to run KUnit tests...')
-		with ExitStack() as es:
-			config = open(get_kconfig_path(build_dir), 'a')
-			disable = open(BROKEN_ALLCONFIG_PATH, 'r').read()
-			config.write(disable)
+
+		with open(get_kconfig_path(build_dir), 'a') as config:
+			with open(BROKEN_ALLCONFIG_PATH, 'r') as disable:
+				config.write(disable.read())
 		kunit_parser.print_with_timestamp(
 			'Starting Kernel with all configs takes a few minutes...')
 
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 619c4554cbff..cad37a98e599 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -185,7 +185,7 @@ class KUnitParserTest(unittest.TestCase):
 				kunit_parser.extract_tap_lines(file.readlines()))
 		print_mock.assert_any_call(StrContains('could not parse test results!'))
 		print_mock.stop()
-		file.close()
+		self.assertEqual(0, len(result.suites))
 
 	def test_crashed_test(self):
 		crashed_log = test_data_path('test_is_test_passed-crash.log')
@@ -197,24 +197,22 @@ class KUnitParserTest(unittest.TestCase):
 
 	def test_skipped_test(self):
 		skipped_log = test_data_path('test_skip_tests.log')
-		file = open(skipped_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(skipped_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 
 		# A skipped test does not fail the whole suite.
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
-		file.close()
 
 	def test_skipped_all_tests(self):
 		skipped_log = test_data_path('test_skip_all_tests.log')
-		file = open(skipped_log)
-		result = kunit_parser.parse_run_tests(file.readlines())
+		with open(skipped_log) as file:
+			result = kunit_parser.parse_run_tests(file.readlines())
 
 		self.assertEqual(
 			kunit_parser.TestStatus.SKIPPED,
 			result.status)
-		file.close()
 
 
 	def test_ignores_prefix_printk_time(self):
@@ -283,13 +281,13 @@ class LinuxSourceTreeTest(unittest.TestCase):
 
 	def test_valid_kunitconfig(self):
 		with tempfile.NamedTemporaryFile('wt') as kunitconfig:
-			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
+			kunit_kernel.LinuxSourceTree('', kunitconfig_path=kunitconfig.name)
 
 	def test_dir_kunitconfig(self):
 		with tempfile.TemporaryDirectory('') as dir:
-			with open(os.path.join(dir, '.kunitconfig'), 'w') as f:
+			with open(os.path.join(dir, '.kunitconfig'), 'w'):
 				pass
-			tree = kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
+			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 
 	# TODO: add more test cases.
 

base-commit: 3b29021ddd10cfb6b2565c623595bd3b02036f33
-- 
2.33.0.685.g46640cef36-goog

