Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F264D2D822A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 23:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406921AbgLKWdX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 17:33:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406954AbgLKWdU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 17:33:20 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 911D8C0613CF
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Dec 2020 14:32:40 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id q11so12595544ybm.21
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Dec 2020 14:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=EIHB+uodINauSQ/HRZMZjP79w222qFqt1odt9Kn0EeA=;
        b=kBEsvZPSXTy/bwTZCH9sqc/qjaNjuJFEnZKMdDARAYR+AkHMWHQCp2nZA4tmAcbuDe
         Bkp0hf1v8S8KNXwXUbr4jop2W04ZzEDcVdHQ3SPU7BrTfhqxf0BB60Cm8S8x0OIJVIzi
         ZCk+8a3EXXXRYno9fd2DlBNrf9iQuXXaFykSRiJD5+NyludQWG+f+gTr6+KrYJhPql1s
         1n3NMzbPeWIUKoT3oWT+XkHrAnAnNVW6yWzmgzTW8ggY9N5QN+JHmZaHyA2NUvmB9KZy
         /3uUjJKA5H0DVHnIfl3W7nXv3wnZ/nxTILbUJ7D2UvoT6OXPQSLzTFn+hNtRd+Qzr63N
         dSSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=EIHB+uodINauSQ/HRZMZjP79w222qFqt1odt9Kn0EeA=;
        b=EpB6k06qc1+MjfA8NWpYi7CJzG4hmwCAZ0kaaJmfMz6wBrj2/3A3SHuHJuA6kDv5mM
         3iH+xogosTnvc0MFBF+gMae7nTbro+IFBG9ISwtJGQDdCkGYWpbsu2X+MW3lu7K4uFhn
         zsC3ONrHhDD1kreFJT2/mBw9PTYyzn93uRUtQ4e064vS63K0ZD4l6nwIrbSzK4NjAdS8
         ASPwMpbxgGzURu1vlalk7q9Q9GKJBygYl4LsTnlSrdrWiIEyxKnMgTqEEP3NJhInEDwL
         40oCreTFwm2xCfCZ8S7/Op7TlvuLwDnAvXnqWXSwYcjjpFE8Ajjo+w/HE32DdT+02UOV
         khjg==
X-Gm-Message-State: AOAM532S4Jp+uNDFRQ9lIAEXMlJ8p7hgPTG/SsFg6bRR/yjaVtnderRG
        HjaVL0U7bg0RA89x0N6/TTsa0bdwHdvPdQ==
X-Google-Smtp-Source: ABdhPJyAqNJ9NMXtkjBJlscyDSkug86/wdhzgRgZrnHVThKlGW6lZLbdikkHDiSLUrzB9fMpPrL0nc2HGNqEVg==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a25:8283:: with SMTP id
 r3mr21992356ybk.66.1607725959837; Fri, 11 Dec 2020 14:32:39 -0800 (PST)
Date:   Fri, 11 Dec 2020 14:32:32 -0800
Message-Id: <20201211223232.697679-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] kunit: tool: Fix spelling of "diagnostic" in kunit_parser
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Various helper functions were misspelling "diagnostic" in their names.
It finally got annoying, so fix it.

Signed-off-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 6614ec4d0898..1a1e1d13f1d3 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -97,11 +97,11 @@ def print_log(log):
 
 TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
 
-def consume_non_diagnositic(lines: List[str]) -> None:
+def consume_non_diagnostic(lines: List[str]) -> None:
 	while lines and not TAP_ENTRIES.match(lines[0]):
 		lines.pop(0)
 
-def save_non_diagnositic(lines: List[str], test_case: TestCase) -> None:
+def save_non_diagnostic(lines: List[str], test_case: TestCase) -> None:
 	while lines and not TAP_ENTRIES.match(lines[0]):
 		test_case.log.append(lines[0])
 		lines.pop(0)
