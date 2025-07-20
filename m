Return-Path: <linux-kselftest+bounces-37724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B56A3B0B8CB
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:31:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D846E189AC0A
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13E223B639;
	Sun, 20 Jul 2025 22:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g6eBC7QE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83E923B61E;
	Sun, 20 Jul 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050579; cv=none; b=FMQeEzzH6qxxb7HPIwCQNyNDqV1HTcti/UefFzw2HmGxB3A+2Kg+10NgQInqVAjZhr11m7howmVvaQdj8VnK/OxbKr+VKPiOQIouhU5sOvhaGAkXhXxDmMI9Nm0RAoxAUrzYNWLDMFyLaWDH8bXAfY9zy1UT/FJMTMiRgX8UV9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050579; c=relaxed/simple;
	bh=OybeR1myFyoB4x5YG3GAdLDedA44UoChI1YMVz8OcGg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eaRsyF6MKCIRIssx1RBLMHf2OltN+HiEkuC9YWiKU1ysywOc7cMnOIuCdVB0NEGwm4iUPvMmpK8R2zuc4QTQ8aJAc2b2j7V0GlAxn7nKaCVC3tZQmj0YCR+bipLqT+v7hc9SEV7bc14cAS4u0Px7iEnJJwCKgEX9cXXjGpInoKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g6eBC7QE; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wer4C1qkdvsHfGK/a4LGf0Xmv0gVuhcd2JmJHGNiEBU=; b=g6eBC7QEDU7bGPFvvZSarf4cAz
	MYyWUs9M+dgnnuFJo291ZJQreKoUIU4GPDoFQfsPOHVfez22gMrg6Ag/4OkEMFsax5tb7XSr7AOmW
	QFhXS8T4bT50Az/dXmWoP0MiXQJSyRcUUVxzlHuEOfbID/PfR7vgHz3PgiYIZs2udBCm+g7j8Cfwp
	iNdLYK9oQ0perQcP5HPu/9HiPN084hRlZkQqYhWuo46sOi5+R3epiEAiBgOP92d2d8vEnpdtkY3Pd
	mXLxMFMQtEIm2NLanbK1HdBZA8UY/iJUhgVJwumcsBsXKD2YU5IKn2YScBLOcjzQmD56mnztq66s5
	yvXheUaA==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcXH-001Sqt-Nh; Mon, 21 Jul 2025 00:29:35 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:29:09 -0300
Subject: [PATCH v2 11/15] selftests/futex: Refactor futex_waitv with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-11-1f9bcb5b7294@igalia.com>
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

To reduce the boilerplate code, refactor futex_waitv test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_waitv.c       | 98 ++++++++++------------
 tools/testing/selftests/futex/functional/run.sh    |  2 +-
 2 files changed, 44 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e181544992efd53891ccca02787adb..8ceaa372b2524fe243400c50382a142a30e61159 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -15,25 +15,16 @@
 #include <pthread.h>
 #include <stdint.h>
 #include <sys/shm.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
 
-#define TEST_NAME "futex-wait"
 #define WAKE_WAIT_US 10000
 #define NR_FUTEXES 30
 static struct futex_waitv waitv[NR_FUTEXES];
 u_int32_t futexes[NR_FUTEXES] = {0};
 
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *waiterfn(void *arg)
 {
 	struct timespec to;
@@ -41,7 +32,7 @@ void *waiterfn(void *arg)
 
 	/* setting absolute timeout for futex2 */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
 
 	to.tv_sec++;
 
@@ -57,34 +48,10 @@ void *waiterfn(void *arg)
 	return NULL;
 }
 
-int main(int argc, char *argv[])
+TEST(private_waitv)
 {
 	pthread_t waiter;
-	int res, ret = RET_PASS;
-	struct timespec to;
-	int c, i;
-
-	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
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
-	ksft_set_plan(7);
-	ksft_print_msg("%s: Test FUTEX_WAITV\n",
-		       basename(argv[0]));
+	int res, i;
 
 	for (i = 0; i < NR_FUTEXES; i++) {
 		waitv[i].uaddr = (uintptr_t)&futexes[i];
@@ -95,7 +62,7 @@ int main(int argc, char *argv[])
 
 	/* Private waitv */
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
 
 	usleep(WAKE_WAIT_US);
 
@@ -104,10 +71,15 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv private\n");
 	}
+}
+
+TEST(shared_waitv)
+{
+	pthread_t waiter;
+	int res, i;
 
 	/* Shared waitv */
 	for (i = 0; i < NR_FUTEXES; i++) {
@@ -128,7 +100,7 @@ int main(int argc, char *argv[])
 	}
 
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
 
 	usleep(WAKE_WAIT_US);
 
@@ -137,19 +109,24 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake shared returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv shared\n");
 	}
 
 	for (i = 0; i < NR_FUTEXES; i++)
 		shmdt(u64_to_ptr(waitv[i].uaddr));
+}
+
+TEST(invalid_flag)
+{
+	struct timespec to;
+	int res;
 
 	/* Testing a waiter without FUTEX_32 flag */
 	waitv[0].flags = FUTEX_PRIVATE_FLAG;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
 
 	to.tv_sec++;
 
@@ -158,17 +135,21 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv without FUTEX_32\n");
 	}
+}
 
+TEST(unaligned_address)
+{
+	struct timespec to;
+	int res;
 	/* Testing a waiter with an unaligned address */
 	waitv[0].flags = FUTEX_PRIVATE_FLAG | FUTEX_32;
 	waitv[0].uaddr = 1;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
 
 	to.tv_sec++;
 
@@ -177,16 +158,21 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv with an unaligned address\n");
 	}
+}
+
+TEST(null_address)
+{
+	struct timespec to;
+	int res;
 
 	/* Testing a NULL address for waiters.uaddr */
 	waitv[0].uaddr = 0x00000000;
 
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
 
 	to.tv_sec++;
 
@@ -195,14 +181,13 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv NULL address in waitv.uaddr\n");
 	}
 
 	/* Testing a NULL address for *waiters */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
 
 	to.tv_sec++;
 
@@ -211,14 +196,19 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv NULL address in *waiters\n");
 	}
+}
+
+TEST(invalid_clockid)
+{
+	struct timespec to;
+	int res;
 
 	/* Testing an invalid clockid */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
 
 	to.tv_sec++;
 
@@ -227,11 +217,9 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv invalid clockid\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index af32695cfaded4f834c7c07c24908b8a3e32fe28..6086b5652687af3cd2d4e4bd56159149d5bb5fea 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -57,7 +57,7 @@ echo
 ./futex_requeue
 
 echo
-./futex_waitv $COLOR
+./futex_waitv
 
 echo
 ./futex_priv_hash $COLOR

-- 
2.50.1


