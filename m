Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A799474B88B
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 23:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231845AbjGGVKP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 17:10:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjGGVKJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 17:10:09 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF61FC7
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jul 2023 14:10:03 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so2563454276.2
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jul 2023 14:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688764202; x=1691356202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZZVn4GL1xsWAqTIUq7UDdp+D3mHVFXeX/1OGD7LRzY=;
        b=p1TlXHxG39+pTa25N6I6Um//Q9VKJlZx+s6CFd1KFhnubnaL8Et64lOA1nBIz7BkO4
         giAWq6eVV3mEtHPiJ1pn6hRvlYkZGlfUHHSgdf2KLjiJHndCz4UVw2bJnMp+kKoinrpl
         VKNoFHlev/N1tRxGbq6QQZY3tcUaLl4HSlZpHJPSwwA7flRDbFaR8fReHAzNSnFCl98m
         0G7240FunmPmFKL47vba0L5GRjcLP0JmAXnDA6MFFEPQnSmrwf6vFA44RMf1UGbmsZbJ
         GsGF2R+/4FD/p3lu1HoE4ULjmo98CJUCQUOQtI44ZZhvRoyCF93m83uNICculgRnD6fa
         iBwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688764202; x=1691356202;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZZVn4GL1xsWAqTIUq7UDdp+D3mHVFXeX/1OGD7LRzY=;
        b=WiqR40Y5VxrHkB32Iez+aXeXYZIXk9QUDjd5WMQNL3Ri6OGczvDD76UtGMHrSdDeZd
         DZZS1UgS+ZovBNWdoTLdC/Y8nE7r8MgF22DEIzu9GwyRRsbXBqf8MTNxYCpJpjdXh579
         Y1bdsqzEWtylnjOFtywzmvZMn7x8e30wNgFhrj86sMuvzZi08KLVN9QSrqHpdG2qVKXJ
         gh6rg3z59UTprjFhIffYtVD8RIgZL6LEqoeHwnmTk4l3sD1dxpgdAsC8+eYAbPRxh7AV
         HJcp7Rb16jq3K5z5ZYphPFzCYHYgjEZqqyk4+78v/zDzJ5oAX+JFFURz2tkSWhZF8N4g
         kgaA==
X-Gm-Message-State: ABy/qLb3Fr760L8izbIqG76ApaSFNzq+VqyaEbfi4F5OQEOvPPVEMqP6
        RcmzkMIujgFFEGyN78iLk46S3gwrkg==
X-Google-Smtp-Source: APBJJlHQg+UDXLchFCf9netJSWZyJGw19qlrWpeY2nX4RLLm6P9XQVBlwld8VyD2pQwCH83H4vCqpmxJkg==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:d6:0:b0:c6e:269e:953a with SMTP id
 205-20020a2500d6000000b00c6e269e953amr12102yba.3.1688764202530; Fri, 07 Jul
 2023 14:10:02 -0700 (PDT)
Date:   Fri,  7 Jul 2023 21:09:43 +0000
In-Reply-To: <20230707210947.1208717-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230707210947.1208717-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230707210947.1208717-6-rmoar@google.com>
Subject: [RFC v2 5/9] kunit: tool: Add command line interface to filter and
 report attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ability to kunit.py to filter attributes and report a list of tests
including attributes without running tests.

Add flag "--filter" to input filters on test attributes. Tests will be
filtered out if they do not match all inputted filters.

Example: --filter speed=slow (This filter would run only the tests that are
marked as slow)

Filters have operations: <, >, <=, >=, !=, and =. But note that the
characters < and > are often interpreted by the shell, so they may need to
be quoted or escaped.

