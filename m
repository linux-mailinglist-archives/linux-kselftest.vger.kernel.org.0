Return-Path: <linux-kselftest+bounces-41770-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDEFB81F22
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B21EA16315C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3326830CDA4;
	Wed, 17 Sep 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="HSbcU/ZK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4112309EF1;
	Wed, 17 Sep 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144193; cv=none; b=YXX/rPEa4ZFsKKw3F6m8qj3VF0frNmpLulhGBekKHhMgX2DVFFqxVsYqpGuMdvGi1umwL6qc2+iVfKahgWXui7p5oP7dI90oAMT7mv6qJnfH2PT9WYxqKH59qfeFn3o+BvqDI2P4A9TcUfiiBbLVBQRO0GIGPuFxR8s0wJdx5do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144193; c=relaxed/simple;
	bh=fhdKQb6VO8R7Imb/XyuSk3jMs3Hc1FkrvljCoHPL7Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0Tp1TZORRakdBrMSrgJGLxRWcDq4OTVgJH6ObpeFFENNUjjkRq0DCM2fSEQaMfnAuziQq0Twp/W99hXvnsW+nJ3EqWaGAuF6WXwIQ+nMrO8NOgnLugV6KO24exzLAXKzm/hYL3PLBwSxtB6qGWy0P78Ko4p4RrztbOnInhjTI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=HSbcU/ZK; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AvuiaA5LiOdvMlu8qqor+Qnyk1ySyEHQZJxmUxtfM3E=; b=HSbcU/ZK+EpMLgfZv8fghS1UKV
	HHa0Sp1eHTL8AtYsEa4UlFLCH1DM6NHe6yij9a61xOUV7Ke3FxOwMkapq8tfanZMHEfyq8/S3hasr
	6etLvXyQa/sJ+b/dziioBmBG9tXM+N7yimA2o2stdWRkr+bdDx1BUusNJtA9jtiLubVa2aI9JfMEZ
	q5NU4md3zJvu+uh71JdYWd5YQJeA0FaMwOB91a91P4TGpPBR44MatjIFO//tn43vAoh9NSnIOKNTP
	ce+YfxvKnLhXejCYNAFp/KbNEYbgIWliXBLSvAwkqnmbxQcF174LdUNTI8KajaYPMqZCvbEpuq7bu
	ZvlTSktA==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzcJ-00CsMq-HD; Wed, 17 Sep 2025 23:23:07 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:44 -0300
Subject: [PATCH v3 05/15] selftests/futex: Refactor futex_wait_timeout with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-5-306b373c244d@igalia.com>
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

To reduce the boilerplate code, refactor futex_wait_timeout test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../futex/functional/futex_wait_timeout.c          | 139 +++++++++------------
 tools/testing/selftests/futex/functional/run.sh    |   2 +-
 2 files changed, 61 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f878360bcd04c72565510c116808b3e82347..ee01e49b1b3fa62dbad87f80b6937816fcb110ac 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -16,26 +16,15 @@
  *****************************************************************************/
 
 #include <pthread.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
-
-#define TEST_NAME "futex-wait-timeout"
+#include "../../kselftest_harness.h"
 
 static long timeout_ns = 100000;	/* 100us default timeout */
 static futex_t futex_pi;
 static pthread_barrier_t barrier;
 
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -t N	Timeout in nanoseconds (default: 100,000)\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 /*
  * Get a PI lock and hold it forever, so the main thread lock_pi will block
  * and we can test the timeout
@@ -47,13 +36,13 @@ void *get_pi_lock(void *arg)
 
 	ret = futex_lock_pi(&futex_pi, NULL, 0, 0);
 	if (ret != 0)
-		error("futex_lock_pi failed\n", ret);
+		ksft_exit_fail_msg("futex_lock_pi failed\n");
 
 	pthread_barrier_wait(&barrier);
 
 	/* Blocks forever */
 	ret = futex_wait(&lock, 0, NULL, 0);
-	error("futex_wait failed\n", ret);
+	ksft_exit_fail_msg("futex_wait failed\n");
 
 	return NULL;
 }
@@ -61,12 +50,11 @@ void *get_pi_lock(void *arg)
 /*
  * Check if the function returned the expected error
  */
