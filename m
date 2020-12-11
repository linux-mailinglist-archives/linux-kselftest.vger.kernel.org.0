Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 184CC2D70C9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Dec 2020 08:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391175AbgLKHYf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 11 Dec 2020 02:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390491AbgLKHYI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 11 Dec 2020 02:24:08 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC9EC0613CF
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 23:23:28 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id f3so5921485pgg.9
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Dec 2020 23:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=H8bMaqTtpRwBBTx6Q4pQzGIh8kzJB+AXUEJsxK1yWCw=;
        b=nZ3TQ57A6Cui7pvtozMKIRE9+2p7qxstRScb0KqA/qJfcc8lLDnApvRHAx/908N/ro
         1d4Y1PojKKYDWKvHcE7KJJof5NJHDKAYuPAkS/FhjZ93fI3tBOsDRJztS1rP5KLRhsM/
         8QgVk4wW4bKeicbPiqQ88FTn/fKf0GGNNDEYy1RVBbmKUA9Tg4/Qf6lghu4m/Gv89dmo
         pji1YOX/vjsCJBVmWHAxrR2uLVXvp5Qq0MtOYaM9Tzmin1ywin3YpSYykfrXU6nwqP99
         xPBfZlTEttDk5mu68AMLgZvn592IuDqpdSwaHKg/Qb9EyKxrJ4QIxDd/d497eHHF7wKM
         888A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=H8bMaqTtpRwBBTx6Q4pQzGIh8kzJB+AXUEJsxK1yWCw=;
        b=etIwTss3S2rzqNX2KUt2Ow++4bDyIyjGUvS1C3242KjOqO/2phk2Qkk0i+zxo7ZHdm
         hYHcq5AdtTDOKrn/w4ti06E+bTqwF5ytkFcEnJLdhF30NB9VXZmJGRKGM+YrgMbHTZ8R
         OCR1HLknhyQcV7HgKdwVN5ZAI/CsRwiw8pFzxTXsNEdi65CAuq6H63QjEi9XrUTfvHxz
         ILrVVNwSkY7zWUZ5N4qsCBytR6dvVmPYwzNC46MuooBDHOB24GH9jk7vMmy3u5AA75NK
         MsHgdvDF8oC7NPnXaFJDEWsGki3F5OIug1URu2u3kD4FRIbp9D3lO6TtLnnpIJsTQWVA
         V6bw==
X-Gm-Message-State: AOAM533yiQ+405vE3kChrZwVCFRf3LKqMITts2/zRyseEy7rX20PGJps
        iL6/gROk6tm8zl/TWxuR68xrb5MNfGj8OQ==
X-Google-Smtp-Source: ABdhPJwMgpTxJpuqXe5Vn5Jp5uibmSaqZUtSd/+xePT7tWpRS7oEdJvXfrDH4X6kl3hG3N5XOHw34kN/pYs2Dg==
Sender: "davidgow via sendgmr" <davidgow@spirogrip.svl.corp.google.com>
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:42a8:f0ff:fe4d:3548])
 (user=davidgow job=sendgmr) by 2002:a17:902:9f8b:b029:da:726d:3f17 with SMTP
 id g11-20020a1709029f8bb02900da726d3f17mr9732239plq.35.1607671407927; Thu, 10
 Dec 2020 23:23:27 -0800 (PST)
Date:   Thu, 10 Dec 2020 23:23:19 -0800
Message-Id: <20201211072319.533803-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
Subject: [PATCH] kunit: Print test statistics on failure
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Arpitha Raghunandan <98.arpi@gmail.com>,
        Daniel Latypov <dlatypov@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, David Gow <davidgow@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a number of tests fail, it can be useful to get higher-level
statistics of how many tests are failing (or how many parameters are
failing in parameterised tests), and in what cases or suites. This is
already done by some non-KUnit tests, so add support for automatically
generating these for KUnit tests.

This change adds a 'kunit_stats_enabled' switch which has three values:
- 0: No stats are printed (current behaviour)
- 1: Stats are printed only for tests/suites with more than one
     subtests, and at least one failure (new default)
- 2: Always print test statistics

For parameterised tests, the summary line looks as follows:
"    # inode_test_xtimestamp_decoding: 0 / 16 test parameters failed"
For test suites, it looks like this:
"# ext4_inode_test: (0 / 1) tests failed (0 / 16 test parameters)"

