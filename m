Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8D328FA78
	for <lists+linux-kselftest@lfdr.de>; Thu, 15 Oct 2020 23:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405067AbgJOVNH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Oct 2020 17:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405065AbgJOVNF (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Oct 2020 17:13:05 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58EB4C0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 14:13:05 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n6so780924ioc.12
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Oct 2020 14:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language;
        bh=g22yLxj3dteulYwJqMUVhkS29hUNhmAma0sCRQEkzhU=;
        b=eAozVI5V9nCaPCcKHHW3X5b4dbUm8eFLCkWo3RXUF87zreeRKEP7AC/GGPmfAh+2KM
         /IjEag6HjSrTG2QO73HUlQkSOOgxl6h92YFs4yXpN+8/3vZZd60+tJo8ot3k4IOsdcon
         jdBFk70A4S2XEJjXoJYWr6P7jA40iF98gCgsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language;
        bh=g22yLxj3dteulYwJqMUVhkS29hUNhmAma0sCRQEkzhU=;
        b=AX2iiskIMGN1qHjuUGRFyo+1+3hiTpHCi1HyoGcJii0eiZTdsTugaUUGd82dOzr3jw
         0p8tWXSL6RygaJSvylYRR4EHm2/YgnKO7c02L7ohwrp1YzL6Fx7NEkCoETlSnAqU/ZPW
         yYJVDFKP+LxhhArP+qSe8BQ7WKuJrjIQ+TPdxb4BZ2cq9ymVeB4Rqh0pOcgLeQ0/vCnW
         QWpLWnSnI0lrYAdnb427/G2+Hbsy8zMb6fLBJ2AxTbopI6ggo6qb1xVCMOZXw8XejZob
         vxX6itBuiSTz1GW2eJJqyPpSntk1/qdyIcE6iSGww8epc7vFf0pg+qxUhEQwBdh3z8lW
         PEBQ==
X-Gm-Message-State: AOAM531mFLKwTzZYBevMdc2blavIjuIViqWhSWygflXTHEDuGD4BPbZs
        W2PXzjiNLCc4jMyzHo/GwJNdXk/tTDnOqQ==
X-Google-Smtp-Source: ABdhPJwvrB3Ez3YusoUhCrlgo4u0yAjimhOYU4CD+qJQXVDXPQOsVTokb5cd2n++E5w7ASPogAX/oQ==
X-Received: by 2002:a02:234a:: with SMTP id u71mr236554jau.3.1602796384292;
        Thu, 15 Oct 2020 14:13:04 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id r16sm159228iln.58.2020.10.15.14.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 14:13:03 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org
From:   Shuah Khan <skhan@linuxfoundation.org>
Subject: [GIT PULL] Kunit fixes update for Linux 5.10-rc1
Message-ID: <18ef2c05-5e4e-bdb3-560b-847aada816c3@linuxfoundation.org>
Date:   Thu, 15 Oct 2020 15:13:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------9136970B5B024F13E75D2D19"
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This is a multi-part message in MIME format.
--------------9136970B5B024F13E75D2D19
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Linus,

Please pull the following Kunit fixes update for Linux 5.10-rc1

This Kunit fixes update consists of several kunit tool bug fixes in
flag handling, run outside kernel tree, make errors, and generating
results.

diff is attached.

thanks,
-- Shuah

----------------------------------------------------------------
The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

   Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest 
tags/linux-kselftest-kunit-fixes-5.10-rc1

for you to fetch changes up to 1abdd39f14b25dd2d69096b624a4f86f158a9feb:

   kunit: tool: fix display of make errors (2020-10-09 14:04:09 -0600)

----------------------------------------------------------------
linux-kselftest-kunit-fixes-5.10-rc1

This Kunit fixes update consists of several kunit tool bug fixes in
flag handling, run outside kernel tree, make errors, and generating
results.

----------------------------------------------------------------
Brendan Higgins (3):
       kunit: tool: fix running kunit_tool from outside kernel tree
       kunit: tool: fix --alltests flag
       kunit: tool: handle when .kunit exists but .kunitconfig does not

Daniel Latypov (1):
       kunit: tool: fix display of make errors

Heidi Fahim (1):
       kunit: tool: allow generating test results in JSON

  tools/testing/kunit/configs/broken_on_uml.config |  1 +
  tools/testing/kunit/kunit.py                     | 58 
+++++++++++++++-------
  tools/testing/kunit/kunit_json.py                | 63 
++++++++++++++++++++++++
  tools/testing/kunit/kunit_kernel.py              | 27 +++++-----
  tools/testing/kunit/kunit_tool_test.py           | 33 +++++++++++++
  5 files changed, 154 insertions(+), 28 deletions(-)
  create mode 100644 tools/testing/kunit/kunit_json.py
----------------------------------------------------------------

--------------9136970B5B024F13E75D2D19
Content-Type: text/x-patch; charset=UTF-8;
 name="linux-kselftest-kunit-fixes-5.10-rc1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="linux-kselftest-kunit-fixes-5.10-rc1.diff"

diff --git a/tools/testing/kunit/configs/broken_on_uml.config b/tools/testing/kunit/configs/broken_on_uml.config
index 239b9f03da2c..a7f0603d33f6 100644
--- a/tools/testing/kunit/configs/broken_on_uml.config
+++ b/tools/testing/kunit/configs/broken_on_uml.config
@@ -39,3 +39,4 @@
 # CONFIG_QCOM_CPR is not set
 # CONFIG_RESET_BRCMSTB_RESCAL is not set
 # CONFIG_RESET_INTEL_GW is not set
+# CONFIG_ADI_AXI_ADC is not set
diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 425ef40067e7..ebf5f5763dee 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -17,6 +17,7 @@ from collections import namedtuple
 from enum import Enum, auto
 
 import kunit_config
+import kunit_json
 import kunit_kernel
 import kunit_parser
 
@@ -30,9 +31,9 @@ KunitBuildRequest = namedtuple('KunitBuildRequest',
 KunitExecRequest = namedtuple('KunitExecRequest',
 			      ['timeout', 'build_dir', 'alltests'])
 KunitParseRequest = namedtuple('KunitParseRequest',
-			       ['raw_output', 'input_data'])
+			       ['raw_output', 'input_data', 'build_dir', 'json'])
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
-					   'build_dir', 'alltests',
+					   'build_dir', 'alltests', 'json',
 					   'make_options'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
@@ -113,12 +114,22 @@ def parse_tests(request: KunitParseRequest) -> KunitResult:
 	test_result = kunit_parser.TestResult(kunit_parser.TestStatus.SUCCESS,
 					      [],
 					      'Tests not Parsed.')
+
 	if request.raw_output:
 		kunit_parser.raw_output(request.input_data)
 	else:
 		test_result = kunit_parser.parse_run_tests(request.input_data)
 	parse_end = time.time()
 
+	if request.json:
+		json_obj = kunit_json.get_json_result(
+					test_result=test_result,
+					def_config='kunit_defconfig',
+					build_dir=request.build_dir,
+					json_path=request.json)
+		if request.json == 'stdout':
+			print(json_obj)
+
 	if test_result.status != kunit_parser.TestStatus.SUCCESS:
 		return KunitResult(KunitStatus.TEST_FAILURE, test_result,
 				   parse_end - parse_start)
@@ -151,7 +162,9 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 		return exec_result
 
 	parse_request = KunitParseRequest(request.raw_output,
-					  exec_result.result)
+					  exec_result.result,
+					  request.build_dir,
+					  request.json)
 	parse_result = parse_tests(parse_request)
 
 	run_end = time.time()
