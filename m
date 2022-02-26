Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932704C5843
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 22:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiBZVYK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 26 Feb 2022 16:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbiBZVYJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 26 Feb 2022 16:24:09 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CC428F96F
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 13:23:33 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d61b4ef6cdso66124277b3.11
        for <linux-kselftest@vger.kernel.org>; Sat, 26 Feb 2022 13:23:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=J6j2inEmM2G/VjC4yVLo68KdKRLj/4RdQFdUNasgbc4=;
        b=p1UQxaHkIXrxFewg80mViEE+sNxpZrJ5BXIUBsMp5MBkAfULz3wEdzO1SWTfpqxAeb
         AovBR03HS/YvV8v59t+R4ro/HK1Lgb/A11zoIm2jVSKCJpk1Omff8DZdBVun3eNSh99P
         qiCP88AYXqZRg0F26UMFh6tFAqD0T9MKB9RM7BQSfgF135w2ToWvF/BiaNuKT/cJiHlb
         eVuWdEi7IHrmaSR0DHzYjNtCtM0wmSLwQ0MGU7BbIvYtJgYrgrzomRs5EKkfRLu2UoXC
         pJhBv0VrFeLJqqzrK2bfPLNZfkqayO7vj26sTHNFTTyV0ST1Hhk++WcAnCi0btUZA/km
         wXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=J6j2inEmM2G/VjC4yVLo68KdKRLj/4RdQFdUNasgbc4=;
        b=GXKYJ/Kl2So+5bFPxTk3zD66XCW7x1aalEeuGIQ39FWmrptc4EkAKvItvf+aSjfZYw
         22DZ9F3MCxc+k5lFKl/87zY9pFbGGbqPKN6Uhu9nCqrUE67NxAYpcD1zKJYImtMgLsCJ
         HaL8AgsVturBzDhTi+0bj67vQg/4nLIjOR8By+TIqz/EpByt9F+MRn316XWr9IsQLgaH
         5IpTdUefcD2/yMqTWuVwG1HjVPDI8Ry8JNowc98AyvqiqHtEdsH5TwUA/sULyi+Q21NL
         Os12lQeWqUotFH3kPdwGbDnL2AGI0LqVZOc4IPdqPPBlSXL/59byPcFC5FoZruZhGe/B
         wZjg==
X-Gm-Message-State: AOAM530U+RNjw/vgB2hK9tXvTuyODKiClfjU4AjlbFI64s97P7oPwdKD
        m2zyQvQBfQY6E2sqG2j8wdFfk7LK5RS5qw==
X-Google-Smtp-Source: ABdhPJx2ZmaY96X8Esy5Q6/6g/Hm/z+/jdCTYF1vj/idV3IZqOvcTd6IY6lC1+gMb6jOOMuBFGu2ezJ9MXER7A==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:3a80:7413:c995:5fb1])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:1027:b0:619:3e74:ab5b with SMTP
 id x7-20020a056902102700b006193e74ab5bmr13207007ybt.136.1645910613153; Sat,
 26 Feb 2022 13:23:33 -0800 (PST)
Date:   Sat, 26 Feb 2022 13:23:25 -0800
Message-Id: <20220226212325.2984807-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2] kunit: tool: more descriptive metavars/--help output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Before, our help output contained lines like
  --kconfig_add KCONFIG_ADD
  --qemu_config qemu_config
  --jobs jobs

They're not very helpful.

The former kind come from the automatic 'metavar' we get from argparse,
the uppercase version of the flag name.
The latter are where we manually specified metavar as the flag name.

After:
  --build_dir DIR
  --make_options X=Y
  --kunitconfig PATH
  --kconfig_add CONFIG_X=Y
  --arch ARCH
  --cross_compile PREFIX
  --qemu_config FILE
  --jobs N
  --timeout SECONDS
  --raw_output [{all,kunit}]
  --json [FILE]

This patch tries to make the code more clear by specifying the _type_ of
input we expect, e.g. --build_dir is a DIR, --qemu_config is a FILE.
I also switched it to uppercase since it looked more clearly like
placeholder text that way.

This patch also changes --raw_output to specify `choices` to make it
more clear what the options are, and this way argparse can validate it
for us, as shown by the added test case.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py           | 26 ++++++++++++--------------
 tools/testing/kunit/kunit_tool_test.py |  5 +++++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 9274c6355809..63d2c4bb9503 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -206,8 +206,6 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[
 			pass
 		elif request.raw_output == 'kunit':
 			output = kunit_parser.extract_tap_lines(output)
-		else:
-			print(f'Unknown --raw_output option "{request.raw_output}"', file=sys.stderr)
 		for line in output:
 			print(line.rstrip())
 
@@ -281,10 +279,10 @@ def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
 			    'directory.',
-			    type=str, default='.kunit', metavar='build_dir')
+			    type=str, default='.kunit', metavar='DIR')
 	parser.add_argument('--make_options',
 			    help='X=Y make option, can be repeated.',
-			    action='append')
+			    action='append', metavar='X=Y')
 	parser.add_argument('--alltests',
 			    help='Run all KUnit tests through allyesconfig',
 			    action='store_true')
