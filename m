Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11DAD474BE5
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 20:30:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237419AbhLNTaP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 14:30:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237414AbhLNTaP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 14:30:15 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A62C06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:30:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j18-20020a258152000000b006000d292a42so38580490ybm.0
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=xA9ZRDld2H7cpZwQWYc0HcmPZG4csb1ONfd+ykfascA=;
        b=DSfGI8UT02mPuL1C9GmsKqwJR9Ygm/IPzVQUBpsFDvpn53S2CRNAMxqxgVu0YS2q7m
         D8RN1Uk8eDa2+j/kndZjoQBUtqN4Mt1ON27JsvYrFukOm9RWfnrUICexhc65aT+hcgrB
         WMDTL/G32AKt9KqpWI/GLNMSLU7yKN3JAZhN45L+QsrPPOvL9+GPqt9mF04C4nj7t1/t
         Qu3Im7d9CQC5dJ8JQwyJ4dyIPihg7Ae6DdjvTa42FCjE5m/q+XQoXNyv4IFvDuMHfHLK
         mmox3Usy3QGegxmrGf+Me6M5a+qY/cJOBwQrsm5dBD1gwUGLgTCnY/wKrti57fHBiMcn
         Cd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=xA9ZRDld2H7cpZwQWYc0HcmPZG4csb1ONfd+ykfascA=;
        b=QrkUQtCQe4Ug8Y0nxymtsuk/sNxZTN7RN/cWky0HDqXAQPhsY9PGGlW2RSeJGGiSJA
         Z/HsYQu4bNqZnVLUBWac3HGko0ZVJDJBp2EXSYVMZecCEaKnVyp1/uX3+wF4kvnZFEib
         TLvVZ9I0VlG7i1teQVFaP4fqf5RtrYMNNvxxLOPR6l9n9Lq5nhzzENZc94h5aa4ZGy0D
         FeE9kSss/CZ5jH58GBmfYcrHvi248VAuLd5kgBCbVdyhd2QLcQ3YZTByDRt/2Xd1XM7e
         qqVrYBfD5t5Xqh3ZgLH6IpVCNPAXw+ZYA4j7nh1RzyKU9tkdr3uJ2coIBOtOb+O2O7bg
         hv7Q==
X-Gm-Message-State: AOAM530J/xyQKynJGuv0IXIM1Skl8YB5WSJ7cYqB+o+1fOvL8EUBXAUm
        a23mSsudrTgv4J7BZNjRAqMbmIAmUFD1Jw==
X-Google-Smtp-Source: ABdhPJw5igwMsciDdHmsV7ZDp+IrFr3EUJbzzIsMlzPLmw8vnwMAypHTENvD7Zr+iHWe7UHIc/uJnYzRdyTQcA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a10:bb1b:63e:864a])
 (user=dlatypov job=sendgmr) by 2002:a25:2405:: with SMTP id
 k5mr1025330ybk.593.1639510214155; Tue, 14 Dec 2021 11:30:14 -0800 (PST)
Date:   Tue, 14 Dec 2021 11:30:10 -0800
Message-Id: <20211214193010.138458-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2] kunit: tool: make `build` subcommand also reconfigure if needed
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

If I created a kunitconfig file that was incomplete, then
$ ./tools/testing/kunit/kunit.py build --kunitconfig=my_kunitconfig
would silently drop all the options with unmet dependencies!

This is because it doesn't do the config check that `kunit.py config`
does.

So if I want to safely build a kernel for testing, I have to do
$ ./tools/testing/kunit/kunit.py config <flags>
$ ./tools/testing/kunit/kunit.py build <flags, again>

It seems unlikely that any user of kunit.py would want the current
`build` semantics.
So make it effectively do `kunit.py config` + `kunit.py build`.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: rebase on top of v2 of dependency:
https://lore.kernel.org/linux-kselftest/20211214192612.134306-1-dlatypov@google.com/
---
 tools/testing/kunit/kunit.py           | 10 +++++++++-
 tools/testing/kunit/kunit_tool_test.py |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 417dc2d11f4f..f1be71811369 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -110,6 +110,14 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 			   'built kernel successfully',
 			   build_end - build_start)
 
+def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
+			   request: KunitBuildRequest) -> KunitResult:
+	config_result = config_tests(linux, request)
+	if config_result.status != KunitStatus.SUCCESS:
+		return config_result
+
+	return build_tests(linux, request)
+
 def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
 	args = ['kunit.action=list']
 	if request.kernel_args:
@@ -464,7 +472,7 @@ def main(argv, linux=None):
 					    make_options=cli_args.make_options,
 					    jobs=cli_args.jobs,
 					    alltests=cli_args.alltests)
-		result = build_tests(linux, request)
+		result = config_and_build_tests(linux, request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
 				result.elapsed_time))
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 1f6b177ca5c2..b80e333a20cb 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -526,7 +526,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
-		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
-- 
2.34.1.173.g76aa8bc2d0-goog

