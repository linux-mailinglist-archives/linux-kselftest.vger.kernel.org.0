Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716624BAB4C
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Feb 2022 21:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243450AbiBQUw4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Feb 2022 15:52:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiBQUwz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Feb 2022 15:52:55 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06A51606E5
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 12:52:39 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2d6b6cf0cafso12195017b3.21
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Feb 2022 12:52:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=KUuQWid3ijk52tNSFq74jJmo8zydjqK+JD0sfiPfJ1Q=;
        b=n+VMdXFP5Zicsyj3l46aT0/QIoOkIuqpbcIUnelVarJ/rP69T00oxy1Ltz3R7Q193E
         KSECuUrLgR8F6fxYHRhyzW/La70GqR95qOK11NL23DXJMOsJB1HYoqpk+hHeTq9qIyKW
         fExyHntZVT3v+K3UxkkyE5ITl5y/TRa/c9sz16MhVXzEbgBqJ/4L7ndcWu37nMMRFDpA
         J2npDxs/FkrTPlJ2GMuedNeDZuBHuYz0tEF9sQS6mwlUyP0D/Rt1Vlv6Ef/39pFg6t1U
         XP1CgbNIvdsUa95ZBu/jC6A+JO3tzBTSgqd6tjzQiQNL2zdFe4MIn5VToXzE8o8wMjzg
         1F3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=KUuQWid3ijk52tNSFq74jJmo8zydjqK+JD0sfiPfJ1Q=;
        b=qnLf/XuVm+fe8wPx4HHWcDsst/RmI5U8UDCwNznt3MLvqzFIe+d4POqOAXdWQA+NqN
         qHDs76EODaxQPfyYD7zYDdQHbILHtEizZTbCrI9m990Y6styhnaF8ttEiSyxFBc+czju
         xykWymtSuGR6JPG72TvqGTPBksZ0cOI0ev9q7DvnMCXkVD2xA5C3Ytoi2EjwIkoBMDvz
         7WbrLFrGQREAgqM33gORcDj5/mB9Nog8Q72NdNrnrF+xUIPNQN6Bd1C4dmGJwtFx+jrk
         JEQOL9A79UFDoDyr8LeskQQIwmXEL/V5ELyhx1C/jpmr9qb9q5SEEvM5tWuDw6nOgD3S
         vQ6A==
X-Gm-Message-State: AOAM531xjCT5YEFct5lufkQmPlBurwcwX7+c7+Trv9scBoPrN5tDgrac
        gAml/FealXVIO6eZAgJUasXkM4S3n1zJMg==
X-Google-Smtp-Source: ABdhPJwrQ922nuAr9X4NYm2igQKx5jkLbETSS3oOcIVWW4n60KtWBhVC3MlnAAGKacGqc8tuYJzzxVOBptRSVQ==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:1d37:446c:f8bc:463])
 (user=dlatypov job=sendgmr) by 2002:a25:da08:0:b0:623:f697:8e59 with SMTP id
 n8-20020a25da08000000b00623f6978e59mr4330393ybf.368.1645131159175; Thu, 17
 Feb 2022 12:52:39 -0800 (PST)
Date:   Thu, 17 Feb 2022 12:52:26 -0800
In-Reply-To: <20220217205227.4098452-1-dlatypov@google.com>
Message-Id: <20220217205227.4098452-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20220217205227.4098452-1-dlatypov@google.com>
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH 2/3] kunit: tool: refactor how we plumb metadata into JSON
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
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
2.35.1.473.g83b2b277ed-goog

