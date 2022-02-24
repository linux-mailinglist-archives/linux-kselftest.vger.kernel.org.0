Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 990304C35BF
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Feb 2022 20:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbiBXTVg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 24 Feb 2022 14:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbiBXTV3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 24 Feb 2022 14:21:29 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB441E522C
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 11:20:59 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r14-20020a5b018e000000b00624f6f97bf4so749428ybl.12
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Feb 2022 11:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5/X2V+LUb5lUAOXbMwMCBLiJRGGwZlFxW0+/UOkBjzQ=;
        b=I7rTEbob1KpJ25AxqDD6poFdpTi6PO5gSy3hmZbF6mAkZG2JGgNI8NaJK4M4f/qLdo
         heJBewx4DQLBI06OpVCsai0xlqX4FDjJy4Doy5Wp+1iws5KDD4UmaCWrmXXsXjrr14mD
         5oJ9akJgQf583BcLputTjpd0vzhxJ086QOHZCk9DkcLx/a3RRMX6MMo1LtPwQKKjHB9v
         Eeh8DM/Dh4oR9SyUw2Te7AyVLCCMQ/ds4a5Dtb+nbzL0oTRDrP5nkdoM6cwsClvi3rSE
         bFLOagVBxroRoa/N6pO0rTLENMkaoc6eE4uOkpH5EADcjsAfcGZtqLxsOyOvHlHFg71S
         Unjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5/X2V+LUb5lUAOXbMwMCBLiJRGGwZlFxW0+/UOkBjzQ=;
        b=vv1fLP+chAKq3IF5MmHl6pvt5Z7eobL4Orj0CvM22e9iJJ3XOrN8X00PTxKRQiIurb
         RswLVlOCS8eGkhIjozu/Uih6fCmJfaiKo7q5QvRcqhPaoy+Qkk8DWRyby1YT+WmQdWMf
         gEfLVXdFy0qDHvajD0xwYnPj2NTzxLHWyWYkXY1AO8ocv2iasynqGIeI/q+iYY2EGEKz
         2kdu18hEvEVT+0E83Oy1HW4vu7f40+WzpiAJzFhfF1ExL4kJNuhDKcVgpm6kCST8bZs3
         l8mNwnF6f4S7fAKaQbDcFySmm8UHuiKkPrKVYTGp+aecZi/IA3BYia2AtXsm05lEcADi
         FtDA==
X-Gm-Message-State: AOAM530lOaHZ0HD9p3Kt2VOJ9Do7S+ERcxZORmeavOoHo4jwaWevp85a
        8aV4zwoLspRGWdvOVZtHTAnG81u4Lp8reg==
X-Google-Smtp-Source: ABdhPJx4s6dYkJwPQXgMCaM3MkzCoRxl//hffVWfyTTKPUGs5Zfx2oIKatlg/xsI5gXq0xHURGV1kT6EU86Y6g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:96e5:fbf5:15ed:8b6f])
 (user=dlatypov job=sendgmr) by 2002:a25:8748:0:b0:624:783e:d501 with SMTP id
 e8-20020a258748000000b00624783ed501mr3853640ybn.127.1645730458610; Thu, 24
 Feb 2022 11:20:58 -0800 (PST)
Date:   Thu, 24 Feb 2022 11:20:35 -0800
In-Reply-To: <20220224192036.2388302-1-dlatypov@google.com>
Message-Id: <20220224192036.2388302-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220224192036.2388302-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 2/3] kunit: tool: refactor how we plumb metadata into JSON
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When using --json, kunit.py run/exec/parse will produce results in
KernelCI json format.
As part of that, we include the build_dir that was used, and we
(incorrectly) hardcode in the arch, etc.

We'll want a way to plumb more values (as well as the correct `arch`),
so this patch groups those fields into kunit_json.Metadata type.
This patch should have no user visible changes.

And since we only used build_dir in KunitParseRequest for json, we can
now move it out of that struct and add it into KunitExecRequest, which
needs it and used to get it via inheritance.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit.py           | 16 +++++++-------
 tools/testing/kunit/kunit_json.py      | 29 ++++++++++++++++++--------
 tools/testing/kunit/kunit_tool_test.py |  9 ++++----
 3 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 4cb91d191f1d..7dd6ed42141f 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -47,11 +47,11 @@ class KunitBuildRequest(KunitConfigRequest):
 @dataclass
 class KunitParseRequest:
 	raw_output: Optional[str]
-	build_dir: str
 	json: Optional[str]
 
 @dataclass
 class KunitExecRequest(KunitParseRequest):
+	build_dir: str
 	timeout: int
 	alltests: bool
 	filter_glob: str
@@ -153,6 +153,8 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 				test_glob = request.filter_glob.split('.', maxsplit=2)[1]
 				filter_globs = [g + '.'+ test_glob for g in filter_globs]
 
+	metadata = kunit_json.Metadata(build_dir=request.build_dir)
+
 	test_counts = kunit_parser.TestCounts()
 	exec_time = 0.0
 	for i, filter_glob in enumerate(filter_globs):
@@ -165,7 +167,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 			filter_glob=filter_glob,
 			build_dir=request.build_dir)
 
-		_, test_result = parse_tests(request, run_result)
+		_, test_result = parse_tests(request, metadata, run_result)
 		# run_kernel() doesn't block on the kernel exiting.
 		# That only happens after we get the last line of output from `run_result`.
 		# So exec_time here actually contains parsing + execution time, which is fine.
