Return-Path: <linux-kselftest+bounces-47722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A3FCCEE38
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 09:08:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EF8463010EDB
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 08:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9CF2D9494;
	Fri, 19 Dec 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RHQoupV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0104A13FEE
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 08:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766131734; cv=none; b=rSZDsKLJ05M74Oijz7Ki5zACmI1+8PXvhMjp5e+FJjFC4/PV5gu/VPJUY39UJ3T9M7Zzu4C6IOG4K/3BiT1ntYcOEuE1Isvk4mv0JLWy2B3olcY0CybKlKEYQ/7tTlvqJXvY6nEUGxNXe2L8jB7fBBTht+XmojQ2eCcLmlhIAes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766131734; c=relaxed/simple;
	bh=c08HL3X0gS3Tir32FNsPBvq2tRvqI6vCoJ/9N8wTGuc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=k1Oo6CAX6mHiY5Jc9Veh0h7Ayt72oFtHJJpzozB4TfbcPMyxxi1X/DR38Lq8mfMDkja82iM+nOyYo2Znh55ngWNo539IUCqxF5gFNzYmMmDMHm4G4NH3mlX7TQHXO2UKSVv9YBosYGJkNtMNXsY4KCPChqCGMo/04JBqCtwqjqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RHQoupV; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7d5564057d0so4004684b3a.0
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 00:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766131732; x=1766736532; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CVYP3bSK2KuLrEmdKNykpHO/s/KahanlguSoTHltRDI=;
        b=1RHQoupVcIUAoTzzmPCpT4LeNSNBCfkZLwNOMXXFGFK7ioYGn6rHOv/24EdsNL9xB1
         5lsyrSdlv+4NCtW/SoYo6KjqRASMOddodfIv3bPFM6waEV44agYvZMa9ibvMIKDrQXZ0
         DzW7Isj5xEmyuAuowlzrVw30XM0l4ftQiXl1R1Qz4woKdrqFffHWeCAR4pQjk59QPRM8
         WiFlyKoFATjJaRnmeDOLz/IrjpLrMU+AbMJHJMOdXCQcH7LZm/UP9cUQUJVKHg6mSom4
         VcBI0SDgqvfPLZhzZrG7POirNRmSfu8FO59SnJOa2NJrss4AK9UNepfsQd2be9y8XsvY
         a5Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766131732; x=1766736532;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CVYP3bSK2KuLrEmdKNykpHO/s/KahanlguSoTHltRDI=;
        b=EgBvU6dbKwm0DIJ5gPYrFyImdISHhcU+PBN0Aj2XQ5idb4buNX+tRrfbU6ZsW3HreZ
         jOBpa2m+uFtbQHmH8qGVGPBxkaLu5LDfO810pHEq0mq1KX/cR0n721oLvvMiSyif999o
         rG21YqJp6EsTOg332L7tEfndAMpc0M8+a3XxFjwFuoA8oUIRY1nmvjr0YLhGFGJCcOEQ
         ZFMGGtb65cs3kFW1pUrjJM2fJDkSMncxvwgEJno2jFM2aGAhuW5x+2Ej3s/AIxz91Oxz
         tZK7rtEAxS4BStLjxx7cSw274rLoeMTwgl/pkJVZaaI9K2vjBu1SQHxq5WSJGpB8jdxk
         Fifw==
X-Forwarded-Encrypted: i=1; AJvYcCXYkf3XYYfakB9Cr6LJqVOaBJe/GMwHFDz2LfPBSmjVOy0L+rKmV/1Exi5ZneWE5hjeBEU4kVHrrtCgLsdnhkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMTtHnJxuWEYHtJ+/FYsJLa4Cpkwo17IDzF/YuLuzI8qpd3yt4
	7wbbEbeZbIWD8BUiRPajEx3Egw2QdwqoVuVJ5Butec7A+AvlE929AfsOmEekHs3jAIXpWUK3Aw5
	grTdnkqjGEhPvdA==
