Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECFDC435ADB
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 08:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbhJUGau (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 02:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhJUGan (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 02:30:43 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B8EC061749
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 23:28:27 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id bz13-20020ad44c0d000000b0038379dd89e5so4914192qvb.20
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Oct 2021 23:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=O4M/tQHIU9ygzYdcq00Cuq5xDfJVENaFvMJsaxgv1Uk=;
        b=e0ZPev5S1yXkp8gSTDcCadahubPewHibI57BZUd/3J1ij+TLIxPmeJPN+RytbEhNHK
         YHymvVDt1vDGGQ20g4qMcadvcFgnu8g8fAaTOLhGjhelLaJos4Uv1WwR+4Sepy42UeYf
         DxX3dNvqQrIZxINaorN98+gqKL0CJBR6GZKztxy2mM54aILe67YT7DrHzetzIgWE+ehH
         3hjs8uVS5bSEFOgrROcl/IblOCmhmVFeIWAlKWtr98vw2HNkXYWEWPBgAR1HGAgJXhiO
         CLUFqum6redfCy5V4zZiDnQXYNK6uflGKXmdmXfWvoSLI+ViXlQ3t2QpOHEvLGUHM11E
         9xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=O4M/tQHIU9ygzYdcq00Cuq5xDfJVENaFvMJsaxgv1Uk=;
        b=xLsyhW9ofWZb5X5IpRrdMLKz3MzXW985RyjV1txG8QhNIfzw8taLA3c+Jc/KucUY4E
         kucDO7xYeBH8Vg4/JcBMZu4q8ZJCe2uOZa2aOXnOZS3TcigQhYSw7BGhR8h9nbVlbHcz
         24GxvdCCnHZFh11lWJrQEj2FLMV4ZbvdNDUZ1cZUM0UkZ205TGUc77RVspP3SKOzmJj2
         Rl5BEf9wiXvULvEc4bq8EMPGSMZuaEzUhE716owayaXdkt38/7QUftfaVrt2DUS2SIu1
         WUeKPuuFdnPznI/nt8AlM0CrXRgsLTVRdwMtNR/jbFKXbjc8PyIuE6A6weo1TUp+QxNg
         TrZQ==
X-Gm-Message-State: AOAM532BcVmj+NFMJyg4ft1XCLYl9DOH23yONF6c+yssE+0G+DRzdKYs
        Kgjs7YGSPwUZPzwh756LYyD2OJL28txQiQ==
X-Google-Smtp-Source: ABdhPJwvmWlCmJSn4btqHbjJgkZRWvCuCYw3JeKmYvFU1OXfg88WhZZHfLBNOvmq4uVoco5eh9qYbyffJhOvcw==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:1200:8c8:2819:6ab9])
 (user=davidgow job=sendgmr) by 2002:a05:622a:1195:: with SMTP id
 m21mr4023056qtk.96.1634797706584; Wed, 20 Oct 2021 23:28:26 -0700 (PDT)
Date:   Wed, 20 Oct 2021 23:28:18 -0700
Message-Id: <20211021062819.1313964-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH 1/2] kunit: tool: Do not error on tests without test plans
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
---
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