Example: --filter "speed>slow" or --filter speed\>slow (This filter would
run only the tests that have the speed faster than slow.

Additionally, multiple filters can be used.

Example: --filter "speed=slow, module!=example" (This filter would run
only the tests that have the speed slow and are not in the "example"
module)

Note if the user wants to skip filtered tests instead of not
running/showing them use the "--filter_skip" flag instead.

Expose the output of kunit.action=list option with flag "--list_tests" to
output a list of tests. Additionally, add flag "--list_tests_attr" to
output a list of tests and their attributes. These flags are useful to see
tests and test attributes without needing to run tests.

Example of the output of "--list_tests_attr":
  example
  example.test_1
  example.test_2
  # example.test_2.speed: slow

This output includes a suite, example, with two test cases, test_1 and
test_2. And in this instance test_2 has been marked as slow.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes since v1:
- Change method for inputting filters to allow for spaces in filtering
  values
- Add option to skip filtered tests instead of not run or show them with
  the --filter_skip flag
- Separate the new feature to list tests and their attributes into both
  --list_tests (lists just tests) and --list_tests_attr (lists all)

 tools/testing/kunit/kunit.py           | 80 ++++++++++++++++++++++++--
 tools/testing/kunit/kunit_kernel.py    |  6 +-
 tools/testing/kunit/kunit_tool_test.py | 39 ++++++-------
 3 files changed, 96 insertions(+), 29 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 3905c43369c3..6104e622ce20 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -55,8 +55,12 @@ class KunitExecRequest(KunitParseRequest):
 	build_dir: str
 	timeout: int
 	filter_glob: str
+	filter: str
+	filter_skip: str
 	kernel_args: Optional[List[str]]
 	run_isolated: Optional[str]
+	list_tests: bool
+	list_tests_attr: bool
 
 @dataclass
 class KunitRequest(KunitExecRequest, KunitBuildRequest):
@@ -102,19 +106,39 @@ def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
 
 def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
 	args = ['kunit.action=list']
+
+	if request.kernel_args:
+		args.extend(request.kernel_args)
+
+	output = linux.run_kernel(args=args,
+			   timeout=request.timeout,
+			   filter_glob=request.filter_glob,
+			   filter=request.filter,
+			   build_dir=request.build_dir)
+	lines = kunit_parser.extract_tap_lines(output)
+	# Hack! Drop the dummy TAP version header that the executor prints out.
+	lines.pop()
+
+	# Filter out any extraneous non-test output that might have gotten mixed in.
+	return [l for l in output if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
+
+def _list_tests_attr(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> Iterable[str]:
+	args = ['kunit.action=list_attr']
+
 	if request.kernel_args:
 		args.extend(request.kernel_args)
 
 	output = linux.run_kernel(args=args,
 			   timeout=request.timeout,
 			   filter_glob=request.filter_glob,
+			   filter=request.filter,
 			   build_dir=request.build_dir)
 	lines = kunit_parser.extract_tap_lines(output)
 	# Hack! Drop the dummy TAP version header that the executor prints out.
 	lines.pop()
 
 	# Filter out any extraneous non-test output that might have gotten mixed in.
-	return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
+	return lines
 
 def _suites_from_test_list(tests: List[str]) -> List[str]:
 	"""Extracts all the suites from an ordered list of tests."""
@@ -128,10 +152,18 @@ def _suites_from_test_list(tests: List[str]) -> List[str]:
 			suites.append(suite)
 	return suites
 
-
-
 def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> KunitResult:
 	filter_globs = [request.filter_glob]
+	if request.list_tests:
+		output = _list_tests(linux, request)
+		for line in output:
+			print(line.rstrip())
+		return KunitResult(status=KunitStatus.SUCCESS, elapsed_time=0.0)
+	if request.list_tests_attr:
+		attr_output = _list_tests_attr(linux, request)
+		for line in attr_output:
+			print(line.rstrip())
+		return KunitResult(status=KunitStatus.SUCCESS, elapsed_time=0.0)
 	if request.run_isolated:
 		tests = _list_tests(linux, request)
 		if request.run_isolated == 'test':
@@ -145,6 +177,17 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 
 	metadata = kunit_json.Metadata(arch=linux.arch(), build_dir=request.build_dir, def_config='kunit_defconfig')
 
+	filter = request.filter
+	if request.filter_skip:
+		args = ['kunit.filter_action=skip']
+		filter = request.filter_skip
+		if request.kernel_args:
+			args.extend(request.kernel_args)
+	elif request.kernel_args:
+		args = request.kernel_args
+	else:
+		args = None
+
 	test_counts = kunit_parser.TestCounts()
 	exec_time = 0.0
 	for i, filter_glob in enumerate(filter_globs):
@@ -152,9 +195,10 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 
 		test_start = time.time()
 		run_result = linux.run_kernel(
-			args=request.kernel_args,
+			args=args,
 			timeout=request.timeout,
 			filter_glob=filter_glob,
+			filter=filter,
 			build_dir=request.build_dir)
 
 		_, test_result = parse_tests(request, metadata, run_result)
@@ -341,6 +385,18 @@ def add_exec_opts(parser: argparse.ArgumentParser) -> None:
 			    nargs='?',
 			    default='',
 			    metavar='filter_glob')
+	parser.add_argument('--filter',
+			    help='Filter KUnit tests with attributes, '
+				'filtered tests will not run, '
+			    'e.g. speed=fast or speed=>low',
+			    type=str,
+				default='')
+	parser.add_argument('--filter_skip',
+			    help='Filter KUnit tests run with attributes, '
+				'filtered tests will be skipped, '
+			    'e.g. speed=fast or speed=>low',
+			    type=str,
+				default='')
 	parser.add_argument('--kernel_args',
 			    help='Kernel command-line parameters. Maybe be repeated',
 			     action='append', metavar='')
@@ -350,6 +406,10 @@ def add_exec_opts(parser: argparse.ArgumentParser) -> None:
 			    'what ran before it.',
 			    type=str,
 			    choices=['suite', 'test'])
+	parser.add_argument('--list_tests', help='If set, list all tests',
+			    action='store_true')
+	parser.add_argument('--list_tests_attr', help='If set, list all tests and attributes.',
+			    action='store_true')
 
 def add_parse_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t parse output from kernel. '
@@ -398,8 +458,12 @@ def run_handler(cli_args: argparse.Namespace) -> None:
 					json=cli_args.json,
 					timeout=cli_args.timeout,
 					filter_glob=cli_args.filter_glob,
+					filter=cli_args.filter,
+					filter_skip=cli_args.filter_skip,
 					kernel_args=cli_args.kernel_args,
-					run_isolated=cli_args.run_isolated)
+					run_isolated=cli_args.run_isolated,
+					list_tests=cli_args.list_tests,
+					list_tests_attr=cli_args.list_tests_attr)
 	result = run_tests(linux, request)
 	if result.status != KunitStatus.SUCCESS:
 		sys.exit(1)
