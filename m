Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6707472A720
	for <lists+linux-kselftest@lfdr.de>; Sat, 10 Jun 2023 02:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjFJAwS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 9 Jun 2023 20:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbjFJAwR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 9 Jun 2023 20:52:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC95D30E5
        for <linux-kselftest@vger.kernel.org>; Fri,  9 Jun 2023 17:52:14 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb39aebdd87so5208453276.0
        for <linux-kselftest@vger.kernel.org>; Fri, 09 Jun 2023 17:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686358334; x=1688950334;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBsX1t2HFlz4ikZu05s+Ij9XO4LQtrN6NyLytDkTSA4=;
        b=Sn2Dd/x48qKkeIH4X8r0VPCdNgCpAfZC4xE9ujjDXRue4B+pfHp1HmaywFTo0K3+6o
         lIMdQITumf52CzC5mIO9rOY+PwTnj+07s0iqrmtJgtRE2Z8oTSd6T6sNPkPhlZnY9osq
         nfZiY0EuUD6jsHoET9sCuAxNiGJ9Hf9JR+wKeOS4o+tt+EjPPcW891tA3Mq4kGdCXoVL
         SnYw+lK2w+y7vTZIL5IyuiT+SEO32BbAhL6HWhvz289unvwaZ7++RyMiK1UTmhtSO8bG
         3aBMxvhnYHTlNasVxX5xJjtP5RRCRCcYd4kAdxCQjIhdVpM4D8LZF/q+hgEfBSnUqHeR
         7qvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686358334; x=1688950334;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uBsX1t2HFlz4ikZu05s+Ij9XO4LQtrN6NyLytDkTSA4=;
        b=IxGpTjfOwRq7tYjhFXA7XOa0FiZHn1l8O3mFYXs71Dy0MDb9sw6lvMnup4GG7it1WV
         1bH007TTnXkmy7hwSq8HdlN6mrPqIN9EqjXVfwWWpXENNa386+qIypcdY6TCGOhcibe1
         mr5KkIPipgwQwE8ODarzoV3tu/Qv1hVnXQ62gP/VSfp7FlUGOb7uZajCdeL84qeFbB7e
         uxDzPQfpEWU3Je4NbMerHfGcinMswyFby5EZpWfAvGIeABDsmRUXlWGL/wqrtpnj29mc
         fFv7j51Y2DP+wnTKkb1HqdsdCnnfS3D4kKC2BDmNPiMJ4Oh2JfRZhmZQPYlVwc7YEXti
         /J+g==
X-Gm-Message-State: AC+VfDz/USH44pqiazuwEj2z4NXUU4ubqlq3k0KftiwOB5rw+KU9ewmN
        A3pKHO9bGC0RT+gQRWOa2BDwNPjGYA==
X-Google-Smtp-Source: ACHHUZ7SEar8r2ciV3/3VZaJyuZQBccjH4OUT8kuimqEuwg1KKuOjTcXWu1yCDpCVeSKtPjG3+Q6ZcY4OQ==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a25:8c07:0:b0:bad:2b06:da3 with SMTP id
 k7-20020a258c07000000b00bad2b060da3mr2079249ybl.3.1686358333943; Fri, 09 Jun
 2023 17:52:13 -0700 (PDT)
Date:   Sat, 10 Jun 2023 00:51:47 +0000
In-Reply-To: <20230610005149.1145665-1-rmoar@google.com>
Mime-Version: 1.0
References: <20230610005149.1145665-1-rmoar@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230610005149.1145665-5-rmoar@google.com>
Subject: [RFC v1 4/6] kunit: tool: Add command line interface to filter and
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add ability to use kunit.py to filter attributes and to report a list of
tests including attributes without running tests.

Add flag "--filter" to input filters on test attributes. Tests will be
filtered out if they do not match all inputted filters.

Example: --filter speed=3Dslow

This filter would run only the tests that are marked as slow. Note there
cannot be spaces within a filter.

As said in the previous patch, filters can have different operations: <, >,
<=3D, >=3D, !=3D, and =3D. Note that the characters < and > are often inter=
preted
by the shell, so they may need to be quoted or escaped.

