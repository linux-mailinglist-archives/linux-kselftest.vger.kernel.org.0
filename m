Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8651C0D65
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 May 2020 06:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgEAE1g (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 May 2020 00:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726153AbgEAE1f (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 May 2020 00:27:35 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B367C035495
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Apr 2020 21:27:33 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n205so10725779ybf.14
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Apr 2020 21:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=mm57KHahDM8P2sHiHDBAQ3jxA1XX0ZuHuyaz8Yv2CPk=;
        b=Cx5E6xcASlxHdoqv6F4CzaR84iEKF0qMmJfAQsoWkZXPP5v29LhNn8ew9ahg27XCls
         fjMZfaUH/fi4zUn+Sq+1kxwoC1rJEOaxUFeljADrMLqOz41bwNM148agubegwLa4b6TX
         VsWd4joZIg+fpH6ccitLh+57ENDVIdPPXH7rLb/kRmySbhzI+rkWgi/Chsd1s9AUyaDK
         dsnZz9ad/fgXPV/9iv60we4W9/RytJbrsIEDcda+beRQ+xcrJsU4M3c5OUfnTdgGdGRr
         kaEXYEvsx1+JtgLESzg8bnNaRxkDlwBAroyGR14TwSfj3jUHBn5IBczBEnCjrXE8EMzc
         WhVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=mm57KHahDM8P2sHiHDBAQ3jxA1XX0ZuHuyaz8Yv2CPk=;
        b=qP3Zi4/eM2pbvP4A13xN4XfjFp+GkzYz0ZBnN4GhppRUMnOuQmfoansit8aZsXXuPR
         1NteybU6rdJv1Ywme4qQysgK/uuOdgpf8tIS/S9hnzu09Q0poHIfr+s9p2t2JYZE5TFx
         6F4bAZ2NVpAFMS5RILtN8bevIVTXiskQor8AnvJzsibyBUcdJzNarBh6KbWlwBdB6ipo
         GG2SdsPNUjBPr3lnYyQYE58Jgaeua1VUWzyqHWrAX1fdEVN331dwyW2zZvyame4wMCTb
         5Gzkmas455ls8ZoBCNxnHOAKadeVb82GxyqhHtJNbGPo0nN1PnDuRJZO1hduBMv9N42l
         C8yw==
X-Gm-Message-State: AGi0PuYnKu+CIkrskRi4OeBuA26KhsVjmvYVjQ3fmTEw8gla4UVawfVf
        T13e134PV8Thx06Dyll6x2g2yaKVbQLu8g==
X-Google-Smtp-Source: APiQypJDqcFlr9WcThO4/YC7rrTHXYhjFcaNcjuV48+YfryI6DTN4/s3VoIEX6eZeBP2FBiDimF9xhAmbd1zrA==
X-Received: by 2002:a25:e7cb:: with SMTP id e194mr3551728ybh.422.1588307252983;
 Thu, 30 Apr 2020 21:27:32 -0700 (PDT)
Date:   Thu, 30 Apr 2020 21:27:01 -0700
Message-Id: <20200501042701.7436-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH kunit-next] kunit: kunit_tool: Separate out config/build/exec/parse
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Heidi Fahim <heidifahim@google.com>,
        Shuah Kahn <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add new subcommands to kunit.py to allow stages of the existing 'run'
subcommand to be run independently:
- 'config': Verifies that .config is a subset of .kunitconfig
- 'build': Compiles a UML kernel for KUnit
- 'exec': Runs the kernel, and outputs the test results.
- 'parse': Parses test results from a file or stdin

The 'run' command continues to behave as before.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---

Changes since the RFC[1]:
- Rebased on top of kselftest/kunit, adding support for --alltests and
  --make_options
- Fixed an issue where the help text wouldn't print properly if an
  invalid subcommand were specified.
- Changed 'parse' subcommand to make the filename optional (and default
  to stdin) as suggested by Brendan.

[1]: https://lkml.org/lkml/2020/3/11/1225

 tools/testing/kunit/kunit.py           | 293 ++++++++++++++++++++-----
 tools/testing/kunit/kunit_tool_test.py |  63 +++++-
 2 files changed, 296 insertions(+), 60 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dca74774dd2..b01838b6f5f9 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -20,8 +20,17 @@ import kunit_config
 import kunit_kernel
 import kunit_parser
 
-KunitResult = namedtuple('KunitResult', ['status','result'])
+KunitResult = namedtuple('KunitResult', ['status','result','elapsed_time'])
 
+KunitConfigRequest = namedtuple('KunitConfigRequest',
+				['build_dir', 'defconfig', 'make_options'])
+KunitBuildRequest = namedtuple('KunitBuildRequest',
+			       ['jobs', 'build_dir', 'alltests',
+				'make_options'])
+KunitExecRequest = namedtuple('KunitExecRequest',
+			      ['timeout', 'build_dir', 'alltests'])
+KunitParseRequest = namedtuple('KunitParseRequest',
+			       ['raw_output', 'input_data'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'defconfig',
 					   'alltests', 'make_options'])
@@ -46,14 +55,25 @@ def get_kernel_root_path():
 		sys.exit(1)
 	return parts[0]
 
-def run_tests(linux: kunit_kernel.LinuxSourceTree,
-	      request: KunitRequest) -> KunitResult:
+def config_tests(linux: kunit_kernel.LinuxSourceTree,
+		 request: KunitConfigRequest) -> KunitResult:
+	kunit_parser.print_with_timestamp('Configuring KUnit Kernel ...')
+
 	config_start = time.time()
+	if request.defconfig:
+		create_default_kunitconfig()
 	success = linux.build_reconfig(request.build_dir, request.make_options)
 	config_end = time.time()
 	if not success:
-		return KunitResult(KunitStatus.CONFIG_FAILURE, 'could not configure kernel')
+		return KunitResult(KunitStatus.CONFIG_FAILURE,
+				   'could not configure kernel',
+				   config_end - config_start)
+	return KunitResult(KunitStatus.SUCCESS,
+			   'configured kernel successfully',
+			   config_end - config_start)
 
+def build_tests(linux: kunit_kernel.LinuxSourceTree,
+		request: KunitBuildRequest) -> KunitResult:
 	kunit_parser.print_with_timestamp('Building KUnit Kernel ...')
 
 	build_start = time.time()
@@ -64,78 +84,167 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE, 'could not build kernel')
+	if not success:
+		return KunitResult(KunitStatus.BUILD_FAILURE,
+				   'could not build kernel',
+				   build_end - build_start)
+	return KunitResult(KunitStatus.SUCCESS,
+			   'built kernel successfully',
+			   build_end - build_start)
 
