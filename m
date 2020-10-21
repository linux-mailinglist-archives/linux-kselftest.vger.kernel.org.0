Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A9E2954A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Oct 2020 00:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505705AbgJUWIi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Oct 2020 18:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506566AbgJUWIh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Oct 2020 18:08:37 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CE6C0613CE
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 15:08:36 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w126so2696901qka.5
        for <linux-kselftest@vger.kernel.org>; Wed, 21 Oct 2020 15:08:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=56A4/uXKp2ANLOenIvW/0T3oiOKTm1VKFJfUcaUWi9M=;
        b=FMVT3FHn4J20UdJyjTP6MFLRhQnzgJp5ouP7VVWZjiYmkY+80Nqn8yXK66p2cVR/97
         yAXFyeasyq1mnAzbhMrRd5t652PIjYngeuq8VOB3VdRHPHzbfUQ3Oc0P55bPa8J7Z91D
         W+P1/msf16vZu9Ksbuhy7E4xBe1FlLNzDzD/fIn9Lxl9jZYmFrQ7uOGoTRRAh8emiIeC
         g85Zlbp/O5TBMsltGjs4nSNLixxF/5Q1bdHy+/F3hm0J9+LfaayHZwXXVt9YrMrJvAGz
         rfKcV1iP06DSFENI7KzmVvth5idobbP+VIFyZbZqnwWeq7+b0vr9EGRNqgH5qw0LbIrn
         WyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=56A4/uXKp2ANLOenIvW/0T3oiOKTm1VKFJfUcaUWi9M=;
        b=H2DHD8O6GCwp/2B8cd4sUY1D9sTtFnhjlLcQ3s5Us6Eivl+UTEtdfmQHE7CYO31/zX
         2mxr5TOzrYyWEkDH3pHxKCe7n3RSbzxNcdtyIE1YaPwaqt0oUmgq1L9Roa1TmKyO+SKJ
         IeN4L+wZPF/zWLQREn7MMwkgdWjU6F3GvnOKqnGBMFMz+Md6UeXBL1sFkzQYsR1C3NIp
         cjqtch64+VSqLZcbrDoWJnRym+0moApcZfm5ZnIDF2clqLkHTnVzM5nNZBeooVHsnhmR
         WkIEPWv7SqS5mLWowKVBFF4R2pb3jidkSuGH/oBOmBOjJofSD4rXTMCdZxdxk3mX3VhB
         TwtA==
X-Gm-Message-State: AOAM532FA60si+M+EU581/+LmNUXimlfy6ITxqNCZmEMqxwNzd1IYWcY
        OiOyUCHJMFuM9kk2CeBfWxCrFte7A0qE2w==
X-Google-Smtp-Source: ABdhPJxYLkfjuAGVW5ShixgfveXCts2WCoTlefH4kZnCexwFOh7oM1J9fOe2fbJnH0WvCROnSAITx7JI1FWzmg==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a0c:fd4c:: with SMTP id
 j12mr4973308qvs.22.1603318115082; Wed, 21 Oct 2020 15:08:35 -0700 (PDT)
Date:   Wed, 21 Oct 2020 15:07:52 -0700
Message-Id: <20201021220752.418832-1-dlatypov@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
Subject: [PATCH] kunit: tool: fix pre-existing python type annotation errors
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The code uses annotations, but they aren't accurate.
Note that type checking in python is a separate process, running
`kunit.py run` will not check and complain about invalid types at
runtime.

Fix pre-existing issues found by running a type checker
$ mypy *.py

All but one of these were returning `None` without denoting this
properly (via `Optional[Type]`).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
---
 tools/testing/kunit/kunit_parser.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8019e3dd4c32..d3bc0f197682 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,7 +12,7 @@ from collections import namedtuple
 from datetime import datetime
 from enum import Enum, auto
 from functools import reduce
-from typing import List
+from typing import List, Optional, Tuple
 
 TestResult = namedtuple('TestResult', ['status','suites','log'])
 
@@ -152,7 +152,7 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 	else:
 		return False
 
-def parse_test_case(lines: List[str]) -> TestCase:
+def parse_test_case(lines: List[str]) -> Optional[TestCase]:
 	test_case = TestCase()
 	save_non_diagnositic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
@@ -164,7 +164,7 @@ def parse_test_case(lines: List[str]) -> TestCase:
 
 SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
 
-def parse_subtest_header(lines: List[str]) -> str:
+def parse_subtest_header(lines: List[str]) -> Optional[str]:
 	consume_non_diagnositic(lines)
 	if not lines:
 		return None
@@ -177,7 +177,7 @@ def parse_subtest_header(lines: List[str]) -> str:
 
 SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
-def parse_subtest_plan(lines: List[str]) -> int:
+def parse_subtest_plan(lines: List[str]) -> Optional[int]:
 	consume_non_diagnositic(lines)
 	match = SUBTEST_PLAN.match(lines[0])
 	if match:
@@ -231,7 +231,7 @@ def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
-def parse_test_suite(lines: List[str], expected_suite_index: int) -> TestSuite:
+def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
 	if not lines:
 		return None
 	consume_non_diagnositic(lines)
@@ -272,7 +272,7 @@ def parse_tap_header(lines: List[str]) -> bool:
 
 TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
 
-def parse_test_plan(lines: List[str]) -> int:
+def parse_test_plan(lines: List[str]) -> Optional[int]:
 	consume_non_diagnositic(lines)
 	match = TEST_PLAN.match(lines[0])
 	if match:
@@ -311,7 +311,7 @@ def parse_test_result(lines: List[str]) -> TestResult:
 	else:
 		return TestResult(TestStatus.NO_TESTS, [], lines)
 
-def print_and_count_results(test_result: TestResult) -> None:
+def print_and_count_results(test_result: TestResult) -> Tuple[int, int, int]:
 	total_tests = 0
 	failed_tests = 0
 	crashed_tests = 0

base-commit: c4d6fe7311762f2e03b3c27ad38df7c40c80cc93
-- 
2.29.0.rc1.297.gfa9743e501-goog

