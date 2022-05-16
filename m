Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93802528F35
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 May 2022 21:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236653AbiEPTxS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 May 2022 15:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348054AbiEPTwi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 May 2022 15:52:38 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9D542ECB
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 12:48:14 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id f6-20020a170902ab8600b0015f186a69e7so8503403plr.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 May 2022 12:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7zxkc5ZXExRsw2+htaBLaHICt2hKO01Qx7emNNIuPE0=;
        b=WjNwvg62TXvaMOE3bJ3rVJRZqhLuj4FN2JiSrbyDgPKxQm0Z5/Zfo09Si3yiNsbr7w
         fvMNxbeF+qScnuYTamACHMeCLcn2I1ZhJL3zwn584F92egbFP+M+/iI91+78Qxs+G+KN
         gIUwtOjWOfk5LRjil5DZXu/ZWc0Bny4kNCcUo0pE1C7BbUlKlLwyP5ayoAR88VEWwA6Z
         7QjHyPLsdbVVhQ+rDfaPrJrZB+3rQMNSVOcZqum+/oSPXKx8V20GHxehDI/7lUyLGnWM
         MJjpcmsFEXyN9gYQwkztG57Oy+bdjLIaKayZxlNdeqyPFpkfuAxF60X7wMaoEbm/SThU
         flrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7zxkc5ZXExRsw2+htaBLaHICt2hKO01Qx7emNNIuPE0=;
        b=A8Ge2CQJZ7E7YtWnglq+622JRCemgZm1GGtTgTIDanCWSDcXK0KwhZWfQUJgt4NGdN
         3u8QA32mKD54qFnmBaXaOmnoVG8M+kW2RXZOfEAvVOn/SNFERmD86JS90NJG4zlDXgpa
         wHHw5+ATTRCx5vPDY4aKZGNJHLKXvsTzmCyigwfu/rRCY5AiNhLv9Ek82bTZHHg7Auch
         z7A98oV6Tmd0AywWsM7QGw396kXu3ui4KmM0+XZXNTUyS+/5TOIchZzQlYOpbONm04F3
         dmoTKmjap5hXRC+vJgfT0AwEUrvTRGFbnIjSt/PW0xVfEKf7UJmsvKBtmjLiexAb+chW
         LEdg==
X-Gm-Message-State: AOAM532T2NA03V5O6qe420osjQGqp+Ctf4LZ9IQrzn69vmzxRCzNgMFy
        d+CDg2JzB7vi1N1ZsertXMDX/+Bo9avnhQ==
X-Google-Smtp-Source: ABdhPJzsv0ZSkVGrhs01PhuMYzcc4fjoIMDaCDa/ta9nFEchQcxe8TTwNYD1/jAHfoxtJmb9D8mOM6DFYi9s/w==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:8f91:3848:5672:cb59])
 (user=dlatypov job=sendgmr) by 2002:a05:6a00:1146:b0:4c9:ede0:725a with SMTP
 id b6-20020a056a00114600b004c9ede0725amr18914364pfm.35.1652730490733; Mon, 16
 May 2022 12:48:10 -0700 (PDT)
Date:   Mon, 16 May 2022 12:47:29 -0700
In-Reply-To: <20220516194730.1546328-1-dlatypov@google.com>
Message-Id: <20220516194730.1546328-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220516194730.1546328-1-dlatypov@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [PATCH 2/3] kunit: tool: redo how we construct and mock LinuxSourceTree
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

Our main function currently has an optional `linux` argument which is
used to by our unit tests to inject a mock.
We currently have the same code copy-pasted several times to do
  if not linux:
    linux = MakeRealInstance(cli_args.foo, cli_args.bar, ...)

But in python, dependency injection isn't necessary or idiomatic when we
can just use mock.patch() to mock things out.

This change
1. adds a helper to create a LinuxSourceTree from the cli_args
2. drops the `linux` parameter in favor of mocking the __init__ func.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           |  49 ++++--------
 tools/testing/kunit/kunit_tool_test.py | 103 ++++++++++++-------------
 2 files changed, 65 insertions(+), 87 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 13bd72e47da8..8a90d80ee66e 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -365,7 +365,18 @@ def add_parse_opts(parser) -> None:
 			    'filename is specified',
 			    type=str, const='stdout', default=None, metavar='FILE')
 
-def main(argv, linux=None):
+
+def tree_from_args(cli_args: argparse.Namespace) -> kunit_kernel.LinuxSourceTree:
+	"""Returns a LinuxSourceTree based on the user's arguments."""
+	return kunit_kernel.LinuxSourceTree(cli_args.build_dir,
+			kunitconfig_path=cli_args.kunitconfig,
+			kconfig_add=cli_args.kconfig_add,
+			arch=cli_args.arch,
+			cross_compile=cli_args.cross_compile,
+			qemu_config_path=cli_args.qemu_config)
+
+
+def main(argv):
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
@@ -412,14 +423,7 @@ def main(argv, linux=None):
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
 
