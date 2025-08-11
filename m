Return-Path: <linux-kselftest+bounces-38696-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEEFB21454
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 20:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05A813E5256
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Aug 2025 18:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF9A02E172C;
	Mon, 11 Aug 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBtPGm5R"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153C2E11B5;
	Mon, 11 Aug 2025 18:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754936895; cv=none; b=DsFnbNvFZ8ltNY53WvKWV0ma+xbpRRkfiyic+C2/Wln6kgBPp/nijFLM4/i5DRKOJUkvJ8ecmuPtxj6s0Mq8BZ/yxaci4/c+PhZJc2EcPcyZkhc9iHb77TgXHwhOyGQGt5MVwT+CGnYxhwlVtuEb3k8H2e1oC1d8AZtxc7kTJjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754936895; c=relaxed/simple;
	bh=v+uI9RgVhcnAWYgq7k6R6BzMyJMOzTZxFw5x6+b2bgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lb1pVBruYsBwHIv+ax75otp/JoYB8Y7BMR7PqzpzkG9Z9kzlt0dxGpO1PY8qRY3lxjMKkIBqqs1YGl912Bvgk+bQJCKgHuxmNL+CLN4siip+NvwV90c0uF2q0e5VU8IEfdBMpwZKkJnqKvYjiqAdiOD3k+rr9+neKaWzKNXn/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBtPGm5R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EE18C4CEF5;
	Mon, 11 Aug 2025 18:28:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754936895;
	bh=v+uI9RgVhcnAWYgq7k6R6BzMyJMOzTZxFw5x6+b2bgY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HBtPGm5Rva7/ljD7ylUb1VsOUFBjTRwA5nu75yCSL7wEOt53SS/3LuD31Tiy5ggDx
	 1WUHofV9ytaje/F9HR2OjDi3ovBHYS8TuJd5jL+HtmYM+E7lMxRVbLpST0P15nQCBq
	 VCKP/g2cWmJrJYZ2koIWMX3FMInjsTdSngqJhfsbUIgRN1742eanNCzJSh+JUtF/3q
	 IDRAGtMheOj1zRJJLRzyLov6wXn8iR5cbgS+LqTm4IViRoTzQ1chXKnl9uSXWNJoW7
	 +Vyzd9BM8pDC7i71cLI7OR01Gt//khT/iAj2SN7kEaQfMETd2NxZs3fJTQfOWUOuqy
	 7q197TEVFiEOw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 1/3] kunit, lib/crypto: Move run_irq_test() to common header
Date: Mon, 11 Aug 2025 11:26:29 -0700
Message-ID: <20250811182631.376302-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811182631.376302-1-ebiggers@kernel.org>
References: <20250811182631.376302-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename run_irq_test() to kunit_run_irq_test() and move it to a public
header so that it can be reused by crc_kunit.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 include/kunit/run-in-irq-context.h    | 129 ++++++++++++++++++++++++++
 lib/crypto/tests/hash-test-template.h | 123 +-----------------------
 2 files changed, 133 insertions(+), 119 deletions(-)
 create mode 100644 include/kunit/run-in-irq-context.h

