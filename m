Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058D76D5232
	for <lists+linux-kselftest@lfdr.de>; Mon,  3 Apr 2023 22:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjDCUUg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 3 Apr 2023 16:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjDCUUO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 3 Apr 2023 16:20:14 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58D749F3
        for <linux-kselftest@vger.kernel.org>; Mon,  3 Apr 2023 13:19:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id e186-20020a2537c3000000b00b72501acf50so30088672yba.20
        for <linux-kselftest@vger.kernel.org>; Mon, 03 Apr 2023 13:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680553174;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rGqh23Uho9as75Hu8J99LRSqbd0ZR41vrBHLl9H6fHQ=;
        b=khkXUNMAfSlZq41nqUyefbu+R10boC1ReNh6N+z0+vMXfFPuyw3nUSlPus1j+7qsL4
         d9MXbXjh74GH+fY+wME0qYIBTILSWRnN2LIvTyS18LlZ6LDhX8bSvqY9AZWQtCzy3mMy
         6a0MDKkSVkvWVK0p9zNkxgcL55KZTRpuR3KZt0/mDGR6xA5VfrZjpM4HxkPcUZ1lmctn
         C6AuTZXCHrq7B4K8XJH8Q9d+z8QTMsbB/9Q7hD9hl8Zx1Zx31x3CB/0v5HfNIln/J9qw
         w696+QnKuCQ2opbeqVjtFUuy+4a4doKDOS28UKq6NWLbJ17rnAMBto/SJpHPyIuIXA4E
         RHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680553174;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGqh23Uho9as75Hu8J99LRSqbd0ZR41vrBHLl9H6fHQ=;
        b=XDpfcFq3tmpweVtfSrwN3EfH+HSDSDwMmBX7F4maX6Q28Km0L7tSXbZUgnpDs8y+hB
         Lj2tkB0SUIFVR5OJ35eOtxeWbFVv0OW2nutpsDRxwax5H6PbMXaoRQwQ1e8r5DJhuKs9
         39XzhdvA8V8zwX+OQIfB69gxTghp1hPi1gVtZhLt7vYhHSdzq/jP2E2GRMUXzUq4PIZW
         iqxX8QvysdE8do628qIvuIA3BA56P08c0p/BW6fHQ81tWcPzNaqi+q5PXVLm8JJDrXpf
         n0qqf9sqRMoXF4Xs17IMT54k/2JPrq4ps5ZQ5ULbocukL5kgBMYtyUzDVy1KCMjup902
         9koQ==
X-Gm-Message-State: AAQBX9dTJ3NGcSEkR0aIV5uBaYoQ9GGN0aXov6OQzLb9qvcJnnsFDeys
        JBpde508mkiBnJBvQ2kwiEH/szv3jw==
X-Google-Smtp-Source: AKy350ZZP+l24APDLQ0PRDNMPAAj0096jqtn5eMmpF9PgOXcwHjxzRWAoeI0SY3rlBf35fZKL2v+Otk6mA==
X-Received: from rmoar-specialist.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:45d3])
 (user=rmoar job=sendgmr) by 2002:a81:8b52:0:b0:544:b9b2:5c32 with SMTP id
 e18-20020a818b52000000b00544b9b25c32mr105433ywk.7.1680553174571; Mon, 03 Apr
 2023 13:19:34 -0700 (PDT)
Date:   Mon,  3 Apr 2023 20:19:30 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230403201930.2019419-1-rmoar@google.com>
Subject: [PATCH v2] kunit: add tests for using current KUnit test field
From:   Rae Moar <rmoar@google.com>
To:     brendanhiggins@google.com, davidgow@google.com, dlatypov@google.com
Cc:     skhan@linuxfoundation.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Rae Moar <rmoar@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Create test suite called "kunit_current" to add test coverage for the use
of current->kunit_test, which returns the current KUnit test.

Add two test cases:
- kunit_current_test to test current->kunit_test and the method
  kunit_get_current_test(), which utilizes current->kunit_test.

- kunit_current_fail_test to test the method
  kunit_fail_current_test(), which utilizes current->kunit_test.

Signed-off-by: Rae Moar <rmoar@google.com>
---

Changes from v1->v2:
- Combine two test cases to test both ways of getting current test in
  kunit_current_test.
- Changes to comments.
- Add kunit_cleanup to kunit_current_fail_test.

 lib/kunit/kunit-test.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/kunit-test.c b/lib/kunit/kunit-test.c
index b63595d3e241..42e44caa1bdd 100644
--- a/lib/kunit/kunit-test.c
+++ b/lib/kunit/kunit-test.c
@@ -6,6 +6,7 @@
  * Author: Brendan Higgins <brendanhiggins@google.com>
  */
 #include <kunit/test.h>
+#include <kunit/test-bug.h>
 
 #include "try-catch-impl.h"
 
@@ -532,7 +533,46 @@ static struct kunit_suite kunit_status_test_suite = {
 	.test_cases = kunit_status_test_cases,
 };
 
+static void kunit_current_test(struct kunit *test)
+{
+	/* Check results of both current->kunit_test and
+	 * kunit_get_current_test() are equivalent to current test.
+	 */
+	KUNIT_EXPECT_PTR_EQ(test, test, current->kunit_test);
+	KUNIT_EXPECT_PTR_EQ(test, test, kunit_get_current_test());
+}
+
+static void kunit_current_fail_test(struct kunit *test)
+{
+	struct kunit fake;
+
+	kunit_init_test(&fake, "fake test", NULL);
+	KUNIT_EXPECT_EQ(test, fake.status, KUNIT_SUCCESS);
+
+	/* Set current->kunit_test to fake test. */
+	current->kunit_test = &fake;
+
+	kunit_fail_current_test("This should make `fake` test fail.");
+	KUNIT_EXPECT_EQ(test, fake.status, (enum kunit_status)KUNIT_FAILURE);
+	kunit_cleanup(&fake);
+
+	/* Reset current->kunit_test to current test. */
+	current->kunit_test = test;
+}
+
+static struct kunit_case kunit_current_test_cases[] = {
+	KUNIT_CASE(kunit_current_test),
+	KUNIT_CASE(kunit_current_fail_test),
+	{}
+};
+
+static struct kunit_suite kunit_current_test_suite = {
+	.name = "kunit_current",
+	.test_cases = kunit_current_test_cases,
+};
+
 kunit_test_suites(&kunit_try_catch_test_suite, &kunit_resource_test_suite,
-		  &kunit_log_test_suite, &kunit_status_test_suite);
+		  &kunit_log_test_suite, &kunit_status_test_suite,
+		  &kunit_current_test_suite);
 
 MODULE_LICENSE("GPL v2");

base-commit: 7232282dd47cce6a780c9414bd9baccf232c7686
-- 
2.40.0.348.gf938b09366-goog

