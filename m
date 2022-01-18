Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B135B492E28
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jan 2022 20:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348648AbiARTJf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jan 2022 14:09:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348391AbiARTJb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jan 2022 14:09:31 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4735C061574
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 11:09:30 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id b61-20020a25a243000000b006126ea65191so7821926ybi.19
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jan 2022 11:09:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Y+WNm4SRT+v0/a8Imp7LUvwXVPmkF4Imu0eAPnXyHIY=;
        b=ZZORa00GlA7CoqqZHJqUgUHTShPxXbCBwfNgu8zSTsbERei9c7ruuWMpi1znaJeEEB
         6BWxI2LQ6ChJswk93WjpKcBno2GG9Svvk1JysMxHyX78mjVuLNP7P0L3AXxc2l4wBgh9
         UgCLYWICx9RYPeiWwE9kDVQLjuSPMjczPBD8uOtnTcQkXa0XsLBD+AO7HJZj+ZjesdLc
         GHqTANmCBJEon4tL04fPHFFFRLpgvEogeuozSsudbWXLZrh9SBNwqAcqDPqnyGrmiymW
         VdRadFd0xZ5hETSF0aIEOHd/cyY2AtCH5klS30UGMXPrHt1edGdR1B5LKi1+gGtMQPhc
         lIQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Y+WNm4SRT+v0/a8Imp7LUvwXVPmkF4Imu0eAPnXyHIY=;
        b=M41deC9/Bf9l1v9Mwv9Ov4idzNg1PmzfaaspqHl6cbh/N0a4wt9w2aZuBEwMe1v6Xm
         1yndKZ0vqJel9UKo870eK+IlM92mtxQRIChc5tZE9uVAP+LF3ZYj4u2UVPX0DPYdOpvu
         AhFEhLAdMgp2FuyloCtwftvZ1rcXdtwlvNl7cxfijlzUeuBzQPAl4M9jGgYQR+E42iuH
         7OgcSg8gvSzaj0MqYGXjPhAO9u46QEWDon5GnpWO8Kf7CsyiYRXYKxs1mPHjHP7BtDCe
         1DL8uPt4RcOl52sj77sepw0ku/1nxgyoWwvcg1cqNZ/hoDPkZZxDm9k6GwEa+LkhlrUH
         JSHA==
X-Gm-Message-State: AOAM530A7dtCGJDPQ+6w6l91MfF+TRlKtHzd8wcKvUJjt6ofVWrjSfj2
        hgHFZ61Lkvl/aGY+87XXSMCyhELs1cvFYw==
X-Google-Smtp-Source: ABdhPJwn7PPo8uhx2nlkSGOZ6nAex2sT6ImnNbd1j3uwG2LGxKZwPd1nfjg7PDhR0L85WKrldqXWAKFuMBbS0g==
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:7fc9:5977:ab73:1d36])
 (user=dlatypov job=sendgmr) by 2002:a5b:590:: with SMTP id
 l16mr32787350ybp.629.1642532970016; Tue, 18 Jan 2022 11:09:30 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:09:18 -0800
Message-Id: <20220118190922.1557074-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH 1/5] kunit: tool: drop mostly unused KunitResult.result field
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This field is only used to pass along the parsed Test object from
parse_tests().
Everywhere else the `result` field is ignored.

Instead make parse_tests() explicitly return a KunitResult and Test so
we can retire the `result` field.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit.py | 24 ++++++++----------------
 1 file changed, 8 insertions(+), 16 deletions(-)

diff --git a/tools/testing/kunit/kunit.py b/tools/testing/kunit/kunit.py
index 7a706f96f68d..9274c6355809 100755
--- a/tools/testing/kunit/kunit.py
+++ b/tools/testing/kunit/kunit.py
@@ -17,7 +17,7 @@ assert sys.version_info >= (3, 7), "Python version is too old"
 
 from dataclasses import dataclass
 from enum import Enum, auto
-from typing import Any, Iterable, Sequence, List, Optional
+from typing import Iterable, List, Optional, Sequence, Tuple
 
 import kunit_json
 import kunit_kernel