@@ -441,8 +505,12 @@ def exec_handler(cli_args: argparse.Namespace) -> None:
 					json=cli_args.json,
 					timeout=cli_args.timeout,
 					filter_glob=cli_args.filter_glob,
+					filter=cli_args.filter,
+					filter_skip=cli_args.filter_skip,
 					kernel_args=cli_args.kernel_args,
-					run_isolated=cli_args.run_isolated)
+					run_isolated=cli_args.run_isolated,
+					list_tests=cli_args.list_tests,
+					list_tests_attr=cli_args.list_tests_attr)
 	result = exec_tests(linux, exec_request)
 	stdout.print_with_timestamp((
 		'Elapsed time: %.3fs\n') % (result.elapsed_time))
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 7f648802caf6..281f062a4767 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -330,11 +330,13 @@ class LinuxSourceTree:
 			return False
 		return self.validate_config(build_dir)
 
-	def run_kernel(self, args: Optional[List[str]]=None, build_dir: str='', filter_glob: str='', timeout: Optional[int]=None) -> Iterator[str]:
+	def run_kernel(self, args: Optional[List[str]]=None, build_dir: str='', filter_glob: str='', filter: str='', timeout: Optional[int]=None) -> Iterator[str]:
 		if not args:
 			args = []
 		if filter_glob:
-			args.append('kunit.filter_glob='+filter_glob)
+			args.append('kunit.filter_glob=' + filter_glob)
+		if filter:
+			args.append('kunit.filter="' + filter + '"')
 		args.append('kunit.enable=1')
 
 		process = self._ops.start(args, build_dir)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index be35999bb84f..85a1fb72735e 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -597,7 +597,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=None, build_dir='.kunit', filter_glob='', timeout=300)
+			args=None, build_dir='.kunit', filter_glob='', filter='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_passes_args_pass(self):
@@ -605,7 +605,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=None, build_dir='.kunit', filter_glob='', timeout=300)
+			args=None, build_dir='.kunit', filter_glob='', filter='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_exec_passes_args_fail(self):
@@ -629,7 +629,7 @@ class KUnitMainTest(unittest.TestCase):
 			kunit.main(['run'])
 		self.assertEqual(e.exception.code, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=None, build_dir='.kunit', filter_glob='', timeout=300)
+			args=None, build_dir='.kunit', filter_glob='', filter='', timeout=300)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
 
 	def test_exec_raw_output(self):
@@ -670,13 +670,13 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel = mock.Mock(return_value=[])
 		kunit.main(['run', '--raw_output', 'filter_glob'])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=None, build_dir='.kunit', filter_glob='filter_glob', timeout=300)
+			args=None, build_dir='.kunit', filter_glob='filter_glob', filter='', timeout=300)
 
 	def test_exec_timeout(self):
 		timeout = 3453
 		kunit.main(['exec', '--timeout', str(timeout)])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
+			args=None, build_dir='.kunit', filter_glob='', filter='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_timeout(self):
@@ -684,7 +684,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=None, build_dir='.kunit', filter_glob='', timeout=timeout)
+			args=None, build_dir='.kunit', filter_glob='', filter='', timeout=timeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_builddir(self):
@@ -692,7 +692,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--build_dir=.kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=None, build_dir=build_dir, filter_glob='', timeout=300)
+			args=None, build_dir=build_dir, filter_glob='', filter='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_config_builddir(self):
@@ -710,7 +710,7 @@ class KUnitMainTest(unittest.TestCase):
 		build_dir = '.kunit'
 		kunit.main(['exec', '--build_dir', build_dir])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=None, build_dir=build_dir, filter_glob='', timeout=300)
+			args=None, build_dir=build_dir, filter_glob='', filter='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_run_kunitconfig(self):
@@ -786,7 +786,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--kernel_args=a=1', '--kernel_args=b=2'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
+		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', filter='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
 	def test_list_tests(self):
@@ -794,13 +794,11 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None, 'suite'))
-
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', '', None, 'suite', False, False))
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', timeout=300)
-
+			args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', filter='', timeout=300)
 
 	@mock.patch.object(kunit, '_list_tests')
 	def test_run_isolated_by_suite(self, mock_tests):
@@ -809,10 +807,10 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*', None, 'suite'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*', '', '', None, 'suite', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
-			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
-			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', filter='', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', filter='', timeout=300),
 		])
 
 	@mock.patch.object(kunit, '_list_tests')
@@ -822,13 +820,12 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None, 'test'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', '', None, 'test', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
-			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
-			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
-			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', filter='', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', filter='', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', filter='', timeout=300),
 		])
 
-
 if __name__ == '__main__':
 	unittest.main()
-- 
2.41.0.255.g8b1d071c50-goog

