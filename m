Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66FE4488005
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jan 2022 01:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229487AbiAHAtc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jan 2022 19:49:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiAHAtc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jan 2022 19:49:32 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9771C061574
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Jan 2022 16:49:31 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id x6so9160012iol.13
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Jan 2022 16:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=0oVry3+kv2H+rFnCz3qebnkyA4NM6KuoCZBaZvweHiU=;
        b=anvIG5yR8ib2z8q46O0oyTTRFSH1Tw0LKURogpMjclkFrVn+L01bckYES4mt6cFaEV
         3wpFGX/Mo/OleRG4Roe0rfo5cI+TtMl8gnBjV2xz+s4fOczFqeWtEBdrct3OxwPCo1R0
         x+tMu12646ZMrhqVFV59OYpF8DLBmjS18zKG4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=0oVry3+kv2H+rFnCz3qebnkyA4NM6KuoCZBaZvweHiU=;
        b=k6vgCQVvCmTl/HLp8AmU2639mcyb2AMhnhf9+9l0q7Ibt0+8xtZbXiYaq3BkVY9fMt
         eC2xE3294VihEgYE3wlGdOGjpW2AzQEKg90wm1GWvpgJRtSjdl3q959uGSlkK3ZY2w6s
         fJ6xRNNGvW91+HywP+iUcDiBseOcYGgwldDJQjJhAez0biloAZgzjdzRBn3OLyZjil3f
         QUVEWSrt88NfgApmznCLzhTb87dSZQtINS+cr154yse2dLR/2oYzkEGvFwW+Jz1wVdj6
         ezZwgxyfP1JDfePy1jDarthiSVhGlxmi6jE2IMg8jkYUijXWtFwr5Lf8CL9perin04ne
         xC1A==
X-Gm-Message-State: AOAM531kCercAaFngu+HOsZpToTHyopi/vPbJgXgEM0Jsp0NRrxLeJNe
        jZMz9LcwmYqXP0TpIr+z9K1yAZV8nfOv1g==
X-Google-Smtp-Source: ABdhPJx8WiZdRcKblAqe9Nyf0X7NyHBCEYoZG0Smg3inMJ4ZuJ1SbdAi28tlrRa74AVnyX/M2SoWpw==
X-Received: by 2002:a02:cdd9:: with SMTP id m25mr31388795jap.110.1641602971136;
        Fri, 07 Jan 2022 16:49:31 -0800 (PST)
Received: from [192.168.1.128] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id p15sm118039ilo.83.2022.01.07.16.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jan 2022 16:49:30 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] KUnit update for Linux 5.17-rc1
Message-ID: <2886e025-edea-5e09-1e6c-ff2a53ef4c13@linuxfoundation.org>
Date:   Fri, 7 Jan 2022 17:49:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------B199BF0E8E8C6D9C83D37F99"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------B199BF0E8E8C6D9C83D37F99
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following KUnit update for Linux 5.17-rc1.

This KUnit update for Linux 5.17-rc1 consists of several fixes and
enhancements. A few highlights:

- Option --kconfig_add option allows easily tweaking kunitconfigs
- make build subcommand can reconfigure if needed
- doesn't error on tests without test plans
- doesn't crash if no parameters are generated
- defaults --jobs to # of cups
- reports test parameter results as (K)TAP subtests

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

   Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux-kselftest-kunit-5.17-rc1

for you to fetch changes up to ad659ccb5412874c6a89d3588cb18857c00e9d0f:

   kunit: tool: Default --jobs to number of CPUs (2021-12-15 16:44:55 -0700)

----------------------------------------------------------------
linux-kselftest-kunit-5.17-rc1

This KUnit update for Linux 5.17-rc1 consists of several fixes and
enhancements. A few highlights:

- Option --kconfig_add option allows easily tweaking kunitconfigs
- make build subcommand can reconfigure if needed
- doesn't error on tests without test plans
- doesn't crash if no parameters are generated
- defaults --jobs to # of cups
- reports test parameter results as (K)TAP subtests

----------------------------------------------------------------
Daniel Latypov (13):
       kunit: tool: fix --json output for skipped tests
       Documentation: kunit: remove claims that kunit is a mocking framework
       kunit: add run_checks.py script to validate kunit changes
       kunit: tool: print parsed test results fully incrementally
       kunit: tool: move Kconfig read_from_file/parse_from_string to package-level
       kunit: tool: add --kconfig_add to allow easily tweaking kunitconfigs
       kunit: tool: revamp message for invalid kunitconfig
       kunit: tool: reconfigure when the used kunitconfig changes
       kunit: tool: suggest using decode_stacktrace.sh on kernel crash
       kunit: tool: use dataclass instead of collections.namedtuple
       kunit: tool: delete kunit_parser.TestResult type
       kunit: tool: make `build` subcommand also reconfigure if needed
       kunit: tool: fix newly introduced typechecker errors

David Gow (5):
       kunit: tool: Do not error on tests without test plans
       kunit: tool: Report an error if any test has no subtests
       kunit: Don't crash if no parameters are generated
       kunit: Report test parameter results as (K)TAP subtests
       kunit: tool: Default --jobs to number of CPUs

  Documentation/dev-tools/kunit/api/index.rst        |   3 +-
  Documentation/dev-tools/kunit/api/test.rst         |   3 +-
  Documentation/dev-tools/kunit/index.rst            |   2 +-
  Documentation/dev-tools/kunit/start.rst            |   8 +-
  lib/kunit/test.c                                   |  25 +--
  tools/testing/kunit/kunit.py                       | 182 ++++++++++++---------
  tools/testing/kunit/kunit_config.py                |  61 +++----
  tools/testing/kunit/kunit_json.py                  |   8 +-
  tools/testing/kunit/kunit_kernel.py                |  76 ++++++---
  tools/testing/kunit/kunit_parser.py                |  57 ++++---
  tools/testing/kunit/kunit_tool_test.py             | 171 ++++++++++++++++---
  tools/testing/kunit/run_checks.py                  |  81 +++++++++
  .../test_is_test_passed-no_tests_no_plan.log       |   7 +
  13 files changed, 480 insertions(+), 204 deletions(-)
  create mode 100755 tools/testing/kunit/run_checks.py
  create mode 100644 tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
