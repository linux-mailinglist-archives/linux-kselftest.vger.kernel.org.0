Return-Path: <linux-kselftest+bounces-41768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0BFB81F16
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C81A1C242C2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE4330BF5C;
	Wed, 17 Sep 2025 21:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AXzDHrt9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161221B9FD;
	Wed, 17 Sep 2025 21:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144191; cv=none; b=TV8Q2CK0tG3ee4lAvvL+hmp3sbId6+s/olwH0Xvbfc1DhAklKYSm+yhdBjqjYPECf/ku3U2XvmrdLZOkskvahHXtAAIGPbRDgYBFRO3NVRncUizNXmFv5s+A52FpC4K1wphNhmO8ZcKJRC4GXR17a8/rtQ8WdSwmarRGouqMeas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144191; c=relaxed/simple;
	bh=f9UuDQoyQy31BebDk25RTNCu6CBN4ceqbKacykEOwqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhferZsH4uYuAfpxZJ3SWxYqLhwS9ce+4NXmjIdLF/g+WX44Z5q5mQ+Y2PVMQ3hWJIV2SA1SuVJQy+is+1B95CqD5Dv87AXTQ2AbBlKLD/giBdnyBsKe8MNR3mD6Y/iGRy3V4SRzQUVeqvUMPotu3no0Ll2Yi6++tgjnxnMaB0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AXzDHrt9; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Z8W3ktmBFJoP8I1oZuSZL7jSz6wBbJQ9KdkBibsArVI=; b=AXzDHrt948JpedRSu5YQkZBVop
	I2z3CXrnS4D53rO4Hho3lGXo+D+icC5aPPl8YQwvPd7RnW0/Rv+3H9eQuiRmoa4bAM4hWYliFLWxl
	VHv3eiiExoFCInTNPnjrrKgdku1fu3bBueTJZP+danlG73aVqUW85VwUXgiAZ3f/AlevJ2aPamDGl
	F6DSHYcgEHA4l5MSdMSYQZWjLwXPsBdUGrYxTwgbVyfwG5lVqygToIpbYjZrwOvdTJ3zjSwkU7gHL
	9c2SXRTfPn/DOHf4RdpNx3b7LuljXVg2ZXoZk0NqP5lvAeD1h9fUmMrnE9sozu9i0286/ywP957qg
	FA9YU8nQ==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzcB-00CsMq-BB; Wed, 17 Sep 2025 23:22:59 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:41 -0300
Subject: [PATCH v3 02/15] selftests/futex: Refactor futex_requeue_pi with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-2-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-0-306b373c244d@igalia.com>
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-0-306b373c244d@igalia.com>
To: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

To reduce the boilerplate code, refactor futex_requeue_pi test to use
kselftest_harness header instead of futex's logging header.

Use kselftest fixture feature to make it easy to repeat the same test
with different parameters. With that, drop all repetitive test calls
from run.sh.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_requeue_pi.c  | 261 ++++++++++-----------
 tools/testing/selftests/futex/functional/run.sh    |  26 +-
 2 files changed, 122 insertions(+), 165 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 215c6cb539b4abc7a48fb00b545ae26e52fd118a..699642f08a5d1324984ca94082cb040c04a97496 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -26,11 +26,11 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <string.h>
+
 #include "atomic.h"
 #include "futextest.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
 
-#define TEST_NAME "futex-requeue-pi"
 #define MAX_WAKE_ITERS 1000
 #define THREAD_MAX 10
 #define SIGNAL_PERIOD_US 100
@@ -42,12 +42,6 @@ futex_t f1 = FUTEX_INITIALIZER;
 futex_t f2 = FUTEX_INITIALIZER;
 futex_t wake_complete = FUTEX_INITIALIZER;
 