@@ -292,11 +290,11 @@ def add_common_opts(parser) -> None:
 			     help='Path to Kconfig fragment that enables KUnit tests.'
 			     ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
 			     'will get  automatically appended.',
-			     metavar='kunitconfig')
+			     metavar='PATH')
 	parser.add_argument('--kconfig_add',
 			     help='Additional Kconfig options to append to the '
 			     '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
-			    action='append')
+			    action='append', metavar='CONFIG_X=Y')
 
 	parser.add_argument('--arch',
 			    help=('Specifies the architecture to run tests under. '
@@ -304,7 +302,7 @@ def add_common_opts(parser) -> None:
 				  'string passed to the ARCH make param, '
 				  'e.g. i386, x86_64, arm, um, etc. Non-UML '
 				  'architectures run on QEMU.'),
-			    type=str, default='um', metavar='arch')
+			    type=str, default='um', metavar='ARCH')
 
 	parser.add_argument('--cross_compile',
 			    help=('Sets make\'s CROSS_COMPILE variable; it should '
@@ -316,18 +314,18 @@ def add_common_opts(parser) -> None:
 				  'if you have downloaded the microblaze toolchain '
 				  'from the 0-day website to a directory in your '
 				  'home directory called `toolchains`).'),
-			    metavar='cross_compile')
+			    metavar='PREFIX')
 
 	parser.add_argument('--qemu_config',
 			    help=('Takes a path to a path to a file containing '
 				  'a QemuArchParams object.'),
-			    type=str, metavar='qemu_config')
+			    type=str, metavar='FILE')
 
 def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
-			    type=int, default=get_default_jobs(), metavar='jobs')
+			    type=int, default=get_default_jobs(), metavar='N')
 
 def add_exec_opts(parser) -> None:
 	parser.add_argument('--timeout',
@@ -336,7 +334,7 @@ def add_exec_opts(parser) -> None:
 			    'tests.',
 			    type=int,
 			    default=300,
-			    metavar='timeout')
+			    metavar='SECONDS')
 	parser.add_argument('filter_glob',
 			    help='Filter which KUnit test suites/tests run at '
 			    'boot-time, e.g. list* or list*.*del_test',
@@ -346,7 +344,7 @@ def add_exec_opts(parser) -> None:
 			    metavar='filter_glob')
 	parser.add_argument('--kernel_args',
 			    help='Kernel command-line parameters. Maybe be repeated',
-			     action='append')
+			     action='append', metavar='')
 	parser.add_argument('--run_isolated', help='If set, boot the kernel for each '
 			    'individual suite/test. This is can be useful for debugging '
 			    'a non-hermetic test, one that might pass/fail based on '
@@ -357,13 +355,13 @@ def add_exec_opts(parser) -> None:
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
 			    'If set to --raw_output=kunit, filters to just KUnit output.',
-			    type=str, nargs='?', const='all', default=None)
+			     type=str, nargs='?', const='all', default=None, choices=['all', 'kunit'])
 	parser.add_argument('--json',
 			    nargs='?',
 			    help='Stores test results in a JSON, and either '
 			    'prints to stdout or saves to file if a '
 			    'filename is specified',
-			    type=str, const='stdout', default=None)
+			    type=str, const='stdout', default=None, metavar='FILE')
 
 def main(argv, linux=None):
 	parser = argparse.ArgumentParser(
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 352369dffbd9..eb2011d12c78 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -595,6 +595,11 @@ class KUnitMainTest(unittest.TestCase):
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
 			self.assertNotEqual(call, mock.call(StrContains(' 0 tests run')))
 
+	def test_run_raw_output_invalid(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		with self.assertRaises(SystemExit) as e:
+			kunit.main(['run', '--raw_output=invalid'], self.linux_source_mock)
+
 	def test_run_raw_output_does_not_take_positional_args(self):
 		# --raw_output is a string flag, but we don't want it to consume
 		# any positional arguments, only ones after an '='

base-commit: 5debe5bfa02c4c8922bd2d0f82c9c3a70bec8944
-- 
2.35.1.574.g5d30c73bfb-goog

