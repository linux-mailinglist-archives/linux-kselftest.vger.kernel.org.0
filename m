Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4743DFAE9
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Aug 2021 07:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231699AbhHDFIi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Aug 2021 01:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbhHDFIh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Aug 2021 01:08:37 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEDFC0613D5
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Aug 2021 22:08:25 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id y10-20020a0cd98a0000b029032ca50bbea1so981900qvj.12
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Aug 2021 22:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=US53yUumKIui9w1wi7h47KWAiBIOlXWNaoToSkpc1pg=;
        b=UfoVVUuES1P/lVZ9QL0hAzNDEYLDv8AIgZlWDbZCkThBbyrA0vWA7P+KJC2qcfBeab
         hiJl6q2F0Za/8aWdXRVZHy2geMriNgg9zlBpg171+aVykSMALiUxNPREoINyV9f4NIMb
         ujazt3kw344RDxLykZC6uOJUae5Vclh+crRcuCMF5YcSY1C/200iPw+rHn0oxV8pD3T9
         Qr9nRFOdeYwWex0EuVtZ65gFiva3xViD78jd3m75/+s/CO/xN94pIEX2l+zb+l4jpY9m
         7pPkpF75idk3DdBY6IQVDPPZ5yVrlJo2oHXRfmf/cVNL8qlbmLKbqkJkJCxmYv8nPmQv
         pIyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=US53yUumKIui9w1wi7h47KWAiBIOlXWNaoToSkpc1pg=;
        b=aLtaV4BMdy5x7Kxhuaoz1nIwDIQtGOQkNlgtYeqXC/9QgK+ph2Iie19uRCna0HhUtr
         ySzhev4cxBz+aqOhCKnoK6DVVU8a/G99rx3S3Fzo6mYPfyWFj4EKi41nh5IwVrb4BS6d
         kHyRd3/yKUOAJhShh/ATz65d2hTG2HTqGW8YWDIaauwRhfII6icGvVi7nDgJN8fpqOMz
         C7iFVtPMW1Ami2CVghrIhOs6XFPxhpi6ZdrYwxAKxqjRzq7yugAKtxoYqZNnawvcHLXi
         Whma5D7gLz73idyVS6sIEgEm0+lAHOAnMYB6q1TbUYkIEvO2APfjWSDRN/IrQFnyMTj3
         19WA==
X-Gm-Message-State: AOAM530PnX3ygIHU13xNYlaqOQxB+p5cyR574XOse9xVgFj0xNKNjcoM
        fPO01eBktR9+lhj11PIxPj6iSXGG7v8eYQ==
X-Google-Smtp-Source: ABdhPJwMf8PjpVbnV9c7rr8gDqcZbCB5yISn0C/o6Xq+r0xAaOQypE4amrtrxDVMZxvmVAsgy1+0J6be7po2JQ==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:f5f1:74e0:8689:e610])
 (user=davidgow job=sendgmr) by 2002:a05:6214:2428:: with SMTP id
 gy8mr25480478qvb.49.1628053704859; Tue, 03 Aug 2021 22:08:24 -0700 (PDT)
Date:   Tue,  3 Aug 2021 22:08:08 -0700
Message-Id: <20210804050809.628266-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [PATCH v2] kunit: Print test statistics on failure
From:   David Gow <davidgow@google.com>
To:     Brendan Higgins <brendanhiggins@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        Rae Moar <rmoar@google.com>, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a number of tests fail, it can be useful to get higher-level
statistics of how many tests are failing (or how many parameters are
failing in parameterised tests), and in what cases or suites. This is
already done by some non-KUnit tests, so add support for automatically
generating these for KUnit tests.

This change adds a 'kunit.stats_enabled' switch which has three values:
- 0: No stats are printed (current behaviour)
- 1: Stats are printed only for tests/suites with more than one
     subtest (new default)
- 2: Always print test statistics