Example: --filter "speed>=3Dnormal" or =E2=80=93filter speed\>=3Dnormal

This filter would run only the tests that have the speed faster than or
equal to normal.

Add flag "--list_tests" to output a list of tests and their attributes
without running tests. This will be useful to see test attributes and which
tests will run with given filters.

Example of the output of these tests:
  example
  example.test_1
  example.test_2
  # example.test_2.speed: slow

This output includes a suite, example, with two test cases, test_1 and
test_2. And in this instance test_2 has been marked as slow.

Signed-off-by: Rae Moar <rmoar@google.com>
---
 tools/testing/kunit/kunit.py           | 34 +++++++++++++++++----
 tools/testing/kunit/kunit_kernel.py    |  6 ++--
 tools/testing/kunit/kunit_tool_test.py | 41 +++++++++++++-------------
 3 files changed, 54 insertions(+), 27 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 3905c43369c3..661c39f7acf5 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -55,8 +55,10 @@ class KunitExecRequest(KunitParseRequest):
 	build_dir: str
 	timeout: int
 	filter_glob: str
+	filter: Optional[List[str]]
 	kernel_args: Optional[List[str]]
 	run_isolated: Optional[str]
+	list_tests: Optional[bool]
=20
 @dataclass
 class KunitRequest(KunitExecRequest, KunitBuildRequest):
@@ -100,7 +102,7 @@ def config_and_build_tests(linux: kunit_kernel.LinuxSou=
rceTree,
=20
 	return build_tests(linux, request)
=20
-def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecReq=
uest) -> List[str]:
+def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecReq=
uest) -> Iterable[str]:
 	args =3D ['kunit.action=3Dlist']
 	if request.kernel_args:
 		args.extend(request.kernel_args)
@@ -108,13 +110,17 @@ def _list_tests(linux: kunit_kernel.LinuxSourceTree, =
request: KunitExecRequest)
 	output =3D linux.run_kernel(args=3Dargs,
 			   timeout=3Drequest.timeout,
 			   filter_glob=3Drequest.filter_glob,
+			   filter=3Drequest.filter,
 			   build_dir=3Drequest.build_dir)
 	lines =3D kunit_parser.extract_tap_lines(output)
 	# Hack! Drop the dummy TAP version header that the executor prints out.
 	lines.pop()
=20
 	# Filter out any extraneous non-test output that might have gotten mixed =
in.
-	return [l for l in lines if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
+	return output
+
+def _get_tests(output: Iterable[str]) -> List[str]:
+	return [l for l in output if re.match(r'^[^\s.]+\.[^\s.]+$', l)]
=20
 def _suites_from_test_list(tests: List[str]) -> List[str]:
 	"""Extracts all the suites from an ordered list of tests."""
@@ -132,8 +138,14 @@ def _suites_from_test_list(tests: List[str]) -> List[s=
tr]:
=20
 def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequ=
est) -> KunitResult:
 	filter_globs =3D [request.filter_glob]
+	if request.list_tests:
+		output =3D _list_tests(linux, request)
+		for line in output:
+			print(line.rstrip())
+		return KunitResult(status=3DKunitStatus.SUCCESS, elapsed_time=3D0.0)
 	if request.run_isolated:
-		tests =3D _list_tests(linux, request)
+		output =3D _list_tests(linux, request)
+		tests =3D _get_tests(output)
 		if request.run_isolated =3D=3D 'test':
 			filter_globs =3D tests
 		elif request.run_isolated =3D=3D 'suite':
@@ -155,6 +167,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, req=
uest: KunitExecRequest) -
 			args=3Drequest.kernel_args,
 			timeout=3Drequest.timeout,
 			filter_glob=3Dfilter_glob,
+			filter=3Drequest.filter,
 			build_dir=3Drequest.build_dir)
=20
 		_, test_result =3D parse_tests(request, metadata, run_result)
@@ -341,6 +354,11 @@ def add_exec_opts(parser: argparse.ArgumentParser) -> =
None:
 			    nargs=3D'?',
 			    default=3D'',
 			    metavar=3D'filter_glob')