@@ -113,7 +113,7 @@ OK_NOT_OK_SUBTEST = re.compile(r'^[\s]+(ok|not ok) [0-9]+ - (.*)$')
 OK_NOT_OK_MODULE = re.compile(r'^(ok|not ok) ([0-9]+) - (.*)$')
 
 def parse_ok_not_ok_test_case(lines: List[str], test_case: TestCase) -> bool:
-	save_non_diagnositic(lines, test_case)
+	save_non_diagnostic(lines, test_case)
 	if not lines:
 		test_case.status = TestStatus.TEST_CRASHED
 		return True
@@ -139,7 +139,7 @@ SUBTEST_DIAGNOSTIC = re.compile(r'^[\s]+# (.*)$')
 DIAGNOSTIC_CRASH_MESSAGE = re.compile(r'^[\s]+# .*?: kunit test case crashed!$')
 
 def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
-	save_non_diagnositic(lines, test_case)
+	save_non_diagnostic(lines, test_case)
 	if not lines:
 		return False
 	line = lines[0]
@@ -155,7 +155,7 @@ def parse_diagnostic(lines: List[str], test_case: TestCase) -> bool:
 
 def parse_test_case(lines: List[str]) -> Optional[TestCase]:
 	test_case = TestCase()
-	save_non_diagnositic(lines, test_case)
+	save_non_diagnostic(lines, test_case)
 	while parse_diagnostic(lines, test_case):
 		pass
 	if parse_ok_not_ok_test_case(lines, test_case):
@@ -166,7 +166,7 @@ def parse_test_case(lines: List[str]) -> Optional[TestCase]:
 SUBTEST_HEADER = re.compile(r'^[\s]+# Subtest: (.*)$')
 
 def parse_subtest_header(lines: List[str]) -> Optional[str]:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	if not lines:
 		return None
 	match = SUBTEST_HEADER.match(lines[0])
@@ -179,7 +179,7 @@ def parse_subtest_header(lines: List[str]) -> Optional[str]:
 SUBTEST_PLAN = re.compile(r'[\s]+[0-9]+\.\.([0-9]+)')
 
 def parse_subtest_plan(lines: List[str]) -> Optional[int]:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	match = SUBTEST_PLAN.match(lines[0])
 	if match:
 		lines.pop(0)
@@ -202,7 +202,7 @@ def max_status(left: TestStatus, right: TestStatus) -> TestStatus:
 def parse_ok_not_ok_test_suite(lines: List[str],
 			       test_suite: TestSuite,
 			       expected_suite_index: int) -> bool:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	if not lines:
 		test_suite.status = TestStatus.TEST_CRASHED
 		return False
@@ -235,7 +235,7 @@ def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
 def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
 	if not lines:
 		return None
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	test_suite = TestSuite()
 	test_suite.status = TestStatus.SUCCESS
 	name = parse_subtest_header(lines)
@@ -264,7 +264,7 @@ def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[Te
 TAP_HEADER = re.compile(r'^TAP version 14$')
 
 def parse_tap_header(lines: List[str]) -> bool:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	if TAP_HEADER.match(lines[0]):
 		lines.pop(0)
 		return True
@@ -274,7 +274,7 @@ def parse_tap_header(lines: List[str]) -> bool:
 TEST_PLAN = re.compile(r'[0-9]+\.\.([0-9]+)')
 
 def parse_test_plan(lines: List[str]) -> Optional[int]:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	match = TEST_PLAN.match(lines[0])
 	if match:
 		lines.pop(0)
@@ -286,7 +286,7 @@ def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
 	return bubble_up_errors(lambda x: x.status, test_suite_list)
 
 def parse_test_result(lines: List[str]) -> TestResult:
-	consume_non_diagnositic(lines)
+	consume_non_diagnostic(lines)
 	if not lines or not parse_tap_header(lines):
 		return TestResult(TestStatus.NO_TESTS, [], lines)
 	expected_test_suite_num = parse_test_plan(lines)

base-commit: 5f6b99d0287de2c2d0b5e7abcb0092d553ad804a
-- 
2.29.2.576.ga3fc446d84-goog