kunit_tool is also updated to correctly ignore diagnostic lines, so that
these statistics do not prevent the result from parsing.

Signed-off-by: David Gow <davidgow@google.com>
---

This is largely a follow-up to the discussion here:
 https://lore.kernel.org/linux-kselftest/CABVgOSmy4n_LGwDS7yWfoLftcQzxv6S+iXx9Y=OPcgG2gu0z1w@mail.gmail.com/T/#t

Does this seem like a sensible addition?

Cheers,
-- David

 lib/kunit/test.c                    | 71 +++++++++++++++++++++++++++++
 tools/testing/kunit/kunit_parser.py |  2 +-
 2 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index ec9494e914ef..711e269366a7 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -9,6 +9,7 @@
 #include <kunit/test.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/moduleparam.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -16,6 +17,40 @@
 #include "string-stream.h"
 #include "try-catch-impl.h"
 
+/*
+ * KUnit statistic mode:
+ * 0 - disabled
+ * 1 - only when there is at least one failure, and more than one subtest
+ * 2 - enabled
+ */
+static int kunit_stats_enabled = 1;
+core_param(kunit_stats_enabled, kunit_stats_enabled, int, 0644);
+
+static bool kunit_should_print_stats(int num_failures, int num_subtests)
+{
+	if (kunit_stats_enabled == 0)
+		return false;
+
+	if (kunit_stats_enabled == 2)
+		return true;
+
+	return (num_failures > 0 && num_subtests > 1);
+}
+
+static void kunit_print_test_stats(struct kunit *test,
+				   size_t num_failures, size_t num_subtests)
+{
+	if (!kunit_should_print_stats(num_failures, num_subtests))
+		return;
+
+	kunit_log(KERN_INFO, test,
+		  KUNIT_SUBTEST_INDENT
+		  "# %s: %lu / %lu test parameters failed",
+		  test->name,
+		  num_failures,
+		  num_subtests);
+}
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -346,15 +381,37 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 	test_case->success = test->success;
 }
 
+static void kunit_print_suite_stats(struct kunit_suite *suite,
+				    size_t num_failures,
+				    size_t total_param_failures,
+				    size_t total_params)
+{
+	size_t num_cases = kunit_suite_num_test_cases(suite);
+
+	if (!kunit_should_print_stats(num_failures, num_cases))
+		return;
+
+	kunit_log(KERN_INFO, suite,
+		  "# %s: (%lu / %lu) tests failed (%lu / %lu test parameters)",
+		  suite->name,
+		  num_failures,
+		  num_cases,
+		  total_param_failures,
+		  total_params);
+}
+
 int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
 	struct kunit_case *test_case;
+	size_t num_suite_failures = 0;
+	size_t total_param_failures = 0, total_params = 0;
 
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
+		size_t num_params = 0, num_failures = 0;
 		bool test_success = true;
 
 		if (test_case->generate_params) {
@@ -385,13 +442,27 @@ int kunit_run_tests(struct kunit_suite *suite)
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
 			}
+
+			if (!test.success)
+				num_failures++;
+			num_params++;
+
 		} while (test.param_value);
 
+		kunit_print_test_stats(&test, num_failures, num_params);
+
 		kunit_print_ok_not_ok(&test, true, test_success,
 				      kunit_test_case_num(suite, test_case),
 				      test_case->name);
+
+		if (!test_success)
+			num_suite_failures++;
+		total_params += num_params;
+		total_param_failures += num_failures;
 	}
 
+	kunit_print_suite_stats(suite, num_suite_failures,
+				total_param_failures, total_params);
 	kunit_print_subtest_end(suite);
 
 	return 0;
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index 6614ec4d0898..88ee2b2668ad 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -95,7 +95,7 @@ def print_log(log):
 	for m in log:
 		print_with_timestamp(m)
 
-TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
+TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*# Subtest:).*$')
 
 def consume_non_diagnositic(lines: List[str]) -> None:
 	while lines and not TAP_ENTRIES.match(lines[0]):

base-commit: 5f6b99d0287de2c2d0b5e7abcb0092d553ad804a
-- 
2.29.2.576.ga3fc446d84-goog

