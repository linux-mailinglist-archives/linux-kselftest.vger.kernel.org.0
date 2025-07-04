Return-Path: <linux-kselftest+bounces-36586-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DBB8DAF9641
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFB3A1CA6CF7
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9CC3093DB;
	Fri,  4 Jul 2025 15:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="O+qKuisz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A380307AF3;
	Fri,  4 Jul 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641548; cv=none; b=Etkxsa8fzRmi+H9CCrp9CCr82bWP00qwwmq8gCIhlHkBLuj9e2sO2obtHj2lZk6RFeb8bILUDctsLn8wRiPGXQXsxBWJ22rUwrzmb1j8cnva7NbICn50xStxPSUOliDZZvWOBe0JStH7AT4onnl2asQM3rx6rHs/LGmPISy4oTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641548; c=relaxed/simple;
	bh=5Pvjh50WQyx5/gMeQSfj7awWgdJbbPO6FFu59gX9q1w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B4Tk5uZmmggu6myaesRlt5L54FkBkNMWBxs3Fppvda5KnCz8qbELCVbajjljEjbZ+qOjo1nhSK1L+neval+GxVzLPJKHtAJAEaX35ix4eZ2v0vAwGVeXyu1fudH+0dke5zY6kk+kCsGPoE3SmpjClYQcFsbFR/3/fr7DebqL1l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=O+qKuisz; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=u6gK7oLhQiOEvzO1qG23okxcLQZxtVgiVb9V1xWsQnY=; b=O+qKuiszMuacHmOYryQ4hrzebk
	tBRIDM0DH606/KO4SY9y0PsQTYvePZH6M0EW+QeovH/sRv0G8s/UzfmE/UTnETPkbrjTup9s9OMg1
	/ge8H3Htd+5xVRCrjL8uYv8/tCmJh5SqGldExBF1H017uNMFZaefBbz57+X/Wxtk3XZd1ran1inZJ
	Bynwrvas0kGcC76beiU5+ixnuu+nAgb69NdZo7HVO0K68VR3YqhmizGUp6yGc5EN1UzDcuBnylnqs
	18+/YzzY7qKp5IA7rNUTxdjeru8RVRxEBeySqhFf2PCbDA0DjnEp2IlgoGUfMbgRxD2EvvypfbHQ9
	td7Mj78Q==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhyy-00CTWt-5A; Fri, 04 Jul 2025 17:05:44 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:11 -0300
Subject: [PATCH 07/15] selftests/futex: Refactor
 futex_wait_unitialized_heap with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-7-c0ff4f24c4e1@igalia.com>
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

To reduce the boilerplate code, refactor futex_wait_unitialized_heap
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../functional/futex_wait_uninitialized_heap.c     | 76 +++++-----------------
 tools/testing/selftests/futex/functional/run.sh    |  2 +-
 2 files changed, 19 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
index ed9cd07e31c1a980bb505bb97617282411b6085a..ce2301500d839ca7b2d527ab4e072b9f00d1146a 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
@@ -29,95 +29,55 @@
 #include <linux/futex.h>
 #include <libgen.h>
 
-#include "logging.h"
 #include "futextest.h"
+#include "../../kselftest_harness.h"
 
-#define TEST_NAME "futex-wait-uninitialized-heap"
 #define WAIT_US 5000000
 
 static int child_blocked = 1;
-static int child_ret;
+static bool child_ret;
 void *buf;
 
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *wait_thread(void *arg)
 {
 	int res;
 
-	child_ret = RET_PASS;
+	child_ret = true;
 	res = futex_wait(buf, 1, NULL, 0);
 	child_blocked = 0;
 
 	if (res != 0 && errno != EWOULDBLOCK) {
-		error("futex failure\n", errno);
-		child_ret = RET_ERROR;
+		ksft_exit_fail_msg("futex failure\n");
+		child_ret = false;
 	}
 	pthread_exit(NULL);
 }
 
-int main(int argc, char **argv)
+TEST(futex_wait_uninitialized_heap)
 {
-	int c, ret = RET_PASS;
 	long page_size;
 	pthread_t thr;
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
+	int ret;
 
 	page_size = sysconf(_SC_PAGESIZE);
 
 	buf = mmap(NULL, page_size, PROT_READ|PROT_WRITE,
 		   MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
-	if (buf == (void *)-1) {
-		error("mmap\n", errno);
-		exit(1);
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
-	ksft_print_msg("%s: Test the uninitialized futex value in FUTEX_WAIT\n",
-	       basename(argv[0]));
-
+	if (buf == (void *)-1)
+		ksft_exit_fail_msg("mmap\n");
 
 	ret = pthread_create(&thr, NULL, wait_thread, NULL);
-	if (ret) {
-		error("pthread_create\n", errno);
-		ret = RET_ERROR;
-		goto out;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_create\n");
 
-	info("waiting %dus for child to return\n", WAIT_US);
+	ksft_print_dbg_msg("waiting %dus for child to return\n", WAIT_US);
 	usleep(WAIT_US);
 
-	ret = child_ret;
-	if (child_blocked) {
-		fail("child blocked in kernel\n");
-		ret = RET_FAIL;
-	}
+	if (child_blocked)
+		ksft_test_result_fail("child blocked in kernel\n");
 
- out:
-	print_result(TEST_NAME, ret);
-	return ret;
+	if (!child_ret)
+		ksft_test_result_fail("child error\n");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 4a4fe9891f1ef8d69bb968a3a2be6c7dccd3575f..a93eb2a21d4aa23f874bf11ccc852838a4c3866f 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -47,7 +47,7 @@ echo
 ./futex_wait_wouldblock
 
 echo
-./futex_wait_uninitialized_heap $COLOR
+./futex_wait_uninitialized_heap
 ./futex_wait_private_mapped_file $COLOR
 
 echo

-- 
2.49.0