-		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
-					kconfig_add=cli_args.kconfig_add,
-					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile,
-					qemu_config_path=cli_args.qemu_config)
-
+		linux = tree_from_args(cli_args)
 		request = KunitRequest(build_dir=cli_args.build_dir,
 				       make_options=cli_args.make_options,
 				       jobs=cli_args.jobs,
@@ -438,14 +442,7 @@ def main(argv, linux=None):
 				not os.path.exists(cli_args.build_dir)):
 			os.mkdir(cli_args.build_dir)
 
-		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
-					kconfig_add=cli_args.kconfig_add,
-					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile,
-					qemu_config_path=cli_args.qemu_config)
-
+		linux = tree_from_args(cli_args)
 		request = KunitConfigRequest(build_dir=cli_args.build_dir,
 					     make_options=cli_args.make_options)
 		result = config_tests(linux, request)
@@ -455,14 +452,7 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
-		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
-					kconfig_add=cli_args.kconfig_add,
-					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile,
-					qemu_config_path=cli_args.qemu_config)
-
+		linux = tree_from_args(cli_args)
 		request = KunitBuildRequest(build_dir=cli_args.build_dir,
 					    make_options=cli_args.make_options,
 					    jobs=cli_args.jobs,
@@ -474,14 +464,7 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
-		if not linux:
-			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
-					kunitconfig_path=cli_args.kunitconfig,
-					kconfig_add=cli_args.kconfig_add,
-					arch=cli_args.arch,
-					cross_compile=cli_args.cross_compile,
-					qemu_config_path=cli_args.qemu_config)
-
+		linux = tree_from_args(cli_args)
 		exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
 						build_dir=cli_args.build_dir,
 						json=cli_args.json,
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index b9158017ece6..baee11d96474 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -503,24 +503,25 @@ class KUnitMainTest(unittest.TestCase):
 		self.print_mock = mock.patch('builtins.print').start()
 		self.addCleanup(mock.patch.stopall)
 
-		self.linux_source_mock = mock.Mock()
-		self.linux_source_mock.build_reconfig = mock.Mock(return_value=True)
-		self.linux_source_mock.build_kernel = mock.Mock(return_value=True)
-		self.linux_source_mock.run_kernel = mock.Mock(return_value=all_passed_log)
+		self.mock_linux_init = mock.patch.object(kunit_kernel, 'LinuxSourceTree').start()
+		self.linux_source_mock = self.mock_linux_init.return_value
+		self.linux_source_mock.build_reconfig.return_value = True
+		self.linux_source_mock.build_kernel.return_value = True
+		self.linux_source_mock.run_kernel.return_value = all_passed_log
 
 	def test_config_passes_args_pass(self):