----------------------------------------------------------------

--------------B199BF0E8E8C6D9C83D37F99
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-5.17-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-5.17-rc1.diff"

diff --git a/Documentation/dev-tools/kunit/api/index.rst b/Documentation/dev-tools/kunit/api/index.rst
index b33ad72bcf0b..3006cadcf44a 100644
--- a/Documentation/dev-tools/kunit/api/index.rst
+++ b/Documentation/dev-tools/kunit/api/index.rst
@@ -12,5 +12,4 @@ following sections:
 
 Documentation/dev-tools/kunit/api/test.rst
 
- - documents all of the standard testing API excluding mocking
-   or mocking related features.
+ - documents all of the standard testing API
diff --git a/Documentation/dev-tools/kunit/api/test.rst b/Documentation/dev-tools/kunit/api/test.rst
index aaa97f17e5b3..c5eca423e8b6 100644
--- a/Documentation/dev-tools/kunit/api/test.rst
+++ b/Documentation/dev-tools/kunit/api/test.rst
@@ -4,8 +4,7 @@
 Test API
 ========
 
-This file documents all of the standard testing API excluding mocking or mocking
-related features.
+This file documents all of the standard testing API.
 
 .. kernel-doc:: include/kunit/test.h
    :internal:
diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index cacb35ec658d..7af7dec83646 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -19,7 +19,7 @@ KUnit - Unit Testing for the Linux Kernel
 What is KUnit?
 ==============
 
-KUnit is a lightweight unit testing and mocking framework for the Linux kernel.
+KUnit is a lightweight unit testing framework for the Linux kernel.
 
 KUnit is heavily inspired by JUnit, Python's unittest.mock, and
 Googletest/Googlemock for C++. KUnit provides facilities for defining unit test
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 1e00f9226f74..0a5e65540974 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -50,10 +50,10 @@ It'll warn you if you haven't included the dependencies of the options you're
 using.
 
 .. note::
-   Note that removing something from the ``.kunitconfig`` will not trigger a
-   rebuild of the ``.config`` file: the configuration is only updated if the
-   ``.kunitconfig`` is not a subset of ``.config``. This means that you can use
-   other tools (such as make menuconfig) to adjust other config options.
+   If you change the ``.kunitconfig``, kunit.py will trigger a rebuild of the
+   ``.config`` file. But you can edit the ``.config`` file directly or with
+   tools like ``make menuconfig O=.kunit``. As long as its a superset of
+   ``.kunitconfig``, kunit.py won't overwrite your changes.
 
 
 Running the tests (KUnit Wrapper)
diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 3bd741e50a2d..c7ed4aabec04 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -504,25 +504,28 @@ int kunit_run_tests(struct kunit_suite *suite)
 		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
-		if (test_case->generate_params) {
+		if (!test_case->generate_params) {
+			/* Non-parameterised test. */
+			kunit_run_case_catch_errors(suite, test_case, &test);
+			kunit_update_stats(&param_stats, test.status);
+		} else {
 			/* Get initial param. */
 			param_desc[0] = '\0';
 			test.param_value = test_case->generate_params(NULL, param_desc);
-		}
+			kunit_log(KERN_INFO, &test, KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+				  "# Subtest: %s", test_case->name);
 
-		do {
-			kunit_run_case_catch_errors(suite, test_case, &test);
+			while (test.param_value) {
+				kunit_run_case_catch_errors(suite, test_case, &test);
 
-			if (test_case->generate_params) {
 				if (param_desc[0] == '\0') {
 					snprintf(param_desc, sizeof(param_desc),
 						 "param-%d", test.param_index);
 				}
 
 				kunit_log(KERN_INFO, &test,
-					  KUNIT_SUBTEST_INDENT
-					  "# %s: %s %d - %s",
-					  test_case->name,
+					  KUNIT_SUBTEST_INDENT KUNIT_SUBTEST_INDENT
+					  "%s %d - %s",
 					  kunit_status_to_ok_not_ok(test.status),
 					  test.param_index + 1, param_desc);
 
@@ -530,11 +533,11 @@ int kunit_run_tests(struct kunit_suite *suite)
 				param_desc[0] = '\0';
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
-			}
 
-			kunit_update_stats(&param_stats, test.status);
+				kunit_update_stats(&param_stats, test.status);
+			}
+		}
 
-		} while (test.param_value);
 
 		kunit_print_test_stats(&test, param_stats);
 
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 68e6f461c758..7a706f96f68d 100755
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
@@ -91,6 +110,14 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 			   'built kernel successfully',
 			   build_end - build_start)
 
+def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
+			   request: KunitBuildRequest) -> KunitResult:
+	config_result = config_tests(linux, request)
+	if config_result.status != KunitStatus.SUCCESS:
+		return config_result
+
+	return build_tests(linux, request)
+
 def _list_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> List[str]:
 	args = ['kunit.action=list']
 	if request.kernel_args:
@@ -121,8 +148,7 @@ def _suites_from_test_list(tests: List[str]) -> List[str]:
 
 
 
-def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
-	       parse_request: KunitParseRequest) -> KunitResult:
+def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -> KunitResult:
 	filter_globs = [request.filter_glob]
 	if request.run_isolated:
 		tests = _list_tests(linux, request)
@@ -147,17 +173,23 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest,
 			filter_glob=filter_glob,
 			build_dir=request.build_dir)
 
-		result = parse_tests(parse_request, run_result)
+		result = parse_tests(request, run_result)
 		# run_kernel() doesn't block on the kernel exiting.
 		# That only happens after we get the last line of output from `run_result`.
 		# So exec_time here actually contains parsing + execution time, which is fine.
 		test_end = time.time()
 		exec_time += test_end - test_start
 
-		test_counts.add_subtest_counts(result.result.test.counts)
+		test_counts.add_subtest_counts(result.result.counts)
+
+	if len(filter_globs) == 1 and test_counts.crashed > 0:
+		bd = request.build_dir
+		print('The kernel seems to have crashed; you can decode the stack traces with:')
+		print('$ scripts/decode_stacktrace.sh {}/vmlinux {} < {} | tee {}/decoded.log | {} parse'.format(
+				bd, bd, kunit_kernel.get_outfile_path(bd), bd, sys.argv[0]))
 
 	kunit_status = _map_to_overall_status(test_counts.get_status())
