Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79ADC41E3C8
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Oct 2021 00:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348760AbhI3WWt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Sep 2021 18:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348612AbhI3WWo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Sep 2021 18:22:44 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5719AC061771
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:21:01 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id bm12-20020a05620a198c00b00432e14ddb99so14840018qkb.21
        for <linux-kselftest@vger.kernel.org>; Thu, 30 Sep 2021 15:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VVBNov2yygjCVfdkMVAlcm1PHPX4beVk2O1Qv4WyQ5o=;
        b=K1DsnQHoM/mWAmQn5gPc2RmssYVmEMk8pLt9UyXQuFheU/KNxmBEQxjkJ4uezag1VX
         Tpe+6m18+Xio7wuYAmtilTAMNJubzCoEuadNsGLRYSQHnji+SpNJX9u+/aRqxGo7R+PN
         BG6sg2jMUpS75icpBonJjubdf9I4+tr3RXA/HQMHoDlryyUe3pg6tffXJJMAEXFGJt5z
         ACf0oeXv4ltEsdTTHLd6EgMnZLOV8vXi4J7T3Z1KJ5qHYRWIaUm6uI2D9yyY9wa4ZSE2
         n7ecbnbSG6QWTmoZcXBcVOGqMfTqpiH5tVD3CrhZeoQPsKchNF+IiZxKqNAXu8I18jN1
         iMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VVBNov2yygjCVfdkMVAlcm1PHPX4beVk2O1Qv4WyQ5o=;
        b=pj5jBMIUYuJQPWEBN0J9IjN34n3NcThxXdlxt/KA96b6Y5vhLQfdILEIkAlUqgugZq
         pnOwjeC0dAZpZivi9S8PgTl9K7LqLijFoE1f6faRqEU2J4y6uigGvCHbfd2+Pas9kysL
         fea+ZzORkGHGpstn6D16DyVjfjesdUaNxqiDxVepXbqMF+loNjYffKliBt+5z2wjf46h
         phMkxhY5EEVPmrkZ4CWN3RLjK0Kv7IIopcgvc9gPC32DuM0qasN0QLt7Dm3i4Z3BI8Aa
         5K0280t9/zCE/bJdjphX8TBvZYdKl73ziSvHsRnICbGURf+o2o0yVMx8OhrTSbfEn6bF
         rEpQ==
X-Gm-Message-State: AOAM533t8jVJLCb0GNfJkH6ITO0uWpayVU9FqaZs+ABlhsLf/4sOjIvc
        dR/1+i4FA+FyXwOe9RM/G29dKa6qEMVy7g==
X-Google-Smtp-Source: ABdhPJx/OoKNOdWAzJg0hpr2Og4CHA5sYz5fzQ+lsfyL0RkHGYG4gHQ8cIjXqY37U6kvM7WqV3E0WH7nzv4gyQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:39fa:d88:fb3b:880e])
 (user=dlatypov job=sendgmr) by 2002:a0c:df92:: with SMTP id
 w18mr7822248qvl.46.1633040460475; Thu, 30 Sep 2021 15:21:00 -0700 (PDT)
Date:   Thu, 30 Sep 2021 15:20:48 -0700
In-Reply-To: <20210930222048.1692635-1-dlatypov@google.com>
Message-Id: <20210930222048.1692635-5-dlatypov@google.com>
Mime-Version: 1.0
References: <20210930222048.1692635-1-dlatypov@google.com>
X-Mailer: git-send-email 2.33.0.800.g4c38ced690-goog
Subject: [PATCH v4 4/4] kunit: tool: support running each suite/test separately
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The new --run_isolated flag makes the tool boot the kernel once per
suite or test, preventing leftover state from one suite to impact the
other. This can be useful as a starting point to debugging test
hermeticity issues.

Note: it takes a lot longer, so people should not use it normally.

Consider the following very simplified example:

  bool disable_something_for_test = false;
  void function_being_tested() {
    ...
    if (disable_something_for_test) return;
    ...
  }

  static void test_before(struct kunit *test)
  {
    disable_something_for_test = true;
    function_being_tested();
    /* oops, we forgot to reset it back to false */
  }

  static void test_after(struct kunit *test)
  {
    /* oops, now "fixing" test_before can cause test_after to fail! */
    function_being_tested();
  }

Presented like this, the issues are obvious, but it gets a lot more
complicated to track down as the amount of test setup and helper
functions increases.

Another use case is memory corruption. It might not be surfaced as a
failure/crash in the test case or suite that caused it. I've noticed in
kunit's own unit tests, the 3rd suite after might be the one to finally
crash after an out-of-bounds write, for example.

Example usage:

