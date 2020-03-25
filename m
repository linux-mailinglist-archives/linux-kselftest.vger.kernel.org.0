Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9D6819340B
	for <lists+linux-kselftest@lfdr.de>; Wed, 25 Mar 2020 23:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbgCYW7T (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 25 Mar 2020 18:59:19 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:39056 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgCYW7T (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 25 Mar 2020 18:59:19 -0400
Received: by mail-pf1-f201.google.com with SMTP id x189so3526071pfd.6
        for <linux-kselftest@vger.kernel.org>; Wed, 25 Mar 2020 15:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=703Y1PKm2HWn9gyPtbR/P+tRSHGQjnfCphPxIyJ++J4=;
        b=VZziPPs1mjARJd6AZ56ZxyW5rHGu9WA3EZSuYl9kTjjuf0x/0CH7yg8NVIqd6zk8TY
         lm01RhEXyetye3UALFPTmfzh1YbtqEHXp3JIeGaI2jAgUEJofz9UufpxWLVHMP7a2QWH
         TBA4CnBZYTtQ6gIc1AhrFSPRA1AKYOqBnDzV113dBtJXb+k3ny46yScHa6R56A5tfXIk
         p1D0RsTB0VUpcFVeE94bkLYSuKdlUHNm2pcJn6PElW04pM+eXmzOiZWjt294qYe1cj7l
         pgT0sf2qnpAo4KkVr7oI3LsO6s1cM3dLmnc2y8kOjamZ7kJ3c9bw2exCS+caZIBNRt4q
         oGzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=703Y1PKm2HWn9gyPtbR/P+tRSHGQjnfCphPxIyJ++J4=;
        b=lC7wm9GEVUbsKyjyN3vWNTRqMMzhM3j9sFpcZ2g2uM+ASacuSoO4chpQ+HfPPkoUry
         pHdigDQsZ1lrwf1J7nhDz0QJVYdDnFR1JRp3B3T6ETxxLhvR9SLrBVklSwAeIdqCzRJj
         QZMNTYTXRenuqhOSedrR4SZWpFR5PaGUUn5J9Uu+1h1NoqfkjsWEksSEd4btscSjdRdD
         gE1gg6IONDuTPujzCM1yCUd4GTVY1S01AelB4H0EiV9Gg5/ANuLmXTP3IjqlLWKhj6pg
         WJkasO3HA2ux3g3d/bb+b4veFTJRKSqMo4IZyadpTCr6rixKcrSnygUVHIfRZvk9dJdO
         cgXQ==
X-Gm-Message-State: ANhLgQ3V8VCbngYPWRJ6lf7h/eacaXIrus7z+uVg7ld5wCXfZ5/kNoWs
        qUsmvdXmPQuc0c+zPfiLolz2aArzWlRdohOu
X-Google-Smtp-Source: ADFU+vuwkS7dNE4QXSH3KezWUSyd/AkcKfOxcYmWASCMPqnU+oTugdftTDt9jJWjpg7ksfZEMa/vf/gku87K4HtE
X-Received: by 2002:a17:90a:e382:: with SMTP id b2mr5863803pjz.83.1585177155864;
 Wed, 25 Mar 2020 15:59:15 -0700 (PDT)
Date:   Wed, 25 Mar 2020 15:59:11 -0700
Message-Id: <20200325225911.131940-1-heidifahim@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH] kunit: convert test results to JSON
From:   Heidi Fahim <heidifahim@google.com>
To:     brendanhiggins@google.com, skhan@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com
Cc:     Heidi Fahim <heidifahim@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a --json flag, which when specified when kunit_tool is run, calls
method get_json_result.  This is a method within kunit_json.py that
formats KUnit results into a dict conforming to the following KernelCI
API test_group spec:
https://api.kernelci.org/schema-test-group.html#post.  The user can
specify a filename as the value to json in order to store the JSON
results under linux/.
Tested within kunit_tool_test.py in a new test case called
KUnitJsonTest.

Signed-off-by: Heidi Fahim <heidifahim@google.com>
---
 tools/testing/kunit/kunit.py                  |  24 ++++++-
 tools/testing/kunit/kunit_json.py             |  63 ++++++++++++++++++
 tools/testing/kunit/kunit_tool_test.py        |  33 +++++++++
 .../kunit/test_data/test_pound_sign.log       | Bin 0 -> 1656 bytes
 4 files changed, 118 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/kunit/kunit_json.py

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7dca74774dd2..ce8f8e5e0ccb 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -17,6 +17,7 @@ from collections import namedtuple
 from enum import Enum, auto
 
 import kunit_config
+import kunit_json
 import kunit_kernel
 import kunit_parser
 
@@ -24,10 +25,11 @@ KunitResult = namedtuple('KunitResult', ['status','result'])
 
 KunitRequest = namedtuple('KunitRequest', ['raw_output','timeout', 'jobs',
 					   'build_dir', 'defconfig',
-					   'alltests', 'make_options'])
+					   'alltests', 'make_options', 'json'])
 
 KernelDirectoryPath = sys.argv[0].split('tools/testing/kunit/')[0]
 
