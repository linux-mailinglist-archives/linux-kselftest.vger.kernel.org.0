Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72B9D2F6F9C
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Jan 2021 01:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731395AbhAOAkI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 14 Jan 2021 19:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731364AbhAOAkG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 14 Jan 2021 19:40:06 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5521DC0613C1
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:39:26 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id j1so3598214ybj.11
        for <linux-kselftest@vger.kernel.org>; Thu, 14 Jan 2021 16:39:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=aABCcgWcudlDKbXOL3XsmbyaRQXHrx3QfYiq3YgoW1c=;
        b=rI3vpzgGa0MgEb+EkJ0uo/3gzNbgy7zWGq/inNxUc0UkOfAjyJcm6cA1uuvJSD/hPE
         o67JjOvbZAxST0Cl/eM3uCjcHUwTAP6zLSg5RY2k1Ah62t2Sv7XyVDhyCBEtPcSS8DCe
         CeWPSXMLG0gwM6wHjwtns36/JzgRwxs++DBXa/435a0umMpM3WAdfLhGGJT5stFdRmaE
         3M37SEoeDUR6N3+wTVTSM/5yYPvZAZaUJf1FlsVKQejJNEnv47sIRpWOd7klNqeNpRAD
         mHBgM4VkdaVp+c5jvPlV3zVCfuv+clG0Q8Owsime17rZ0ncb6VRXvmixXF539RW8lBES
         WG2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aABCcgWcudlDKbXOL3XsmbyaRQXHrx3QfYiq3YgoW1c=;
        b=Zjje1GelXMgeN5x68X8+5h3ICGVgusIUEFeX4Xo56UYWWPvVA1atQwWRiS5zxZ6Cyf
         J4js/op3iOaGiFdZU9Zq6Wv9yL7fU+KMOvRfYK0B0gIvzDVHkfUICkDg/44aAGxAkZUC
         3k+cQEJwa4R9z5HIMGmCZ8DZt/yG/2LBxtlfKIsWKine5gx2Sb8w4vqw17D5MDgnGfn5
         AJVNPtVWhXLwELRjW3bAHigzaccvYY0f640m/bBxWgN0BJYdCOflNPmdk72kioc7oI2u
         F1WiwhnMf6FVdAJ2ilegqVytD1Sk3lE/A2sRCk50zjtexyzrDFdlg4ju8PFPBNnPcSuX
         5Ruw==
X-Gm-Message-State: AOAM531uZuBKswbVdsf8tlgNbwR1onTdDKvCnppomZVQVZmXFfKKBKUo
        CJYpO7B3dwTfSBH5yNDozW7n+/X+0WyTLQ==
X-Google-Smtp-Source: ABdhPJzHQnP1kssSSFKTiM+U7ncl7HzouLA6nmaX+iihGnMCfjtqcUYOaoJESlO6PL/RT7IKP0bKLK3CvunNtQ==
Sender: "dlatypov via sendgmr" <dlatypov@dlatypov.svl.corp.google.com>
X-Received: from dlatypov.svl.corp.google.com ([2620:15c:2cd:202:a28c:fdff:fee3:28c6])
 (user=dlatypov job=sendgmr) by 2002:a25:d3c4:: with SMTP id
 e187mr15313845ybf.259.1610671165543; Thu, 14 Jan 2021 16:39:25 -0800 (PST)
Date:   Thu, 14 Jan 2021 16:39:12 -0800
In-Reply-To: <20210115003913.1406896-1-dlatypov@google.com>
Message-Id: <20210115003913.1406896-2-dlatypov@google.com>
Mime-Version: 1.0
References: <20210115003913.1406896-1-dlatypov@google.com>
X-Mailer: git-send-email 2.30.0.296.g2bfb1c46d8-goog
Subject: [PATCH v4 2/3] kunit: tool: fix minor typing issue with None status
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org,
        Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The code to handle aggregating statuses didn't check that the status
actually got set to some non-None value.
Default the value to SUCCESS instead of adding a bunch of `is None`
checks.

This sorta follows the precedent in commit 3fc48259d525 ("kunit: Don't
fail test suites if one of them is empty").

Also slightly simplify the code and add type annotations.

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
 tools/testing/kunit/kunit_parser.py | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 8b5eb9507765..2e4cb5206fa7 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -12,13 +12,13 @@ from collections import namedtuple
 from datetime import datetime
 from enum import Enum, auto
 from functools import reduce
-from typing import Iterator, List, Optional, Tuple
+from typing import Iterable, Iterator, List, Optional, Tuple
 
 TestResult = namedtuple('TestResult', ['status','suites','log'])
 
 class TestSuite(object):
 	def __init__(self) -> None:
-		self.status = None  # type: Optional[TestStatus]
+		self.status = TestStatus.SUCCESS
 		self.name = ''
 		self.cases = []  # type: List[TestCase]
 
@@ -30,7 +30,7 @@ class TestSuite(object):
 
 class TestCase(object):
 	def __init__(self) -> None:
-		self.status = None  # type: Optional[TestStatus]
+		self.status = TestStatus.SUCCESS
 		self.name = ''
 		self.log = []  # type: List[str]
 
@@ -224,12 +224,11 @@ def parse_ok_not_ok_test_suite(lines: List[str],
 	else:
 		return False
 
-def bubble_up_errors(to_status, status_container_list) -> TestStatus:
-	status_list = map(to_status, status_container_list)
-	return reduce(max_status, status_list, TestStatus.SUCCESS)
+def bubble_up_errors(statuses: Iterable[TestStatus]) -> TestStatus:
+	return reduce(max_status, statuses, TestStatus.SUCCESS)
 
 def bubble_up_test_case_errors(test_suite: TestSuite) -> TestStatus:
-	max_test_case_status = bubble_up_errors(lambda x: x.status, test_suite.cases)
+	max_test_case_status = bubble_up_errors(x.status for x in test_suite.cases)
 	return max_status(max_test_case_status, test_suite.status)
 
 def parse_test_suite(lines: List[str], expected_suite_index: int) -> Optional[TestSuite]:
@@ -282,8 +281,8 @@ def parse_test_plan(lines: List[str]) -> Optional[int]:
 	else:
 		return None
 
-def bubble_up_suite_errors(test_suite_list: List[TestSuite]) -> TestStatus:
-	return bubble_up_errors(lambda x: x.status, test_suite_list)
+def bubble_up_suite_errors(test_suites: Iterable[TestSuite]) -> TestStatus:
+	return bubble_up_errors(x.status for x in test_suites)
 
 def parse_test_result(lines: List[str]) -> TestResult:
 	consume_non_diagnositic(lines)
-- 
2.30.0.296.g2bfb1c46d8-goog

