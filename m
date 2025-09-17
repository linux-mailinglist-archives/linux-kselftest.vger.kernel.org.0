Return-Path: <linux-kselftest+bounces-41769-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C01B81F49
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BB717BDC41
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09DC330C607;
	Wed, 17 Sep 2025 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="oMGIwQ+Z"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F65308F31;
	Wed, 17 Sep 2025 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144191; cv=none; b=i3mlcpDOpBlKBGNEbl2K1E+rcsJgpHM7bXQmZK28hIaouV5QCI8MaltX1/4AmGiLLCygcN/h1ivC95H2eNa0AAIddcwVkoytU3x1Ks0BcKmNnmchlnzofBz0bRklvyVIIGNjdWJNyYe6MDtysS6R/ilEOECsstvsP9oEVnLTbbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144191; c=relaxed/simple;
	bh=QcKScPsscDI2xb9rzNMu9xUjmF6yoK783hU/KCdPqVM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DwE2PSm81JMfi6ikKi7Q6rCCKQj9nVYyaz0EaTjtzqvygA2w9XMoEEMUmIRwmC3NrrKv8gtpt0XRAQhehs7d/0Nu0jBqDq8GC3c5Xo0rqqWuc5zeUJPkVHTijpJapJ9meCNY4ykLId6XnKKKVXvUaeJIHhswFqO5I5GDhLGtsdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=oMGIwQ+Z; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YBRa5lKtGFTIEz+vl2GMzX0oxAgdhqK5evDEEsidcuY=; b=oMGIwQ+Zt1b5/v6rS5X5mzqOwm
	FlnMOWv5SrnyMiU9jS8tSf5oufHBH8b2pjyjvx/vYgnoWsKi342/ot4ABlOo8Ty0FDidqwg9+5tU+
	TMF5NQyFWCbDX82mMxPNrekZwCR4zugRzLVKvYz4jGrbtdK+yj2ueSGEatUETm1/8798hbKouGKSd
	/gt0dFC5VIWlWW4X1fVhwY7ExPlKfVs4DDsSnOci4P9w6gZTO0uq5MydrJwtSOIpSnubANCliTccj
	ZAUHC262ooK4FAvzT+HOREmKJ4w5hTyft+5RIQgo6g3ronLSCd7RGv0X+/B9mLxsF7g4F18mx2V4t
	ozt/FzMw==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzcE-00CsMq-6d; Wed, 17 Sep 2025 23:23:02 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:42 -0300
Subject: [PATCH v3 03/15] selftests/futex: Refactor
 futex_requeue_pi_mismatched_ops with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-3-306b373c244d@igalia.com>
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

To reduce the boilerplate code, refactor futex_requeue_pi_mismatched_ops
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../functional/futex_requeue_pi_mismatched_ops.c   | 86 ++++++----------------
 tools/testing/selftests/futex/functional/run.sh    |  2 +-
 2 files changed, 23 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
index d0a4d332ea44131d5e78a4c7d0cd36d36ae468d2..77135a22a583e14c6cb8b897b3596d54db8f8d0f 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
@@ -23,67 +23,32 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "futextest.h"
-#include "logging.h"
 
-#define TEST_NAME "futex-requeue-pi-mismatched-ops"
+#include "futextest.h"
+#include "../../kselftest_harness.h"
 
 futex_t f1 = FUTEX_INITIALIZER;
 futex_t f2 = FUTEX_INITIALIZER;
 int child_ret = 0;
 
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 void *blocking_child(void *arg)
 {
 	child_ret = futex_wait(&f1, f1, NULL, FUTEX_PRIVATE_FLAG);
 	if (child_ret < 0) {
 		child_ret = -errno;
-		error("futex_wait\n", errno);
+		ksft_exit_fail_msg("futex_wait\n");
 	}
 	return (void *)&child_ret;
 }
 
-int main(int argc, char *argv[])
+TEST(requeue_pi_mismatched_ops)
 {
-	int ret = RET_PASS;
 	pthread_t child;
-	int c;
+	int ret;
 
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
-	ksft_print_msg("%s: Detect mismatched requeue_pi operations\n",
-	       basename(argv[0]));
+	if (pthread_create(&child, NULL, blocking_child, NULL))
+		ksft_exit_fail_msg("pthread_create\n");
 
-	if (pthread_create(&child, NULL, blocking_child, NULL)) {
-		error("pthread_create\n", errno);
-		ret = RET_ERROR;
-		goto out;
-	}
 	/* Allow the child to block in the kernel. */
 	sleep(1);
 
@@ -102,34 +67,27 @@ int main(int argc, char *argv[])
 			 * FUTEX_WAKE.
 			 */
 			ret = futex_wake(&f1, 1, FUTEX_PRIVATE_FLAG);
-			if (ret == 1) {
-				ret = RET_PASS;
-			} else if (ret < 0) {
-				error("futex_wake\n", errno);
-				ret = RET_ERROR;
-			} else {
-				error("futex_wake did not wake the child\n", 0);
-				ret = RET_ERROR;
-			}
+			if (ret == 1)
+				ret = 0;
+			else if (ret < 0)
+				ksft_exit_fail_msg("futex_wake\n");
+			else
+				ksft_exit_fail_msg("futex_wake did not wake the child\n");
 		} else {
-			error("futex_cmp_requeue_pi\n", errno);
-			ret = RET_ERROR;
+			ksft_exit_fail_msg("futex_cmp_requeue_pi\n");
 		}
 	} else if (ret > 0) {
-		fail("futex_cmp_requeue_pi failed to detect the mismatch\n");
-		ret = RET_FAIL;
+		ksft_test_result_fail("futex_cmp_requeue_pi failed to detect the mismatch\n");
 	} else {
-		error("futex_cmp_requeue_pi found no waiters\n", 0);
-		ret = RET_ERROR;
+		ksft_exit_fail_msg("futex_cmp_requeue_pi found no waiters\n");
 	}
 
 	pthread_join(child, NULL);
 
-	if (!ret)
-		ret = child_ret;
-
- out:
-	/* If the kernel crashes, we shouldn't return at all. */
-	print_result(TEST_NAME, ret);
-	return ret;
+	if (!ret && !child_ret)
+		ksft_test_result_pass("futex_requeue_pi_mismatched_ops passed\n");
+	else
+		ksft_test_result_pass("futex_requeue_pi_mismatched_ops failed\n");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index d34e2235ac10d2a02831a6269e8d9b693f57a6e9..cc1b743668a2084922c892d2924ef0ebb46386e4 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -35,7 +35,7 @@ echo
 ./futex_requeue_pi
 
 echo
-./futex_requeue_pi_mismatched_ops $COLOR
+./futex_requeue_pi_mismatched_ops
 
 echo
 ./futex_requeue_pi_signal_restart $COLOR

-- 
2.51.0