+def exec_tests(linux: kunit_kernel.LinuxSourceTree,
+	       request: KunitExecRequest) -> KunitResult:
 	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
 	test_start = time.time()
-	kunit_output = linux.run_kernel(
+	result = linux.run_kernel(
 		timeout=None if request.alltests else request.timeout,
 		build_dir=request.build_dir)
+
+	test_end = time.time()
+
+	return KunitResult(KunitStatus.SUCCESS,
+			   result,
+			   test_end - test_start)
+
+def parse_tests(request: KunitParseRequest) -> KunitResult:
+	parse_start = time.time()
+
+	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
+					      [],
+					      'Tests not Parsed.')
 	if request.raw_output:
-		raw_output = kunit_parser.raw_output(kunit_output)
-		isolated = list(kunit_parser.isolate_kunit_output(raw_output))
-		test_result = kunit_parser.parse_test_result(isolated)
+		kunit_parser.raw_output(request.input_data)
 	else:
-		test_result = kunit_parser.parse_run_tests(kunit_output)
-	test_end = time.time()
+		test_result = kunit_parser.parse_run_tests(request.input_data)
+	parse_end = time.time()
+
+	if test_result.status != kunit_parser.TestStatus.SUCCESS:
+		return KunitResult(KunitStatus.TEST_FAILURE, test_result,
+				   parse_end - parse_start)
+
+	return KunitResult(KunitStatus.SUCCESS, test_result,
+				parse_end - parse_start)
+
+
+def run_tests(linux: kunit_kernel.LinuxSourceTree,
+	      request: KunitRequest) -> KunitResult:
+	run_start = time.time()
+
+	config_request = KunitConfigRequest(request.build_dir,
+					    request.defconfig,
+					    request.make_options)
+	config_result = config_tests(linux, config_request)
+	if config_result.status != KunitStatus.SUCCESS:
+		return config_result
+
+	build_request = KunitBuildRequest(request.jobs, request.build_dir,
+					  request.alltests,
+					  request.make_options)
+	build_result = build_tests(linux, build_request)
+	if build_result.status != KunitStatus.SUCCESS:
+		return build_result
+
+	exec_request = KunitExecRequest(request.timeout, request.build_dir,
+					request.alltests)
+	exec_result = exec_tests(linux, exec_request)
+	if exec_result.status != KunitStatus.SUCCESS:
+		return exec_result
+
+	parse_request = KunitParseRequest(request.raw_output,
+					  exec_result.result)
+	parse_result = parse_tests(parse_request)
+
+	run_end = time.time()
 
 	kunit_parser.print_with_timestamp((
 		'Elapsed time: %.3fs total, %.3fs configuring, %.3fs ' +
 		'building, %.3fs running\n') % (
-				test_end - config_start,
-				config_end - config_start,
-				build_end - build_start,
-				test_end - test_start))
+				run_end - run_start,
+				config_result.elapsed_time,
+				build_result.elapsed_time,
+				exec_result.elapsed_time))
+	return parse_result
+
+def add_common_opts(parser):
+	parser.add_argument('--build_dir',
+			    help='As in the make command, it specifies the build '
+			    'directory.',
+			    type=str, default='', metavar='build_dir')
+	parser.add_argument('--make_options',
+			    help='X=Y make option, can be repeated.',
+			    action='append')
+	parser.add_argument('--alltests',
+			    help='Run all KUnit tests through allyesconfig',
+			    action='store_true')
+
+def add_config_opts(parser):
+	parser.add_argument('--defconfig',
+			    help='Uses a default .kunitconfig.',
+			    action='store_true')
+
+def add_build_opts(parser):
+	parser.add_argument('--jobs',
+			    help='As in the make command, "Specifies  the number of '
+			    'jobs (commands) to run simultaneously."',
+			    type=int, default=8, metavar='jobs')
+
+def add_exec_opts(parser):
+	parser.add_argument('--timeout',
+			    help='maximum number of seconds to allow for all tests '
+			    'to run. This does not include time taken to build the '
+			    'tests.',
+			    type=int,
+			    default=300,
+			    metavar='timeout')
+
+def add_parse_opts(parser):
+	parser.add_argument('--raw_output', help='don\'t format output from kernel',
+			    action='store_true')
 
