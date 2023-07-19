Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ED175A1C7
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 00:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjGSWYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 18:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjGSWYQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 18:24:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D722106
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:24:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-ca8e5f39e09so374576276.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jul 2023 15:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805441; x=1692397441;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6OtU6HKaPtInKv7GRD9j2k9uQtdnKiNR0hgZm/fuNuo=;
        b=UcfGvZbrMKv8SaDQsQZb13+VjYawUvXZCC5QhOFS1NxUjO5KF32QBFDoAkO8eGRVou
         JlviKJ/oeNVFuXkwprhUSTOYg9boSYrs6OhqZaL9WeYQfjCFAhbPqEgq6WmiQKUujtla
         AEuduVCppo+lhpZohhYmpxpp6LRvxYkSAgECvfFRCrHNDmV0zv8ZRnM/C88U/3HGcANu
         cLkAtBLnc0JGVZPDXcuUbfRbpYUmsm22bEecsCuQKCyfGNy/oNnMG0OF8v2fePDCMS5K
         EwScQYhnU+trDaeKDDKS0DCMDtbE+YGoIKJaz0a0L3NOk4CNXW8luqRn0hawmyDs13z8
         SfyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805441; x=1692397441;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6OtU6HKaPtInKv7GRD9j2k9uQtdnKiNR0hgZm/fuNuo=;
        b=CLNWpJ0FZsnuXNVEXLSOjJtX6ahdNPd3HNA5jE+CSEI2U3+yBfYjugwyopzBDYf6yS
         I6K5OlfLwtSjwoc+wAHDBvUFLi1u+L/4Q2SKV2tah7v/9mji3HX6CDx9SBEb7vK9MMQG
         JLDBTBXKipr7c9kFqP8zXXAp/LbDLlkrSyOWqaWmC6hzBHB8OKQvAq9mHj9owAgPN0ux
         zawqEsQlATCfdvku4xuDHYeo4mR9ZwkPG1T+Wbs0ezWAIqnZk9zAXt2jm5XQN090hQFz
         9KZcPnJo4vAHbHVgKMOdL5et6Esdc161YBO+IgCCV5j7/kul4iP4ztln1JR5+UxM315g
         Aakw==
X-Gm-Message-State: ABy/qLbS2wZmfKZxrCCM0CHxRjPyQAOVcWG6/vjjOHRvlvZpaIZTW4kx
        isBtbobKSFmra1MnB5iCYo08g3HTng==
X-Google-Smtp-Source: APBJJlHYrT1refevov/wwGKzGf7E5mcjTJpHif0Z99HcDWLAWKGz3adeGU/phPoprzDimMVENgxrRAMNsw==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:ad1f:0:b0:cf9:3564:33c7 with SMTP id
 y31-20020a25ad1f000000b00cf9356433c7mr27536ybi.0.1689805440994; Wed, 19 Jul
 2023 15:24:00 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:23:32 +0000
In-Reply-To: <20230719222338.259684-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230719222338.259684-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230719222338.259684-6-rmoar@google.com>
Subject: [PATCH v1 5/9] kunit: tool: Add command line interface to filter and
 report attributes
From:   Rae Moar <rmoar@google.com>
To:     shuah@kernel.org, davidgow@google.com, dlatypov@google.com,
        brendan.higgins@linux.dev
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        linux-hardening@vger.kernel.org, jstultz@google.com,
        tglx@linutronix.de, sboyd@kernel.org, Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ability to kunit.py to filter attributes and report a list of tests
including attributes without running tests.

Add flag "--filter" to input filters on test attributes. Tests will be
filtered out if they do not match all inputted filters.

Example: --filter speed=3Dslow (This filter would run only the tests that a=
re
marked as slow)

Filters have operations: <, >, <=3D, >=3D, !=3D, and =3D. But note that the
characters < and > are often interpreted by the shell, so they may need to
be quoted or escaped.

