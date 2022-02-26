Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8015F4C5390
	for <lists+linux-kselftest@lfdr.de>; Sat, 26 Feb 2022 04:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbiBZDbh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 25 Feb 2022 22:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiBZDbh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 25 Feb 2022 22:31:37 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4412BA9C5
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 19:31:00 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b11-20020a5b008b000000b00624ea481d55so5334510ybp.19
        for <linux-kselftest@vger.kernel.org>; Fri, 25 Feb 2022 19:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=j2FdqvAg92mVH36PVc9Yu0hrEVjIPnTLS+qsjkQt3KE=;
        b=fuVz7mV5xAXXD+5JGzAYynY/Zshh0GrWZ8jjkAA1KHrjpdhfQaKgvci2uB02UC4Pj6
         fljJiUpSshQy/otqthaW29j7OHv5AC1jk57WUz/G7BZhIbtpplCoTIYLZTwD42bGZgEb
         3Gr+r4RmRs8qyZzmTaBPq/VqIsdhPVyiRB1BOGpTJpN6N4pKgocG454B+lKe/OZ1HilZ
         LjawccxaerKNoLZ/cGh1pbfVfBcIzoEm6bAUIJX49OCBEoW9VkJ4LxFc8eenn8bO1P7c
         ExyRMNANz5KZ5a4u7w4Tb1a1bS7GEYpjOK2z1SwVyWVBadDsaTLSQgW5LjvKzif3jqMK
         N1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=j2FdqvAg92mVH36PVc9Yu0hrEVjIPnTLS+qsjkQt3KE=;
        b=YZ2pcSNsZxWrtq19RLh0SDgDF2YS6lvazjEt510ZaiaBnPWLsFeRXe0EZbJFp+mnaR
         IsFDLmli1bUxTGamcVXQRV+93E6BxcI2nfx5FdCVKu4bNLS8hs/N4XmVvwBKR421MIsy
         K94i9nyS3oNF37lz9rMFjfubo65nklUHd+g+XW1jwS15EZRemPEVSUnxBDH/0ZFd1N73
         YGVYfki+N0Qwv1gz5HLO2PxdjAldwgVEll09dBeRwACiCF++aSyz9i3GO+/W0TDKtsCo
         Z9+nW2rO4B2kzHQ2iUDSg5QXhHtjLonqps4nnH/ScnykWDCLP+oDsGOV4qTfFZ4yGINA
         vfeA==
X-Gm-Message-State: AOAM533LB/I4clv1LbX0aWVdytKRx/4MZV8VTPg2cWZ0vQiIOARbrphy
        V6LwKNgcg680tKQ3ccnrqkzpVr9IdNH+VA==
X-Google-Smtp-Source: ABdhPJx7iXHxivoUPHylbghOBIuZVmV9V4rUGyQyl/RajkfqalR+hZ4N3/z3SlcGs3Uqyq29jXNI287buN2pUg==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:3f24:7bc4:da33:c93e])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:1007:b0:622:9e94:4df8 with SMTP
 id w7-20020a056902100700b006229e944df8mr9956691ybt.315.1645846259422; Fri, 25
 Feb 2022 19:30:59 -0800 (PST)
Date:   Fri, 25 Feb 2022 19:30:54 -0800
Message-Id: <20220226033054.2860933-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH] kunit: tool: more descriptive metavars/--help output
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
the uppsercase version of the flag name.
The latter are where we manually specified metavar as the flag name.

After:
  --build_dir DIR
  --make_options X=Y
  --kunitconfig KUNITCONFIG
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
---
 tools/testing/kunit/kunit.py           | 26 ++++++++++++--------------
 tools/testing/kunit/kunit_tool_test.py |  5 +++++
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 9274c6355809..566404f5e42a 100755
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
+			     metavar='KUNITCONFIG')
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