For parameterised tests, the summary line looks as follows:
"    # inode_test_xtimestamp_decoding: pass:16 fail:0 skip:0 total:16"
For test suites, there are two lines looking like this:
"# ext4_inode_test: pass:1 fail:0 skip:0 total:1"
"# Totals: pass:16 fail:0 skip:0 total:16"

The first line gives the number of direct subtests, the second "Totals"
line is the accumulated sum of all tests and test parameters.

This format is based on the one used by kselftest[1].

[1]: https://elixir.bootlin.com/linux/latest/source/tools/testing/selftests/kselftest.h#L109

Signed-off-by: David Gow <davidgow@google.com>
---

This is the long-awaited v2 of the test statistics patch:
https://lore.kernel.org/linux-kselftest/20201211072319.533803-1-davidgow@google.com/

It updates the patch to apply on current mainline kernels, takes skipped
tests into account, changes the output format to better match what
kselftest uses, and addresses some of the comments from v1.

Please let me know what you think, in particular:
- Is this sufficient to assuage any worries about porting tests to
  KUnit?
- Are we printing too many stats by default: for a lot of existing tests
  many of them are useless. I'm particuarly curious about the separate
  "Totals" line, versus the per-suite line -- is that useful? Should it
  only be printed when the totals differ?
- Is the output format sufficiently legible for people and/or tools
  which may want to parse it?

Cheers,
-- David

Changelog:

Changes since v1:
https://lore.kernel.org/linux-kselftest/20201211072319.533803-1-davidgow@google.com/
- Rework to use a new struct kunit_result_stats, with helper functions
  for adding results, accumulating them over nested structures, etc.
- Support skipped tests, report them separately from failures and
  passes.
- New output format to better match kselftest:
  - "pass:n fail:n skip:n total:n"
- Changes to stats_enabled parameter:
  - Now a module parameter, with description
  - Default "1" option now prints even when no tests fail.
- Improved parser fix which doesn't break crashed test detection.

---
 lib/kunit/test.c                    | 109 ++++++++++++++++++++++++++++
 tools/testing/kunit/kunit_parser.py |   2 +-
 2 files changed, 110 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d79ecb86ea57..f246b847024e 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -10,6 +10,7 @@
 #include <kunit/test-bug.h>
 #include <linux/kernel.h>
 #include <linux/kref.h>
+#include <linux/moduleparam.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
 
@@ -51,6 +52,51 @@ void __kunit_fail_current_test(const char *file, int line, const char *fmt, ...)
 EXPORT_SYMBOL_GPL(__kunit_fail_current_test);
 #endif
 