Per suite:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite
...
Starting KUnit Kernel (1/7)...
============================================================
======== [PASSED] kunit_executor_test ========
....
Testing complete. 5 tests run. 0 failed. 0 crashed. 0 skipped.
Starting KUnit Kernel (2/7)...
============================================================
======== [PASSED] kunit-try-catch-test ========
...

Per test:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=test
Starting KUnit Kernel (1/23)...
============================================================
======== [PASSED] kunit_executor_test ========
[PASSED] parse_filter_test
============================================================
Testing complete. 1 tests run. 0 failed. 0 crashed. 0 skipped.
Starting KUnit Kernel (2/23)...
============================================================
======== [PASSED] kunit_executor_test ========
[PASSED] filter_subsuite_test
...

It works with filters as well:
$ ./tools/testing/kunit/kunit.py run --kunitconfig=lib/kunit --run_isolated=suite example
...
Starting KUnit Kernel (1/1)...
============================================================
======== [PASSED] example ========
...

It also handles test filters, '*.*skip*' runs these 3 tests:
  kunit_status.kunit_status_mark_skipped_test
  example.example_skip_test
  example.example_mark_skipped_test

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py           | 100 +++++++++++++++++++------
 tools/testing/kunit/kunit_tool_test.py |  40 ++++++++++
 2 files changed, 118 insertions(+), 22 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 5e717594df5b..8c7e8c7b2c97 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -8,15 +8,16 @@
 # Author: Brendan Higgins <brendanhiggins@google.com>
 
 import argparse
-import sys
 import os
+import re
+import sys
 import time
 
 assert sys.version_info >= (3, 7), "Python version is too old"
 
 from collections import namedtuple
 from enum import Enum, auto
-from typing import Iterable
+from typing import Iterable, List
 
 import kunit_config
 import kunit_json
@@ -31,13 +32,13 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 			       ['jobs', 'build_dir', 'alltests',
 				'make_options'])
 KunitExecRequest = namedtuple('KunitExecRequest',
-                              ['timeout', 'build_dir', 'alltests',
-                               'filter_glob', 'kernel_args'])
+			      ['timeout', 'build_dir', 'alltests',
+			       'filter_glob', 'kernel_args', 'run_isolated'])
 KunitParseRequest = namedtuple('KunitParseRequest',
 			       ['raw_output', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'alltests', 'filter_glob',
-					   'kernel_args', 'json', 'make_options'])
+					   'kernel_args', 'run_isolated', 'json', 'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
@@ -91,23 +92,70 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 			   'built kernel successfully',
 			   build_end - build_start)
 
+def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
+	args = ['kunit.action=list']
+	if request.kernel_args:
+		args.extend(request.kernel_args)
+
+	output = linux.run_kernel(args=args,
+			   timeout=None if request.alltests else request.timeout,
+			   filter_glob=request.filter_glob,
+			   build_dir=request.build_dir)
+	lines = kunit_parser.extract_tap_lines(output)
+	# Hack! Drop the dummy TAP version header that the executor prints out.
+	lines.pop()
+
+	# Filter out any extraneous non-test output that might have gotten mixed in.
+	return [l for l in lines if re.match('^[^\s.]+\.[^\s.]+$', l)]
+
+def _suites_from_test_list(tests: List[str]) -> List[str]:
+	"""Extracts all the suites from an ordered list of tests."""
+	suites = []  # type: List[str]
+	for t in tests:
+		parts = t.split('.', maxsplit=2)
+		if len(parts) != 2:
+			raise ValueError(f'internal KUnit error, test name should be of the form "<suite>.<test>", got "{t}"')
+		suite, case = parts
+		if not suites or suites[-1] != suite:
+			suites.append(suite)
+	return suites
+
+
+
 def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
 	       parse_request: KunitParseRequest) -> KunitResult:
