Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ACC427581
	for <lists+linux-kselftest@lfdr.de>; Sat,  9 Oct 2021 03:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhJIB4O (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 8 Oct 2021 21:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbhJIB4O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 8 Oct 2021 21:56:14 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDA7C061570
        for <linux-kselftest@vger.kernel.org>; Fri,  8 Oct 2021 18:54:18 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t3-20020a056214154300b00383496932feso3281521qvw.6
        for <linux-kselftest@vger.kernel.org>; Fri, 08 Oct 2021 18:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=76p5MfvWGdwgnPxyAjvl4ZNMkG5vyADIcjc+KTZ0VLI=;
        b=Chzs3PWcNNhn8atVsXvU5xbtTKp9v03XRcUaIQlfRAi6Z92Ln3/UerWQvw7iAUguex
         0OQfmH0CI5eiRMXm+Tg+aUQ7RUcAVXwHEhwDGRQBYSzdncJn14B0u9hpxxtm0XZ0rD8t
         J2Ie9fU6G4OZ/6CVU1Z3xJpNO+g5GhSCkTqskkfP6rl870Z7AkLBDA5euXRgwgxDFu9N
         5K/lzQBqhdDqJNyC+9089GXQ/yh64cmnQRDxfTkP2Jq2xnwCyFw+ZD0qO/p9UcOMcUwg
         98QdGMomgEh0gIPmDwJ9P7BBvRgTUSSNlNY+Zvknqsu/u/zlhAyFIqdkB3DqsvvFPcyA
         jSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=76p5MfvWGdwgnPxyAjvl4ZNMkG5vyADIcjc+KTZ0VLI=;
        b=Hr1HT3u1++woRiYzY7w5yhyrqAUCibhANm1m2RwNUAA72HN8hYN4qnUsINHhkszzrs
         qtM60zc2koM/IO/UIitjOCgbI+AZq7D1yFfDeK3HaSFhmvBFSpkVW0emx0szeL9rRRjw
         ro+MfEOU6Rssm2GU3jXNati3G7c8NhVXqcZXIlkC94xDo/7p1f07pRL0unnmzYFoCQxn
         jQLRb2ga71RvhsDLcCUMvCkycoRL0RDNQRATbYHaXYSv6JjFCHRiT0RtscAScOUUGwv/
         OSvND3uHN0zVRHG9T6+y4mInjknue1W2+I+TY5LdCr9AMMSaO23JKdROUm6EWGjxcG0l
         eKvQ==
X-Gm-Message-State: AOAM531gGpbafA4OdI3l0EuyBPTqNRXC85Siv4iHKCtqVt8vXpgqgbJ2
        Ute25lPiZDsFAbcYCWm7B6b75/CX86O8RQ==
X-Google-Smtp-Source: ABdhPJwmD1xs2RsWk/c6qQMb40ItPikYaYoMbdjAvJqHFKg0LeD3Gl1ATx8YZfcMbjmOANvoaB/jeWkQ+7XFVA==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:fc52:cec:3819:b41f])
 (user=dlatypov job=sendgmr) by 2002:ac8:3e82:: with SMTP id
 y2mr1861044qtf.284.1633744457242; Fri, 08 Oct 2021 18:54:17 -0700 (PDT)
Date:   Fri,  8 Oct 2021 18:54:05 -0700
Message-Id: <20211009015406.1311319-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH 1/2] kunit: tool: use dataclass instead of collections.namedtuple
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

namedtuple is a terse way of defining a collection of fields.
However, it does not allow us to annotate the type of these fields.
It also doesn't let us have any sort of inheritance between types.

