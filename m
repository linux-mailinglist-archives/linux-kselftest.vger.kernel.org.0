Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9FA23F5C0
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Aug 2020 03:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgHHBRl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Aug 2020 21:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbgHHBRl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Aug 2020 21:17:41 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 258F7C061756
        for <linux-kselftest@vger.kernel.org>; Fri,  7 Aug 2020 18:17:41 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id h6so2767491qvz.14
        for <linux-kselftest@vger.kernel.org>; Fri, 07 Aug 2020 18:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yd6TGRc1GXqN/EjtG+8Verq36FPJdYPHa8QPD7rKsBw=;
        b=TuoU7TfCVBfpE2cCm9NmCqDraN4zNzlW7gPwmIpx6K/oM4Q/HzkbI3h82zn0k0TRbb
         qkjfxDDVmZgwieq5MsHrot7tkDiIegJvaQ81Y8kNk2Nmo/gO3R+by89MaLPEEhLjC2hf
         iUe0qc2wDryiDiX6lHZeRcMu2C14FwodJ0shPV18YQyjaXg6MPbsf2zCRbO7S8aJIW5U
         uvlCoPUUOKjEA8Fmdgkwaku1Pbz23uA3WOUL8nRB2PIbWriUNaAcVl5rjPAAB9be/1Hb
         +b9ixQDQvWydkEdUL+rtl5JHrqC3vBPmND3vMbAsRiD503ib7L5LJVm1OArdlAt8+5K6
         1Yqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yd6TGRc1GXqN/EjtG+8Verq36FPJdYPHa8QPD7rKsBw=;
        b=VwSSEMLlENaknX2f1cFe+35VhzkXnsy4IwXZrEpK8UWzb4eznxVcQFgafEjlJLDFJz
         DSrdxb9yOv5X9+Q6jDYUGAxOXnhw6ad7AXFbP8+sSZSWygRja5owtEFhTt6uyKHx/Tfs
         rIZOcAIQFRiE/wD08KhjLYwdWvd+Y5U/TW8VAv0ZpAfKzQ4qMZ/gy/8Zg2dNsth+I6GS
         1uk712AqSigqBcLVmnUQW4zRg4P6PAFgZ3TkTf32pAz0/klSoZHAys9FzBMkufMmGBRs
         CuJycIZpE8GreeJ5Ccmo41P+vZr72nYxGhD6g0qItzjqwwwzR71OsIYrMrP5yhZgSFC8
         /LcQ==
X-Gm-Message-State: AOAM530JEnWBqLpUDxjQ7Y5MKqWZhFDQtLUgbAPxJYIi0z4FuVruq8l8
        kY1hUDSBiL8CVnWbdPDs237n6MnQJ3sGGkEk6yLq3w==
X-Google-Smtp-Source: ABdhPJx+t440pJAV1URxY4FC4xXu7li3tPKgxdxjbCWQkD0lFIKWnmZ0ha7fd/s17cbCixhZFQD4B9W9K604rY3jrFVlRw==
X-Received: by 2002:ad4:44e5:: with SMTP id p5mr17363190qvt.197.1596849460227;
 Fri, 07 Aug 2020 18:17:40 -0700 (PDT)
Date:   Fri,  7 Aug 2020 18:16:51 -0700
In-Reply-To: <20200808011651.2113930-1-brendanhiggins@google.com>
Message-Id: <20200808011651.2113930-2-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20200808011651.2113930-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v1 2/2] kunit: tool: allow generating test results in JSON
From:   Brendan Higgins <brendanhiggins@google.com>
To:     shuah@kernel.org, davidgow@google.com
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Heidi Fahim <heidifahim@google.com>,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Heidi Fahim <heidifahim@google.com>

Add a --json flag, which when specified when kunit_tool is run,
generates JSON formatted test results conforming to the KernelCI API
test_group spec[1]. The user can the new flag to specify a filename as
the value to json in order to store the JSON results under linux/.

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
index 96344a11ff1f..485b7c63b967 100755
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
@@ -254,6 +272,7 @@ def main(argv, linux=None):
 				       cli_args.jobs,
 				       cli_args.build_dir,
 				       cli_args.alltests,
+				       cli_args.json,
 				       cli_args.make_options)
 		result = run_tests(linux, request)
 		if result.status != KunitStatus.SUCCESS:
@@ -308,7 +327,9 @@ def main(argv, linux=None):
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
@@ -322,7 +343,9 @@ def main(argv, linux=None):
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
-- 
2.28.0.236.gb10cc79966-goog

