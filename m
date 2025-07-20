Return-Path: <linux-kselftest+bounces-37723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E060BB0B8C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:31:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 416DB189A27D
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FB023AE66;
	Sun, 20 Jul 2025 22:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iXnSNwfq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F07A22FF39;
	Sun, 20 Jul 2025 22:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050577; cv=none; b=YxV9nqtqf9CZ2jtIMN7GlyVyBCkYWjHYp3Q7WxlRzQDk82K1WOBqVecxDAbNROZNn797ijts7i6nftBhZ2kdJDFuKDGoEQOfIUo2tJoFKXzfhJy5l4J3x9KzXi05s2WlcclGn2zSzXq7S7+Y+J1RdMStu26hahGXYqpMRc1a0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050577; c=relaxed/simple;
	bh=TXLQ/IykZSSL5TH8H5naRsVU9mkeDMtXunJ47IToAIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JlwsXgpDcQpB3DOirqlq8kgHHaCq7fq5+4ypRX1cKLMPU9Modfiq0jSX+6AUIisMttAcG9eLtRsOmavUXDUhPf+DV2HLomNJzLENCQM9wHfMnrn7663vIkP/Y2QZ5QdiuJfEsyob6oRzY68nnv+1jmY7Of+4TXJE7qONO63vZmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iXnSNwfq; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Ozq35aUnU2ktYvk+zYuA7uRopjj2PZLiGFrXbotNjWU=; b=iXnSNwfqXI4Ig7YmDk9cldGtOy
	jW+oW02MXYsJRl6IBoZ/sDsRjAz4G8SRTJCK1Y+4f+iNHDN3kJ7NXqcD77uoz6++D7fBZTyIYVpFQ
	RJ1EhWAoxPeCOWz/oSg7ktYWNvyZc1jRpvRwcerU/kLa/5/Qr5VJNu++7x95Ok05UplZWnWbXw5m6
	dstLn9gO5G3LcXo/3Lz7ZdehMX9lePGIUnOBVUprxq7o3CSPQYpHGKzBiXXRS2Qmx0vccKdKpReiB
	xYOwcOzrdUO3orLbKmBsSDaRTcjq754bjVo9KV+AfKn/HfGZxDVHFnAxdJISFeHjhsikYo/UG84tD
	0ikqoV+A==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcXF-001Sqt-2Z; Mon, 21 Jul 2025 00:29:33 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:29:08 -0300
Subject: [PATCH v2 10/15] selftests/futex: Refactor futex_requeue with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-10-1f9bcb5b7294@igalia.com>
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

To reduce the boilerplate code, refactor futex_requeue test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_requeue.c     | 76 +++++++---------------
 tools/testing/selftests/futex/functional/run.sh    |  2 +-
 2 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 51485be6eb2f1be6d0e30bc26c116515a0e5e7cc..69e2555b60399174a16ee1316b0b7d2e10419989 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -7,24 +7,15 @@
 
 #include <pthread.h>
 #include <limits.h>
-#include "logging.h"
+
 #include "futextest.h"
+#include "../../kselftest_harness.h"
 
-#define TEST_NAME "futex-requeue"
 #define timeout_ns  30000000
 #define WAKE_WAIT_US 10000
 
 volatile futex_t *f1;
 
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
@@ -38,67 +29,49 @@ void *waiterfn(void *arg)
 	return NULL;
 }
 
-int main(int argc, char *argv[])
+TEST(requeue_single)
 {
-	pthread_t waiter[10];
-	int res, ret = RET_PASS;
-	int c, i;
 	volatile futex_t _f1 = 0;
 	volatile futex_t f2 = 0;
+	pthread_t waiter[10];
+	int res;
 
 	f1 = &_f1;
 
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
-	ksft_set_plan(2);
-	ksft_print_msg("%s: Test futex_requeue\n",
-		       basename(argv[0]));
-
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
 	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
 
 	usleep(WAKE_WAIT_US);
 
-	info("Requeuing 1 futex from f1 to f2\n");
+	ksft_print_dbg_msg("Requeuing 1 futex from f1 to f2\n");
 	res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
-	if (res != 1) {
+	if (res != 1)
 		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
-	}
 
-
-	info("Waking 1 futex at f2\n");
+	ksft_print_dbg_msg("Waking 1 futex at f2\n");
 	res = futex_wake(&f2, 1, 0);
 	if (res != 1) {
 		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_requeue simple succeeds\n");
 	}
+}
+
+TEST(requeue_multiple)
+{
+	volatile futex_t _f1 = 0;
+	volatile futex_t f2 = 0;
+	pthread_t waiter[10];
+	int res, i;
 
+	f1 = &_f1;
 
 	/*
 	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
@@ -106,31 +79,28 @@ int main(int argc, char *argv[])
 	 */
 	for (i = 0; i < 10; i++) {
 		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
-			error("pthread_create failed\n", errno);
+			ksft_exit_fail_msg("pthread_create failed\n");
 	}
 
 	usleep(WAKE_WAIT_US);
 
-	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
+	ksft_print_dbg_msg("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
 	res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
 	if (res != 10) {
 		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	}
 
-	info("Waking INT_MAX futexes at f2\n");
+	ksft_print_dbg_msg("Waking INT_MAX futexes at f2\n");
 	res = futex_wake(&f2, INT_MAX, 0);
 	if (res != 7) {
 		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_requeue many succeeds\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index b461a0a075a2ae526d37a1fcd09e196e48c2d4ff..af32695cfaded4f834c7c07c24908b8a3e32fe28 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -54,7 +54,7 @@ echo
 ./futex_wait
 
 echo
-./futex_requeue $COLOR
+./futex_requeue
 
 echo
 ./futex_waitv $COLOR

-- 
2.50.1


