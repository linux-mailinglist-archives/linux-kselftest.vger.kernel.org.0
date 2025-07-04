Return-Path: <linux-kselftest+bounces-36583-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AADABAF9639
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DD901CA6A02
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BA332F234E;
	Fri,  4 Jul 2025 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="V+A9LfeI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF522D7812;
	Fri,  4 Jul 2025 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641541; cv=none; b=TaX1crRNHiJ/22MMXEVSEFCgJ4qJ+UVY33nDUx3BUm7+y8qsmU0/2XSQv6H9p9BAR2wxRLv4/90tDXtRn5+tgEa42+2LtGzfcXjjVCvBc277diddFBaXMl/mkrb+xIJXBnkE9cHLXZHKTj9CCCcC6kUbpGZS6bViSLXijH3O7oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641541; c=relaxed/simple;
	bh=V3tMoIJp/NTXTgwMUmtavU/XTfr+PVu/hBgU2sjou64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mvQfmOtfcbNdVbGWkZ8thvfKBjDnaDsAyqKqZ98AT0yUhk6UvRJNRkXrrcjbh9fu3ZpKGL36QJENLQJTIaxbsS94WFfXn8BEyceN3tGMrA0JtUik6iqBRfzJIhK5Y8cXIo8mlT9nLdn7/Ma3HzsVfZpAFy/2yWhZ4j4UBYEtIlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=V+A9LfeI; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lity6QYpYzE34cdd1wQik8MA/JHn0N3eCxfewvB4jD4=; b=V+A9LfeI4/55mA2qK8Y15yce7t
	ixsBCF7s1Hb6FS8QQtg5BMhNw2lYTreIJFdclmeOEOMixTOq7n2w5IPsXqA4ncVx7FvYDWmNpJ2Lo
	nRlQHwX9v8NZAdURre6sopaTSAnoY+qMpSxLY3/feLv67ZIFboNLzjJgocew6XVhMJ400Ir9iIQdb
	kiEHO80ARE5qRlB0jjK4RUBz1/7wmFNsr+RBXV1t1XH8wwyvKovMEUMJGru6+xm+Xv2pHxIuDU5xu
	SYCpVg6eXTNXSSEw9Uya0etBMYAVpXVBTWqmAwGyuO2lj7eYqre0TSVB3NFtCNy+096W5uFUeARW3
	cQESitmg==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhyq-00CTWt-4G; Fri, 04 Jul 2025 17:05:36 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:08 -0300
Subject: [PATCH 04/15] selftests/futex: Refactor
 futex_requeue_pi_signal_restart with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-4-c0ff4f24c4e1@igalia.com>
References: <20250704-tonyk-robust_test_cleanup-v1-0-c0ff4f24c4e1@igalia.com>
In-Reply-To: <20250704-tonyk-robust_test_cleanup-v1-0-c0ff4f24c4e1@igalia.com>
To: Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

To reduce the boilerplate code, refactor futex_requeue_pi_signal_restart
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../functional/futex_requeue_pi_signal_restart.c   | 129 ++++++---------------
 tools/testing/selftests/futex/functional/run.sh    |   2 +-
 2 files changed, 38 insertions(+), 93 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
index c6b8f32990c87587551b14577b200e62c56af223..e34ee0f9ebccdb2cd2984e48acf157245b12848f 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
@@ -24,11 +24,11 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+
 #include "atomic.h"
 #include "futextest.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
 
-#define TEST_NAME "futex-requeue-pi-signal-restart"
 #define DELAY_US 100
 
 futex_t f1 = FUTEX_INITIALIZER;