-		kunit.main(['config', '--build_dir=.kunit'], self.linux_source_mock)
+		kunit.main(['config', '--build_dir=.kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_build_passes_args_pass(self):
-		kunit.main(['build'], self.linux_source_mock)
+		kunit.main(['build'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.build_kernel.assert_called_once_with(False, kunit.get_default_jobs(), '.kunit', None)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
-		kunit.main(['exec'], self.linux_source_mock)
+		kunit.main(['exec'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
@@ -528,7 +529,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
-		kunit.main(['run'], self.linux_source_mock)
+		kunit.main(['run'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
@@ -538,13 +539,13 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
-			kunit.main(['exec'], self.linux_source_mock)
+			kunit.main(['exec'])
 		self.assertEqual(e.exception.code, 1)
 
 	def test_run_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run'], self.linux_source_mock)
+			kunit.main(['run'])
 		self.assertEqual(e.exception.code, 1)
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
@@ -553,7 +554,7 @@ class KUnitMainTest(unittest.TestCase):
 	def test_exec_no_tests(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=['TAP version 14', '1..0'])
 		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run'], self.linux_source_mock)
+			kunit.main(['run'])
 		self.assertEqual(e.exception.code, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=300)
@@ -561,7 +562,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_exec_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['exec', '--raw_output'], self.linux_source_mock)
+		kunit.main(['exec', '--raw_output'])
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
 			self.assertNotEqual(call, mock.call(StrContains('Testing complete.')))
@@ -569,7 +570,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output'], self.linux_source_mock)
+		kunit.main(['run', '--raw_output'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
@@ -578,7 +579,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_raw_output_kunit(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output=kunit'], self.linux_source_mock)
+		kunit.main(['run', '--raw_output=kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		for call in self.print_mock.call_args_list:
@@ -588,27 +589,27 @@ class KUnitMainTest(unittest.TestCase):
 	def test_run_raw_output_invalid(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run', '--raw_output=invalid'], self.linux_source_mock)
+			kunit.main(['run', '--raw_output=invalid'])
 		self.assertNotEqual(e.exception.code, 0)
 
 	def test_run_raw_output_does_not_take_positional_args(self):
 		# --raw_output is a string flag, but we don't want it to consume
 		# any positional arguments, only ones after an '='
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		kunit.main(['run', '--raw_output', 'filter_glob'], self.linux_source_mock)
+		kunit.main(['run', '--raw_output', 'filter_glob'])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
 
 	def test_exec_timeout(self):
 		timeout = 3453
-		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
+		kunit.main(['exec', '--timeout', str(timeout)])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
 		timeout = 3453
-		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
+		kunit.main(['run', '--timeout', str(timeout)])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
@@ -616,7 +617,7 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_run_builddir(self):
 		build_dir = '.kunit'
-		kunit.main(['run', '--build_dir=.kunit'], self.linux_source_mock)
+		kunit.main(['run', '--build_dir=.kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir=build_dir, filter_glob='', timeout=300)
@@ -624,60 +625,54 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_config_builddir(self):
 		build_dir = '.kunit'
-		kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
+		kunit.main(['config', '--build_dir', build_dir])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 
 	def test_build_builddir(self):
 		build_dir = '.kunit'
 		jobs = kunit.get_default_jobs()
-		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
+		kunit.main(['build', '--build_dir', build_dir])
 		self.linux_source_mock.build_kernel.assert_called_once_with(False, jobs, build_dir, None)
 
 	def test_exec_builddir(self):
 		build_dir = '.kunit'
-		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
+		kunit.main(['exec', '--build_dir', build_dir])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 			args=None, build_dir=build_dir, filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
-	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
-	def test_run_kunitconfig(self, mock_linux_init):
-		mock_linux_init.return_value = self.linux_source_mock
+	def test_run_kunitconfig(self):
 		kunit.main(['run', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
-		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path='mykunitconfig',
-							kconfig_add=None,
-							arch='um',
-							cross_compile=None,
-							qemu_config_path=None)
-
-	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
-	def test_config_kunitconfig(self, mock_linux_init):
-		mock_linux_init.return_value = self.linux_source_mock
+		self.mock_linux_init.assert_called_once_with('.kunit',
+						kunitconfig_path='mykunitconfig',
+						kconfig_add=None,
+						arch='um',
+						cross_compile=None,
+						qemu_config_path=None)
+
+	def test_config_kunitconfig(self):
 		kunit.main(['config', '--kunitconfig=mykunitconfig'])
 		# Just verify that we parsed and initialized it correctly here.
-		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path='mykunitconfig',
-							kconfig_add=None,
-							arch='um',
-							cross_compile=None,
-							qemu_config_path=None)
-
-	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
-	def test_run_kconfig_add(self, mock_linux_init):
-		mock_linux_init.return_value = self.linux_source_mock
+		self.mock_linux_init.assert_called_once_with('.kunit',
+						kunitconfig_path='mykunitconfig',
+						kconfig_add=None,
+						arch='um',
+						cross_compile=None,
+						qemu_config_path=None)
+
+	def test_run_kconfig_add(self):
 		kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
 		# Just verify that we parsed and initialized it correctly here.
-		mock_linux_init.assert_called_once_with('.kunit',
-							kunitconfig_path=None,
-							kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
-							arch='um',
-							cross_compile=None,
-							qemu_config_path=None)
+		self.mock_linux_init.assert_called_once_with('.kunit',
+						kunitconfig_path=None,
+						kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
+						arch='um',
+						cross_compile=None,
+						qemu_config_path=None)
 
 	def test_run_kernel_args(self):
-		kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'], self.linux_source_mock)
+		kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
 		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
@@ -699,7 +694,7 @@ class KUnitMainTest(unittest.TestCase):
 	@mock.patch.object(kunit, '_list_tests')
 	def test_run_isolated_by_suite(self, mock_tests):
 		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
-		kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'], self.linux_source_mock)
+		kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'])
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
@@ -712,7 +707,7 @@ class KUnitMainTest(unittest.TestCase):
 	@mock.patch.object(kunit, '_list_tests')
 	def test_run_isolated_by_test(self, mock_tests):
 		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
-		kunit.main(['exec', '--run_isolated=test', 'suite*'], self.linux_source_mock)
+		kunit.main(['exec', '--run_isolated=test', 'suite*'])
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-- 
2.36.1.124.g0e6072fb45-goog

