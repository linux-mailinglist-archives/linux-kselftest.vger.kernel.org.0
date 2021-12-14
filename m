Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A147C474BD9
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Dec 2021 20:26:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237395AbhLNT0T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Dec 2021 14:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237366AbhLNT0S (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Dec 2021 14:26:18 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A27C06173E
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:26:18 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w5-20020a25ac05000000b005c55592df4dso38607777ybi.12
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Dec 2021 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=soknJRx1dU20E6sq7VszzvVg4scvjxi1ErpHJ4V+HCM=;
        b=aUa06ZMpPlVotUhAkEvMymSD2UJbmHTz2N6q2w0MAIXt9ZuvtuEVLHjCBN2dircQiP
         SaHftJ75g1GMYe4ExhOEKc4I1oNhsYqL2oMRKbpeX0LHIeoCqQFvTpaPD/iid4rUdXcJ
         SszsLYjXr0HvnCo7qGQMLOAdog//0VxyCCkbNT6IA0t4Yr70FFk55S7rSk+bBm0EqHRW
         sHu8n+03H+srgn2IGEYNv+lbV6MOaJAHErz7L1d1ggit7FgCcpD0X1F099SOTDE4LhZl
         c+b2MqdKVr6qRQXt1EQ7O9N0jvaq9zeoC5FCpfFLaD7DRJlEVlJNyumARy+RXiA3XwR6
         a9Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=soknJRx1dU20E6sq7VszzvVg4scvjxi1ErpHJ4V+HCM=;
        b=jeLZR90PQJMuK+1MojWD2QTFix0i93Dp+UWhivvqAwx2uMjPYuv/r+ECrhLSpbaRqe
         Wcfy4vrzhxUYDyuVbt8dqvWg7DgLBVY5qcf31hez5muGTYUJP/Z0wKVfRZWAR+fn3SA7
         ohvgNo+6PoN0srNAVIWyu/RAwrq8D7W3aZDFU4VX4HQUqvKH+4koD5son8FhpVpY81lK
         9UEuaFwXEARMxUO2VdyWeh9RRZgs4ccz0t3V7pugJlQWvR4hHtXYIB5RK/UJCw9GzQZm
         1PtIq5SXpQOk1F2CaHYBO94uKoLG1pkVvrQ24JY3vRI9YCtGRX1xHrEqmqJl7XHQ4XXC
         nXGg==
X-Gm-Message-State: AOAM531Bn4+ip8PPoLbUdJS5I5pV84bl670fpD9UKLgiIk9EmOvosUQb
        Wv58tF7/Ysyj7KJ/LwSf9bkii6djM2B1Jw==
X-Google-Smtp-Source: ABdhPJxdMzwZTRQ1pW2+fqI9YjAbZ8SkWBsdowMW85/0057Artw0DO6OHN81yUbkFPHr2R1+KyQ9J7dSwH/tHQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1a10:bb1b:63e:864a])
 (user=dlatypov job=sendgmr) by 2002:a05:6902:102d:: with SMTP id
 x13mr1168056ybt.114.1639509977726; Tue, 14 Dec 2021 11:26:17 -0800 (PST)
Date:   Tue, 14 Dec 2021 11:26:11 -0800
Message-Id: <20211214192612.134306-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v2 1/2] kunit: tool: use dataclass instead of collections.namedtuple
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
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
---
v1 -> v2: no change, clean rebase onto linux-kselftest kunit branch.
---
 tools/testing/kunit/kunit.py           | 139 +++++++++++++------------
 tools/testing/kunit/kunit_tool_test.py |   6 +-
 2 files changed, 75 insertions(+), 70 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 8c52faf5787c..4f5c7984cf3f 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -15,38 +15,57 @@ import time
 
 assert sys.version_info >= (3, 7), "Python version is too old"
 
-from collections import namedtuple
+from dataclasses import dataclass
 from enum import Enum, auto
-from typing import Iterable, Sequence, List
+from typing import Any, Iterable, Sequence, List, Optional
 
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
@@ -217,27 +235,15 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
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
 
@@ -413,16 +419,16 @@ def main(argv, linux=None):
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
@@ -439,8 +445,8 @@ def main(argv, linux=None):
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
 
-		request = KunitConfigRequest(cli_args.build_dir,
-					     cli_args.make_options)
+		request = KunitConfigRequest(build_dir=cli_args.build_dir,
+					     make_options=cli_args.make_options)
 		result = config_tests(linux, request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
@@ -456,10 +462,10 @@ def main(argv, linux=None):
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
@@ -475,16 +481,15 @@ def main(argv, linux=None):
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
@@ -496,9 +501,9 @@ def main(argv, linux=None):
 		else:
 			with open(cli_args.file, 'r', errors='backslashreplace') as f:
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
index 97a4c72af2b8..e30e162bd084 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -691,7 +691,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'suite'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'suite'))
 
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
@@ -706,7 +706,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*.test*', None, 'suite'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*.test*', None, 'suite'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
@@ -719,7 +719,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'test'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'test'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),

base-commit: 7fa7ffcf9babaea2f0a81681b4ef460ee4b93278
-- 
2.34.1.173.g76aa8bc2d0-goog