Example: --filter "speed>slow" or --filter speed\>slow (This filter would
run only the tests that have the speed faster than slow.

Additionally, multiple filters can be used.

Example: --filter "speed=3Dslow, module!=3Dexample" (This filter would run
only the tests that have the speed slow and are not in the "example"
module)

Note if the user wants to skip filtered tests instead of not
running/showing them use the "--filter_action=3Dskip" flag instead.

Expose the output of kunit.action=3Dlist option with flag "--list_tests" to
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

Changes since RFC v2:
- Remove --filter_skip flag and replace with --filter_action=3Dskip
- Make KUnit executor errors visible in kunit.py and raw_output
- Fix up help comments

Changes since RFC v1:
- Change method for inputting filters to allow for spaces in filtering
  values
- Add option to skip filtered tests instead of not run or show them with
  the =E2=80=93-filter_skip flag
- Separate the new feature to list tests and their attributes into both
  --list_tests (lists just tests) and --list_tests_attr (lists all)

 tools/testing/kunit/kunit.py           | 70 ++++++++++++++++++++++++--
 tools/testing/kunit/kunit_kernel.py    |  8 ++-
 tools/testing/kunit/kunit_parser.py    | 11 +++-
 tools/testing/kunit/kunit_tool_test.py | 39 +++++++-------
 4 files changed, 99 insertions(+), 29 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 3905c43369c3..bc74088c458a 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -55,8 +55,12 @@ class KunitExecRequest(KunitParseRequest):
 	build_dir: str
 	timeout: int
 	filter_glob: str
+	filter: str
+	filter_action: Optional[str]
 	kernel_args: Optional[List[str]]
 	run_isolated: Optional[str]
+	list_tests: bool
+	list_tests_attr: bool
=20
 @dataclass
 class KunitRequest(KunitExecRequest, KunitBuildRequest):
@@ -102,19 +106,41 @@ def config_and_build_tests(linux: kunit_kernel.LinuxS=
ourceTree,
=20
 def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecReq=
uest) -> List[str]:
 	args =3D ['kunit.action=3Dlist']
+
+	if request.kernel_args:
+		args.extend(request.kernel_args)
+
+	output =3D linux.run_kernel(args=3Dargs,
+			   timeout=3Drequest.timeout,
+			   filter_glob=3Drequest.filter_glob,
+			   filter=3Drequest.filter,
+			   filter_action=3Drequest.filter_action,
+			   build_dir=3Drequest.build_dir)
+	lines =3D kunit_parser.extract_tap_lines(output)
+	# Hack! Drop the dummy TAP version header that the executor prints out.
+	lines.pop()
+
+	# Filter out any extraneous non-test output that might have gotten mixed =
in.
+	return [l for l in output if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
+
+def _list_tests_attr(linux: kunit_kernel.LinuxSourceTree, request: KunitEx=
ecRequest) -> Iterable[str]:
+	args =3D ['kunit.action=3Dlist_attr']
+
 	if request.kernel_args:
 		args.extend(request.kernel_args)
=20
 	output =3D linux.run_kernel(args=3Dargs,
 			   timeout=3Drequest.timeout,
 			   filter_glob=3Drequest.filter_glob,
+			   filter=3Drequest.filter,
+			   filter_action=3Drequest.filter_action,
 			   build_dir=3Drequest.build_dir)
 	lines =3D kunit_parser.extract_tap_lines(output)
 	# Hack! Drop the dummy TAP version header that the executor prints out.
 	lines.pop()
=20
 	# Filter out any extraneous non-test output that might have gotten mixed =
in.
-	return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
+	return lines
=20
 def _suites_from_test_list(tests: List[str]) -> List[str]:
 	"""Extracts all the suites from an ordered list of tests."""
@@ -128,10 +154,18 @@ def _suites_from_test_list(tests: List[str]) -> List[=
str]:
 			suites.append(suite)
 	return suites
=20
-
-
 def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequ=
est) -> KunitResult:
 	filter_globs =3D [request.filter_glob]
+	if request.list_tests:
+		output =3D _list_tests(linux, request)
+		for line in output:
+			print(line.rstrip())
+		return KunitResult(status=3DKunitStatus.SUCCESS, elapsed_time=3D0.0)
+	if request.list_tests_attr:
+		attr_output =3D _list_tests_attr(linux, request)
+		for line in attr_output:
+			print(line.rstrip())
+		return KunitResult(status=3DKunitStatus.SUCCESS, elapsed_time=3D0.0)
 	if request.run_isolated:
 		tests =3D _list_tests(linux, request)
 		if request.run_isolated =3D=3D 'test':
@@ -155,6 +189,8 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, req=
uest: KunitExecRequest) -
 			args=3Drequest.kernel_args,
 			timeout=3Drequest.timeout,
 			filter_glob=3Dfilter_glob,