Since commit df4b0807ca1a ("kunit: tool: Assert the version
requirement"), kunit.py has asserted that it's running on python >=3.7.

So in that case use a 3.7 feature, dataclasses, to replace these.

Changes in detail:
* Make KunitExecRequest contain all the fields needed for exec_tests
* Use inheritance to dedupe fields
  * also allows us to e.g. pass a KUnitRequest in as a KUnitParseRequest
  * this has changed around the order of some fields
* Use named arguments when constructing all request objects in kunit.py
  * This is to prevent accidentally mixing up fields, etc.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py           | 139 +++++++++++++------------
 tools/testing/kunit/kunit_tool_test.py |   6 +-
 2 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 9c9ed4071e9e..f879414a13c4 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -15,38 +15,57 @@ import time
 
 assert sys.version_info >= (3, 7), "Python version is too old"
 
-from collections import namedtuple
+from dataclasses import dataclass
 from enum import Enum, auto
-from typing import Iterable, List
+from typing import Any, Iterable, List, Optional
 
 import kunit_json
 import kunit_kernel
 import kunit_parser
 
-KunitResult = namedtuple('KunitResult', ['status','result','elapsed_time'])
-
-KunitConfigRequest = namedtuple('KunitConfigRequest',
-				['build_dir', 'make_options'])
-KunitBuildRequest = namedtuple('KunitBuildRequest',
-			       ['jobs', 'build_dir', 'alltests',
-				'make_options'])
-KunitExecRequest = namedtuple('KunitExecRequest',
-			      ['timeout', 'build_dir', 'alltests',
-			       'filter_glob', 'kernel_args', 'run_isolated'])
-KunitParseRequest = namedtuple('KunitParseRequest',
-			       ['raw_output', 'build_dir', 'json'])
-KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'alltests', 'filter_glob',
-					   'kernel_args', 'run_isolated', 'json', 'make_options'])
-
-KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
-
 class KunitStatus(Enum):
 	SUCCESS = auto()
 	CONFIG_FAILURE = auto()
 	BUILD_FAILURE = auto()
 	TEST_FAILURE = auto()
 
+@dataclass
+class KunitResult:
+	status: KunitStatus
+	result: Any
+	elapsed_time: float
+
+@dataclass
+class KunitConfigRequest:
+	build_dir: str
+	make_options: Optional[List[str]]
+
+@dataclass
+class KunitBuildRequest(KunitConfigRequest):
+	jobs: int
+	alltests: bool
+
+@dataclass
+class KunitParseRequest:
+	raw_output: Optional[str]
+	build_dir: str
+	json: Optional[str]
+
+@dataclass
+class KunitExecRequest(KunitParseRequest):
+	timeout: int
+	alltests: bool
+	filter_glob: str
+	kernel_args: Optional[List[str]]
+	run_isolated: Optional[str]
+
+@dataclass
+class KunitRequest(KunitExecRequest, KunitBuildRequest):
+	pass
+
+
+KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
+
 def get_kernel_root_path() -> str:
 	path = sys.argv[0] if not __file__ else __file__
 	parts = os.path.realpath(path).split('tools/testing/kunit')
@@ -121,8 +140,7 @@ def _suites_from_test_list(tests: List[str]) -> List[str]:
 
 
 
-def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
-	       parse_request: KunitParseRequest) -> KunitResult:
+def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> KunitResult:
 	filter_globs = [request.filter_glob]
 	if request.run_isolated:
 		tests = _list_tests(linux, request)
@@ -147,7 +165,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
 			filter_glob=filter_glob,
 			build_dir=request.build_dir)
 
-		result = parse_tests(parse_request, run_result)
+		result = parse_tests(request, run_result)
 		# run_kernel() doesn't block on the kernel exiting.
 		# That only happens after we get the last line of output from `run_result`.
 		# So exec_time here actually contains parsing + execution time, which is fine.
@@ -211,27 +229,15 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
 	run_start = time.time()
 
-	config_request = KunitConfigRequest(request.build_dir,
-					    request.make_options)
-	config_result = config_tests(linux, config_request)
+	config_result = config_tests(linux, request)
 	if config_result.status != KunitStatus.SUCCESS:
 		return config_result
 
-	build_request = KunitBuildRequest(request.jobs, request.build_dir,
-					  request.alltests,
-					  request.make_options)
-	build_result = build_tests(linux, build_request)
+	build_result = build_tests(linux, request)
 	if build_result.status != KunitStatus.SUCCESS:
 		return build_result
 
