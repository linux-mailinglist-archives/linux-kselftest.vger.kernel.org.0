Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C763861868A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Nov 2022 18:48:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiKCRsj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Nov 2022 13:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231908AbiKCRsT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Nov 2022 13:48:19 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B21D30B
        for <linux-kselftest@vger.kernel.org>; Thu,  3 Nov 2022 10:47:48 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id n4-20020a17090a2fc400b002132adb9485so1266260pjm.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Nov 2022 10:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=x5UDPV/B3DbeeLLd5UNbXGu4AbVddR846UKz8icVwAg=;
        b=ARL1Z+nO3QvcQjmNyeaET5LfZwzcYuge5A11iFR6e70VYgXXlHx0UmBGpYP+zmGc6G
         q9yFicoNpr1w5MlK6VCq3mcp7j7kvFdNBKYDrty3rK5Hnaj+v+lSK8WQDBmnkhyRA1LW
         sg4hbNrm7x+kJUaUyva3scLdS7rV6Vs9Q18AYTOYF2p9NTo8oE9y8xjMECrv1eR9fHo7
         k4WAemX/5vei32E7ZnfyM+v2Kyatx8MOsT9Mxsk6Y+wbWIK+ItpVhSmafBOwCv4rrRV8
         U4qyVaL/hEuq5tQj3ALAv4vAopBQ/kq9AyRbPEijppOJ/N1Xc8x3Wj13MP9SOGCtFzu7
         Ztww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x5UDPV/B3DbeeLLd5UNbXGu4AbVddR846UKz8icVwAg=;
        b=Dg9f2JPyqNKgTj9QImEet4VG/+EGB8OSEhIZI4x02VebdcVpPBeGRA4JDP9h2hKzeR
         FU3QLruRcrxeJWWGKlSXysQQDD+StW3LJQv5WmVRfFLkG6te65UZ1Guki/ZcCwiPose8
         WfVcXm8LFVxJjpNu6po1pBW1MC6vfMwpSZwD5GRXOwMJMs6kpO/kMq1qcxwU4BBf923w
         +5Y2kgpV37CRIrU/TWKva/LmLlYs00ARqKoV26IINqarWUIL680rJ0HoKZjfe01q4LFw
         Sl4y2Fk8A5BkZmlB61o7S6YB5DRN75JUIWi3Xmp0mfw3qN5RDsc6bhbzEiqk96ZW3P/B
         9RGQ==
X-Gm-Message-State: ACrzQf0ust5HwGFMErsRV4IRfZNLvutvQHf3NJ/ArNfONBOv0jeCw6D2
        Wq4NXWscorbgly5Gn5JTc2xgedIuVpXUZg==
X-Google-Smtp-Source: AMsMyM4oTyeetb2fHUi/IMTtVZJbETiXu+iiifYy2OyaOkeY2IKWBmMNsJS3S8pcU87mpdisnUTHwNVbGpHEGw==
X-Received: from dlatypov-spec.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3f35])
 (user=dlatypov job=sendgmr) by 2002:a17:902:c949:b0:187:2be9:9f0a with SMTP
 id i9-20020a170902c94900b001872be99f0amr18975485pla.58.1667497668055; Thu, 03
 Nov 2022 10:47:48 -0700 (PDT)
Date:   Thu,  3 Nov 2022 10:47:38 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221103174740.3492603-1-dlatypov@google.com>
Subject: [PATCH v2 1/3] kunit: tool: make TestCounts a dataclass
From:   Daniel Latypov <dlatypov@google.com>
To:     brendanhiggins@google.com, davidgow@google.com
Cc:     rmoar@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org, Daniel Latypov <dlatypov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Since we're using Python 3.7+, we can use dataclasses to tersen the
code.

It also lets us create pre-populated TestCounts() objects and compare
them in our unit test. (Before, you could only create empty ones).

Signed-off-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: David Gow <davidgow@google.com>
---
v1 -> v2: just rebased onto linux-kselftest/kunit
---
 tools/testing/kunit/kunit_parser.py    | 25 ++++++++-----------------
 tools/testing/kunit/kunit_tool_test.py |  4 +---
 2 files changed, 9 insertions(+), 20 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 94dba66feec5..a56c75a973b5 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -10,6 +10,7 @@
 # Author: Rae Moar <rmoar@google.com>
 
 from __future__ import annotations
+from dataclasses import dataclass
 import re
 import sys
 
@@ -71,27 +72,17 @@ class TestStatus(Enum):
 	NO_TESTS = auto()
 	FAILURE_TO_PARSE_TESTS = auto()
 
+@dataclass
 class TestCounts:
 	"""
 	Tracks the counts of statuses of all test cases and any errors within
 	a Test.
-
-	Attributes:
-	passed : int - the number of tests that have passed
-	failed : int - the number of tests that have failed
-	crashed : int - the number of tests that have crashed
-	skipped : int - the number of tests that have skipped
-	errors : int - the number of errors in the test and subtests
-	"""
-	def __init__(self):
-		"""Creates TestCounts object with counts of all test
-		statuses and test errors set to 0.
-		"""
-		self.passed = 0
-		self.failed = 0
-		self.crashed = 0
-		self.skipped = 0
-		self.errors = 0
+	"""
+	passed: int = 0
+	failed: int = 0
+	crashed: int = 0
+	skipped: int = 0
+	errors: int = 0
 
 	def __str__(self) -> str:
 		"""Returns the string representation of a TestCounts object."""
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 7dcd67003b23..440a273f1d21 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -182,9 +182,7 @@ class KUnitParserTest(unittest.TestCase):
 				kunit_parser.extract_tap_lines(
 				file.readlines()))
 		# A missing test plan is not an error.
-		self.assertEqual(0, result.counts.errors)
-		# All tests should be accounted for.
-		self.assertEqual(10, result.counts.total())
+		self.assertEqual(result.counts, kunit_parser.TestCounts(passed=10, errors=0))
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)

base-commit: 29ad37f740d302d0f27374edaf85fe8978e45ba9
-- 
2.38.1.431.g37b22c650d-goog

