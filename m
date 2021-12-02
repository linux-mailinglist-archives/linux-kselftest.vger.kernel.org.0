Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073A9466AFA
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 21:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348881AbhLBUmy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 2 Dec 2021 15:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348876AbhLBUmx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 2 Dec 2021 15:42:53 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E896FC061757
        for <linux-kselftest@vger.kernel.org>; Thu,  2 Dec 2021 12:39:30 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id r15-20020a63ec4f000000b002e582189837so507602pgj.20
        for <linux-kselftest@vger.kernel.org>; Thu, 02 Dec 2021 12:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1bBCoVC9S/+TW6ndTgS5qlZLYuJcP1k4XxUAjFSU+s8=;
        b=tAjj5diUhuSTD+4soSUzE+A+CPb64SeadEyY+LE141q4tuLlG+WutJ07plrrfhT9vn
         /B5d0BAp1T24/kRj9sP5vx+YSN1NTbQ+gwusMr/msAGLjMdwjm6rvQ6iXSqM90bfhGuM
         DDaG41Ye4GOoKVDFmUagMy9wdZLtGzKQl4tO2yrL7MJOxFWUC8xIl3vPS1FXahBAS31Z
         Car8pkQh+YIC3b01ma14y8s/AD8IsVhdkAjeePESJOqU3nUds/sGYnNhXDuc/JE5z9S5
         054j4JMyavbzEQ4qtU6nVJcZCEn/A6u6DRv7CanBmavN8TzOMa1Wnet5pXWUj0Bvy1Bw
         pSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1bBCoVC9S/+TW6ndTgS5qlZLYuJcP1k4XxUAjFSU+s8=;
        b=rSMDCVCBGI1nerUJIF1PxkCOvEMLB4zmeNqjlnVJMGu4uS53kMdwM2/tgRcjQ+lwdk
         hnH0G92xEhb7LTVqSRa04KyxRHcdYZeEWReOVffzuZsGgnWmDDuUPC3pdclj1q+JWb/o
         tMR79SRN5J/2//lrqtc/EZq6OymMWQ3OOAqLQxclrQ1PYg3Giyv6FKcR1601o8aE6Pvx
         fpY5fCrHa5L604ovpyyibP4d6zHeMvucHPyfhi059zH7awKzuhQsJbU/aKyYzBlGEMFt
         cfBJstEeD2HHn9yyLJ401E4OQKo/ngE7wx5g+eG5ahoM3HsUaxwXeDYTPELgiZN4MI2p
         N4kQ==
X-Gm-Message-State: AOAM533V8HDyg045YZqqGu0sxGohE1GjfnPfjb/36GgVPtbHffhxh6Jo
        WhBtq0kZNIvUsINRm6HpxgT5xijdG37pxQ==
X-Google-Smtp-Source: ABdhPJzL0BiPEBT2jAysbk5eYIZN8aFgygrLnN9kluCV/05L3Mvhp0uwtZ6mYCmzijLabi2Rmp1HB5kJq8lfPA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:20b0:7fea:c512:7f65])
 (user=dlatypov job=sendgmr) by 2002:a17:90b:38c1:: with SMTP id
 nn1mr8603752pjb.91.1638477570307; Thu, 02 Dec 2021 12:39:30 -0800 (PST)
Date:   Thu,  2 Dec 2021 12:39:27 -0800
Message-Id: <20211202203927.2004527-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.384.gca35af8252-goog
Subject: [PATCH] kunit: tool: make `build` subcommand also reconfigure if needed
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
---
Note: this patch depends on https://lore.kernel.org/linux-kselftest/20211009015406.1311319-1-dlatypov@google.com/
That patch simplifies all these functions by reducing the amount of
boilerplate needed to convert between XXXRequest types.

But we can rewrite this so it doesn't have that dep at the cost of
the patch becoming more verbose.
---
 tools/testing/kunit/kunit.py           | 10 +++++++++-
 tools/testing/kunit/kunit_tool_test.py |  2 +-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 367e29d6942b..99068532485d 100755
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
@@ -451,7 +459,7 @@ def main(argv, linux=None):
 					    make_options=cli_args.make_options,
 					    jobs=cli_args.jobs,
 					    alltests=cli_args.alltests)
-		result = build_tests(linux, request)
+		result = config_and_build_tests(linux, request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
 				result.elapsed_time))
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 178321d1f190..43ced874d5ad 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -418,7 +418,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
-		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
-- 
2.34.0.384.gca35af8252-goog