-	exec_request = KunitExecRequest(request.timeout, request.build_dir,
-				 request.alltests, request.filter_glob,
-				 request.kernel_args, request.run_isolated)
-	parse_request = KunitParseRequest(request.raw_output,
-					  request.build_dir,
-					  request.json)
-
-	exec_result = exec_tests(linux, exec_request, parse_request)
+	exec_result = exec_tests(linux, request)
 
 	run_end = time.time()
 
@@ -382,16 +388,16 @@ def main(argv, linux=None):
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
 
-		request = KunitRequest(cli_args.raw_output,
-				       cli_args.timeout,
-				       cli_args.jobs,
-				       cli_args.build_dir,
-				       cli_args.alltests,
-				       cli_args.filter_glob,
-				       cli_args.kernel_args,
-				       cli_args.run_isolated,
-				       cli_args.json,
-				       cli_args.make_options)
+		request = KunitRequest(build_dir=cli_args.build_dir,
+				       make_options=cli_args.make_options,
+				       jobs=cli_args.jobs,
+				       alltests=cli_args.alltests,
+				       raw_output=cli_args.raw_output,
+				       json=cli_args.json,
+				       timeout=cli_args.timeout,
+				       filter_glob=cli_args.filter_glob,
+				       kernel_args=cli_args.kernel_args,
+				       run_isolated=cli_args.run_isolated)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
@@ -407,8 +413,8 @@ def main(argv, linux=None):
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
 
-		request = KunitConfigRequest(cli_args.build_dir,
-					     cli_args.make_options)
+		request = KunitConfigRequest(build_dir=cli_args.build_dir,
+					     make_options=cli_args.make_options)
 		result = config_tests(linux, request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
@@ -423,10 +429,10 @@ def main(argv, linux=None):
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
 
-		request = KunitBuildRequest(cli_args.jobs,
-					    cli_args.build_dir,
-					    cli_args.alltests,
-					    cli_args.make_options)
+		request = KunitBuildRequest(build_dir=cli_args.build_dir,
+					    make_options=cli_args.make_options,
+					    jobs=cli_args.jobs,
+					    alltests=cli_args.alltests)
 		result = build_tests(linux, request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
@@ -441,16 +447,15 @@ def main(argv, linux=None):
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
 
-		exec_request = KunitExecRequest(cli_args.timeout,
-						cli_args.build_dir,
-						cli_args.alltests,
-						cli_args.filter_glob,
-						cli_args.kernel_args,
-						cli_args.run_isolated)
-		parse_request = KunitParseRequest(cli_args.raw_output,
-						  cli_args.build_dir,
-						  cli_args.json)
-		result = exec_tests(linux, exec_request, parse_request)
+		exec_request = KunitExecRequest(raw_output=cli_args.raw_output,
+						build_dir=cli_args.build_dir,
+						json=cli_args.json,
+						timeout=cli_args.timeout,
+						alltests=cli_args.alltests,
+						filter_glob=cli_args.filter_glob,
+						kernel_args=cli_args.kernel_args,
+						run_isolated=cli_args.run_isolated)
+		result = exec_tests(linux, exec_request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (result.elapsed_time))
 		if result.status != KunitStatus.SUCCESS:
@@ -461,9 +466,9 @@ def main(argv, linux=None):
 		else:
 			with open(cli_args.file, 'r') as f:
 				kunit_output = f.read().splitlines()
-		request = KunitParseRequest(cli_args.raw_output,
-					    None,
-					    cli_args.json)
+		request = KunitParseRequest(raw_output=cli_args.raw_output,
+					    build_dir='',
+					    json=cli_args.json)
 		result = parse_tests(request, kunit_output)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 6648de1f9ceb..2540bb10b4e8 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -556,7 +556,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'suite'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'suite'))
 
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
@@ -571,7 +571,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*.test*', None, 'suite'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*.test*', None, 'suite'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
@@ -584,7 +584,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'test'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'test'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),

base-commit: e3c6457b588d83b7ecd40eb4bd6d95007020fbe4
-- 
2.33.0.882.g93a45727a2-goog