X-Google-Smtp-Source: AGHT+IF1HWHkidomjHSYrLOWRhyEBQjZoXpv/inqUNzrJu7XY2pVFTmtxyYaUnlT82pi8CaiMhNQXsM7MCuS1Q==
X-Received: from pfbk28.prod.google.com ([2002:a05:6a00:b01c:b0:7c2:a212:2b32])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3385:b0:7ab:5e68:e204 with SMTP id d2e1a72fcca58-7ff650cdf7amr2113593b3a.29.1766131732390;
 Fri, 19 Dec 2025 00:08:52 -0800 (PST)
Date: Fri, 19 Dec 2025 16:08:48 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219080850.921416-1-davidgow@google.com>
Subject: [PATCH] kunit: Enforce task execution in {soft,hard}irq contexts
From: David Gow <davidgow@google.com>
To: Eric Biggers <ebiggers@kernel.org>, Brendan Higgins <brendan.higgins@linux.dev>, 
	Rae Moar <raemoar63@gmail.com>, Shuah Khan <skhan@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The kunit_run_irq_test() helper allows a function to be run in hardirq
and softirq contexts (in addition to the task context). It does this by
running the user-provided function concurrently in the three contexts,
until either a timeout has expired or a number of iterations have
completed in the normal task context.

However, on setups where the initialisation of the hardirq and softirq
contexts (or, indeed, the scheduling of those tasks) is significantly
slower than the function execution, it's possible for that number of
iterations to be exceeded before any runs in irq contexts actually
occur. This occurs with the polyval.test_polyval_preparekey_in_irqs
test, which runs 20000 iterations of the relatively fast preparekey
function, and therefore fails often under many UML, 32-bit arm, m68k and
other environments.

Instead, ensure that the max_iterations limit counts executions in all
three contexts, and requires at least one of each. This will cause the
test to continue iterating until at least the irq contexts have been
tested, or the 1s wall-clock limit has been exceeded. This causes the
test to pass in all of my environments.

In so doing, we also update the task counters to atomic ints, to better
match both the 'int' max_iterations input, and to ensure they are
correctly updated across contexts.

Finally, we also fix a few potential assertion messages to be
less-specific to the original crypto usecases.

Fixes: b41dc83f0790 ("kunit, lib/crypto: Move run_irq_test() to common header")
Signed-off-by: David Gow <davidgow@google.com>
---
 include/kunit/run-in-irq-context.h | 41 ++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 13 deletions(-)

diff --git a/include/kunit/run-in-irq-context.h b/include/kunit/run-in-irq-context.h
index 108e96433ea4..4d25aee0de6e 100644
--- a/include/kunit/run-in-irq-context.h
+++ b/include/kunit/run-in-irq-context.h
@@ -20,8 +20,8 @@ struct kunit_irq_test_state {
 	bool task_func_reported_failure;
 	bool hardirq_func_reported_failure;
 	bool softirq_func_reported_failure;
-	unsigned long hardirq_func_calls;
-	unsigned long softirq_func_calls;
+	atomic_t hardirq_func_calls;
+	atomic_t softirq_func_calls;
 	struct hrtimer timer;
 	struct work_struct bh_work;
 };
@@ -32,7 +32,7 @@ static enum hrtimer_restart kunit_irq_test_timer_func(struct hrtimer *timer)
 		container_of(timer, typeof(*state), timer);
 
 	WARN_ON_ONCE(!in_hardirq());
-	state->hardirq_func_calls++;
+	atomic_inc(&state->hardirq_func_calls);
 
 	if (!state->func(state->test_specific_state))
 		state->hardirq_func_reported_failure = true;
@@ -48,7 +48,7 @@ static void kunit_irq_test_bh_work_func(struct work_struct *work)
 		container_of(work, typeof(*state), bh_work);
 
 	WARN_ON_ONCE(!in_serving_softirq());
-	state->softirq_func_calls++;
+	atomic_inc(&state->softirq_func_calls);
 
 	if (!state->func(state->test_specific_state))
 		state->softirq_func_reported_failure = true;