@@ -37,15 +37,6 @@ atomic_t requeued = ATOMIC_INITIALIZER;
 
 int waiter_ret = 0;
 
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 		     int policy, int prio)
 {
@@ -57,35 +48,28 @@ int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 	memset(&schedp, 0, sizeof(schedp));
 
 	ret = pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
-	if (ret) {
-		error("pthread_attr_setinheritsched\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setinheritsched\n");
 
 	ret = pthread_attr_setschedpolicy(&attr, policy);
-	if (ret) {
-		error("pthread_attr_setschedpolicy\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setschedpolicy\n");
 
 	schedp.sched_priority = prio;
 	ret = pthread_attr_setschedparam(&attr, &schedp);
-	if (ret) {
-		error("pthread_attr_setschedparam\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setschedparam\n");
 
 	ret = pthread_create(pth, &attr, func, arg);
-	if (ret) {
-		error("pthread_create\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_create\n");
+
 	return 0;
 }
 
 void handle_signal(int signo)
 {
-	info("signal received %s requeue\n",
+	ksft_print_dbg_msg("signal received %s requeue\n",
 	     requeued.val ? "after" : "prior to");
 }
 
@@ -94,78 +78,46 @@ void *waiterfn(void *arg)
 	unsigned int old_val;
 	int res;
 
-	waiter_ret = RET_PASS;
-
-	info("Waiter running\n");
-	info("Calling FUTEX_LOCK_PI on f2=%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("Waiter running\n");
+	ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on f2=%x @ %p\n", f2, &f2);
 	old_val = f1;
 	res = futex_wait_requeue_pi(&f1, old_val, &(f2), NULL,
 				    FUTEX_PRIVATE_FLAG);
 	if (!requeued.val || errno != EWOULDBLOCK) {
-		fail("unexpected return from futex_wait_requeue_pi: %d (%s)\n",
+		ksft_test_result_fail("unexpected return from futex_wait_requeue_pi: %d (%s)\n",
 		     res, strerror(errno));
-		info("w2:futex: %x\n", f2);
+		ksft_print_dbg_msg("w2:futex: %x\n", f2);
 		if (!res)
 			futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
-		waiter_ret = RET_FAIL;
 	}
 
-	info("Waiter exiting with %d\n", waiter_ret);
 	pthread_exit(NULL);
 }
 
 
-int main(int argc, char *argv[])
+TEST(futex_requeue_pi_signal_restart)
 {
 	unsigned int old_val;
 	struct sigaction sa;
 	pthread_t waiter;
-	int c, res, ret = RET_PASS;
-
-	while ((c = getopt(argc, argv, "chv:")) != -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
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
-	ksft_print_msg("%s: Test signal handling during requeue_pi\n",
-	       basename(argv[0]));
-	ksft_print_msg("\tArguments: <none>\n");
+	int res;
 
 	sa.sa_handler = handle_signal;
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags = 0;
-	if (sigaction(SIGUSR1, &sa, NULL)) {
-		error("sigaction\n", errno);
-		exit(1);
-	}
+	if (sigaction(SIGUSR1, &sa, NULL))
+		ksft_exit_fail_msg("sigaction\n");
 
-	info("m1:f2: %x\n", f2);
-	info("Creating waiter\n");
+	ksft_print_dbg_msg("m1:f2: %x\n", f2);
+	ksft_print_dbg_msg("Creating waiter\n");
 	res = create_rt_thread(&waiter, waiterfn, NULL, SCHED_FIFO, 1);
-	if (res) {
-		error("Creating waiting thread failed", res);
-		ret = RET_ERROR;
-		goto out;
-	}
+	if (res)
+		ksft_exit_fail_msg("Creating waiting thread failed");
 
-	info("Calling FUTEX_LOCK_PI on f2=%x @ %p\n", f2, &f2);
-	info("m2:f2: %x\n", f2);
+	ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on f2=%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("m2:f2: %x\n", f2);
 	futex_lock_pi(&f2, 0, 0, FUTEX_PRIVATE_FLAG);
-	info("m3:f2: %x\n", f2);
+	ksft_print_dbg_msg("m3:f2: %x\n", f2);
 
 	while (1) {
 		/*
@@ -173,11 +125,11 @@ int main(int argc, char *argv[])
 		 * restart futex_wait_requeue_pi() in the kernel. Wait for the
 		 * waiter to block on f1 again.
 		 */
-		info("Issuing SIGUSR1 to waiter\n");
+		ksft_print_dbg_msg("Issuing SIGUSR1 to waiter\n");
 		pthread_kill(waiter, SIGUSR1);
 		usleep(DELAY_US);
 
-		info("Requeueing waiter via FUTEX_CMP_REQUEUE_PI\n");
+		ksft_print_dbg_msg("Requeueing waiter via FUTEX_CMP_REQUEUE_PI\n");
 		old_val = f1;
 		res = futex_cmp_requeue_pi(&f1, old_val, &(f2), 1, 0,
 					   FUTEX_PRIVATE_FLAG);
@@ -191,12 +143,10 @@ int main(int argc, char *argv[])
 			atomic_set(&requeued, 1);
 			break;
 		} else if (res < 0) {
-			error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
-			ret = RET_ERROR;
-			break;
+			ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
 		}
 	}
-	info("m4:f2: %x\n", f2);
+	ksft_print_dbg_msg("m4:f2: %x\n", f2);
 
 	/*
 	 * Signal the waiter after requeue, waiter should return from
@@ -204,19 +154,14 @@ int main(int argc, char *argv[])
 	 * futex_unlock_pi() can't happen before the signal wakeup is detected
 	 * in the kernel.
 	 */
-	info("Issuing SIGUSR1 to waiter\n");
+	ksft_print_dbg_msg("Issuing SIGUSR1 to waiter\n");
 	pthread_kill(waiter, SIGUSR1);
-	info("Waiting for waiter to return\n");
+	ksft_print_dbg_msg("Waiting for waiter to return\n");
 	pthread_join(waiter, NULL);
 
-	info("Calling FUTEX_UNLOCK_PI on mutex=%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("Calling FUTEX_UNLOCK_PI on mutex=%x @ %p\n", f2, &f2);
 	futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
-	info("m5:f2: %x\n", f2);
-
- out:
-	if (ret == RET_PASS && waiter_ret)
-		ret = waiter_ret;
-
-	print_result(TEST_NAME, ret);
-	return ret;
+	ksft_print_dbg_msg("m5:f2: %x\n", f2);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index f9d598ef43ec3fb7580ab59bf6fc70b6ecd8a82d..37f614e7d7fd3ce9741861e23df40f87139f572a 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -38,7 +38,7 @@ echo
 ./futex_requeue_pi_mismatched_ops
 
 echo
-./futex_requeue_pi_signal_restart $COLOR
+./futex_requeue_pi_signal_restart
 
 echo
 ./futex_wait_timeout $COLOR

-- 
2.49.0


