Return-Path: <linux-kselftest+bounces-47727-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132BCCF0AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 09:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A6817300E757
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Dec 2025 08:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B152DA75B;
	Fri, 19 Dec 2025 08:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tURMZpc5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E5B1C3C1F
	for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766134384; cv=none; b=qMHgRXGIXSwBVDDCfrOgG/7OVwjUVBx/khCLjSiCjbTI5E12GZT6Zbwb4zmcEMvPrk+/GFAgNqVKSK8fTSPDHWszh6CHnfyl0fPVxoOJ92/a1RGy3HbAEU5XYH3GjDoom9koVcpDA5NeB8eqZ61Eojj0N3ubf7h/2VmyrvG3zOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766134384; c=relaxed/simple;
	bh=EkNn/8zLRRogqkTnjH1xZ8UN7YMucZRcQRYw+pKAvEU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=VAasPYEAVxiPbPBFAeQdtITBJlrxQbYR8rjqBy9BMEYCLfwSph3KZTXB+dl3OGGJ63EORgZVG1I5bfJsc+cdYQa12y6xR2ojbI4Pjw+lfQKlMY/Rhgl7tMVkkkfsIc5G8VRNPZQcQRQMXmzlyuy4lt0B8vXVpSDoy+XLjU1xP9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tURMZpc5; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--davidgow.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7f046e16d50so2524040b3a.3
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Dec 2025 00:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766134382; x=1766739182; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ALTNgV5kbX+eaK/ALXgwW4Fu8E31sXIsssHSl1cpDHw=;
        b=tURMZpc5/djSR1TpR9jNycwKbT7z5Ci8ARj4BgJxCo4eGD5gw+r4aT5x3/dPQUPMzX
         WzZj5j0Yt71aTvKa6ftlWMnnscseq3KIQ5CLGDtehhc5NB816Sqf0JBVLzE7o3eaNiuO
         4k1IwlgRgHwqAWvC6UU2p33FhXW09tWb8MLGBMyHrqHy64CN4UpmlD8J+CsFUAh9btaZ
         rGL72asPu5VeTBqZl7/cU+CHwrkUVaA6UBkHNqJOwoqKqTJZAIBoA5B5JO5Zj96S45se
         qlxTryWH3dXm9Eu45R+FJuZyubw72KmdU7RI7xwsjDlB2CUyT7MOaBPSnkRSUzeWfvek
         erYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766134382; x=1766739182;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ALTNgV5kbX+eaK/ALXgwW4Fu8E31sXIsssHSl1cpDHw=;
        b=LX1yjO2uRBrW9cM3nQVsAG4TKybNaGQXHyQPX7w38C8sGbbYkqwEAE1X59e8PuZF14
         EvqABL8JAY/69dwe7+Mli1ixxTg6ltVxNd0onAwDxkc+AvuBTySdCHurnV9KxPciwGY5
         OnHm9s+anoXn6Im/AdE+3tdQrVhzFBlInZMVe2UzrCNL+x5IuQrEAJxF3xWRQ1Fl0Ig9
         1EvmawqxFxsdjQmLi1CiUbKwR8GISCs3xr4MovL+jHCdX+y4krOp9fjxP4raNkPouRHP
         66OrljtH9yfflE8BK7focOvvWG12tDKyBs21rDVLwqVa5RVGA4ohRrfuxEwykj6QAiMF
         KS7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWMIcay6Wdh0JiKOBKl4LVbepm0as9Bo25Q3jBhDSeNDyNzn8JOHVvk69wNWR/vI1fhclFMs/iayOK59300okE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPis6Dgdt22OVUnqRLxVQZEs72Y2I/Gnc1LmFrRXOdgVGKlbdq
	qaePOWSwlJHJF7EpBUiR8LpVA/YvNS2xBjW5L34HjKNIC2gCSIB582QPHdmxhMUI5r8mVFsf2lQ
	LCiGZdfLmb1qEgw==
X-Google-Smtp-Source: AGHT+IE2Q1WFb9mTXX7DFWKmbUYLdBN23Zehjr9ll2dutUp2jpF8zckcooSNEdiepsEmOy1X7NRwXN6EfgSl/w==
X-Received: from pfbmy26-n2.prod.google.com ([2002:a05:6a00:6d5a:20b0:7dd:8bba:6391])
 (user=davidgow job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3386:b0:7f2:1951:c130 with SMTP id d2e1a72fcca58-7ff66d5ff66mr2340671b3a.68.1766134382070;
 Fri, 19 Dec 2025 00:53:02 -0800 (PST)
Date: Fri, 19 Dec 2025 16:52:58 +0800
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219085259.1163048-1-davidgow@google.com>
Subject: [PATCH v2] kunit: Enforce task execution in {soft,hard}irq contexts
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

Changes since v1:
https://lore.kernel.org/all/20251219080850.921416-1-davidgow@google.com/
- Remove a leftover debug line which forced max_iterations to 1.


 include/kunit/run-in-irq-context.h | 39 ++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/include/kunit/run-in-irq-context.h b/include/kunit/run-in-irq-context.h
index 108e96433ea4..84694f383e37 100644
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
@@ -85,6 +88,8 @@ static inline void kunit_run_irq_test(struct kunit *test, bool (*func)(void *),
 		.test_specific_state = test_specific_state,
 	};
 	unsigned long end_jiffies;
+	int hardirq_calls, softirq_calls;
+	bool allctx = false;
 
 	/*
 	 * Set up a hrtimer (the way we access hardirq context) and a work
@@ -94,14 +99,22 @@ static inline void kunit_run_irq_test(struct kunit *test, bool (*func)(void *),
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
@@ -109,21 +122,21 @@ static inline void kunit_run_irq_test(struct kunit *test, bool (*func)(void *),
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