-	if test_result.status != kunit_parser.TestStatus.SUCCESS:
-		return KunitResult(KunitStatus.TEST_FAILURE, test_result)
-	else:
-		return KunitResult(KunitStatus.SUCCESS, test_result)
 
 def main(argv, linux=None):
 	parser = argparse.ArgumentParser(
 			description='Helps writing and running KUnit tests.')
 	subparser = parser.add_subparsers(dest='subcommand')
 
+	# The 'run' command will config, build, exec, and parse in one go.
 	run_parser = subparser.add_parser('run', help='Runs KUnit tests.')
-	run_parser.add_argument('--raw_output', help='don\'t format output from kernel',
-				action='store_true')
-
-	run_parser.add_argument('--timeout',
-				help='maximum number of seconds to allow for all tests '
-				'to run. This does not include time taken to build the '
-				'tests.',
-				type=int,
-				default=300,
-				metavar='timeout')
-
-	run_parser.add_argument('--jobs',
-				help='As in the make command, "Specifies  the number of '
-				'jobs (commands) to run simultaneously."',
-				type=int, default=8, metavar='jobs')
-
-	run_parser.add_argument('--build_dir',
-				help='As in the make command, it specifies the build '
-				'directory.',
-				type=str, default='', metavar='build_dir')
-
-	run_parser.add_argument('--defconfig',
-				help='Uses a default .kunitconfig.',
-				action='store_true')
-
-	run_parser.add_argument('--alltests',
-				help='Run all KUnit tests through allyesconfig',
-				action='store_true')
-
-	run_parser.add_argument('--make_options',
-				help='X=Y make option, can be repeated.',
-				action='append')
+	add_common_opts(run_parser)
+	add_config_opts(run_parser)
+	add_build_opts(run_parser)
+	add_exec_opts(run_parser)
+	add_parse_opts(run_parser)
+
+	config_parser = subparser.add_parser('config',
+						help='Ensures that .config contains all of '
+						'the options in .kunitconfig')
+	add_common_opts(config_parser)
+	add_config_opts(config_parser)
+
+	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
+	add_common_opts(build_parser)
+	add_build_opts(build_parser)
+
+	exec_parser = subparser.add_parser('exec', help='Run a kernel with KUnit tests')
+	add_common_opts(exec_parser)
+	add_exec_opts(exec_parser)
+	add_parse_opts(exec_parser)
+
+	# The 'parse' option is special, as it doesn't need the kernel source
+	# (therefore there is no need for a build_dir, hence no add_common_opts)
+	# and the '--file' argument is not relevant to 'run', so isn't in
+	# add_parse_opts()
+	parse_parser = subparser.add_parser('parse',
+					    help='Parses KUnit results from a file, '
+					    'and parses formatted results.')
+	add_parse_opts(parse_parser)
+	parse_parser.add_argument('file',
+				  help='Specifies the file to read results from.',
+				  type=str, nargs='?', metavar='input_file')
 
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
-		if get_kernel_root_path():
-			os.chdir(get_kernel_root_path())
-
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
@@ -143,9 +252,6 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
-		if cli_args.defconfig:
-			create_default_kunitconfig()
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -159,6 +265,81 @@ def main(argv, linux=None):
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
+	elif cli_args.subcommand == 'config':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
+		request = KunitConfigRequest(cli_args.build_dir,
+					     cli_args.defconfig,
+					     cli_args.make_options)
+		result = config_tests(linux, request)
+		kunit_parser.print_with_timestamp((
+			'Elapsed time: %.3fs\n') % (
+				result.elapsed_time))
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	elif cli_args.subcommand == 'build':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
+		request = KunitBuildRequest(cli_args.jobs,
+					    cli_args.build_dir,
+					    cli_args.alltests,
+					    cli_args.make_options)
+		result = build_tests(linux, request)
+		kunit_parser.print_with_timestamp((
+			'Elapsed time: %.3fs\n') % (
+				result.elapsed_time))
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	elif cli_args.subcommand == 'exec':
+		if cli_args.build_dir:
+			if not os.path.exists(cli_args.build_dir):
+				os.mkdir(cli_args.build_dir)
+			kunit_kernel.kunitconfig_path = os.path.join(
+				cli_args.build_dir,
+				kunit_kernel.kunitconfig_path)
+
+		if not linux:
+			linux = kunit_kernel.LinuxSourceTree()
+
+		exec_request = KunitExecRequest(cli_args.timeout,
+						cli_args.build_dir,
+						cli_args.alltests)
+		exec_result = exec_tests(linux, exec_request)
+		parse_request = KunitParseRequest(cli_args.raw_output,
+						  exec_result.result)
+		result = parse_tests(parse_request)
+		kunit_parser.print_with_timestamp((
+			'Elapsed time: %.3fs\n') % (
+				exec_result.elapsed_time))
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	elif cli_args.subcommand == 'parse':
+		if cli_args.file == None:
+			kunit_output = sys.stdin
+		else:
+			with open(cli_args.file, 'r') as f:
+				kunit_output = f.read().splitlines()
+		request = KunitParseRequest(cli_args.raw_output,
+					    kunit_output)
+		result = parse_tests(request)
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
 	else:
 		parser.print_help()
 
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 984588d6ba95..5bb7b118ebd9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -239,6 +239,24 @@ class KUnitMainTest(unittest.TestCase):
 		self.print_patch.stop()
 		pass
 