-/* Test option defaults */
-static long timeout_ns;
-static int broadcast;
-static int owner;
-static int locked;
-
 struct thread_arg {
 	long id;
 	struct timespec *timeout;
@@ -56,18 +50,73 @@ struct thread_arg {
 };
 #define THREAD_ARG_INITIALIZER { 0, NULL, 0, 0 }
 
-void usage(char *prog)
+FIXTURE(args)
 {
-	printf("Usage: %s\n", prog);
-	printf("  -b	Broadcast wakeup (all waiters)\n");
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -l	Lock the pi futex across requeue\n");
-	printf("  -o	Use a third party pi futex owner during requeue (cancels -l)\n");
-	printf("  -t N	Timeout in nanoseconds (default: 0)\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
+};
+
+FIXTURE_SETUP(args)
+{
+};
+
+FIXTURE_TEARDOWN(args)
+{
+};
+
+FIXTURE_VARIANT(args)
+{
+	long timeout_ns;
+	bool broadcast;
+	bool owner;
+	bool locked;
+};
+
+/*
+ * For a given timeout value, this macro creates a test input with all the
+ * possible combinations of valid arguments
+ */
+#define FIXTURE_VARIANT_ADD_TIMEOUT(timeout)		\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout)			\
+{							\
+	.timeout_ns = timeout,				\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast)	\
+{							\
+	.timeout_ns = timeout,				\
+	.broadcast = true,				\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast_locked) \
+{							\
+	.timeout_ns = timeout,				\
+	.broadcast = true,				\
+	.locked = true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast_owner) \
+{							\
+	.timeout_ns = timeout,				\
+	.broadcast = true,				\
+	.owner = true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_locked)		\
+{							\
+	.timeout_ns = timeout,				\
+	.locked = true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_owner)		\
+{							\
+	.timeout_ns = timeout,				\
+	.owner = true,					\
+};							\
+
+FIXTURE_VARIANT_ADD_TIMEOUT(0);
+FIXTURE_VARIANT_ADD_TIMEOUT(5000);
+FIXTURE_VARIANT_ADD_TIMEOUT(500000);
+FIXTURE_VARIANT_ADD_TIMEOUT(2000000000);
 
 int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 		     int policy, int prio)
@@ -81,26 +130,26 @@ int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 
 	ret = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
 	if (ret) {
-		error("pthread_attr_setinheritsched\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setinheritsched\n");
 		return -1;
 	}
 
 	ret = pthread_attr_setschedpolicy(&attr, policy);
 	if (ret) {
-		error("pthread_attr_setschedpolicy\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setschedpolicy\n");
 		return -1;
 	}
 
 	schedp.sched_priority = prio;
 	ret = pthread_attr_setschedparam(&attr, &schedp);
 	if (ret) {
-		error("pthread_attr_setschedparam\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setschedparam\n");
 		return -1;
 	}
 
 	ret = pthread_create(pth, &attr, func, arg);
 	if (ret) {
-		error("pthread_create\n", ret);
+		ksft_exit_fail_msg("pthread_create\n");
 		return -1;
 	}
 	return 0;
@@ -112,7 +161,7 @@ void *waiterfn(void *arg)
 	struct thread_arg *args = (struct thread_arg *)arg;
 	futex_t old_val;
 
-	info("Waiter %ld: running\n", args->id);
+	ksft_print_dbg_msg("Waiter %ld: running\n", args->id);
 	/* Each thread sleeps for a different amount of time
 	 * This is to avoid races, because we don't lock the
 	 * external mutex here */
@@ -120,26 +169,25 @@ void *waiterfn(void *arg)
 
 	old_val = f1;
 	atomic_inc(&waiters_blocked);
-	info("Calling futex_wait_requeue_pi: %p (%u) -> %p\n",
+	ksft_print_dbg_msg("Calling futex_wait_requeue_pi: %p (%u) -> %p\n",
 	     &f1, f1, &f2);
 	args->ret = futex_wait_requeue_pi(&f1, old_val, &f2, args->timeout,
 					  FUTEX_PRIVATE_FLAG);
 
-	info("waiter %ld woke with %d %s\n", args->id, args->ret,
+	ksft_print_dbg_msg("waiter %ld woke with %d %s\n", args->id, args->ret,
 	     args->ret < 0 ? strerror(errno) : "");
 	atomic_inc(&waiters_woken);
 	if (args->ret < 0) {
 		if (args->timeout && errno == ETIMEDOUT)
 			args->ret = 0;
 		else {
-			args->ret = RET_ERROR;
-			error("futex_wait_requeue_pi\n", errno);
+			ksft_exit_fail_msg("futex_wait_requeue_pi\n");
 		}
 		futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 	}
 	futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
 
-	info("Waiter %ld: exiting with %d\n", args->id, args->ret);
+	ksft_print_dbg_msg("Waiter %ld: exiting with %d\n", args->id, args->ret);
 	pthread_exit((void *)&args->ret);
 }
 
@@ -152,14 +200,14 @@ void *broadcast_wakerfn(void *arg)
 	int nr_wake = 1;
 	int i = 0;
 
-	info("Waker: waiting for waiters to block\n");
+	ksft_print_dbg_msg("Waker: waiting for waiters to block\n");
 	while (waiters_blocked.val < THREAD_MAX)
 		usleep(1000);
 	usleep(1000);
 
-	info("Waker: Calling broadcast\n");
+	ksft_print_dbg_msg("Waker: Calling broadcast\n");
 	if (args->lock) {
-		info("Calling FUTEX_LOCK_PI on mutex=%x @ %p\n", f2, &f2);
+		ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on mutex=%x @ %p\n", f2, &f2);
 		futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 	}
  continue_requeue:
@@ -167,16 +215,14 @@ void *broadcast_wakerfn(void *arg)
 	args->ret = futex_cmp_requeue_pi(&f1, old_val, &f2, nr_wake, nr_requeue,
 				   FUTEX_PRIVATE_FLAG);
 	if (args->ret < 0) {
-		args->ret = RET_ERROR;
-		error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
+		ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
 	} else if (++i < MAX_WAKE_ITERS) {
 		task_count += args->ret;
 		if (task_count < THREAD_MAX - waiters_woken.val)
 			goto continue_requeue;
 	} else {
-		error("max broadcast iterations (%d) reached with %d/%d tasks woken or requeued\n",
-		       0, MAX_WAKE_ITERS, task_count, THREAD_MAX);
-		args->ret = RET_ERROR;
+		ksft_exit_fail_msg("max broadcast iterations (%d) reached with %d/%d tasks woken or requeued\n",
+		       MAX_WAKE_ITERS, task_count, THREAD_MAX);
 	}
 
 	futex_wake(&wake_complete, 1, FUTEX_PRIVATE_FLAG);
@@ -187,7 +233,7 @@ void *broadcast_wakerfn(void *arg)
 	if (args->ret > 0)
 		args->ret = task_count;
 
-	info("Waker: exiting with %d\n", args->ret);
+	ksft_print_dbg_msg("Waker: exiting with %d\n", args->ret);
 	pthread_exit((void *)&args->ret);
 }
 
@@ -200,20 +246,20 @@ void *signal_wakerfn(void *arg)
 	int nr_wake = 1;
 	int i = 0;
 
-	info("Waker: waiting for waiters to block\n");
+	ksft_print_dbg_msg("Waker: waiting for waiters to block\n");
 	while (waiters_blocked.val < THREAD_MAX)
 		usleep(1000);
 	usleep(1000);
 
 	while (task_count < THREAD_MAX && waiters_woken.val < THREAD_MAX) {
-		info("task_count: %d, waiters_woken: %d\n",
+		ksft_print_dbg_msg("task_count: %d, waiters_woken: %d\n",
 		     task_count, waiters_woken.val);
 		if (args->lock) {
-			info("Calling FUTEX_LOCK_PI on mutex=%x @ %p\n",
-			     f2, &f2);
+			ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on mutex=%x @ %p\n",
+			    f2, &f2);
 			futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 		}
-		info("Waker: Calling signal\n");
+		ksft_print_dbg_msg("Waker: Calling signal\n");
 		/* cond_signal */
 		old_val = f1;
 		args->ret = futex_cmp_requeue_pi(&f1, old_val, &f2,
@@ -221,28 +267,23 @@ void *signal_wakerfn(void *arg)
 						 FUTEX_PRIVATE_FLAG);
 		if (args->ret < 0)
 			args->ret = -errno;
-		info("futex: %x\n", f2);
+		ksft_print_dbg_msg("futex: %x\n", f2);
 		if (args->lock) {
-			info("Calling FUTEX_UNLOCK_PI on mutex=%x @ %p\n",
-			     f2, &f2);
+			ksft_print_dbg_msg("Calling FUTEX_UNLOCK_PI on mutex=%x @ %p\n",
+			    f2, &f2);
 			futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
 		}
-		info("futex: %x\n", f2);
-		if (args->ret < 0) {
-			error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
-			args->ret = RET_ERROR;
-			break;
-		}
+		ksft_print_dbg_msg("futex: %x\n", f2);
+		if (args->ret < 0)
+			ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
 
 		task_count += args->ret;
 		usleep(SIGNAL_PERIOD_US);
 		i++;
 		/* we have to loop at least THREAD_MAX times */
 		if (i > MAX_WAKE_ITERS + THREAD_MAX) {
-			error("max signaling iterations (%d) reached, giving up on pending waiters.\n",
-			      0, MAX_WAKE_ITERS + THREAD_MAX);
-			args->ret = RET_ERROR;
-			break;
+			ksft_exit_fail_msg("max signaling iterations (%d) reached, giving up on pending waiters.\n",
+			      MAX_WAKE_ITERS + THREAD_MAX);
 		}
 	}
 
@@ -251,8 +292,8 @@ void *signal_wakerfn(void *arg)
 	if (args->ret >= 0)
 		args->ret = task_count;
 
-	info("Waker: exiting with %d\n", args->ret);
-	info("Waker: waiters_woken: %d\n", waiters_woken.val);
+	ksft_print_dbg_msg("Waker: exiting with %d\n", args->ret);
+	ksft_print_dbg_msg("Waker: waiters_woken: %d\n", waiters_woken.val);
 	pthread_exit((void *)&args->ret);
 }
 
