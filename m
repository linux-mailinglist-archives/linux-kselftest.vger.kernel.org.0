Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5E67A7643
	for <lists+linux-kselftest@lfdr.de>; Wed, 20 Sep 2023 10:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233464AbjITItP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 20 Sep 2023 04:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbjITItO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 20 Sep 2023 04:49:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDAA93;
        Wed, 20 Sep 2023 01:49:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8FCC433C7;
        Wed, 20 Sep 2023 08:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695199748;
        bh=qSsw71s1Fjqhd6GpejqtDVQ+WOuNOzjUTZO9Z7vF7/U=;
        h=From:To:Cc:Subject:Date:From;
        b=fFAMTd+2BBf2WY/P+COVYj/C+yt5CW2oUw5+/gHjtBVXIg8DfalWC6QQBjBe0+lzI
         HCRD/4HKgXi6HHRdTJBRaP3MAtQfvuk4CuqD3kn14luq9yfCUZ219qJyhzlljI5rZ0
         8GOsRtOiS4bY3sHoIrlScmuKF1T6NIfYXb/i0b+ci1NyaVrMNe3xaEUKH13jcFMCtE
         gKwWWwElx1pddNUlBvkKnp7oOVbW9AUj9bTtiYF0FLTQuEVCaPLu/Si1b39j9VM/A9
         rGnf/k9CCmLomNoq1h3YsW+zmKbfqgMn2wC3CnTBuBvXwxQ8sRFz1Wt+ImMkHcNRNN
         Zc5kHJiq44UWQ==
From:   Maxime Ripard <mripard@kernel.org>
To:     Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>
Cc:     Maxime Ripard <mripard@kernel.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rae Moar <rmoar@google.com>, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] kunit: Warn if tests are slow
Date:   Wed, 20 Sep 2023 10:49:03 +0200
Message-ID: <20230920084903.1522728-1-mripard@kernel.org>
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

Changes from v1:
- Split the patch out of the series
- Change to trigger the warning only if the runtime is twice the
  threshold (Jani, Rae)
- Split the speed check into a separate function (Rae)
- Link: https://lore.kernel.org/all/20230911-kms-slow-tests-v1-0-d3800a69a1a1@kernel.org/
---
 lib/kunit/test.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index 49698a168437..a1d5dd2bf87d 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -372,6 +372,25 @@ void kunit_init_test(struct kunit *test, const char *name, char *log)
 }
 EXPORT_SYMBOL_GPL(kunit_init_test);
 
+#define KUNIT_SPEED_SLOW_THRESHOLD_S	1
+
+static void kunit_run_case_check_speed(struct kunit *test,
+				       struct kunit_case *test_case,
+				       struct timespec64 duration)
+{
+	enum kunit_speed speed = test_case->attr.speed;
+
+	if (duration.tv_sec < (2 * KUNIT_SPEED_SLOW_THRESHOLD_S))
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
@@ -379,6 +398,8 @@ static void kunit_run_case_internal(struct kunit *test,
 				    struct kunit_suite *suite,
 				    struct kunit_case *test_case)
 {
+	struct timespec64 start, end;
+
 	if (suite->init) {
 		int ret;
 
@@ -390,7 +411,13 @@ static void kunit_run_case_internal(struct kunit *test,
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