-	return KunitResult(status=kunit_status, result=result.result, elapsed_time=exec_time)
+	return KunitResult(status=kunit_status, result=result, elapsed_time=exec_time)
 
 def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
@@ -168,14 +200,12 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
 	parse_start = time.time()
 
-	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
-					      kunit_parser.Test(),
-					      'Tests not Parsed.')
+	test_result = kunit_parser.Test()
 
 	if request.raw_output:
 		# Treat unparsed results as one passing test.
-		test_result.test.status = kunit_parser.TestStatus.SUCCESS
-		test_result.test.counts.passed = 1
+		test_result.status = kunit_parser.TestStatus.SUCCESS
+		test_result.counts.passed = 1
 
 		output: Iterable[str] = input_data
 		if request.raw_output == 'all':
@@ -193,7 +223,7 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitR
 
 	if request.json:
 		json_obj = kunit_json.get_json_result(
-					test_result=test_result,
+					test=test_result,
 					def_config='kunit_defconfig',
 					build_dir=request.build_dir,
 					json_path=request.json)
@@ -211,27 +241,15 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
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
 
@@ -264,6 +282,9 @@ def massage_argv(argv: Sequence[str]) -> Sequence[str]:
 		return  f'{arg}={pseudo_bool_flag_defaults[arg]}'
 	return list(map(massage_arg, argv))
 
+def get_default_jobs() -> int:
+	return len(os.sched_getaffinity(0))
+
 def add_common_opts(parser) -> None:
 	parser.add_argument('--build_dir',
 			    help='As in the make command, it specifies the build '
@@ -280,6 +301,10 @@ def add_common_opts(parser) -> None:
 			     ' If given a directory, (e.g. lib/kunit), "/.kunitconfig" '
 			     'will get  automatically appended.',
 			     metavar='kunitconfig')
