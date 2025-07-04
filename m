Return-Path: <linux-kselftest+bounces-36584-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0DAAF963B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:06:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488825A7105
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229F0302048;
	Fri,  4 Jul 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="NCXjXNK6"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171452DE710;
	Fri,  4 Jul 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641543; cv=none; b=ZFE7yzGozu4rX4FTxl66Q7X2bCV3hbtCUKoZ7du3aRYgJ3vLIHsrJqaALX4TmMdo5Ad/2ugiB+0YvluxZMnhYbtxo/BvVEhTNL7Cmnk1DTv1YbUhPkdXlK19Cc7sh4frLKSRSYwHAOmg3eTrKF/VNfKjCXBqPYBHT1v4+KkeGq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641543; c=relaxed/simple;
	bh=Wg4yy5y9MyYHmyF5L8tl3PEUJZrQ24Vqqu7zaLgmnEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L21n49gPOBRTOOAb1S0r6KhLS0fbyOQaeyCC3fZnRnCI9tAZkdqTxfPxzjqtNWvpC5V7la2ofaVbA9VaXTWTEs0xQ1q9WF7I38ZL3iqg90cSc5proMRsbVvtszjWulDdzO+Oj9lZpbc5OVZMtjtfiDZtwSzGtXRemFVyKEKC+XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=NCXjXNK6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=c6WEnVGf8U+FfRf9MBqFGKJNZ0FWJUy70Io4K0h5Lg4=; b=NCXjXNK6uk49/iOiHRCq+eUG/Y
	gdxllzfTrLeI9J3ob1CYg0IaLVFCotmc5mYZMI+JbyFRq89lllXc7kX5JjcVwUtCIOBZGFjyQU3PY
	RqtIkyID7XgW0+YZoxWe34kMnv1QhlRewv8X2yz62jahUoZxh/12Q6AWHGu+vph4OWt8hl/y3WVKC
	vHbZPx/G7dKgQ5XCdV2LJ3yMCoYRqp3ZopL0Qz5B2h3JVR1TVrtruHyi1RU/0C0/toZVoKqIXQZvj
	6whp3eO9mchEXdN/7liRlT1mrbeOBjhsRkVfS9Uwm2SL1CVrOic/tmgZPPdq+kzEmo6ReIXXsgavB
	eM4Txy5g==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhys-00CTWt-Pv; Fri, 04 Jul 2025 17:05:38 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:09 -0300
Subject: [PATCH 05/15] selftests/futex: Refactor futex_wait_timeout with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-5-c0ff4f24c4e1@igalia.com>
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
index 37f614e7d7fd3ce9741861e23df40f87139f572a..d42a8f4cf0a3d4361fd9d1196cb385a3ae38a04a 100755
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
2.49.0


