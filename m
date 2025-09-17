Return-Path: <linux-kselftest+bounces-41775-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753CEB81F46
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D10F4A6F57
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F4430FC07;
	Wed, 17 Sep 2025 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Wpfa1xo8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF65D309EFD;
	Wed, 17 Sep 2025 21:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144204; cv=none; b=Ntmm9rNfBFj1H/qv8Ccqozs7/JCcBr2hJGWl+SO0SIUbR205kgNyh3KNE/fi+hGOSl8Q7sg/6xQEsN6tteN5SgUgDIHk2FFOBHIMov5Dqmo/Ul5eWGOX7ONYy35WX84binmNxi3TZrDOLb3em+66RMYXooVfCHeW2Q5p2EvQDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144204; c=relaxed/simple;
	bh=uS3dbnC3NrbXI7F1dj1yv6NaCZ/zVYoh4g/a2rU9hHo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVXjmRrzXASswsFc/qgj84XC4WUrfoptB9e3kWGZ4V/E0ZSeFc9jDa+Mw0qttTDtLmaezW/IgYsNSf+m/iS/mMawl8me8uYXjJqj+tek3KEnZmIVnND/TdQz3fac105bRH50JDNV6/LBlEBsekzxMNVLBCekswJnpSe0Vf+YLtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Wpfa1xo8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=wYGvXCHxPME7E3qzOBcv2+2mOppjBtMJtbwHb9S+cro=; b=Wpfa1xo8NQyJPY1JyPvmBcA0x+
	6LYWgA/Xf6P8kge+xKhx/JZoumESzCLSARcQQddS8oe/Sd9VZbPsjh9rKzj1KbiWO7UECs6E0HMnL
	Fa6gaNPezDQ+UiP+5rhfkfoWhGoif5KNZph9RKRgGS3I4AKP/IHYzh+Am4AJC++P8ZHDdAxDiGUAI
	iXCW4G1ZxmmWHaYjJtkudbHJsiDa4fhpYtbaoH5CVyRzKnxEH+lMWti4WXmu/pmu6g+R32Ivo9kWR
	eXWoJjSw4SBS7I/FppGby/+uX0i0Tjqzt8rm/w7bdrNlftavdfle1CHHKfDpX6175L2pxriXPbUn9
	EiyYR4eQ==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzcW-00CsMq-Re; Wed, 17 Sep 2025 23:23:21 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:49 -0300
Subject: [PATCH v3 10/15] selftests/futex: Refactor futex_requeue with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-10-306b373c244d@igalia.com>
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
index 1ce0f20cadfcc33e2d58f53e14c36bb8cf30b870..b711351a10ec8a3607538ab22ef838031738da7a 100755
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
2.51.0