@@ -59,7 +59,10 @@ static void kunit_irq_test_bh_work_func(struct work_struct *work)
  * hardirq context concurrently, and reports a failure to KUnit if any
  * invocation of @func in any context returns false.  @func is passed
  * @test_specific_state as its argument.  At most 3 invocations of @func will
- * run concurrently: one in each of task, softirq, and hardirq context.
+ * run concurrently: one in each of task, softirq, and hardirq context. @func
+ * will continue running until either @max_iterations calls have been made (so
+ * long as at least one each runs in task, softirq, and hardirq contexts), or
+ * one second has passed.
  *
  * The main purpose of this interrupt context testing is to validate fallback
  * code paths that run in contexts where the normal code path cannot be used,
@@ -85,6 +88,10 @@ static inline void kunit_run_irq_test(struct kunit *test, bool (*func)(void *),
 		.test_specific_state = test_specific_state,
 	};
 	unsigned long end_jiffies;
+	int hardirq_calls, softirq_calls;
+	bool allctx = false;
+
+	max_iterations = 1;
 
 	/*
 	 * Set up a hrtimer (the way we access hardirq context) and a work
@@ -94,14 +101,22 @@ static inline void kunit_run_irq_test(struct kunit *test, bool (*func)(void *),
 			       CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 	INIT_WORK_ONSTACK(&state.bh_work, kunit_irq_test_bh_work_func);
 
-	/* Run for up to max_iterations or 1 second, whichever comes first. */
+	/* Run for up to max_iterations (including at least one task, softirq,
+	 * and hardirq), or 1 second, whichever comes first.
+	 */
 	end_jiffies = jiffies + HZ;
 	hrtimer_start(&state.timer, KUNIT_IRQ_TEST_HRTIMER_INTERVAL,
 		      HRTIMER_MODE_REL_HARD);
-	for (int i = 0; i < max_iterations && !time_after(jiffies, end_jiffies);
-	     i++) {
+	for (int task_calls = 0, calls = 0;
+			((calls < max_iterations) || !allctx) && !time_after(jiffies, end_jiffies);
+			task_calls++) {
 		if (!func(test_specific_state))
 			state.task_func_reported_failure = true;
+
+		hardirq_calls = atomic_read(&state.hardirq_func_calls);
+		softirq_calls = atomic_read(&state.softirq_func_calls);
+		calls = task_calls + hardirq_calls + softirq_calls;
+		allctx = (task_calls > 0) && (hardirq_calls > 0) && (softirq_calls > 0);
 	}
 
 	/* Cancel the timer and work. */
@@ -109,21 +124,21 @@ static inline void kunit_run_irq_test(struct kunit *test, bool (*func)(void *),
 	flush_work(&state.bh_work);
 
 	/* Sanity check: the timer and BH functions should have been run. */
-	KUNIT_EXPECT_GT_MSG(test, state.hardirq_func_calls, 0,
+	KUNIT_EXPECT_GT_MSG(test, atomic_read(&state.hardirq_func_calls), 0,
 			    "Timer function was not called");
-	KUNIT_EXPECT_GT_MSG(test, state.softirq_func_calls, 0,
+	KUNIT_EXPECT_GT_MSG(test, atomic_read(&state.softirq_func_calls), 0,
 			    "BH work function was not called");
 
 	/* Check for incorrect hash values reported from any context. */
 	KUNIT_EXPECT_FALSE_MSG(
 		test, state.task_func_reported_failure,
-		"Incorrect hash values reported from task context");
+		"Failure reported from task context");
 	KUNIT_EXPECT_FALSE_MSG(
 		test, state.hardirq_func_reported_failure,
-		"Incorrect hash values reported from hardirq context");
+		"Failure reported from hardirq context");
 	KUNIT_EXPECT_FALSE_MSG(
 		test, state.softirq_func_reported_failure,
-		"Incorrect hash values reported from softirq context");
+		"Failure reported from softirq context");
 }
 
 #endif /* _KUNIT_RUN_IN_IRQ_CONTEXT_H */
-- 
2.52.0.322.g1dd061c0dc-goog


