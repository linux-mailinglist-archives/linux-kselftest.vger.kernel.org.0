Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A075243DB5E
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Oct 2021 08:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbhJ1God (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Oct 2021 02:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhJ1God (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Oct 2021 02:44:33 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F5FC061745
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 23:42:06 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id a20-20020a25ae14000000b005c1961310aeso7443339ybj.3
        for <linux-kselftest@vger.kernel.org>; Wed, 27 Oct 2021 23:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=6u+AjwrYCRzNV1ppQBIxebat3yD3SQvtae0skIY3lNo=;
        b=OQdX7s0MYsZvg2MVoinhzq/An17UK9xk4F1ShkS1X7AJIoR0kk77d82PZMHFAjJwe/
         1Z9Fvz0JJ4ZreAjUvJq95p9DPqPVrbNT8+B/Hd1XFG5L9dDc6hgPcGWAzfuQL/IXELUY
         BJE+AMEWFL9FOSFBP3abGM0OFwv5v+/lgKdQKvw0esnECGg3egjazNBmYhpsF7RcBnIt
         xUvrK8YMCoCn4yJPuD3qMLEHVFb3u/+Zl8T4dMy0Qte9JTS12OANKQxhU9ZY5CpaK8fF
         kJirAK2OW4V+m9x+4anTBq0Zb4ATV2YsBxjQwm0M1tKyW56HulxjPfNc8mJO3wWGPynS
         YCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=6u+AjwrYCRzNV1ppQBIxebat3yD3SQvtae0skIY3lNo=;
        b=qF9YFXjgxfRADvHsUNs64UMeqMRsXwW214E8Xs3l+r/XZ6frQB0c/BtF6O7LyDGq1y
         RnB0OweDvI9HXH2Z0htF/uqPZaFKAjGCe2gpxZU15V3DDWLpiCSoAsbUqZfYQ3vx+pq8
         zk17IpTBVa7/+eBd3dj58Xp2Dcm2odK674g4m6nydA/N3ZeHGcwm4yWsCQdABH8HRjHe
         KZm8RHOQPADwZSslDNPPwmvhecVUAomz04ovqxTYr4OQP0xMkZ35vOObpQjvuf0JKEON
         NhXlMQ2UdoCitZg6K6+DohZM82QafOsf23a621acl5reEansa+8kfqpIoKMjOo6L6kbm
         euOQ==
X-Gm-Message-State: AOAM5300YFVpVsZYu1LDzQ12iZyGnpjIUaUfliagfsxwNjAy2GObu/rb
        CMDWJYFwCNAKGFEDOy6xooFRicgwh2b5Mg==
X-Google-Smtp-Source: ABdhPJzpI+bgenpEZq6hGo6zkOJiZT9RdDaOIZ+imxux9xFbr9i7mMFrJlRCbW6YT+TUTg2ztqYxeDld8j3XjQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:d8b1:a4bf:2b6f:92f9])
 (user=davidgow job=sendgmr) by 2002:a25:344d:: with SMTP id
 b74mr2711522yba.317.1635403326178; Wed, 27 Oct 2021 23:42:06 -0700 (PDT)
Date:   Wed, 27 Oct 2021 23:41:51 -0700
Message-Id: <20211028064154.2301049-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v3 1/4] kunit: tool: Do not error on tests without test plans
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
2.33.0.1079.g6e70778dc9-goog