@@ -189,7 +191,7 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	else:
 		return KunitStatus.TEST_FAILURE
 
-def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
+def parse_tests(request: KunitParseRequest, metadata: kunit_json.Metadata, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
 	parse_start = time.time()
 
 	test_result = kunit_parser.Test()
@@ -216,8 +218,7 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[
 	if request.json:
 		json_str = kunit_json.get_json_result(
 					test=test_result,
-					def_config='kunit_defconfig',
-					build_dir=request.build_dir)
+					metadata=metadata)
 		if request.json == 'stdout':
 			print(json_str)
 		else:
@@ -504,10 +505,11 @@ def main(argv, linux=None):
 		else:
 			with open(cli_args.file, 'r', errors='backslashreplace') as f:
 				kunit_output = f.read().splitlines()
+		# We know nothing about how the result was created!
+		metadata = kunit_json.Metadata()
 		request = KunitParseRequest(raw_output=cli_args.raw_output,
-					    build_dir='',
 					    json=cli_args.json)
-		result, _ = parse_tests(request, kunit_output)
+		result, _ = parse_tests(request, metadata, kunit_output)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	else:
diff --git a/tools/testing/kunit/kunit_json.py b/tools/testing/kunit/kunit_json.py
index 14a480d3308a..0a7e29a315ed 100644
--- a/tools/testing/kunit/kunit_json.py
+++ b/tools/testing/kunit/kunit_json.py
@@ -6,6 +6,7 @@
 # Copyright (C) 2020, Google LLC.
 # Author: Heidi Fahim <heidifahim@google.com>
 
+from dataclasses import dataclass
 import json
 import os
 
@@ -14,6 +15,13 @@ import kunit_parser
 from kunit_parser import Test, TestStatus
 from typing import Any, Dict
 
+@dataclass
+class Metadata:
+	"""Stores metadata about this run to include in get_json_result()."""
+	arch: str = 'UM'
+	def_config: str = 'kunit_defconfig'
+	build_dir: str = ''
+
 JsonObj = Dict[str, Any]
 
 _status_map: Dict[TestStatus, str] = {
@@ -22,14 +30,13 @@ _status_map: Dict[TestStatus, str] = {
 	TestStatus.TEST_CRASHED: "ERROR",
 }
 
-def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
+def _get_group_json(test: Test, common_fields: JsonObj) -> JsonObj:
 	sub_groups = []  # List[JsonObj]
 	test_cases = []  # List[JsonObj]
 
 	for subtest in test.subtests:
 		if subtest.subtests:
-			sub_group = _get_group_json(subtest, def_config,
-				build_dir)
+			sub_group = _get_group_json(subtest, common_fields)
 			sub_groups.append(sub_group)
 			continue
 		status = _status_map.get(subtest.status, "FAIL")
@@ -37,19 +44,23 @@ def _get_group_json(test: Test, def_config: str, build_dir: str) -> JsonObj:
 
 	test_group = {
 		"name": test.name,
-		"arch": "UM",
-		"defconfig": def_config,
-		"build_environment": build_dir,
 		"sub_groups": sub_groups,
 		"test_cases": test_cases,
+	}
+	test_group.update(common_fields)
+	return test_group
+
+def get_json_result(test: Test, metadata: Metadata) -> str:
+	common_fields = {
+		"arch": metadata.arch,
+		"defconfig": metadata.def_config,
+		"build_environment": metadata.build_dir,
 		"lab_name": None,
 		"kernel": None,
 		"job": None,
 		"git_branch": "kselftest",
 	}
-	return test_group
 
-def get_json_result(test: Test, def_config: str, build_dir: str) -> str:
-	test_group = _get_group_json(test, def_config, build_dir)
+	test_group = _get_group_json(test, common_fields)
 	test_group["name"] = "KUnit Test Group"
 	return json.dumps(test_group, indent=4)
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index a3c036a620b2..60806994683c 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -468,8 +468,7 @@ class KUnitJsonTest(unittest.TestCase):
 			test_result = kunit_parser.parse_run_tests(file)
 			json_obj = kunit_json.get_json_result(
 				test=test_result,
-				def_config='kunit_defconfig',
-				build_dir='.kunit')
+				metadata=kunit_json.Metadata())
 		return json.loads(json_obj)
 
 	def test_failed_test_json(self):
@@ -691,7 +690,7 @@ class KUnitMainTest(unittest.TestCase):
 		self.linux_source_mock.run_kernel.return_value = ['TAP version 14', 'init: random output'] + want
 
 		got = kunit._list_tests(self.linux_source_mock,
-				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'suite'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*', None, 'suite'))
 
 		self.assertEqual(got, want)
 		# Should respect the user's filter glob when listing tests.
@@ -706,7 +705,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*.test*', None, 'suite'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*.test*', None, 'suite'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test*', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite2.test*', timeout=300),
@@ -719,7 +718,7 @@ class KUnitMainTest(unittest.TestCase):
 
 		# Should respect the user's filter glob when listing tests.
 		mock_tests.assert_called_once_with(mock.ANY,
-				     kunit.KunitExecRequest(None, '.kunit', None, 300, False, 'suite*', None, 'test'))
+				     kunit.KunitExecRequest(None, None, '.kunit', 300, False, 'suite*', None, 'test'))
 		self.linux_source_mock.run_kernel.assert_has_calls([
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test1', timeout=300),
 			mock.call(args=None, build_dir='.kunit', filter_glob='suite.test2', timeout=300),
-- 
2.35.1.574.g5d30c73bfb-goog

