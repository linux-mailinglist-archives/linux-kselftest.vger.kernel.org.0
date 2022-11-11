Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5854662516D
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 04:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKKDTK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 22:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiKKDTK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 22:19:10 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 028EB4AF25
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 19:19:09 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id v18-20020a637a12000000b0046ed84b94efso1967773pgc.6
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 19:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=foIAt/XU3J4YtladZObByH9iI4esGYWbfPnco3Gtlh8=;
        b=DWw+ys9/MKUB3OxGlZx0Iw6WbQKNXkzY4m9MMOsvP3vZyq5Cx+1OyUQJgOrW9Sesxy
         vUHefMbhl3+Z9wMBF65/0Nbs7Q/pD2tO00AXUVxGyLJ4aP7i9/mRD/OKBJ64ZS//OSim
         NU6I62czrtHqu+WDtgP1KEsMdQ/6cv3+vyx46QjCf4gxR9VXaFQZ7nfrQyRgQj1FoFPo
         L2eXPM9NkbqjIdwgfEH4f6Zlsz1MG1IBiK/hAxSOzZboiIli7h2IWHyiRbTdEJ3nsoog
         zLbQSZR/DXEZofYHQoATjjzs0rJS2Otj6l7RNzIlYqWFmBZK/6sjwqcCMt6+I1LXOq1C
         VqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=foIAt/XU3J4YtladZObByH9iI4esGYWbfPnco3Gtlh8=;
        b=de6D42gGz67iLasCW6P3c3pGrGnuJwzThRHFOiOrZ9W7JIwbUwU3/+0uHDb26vHvII
         OGTiMfZW19pYIyHLlCwRfWQZtnc8xYBef78Q6HjWBBCOzzaMef7UP6A2rqe9L80jmpMn
         kUg0js7dF8lKo0ibtCyygYJ3ZxVUoP35BohlCGIU6/iy/m6ik3FyIrbWMHLpE9IgNM3d
         KAOCU59dRrKnx3XRNAZuDmbtC/g3eSWPgbvxJUK0UFxSNZWOg9uTxDDL3zHXGZ1yRIk0
         MEdNi3gg/uoTs57jX7NnudsJVQ0wK+czoyRUgmTfcdwt5SiI1WjKcFqMWd+OrlBrsogO
         R6Qg==
X-Gm-Message-State: ANoB5pmb6e3up/KE6BEVg67g82xBs2TobriUPkHU/pelIZYSvBffQtxS
        5vMe+S4h7emiNOJbbvRQMuG+mYZJ90AdxQ==
X-Google-Smtp-Source: AA0mqf47VP+wsHzGM8MLOSTnOnfeRzrOAe9St0LPMxr2gCgCXQNvuIGrPZMHM9E1cG1tGgWIhPf+hHgR3PE8PQ==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a62:e412:0:b0:56d:a1fc:7000 with SMTP id
 r18-20020a62e412000000b0056da1fc7000mr659752pfh.35.1668136748495; Thu, 10 Nov
 2022 19:19:08 -0800 (PST)
Date:   Thu, 10 Nov 2022 19:18:55 -0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111031855.592333-1-dlatypov@google.com>
Subject: [PATCH] kunit: tool: tweak error message when no KTAP found
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

We currently tell people we "couldn't find any KTAP output" with no
indication as to what this might mean.

After this patch, we get:

$ ./tools/testing/kunit/kunit.py parse /dev/null
============================================================
[ERROR] Test: <missing>: Could not find any KTAP output. Did any KUnit tests run?
============================================================
Testing complete. Ran 0 tests: errors: 1

Note: we could try and generate a more verbose message like
> Please check .kunit/test.log to see the raw kernel output.
or the like, but we'd need to know what the build dir was to know where
test.log actually lives.

This patch tries to make a more minimal improvement.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py    | 2 +-
 tools/testing/kunit/kunit_tool_test.py | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index a56c75a973b5..d0ed5dd5cfc4 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -782,7 +782,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	test = Test()
 	if not lines:
 		test.name = '<missing>'
-		test.add_error('could not find any KTAP output!')
+		test.add_error('Could not find any KTAP output. Did any KUnit tests run?')
 		test.status = TestStatus.FAILURE_TO_PARSE_TESTS
 	else:
 		test = parse_test(lines, 0, [])
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 90c65b072be9..84a08cf07242 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -207,7 +207,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(crash_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
+		print_mock.assert_any_call(StrContains('Could not find any KTAP output.'))
 		print_mock.stop()
 		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(result.counts.errors, 1)
@@ -588,7 +588,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(e.exception.code, 1)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
-		self.print_mock.assert_any_call(StrContains('could not find any KTAP output!'))
+		self.print_mock.assert_any_call(StrContains('Could not find any KTAP output.'))
 
 	def test_exec_no_tests(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])

base-commit: 870f63b7cd78d0055902d839a60408f7428b4e84
-- 
2.38.1.431.g37b22c650d-goog