@@ -32,7 +32,6 @@ class KunitStatus(Enum):
 @dataclass
 class KunitResult:
 	status: KunitStatus
-	result: Any
 	elapsed_time: float
 
 @dataclass
@@ -82,10 +81,8 @@ def config_tests(linux: kunit_kernel.LinuxSourceTree,
 	config_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.CONFIG_FAILURE,
-				   'could not configure kernel',
 				   config_end - config_start)
 	return KunitResult(KunitStatus.SUCCESS,
-			   'configured kernel successfully',
 			   config_end - config_start)
 
 def build_tests(linux: kunit_kernel.LinuxSourceTree,
@@ -100,14 +97,11 @@ def build_tests(linux: kunit_kernel.LinuxSourceTree,
 	build_end = time.time()
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
-				   'could not build kernel',
 				   build_end - build_start)
 	if not success:
 		return KunitResult(KunitStatus.BUILD_FAILURE,
-				   'could not build kernel',
 				   build_end - build_start)
 	return KunitResult(KunitStatus.SUCCESS,
-			   'built kernel successfully',
 			   build_end - build_start)
 
 def config_and_build_tests(linux: kunit_kernel.LinuxSourceTree,
@@ -173,14 +167,14 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 			filter_glob=filter_glob,
 			build_dir=request.build_dir)
 
-		result = parse_tests(request, run_result)
+		_, test_result = parse_tests(request, run_result)
 		# run_kernel() doesn't block on the kernel exiting.
 		# That only happens after we get the last line of output from `run_result`.
 		# So exec_time here actually contains parsing + execution time, which is fine.
 		test_end = time.time()
 		exec_time += test_end - test_start
 
-		test_counts.add_subtest_counts(result.result.counts)
+		test_counts.add_subtest_counts(test_result.counts)
 
 	if len(filter_globs) == 1 and test_counts.crashed > 0:
 		bd = request.build_dir
@@ -189,7 +183,7 @@ def exec_tests(linux: kunit_kernel.LinuxSourceTree, request: KunitExecRequest) -
 				bd, bd, kunit_kernel.get_outfile_path(bd), bd, sys.argv[0]))
 
 	kunit_status = _map_to_overall_status(test_counts.get_status())
-	return KunitResult(status=kunit_status, result=result, elapsed_time=exec_time)
+	return KunitResult(status=kunit_status, elapsed_time=exec_time)
 
 def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	if test_status in (kunit_parser.TestStatus.SUCCESS, kunit_parser.TestStatus.SKIPPED):
@@ -197,7 +191,7 @@ def _map_to_overall_status(test_status: kunit_parser.TestStatus) -> KunitStatus:
 	else:
 		return KunitStatus.TEST_FAILURE
 
-def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitResult:
+def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> Tuple[KunitResult, kunit_parser.Test]:
 	parse_start = time.time()
 
 	test_result = kunit_parser.Test()
@@ -231,11 +225,9 @@ def parse_tests(request: KunitParseRequest, input_data: Iterable[str]) -> KunitR
 			print(json_obj)
 
 	if test_result.status != kunit_parser.TestStatus.SUCCESS:
-		return KunitResult(KunitStatus.TEST_FAILURE, test_result,
-				   parse_end - parse_start)
+		return KunitResult(KunitStatus.TEST_FAILURE, parse_end - parse_start), test_result
 
-	return KunitResult(KunitStatus.SUCCESS, test_result,
-				parse_end - parse_start)
+	return KunitResult(KunitStatus.SUCCESS, parse_end - parse_start), test_result
 
 def run_tests(linux: kunit_kernel.LinuxSourceTree,
 	      request: KunitRequest) -> KunitResult:
@@ -513,7 +505,7 @@ def main(argv, linux=None):
 		request = KunitParseRequest(raw_output=cli_args.raw_output,
 					    build_dir='',
 					    json=cli_args.json)
-		result = parse_tests(request, kunit_output)
+		result, _ = parse_tests(request, kunit_output)
 		if result.status != KunitStatus.SUCCESS:
 			sys.exit(1)
 	else:

base-commit: f079ab01b5609fb0c9acc52c88168bf1eed82373
-- 
2.34.1.703.g22d0c6ccf7-goog