+			filter=3Drequest.filter,
+			filter_action=3Drequest.filter_action,
 			build_dir=3Drequest.build_dir)
=20
 		_, test_result =3D parse_tests(request, metadata, run_result)
@@ -341,6 +377,16 @@ def add_exec_opts(parser: argparse.ArgumentParser) -> =
None:
 			    nargs=3D'?',
 			    default=3D'',
 			    metavar=3D'filter_glob')
+	parser.add_argument('--filter',
+			    help=3D'Filter KUnit tests with attributes, '
+			    'e.g. module=3Dexample or speed>slow',
+			    type=3Dstr,
+				default=3D'')
+	parser.add_argument('--filter_action',
+			    help=3D'If set to skip, filtered tests will be skipped, '
+				'e.g. --filter_action=3Dskip. Otherwise they will not run.',
+			    type=3Dstr,
+				choices=3D['skip'])
 	parser.add_argument('--kernel_args',
 			    help=3D'Kernel command-line parameters. Maybe be repeated',
 			     action=3D'append', metavar=3D'')
@@ -350,6 +396,12 @@ def add_exec_opts(parser: argparse.ArgumentParser) -> =
None:
 			    'what ran before it.',
 			    type=3Dstr,
 			    choices=3D['suite', 'test'])
+	parser.add_argument('--list_tests', help=3D'If set, list all tests that w=
ill be '
+			    'run.',
+			    action=3D'store_true')
+	parser.add_argument('--list_tests_attr', help=3D'If set, list all tests a=
nd test '
+			    'attributes.',
+			    action=3D'store_true')
=20
 def add_parse_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--raw_output', help=3D'If set don\'t parse output fr=
om kernel. '
@@ -398,8 +450,12 @@ def run_handler(cli_args: argparse.Namespace) -> None:
 					json=3Dcli_args.json,
 					timeout=3Dcli_args.timeout,
 					filter_glob=3Dcli_args.filter_glob,
+					filter=3Dcli_args.filter,
+					filter_action=3Dcli_args.filter_action,
 					kernel_args=3Dcli_args.kernel_args,
-					run_isolated=3Dcli_args.run_isolated)
+					run_isolated=3Dcli_args.run_isolated,
+					list_tests=3Dcli_args.list_tests,
+					list_tests_attr=3Dcli_args.list_tests_attr)
 	result =3D run_tests(linux, request)
 	if result.status !=3D KunitStatus.SUCCESS:
 		sys.exit(1)
@@ -441,8 +497,12 @@ def exec_handler(cli_args: argparse.Namespace) -> None=
:
 					json=3Dcli_args.json,
 					timeout=3Dcli_args.timeout,
 					filter_glob=3Dcli_args.filter_glob,
+					filter=3Dcli_args.filter,
+					filter_action=3Dcli_args.filter_action,
 					kernel_args=3Dcli_args.kernel_args,
