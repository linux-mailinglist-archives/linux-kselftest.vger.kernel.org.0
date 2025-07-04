Return-Path: <linux-kselftest+bounces-36587-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E933FAF9643
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D733D1CA7571
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863B1309A64;
	Fri,  4 Jul 2025 15:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="g+GBOnHa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6EE4309A41;
	Fri,  4 Jul 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641550; cv=none; b=fVv3ktFdhZrgDl8GKabcpDvi+2x1a3gOb3rEt7kVrX3ARdN19BMZ5pKeSLbwFHKYRmLbB7r0W7ZlSa8dP4ud/JyoK1SeKOBA6XUAj0mKCof+g+JI22E6al5iBAcCUufO3bJmh9PQ1J4fTbd7KlwAOwyqV3uux/rJKiL/8BHshPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641550; c=relaxed/simple;
	bh=/FLp9Qe+fb+AJI4kLii+i9V8yYUqq8zGZ//5px20r/A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Wa/AhRMjVJeaz5pO/fh4lToKToCjBVvi7lGot24uJeshs/doWiQfYGJdq13RSSl3U0B6tDy8ZcmqiYPze0/vlfoYO1fnfj4GZF2/FkvtqUuKVvf8tD/JUps2EBCnSGGogfq9Ge1kHPz5XakqXCo/k3oLqFlPMTv04Lvs50tEnaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=g+GBOnHa; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MZTI4WF4Tz8d+DEIyJQ4A8TYNIg+KdLeZ7NA6TNm+pk=; b=g+GBOnHacOATMT439lS7qmuZXA
	6DCC7OD1h60aCkWvosevi041yn53eFRkIj0xOlXPCc0R1BbAaLYRn/pnq0WHLmG2MdvlOShaoEOL/
	Y5PjxTf7DNv7UOsXolnBYPvfIhIp/sIzWvR+XFFo7LUNc1Bffl7pAek9YPATrNx3uhY2DvkpYrBK5
	Yvf4EezFp3LQAkzWm+5uQdqMrUsLIQcabsimjqgyWc6ZWmrAtupmsVlXzgsFJU5RXykIcCdNZZJxE
	iWQO6U0D2os+ug+XbAzeffrjQjumFFkUiDCKzcN8B9NVMqxRkn9TtCjP1Q5kl32Gq2FZrVib4Rq+0
	kg3ryBXw==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhz0-00CTWt-Ql; Fri, 04 Jul 2025 17:05:47 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:12 -0300
Subject: [PATCH 08/15] selftests/futex: Refactor
 futex_wait_private_mapped_file with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-8-c0ff4f24c4e1@igalia.com>
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

To reduce the boilerplate code, refactor futex_wait_private_mapped_file
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../functional/futex_wait_private_mapped_file.c    | 83 ++++++----------------
 tools/testing/selftests/futex/functional/run.sh    |  2 +-
 2 files changed, 21 insertions(+), 64 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
index fb4148f23fa3722cb9c464e188b2747516534dbb..8952ebda14ab8a54d67be4cf36dd2913dbf3c403 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c
@@ -27,10 +27,9 @@
 #include <libgen.h>
 #include <signal.h>
 
-#include "logging.h"
 #include "futextest.h"
+#include "../../kselftest_harness.h"
 
-#define TEST_NAME "futex-wait-private-mapped-file"
 #define PAGE_SZ 4096
 
 char pad[PAGE_SZ] = {1};
@@ -40,86 +39,44 @@ char pad2[PAGE_SZ] = {1};
 #define WAKE_WAIT_US 3000000
 struct timespec wait_timeout = { .tv_sec = 5, .tv_nsec = 0};
 
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *thr_futex_wait(void *arg)
 {
 	int ret;
 
-	info("futex wait\n");
+	ksft_print_dbg_msg("futex wait\n");
 	ret = futex_wait(&val, 1, &wait_timeout, 0);
-	if (ret && errno != EWOULDBLOCK && errno != ETIMEDOUT) {
-		error("futex error.\n", errno);
-		print_result(TEST_NAME, RET_ERROR);
-		exit(RET_ERROR);
-	}
+	if (ret && errno != EWOULDBLOCK && errno != ETIMEDOUT)
+		ksft_exit_fail_msg("futex error.\n");
 
 	if (ret && errno == ETIMEDOUT)
-		fail("waiter timedout\n");
+		ksft_exit_fail_msg("waiter timedout\n");
 
-	info("futex_wait: ret = %d, errno = %d\n", ret, errno);
+	ksft_print_dbg_msg("futex_wait: ret = %d, errno = %d\n", ret, errno);
 
 	return NULL;
 }
 
-int main(int argc, char **argv)
+TEST(wait_private_mapped_file)
 {
 	pthread_t thr;
-	int ret = RET_PASS;
 	int res;
-	int c;
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
-	ksft_print_msg(
-		"%s: Test the futex value of private file mappings in FUTEX_WAIT\n",
-		basename(argv[0]));
-
-	ret = pthread_create(&thr, NULL, thr_futex_wait, NULL);
-	if (ret < 0) {
-		fprintf(stderr, "pthread_create error\n");
-		ret = RET_ERROR;
-		goto out;
-	}
-
-	info("wait a while\n");
+
+	res = pthread_create(&thr, NULL, thr_futex_wait, NULL);
+	if (res < 0)
+		ksft_exit_fail_msg("pthread_create error\n");
+
+	ksft_print_dbg_msg("wait a while\n");
 	usleep(WAKE_WAIT_US);
 	val = 2;
 	res = futex_wake(&val, 1, 0);
-	info("futex_wake %d\n", res);
-	if (res != 1) {
-		fail("FUTEX_WAKE didn't find the waiting thread.\n");
-		ret = RET_FAIL;
-	}
+	ksft_print_dbg_msg("futex_wake %d\n", res);
+	if (res != 1)
+		ksft_exit_fail_msg("FUTEX_WAKE didn't find the waiting thread.\n");
 
-	info("join\n");
+	ksft_print_dbg_msg("join\n");
 	pthread_join(thr, NULL);
 
- out:
-	print_result(TEST_NAME, ret);
-	return ret;
+	ksft_test_result_pass("wait_private_mapped_file");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index a93eb2a21d4aa23f874bf11ccc852838a4c3866f..2b3409d2513ea6b2c29efbcbdedfedd525f64151 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -48,7 +48,7 @@ echo
 
 echo
 ./futex_wait_uninitialized_heap
-./futex_wait_private_mapped_file $COLOR
+./futex_wait_private_mapped_file
 
 echo
 ./futex_wait $COLOR

-- 
2.49.0