+
 class KunitStatus(Enum):
 	SUCCESS = auto()
 	CONFIG_FAILURE = auto()
@@ -70,6 +72,7 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	kunit_output = linux.run_kernel(
 		timeout=None if request.alltests else request.timeout,
 		build_dir=request.build_dir)
+
 	if request.raw_output:
 		raw_output = kunit_parser.raw_output(kunit_output)
 		isolated = list(kunit_parser.isolate_kunit_output(raw_output))
@@ -86,6 +89,15 @@ def run_tests(linux: kunit_kernel.LinuxSourceTree,
 				build_end - build_start,
 				test_end - test_start))
 
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
 		return KunitResult(KunitStatus.TEST_FAILURE, test_result)
 	else:
@@ -130,6 +142,13 @@ def main(argv, linux=None):
 				help='X=Y make option, can be repeated.',
 				action='append')
 
+	run_parser.add_argument('--json',
+				nargs='?',
+				help='Stores test results in a JSON, and either '
+				'prints to stdout or saves to file if a '
+				'filename is specified',
+				const='stdout')
+
 	cli_args = parser.parse_args(argv)
 
 	if cli_args.subcommand == 'run':
@@ -155,7 +174,8 @@ def main(argv, linux=None):
 				       cli_args.build_dir,
 				       cli_args.defconfig,
 				       cli_args.alltests,
-				       cli_args.make_options)
+				       cli_args.make_options,
+				       cli_args.json)
 		result = run_tests(linux, request)
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
index ce47e87b633a..94e8a295d466 100755
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
@@ -219,6 +221,37 @@ class KUnitParserTest(unittest.TestCase):
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
diff --git a/tools/testing/kunit/test_data/test_pound_sign.log b/tools/testing/kunit/test_data/test_pound_sign.log
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..28ffa5ba03bfa81ea02ea9d38e7de7acf3dd9e5d 100644
GIT binary patch
literal 1656
zcmah}U2EGg6n$=g#f7|Vtj^>lPBOzDM#o@mlt9+Kgd${FPEBlGBgsqs?{^h<Y3h$o
zFBaGLocpP>13GNVmW<8=R3_K%5Q9W*u~4upWe`4q(jqBTdcAw?ZG=v-jA5@FZ|^*5
zoU$NALGF+lEFssq<A{~zdHR7p&7+U(X~E!_yGM{l@40vQ%(~pazHH!+GB!sI;iCKZ
zY69Cjp-?V{LrnyMQ5I_>Rp5<1_i#FmdPY1z2tkYI|M1-7PdS}Ub_h8eK~m)?&(I;{
zd<2<NV1vyl7BWOggn_Hc5ba`wRu)R=x;oPiRuheYD}$9XJTpphG^wKX*mr|pw(;#T
zTvPxWb#R&-VC|~9KeFD0ooNCooO~P|@vNKL)n#t&WQm2JSh%gFRMuv7!M#yqYailx
z8TM&AUN~yqVM$ThVIE55OcVU4mW$eHC#dHEeUvCiE1wT#?U%cS^A_HAK$VqiIBG75
z($V`G!unJPuo@k2@gj4y7$WV7g73Ls@d32giPqc=`3mz^u|IR`05hOx29+=__XXIv
z%Xf#6<%P11b*dyatBVv$thED!=x%_Ts?sj1OY%b*t$Y}rODc$J2is^#<A~w+w`~mf
zCs_oC7u=9pAjzurLE}*e38}&1-KX^pd*7wM-Q35(VDtTJOgeOnB`K*rii#c_+)*qi
zNQ+5Dqv>MG0wcp<uf!}(SCXw)kqXk>xCSP@rQbRs58c`TmTbn>%WO@TFp;w*gB6RU
km;Ljlo8cvfMVVCc>`K4bOfE$-fO&T9$C>+RbV7Fh7t6}$ApigX

literal 0
HcmV?d00001

-- 
2.25.1.696.g5e7596f4ac-goog