diff --git a/include/kunit/run-in-irq-context.h b/include/kunit/run-in-irq-context.h
new file mode 100644
index 0000000000000..108e96433ea45
--- /dev/null
+++ b/include/kunit/run-in-irq-context.h
@@ -0,0 +1,129 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Helper function for testing code in interrupt contexts
+ *
+ * Copyright 2025 Google LLC
+ */
+#ifndef _KUNIT_RUN_IN_IRQ_CONTEXT_H
+#define _KUNIT_RUN_IN_IRQ_CONTEXT_H
+
+#include <kunit/test.h>
+#include <linux/timekeeping.h>
+#include <linux/hrtimer.h>
+#include <linux/workqueue.h>
+
+#define KUNIT_IRQ_TEST_HRTIMER_INTERVAL us_to_ktime(5)
+
+struct kunit_irq_test_state {
+	bool (*func)(void *test_specific_state);
+	void *test_specific_state;
+	bool task_func_reported_failure;
+	bool hardirq_func_reported_failure;
+	bool softirq_func_reported_failure;
+	unsigned long hardirq_func_calls;
+	unsigned long softirq_func_calls;
+	struct hrtimer timer;
+	struct work_struct bh_work;
+};
+
+static enum hrtimer_restart kunit_irq_test_timer_func(struct hrtimer *timer)
+{
+	struct kunit_irq_test_state *state =
+		container_of(timer, typeof(*state), timer);
+
+	WARN_ON_ONCE(!in_hardirq());
+	state->hardirq_func_calls++;
+
+	if (!state->func(state->test_specific_state))
+		state->hardirq_func_reported_failure = true;
+
+	hrtimer_forward_now(&state->timer, KUNIT_IRQ_TEST_HRTIMER_INTERVAL);
+	queue_work(system_bh_wq, &state->bh_work);
+	return HRTIMER_RESTART;
+}
+
+static void kunit_irq_test_bh_work_func(struct work_struct *work)
+{
+	struct kunit_irq_test_state *state =
+		container_of(work, typeof(*state), bh_work);
+
+	WARN_ON_ONCE(!in_serving_softirq());
+	state->softirq_func_calls++;
+
+	if (!state->func(state->test_specific_state))
+		state->softirq_func_reported_failure = true;
+}
+
+/*
+ * Helper function which repeatedly runs the given @func in task, softirq, and
+ * hardirq context concurrently, and reports a failure to KUnit if any
+ * invocation of @func in any context returns false.  @func is passed
+ * @test_specific_state as its argument.  At most 3 invocations of @func will
+ * run concurrently: one in each of task, softirq, and hardirq context.
+ *
+ * The main purpose of this interrupt context testing is to validate fallback
+ * code paths that run in contexts where the normal code path cannot be used,
+ * typically due to the FPU or vector registers already being in-use in kernel
+ * mode.  These code paths aren't covered when the test code is executed only by
+ * the KUnit test runner thread in task context.  The reason for the concurrency
+ * is because merely using hardirq context is not sufficient to reach a fallback
+ * code path on some architectures; the hardirq actually has to occur while the
+ * FPU or vector unit was already in-use in kernel mode.
+ *
+ * Another purpose of this testing is to detect issues with the architecture's
+ * irq_fpu_usable() and kernel_fpu_begin/end() or equivalent functions,
+ * especially in softirq context when the softirq may have interrupted a task
+ * already using kernel-mode FPU or vector (if the arch didn't prevent that).
+ * Crypto functions are often executed in softirqs, so this is important.
+ */
+static inline void kunit_run_irq_test(struct kunit *test, bool (*func)(void *),
+				      int max_iterations,
+				      void *test_specific_state)
+{
+	struct kunit_irq_test_state state = {
+		.func = func,
+		.test_specific_state = test_specific_state,
+	};
+	unsigned long end_jiffies;
+
+	/*
+	 * Set up a hrtimer (the way we access hardirq context) and a work
+	 * struct for the BH workqueue (the way we access softirq context).
+	 */
+	hrtimer_setup_on_stack(&state.timer, kunit_irq_test_timer_func,
+			       CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
+	INIT_WORK_ONSTACK(&state.bh_work, kunit_irq_test_bh_work_func);
+
+	/* Run for up to max_iterations or 1 second, whichever comes first. */
+	end_jiffies = jiffies + HZ;
+	hrtimer_start(&state.timer, KUNIT_IRQ_TEST_HRTIMER_INTERVAL,
+		      HRTIMER_MODE_REL_HARD);
+	for (int i = 0; i < max_iterations && !time_after(jiffies, end_jiffies);
+	     i++) {
+		if (!func(test_specific_state))
+			state.task_func_reported_failure = true;
+	}
+
+	/* Cancel the timer and work. */
+	hrtimer_cancel(&state.timer);
+	flush_work(&state.bh_work);
+
+	/* Sanity check: the timer and BH functions should have been run. */
+	KUNIT_EXPECT_GT_MSG(test, state.hardirq_func_calls, 0,
+			    "Timer function was not called");
+	KUNIT_EXPECT_GT_MSG(test, state.softirq_func_calls, 0,
+			    "BH work function was not called");
+
+	/* Check for incorrect hash values reported from any context. */
+	KUNIT_EXPECT_FALSE_MSG(
+		test, state.task_func_reported_failure,
+		"Incorrect hash values reported from task context");
+	KUNIT_EXPECT_FALSE_MSG(
+		test, state.hardirq_func_reported_failure,
+		"Incorrect hash values reported from hardirq context");
+	KUNIT_EXPECT_FALSE_MSG(
+		test, state.softirq_func_reported_failure,
+		"Incorrect hash values reported from softirq context");
+}
+
+#endif /* _KUNIT_RUN_IN_IRQ_CONTEXT_H */
diff --git a/lib/crypto/tests/hash-test-template.h b/lib/crypto/tests/hash-test-template.h
index f437a0a9ac6cd..61b43e62779fb 100644
--- a/lib/crypto/tests/hash-test-template.h
+++ b/lib/crypto/tests/hash-test-template.h
@@ -3,15 +3,13 @@
  * Test cases for hash functions, including a benchmark.  This is included by
  * KUnit test suites that want to use it.  See sha512_kunit.c for an example.
  *
  * Copyright 2025 Google LLC
  */
+#include <kunit/run-in-irq-context.h>
 #include <kunit/test.h>
-#include <linux/hrtimer.h>
-#include <linux/timekeeping.h>
 #include <linux/vmalloc.h>
-#include <linux/workqueue.h>
 
 /* test_buf is a guarded buffer, i.e. &test_buf[TEST_BUF_LEN] is not mapped. */
 #define TEST_BUF_LEN 16384
 static u8 *test_buf;
 
@@ -317,123 +315,10 @@ static void test_hash_ctx_zeroization(struct kunit *test)
 	HASH_FINAL(&ctx, test_buf);
 	KUNIT_ASSERT_MEMEQ_MSG(test, &ctx, zeroes, sizeof(ctx),
 			       "Hash context was not zeroized by finalization");
 }
 