+	parser.add_argument('--kconfig_add',
+			     help='Additional Kconfig options to append to the '
+			     '.kunitconfig, e.g. CONFIG_KASAN=y. Can be repeated.',
+			    action='append')
 
 	parser.add_argument('--arch',
 			    help=('Specifies the architecture to run tests under. '
@@ -310,7 +335,7 @@ def add_build_opts(parser) -> None:
 	parser.add_argument('--jobs',
 			    help='As in the make command, "Specifies  the number of '
 			    'jobs (commands) to run simultaneously."',
-			    type=int, default=8, metavar='jobs')
+			    type=int, default=get_default_jobs(), metavar='jobs')
 
 def add_exec_opts(parser) -> None:
 	parser.add_argument('--timeout',
@@ -398,20 +423,21 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
+					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
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
@@ -423,12 +449,13 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
+					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
 
-		request = KunitConfigRequest(cli_args.build_dir,
-					     cli_args.make_options)
+		request = KunitConfigRequest(build_dir=cli_args.build_dir,
+					     make_options=cli_args.make_options)
 		result = config_tests(linux, request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
@@ -439,15 +466,16 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
+					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
 					cross_compile=cli_args.cross_compile,
 					qemu_config_path=cli_args.qemu_config)
 
-		request = KunitBuildRequest(cli_args.jobs,
-					    cli_args.build_dir,
-					    cli_args.alltests,
-					    cli_args.make_options)
-		result = build_tests(linux, request)
+		request = KunitBuildRequest(build_dir=cli_args.build_dir,
+					    make_options=cli_args.make_options,
+					    jobs=cli_args.jobs,
+					    alltests=cli_args.alltests)
+		result = config_and_build_tests(linux, request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
 				result.elapsed_time))
@@ -457,20 +485,20 @@ def main(argv, linux=None):
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree(cli_args.build_dir,
 					kunitconfig_path=cli_args.kunitconfig,
+					kconfig_add=cli_args.kconfig_add,
 					arch=cli_args.arch,
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
@@ -482,9 +510,9 @@ def main(argv, linux=None):
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
diff --git a/tools/testing/kunit/kunit_config.py b/tools/testing/kunit/kunit_config.py
index c77c7d2ef622..677354546156 100644
--- a/tools/testing/kunit/kunit_config.py
+++ b/tools/testing/kunit/kunit_config.py
@@ -62,33 +62,34 @@ class Kconfig(object):
 			for entry in self.entries():
 				f.write(str(entry) + '\n')
 
-	def parse_from_string(self, blob: str) -> None:
-		"""Parses a string containing KconfigEntrys and populates this Kconfig."""
-		self._entries = []
-		is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
-		config_matcher = re.compile(CONFIG_PATTERN)
-		for line in blob.split('\n'):
-			line = line.strip()
-			if not line:
-				continue
-
-			match = config_matcher.match(line)
-			if match:
-				entry = KconfigEntry(match.group(1), match.group(2))
-				self.add_entry(entry)
-				continue
-
-			empty_match = is_not_set_matcher.match(line)
-			if empty_match:
-				entry = KconfigEntry(empty_match.group(1), 'n')
-				self.add_entry(entry)
-				continue
-
-			if line[0] == '#':
-				continue
-			else:
-				raise KconfigParseError('Failed to parse: ' + line)
-
-	def read_from_file(self, path: str) -> None:
-		with open(path, 'r') as f:
-			self.parse_from_string(f.read())
+def parse_file(path: str) -> Kconfig:
+	with open(path, 'r') as f:
+		return parse_from_string(f.read())
+
+def parse_from_string(blob: str) -> Kconfig:
+	"""Parses a string containing Kconfig entries."""
+	kconfig = Kconfig()
+	is_not_set_matcher = re.compile(CONFIG_IS_NOT_SET_PATTERN)
+	config_matcher = re.compile(CONFIG_PATTERN)
+	for line in blob.split('\n'):
+		line = line.strip()
+		if not line:
+			continue
+
+		match = config_matcher.match(line)
+		if match:
+			entry = KconfigEntry(match.group(1), match.group(2))
+			kconfig.add_entry(entry)
+			continue
+
+		empty_match = is_not_set_matcher.match(line)
+		if empty_match:
+			entry = KconfigEntry(empty_match.group(1), 'n')
+			kconfig.add_entry(entry)
+			continue
+
+		if line[0] == '#':
+			continue
+		else:
+			raise KconfigParseError('Failed to parse: ' + line)
+	return kconfig
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 746bec72b9ac..6862671709bc 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -11,7 +11,7 @@ import os
 
 import kunit_parser
 
-from kunit_parser import Test, TestResult, TestStatus
+from kunit_parser import Test, TestStatus
 from typing import Any, Dict, Optional
 
 JsonObj = Dict[str, Any]
@@ -30,6 +30,8 @@ def _get_group_json(test: Test, def_config: str,
 			test_case = {"name": subtest.name, "status": "FAIL"}
 			if subtest.status == TestStatus.SUCCESS:
 				test_case["status"] = "PASS"
+			elif subtest.status == TestStatus.SKIPPED:
+				test_case["status"] = "SKIP"
 			elif subtest.status == TestStatus.TEST_CRASHED:
 				test_case["status"] = "ERROR"
 			test_cases.append(test_case)
@@ -48,9 +50,9 @@ def _get_group_json(test: Test, def_config: str,
 	}
 	return test_group
 
-def get_json_result(test_result: TestResult, def_config: str,
+def get_json_result(test: Test, def_config: str,
 		build_dir: Optional[str], json_path: str) -> str:
-	test_group = _get_group_json(test_result.test, def_config, build_dir)
+	test_group = _get_group_json(test, def_config, build_dir)
 	test_group["name"] = "KUnit Test Group"
 	json_obj = json.dumps(test_group, indent=4)
 	if json_path != 'stdout':
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index 66095568bf32..44bbe54f25f1 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -21,6 +21,7 @@ import qemu_config
 
 KCONFIG_PATH = '.config'
 KUNITCONFIG_PATH = '.kunitconfig'
+OLD_KUNITCONFIG_PATH = 'last_used_kunitconfig'
 DEFAULT_KUNITCONFIG_PATH = 'tools/testing/kunit/configs/default.config'
 BROKEN_ALLCONFIG_PATH = 'tools/testing/kunit/configs/broken_on_uml.config'
 OUTFILE_PATH = 'test.log'
@@ -116,8 +117,7 @@ class LinuxSourceTreeOperationsQemu(LinuxSourceTreeOperations):
 		self._extra_qemu_params = qemu_arch_params.extra_qemu_params
 
 	def make_arch_qemuconfig(self, base_kunitconfig: kunit_config.Kconfig) -> None:
-		kconfig = kunit_config.Kconfig()
-		kconfig.parse_from_string(self._kconfig)
+		kconfig = kunit_config.parse_from_string(self._kconfig)
 		base_kunitconfig.merge_in_entries(kconfig)
 
 	def start(self, params: List[str], build_dir: str) -> subprocess.Popen:
@@ -180,6 +180,9 @@ def get_kconfig_path(build_dir) -> str:
 def get_kunitconfig_path(build_dir) -> str:
 	return get_file_path(build_dir, KUNITCONFIG_PATH)
 
+def get_old_kunitconfig_path(build_dir) -> str:
+	return get_file_path(build_dir, OLD_KUNITCONFIG_PATH)
+
 def get_outfile_path(build_dir) -> str:
 	return get_file_path(build_dir, OUTFILE_PATH)
 
@@ -206,6 +209,7 @@ def get_source_tree_ops_from_qemu_config(config_path: str,
 	# exists as a file.
 	module_path = '.' + os.path.join(os.path.basename(QEMU_CONFIGS_DIR), os.path.basename(config_path))
 	spec = importlib.util.spec_from_file_location(module_path, config_path)
+	assert spec is not None
 	config = importlib.util.module_from_spec(spec)
 	# See https://github.com/python/typeshed/pull/2626 for context.
 	assert isinstance(spec.loader, importlib.abc.Loader)
@@ -225,6 +229,7 @@ class LinuxSourceTree(object):
 	      build_dir: str,
 	      load_config=True,
 	      kunitconfig_path='',
+	      kconfig_add: Optional[List[str]]=None,
 	      arch=None,
 	      cross_compile=None,
 	      qemu_config_path=None) -> None:
@@ -249,8 +254,11 @@ class LinuxSourceTree(object):
 			if not os.path.exists(kunitconfig_path):
 				shutil.copyfile(DEFAULT_KUNITCONFIG_PATH, kunitconfig_path)
 
-		self._kconfig = kunit_config.Kconfig()
-		self._kconfig.read_from_file(kunitconfig_path)
+		self._kconfig = kunit_config.parse_file(kunitconfig_path)
+		if kconfig_add:
+			kconfig = kunit_config.parse_from_string('\n'.join(kconfig_add))
+			self._kconfig.merge_in_entries(kconfig)
+
 
 	def clean(self) -> bool:
 		try:
@@ -262,17 +270,18 @@ class LinuxSourceTree(object):
 
 	def validate_config(self, build_dir) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
-		validated_kconfig = kunit_config.Kconfig()
-		validated_kconfig.read_from_file(kconfig_path)
-		if not self._kconfig.is_subset_of(validated_kconfig):
-			invalid = self._kconfig.entries() - validated_kconfig.entries()
-			message = 'Provided Kconfig is not contained in validated .config. Following fields found in kunitconfig, ' \
-					  'but not in .config: %s' % (
-					', '.join([str(e) for e in invalid])
-			)
-			logging.error(message)
-			return False
-		return True
+		validated_kconfig = kunit_config.parse_file(kconfig_path)
+		if self._kconfig.is_subset_of(validated_kconfig):
+			return True
+		invalid = self._kconfig.entries() - validated_kconfig.entries()
+		message = 'Not all Kconfig options selected in kunitconfig were in the generated .config.\n' \
+			  'This is probably due to unsatisfied dependencies.\n' \
+			  'Missing: ' + ', '.join([str(e) for e in invalid])
+		if self._arch == 'um':
+			message += '\nNote: many Kconfig options aren\'t available on UML. You can try running ' \
+				   'on a different architecture with something like "--arch=x86_64".'
+		logging.error(message)
+		return False
 
 	def build_config(self, build_dir, make_options) -> bool:
 		kconfig_path = get_kconfig_path(build_dir)
@@ -285,25 +294,38 @@ class LinuxSourceTree(object):
 		except ConfigError as e:
 			logging.error(e)
 			return False
-		return self.validate_config(build_dir)
+		if not self.validate_config(build_dir):
+			return False
+
+		old_path = get_old_kunitconfig_path(build_dir)
+		if os.path.exists(old_path):
+			os.remove(old_path)  # write_to_file appends to the file
+		self._kconfig.write_to_file(old_path)
+		return True
+
+	def _kunitconfig_changed(self, build_dir: str) -> bool:
+		old_path = get_old_kunitconfig_path(build_dir)
+		if not os.path.exists(old_path):
+			return True
+
+		old_kconfig = kunit_config.parse_file(old_path)
+		return old_kconfig.entries() != self._kconfig.entries()
 
 	def build_reconfig(self, build_dir, make_options) -> bool:
 		"""Creates a new .config if it is not a subset of the .kunitconfig."""
 		kconfig_path = get_kconfig_path(build_dir)
-		if os.path.exists(kconfig_path):
-			existing_kconfig = kunit_config.Kconfig()
-			existing_kconfig.read_from_file(kconfig_path)
-			self._ops.make_arch_qemuconfig(self._kconfig)
-			if not self._kconfig.is_subset_of(existing_kconfig):
-				print('Regenerating .config ...')
-				os.remove(kconfig_path)
-				return self.build_config(build_dir, make_options)
-			else:
-				return True
-		else:
+		if not os.path.exists(kconfig_path):
 			print('Generating .config ...')
 			return self.build_config(build_dir, make_options)
 
+		existing_kconfig = kunit_config.parse_file(kconfig_path)
+		self._ops.make_arch_qemuconfig(self._kconfig)
+		if self._kconfig.is_subset_of(existing_kconfig) and not self._kunitconfig_changed(build_dir):
+			return True
+		print('Regenerating .config ...')
+		os.remove(kconfig_path)
+		return self.build_config(build_dir, make_options)
+
 	def build_kernel(self, alltests, jobs, build_dir, make_options) -> bool:
 		try:
 			if alltests:
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 3355196d0515..05ff334761dd 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,14 +12,11 @@
 from __future__ import annotations
 import re
 
-from collections import namedtuple
-from datetime import datetime
+import datetime
 from enum import Enum, auto
 from functools import reduce
 from typing import Iterable, Iterator, List, Optional, Tuple
 
-TestResult = namedtuple('TestResult', ['status','test','log'])
-
 class Test(object):
 	"""
 	A class to represent a test parsed from KTAP results. All KTAP
@@ -168,42 +165,51 @@ class TestCounts:
 class LineStream:
 	"""
 	A class to represent the lines of kernel output.
-	Provides a peek()/pop() interface over an iterator of
+	Provides a lazy peek()/pop() interface over an iterator of
 	(line#, text).
 	"""
 	_lines: Iterator[Tuple[int, str]]
 	_next: Tuple[int, str]
+	_need_next: bool
 	_done: bool
 
 	def __init__(self, lines: Iterator[Tuple[int, str]]):
 		"""Creates a new LineStream that wraps the given iterator."""
 		self._lines = lines
 		self._done = False
+		self._need_next = True
 		self._next = (0, '')
-		self._get_next()
 
 	def _get_next(self) -> None:
-		"""Advances the LineSteam to the next line."""
+		"""Advances the LineSteam to the next line, if necessary."""
+		if not self._need_next:
+			return
 		try:
 			self._next = next(self._lines)
 		except StopIteration:
 			self._done = True
+		finally:
+			self._need_next = False
 
 	def peek(self) -> str:
 		"""Returns the current line, without advancing the LineStream.
 		"""
+		self._get_next()
 		return self._next[1]
 
 	def pop(self) -> str:
 		"""Returns the current line and advances the LineStream to
 		the next line.
 		"""
-		n = self._next
-		self._get_next()
-		return n[1]
+		s = self.peek()
+		if self._done:
+			raise ValueError(f'LineStream: going past EOF, last line was {s}')
+		self._need_next = True
+		return s
 
 	def __bool__(self) -> bool:
 		"""Returns True if stream has more lines."""
+		self._get_next()
 		return not self._done
 
 	# Only used by kunit_tool_test.py.
@@ -216,6 +222,7 @@ class LineStream:
 
 	def line_number(self) -> int:
 		"""Returns the line number of the current line."""
+		self._get_next()
 		return self._next[0]
 
 # Parsing helper methods:
@@ -340,8 +347,8 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	"""
 	Parses test plan line and stores the expected number of subtests in
 	test object. Reports an error if expected count is 0.
-	Returns False and reports missing test plan error if fails to parse
-	test plan.
+	Returns False and sets expected_count to None if there is no valid test
+	plan.
 
 	Accepted format:
 	- '1..[number of subtests]'
@@ -356,14 +363,10 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	match = TEST_PLAN.match(lines.peek())
 	if not match:
 		test.expected_count = None
-		test.add_error('missing plan line!')
 		return False
 	test.log.append(lines.pop())
 	expected_count = int(match.group(1))
 	test.expected_count = expected_count
-	if expected_count == 0:
-		test.status = TestStatus.NO_TESTS
-		test.add_error('0 tests run!')
 	return True
 
 TEST_RESULT = re.compile(r'^(ok|not ok) ([0-9]+) (- )?([^#]*)( # .*)?$')
@@ -514,7 +517,7 @@ ANSI_LEN = len(red(''))
 
 def print_with_timestamp(message: str) -> None:
 	"""Prints message with timestamp at beginning."""
-	print('[%s] %s' % (datetime.now().strftime('%H:%M:%S'), message))
+	print('[%s] %s' % (datetime.datetime.now().strftime('%H:%M:%S'), message))
 
 def format_test_divider(message: str, len_message: int) -> str:
 	"""
@@ -590,6 +593,8 @@ def format_test_result(test: Test) -> str:
 		return (green('[PASSED] ') + test.name)
 	elif test.status == TestStatus.SKIPPED:
 		return (yellow('[SKIPPED] ') + test.name)
+	elif test.status == TestStatus.NO_TESTS:
+		return (yellow('[NO TESTS RUN] ') + test.name)
 	elif test.status == TestStatus.TEST_CRASHED:
 		print_log(test.log)
 		return (red('[CRASHED] ') + test.name)
@@ -732,6 +737,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 		# test plan
 		test.name = "main"
 		parse_test_plan(lines, test)
+		parent_test = True
 	else:
 		# If KTAP/TAP header is not found, test must be subtest
 		# header or test result line so parse attempt to parser
@@ -745,7 +751,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 	expected_count = test.expected_count
 	subtests = []
 	test_num = 1
-	while expected_count is None or test_num <= expected_count:
+	while parent_test and (expected_count is None or test_num <= expected_count):
 		# Loop to parse any subtests.
 		# Break after parsing expected number of tests or
 		# if expected number of tests is unknown break when test
@@ -780,9 +786,15 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 			parse_test_result(lines, test, expected_num)
 		else:
 			test.add_error('missing subtest result line!')
+
+	# Check for there being no tests
+	if parent_test and len(subtests) == 0:
+		test.status = TestStatus.NO_TESTS
+		test.add_error('0 tests run!')
+
 	# Add statuses to TestCounts attribute in Test object
 	bubble_up_test_results(test)
-	if parent_test:
+	if parent_test and not main:
 		# If test has subtests and is not the main test object, print
 		# footer.
 		print_test_footer(test)
@@ -790,7 +802,7 @@ def parse_test(lines: LineStream, expected_num: int, log: List[str]) -> Test:
 		print_test_result(test)
 	return test
 
-def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
+def parse_run_tests(kernel_output: Iterable[str]) -> Test:
 	"""
 	Using kernel output, extract KTAP lines, parse the lines for test
 	results and print condensed test results and summary line .
@@ -799,8 +811,7 @@ def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
 	kernel_output - Iterable object contains lines of kernel output
 
 	Return:
-	TestResult - Tuple containg status of main test object, main test
-		object with all subtests, and log of all KTAP lines.
+	Test - the main test object with all subtests.
 	"""
 	print_with_timestamp(DIVIDER)
 	lines = extract_tap_lines(kernel_output)
@@ -814,4 +825,4 @@ def parse_run_tests(kernel_output: Iterable[str]) -> TestResult:
 			test.status = test.counts.get_status()
 	print_with_timestamp(DIVIDER)
 	print_summary_line(test)
-	return TestResult(test.status, test, lines)
+	return test
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 9c4126731457..352369dffbd9 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -13,9 +13,10 @@ import tempfile, shutil # Handling test_tmpdir
 
 import itertools
 import json
+import os
 import signal
 import subprocess
-import os
+from typing import Iterable
 
 import kunit_config
 import kunit_parser
@@ -50,10 +51,9 @@ class KconfigTest(unittest.TestCase):
 		self.assertFalse(kconfig1.is_subset_of(kconfig0))
 
 	def test_read_from_file(self):
-		kconfig = kunit_config.Kconfig()
 		kconfig_path = test_data_path('test_read_from_file.kconfig')
 
-		kconfig.read_from_file(kconfig_path)
+		kconfig = kunit_config.parse_file(kconfig_path)
 
 		expected_kconfig = kunit_config.Kconfig()
 		expected_kconfig.add_entry(
@@ -86,8 +86,7 @@ class KconfigTest(unittest.TestCase):
 
 		expected_kconfig.write_to_file(kconfig_path)
 
-		actual_kconfig = kunit_config.Kconfig()
-		actual_kconfig.read_from_file(kconfig_path)
+		actual_kconfig = kunit_config.parse_file(kconfig_path)
 
 		self.assertEqual(actual_kconfig.entries(),
 				 expected_kconfig.entries())
@@ -179,7 +178,7 @@ class KUnitParserTest(unittest.TestCase):
 		with open(empty_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.FAILURE_TO_PARSE_TESTS,
 			result.status)
@@ -191,7 +190,10 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(
 				file.readlines()))
-		self.assertEqual(2, result.test.counts.errors)
+		# A missing test plan is not an error.
+		self.assertEqual(0, result.counts.errors)
+		# All tests should be accounted for.
+		self.assertEqual(10, result.counts.total())
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
@@ -201,11 +203,23 @@ class KUnitParserTest(unittest.TestCase):
 		with open(header_log) as file:
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(file.readlines()))
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 		self.assertEqual(
 			kunit_parser.TestStatus.NO_TESTS,
 			result.status)
 
+	def test_no_tests_no_plan(self):
+		no_plan_log = test_data_path('test_is_test_passed-no_tests_no_plan.log')
+		with open(no_plan_log) as file:
+			result = kunit_parser.parse_run_tests(
+				kunit_parser.extract_tap_lines(file.readlines()))
+		self.assertEqual(0, len(result.subtests[0].subtests[0].subtests))
+		self.assertEqual(
+			kunit_parser.TestStatus.NO_TESTS,
+			result.subtests[0].subtests[0].status)
+		self.assertEqual(1, result.counts.errors)
+
+
 	def test_no_kunit_output(self):
 		crash_log = test_data_path('test_insufficient_memory.log')
 		print_mock = mock.patch('builtins.print').start()
@@ -214,7 +228,7 @@ class KUnitParserTest(unittest.TestCase):
 				kunit_parser.extract_tap_lines(file.readlines()))
 		print_mock.assert_any_call(StrContains('invalid KTAP input!'))
 		print_mock.stop()
-		self.assertEqual(0, len(result.test.subtests))
+		self.assertEqual(0, len(result.subtests))
 
 	def test_crashed_test(self):
 		crashed_log = test_data_path('test_is_test_passed-crash.log')
@@ -255,10 +269,10 @@ class KUnitParserTest(unittest.TestCase):
 			result.status)
 		self.assertEqual(
 			"sysctl_test",
-			result.test.subtests[0].name)
+			result.subtests[0].name)
 		self.assertEqual(
 			"example",
-			result.test.subtests[1].name)
+			result.subtests[1].name)
 		file.close()
 
 
@@ -269,7 +283,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_ignores_multiple_prefixes(self):
 		prefix_log = test_data_path('test_multiple_prefixes.log')
@@ -278,7 +292,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_prefix_mixed_kernel_output(self):
 		mixed_prefix_log = test_data_path('test_interrupted_tap_output.log')
@@ -287,7 +301,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_prefix_poundsign(self):
 		pound_log = test_data_path('test_pound_sign.log')
@@ -296,7 +310,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_kernel_panic_end(self):
 		panic_log = test_data_path('test_kernel_panic_interrupt.log')
@@ -305,7 +319,7 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.TEST_CRASHED,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
 
 	def test_pound_no_prefix(self):
 		pound_log = test_data_path('test_pound_no_prefix.log')
@@ -314,7 +328,46 @@ class KUnitParserTest(unittest.TestCase):
 			self.assertEqual(
 				kunit_parser.TestStatus.SUCCESS,
 				result.status)
-			self.assertEqual('kunit-resource-test', result.test.subtests[0].name)
+			self.assertEqual('kunit-resource-test', result.subtests[0].name)
+
+def line_stream_from_strs(strs: Iterable[str]) -> kunit_parser.LineStream:
+	return kunit_parser.LineStream(enumerate(strs, start=1))
+
+class LineStreamTest(unittest.TestCase):
+
+	def test_basic(self):
+		stream = line_stream_from_strs(['hello', 'world'])
+
+		self.assertTrue(stream, msg='Should be more input')
+		self.assertEqual(stream.line_number(), 1)
+		self.assertEqual(stream.peek(), 'hello')
+		self.assertEqual(stream.pop(), 'hello')
+
+		self.assertTrue(stream, msg='Should be more input')
+		self.assertEqual(stream.line_number(), 2)
+		self.assertEqual(stream.peek(), 'world')
+		self.assertEqual(stream.pop(), 'world')
+
+		self.assertFalse(stream, msg='Should be no more input')
+		with self.assertRaisesRegex(ValueError, 'LineStream: going past EOF'):
+			stream.pop()
+
+	def test_is_lazy(self):
+		called_times = 0
+		def generator():
+			nonlocal called_times
+			for i in range(1,5):
+				called_times += 1
+				yield called_times, str(called_times)
+
+		stream = kunit_parser.LineStream(generator())
+		self.assertEqual(called_times, 0)
+
+		self.assertEqual(stream.pop(), '1')
+		self.assertEqual(called_times, 1)
+
+		self.assertEqual(stream.pop(), '2')
+		self.assertEqual(called_times, 2)
 
 class LinuxSourceTreeTest(unittest.TestCase):
 
@@ -336,6 +389,10 @@ class LinuxSourceTreeTest(unittest.TestCase):
 				pass
 			kunit_kernel.LinuxSourceTree('', kunitconfig_path=dir)
 
+	def test_kconfig_add(self):
+		tree = kunit_kernel.LinuxSourceTree('', kconfig_add=['CONFIG_NOT_REAL=y'])
+		self.assertIn(kunit_config.KconfigEntry('NOT_REAL', 'y'), tree._kconfig.entries())
+
 	def test_invalid_arch(self):
 		with self.assertRaisesRegex(kunit_kernel.ConfigError, 'not a valid arch, options are.*x86_64'):
 			kunit_kernel.LinuxSourceTree('', arch='invalid')
@@ -356,6 +413,51 @@ class LinuxSourceTreeTest(unittest.TestCase):
 			with open(kunit_kernel.get_outfile_path(build_dir), 'rt') as outfile:
 				self.assertEqual(outfile.read(), 'hi\nbye\n', msg='Missing some output')
 
+	def test_build_reconfig_no_config(self):
+		with tempfile.TemporaryDirectory('') as build_dir:
+			with open(kunit_kernel.get_kunitconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+
+			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			mock_build_config = mock.patch.object(tree, 'build_config').start()
+
+			# Should generate the .config
+			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
+			mock_build_config.assert_called_once_with(build_dir, [])
+
+	def test_build_reconfig_existing_config(self):
+		with tempfile.TemporaryDirectory('') as build_dir:
+			# Existing .config is a superset, should not touch it
+			with open(kunit_kernel.get_kunitconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(kunit_kernel.get_old_kunitconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(kunit_kernel.get_kconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
+
+			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			mock_build_config = mock.patch.object(tree, 'build_config').start()
+
+			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
+			self.assertEqual(mock_build_config.call_count, 0)
+
+	def test_build_reconfig_remove_option(self):
+		with tempfile.TemporaryDirectory('') as build_dir:
+			# We removed CONFIG_KUNIT_TEST=y from our .kunitconfig...
+			with open(kunit_kernel.get_kunitconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y')
+			with open(kunit_kernel.get_old_kunitconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
+			with open(kunit_kernel.get_kconfig_path(build_dir), 'w') as f:
+				f.write('CONFIG_KUNIT=y\nCONFIG_KUNIT_TEST=y')
+
+			tree = kunit_kernel.LinuxSourceTree(build_dir)
+			mock_build_config = mock.patch.object(tree, 'build_config').start()
+
+			# ... so we should trigger a call to build_config()
+			self.assertTrue(tree.build_reconfig(build_dir, make_options=[]))
+			mock_build_config.assert_called_once_with(build_dir, [])
+
 	# TODO: add more test cases.
 
 
@@ -365,7 +467,7 @@ class KUnitJsonTest(unittest.TestCase):
 		with open(test_data_path(log_file)) as file:
 			test_result = kunit_parser.parse_run_tests(file)
 			json_obj = kunit_json.get_json_result(
-				test_result=test_result,
+				test=test_result,
 				def_config='kunit_defconfig',
 				build_dir=None,
 				json_path='stdout')
@@ -383,6 +485,12 @@ class KUnitJsonTest(unittest.TestCase):
 			{'name': 'example_simple_test', 'status': 'ERROR'},
 			result["sub_groups"][1]["test_cases"][0])
 
+	def test_skipped_test_json(self):
+		result = self._json_for('test_skip_tests.log')
+		self.assertEqual(
+			{'name': 'example_skip_test', 'status': 'SKIP'},
+			result["sub_groups"][1]["test_cases"][1])
+
 	def test_no_tests_json(self):
 		result = self._json_for('test_is_test_passed-no_tests_run_with_header.log')
 		self.assertEqual(0, len(result['sub_groups']))
@@ -418,8 +526,8 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_build_passes_args_pass(self):
 		kunit.main(['build'], self.linux_source_mock)
-		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 0)
-		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, '.kunit', None)
+		self.assertEqual(self.linux_source_mock.build_reconfig.call_count, 1)
+		self.linux_source_mock.build_kernel.assert_called_once_with(False, kunit.get_default_jobs(), '.kunit', None)
 		self.assertEqual(self.linux_source_mock.run_kernel.call_count, 0)
 
 	def test_exec_passes_args_pass(self):
@@ -525,8 +633,9 @@ class KUnitMainTest(unittest.TestCase):
 
 	def test_build_builddir(self):
 		build_dir = '.kunit'
+		jobs = kunit.get_default_jobs()
 		kunit.main(['build', '--build_dir', build_dir], self.linux_source_mock)
-		self.linux_source_mock.build_kernel.assert_called_once_with(False, 8, build_dir, None)
+		self.linux_source_mock.build_kernel.assert_called_once_with(False, jobs, build_dir, None)
 
 	def test_exec_builddir(self):
 		build_dir = '.kunit'
@@ -542,6 +651,7 @@ class KUnitMainTest(unittest.TestCase):
 		# Just verify that we parsed and initialized it correctly here.
 		mock_linux_init.assert_called_once_with('.kunit',
 							kunitconfig_path='mykunitconfig',
+							kconfig_add=None,
 							arch='um',
 							cross_compile=None,
 							qemu_config_path=None)
@@ -553,6 +663,19 @@ class KUnitMainTest(unittest.TestCase):
 		# Just verify that we parsed and initialized it correctly here.
 		mock_linux_init.assert_called_once_with('.kunit',
 							kunitconfig_path='mykunitconfig',
+							kconfig_add=None,
+							arch='um',
+							cross_compile=None,
+							qemu_config_path=None)
+
+	@mock.patch.object(kunit_kernel, 'LinuxSourceTree')
+	def test_run_kconfig_add(self, mock_linux_init):
+		mock_linux_init.return_value = self.linux_source_mock
+		kunit.main(['run', '--kconfig_add=CONFIG_KASAN=y', '--kconfig_add=CONFIG_KCSAN=y'])
+		# Just verify that we parsed and initialized it correctly here.
+		mock_linux_init.assert_called_once_with('.kunit',
+							kunitconfig_path=None,
+							kconfig_add=['CONFIG_KASAN=y', 'CONFIG_KCSAN=y'],
 							arch='um',
 							cross_compile=None,
 							qemu_config_path=None)
@@ -569,7 +692,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'suite'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'suite'))
 
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
@@ -584,7 +707,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*.test*', None, 'suite'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*.test*', None, 'suite'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
@@ -597,7 +720,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(300, '.kunit', False, 'suite*', None, 'test'))
+				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'test'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
diff --git a/tools/testing/kunit/run_checks.py b/tools/testing/kunit/run_checks.py
new file mode 100755
index 000000000000..4f32133ed77c
--- /dev/null
+++ b/tools/testing/kunit/run_checks.py
@@ -0,0 +1,81 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+#
+# This file runs some basic checks to verify kunit works.
+# It is only of interest if you're making changes to KUnit itself.
+#
+# Copyright (C) 2021, Google LLC.
+# Author: Daniel Latypov <dlatypov@google.com.com>
+
+from concurrent import futures
+import datetime
+import os
+import shutil
+import subprocess
+import sys
+import textwrap
+from typing import Dict, List, Sequence, Tuple
+
+ABS_TOOL_PATH = os.path.abspath(os.path.dirname(__file__))
+TIMEOUT = datetime.timedelta(minutes=5).total_seconds()
+
+commands: Dict[str, Sequence[str]] = {
+	'kunit_tool_test.py': ['./kunit_tool_test.py'],
+	'kunit smoke test': ['./kunit.py', 'run', '--kunitconfig=lib/kunit', '--build_dir=kunit_run_checks'],
+	'pytype': ['/bin/sh', '-c', 'pytype *.py'],
+	'mypy': ['/bin/sh', '-c', 'mypy *.py'],
+}
+
+# The user might not have mypy or pytype installed, skip them if so.
+# Note: you can install both via `$ pip install mypy pytype`
+necessary_deps : Dict[str, str] = {
+	'pytype': 'pytype',
+	'mypy': 'mypy',
+}
+
+def main(argv: Sequence[str]) -> None:
+	if argv:
+		raise RuntimeError('This script takes no arguments')
+
+	future_to_name: Dict[futures.Future, str] = {}
+	executor = futures.ThreadPoolExecutor(max_workers=len(commands))
+	for name, argv in commands.items():
+		if name in necessary_deps and shutil.which(necessary_deps[name]) is None:
+			print(f'{name}: SKIPPED, {necessary_deps[name]} not in $PATH')
+			continue
+		f = executor.submit(run_cmd, argv)
+		future_to_name[f] = name
+
+	has_failures = False
+	print(f'Waiting on {len(future_to_name)} checks ({", ".join(future_to_name.values())})...')
+	for f in  futures.as_completed(future_to_name.keys()):
+		name = future_to_name[f]
+		ex = f.exception()
+		if not ex:
+			print(f'{name}: PASSED')
+			continue
+
+		has_failures = True
+		if isinstance(ex, subprocess.TimeoutExpired):
+			print(f'{name}: TIMED OUT')
+		elif isinstance(ex, subprocess.CalledProcessError):
+			print(f'{name}: FAILED')
+		else:
+			print('{name}: unexpected exception: {ex}')
+			continue
+
+		output = ex.output
+		if output:
+			print(textwrap.indent(output.decode(), '> '))
+	executor.shutdown()
+
+	if has_failures:
+		sys.exit(1)
+
+
+def run_cmd(argv: Sequence[str]):
+	subprocess.check_output(argv, stderr=subprocess.STDOUT, cwd=ABS_TOOL_PATH, timeout=TIMEOUT)
+
+
+if __name__ == '__main__':
+	main(sys.argv[1:])
diff --git a/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
new file mode 100644
index 000000000000..dd873c981108
--- /dev/null
+++ b/tools/testing/kunit/test_data/test_is_test_passed-no_tests_no_plan.log
@@ -0,0 +1,7 @@
+TAP version 14
+1..1
+  # Subtest: suite
+  1..1
+    # Subtest: case
+  ok 1 - case # SKIP
+ok 1 - suite

--------------B199BF0E8E8C6D9C83D37F99--
