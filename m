Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0BF442863
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Nov 2021 08:30:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbhKBHc6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Nov 2021 03:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhKBHc5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Nov 2021 03:32:57 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D050C061714
        for <linux-kselftest@vger.kernel.org>; Tue,  2 Nov 2021 00:30:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id b126-20020a251b84000000b005bd8aca71a2so29690845ybb.4
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Nov 2021 00:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=4TO7cXb2F2AQHNi68Y4UhnFWgCfoNFbr4ZCVJOaX+38=;
        b=nZ3R7daK2ARwboBEruz7yT3XKV0fn1XsrbiTNK3t7N/+PR1LqhOx2l2vzgm/QxZFOA
         UGvGqtE0CkCFcPQ3ovL1mr7cSg4qkr8qzFJ0sitC8qcUXH8VBoPfV4riCZx8I5+JkDun
         Ll4fuLcak6f0hUgyi6SdeLmBlEFKfLqiaxILWxa+WMAU0IUttIJu3NM8lgJNMM49OzRG
         PcNmXf9pEGA4D8Vuo1wM8y3IiX9NKRuFr+RYdB6u5XDPtNaoRieRRcO4WivPAZVnCew6
         ytXbte7+bPj8wCgZ1iUGeSqoVzSHclKHgAMb35HMS91Qp5yfai4RCTFEUuutpCgqVWEq
         /L5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=4TO7cXb2F2AQHNi68Y4UhnFWgCfoNFbr4ZCVJOaX+38=;
        b=EMG6yLBzEOR5QivAlHUsZKnDi3LkYPX53uidqC3dCYFUygKcCQrpmNX0E6M6c4i5zE
         Z2T6iTEvG/Iw8usAnlz+s5HzgV8tfwryf7UV/RULDZ8e/WtQ+WH7V1RspGWGQHJLVjnp
         v2N+s8dSEA/0DD8RWRnKH5ZGF32lmnMiMng0ukVtkNVJZb9t7ChBaM6ue5k6p/30Brvo
         5hbAlCk0/n3JesL3Im+Bhcn2/wKqOFeM+jf34QSsj/+wRPbLCfTxMPLmf37S/Q37AXUx
         Wzdej2y8qS3c0fFpHcAzJDVoH3wCXVx8/5JQVEeXsKlTCH84t6U84F78QnudWPFrzIuw
         EcPQ==
X-Gm-Message-State: AOAM530lVEfkzlHbNKmhZyG2vgdeBRY8IhwmoRth3BwWTRDmsi3jzb8h
        mqjTxBv6YeRDKajKPDxph8ur4+GNEx2nhQ==
X-Google-Smtp-Source: ABdhPJzzxK4N0+3UkZIX7/cbA0bqfqlwPpFrAUKBBilFhl/vZtMMLFYCw0XJRQnNVClnwP4+DeohLLDs0Viw/Q==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:524f:74d8:b474:2517])
 (user=davidgow job=sendgmr) by 2002:a25:2649:: with SMTP id
 m70mr28997197ybm.21.1635838220057; Tue, 02 Nov 2021 00:30:20 -0700 (PDT)
Date:   Tue,  2 Nov 2021 00:30:11 -0700
Message-Id: <20211102073014.2901870-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.1.1089.g2158813163f-goog
Subject: [PATCH v4 1/4] kunit: tool: Do not error on tests without test plans
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The (K)TAP spec encourages test output to begin with a 'test plan': a
count of the number of tests being run of the form:
1..n

However, some test suites might not know the number of subtests in
advance (for example, KUnit's parameterised tests use a generator
function). In this case, it's not possible to print the test plan in
advance.

kunit_tool already parses test output which doesn't contain a plan, but
reports an error. Since we want to use nested subtests with KUnit
paramterised tests, remove this error.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

No changes since v3:
https://lore.kernel.org/linux-kselftest/20211028064154.2301049-1-davidgow@google.com/

Changes since v2:
https://lore.kernel.org/linux-kselftest/20211027013702.2039566-1-davidgow@google.com/
- No code changes.
- Added Daniel's Reviewed-by.


 tools/testing/kunit/kunit_parser.py    | 5 ++---
 tools/testing/kunit/kunit_tool_test.py | 5 ++++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 3355196d0515..50ded55c168c 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -340,8 +340,8 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	"""
 	Parses test plan line and stores the expected number of subtests in
 	test object. Reports an error if expected count is 0.
-	Returns False and reports missing test plan error if fails to parse
-	test plan.
+	Returns False and sets expected_count to None if there is no valid test
+	plan.
 
 	Accepted format:
 	- '1..[number of subtests]'
@@ -356,7 +356,6 @@ def parse_test_plan(lines: LineStream, test: Test) -> bool:
 	match = TEST_PLAN.match(lines.peek())
 	if not match:
 		test.expected_count = None
-		test.add_error('missing plan line!')
 		return False
 	test.log.append(lines.pop())
 	expected_count = int(match.group(1))
diff --git a/tools/testing/kunit/kunit_tool_test.py b/tools/testing/kunit/kunit_tool_test.py
index 9c4126731457..bc8793145713 100755
--- a/tools/testing/kunit/kunit_tool_test.py
+++ b/tools/testing/kunit/kunit_tool_test.py
@@ -191,7 +191,10 @@ class KUnitParserTest(unittest.TestCase):
 			result = kunit_parser.parse_run_tests(
 				kunit_parser.extract_tap_lines(
 				file.readlines()))
-		self.assertEqual(2, result.test.counts.errors)
+		# A missing test plan is not an error.
+		self.assertEqual(0, result.test.counts.errors)
+		# All tests should be accounted for.
+		self.assertEqual(10, result.test.counts.total())
 		self.assertEqual(
 			kunit_parser.TestStatus.SUCCESS,
 			result.status)
-- 
2.33.1.1089.g2158813163f-goog

