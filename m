Return-Path: <linux-kselftest+bounces-37717-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEA09B0B8BC
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B0181780B1
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7A323643E;
	Sun, 20 Jul 2025 22:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="YChU1kYL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C38B23312D;
	Sun, 20 Jul 2025 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050561; cv=none; b=GZ88WdOEbAfNNlFX/Ky9Pl2RSZVMgbPR8qaXVwD2lxp0bHqEW5OADRvaW/5uqMUKfH7rNChiWaLIv8YeyckswDRX0T3stk0MhYUSXg9fCksovo8+SRL8ojbLgZXIohNhinID23PEyVIaXRX5nNIZQpU2jXN1+4CdcECQYmRDjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050561; c=relaxed/simple;
	bh=NAFtMi4HOaBXasa53kfsaFuY2W3Fi+/xTHO8TA9ukxM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gobn6xR0zitdc0WJRQQVf68AEn0Au7jcETu94B9jeZXCFiziTjqS21CymTOSofkUOqdl5zsDVU6GMFJmgBhbXxXHwq8xSzvk4E+y50McIbC5yg0smV7I3m/LuNGRRkRPt8OVbt5tLUuWqSDomvG/axDPur0sW4CwuIEK+vYHA4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=YChU1kYL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=dCIPcUQOibPJvjFq027dSw36gw4uzcmr7o//8TawR2E=; b=YChU1kYLpEKOW1g0te+6DxgQMI
	qEBtAR/VZNMaKWQuz/ye69sEb5WrJZmzdS3c+TVg04kgj1awJbE5QGXB1JmsNmvD0dQCJiMn8A3zj
	tRhJY1+6sCkPCWG5RUdhbnt/Nf0z6EQLNSriLYadYp00n6OZcUzy/tK+81sWMpgiJSY1Nw7EwdniA
	0+Tjw58NsV9SQrz2BaXn9SVMV3MpPpjmZHHNk2T9r1YIT7pRs2oiD5BxdlRZdvg4srGQ4/pUZnXAJ
	daGktrc5HJMz79KwplSOlFW80xRVw1cwBva76T54aY/m0L5Xnvm1X7B7EsqXDz5ncC5nlPENn1W0O
	+lEnpwlA==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcWz-001Sqt-4H; Mon, 21 Jul 2025 00:29:17 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:29:02 -0300
Subject: [PATCH v2 04/15] selftests/futex: Refactor
 futex_requeue_pi_signal_restart with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-4-1f9bcb5b7294@igalia.com>
References: <20250720-tonyk-robust_test_cleanup-v2-0-1f9bcb5b7294@igalia.com>
In-Reply-To: <20250720-tonyk-robust_test_cleanup-v2-0-1f9bcb5b7294@igalia.com>
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
2.50.1


