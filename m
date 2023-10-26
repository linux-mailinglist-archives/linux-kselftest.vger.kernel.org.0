Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771B07D7F30
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Oct 2023 10:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjJZI7i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 26 Oct 2023 04:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjJZI7h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 26 Oct 2023 04:59:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A2E10E;
        Thu, 26 Oct 2023 01:59:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076DEC433C8;
        Thu, 26 Oct 2023 08:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698310775;
        bh=ZxJyjl9iM4hVa2LaauAP/lo/cgON8YMCpqCM6LS+2Pk=;
        h=From:To:Cc:Subject:Date:From;
        b=g/65lgSSseLw3teMZhybtUHctnj8GOXAfGp6+CiWmSz6aX1JmvD8musYmiPdJen5c
         P+HOABcTBrWuuuT6zSFuplvDN4d1aUc+0IPrXv203nI2NGJwrnbzVhoVVikE3N/blF
         DBMnbhd6YTMIksT9qFh+Tu2kLBsZmJNa++YrfxbO91Lky/9TjrSKwT88bBNcRg0HiI
         7QbGTESDQeUZSBics4ERjU9imaoKGy2ETJXtyt6+aeavkY6mDsqtZA2LuEb2XeIjJh
         KnRvucg7WE8mFBoNe6HjWkX7yZgeAeMhs34l8Ti7AyMvVQY5I8aKsZZv+fXRzDL8uF
         TKH5x8Px/2bpg==
From:   Maxime Ripard <mripard@kernel.org>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH v3] kunit: Warn if tests are slow
Date:   Thu, 26 Oct 2023 10:59:31 +0200
Message-ID: <20231026085931.883824-1-mripard@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kunit recently gained support to setup attributes, the first one being
the speed of a given test, then allowing to filter out slow tests.

A slow test is defined in the documentation as taking more than one
second. There's an another speed attribute called "super slow" but whose
definition is less clear.

Add support to the test runner to check the test execution time, and
report tests that should be marked as slow but aren't.

Signed-off-by: Maxime Ripard <mripard@kernel.org>

---

To: Brendan Higgins <brendan.higgins@linux.dev>
To: David Gow <davidgow@google.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Rae Moar <rmoar@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: linux-kernel@vger.kernel.org

Changes from v2:
- Add defines and comments to make the warning reporting threshold more
  obvious
- Switch the duration comparisons to timespec64_compare to be more
  accurate
- Link: https://lore.kernel.org/all/20230920084903.1522728-1-mripard@kernel.org/

Changes from v1:
- Split the patch out of the series
- Change to trigger the warning only if the runtime is twice the
  threshold (Jani, Rae)
- Split the speed check into a separate function (Rae)
- Link: https://lore.kernel.org/all/20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org/
---
 lib/kunit/test.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 49698a168437..4b710c92340a 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -372,6 +372,36 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
 
+/* Only warn when a test takes more than twice the threshold */
+#define KUNIT_SPEED_WARNING_MULTIPLIER	2
+
+/* Slow tests are defined as taking more than 1s */
+#define KUNIT_SPEED_SLOW_THRESHOLD_S	1
+
+#define KUNIT_SPEED_SLOW_WARNING_THRESHOLD_S	\
+	(KUNIT_SPEED_WARNING_MULTIPLIER * KUNIT_SPEED_SLOW_THRESHOLD_S)
+
+#define s_to_timespec64(s) ns_to_timespec64((s) * NSEC_PER_SEC)
+
+static void kunit_run_case_check_speed(struct kunit *test,
+				       struct kunit_case *test_case,
+				       struct timespec64 duration)
+{
+	struct timespec64 slow_thr =
+		s_to_timespec64(KUNIT_SPEED_SLOW_WARNING_THRESHOLD_S);
+	enum kunit_speed speed = test_case->attr.speed;
+
+	if (timespec64_compare(&duration, &slow_thr) < 0)
+		return;
+
+	if (speed == KUNIT_SPEED_VERY_SLOW || speed == KUNIT_SPEED_SLOW)
+		return;
+
+	kunit_warn(test,
+		   "Test should be marked slow (runtime: %lld.%09lds)",
+		   duration.tv_sec, duration.tv_nsec);
+}
+
 /*
  * Initializes and runs test case. Does not clean up or do post validations.
  */
@@ -379,6 +409,8 @@ static void kunit_run_case_internal(struct kunit *test,
 				    struct kunit_suite *suite,
 				    struct kunit_case *test_case)
 {
+	struct timespec64 start, end;
+
 	if (suite->init) {
 		int ret;
 
@@ -390,7 +422,13 @@ static void kunit_run_case_internal(struct kunit *test,
 		}
 	}
 
+	ktime_get_ts64(&start);
+
 	test_case->run_case(test);
+
+	ktime_get_ts64(&end);
+
+	kunit_run_case_check_speed(test, test_case, timespec64_sub(end, start));
 }
 
 static void kunit_case_internal_cleanup(struct kunit *test)
-- 
2.41.0