@@ -269,15 +310,13 @@ void *third_party_blocker(void *arg)
 	ret2 = futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
 
  out:
-	if (args->ret || ret2) {
-		error("third_party_blocker() futex error", 0);
-		args->ret = RET_ERROR;
-	}
+	if (args->ret || ret2)
+		ksft_exit_fail_msg("third_party_blocker() futex error");
 
 	pthread_exit((void *)&args->ret);
 }
 
-int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
+TEST_F(args, futex_requeue_pi)
 {
 	void *(*wakerfn)(void *) = signal_wakerfn;
 	struct thread_arg blocker_arg = THREAD_ARG_INITIALIZER;
@@ -286,18 +325,26 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 	struct timespec ts, *tsp = NULL;
 	struct thread_arg args[THREAD_MAX];
 	int *waiter_ret;
-	int i, ret = RET_PASS;
+	int i, ret = 0;
+	bool lock = variant->locked;
+	bool third_party_owner = variant->owner;
+	bool broadcast = variant->broadcast;
+	long timeout_ns = variant->timeout_ns;
+
+	ksft_print_msg(
+		"\tArguments: broadcast=%d locked=%d owner=%d timeout=%ldns\n",
+		broadcast, lock, third_party_owner, timeout_ns);
 
 	if (timeout_ns) {
 		time_t secs;
 
-		info("timeout_ns = %ld\n", timeout_ns);
+		ksft_print_dbg_msg("timeout_ns = %ld\n", timeout_ns);
 		ret = clock_gettime(CLOCK_MONOTONIC, &ts);
 		secs = (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec = ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec += secs;
-		info("ts.tv_sec  = %ld\n", ts.tv_sec);
-		info("ts.tv_nsec = %ld\n", ts.tv_nsec);
+		ksft_print_dbg_msg("ts.tv_sec  = %ld\n", ts.tv_sec);
+		ksft_print_dbg_msg("ts.tv_nsec = %ld\n", ts.tv_nsec);
 		tsp = &ts;
 	}
 
@@ -307,10 +354,7 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 	if (third_party_owner) {
 		if (create_rt_thread(&blocker, third_party_blocker,
 				     (void *)&blocker_arg, SCHED_FIFO, 1)) {
-			error("Creating third party blocker thread failed\n",
-			      errno);
-			ret = RET_ERROR;
-			goto out;
+			ksft_exit_fail_msg("Creating third party blocker thread failed\n");
 		}
 	}
 
@@ -318,20 +362,16 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 	for (i = 0; i < THREAD_MAX; i++) {
 		args[i].id = i;
 		args[i].timeout = tsp;
-		info("Starting thread %d\n", i);
+		ksft_print_dbg_msg("Starting thread %d\n", i);
 		if (create_rt_thread(&waiter[i], waiterfn, (void *)&args[i],
 				     SCHED_FIFO, 1)) {
-			error("Creating waiting thread failed\n", errno);
-			ret = RET_ERROR;
-			goto out;
+			ksft_exit_fail_msg("Creating waiting thread failed\n");
 		}
 	}
 	waker_arg.lock = lock;
 	if (create_rt_thread(&waker, wakerfn, (void *)&waker_arg,
 			     SCHED_FIFO, 1)) {
-		error("Creating waker thread failed\n", errno);
-		ret = RET_ERROR;
-		goto out;
+		ksft_exit_fail_msg("Creating waker thread failed\n");
 	}
 
 	/* Wait for threads to finish */
@@ -345,7 +385,6 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 		pthread_join(blocker, NULL);
 	pthread_join(waker, NULL);
 
-out:
 	if (!ret) {
 		if (*waiter_ret)
 			ret = *waiter_ret;
@@ -355,66 +394,8 @@ int unit_test(int broadcast, long lock, int third_party_owner, long timeout_ns)
 			ret = blocker_arg.ret;
 	}
 
-	return ret;
+	if (ret)
+		ksft_test_result_fail("fail");
 }
 
-int main(int argc, char *argv[])
-{
-	char *test_name;
-	int c, ret;
-
-	while ((c = getopt(argc, argv, "bchlot:v:")) != -1) {
-		switch (c) {
-		case 'b':
-			broadcast = 1;
-			break;
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'l':
-			locked = 1;
-			break;
-		case 'o':
-			owner = 1;
-			locked = 0;
-			break;
-		case 't':
-			timeout_ns = atoi(optarg);
-			break;
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
-	ksft_print_msg("%s: Test requeue functionality\n", basename(argv[0]));
-	ksft_print_msg(
-		"\tArguments: broadcast=%d locked=%d owner=%d timeout=%ldns\n",
-		broadcast, locked, owner, timeout_ns);
-
-	ret = asprintf(&test_name,
-		       "%s broadcast=%d locked=%d owner=%d timeout=%ldns",
-		       TEST_NAME, broadcast, locked, owner, timeout_ns);
-	if (ret < 0) {
-		ksft_print_msg("Failed to generate test name\n");
-		test_name = TEST_NAME;
-	}
-
-	/*
-	 * FIXME: unit_test is obsolete now that we parse options and the
-	 * various style of runs are done by run.sh - simplify the code and move
-	 * unit_test into main()
-	 */
-	ret = unit_test(broadcast, locked, owner, timeout_ns);
-
-	print_result(test_name, ret);
-	return ret;
-}
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 5470088dc4dfb6bdbf713afeeb18d999b8ddf506..d34e2235ac10d2a02831a6269e8d9b693f57a6e9 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -32,31 +32,7 @@ fi
 
 
 echo
-# requeue pi testing
-# without timeouts
-./futex_requeue_pi $COLOR
-./futex_requeue_pi $COLOR -b
-./futex_requeue_pi $COLOR -b -l
-./futex_requeue_pi $COLOR -b -o
-./futex_requeue_pi $COLOR -l
-./futex_requeue_pi $COLOR -o
-# with timeouts
-./futex_requeue_pi $COLOR -b -l -t 5000
-./futex_requeue_pi $COLOR -l -t 5000
-./futex_requeue_pi $COLOR -b -l -t 500000
-./futex_requeue_pi $COLOR -l -t 500000
-./futex_requeue_pi $COLOR -b -t 5000
-./futex_requeue_pi $COLOR -t 5000
-./futex_requeue_pi $COLOR -b -t 500000
-./futex_requeue_pi $COLOR -t 500000
-./futex_requeue_pi $COLOR -b -o -t 5000
-./futex_requeue_pi $COLOR -l -t 5000
-./futex_requeue_pi $COLOR -b -o -t 500000
-./futex_requeue_pi $COLOR -l -t 500000
-# with long timeout
-./futex_requeue_pi $COLOR -b -l -t 2000000000
-./futex_requeue_pi $COLOR -l -t 2000000000
-
+./futex_requeue_pi
 
 echo
 ./futex_requeue_pi_mismatched_ops $COLOR

-- 
2.51.0