-					run_isolated=3Dcli_args.run_isolated)
+					run_isolated=3Dcli_args.run_isolated,
+					list_tests=3Dcli_args.list_tests,
+					list_tests_attr=3Dcli_args.list_tests_attr)
 	result =3D exec_tests(linux, exec_request)
 	stdout.print_with_timestamp((
 		'Elapsed time: %.3fs\n') % (result.elapsed_time))
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kuni=
t_kernel.py
index 7f648802caf6..0b6488efed47 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -330,11 +330,15 @@ class LinuxSourceTree:
 			return False
 		return self.validate_config(build_dir)
=20
-	def run_kernel(self, args: Optional[List[str]]=3DNone, build_dir: str=3D'=
', filter_glob: str=3D'', timeout: Optional[int]=3DNone) -> Iterator[str]:
+	def run_kernel(self, args: Optional[List[str]]=3DNone, build_dir: str=3D'=
', filter_glob: str=3D'', filter: str=3D'', filter_action: Optional[str]=3D=
None, timeout: Optional[int]=3DNone) -> Iterator[str]:
 		if not args:
 			args =3D []
 		if filter_glob:
-			args.append('kunit.filter_glob=3D'+filter_glob)
+			args.append('kunit.filter_glob=3D' + filter_glob)
+		if filter:
+			args.append('kunit.filter=3D"' + filter + '"')
+		if filter_action:
+			args.append('kunit.filter_action=3D' + filter_action)
 		args.append('kunit.enable=3D1')
=20
 		process =3D self._ops.start(args, build_dir)
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kuni=
t_parser.py
index fbc094f0567e..79d8832c862a 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -212,6 +212,7 @@ KTAP_START =3D re.compile(r'\s*KTAP version ([0-9]+)$')
 TAP_START =3D re.compile(r'\s*TAP version ([0-9]+)$')
 KTAP_END =3D re.compile(r'\s*(List of all partitions:|'
 	'Kernel panic - not syncing: VFS:|reboot: System halted)')
+EXECUTOR_ERROR =3D re.compile(r'\s*kunit executor: (.*)$')
=20
 def extract_tap_lines(kernel_output: Iterable[str]) -> LineStream:
 	"""Extracts KTAP lines from the kernel output."""
@@ -242,6 +243,8 @@ def extract_tap_lines(kernel_output: Iterable[str]) -> =
LineStream:
 				# remove the prefix, if any.
 				line =3D line[prefix_len:]
 				yield line_num, line
+			elif EXECUTOR_ERROR.search(line):
+				yield line_num, line
 	return LineStream(lines=3Disolate_ktap_output(kernel_output))
=20
 KTAP_VERSIONS =3D [1]
@@ -447,7 +450,7 @@ def parse_diagnostic(lines: LineStream) -> List[str]:
 	Log of diagnostic lines
 	"""
 	log =3D []  # type: List[str]
-	non_diagnostic_lines =3D [TEST_RESULT, TEST_HEADER, KTAP_START]
+	non_diagnostic_lines =3D [TEST_RESULT, TEST_HEADER, KTAP_START, TAP_START=
]
 	while lines and not any(re.match(lines.peek())
 			for re in non_diagnostic_lines):
 		log.append(lines.pop())
@@ -713,6 +716,11 @@ def parse_test(lines: LineStream, expected_num: int, l=
og: List[str], is_subtest:
 	"""
 	test =3D Test()
 	test.log.extend(log)
+
+	# Parse any errors prior to parsing tests
+	err_log =3D parse_diagnostic(lines)
+	test.log.extend(err_log)
+
 	if not is_subtest:
 		# If parsing the main/top-level test, parse KTAP version line and
 		# test plan
@@ -774,6 +782,7 @@ def parse_test(lines: LineStream, expected_num: int, lo=
g: List[str], is_subtest:
 		# Don't override a bad status if this test had one reported.
 		# Assumption: no subtests means CRASHED is from Test.__init__()
 		if test.status in (TestStatus.TEST_CRASHED, TestStatus.SUCCESS):
+			print_log(test.log)
 			test.status =3D TestStatus.NO_TESTS
 			test.add_error('0 tests run!')
=20
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/k=
unit_tool_test.py
index be35999bb84f..b28c1510be2e 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -597,7 +597,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3D'', filte=
r_action=3DNone, timeout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_run_passes_args_pass(self):
@@ -605,7 +605,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3D'', filte=
r_action=3DNone, timeout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_exec_passes_args_fail(self):
@@ -629,7 +629,7 @@ class KUnitMainTest(unittest.TestCase):
 			kunit.main(['run'])
 		self.assertEqual(e.exception.code, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3D'', filte=
r_action=3DNone, timeout=3D300)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
=20
 	def test_exec_raw_output(self):
@@ -670,13 +670,13 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel =3D mock.Mock(return_value=3D[])
 		kunit.main(['run', '--raw_output', 'filter_glob'])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'filter_glob', timeout=
=3D300)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'filter_glob', filter=
=3D'', filter_action=3DNone, timeout=3D300)
=20
 	def test_exec_timeout(self):
 		timeout =3D 3453
 		kunit.main(['exec', '--timeout', str(timeout)])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3Dtimeout)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3D'', filte=