+	parser.add_argument('--filter',
+			    help=3D'Filter which KUnit tests run by attributes'
+			    'e.g. speed=3Dfast or speed=3D>low',
+			    type=3Dstr,
+			    nargs=3D'*')
 	parser.add_argument('--kernel_args',
 			    help=3D'Kernel command-line parameters. Maybe be repeated',
 			     action=3D'append', metavar=3D'')
@@ -350,6 +368,8 @@ def add_exec_opts(parser: argparse.ArgumentParser) -> N=
one:
 			    'what ran before it.',
 			    type=3Dstr,
 			    choices=3D['suite', 'test'])
+	parser.add_argument('--list_tests', help=3D'If set, list all tests and at=
tributes.',
+			    action=3D'store_true')
=20
 def add_parse_opts(parser: argparse.ArgumentParser) -> None:
 	parser.add_argument('--raw_output', help=3D'If set don\'t parse output fr=
om kernel. '
@@ -398,8 +418,10 @@ def run_handler(cli_args: argparse.Namespace) -> None:
 					json=3Dcli_args.json,
 					timeout=3Dcli_args.timeout,
 					filter_glob=3Dcli_args.filter_glob,
+					filter=3Dcli_args.filter,
 					kernel_args=3Dcli_args.kernel_args,
-					run_isolated=3Dcli_args.run_isolated)
+					run_isolated=3Dcli_args.run_isolated,
+					list_tests=3Dcli_args.list_tests)
 	result =3D run_tests(linux, request)
 	if result.status !=3D KunitStatus.SUCCESS:
 		sys.exit(1)
@@ -441,8 +463,10 @@ def exec_handler(cli_args: argparse.Namespace) -> None=
:
 					json=3Dcli_args.json,
 					timeout=3Dcli_args.timeout,
 					filter_glob=3Dcli_args.filter_glob,
+					filter=3Dcli_args.filter,
 					kernel_args=3Dcli_args.kernel_args,
-					run_isolated=3Dcli_args.run_isolated)
+					run_isolated=3Dcli_args.run_isolated,
+					list_tests=3Dcli_args.list_tests)
 	result =3D exec_tests(linux, exec_request)
 	stdout.print_with_timestamp((
 		'Elapsed time: %.3fs\n') % (result.elapsed_time))
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kuni=
t_kernel.py
index 7f648802caf6..62cb8200f60e 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -330,11 +330,13 @@ class LinuxSourceTree:
 			return False
 		return self.validate_config(build_dir)
=20
-	def run_kernel(self, args: Optional[List[str]]=3DNone, build_dir: str=3D'=
', filter_glob: str=3D'', timeout: Optional[int]=3DNone) -> Iterator[str]:
+	def run_kernel(self, args: Optional[List[str]]=3DNone, build_dir: str=3D'=
', filter_glob: str=3D'', filter: Optional[List[str]]=3DNone, timeout: Opti=
onal[int]=3DNone) -> Iterator[str]:
 		if not args:
 			args =3D []
 		if filter_glob:
-			args.append('kunit.filter_glob=3D'+filter_glob)
+			args.append('kunit.filter_glob=3D' + filter_glob)
+		if filter:
+			args.append('kunit.filter=3D' + (','.join(filter)))
 		args.append('kunit.enable=3D1')
=20
 		process =3D self._ops.start(args, build_dir)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/k=
unit_tool_test.py
index be35999bb84f..4a7f3112d06c 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -14,6 +14,7 @@ import tempfile, shutil # Handling test_tmpdir
 import itertools
 import json
 import os
+import re
 import signal
 import subprocess
 from typing import Iterable
@@ -597,7 +598,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3DNone, tim=
eout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_run_passes_args_pass(self):
@@ -605,7 +606,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3DNone, tim=
eout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_exec_passes_args_fail(self):
@@ -629,7 +630,7 @@ class KUnitMainTest(unittest.TestCase):
 			kunit.main(['run'])
 		self.assertEqual(e.exception.code, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3DNone, tim=
eout=3D300)
 		self.print_mock.assert_any_call(StrContains(' 0 tests run!'))
=20
 	def test_exec_raw_output(self):
@@ -670,13 +671,13 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel =3D mock.Mock(return_value=3D[])
 		kunit.main(['run', '--raw_output', 'filter_glob'])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'filter_glob', timeout=
=3D300)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'filter_glob', filter=
=3DNone, timeout=3D300)
=20
 	def test_exec_timeout(self):
 		timeout =3D 3453
 		kunit.main(['exec', '--timeout', str(timeout)])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3Dtimeout)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3DNone, tim=