-static void test_timeout(int res, int *ret, char *test_name, int err)
+static void test_timeout(int res, char *test_name, int err)
 {
 	if (!res || errno != err) {
 		ksft_test_result_fail("%s returned %d\n", test_name,
 				      res < 0 ? errno : res);
-		*ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("%s succeeds\n", test_name);
 	}
@@ -78,10 +66,8 @@ static void test_timeout(int res, int *ret, char *test_name, int err)
 static int futex_get_abs_timeout(clockid_t clockid, struct timespec *to,
 				 long timeout_ns)
 {
-	if (clock_gettime(clockid, to)) {
-		error("clock_gettime failed\n", errno);
-		return errno;
-	}
+	if (clock_gettime(clockid, to))
+		ksft_exit_fail_msg("clock_gettime failed\n");
 
 	to->tv_nsec += timeout_ns;
 
@@ -93,83 +79,66 @@ static int futex_get_abs_timeout(clockid_t clockid, struct timespec *to,
 	return 0;
 }
 
-int main(int argc, char *argv[])
+TEST(wait_bitset)
 {
 	futex_t f1 = FUTEX_INITIALIZER;
-	int res, ret = RET_PASS;
 	struct timespec to;
-	pthread_t thread;
-	int c;
-	struct futex_waitv waitv = {
-			.uaddr = (uintptr_t)&f1,
-			.val = f1,
-			.flags = FUTEX_32,
-			.__reserved = 0
-		};
-
-	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
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
-	ksft_set_plan(9);
-	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
-	       basename(argv[0]));
-	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
-
-	pthread_barrier_init(&barrier, NULL, 2);
-	pthread_create(&thread, NULL, get_pi_lock, NULL);
+	int res;
 
 	/* initialize relative timeout */
 	to.tv_sec = 0;
 	to.tv_nsec = timeout_ns;
 
 	res = futex_wait(&f1, f1, &to, 0);
-	test_timeout(res, &ret, "futex_wait relative", ETIMEDOUT);
+	test_timeout(res, "futex_wait relative", ETIMEDOUT);
 
 	/* FUTEX_WAIT_BITSET with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res = futex_wait_bitset(&f1, f1, &to, 1, FUTEX_CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_wait_bitset realtime", ETIMEDOUT);
+	test_timeout(res, "futex_wait_bitset realtime", ETIMEDOUT);
 
 	/* FUTEX_WAIT_BITSET with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res = futex_wait_bitset(&f1, f1, &to, 1, 0);
-	test_timeout(res, &ret, "futex_wait_bitset monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_wait_bitset monotonic", ETIMEDOUT);
+}
+
+TEST(requeue_pi)
+{
+	futex_t f1 = FUTEX_INITIALIZER;
+	struct timespec to;
+	int res;
 
 	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res = futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, FUTEX_CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_wait_requeue_pi realtime", ETIMEDOUT);
+	test_timeout(res, "futex_wait_requeue_pi realtime", ETIMEDOUT);
 
 	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res = futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, 0);
-	test_timeout(res, &ret, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
+
+}
+
+TEST(lock_pi)
+{
+	struct timespec to;
+	pthread_t thread;
+	int res;
+
+	/* Create a thread that will lock forever so any waiter will timeout */
+	pthread_barrier_init(&barrier, NULL, 2);
+	pthread_create(&thread, NULL, get_pi_lock, NULL);
 
 	/* Wait until the other thread calls futex_lock_pi() */
 	pthread_barrier_wait(&barrier);
 	pthread_barrier_destroy(&barrier);
+
 	/*
 	 * FUTEX_LOCK_PI with CLOCK_REALTIME
 	 * Due to historical reasons, FUTEX_LOCK_PI supports only realtime
@@ -181,26 +150,38 @@ int main(int argc, char *argv[])
 	 * smaller than realtime and the syscall will timeout immediately.
 	 */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res = futex_lock_pi(&futex_pi, &to, 0, 0);
-	test_timeout(res, &ret, "futex_lock_pi realtime", ETIMEDOUT);
+	test_timeout(res, "futex_lock_pi realtime", ETIMEDOUT);
 
 	/* Test operations that don't support FUTEX_CLOCK_REALTIME */
 	res = futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
+	test_timeout(res, "futex_lock_pi invalid timeout flag", ENOSYS);
+}
+
+TEST(waitv)
+{
+	futex_t f1 = FUTEX_INITIALIZER;
+	struct timespec to;
+	int res;
+	struct futex_waitv waitv = {
+			.uaddr = (uintptr_t)&f1,
+			.val = f1,
+			.flags = FUTEX_32,
+			.__reserved = 0
+		};
 
 	/* futex_waitv with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
-	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_waitv monotonic", ETIMEDOUT);
 
 	/* futex_waitv with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
-
-	ksft_print_cnts();
-	return ret;
+	test_timeout(res, "futex_waitv realtime", ETIMEDOUT);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 6d48a7ea95cf99ebe6742554eea7dc180cd4c458..0af695038003b1ded7b21959d5f85105282811df 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -41,7 +41,7 @@ echo
 ./futex_requeue_pi_signal_restart
 
 echo
-./futex_wait_timeout $COLOR
+./futex_wait_timeout
 
 echo
 ./futex_wait_wouldblock $COLOR

-- 
2.51.0