@@ -195,7 +208,12 @@ def add_exec_opts(parser):
 def add_parse_opts(parser):
 	parser.add_argument('--raw_output', help='don\'t format output from kernel',
 			    action='store_true')
-
+	parser.add_argument('--json',
+			    nargs='?',
+			    help='Stores test results in a JSON, and either '
+			    'prints to stdout or saves to file if a '
+			    'filename is specified',
+			    type=str, const='stdout', default=None)
 
 def main(argv, linux=None):
 	parser = argparse.ArgumentParser(
@@ -237,10 +255,16 @@ def main(argv, linux=None):
 
 	cli_args = parser.parse_args(argv)
 
+	if get_kernel_root_path():
+		os.chdir(get_kernel_root_path())
+
 	if cli_args.subcommand == 'run':
 		if not os.path.exists(cli_args.build_dir):
 			os.mkdir(cli_args.build_dir)
 
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
+
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -249,14 +273,18 @@ def main(argv, linux=None):
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.alltests,
+				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'config':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
+		if cli_args.build_dir and (
+				not os.path.exists(cli_args.build_dir)):
+			os.mkdir(cli_args.build_dir)
+
+		if not os.path.exists(kunit_kernel.kunitconfig_path):
+			create_default_kunitconfig()
 
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
@@ -270,10 +298,6 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'build':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -288,10 +312,6 @@ def main(argv, linux=None):
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	elif cli_args.subcommand == 'exec':
-		if cli_args.build_dir:
-			if not os.path.exists(cli_args.build_dir):
-				os.mkdir(cli_args.build_dir)
-
 		if not linux:
 			linux = kunit_kernel.LinuxSourceTree()
 
@@ -300,7 +320,9 @@ def main(argv, linux=None):
 						cli_args.alltests)
 		exec_result = exec_tests(linux, exec_request)
 		parse_request = KunitParseRequest(cli_args.raw_output,
-						  exec_result.result)
+						  exec_result.result,
+						  cli_args.build_dir,
+						  cli_args.json)
 		result = parse_tests(parse_request)
 		kunit_parser.print_with_timestamp((
 			'Elapsed time: %.3fs\n') % (
@@ -314,7 +336,9 @@ def main(argv, linux=None):
 			with open(cli_args.file, 'r') as f:
 				kunit_output = f.read().splitlines()
 		request = KunitParseRequest(cli_args.raw_output,
-					    kunit_output)
+					    kunit_output,
+					    cli_args.build_dir,
+					    cli_args.json)
 		result = parse_tests(request)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
new file mode 100644
index 000000000000..624b31b2dbd6
--- /dev/null
+++ b/tools/testing/kunit/kunit_json.py
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Generates JSON from KUnit results according to
+# KernelCI spec: https://github.com/kernelci/kernelci-doc/wiki/Test-API
+#
+# Copyright (C) 2020, Google LLC.
+# Author: Heidi Fahim <heidifahim@google.com>
+
+import json
+import os
+
+import kunit_parser
+
+from kunit_parser import TestStatus
+
+def get_json_result(test_result, def_config, build_dir, json_path):
+	sub_groups = []
+
+	# Each test suite is mapped to a KernelCI sub_group
+	for test_suite in test_result.suites:
+		sub_group = {
+			"name": test_suite.name,
+			"arch": "UM",
+			"defconfig": def_config,
+			"build_environment": build_dir,
+			"test_cases": [],
+			"lab_name": None,
+			"kernel": None,
+			"job": None,
+			"git_branch": "kselftest",
+		}
+		test_cases = []
+		# TODO: Add attachments attribute in test_case with detailed
+		#  failure message, see https://api.kernelci.org/schema-test-case.html#get
+		for case in test_suite.cases:
+			test_case = {"name": case.name, "status": "FAIL"}
+			if case.status == TestStatus.SUCCESS:
+				test_case["status"] = "PASS"
+			elif case.status == TestStatus.TEST_CRASHED:
+				test_case["status"] = "ERROR"
+			test_cases.append(test_case)
+		sub_group["test_cases"] = test_cases
+		sub_groups.append(sub_group)
+	test_group = {
+		"name": "KUnit Test Group",
+		"arch": "UM",
+		"defconfig": def_config,
+		"build_environment": build_dir,
+		"sub_groups": sub_groups,
+		"lab_name": None,
+		"kernel": None,
+		"job": None,
+		"git_branch": "kselftest",
+	}
+	json_obj = json.dumps(test_group, indent=4)
+	if json_path != 'stdout':
+		with open(json_path, 'w') as result_path:
+			result_path.write(json_obj)
+		root = __file__.split('tools/testing/kunit/')[0]
+		kunit_parser.print_with_timestamp(
+			"Test results stored in %s" %
+			os.path.join(root, result_path.name))
+	return json_obj
diff --git a/tools/testing/kunit/kunit_kernel.py b/tools/testing/kunit/kunit_kernel.py
index e20e2056cb38..b557b1e93f98 100644
--- a/tools/testing/kunit/kunit_kernel.py
+++ b/tools/testing/kunit/kunit_kernel.py
@@ -36,9 +36,9 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(['make', 'mrproper'], stderr=subprocess.STDOUT)
 		except OSError as e:
-			raise ConfigError('Could not call make command: ' + e)
+			raise ConfigError('Could not call make command: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise ConfigError(e.output)
+			raise ConfigError(e.output.decode())
 
 	def make_olddefconfig(self, build_dir, make_options):
 		command = ['make', 'ARCH=um', 'olddefconfig']
@@ -49,22 +49,27 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(command, stderr=subprocess.STDOUT)
 		except OSError as e:
-			raise ConfigError('Could not call make command: ' + e)
+			raise ConfigError('Could not call make command: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise ConfigError(e.output)
+			raise ConfigError(e.output.decode())
 
-	def make_allyesconfig(self):
+	def make_allyesconfig(self, build_dir, make_options):
 		kunit_parser.print_with_timestamp(
 			'Enabling all CONFIGs for UML...')
+		command = ['make', 'ARCH=um', 'allyesconfig']
+		if make_options:
+			command.extend(make_options)
+		if build_dir:
+			command += ['O=' + build_dir]
 		process = subprocess.Popen(
-			['make', 'ARCH=um', 'allyesconfig'],
+			command,
 			stdout=subprocess.DEVNULL,
 			stderr=subprocess.STDOUT)
 		process.wait()
 		kunit_parser.print_with_timestamp(
 			'Disabling broken configs to run KUnit tests...')
 		with ExitStack() as es:
-			config = open(KCONFIG_PATH, 'a')
+			config = open(get_kconfig_path(build_dir), 'a')
 			disable = open(BROKEN_ALLCONFIG_PATH, 'r').read()
 			config.write(disable)
 		kunit_parser.print_with_timestamp(
@@ -79,9 +84,9 @@ class LinuxSourceTreeOperations(object):
 		try:
 			subprocess.check_output(command, stderr=subprocess.STDOUT)
 		except OSError as e:
-			raise BuildError('Could not call execute make: ' + e)
+			raise BuildError('Could not call execute make: ' + str(e))
 		except subprocess.CalledProcessError as e:
-			raise BuildError(e.output)
+			raise BuildError(e.output.decode())
 
 	def linux_bin(self, params, timeout, build_dir, outfile):
 		"""Runs the Linux UML binary. Must be named 'linux'."""
@@ -161,9 +166,9 @@ class LinuxSourceTree(object):
 			return self.build_config(build_dir, make_options)
 
 	def build_um_kernel(self, alltests, jobs, build_dir, make_options):
-		if alltests:
-			self._ops.make_allyesconfig()
 		try:
+			if alltests:
+				self._ops.make_allyesconfig(build_dir, make_options)
 			self._ops.make_olddefconfig(build_dir, make_options)
 			self._ops.make(jobs, build_dir, make_options)
 		except (ConfigError, BuildError) as e:
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 287c74d821c3..99c3c5671ea4 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -11,11 +11,13 @@ from unittest import mock
 
 import tempfile, shutil # Handling test_tmpdir
 
+import json
 import os
 
 import kunit_config
 import kunit_parser
 import kunit_kernel
+import kunit_json
 import kunit
 
 test_tmpdir = ''
@@ -230,6 +232,37 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(file.readlines())
 		self.assertEqual('kunit-resource-test', result.suites[0].name)
 
+class KUnitJsonTest(unittest.TestCase):
+
+	def _json_for(self, log_file):
+		with(open(get_absolute_path(log_file))) as file:
+			test_result = kunit_parser.parse_run_tests(file)
+			json_obj = kunit_json.get_json_result(
+				test_result=test_result,
+				def_config='kunit_defconfig',
+				build_dir=None,
+				json_path='stdout')
+		return json.loads(json_obj)
+
+	def test_failed_test_json(self):
+		result = self._json_for(
+			'test_data/test_is_test_passed-failure.log')
+		self.assertEqual(
+			{'name': 'example_simple_test', 'status': 'FAIL'},
+			result["sub_groups"][1]["test_cases"][0])
+
+	def test_crashed_test_json(self):
+		result = self._json_for(
+			'test_data/test_is_test_passed-crash.log')
+		self.assertEqual(
+			{'name': 'example_simple_test', 'status': 'ERROR'},
+			result["sub_groups"][1]["test_cases"][0])
+
+	def test_no_tests_json(self):
+		result = self._json_for(
+			'test_data/test_is_test_passed-no_tests_run.log')
+		self.assertEqual(0, len(result['sub_groups']))
+
 class StrContains(str):
 	def __eq__(self, other):
 		return self in other

--------------9136970B5B024F13E75D2D19--
