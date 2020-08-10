Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F761241271
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Aug 2020 23:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgHJVdH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 17:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgHJVdH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 17:33:07 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F083CC061756;
        Mon, 10 Aug 2020 14:33:06 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id u126so10480294iod.12;
        Mon, 10 Aug 2020 14:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EUQnG2l6qLmqDOtR01uNvp1OtWUBbv6CVlH5VJ/upA=;
        b=A0h6i2Dp3dIIrscqjjNOJJDKerU8Jc55r0y56Z8hUw2lZ5HS/SFtHzGqLSyPZjFQvU
         4zSUuqH9E1ZMiXU0fZJXoMUcHZkqFJimBq8ZaVp9BaAhAAWSUyy9DRqvegko1KjHdLBq
         ijQ4jpTq92itD/Av/4VTIqeQ9emKbzcyGedAtuuinakv6prvQ2uc54qzUMpPsZjHQHh6
         nE34K/SX8aBgPw/uF59P0WdH/cxZ8AmzS8VAfXxPLdW+7Vs4OIm74lOLc/Ssj2Zjevq+
         zIsX7fFb2zisOhtdcTCWwfFpFm7a3Or8sFwPZlSuFqynQFNE1sp2SWH63/y7RIJD9T8q
         dv0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2EUQnG2l6qLmqDOtR01uNvp1OtWUBbv6CVlH5VJ/upA=;
        b=fdB3lDBKwQzZocY65XwxhZzLRGCY2YyK99EKuE4gNnUh1facpSze74mUNnS3r0+MxN
         hXmegG6VY9Kz/b5mmlu4q1elUK/dzGscaD5lAfDMYjiIHP1DRqZzEnMd57AVK7YWj7T+
         KgJV5N3rn4LUG/a0tgHMlne9KR/BUyj6UrgFgGrWvbnkK9VF2LqijH75Qrku1qS2V3wX
         gplWahxsrcCnFguDmWjkB5iP1NrOc4r9Tzg3/lZhLHyqJUz06HvIAYvQb+cfzkgfYXqh
         WEDmDwLepGyYmrSmW97EzDHmBGjIzGG0R/6HjO8rjk71calt6m1RrcRVL1IbSTTHNYyU
         hLUQ==
X-Gm-Message-State: AOAM531xkbYN3vz69CzOzmfs8AMn/aBttVaxnheuUJHOYqX43XomdGUw
        1AGQOBMeZcjjA9z0cjJCN36b6Oe7ZFk=
X-Google-Smtp-Source: ABdhPJyMxdPMLjBf9knzYcUetN5GhPP8UnU3/VPzmNXj8uS53Ef6m4dKeeSFYjjnf/+FXbaMGZu4SA==
X-Received: by 2002:a05:6638:2647:: with SMTP id n7mr21838759jat.61.1597095185893;
        Mon, 10 Aug 2020 14:33:05 -0700 (PDT)
Received: from urieldev.c.googlers.com.com (243.199.238.35.bc.googleusercontent.com. [35.238.199.243])
        by smtp.gmail.com with ESMTPSA id t26sm5352053ilb.80.2020.08.10.14.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2020 14:33:05 -0700 (PDT)
From:   Uriel Guajardo <urielguajardojr@gmail.com>
To:     brendanhiggins@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org
Cc:     urielguajardo@google.com, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [PATCH] kunit: added lockdep support
Date:   Mon, 10 Aug 2020 21:32:57 +0000
Message-Id: <20200810213257.438861-1-urielguajardojr@gmail.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Uriel Guajardo <urielguajardo@google.com>

KUnit tests will now fail if lockdep detects an error during a test
case.

The idea comes from how lib/locking-selftest [1] checks for lock errors: we
first if lock debugging is turned on. If not, an error must have
occurred, so we fail the test and restart lockdep for the next test case.

Like the locking selftests, we also fix possible preemption count
corruption from lock bugs.

Depends on kunit: support failure from dynamic analysis tools [2]

[1] https://elixir.bootlin.com/linux/v5.7.12/source/lib/locking-selftest.c#L1137

[2] https://lore.kernel.org/linux-kselftest/20200806174326.3577537-1-urielguajardojr@gmail.com/

Signed-off-by: Uriel Guajardo <urielguajardo@google.com>
---
 lib/kunit/test.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/lib/kunit/test.c b/lib/kunit/test.c
index d8189d827368..0838ececa005 100644
--- a/lib/kunit/test.c
+++ b/lib/kunit/test.c
@@ -11,6 +11,8 @@
 #include <linux/kref.h>
 #include <linux/sched/debug.h>
 #include <linux/sched.h>
+#include <linux/lockdep.h>
+#include <linux/debug_locks.h>
 
 #include "debugfs.h"
 #include "string-stream.h"
@@ -22,6 +24,26 @@ void kunit_fail_current_test(void)
 		kunit_set_failure(current->kunit_test);
 }
 
+static inline void kunit_check_locking_bugs(struct kunit *test,
+					    unsigned long saved_preempt_count)
+{
+	preempt_count_set(saved_preempt_count);
+#ifdef CONFIG_TRACE_IRQFLAGS
+	if (softirq_count())
+		current->softirqs_enabled = 0;
+	else
+		current->softirqs_enabled = 1;
+#endif
+#if IS_ENABLED(CONFIG_LOCKDEP)
+	local_irq_disable();
+	if (!debug_locks) {
+		kunit_set_failure(test);
+		lockdep_reset();
+	}
+	local_irq_enable();
+#endif
+}
+
 static void kunit_print_tap_version(void)
 {
 	static bool kunit_has_printed_tap_version;
@@ -289,6 +311,7 @@ static void kunit_try_run_case(void *data)
 	struct kunit *test = ctx->test;
 	struct kunit_suite *suite = ctx->suite;
 	struct kunit_case *test_case = ctx->test_case;
+	unsigned long saved_preempt_count = preempt_count();
 
 	current->kunit_test = test;
 
@@ -298,7 +321,8 @@ static void kunit_try_run_case(void *data)
 	 * thread will resume control and handle any necessary clean up.
 	 */
 	kunit_run_case_internal(test, suite, test_case);
-	/* This line may never be reached. */
+	/* These lines may never be reached. */
+	kunit_check_locking_bugs(test, saved_preempt_count);
 	kunit_run_case_cleanup(test, suite);
 }
 
-- 
2.28.0.236.gb10cc79966-goog