eout=3Dtimeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_run_timeout(self):
@@ -684,7 +685,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--timeout', str(timeout)])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', timeout=3Dtimeout)
+			args=3DNone, build_dir=3D'.kunit', filter_glob=3D'', filter=3DNone, tim=
eout=3Dtimeout)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_run_builddir(self):
@@ -692,7 +693,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--build_dir=3D.kunit'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3Dbuild_dir, filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3Dbuild_dir, filter_glob=3D'', filter=3DNone, ti=
meout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_config_builddir(self):
@@ -710,7 +711,7 @@ class KUnitMainTest(unittest.TestCase):
 		build_dir =3D '.kunit'
 		kunit.main(['exec', '--build_dir', build_dir])
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3DNone, build_dir=3Dbuild_dir, filter_glob=3D'', timeout=3D300)
+			args=3DNone, build_dir=3Dbuild_dir, filter_glob=3D'', filter=3DNone, ti=
meout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_run_kunitconfig(self):
@@ -786,7 +787,7 @@ class KUnitMainTest(unittest.TestCase):
 		kunit.main(['run', '--kernel_args=3Da=3D1', '--kernel_args=3Db=3D2'])
 		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-		      args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', filter_glob=3D'', =
timeout=3D300)
+		      args=3D['a=3D1','b=3D2'], build_dir=3D'.kunit', filter_glob=3D'', =
filter=3DNone, timeout=3D300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
=20
 	def test_list_tests(self):
@@ -794,12 +795,13 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value =3D ['TAP version 14', 'i=
nit: random output'] + want
=20
 		got =3D kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None,=
 'suite'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None,=
 None, 'suite', False))
+		tests =3D kunit._get_tests(got)
=20
-		self.assertEqual(got, want)
+		self.assertEqual(tests, want)
 		# Should respect the user's filter glob when listing tests.
 		self.linux_source_mock.run_kernel.assert_called_once_with(
-			args=3D['kunit.action=3Dlist'], build_dir=3D'.kunit', filter_glob=3D'su=
ite*', timeout=3D300)
+			args=3D['kunit.action=3Dlist'], build_dir=3D'.kunit', filter_glob=3D'su=
ite*', filter=3DNone, timeout=3D300)
=20
=20
 	@mock.patch.object(kunit, '_list_tests')
@@ -809,10 +811,10 @@ class KUnitMainTest(unittest.TestCase):
=20
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*',=
 None, 'suite'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*.test*',=
 None, None, 'suite', False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test*=
', timeout=3D300),
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite2.test=
*', timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test*=
', filter=3DNone, timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite2.test=
*', filter=3DNone, timeout=3D300),
 		])
=20
 	@mock.patch.object(kunit, '_list_tests')
@@ -822,13 +824,12 @@ class KUnitMainTest(unittest.TestCase):
=20
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None,=
 'test'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, 'suite*', None,=
 None, 'test', False))
 		self.linux_source_mock.run_kernel.assert_has_calls([
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test1=
', timeout=3D300),
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test2=
', timeout=3D300),
-			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite2.test=
1', timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test1=
', filter=3DNone, timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite.test2=
', filter=3DNone, timeout=3D300),
+			mock.call(args=3DNone, build_dir=3D'.kunit', filter_glob=3D'suite2.test=
1', filter=3DNone, timeout=3D300),
 		])
=20
-
 if __name__ =3D=3D '__main__':
 	unittest.main()
--=20
2.41.0.162.gfafddb0af9-goog