+/*
+ * KUnit statistic mode:
+ * 0 - disabled
+ * 1 - only when there is more than one subtest
+ * 2 - enabled
+ */
+static int kunit_stats_enabled = 1;
+module_param_named(stats_enabled, kunit_stats_enabled, int, 0644);
+MODULE_PARM_DESC(stats_enabled,
+		  "Print test stats: never (0), only for multiple subtests (1), or always (2)");
+
+struct kunit_result_stats {
+	unsigned long passed;
+	unsigned long skipped;
+	unsigned long failed;
+	unsigned long total;
+};
+
+static bool kunit_should_print_stats(struct kunit_result_stats stats)
+{
+	if (kunit_stats_enabled == 0)
+		return false;
+
+	if (kunit_stats_enabled == 2)
+		return true;
+
+	return (stats.total > 1);
+}
+
+static void kunit_print_test_stats(struct kunit *test,
+				   struct kunit_result_stats stats)
+{
+	if (!kunit_should_print_stats(stats))
+		return;
+
+	kunit_log(KERN_INFO, test,
+		  KUNIT_SUBTEST_INDENT
+		  "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
+		  test->name,
+		  stats.passed,
+		  stats.failed,
+		  stats.skipped,
+		  stats.total);
+}
+
 /*
  * Append formatted message to log, size of which is limited to
  * KUNIT_LOG_SIZE bytes (including null terminating byte).
@@ -393,15 +439,69 @@ static void kunit_run_case_catch_errors(struct kunit_suite *suite,
 		test_case->status = KUNIT_SUCCESS;
 }
 
+static void kunit_print_suite_stats(struct kunit_suite *suite,
+				    struct kunit_result_stats suite_stats,
+				    struct kunit_result_stats param_stats)
+{
+	if (kunit_should_print_stats(suite_stats)) {
+		kunit_log(KERN_INFO, suite,
+			  "# %s: pass:%lu fail:%lu skip:%lu total:%lu",
+			  suite->name,
+			  suite_stats.passed,
+			  suite_stats.failed,
+			  suite_stats.skipped,
+			  suite_stats.total);
+	}
+
+	if (kunit_should_print_stats(param_stats)) {
+		kunit_log(KERN_INFO, suite,
+			  "# Totals: pass:%lu fail:%lu skip:%lu total:%lu",
+			  param_stats.passed,
+			  param_stats.failed,
+			  param_stats.skipped,
+			  param_stats.total);
+	}
+}
+
+static void kunit_update_stats(struct kunit_result_stats *stats,
+			       enum kunit_status status)
+{
+	switch (status) {
+	case KUNIT_SUCCESS:
+		stats->passed++;
+		break;
+	case KUNIT_SKIPPED:
+		stats->skipped++;
+		break;
+	case KUNIT_FAILURE:
+		stats->failed++;
+		break;
+	}
+
+	stats->total++;
+}
+
+static void kunit_accumulate_stats(struct kunit_result_stats *total,
+				   struct kunit_result_stats add)
+{
+	total->passed += add.passed;
+	total->skipped += add.skipped;
+	total->failed += add.failed;
+	total->total += add.total;
+}
+
 int kunit_run_tests(struct kunit_suite *suite)
 {
 	char param_desc[KUNIT_PARAM_DESC_SIZE];
 	struct kunit_case *test_case;
+	struct kunit_result_stats suite_stats = { 0 };
+	struct kunit_result_stats total_stats = { 0 };
 
 	kunit_print_subtest_start(suite);
 
 	kunit_suite_for_each_test_case(suite, test_case) {
 		struct kunit test = { .param_value = NULL, .param_index = 0 };
+		struct kunit_result_stats param_stats = { 0 };
 		test_case->status = KUNIT_SKIPPED;
 
 		if (test_case->generate_params) {
@@ -431,14 +531,23 @@ int kunit_run_tests(struct kunit_suite *suite)
 				test.param_value = test_case->generate_params(test.param_value, param_desc);
 				test.param_index++;
 			}
+
+			kunit_update_stats(&param_stats, test.status);
+
 		} while (test.param_value);
 
+		kunit_print_test_stats(&test, param_stats);
+
 		kunit_print_ok_not_ok(&test, true, test_case->status,
 				      kunit_test_case_num(suite, test_case),
 				      test_case->name,
 				      test.status_comment);
+
+		kunit_update_stats(&suite_stats, test_case->status);
+		kunit_accumulate_stats(&total_stats, param_stats);
 	}
 
+	kunit_print_suite_stats(suite, suite_stats, total_stats);
 	kunit_print_subtest_end(suite);
 
 	return 0;
diff --git a/tools/testing/kunit/kunit_parser.py b/tools/testing/kunit/kunit_parser.py
index b88db3f51dc5..c699f778da06 100644
--- a/tools/testing/kunit/kunit_parser.py
+++ b/tools/testing/kunit/kunit_parser.py
@@ -137,7 +137,7 @@ def print_log(log) -> None:
 	for m in log:
 		print_with_timestamp(m)
 
-TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*#).*$')
+TAP_ENTRIES = re.compile(r'^(TAP|[\s]*ok|[\s]*not ok|[\s]*[0-9]+\.\.[0-9]+|[\s]*# (Subtest:|.*: kunit test case crashed!)).*$')
 
 def consume_non_diagnostic(lines: LineStream) -> None:
 	while lines and not TAP_ENTRIES.match(lines.peek()):
-- 
2.32.0.554.ge1b32706d8-goog

