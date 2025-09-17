Return-Path: <linux-kselftest+bounces-41772-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27CC9B81F37
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF85F1C8102C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A771830E848;
	Wed, 17 Sep 2025 21:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="AUHPOuWO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D130DEDE;
	Wed, 17 Sep 2025 21:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144196; cv=none; b=OdNMax0C3VsyZ5T5AK1PwqffRWVMo1pzJNkn7+Oz6yvddQcjXqNydwm4hhq0K1U+X+9htaVKJFutKE896ubC0JMe0DHurodIQ5dO2UMETE0jpR+Jckrs+kPZtuc12GSrzukWOr1l+qG3Acw/qDOold4EKRHGXQijsDnR/kof4II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144196; c=relaxed/simple;
	bh=R5bbOqu7x7+VfI2zKLqbDs3llrzwOH+WVmtrmpKZjTg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P4pIb58m12Xsgfrwm7FgTnVqFLuVo1le3WBj3S5GqFKUPRt2f8uxCIc7eI7+bs5zDbm4rVOrB6gUdFoO2hr9NJxEa+lkIJH+hFU4CDjb07CYepa1KP74z8ep/fN3zMrlXQbEjWt/H4uWS/JSi3C7a4sWw1TNIEaAdJ3xwXqQQqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=AUHPOuWO; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=zCuAdZH8G1qwE3dLa8tXiZYqF+iuHs/dUS3ryVm4b0Y=; b=AUHPOuWO2qzf4JfQEGow1x9xWO
	gXwjLdM9GOdngQZy3YpiMqTjtgVmR3XDpA6q2SeFGdUeMa38c+PyFZQBudJmMMidU8jvGrzRbeTfs
	Zil9jVt1VLZ0S7NaRPZeBxuHAETG2qrRTWoeLniycp76GvHQpNbT1pCRcXEMhBMkcA/lIr9zlbSJQ
	6FuUQCMdfWXzNDCuSixJqmr36MuKqdAKMnZkrCE9ClTyexOeuGHufWEE3mllAl1TjWrOZ+pvpH/rx
	YaE8IuwDD4BqY4U78Pi5Wv87f6VwlKJBATEIg8MUAevpWCIRZVfTuE/r2ZMk+uKFIXEtraJXLSlOF
	1pC7tvkw==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzcO-00CsMq-Rs; Wed, 17 Sep 2025 23:23:13 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:46 -0300
Subject: [PATCH v3 07/15] selftests/futex: Refactor
 futex_wait_unitialized_heap with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-7-306b373c244d@igalia.com>
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
index a5246d59849853bb70ecf836f0520053cf1fee76..6cb07a4e760d2afc1f4c6b64e570c580ab332ea4 100755
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
2.51.0