-#define IRQ_TEST_HRTIMER_INTERVAL us_to_ktime(5)
-
-struct hash_irq_test_state {
-	bool (*func)(void *test_specific_state);
-	void *test_specific_state;
-	bool task_func_reported_failure;
-	bool hardirq_func_reported_failure;
-	bool softirq_func_reported_failure;
-	unsigned long hardirq_func_calls;
-	unsigned long softirq_func_calls;
-	struct hrtimer timer;
-	struct work_struct bh_work;
-};
-
-static enum hrtimer_restart hash_irq_test_timer_func(struct hrtimer *timer)
-{
-	struct hash_irq_test_state *state =
-		container_of(timer, typeof(*state), timer);
-
-	WARN_ON_ONCE(!in_hardirq());
-	state->hardirq_func_calls++;
-
-	if (!state->func(state->test_specific_state))
-		state->hardirq_func_reported_failure = true;
-
-	hrtimer_forward_now(&state->timer, IRQ_TEST_HRTIMER_INTERVAL);
-	queue_work(system_bh_wq, &state->bh_work);
-	return HRTIMER_RESTART;
-}
-
-static void hash_irq_test_bh_work_func(struct work_struct *work)
-{
-	struct hash_irq_test_state *state =
-		container_of(work, typeof(*state), bh_work);
-
-	WARN_ON_ONCE(!in_serving_softirq());
-	state->softirq_func_calls++;
-
-	if (!state->func(state->test_specific_state))
-		state->softirq_func_reported_failure = true;
-}
-
-/*
- * Helper function which repeatedly runs the given @func in task, softirq, and
- * hardirq context concurrently, and reports a failure to KUnit if any
- * invocation of @func in any context returns false.  @func is passed
- * @test_specific_state as its argument.  At most 3 invocations of @func will
- * run concurrently: one in each of task, softirq, and hardirq context.
- *
- * The main purpose of this interrupt context testing is to validate fallback
- * code paths that run in contexts where the normal code path cannot be used,
- * typically due to the FPU or vector registers already being in-use in kernel
- * mode.  These code paths aren't covered when the test code is executed only by
- * the KUnit test runner thread in task context.  The reason for the concurrency
- * is because merely using hardirq context is not sufficient to reach a fallback
- * code path on some architectures; the hardirq actually has to occur while the
- * FPU or vector unit was already in-use in kernel mode.
- *
- * Another purpose of this testing is to detect issues with the architecture's
- * irq_fpu_usable() and kernel_fpu_begin/end() or equivalent functions,
- * especially in softirq context when the softirq may have interrupted a task
- * already using kernel-mode FPU or vector (if the arch didn't prevent that).
- * Crypto functions are often executed in softirqs, so this is important.
- */
-static void run_irq_test(struct kunit *test, bool (*func)(void *),
-			 int max_iterations, void *test_specific_state)
-{
-	struct hash_irq_test_state state = {
-		.func = func,
-		.test_specific_state = test_specific_state,
-	};
-	unsigned long end_jiffies;
-
-	/*
-	 * Set up a hrtimer (the way we access hardirq context) and a work
-	 * struct for the BH workqueue (the way we access softirq context).
-	 */
-	hrtimer_setup_on_stack(&state.timer, hash_irq_test_timer_func,
-			       CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
-	INIT_WORK_ONSTACK(&state.bh_work, hash_irq_test_bh_work_func);
-
-	/* Run for up to max_iterations or 1 second, whichever comes first. */
-	end_jiffies = jiffies + HZ;
-	hrtimer_start(&state.timer, IRQ_TEST_HRTIMER_INTERVAL,
-		      HRTIMER_MODE_REL_HARD);
-	for (int i = 0; i < max_iterations && !time_after(jiffies, end_jiffies);
-	     i++) {
-		if (!func(test_specific_state))
-			state.task_func_reported_failure = true;
-	}
-
-	/* Cancel the timer and work. */
-	hrtimer_cancel(&state.timer);
-	flush_work(&state.bh_work);
-
-	/* Sanity check: the timer and BH functions should have been run. */
-	KUNIT_EXPECT_GT_MSG(test, state.hardirq_func_calls, 0,
-			    "Timer function was not called");
-	KUNIT_EXPECT_GT_MSG(test, state.softirq_func_calls, 0,
-			    "BH work function was not called");
-
-	/* Check for incorrect hash values reported from any context. */
-	KUNIT_EXPECT_FALSE_MSG(
-		test, state.task_func_reported_failure,
-		"Incorrect hash values reported from task context");
-	KUNIT_EXPECT_FALSE_MSG(
-		test, state.hardirq_func_reported_failure,
-		"Incorrect hash values reported from hardirq context");
-	KUNIT_EXPECT_FALSE_MSG(
-		test, state.softirq_func_reported_failure,
-		"Incorrect hash values reported from softirq context");
-}
-
 #define IRQ_TEST_DATA_LEN 256
 #define IRQ_TEST_NUM_BUFFERS 3 /* matches max concurrency level */
 
 struct hash_irq_test1_state {
 	u8 expected_hashes[IRQ_TEST_NUM_BUFFERS][HASH_SIZE];
@@ -467,11 +352,11 @@ static void test_hash_interrupt_context_1(struct kunit *test)
 	rand_bytes(test_buf, IRQ_TEST_NUM_BUFFERS * IRQ_TEST_DATA_LEN);
 	for (int i = 0; i < IRQ_TEST_NUM_BUFFERS; i++)
 		HASH(&test_buf[i * IRQ_TEST_DATA_LEN], IRQ_TEST_DATA_LEN,
 		     state.expected_hashes[i]);
 
-	run_irq_test(test, hash_irq_test1_func, 100000, &state);
+	kunit_run_irq_test(test, hash_irq_test1_func, 100000, &state);
 }
 
 struct hash_irq_test2_hash_ctx {
 	struct HASH_CTX hash_ctx;
 	atomic_t in_use;
@@ -498,11 +383,11 @@ static bool hash_irq_test2_func(void *state_)
 			break;
 	}
 	if (WARN_ON_ONCE(ctx == &state->ctxs[ARRAY_SIZE(state->ctxs)])) {
 		/*
 		 * This should never happen, as the number of contexts is equal
-		 * to the maximum concurrency level of run_irq_test().
+		 * to the maximum concurrency level of kunit_run_irq_test().
 		 */
 		return false;
 	}
 
 	if (ctx->step == 0) {
@@ -564,11 +449,11 @@ static void test_hash_interrupt_context_2(struct kunit *test)
 	}
 	if (remaining)
 		state->update_lens[state->num_steps++] = remaining;
 	state->num_steps += 2; /* for init and final */
 
-	run_irq_test(test, hash_irq_test2_func, 250000, state);
+	kunit_run_irq_test(test, hash_irq_test2_func, 250000, state);
 }
 
 #define UNKEYED_HASH_KUNIT_CASES                     \
 	KUNIT_CASE(test_hash_test_vectors),          \
 	KUNIT_CASE(test_hash_all_lens_up_to_4096),   \
-- 
2.50.1