r_action=3DNone, timeout=3Dtimeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_run_timeout(self):
@@ -684,7 +684,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3Dtimeout)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3D'', filte=
r_action=3DNone, timeout=3Dtimeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_run_builddir(self):
@@ -692,7 +692,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--build_dir=3D.kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3Dbuild_dir, filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3Dbuild_dir, filter_glob=3D'', filter=3D'', filt=
er_action=3DNone, timeout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_config_builddir(self):
@@ -710,7 +710,7 @@ class KUnitMainTest(unittest.TestCase):
 		build_dir =3D '.kunit'
 		kunit.main(['exec', '--build_dir', build_dir])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3Dbuild_dir, filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3Dbuild_dir, filter_glob=3D'', filter=3D'', filt=
er_action=3DNone, timeout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_run_kunitconfig(self):
@@ -786,7 +786,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--kernel_args=3Da=3D1', '--kernel_args=3Db=3D2'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-		      args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', filter_glob=3D'', =
timeout=3D300)
+		      args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', filter_glob=3D'', =
filter=3D'', filter_action=3DNone, timeout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_list_tests(self):
@@ -794,13 +794,11 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value =3D ['TAP version 14', 'i=
nit: random output'] + want
=20
 		got =3D kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None,=
 'suite'))
-
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', N=
one, None, 'suite', False, False))
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3D['kunit.action=3Dlist'], build_dir=3D'.kunit', filter_glob=3D'su=
ite*', timeout=3D300)
-
+			args=3D['kunit.action=3Dlist'], build_dir=3D'.kunit', filter_glob=3D'su=
ite*', filter=3D'', filter_action=3DNone, timeout=3D300)
=20
 	@mock.patch.object(kunit, '_list_tests')
 	def test_run_isolated_by_suite(self, mock_tests):
@@ -809,10 +807,10 @@ class KUnitMainTest(unittest.TestCase):
=20
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*',=
 None, 'suite'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*',=
 '', None, None, 'suite', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test*=
', timeout=3D300),
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite2.test=
*', timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test*=
', filter=3D'', filter_action=3DNone, timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite2.test=
*', filter=3D'', filter_action=3DNone, timeout=3D300),
 		])
=20
 	@mock.patch.object(kunit, '_list_tests')
@@ -822,13 +820,12 @@ class KUnitMainTest(unittest.TestCase):
=20
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None,=
 'test'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', '', N=
one, None, 'test', False, False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test1=
', timeout=3D300),
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test2=
', timeout=3D300),
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite2.test=
1', timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test1=
', filter=3D'', filter_action=3DNone, timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test2=
', filter=3D'', filter_action=3DNone, timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite2.test=
1', filter=3D'', filter_action=3DNone, timeout=3D300),
 		])
=20
-
 if __name__ =3D=3D '__main__':
 	unittest.main()
--=20
2.41.0.255.g8b1d071c50-goog

