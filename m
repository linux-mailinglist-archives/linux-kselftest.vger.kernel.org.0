Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188292421F4
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 23:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgHKV2M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 11 Aug 2020 17:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKV2J (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 11 Aug 2020 17:28:09 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAF3C061787
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Aug 2020 14:28:09 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id x3so1343pga.4
        for <linux-kselftest@vger.kernel.org>; Tue, 11 Aug 2020 14:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N13wpgYndNaXgSy4by0nKxgHXlrjLqcp9reNbhtILvg=;
        b=dqTCW2YdplgHCyPLFdFZqxIu4yC4Dw6PjLNPMQutQkA/Hx2zIhZ9O1hYxQlK+njp6H
         fVNorFghrQA/cN0HlOgyVvSrhkXlvYVXne9fHFvr/JCupk4Jv7TO/bz95ZEHqT1xyDhb
         n2NXx8N0EVnL6+nNx+FRg5Qpr/aJj2LgH3V4PgHc3evhf1jShU02rR7tVucs80yX1wcA
         Uld4UL8xVAVUUpZYPdiYT+3EMDjvhPLMAH9vSIrpf5ys3OjQmCkmGEctF5DBJ0oV+kgy
         nFeFCLmRytsmBnIVIld5VTv8iwYIG6Xm5to98fGTT8uWjRh7SInID2SRe9TmIrgkqYtU
         e8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N13wpgYndNaXgSy4by0nKxgHXlrjLqcp9reNbhtILvg=;
        b=hCqqS/lkPH+ezR4+akpJjEqah7wk13X40lF6D0sO1y9NkRkFctseBnoWXMKZz4Qx0w
         3SR13lDUu2STupbDhaxQkzwp+yCcCBrt4ypJowl9qS40vZZVFJuayExVvcwoxvun7cJa
         h0oJQxYk7NOi2im4N0Aj/1AZehPVTl81IdOelCKWMr16KVlI7OK+jKZlyXUkty6rZQYH
         E2GvupPCj0FXW7Uxsb+QDNb1Aq5NVB21NST7RstHihb32hHjkJ99ChIYnTt8Ol3iFDRT
         upeKes10W0kkZr9zhcw15GVKXaIuoIu0yU6LU+m4RN4BNXG9LMXrVxClX1YvAntJPcTB
         0skw==
X-Gm-Message-State: AOAM532H3Kt7EiJPhea+XJD3WXky87i5RVVADe7ORA9bZyzF8MLeD52w
        nLz4onwZHY0zHS3WbXnoHTUmib9CBddNHSOk3KWrGA==
X-Google-Smtp-Source: ABdhPJxQOFWZaiQmvlVy+S/FZ0p2TWkzSSH3fPC7l/fcdmOFd1B8nudfxlecAoDP0AsDyHh5PJwTjin6wSPYNQc8VBOYXQ==
X-Received: by 2002:a17:902:d345:: with SMTP id l5mr2400419plk.276.1597181288284;
 Tue, 11 Aug 2020 14:28:08 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:27:56 -0700
In-Reply-To: <20200811212756.3328740-1-brendanhiggins@google.com>
Message-Id: <20200811212756.3328740-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200811212756.3328740-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 2/2] kunit: tool: allow generating test results in JSON
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Tim.Bird@sony.com,
        Heidi Fahim <heidifahim@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Heidi Fahim <heidifahim@google.com>

Add a --json flag, which when specified generates JSON formatted test
results conforming to the KernelCI API test_group spec[1]. The user can
use the new flag to specify a filename to print the json formatted
results to.

Link[1]: https://api.kernelci.org/schema-test-group.html#post
Signed-off-by: Heidi Fahim <heidifahim@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 tools/testing/kunit/kunit.py           | 35 +++++++++++---
 tools/testing/kunit/kunit_json.py      | 63 ++++++++++++++++++++++++++
 tools/testing/kunit/kunit_tool_test.py | 33 ++++++++++++++
 3 files changed, 125 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/kunit/kunit_json.py

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index e2caf4e24ecb2..3c95a0eb0d048 100755
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
@@ -253,6 +271,7 @@ def main(argv, linux=None):
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.alltests,
+				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
@@ -297,7 +316,9 @@ def main(argv, linux=None):
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
@@ -311,7 +332,9 @@ def main(argv, linux=None):
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
index 0000000000000..624b31b2dbd62
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
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 287c74d821c33..99c3c5671ea48 100755
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
-- 
2.28.0.236.gb10cc79966-goog

