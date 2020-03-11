Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 632DC1824BC
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Mar 2020 23:23:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729746AbgCKWXh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 11 Mar 2020 18:23:37 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:53052 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729626AbgCKWXg (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 11 Mar 2020 18:23:36 -0400
Received: by mail-pl1-f202.google.com with SMTP id 64so2090841plf.19
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Mar 2020 15:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=U1iDEFww1El8Gt3tduRVoHHQdOCf1b56TafCNW0JF/k=;
        b=sEVwc1UOBv3VuEQdbGvIlYBgWBX9D5LBgKc0pHQga6mdAVXEcAhDqMVylP1BOQq9eF
         95IpyRVVUevnLdQPbuGavljctufDUdoUnDjn3g0O4BK69JGE3V5pWtp6Oz6RsNT5Auhc
         Uu52Q47dquYxfNtPVchhlmv88Dbv68m2kIi1urohmXZoVklMGNpDku+awGzifErSK+dd
         kJMfYOTDi0KUXPa3DXFeeAgqRq6zpEnuU9DLvl5WUrhvGE0jP1CzPvSZdYJg++UXWTV7
         jdJjwDZnUooCQwEr1xla9kX0a17STbuZlnHJhFk5Yss1ujt5Zgrrk3TeMCYL5p0HILDS
         fovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=U1iDEFww1El8Gt3tduRVoHHQdOCf1b56TafCNW0JF/k=;
        b=Q+dTyNH5EQn1Aiyk3SOzFzQSh8xGbdvyLI4PnD9fL0p+CAK809gbU1Inhms+xPGlEa
         75YRw3DWQsXG1VBIp58AnDldWIiJF0P7Zy5xBogKHYtjCJemsp8Wj3fA1FLGtRwWjRcY
         meGWtjvET9V57l8Oz3qLrY4YjMn6qA823fDmrlYZ731ktPrcXupCix9oiIze3CmRLPs3
         ApzMAGUhifVdBWtNYXsH9rW5Iin7bXpeO0E2QhDgHkNSrJ6dtfev4aBW/pcgZi1I9i1n
         OnZrjcIBNYY7CsJ1xXN1Sy+sUVN7bNw/3Iw2QWlq0FiaTumLJzw0ln5wKNZAGOqmho6S
         FrXw==
X-Gm-Message-State: ANhLgQ2t3MAO1djdq3n7bzd9/zk7S8embzlrSF1vp5mnRdTtB2M76Fa4
        D1YseuJgQHRgYTMAer8PlUkQMLYoudrUsA==
X-Google-Smtp-Source: ADFU+vtPmQMywB2cfUJ8IMDMCSLvMM0dwQYxNSolQ4ed+sEYHP4nCR3VOvylDNPizZTqIGFDCYaWDmt8o2dbUw==
X-Received: by 2002:a63:cb:: with SMTP id 194mr1177160pga.37.1583965413686;
 Wed, 11 Mar 2020 15:23:33 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:21:58 -0700
Message-Id: <20200311222157.259707-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [RFC PATCH kunit-next] kunit: kunit_tool: Separate out config/build/exec/parse
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>
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

Most of these are not hugely useful by themselves yet, and there's room
for plenty of bikeshedding on the names, but this hopefully can form a
foundation for future improvements.

Signed-off-by: David Gow <davidgow@google.com>
---
[Whoops: typo-ed Brendan's email. Sorry about that!]

As was briefly disccussed in [1], this change is part of a "separation
of concerns" in kunit_tool. This should make it easier to integrate
kunit_tool into other setups.

Of particular intrest is probably 'kunit.py parse', which should allow
KUnit results to be parsed from other sources, such as after loading a
module, or from a non-UML kernel, or from debugfs when that's
supported[2].

[1]: https://lkml.org/lkml/2020/2/5/552
[2]: https://patchwork.kernel.org/patch/11419901/

 tools/testing/kunit/kunit.py           | 236 ++++++++++++++++++++-----
 tools/testing/kunit/kunit_tool_test.py |  55 ++++++
 2 files changed, 242 insertions(+), 49 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 180ad1e1b04f..92a634594cf6 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -20,8 +20,12 @@ import kunit_config
 import kunit_kernel
 import kunit_parser
 
-KunitResult = namedtuple('KunitResult', ['status','result'])
+KunitResult = namedtuple('KunitResult', ['status','result','elapsed_time'])
 
+KunitConfigRequest = namedtuple('KunitConfigRequest', ['build_dir', 'defconfig'])
+KunitBuildRequest = namedtuple('KunitBuildRequest', ['jobs', 'build_dir'])
+KunitExecRequest = namedtuple('KunitExecRequest', ['timeout', 'build_dir'])
+KunitParseRequest = namedtuple('KunitParseRequest', ['raw_output', 'input_data'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs', 'build_dir', 'defconfig'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
@@ -44,14 +48,25 @@ def get_kernel_root_path():
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
 	success = linux.build_reconfig(request.build_dir)
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
@@ -59,73 +74,156 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
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
 
+	result = linux.run_kernel(timeout=request.timeout,
+				  build_dir=request.build_dir)
+	test_end = time.time()
+
+	return KunitResult(KunitStatus.SUCCESS,
+			   result,
+			   test_end - test_start)
+
+def parse_tests(request: KunitParseRequest) -> KunitResult:
+	parse_start = time.time()
+
 	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
 					      [],
 					      'Tests not Parsed.')
 	if request.raw_output:
-		kunit_parser.raw_output(
-			linux.run_kernel(timeout=request.timeout,
-					 build_dir=request.build_dir))
+		kunit_parser.raw_output(request.input_data)
 	else:
-		kunit_output = linux.run_kernel(timeout=request.timeout,
-						build_dir=request.build_dir)
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
+	config_request = KunitConfigRequest(request.build_dir, request.defconfig)
+	config_result = config_tests(linux, config_request)
+	if config_result.status != KunitStatus.SUCCESS:
+		return config_result
+
+	build_request = KunitBuildRequest(request.jobs, request.build_dir)
+	build_result = build_tests(linux, build_request)
+	if build_result.status != KunitStatus.SUCCESS:
+		return build_result
+
+	exec_request = KunitExecRequest(request.timeout, request.build_dir)
+	exec_result = exec_tests(linux, exec_request)
+	if exec_result.status != KunitStatus.SUCCESS:
+		return exec_result
+
+	parse_request = KunitParseRequest(request.raw_output, exec_result.result)
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
+
+def add_config_opts(parser):
+	parser.add_argument('--defconfig',
+				help='Uses a default .kunitconfig.',
+				action='store_true')
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
+	add_common_opts(run_parser)
+	add_config_opts(run_parser)
+	add_build_opts(run_parser)
+	add_exec_opts(run_parser)
+	add_parse_opts(run_parser)
 
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
+	config_parser = subparser.add_parser('config',
+						help='Ensures that .config contains all of '
+						'the options in .kunitconfig')
+	add_common_opts(config_parser)
+	add_config_opts(config_parser)
 
-	cli_args = parser.parse_args(argv)
+	build_parser = subparser.add_parser('build', help='Builds a kernel with KUnit tests')
+	add_common_opts(build_parser)
+	add_build_opts(build_parser)
 
-	if cli_args.subcommand == 'run':
-		if get_kernel_root_path():
-			os.chdir(get_kernel_root_path())
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
+				  type=str, default='-', metavar='input_file')
+
+	cli_args = parser.parse_args(argv)
 
+	# Set up the build_dir and source tree for commands which use it
+	# (everything but 'parse')
+	if cli_args.subcommand != 'parse':
 		if cli_args.build_dir:
 			if not os.path.exists(cli_args.build_dir):
 				os.mkdir(cli_args.build_dir)
@@ -133,12 +231,11 @@ def main(argv, linux=None):
 				cli_args.build_dir,
 				kunit_kernel.kunitconfig_path)
 
-		if cli_args.defconfig:
-			create_default_kunitconfig()
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
+
+	if cli_args.subcommand == 'run':
 		request = KunitRequest(cli_args.raw_output,
 				       cli_args.timeout,
 				       cli_args.jobs,
@@ -147,6 +244,47 @@ def main(argv, linux=None):
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
+	elif cli_args.subcommand == 'config':
+		request = KunitConfigRequest(cli_args.build_dir,
+					     cli_args.defconfig)
+		result = config_tests(linux, request)
+		kunit_parser.print_with_timestamp((
+			'Elapsed time: %.3fs\n') % (
+				result.elapsed_time))
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	elif cli_args.subcommand == 'build':
+		request = KunitBuildRequest(cli_args.jobs,
+					    cli_args.build_dir)
+		result = build_tests(linux, request)
+		kunit_parser.print_with_timestamp((
+			'Elapsed time: %.3fs\n') % (
+				result.elapsed_time))
+		if result.status != KunitStatus.SUCCESS:
+			sys.exit(1)
+	elif cli_args.subcommand == 'exec':
+		exec_request = KunitExecRequest(cli_args.timeout,
+						cli_args.build_dir)
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
+		if cli_args.file == '-':
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
index cba97756ac4a..0d04425ead04 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -170,6 +170,24 @@ class KUnitMainTest(unittest.TestCase):
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
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(8, '')
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
@@ -177,6 +195,13 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=300)
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
@@ -187,6 +212,14 @@ class KUnitMainTest(unittest.TestCase):
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
 		kunit.main(['run', '--raw_output'], self.linux_source_mock)
@@ -196,6 +229,12 @@ class KUnitMainTest(unittest.TestCase):
 			assert kall != mock.call(StrContains('Testing complete.'))
 			assert kall != mock.call(StrContains(' 0 tests run'))
 
+	def test_exec_timeout(self):
+		timeout = 3453
+		kunit.main(['exec', '--timeout', str(timeout)], self.linux_source_mock)
+		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir='', timeout=timeout)
+		self.print_mock.assert_any_call(StrContains('Testing complete.'))
+
 	def test_run_timeout(self):
 		timeout = 3453
 		kunit.main(['run', '--timeout', str(timeout)], self.linux_source_mock)
@@ -210,5 +249,21 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.assert_called_once_with(build_dir=build_dir, timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_config_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['config', '--build_dir', build_dir], self.linux_source_mock)
+		assert self.linux_source_mock.build_reconfig.call_count == 1
+
+	def test_build_builddir(self):
+		build_dir = '.kunit'
+		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
+		self.linux_source_mock.build_um_kernel.assert_called_once_with(8, build_dir)
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
2.25.1.481.gfbce0eb801-goog