+	def test_config_passes_args_pass(self):
+		kunit.main(['config'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+		assert self.linux_source_mock.run_kernel.call_count == 0
+
+	def test_build_passes_args_pass(self):
+		kunit.main(['build'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 0
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, '', None)
+		assert self.linux_source_mock.run_kernel.call_count == 0
+
+	def test_exec_passes_args_pass(self):
+		kunit.main(['exec'], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 0
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
 	def test_run_passes_args_pass(self):
 		kunit.main(['run'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
@@ -247,6 +265,13 @@ class KUnitMainTest(unittest.TestCase):
 			build_dir='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_exec_passes_args_fail(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		with self.assertRaises(SystemExit) as e:
+			kunit.main(['exec'], self.linux_source_mock)
+		assert type(e.exception) == SystemExit
+		assert e.exception.code == 1
+
 	def test_run_passes_args_fail(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		with self.assertRaises(SystemExit) as e:
@@ -257,14 +282,28 @@ class KUnitMainTest(unittest.TestCase):
 		assert self.linux_source_mock.run_kernel.call_count == 1
 		self.print_mock.assert_any_call(StrContains(' 0 tests run'))
 
+	def test_exec_raw_output(self):
+		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
+		kunit.main(['exec', '--raw_output'], self.linux_source_mock)
+		assert self.linux_source_mock.run_kernel.call_count == 1
+		for kall in self.print_mock.call_args_list:
+			assert kall != mock.call(StrContains('Testing complete.'))
+			assert kall != mock.call(StrContains(' 0 tests run'))
+
 	def test_run_raw_output(self):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
-		with self.assertRaises(SystemExit) as e:
-			kunit.main(['run', '--raw_output'], self.linux_source_mock)
-		assert type(e.exception) == SystemExit
-		assert e.exception.code == 1
+		kunit.main(['run', '--raw_output'], self.linux_source_mock)
 		assert self.linux_source_mock.build_reconfig.call_count == 1
 		assert self.linux_source_mock.run_kernel.call_count == 1
+		for kall in self.print_mock.call_args_list:
+			assert kall != mock.call(StrContains('Testing complete.'))
+			assert kall != mock.call(StrContains(' 0 tests run'))
+
+	def test_exec_timeout(self):
+		timeout = 3453
+		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
 		timeout = 3453
@@ -282,5 +321,21 @@ class KUnitMainTest(unittest.TestCase):
 			build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_config_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+
+	def test_build_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(False, 8, build_dir, None)
+
+	def test_exec_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['exec', '--build_dir', build_dir], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
 if __name__ == '__main__':
 	unittest.main()
-- 
2.26.2.526.g744177e7f7-goog