-	kunit_parser.print_with_timestamp('Starting KUnit Kernel ...')
-	test_start = time.time()
-	run_result = linux.run_kernel(
-		args=request.kernel_args,
-		timeout=None if request.alltests else request.timeout,
-		filter_glob=request.filter_glob,
-		build_dir=request.build_dir)
-
-	result = parse_tests(parse_request, run_result)
-
-	# run_kernel() doesn't block on the kernel exiting.
-	# That only happens after we get the last line of output from `run_result`.
-	# So exec_time here actually contains parsing + execution time, which is fine.
-	test_end = time.time()
-	exec_time = test_end - test_start
+	filter_globs = [request.filter_glob]
+	if request.run_isolated:
+		tests = _list_tests(linux, request)
+		if request.run_isolated == 'test':
+			filter_globs = tests
+		if request.run_isolated == 'suite':
+			filter_globs = _suites_from_test_list(tests)
+			# Apply the test-part of the user's glob, if present.
+			if '.' in request.filter_glob:
+				test_glob = request.filter_glob.split('.', maxsplit=2)[1]
+				filter_globs = [g + '.'+ test_glob for g in filter_globs]
+
+	overall_status = kunit_parser.TestStatus.SUCCESS
+	exec_time = 0.0
+	for i, filter_glob in enumerate(filter_globs):
+		kunit_parser.print_with_timestamp('Starting KUnit Kernel ({}/{})...'.format(i+1, len(filter_globs)))
+
+		test_start = time.time()
+		run_result = linux.run_kernel(
+			args=request.kernel_args,
+			timeout=None if request.alltests else request.timeout,
+			filter_glob=filter_glob,
+			build_dir=request.build_dir)
+
+		result = parse_tests(parse_request, run_result)
+		# run_kernel() doesn't block on the kernel exiting.
+		# That only happens after we get the last line of output from `run_result`.
+		# So exec_time here actually contains parsing + execution time, which is fine.
+		test_end = time.time()
+		exec_time += test_end - test_start
+
+		overall_status = kunit_parser.max_status(overall_status, result.status)
 
 	return KunitResult(status=result.status, result=result.result, elapsed_time=exec_time)
 
@@ -168,7 +216,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 
 	exec_request = KunitExecRequest(request.timeout, request.build_dir,
 				 request.alltests, request.filter_glob,
-				 request.kernel_args)
+				 request.kernel_args, request.run_isolated)
 	parse_request = KunitParseRequest(request.raw_output,
 					  request.build_dir,
 					  request.json)
@@ -252,6 +300,12 @@ def add_exec_opts(parser) -> None:
 	parser.add_argument('--kernel_args',
 			    help='Kernel command-line parameters. Maybe be repeated',
 			     action='append')
+	parser.add_argument('--run_isolated', help='If set, boot the kernel for each '
+			    'individual suite/test. This is can be useful for debugging '
+			    'a non-hermetic test, one that might pass/fail based on '
+			    'what ran before it.',
+			    type=str,
+			    choices=['suite', 'test']),
 
 def add_parse_opts(parser) -> None:
 	parser.add_argument('--raw_output', help='If set don\'t format output from kernel. '
@@ -325,6 +379,7 @@ def main(argv, linux=None):
 				       cli_args.alltests,
 				       cli_args.filter_glob,
 				       cli_args.kernel_args,
+				       cli_args.run_isolated,
 				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
@@ -380,7 +435,8 @@ def main(argv, linux=None):
 						cli_args.build_dir,
 						cli_args.alltests,
 						cli_args.filter_glob,
-						cli_args.kernel_args)
+						cli_args.kernel_args,
+						cli_args.run_isolated)
 		parse_request = KunitParseRequest(cli_args.raw_output,
 						  cli_args.build_dir,
 						  cli_args.json)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 619c4554cbff..3251cef25b76 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -477,6 +477,46 @@ class KUnitMainTest(unittest.TestCase):
 		      args=['a=1','b=2'], build_dir='.kunit', filter_glob='', timeout=300)
 		self.print_mock.assert_any_call(StrContains('Testing complete.'))
 
+	def test_list_tests(self):
+		want = ['suite.test1', 'suite.test2', 'suite2.test1']
+		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
+
+		got = kunit._list_tests(self.linux_source_mock,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'suite'))
+
+		self.assertEqual(got, want)
+		# Should respect the user's filter glob when listing tests.
+		self.linux_source_mock.run_kernel.assert_called_once_with(
+			args=['kunit.action=list'], build_dir='.kunit', filter_glob='suite*', timeout=300)
+
+
+	@mock.patch.object(kunit, '_list_tests')
+	def test_run_isolated_by_suite(self, mock_tests):
+		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
+		kunit.main(['exec', '--run_isolated=suite', 'suite*.test*'], self.linux_source_mock)
+
+		# Should respect the user's filter glob when listing tests.
+		mock_tests.assert_called_once_with(mock.ANY,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*.test*', None, 'suite'))
+		self.linux_source_mock.run_kernel.assert_has_calls([
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
+		])
+
+	@mock.patch.object(kunit, '_list_tests')
+	def test_run_isolated_by_test(self, mock_tests):
+		mock_tests.return_value = ['suite.test1', 'suite.test2', 'suite2.test1']
+		kunit.main(['exec', '--run_isolated=test', 'suite*'], self.linux_source_mock)
+
+		# Should respect the user's filter glob when listing tests.
+		mock_tests.assert_called_once_with(mock.ANY,
+				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'test'))
+		self.linux_source_mock.run_kernel.assert_has_calls([
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
+			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test1', timeout=300),
+		])
+
 
 if __name__ == '__main__':
 	unittest.main()
-- 
2.33.0.800.g4c38ced690-goog

