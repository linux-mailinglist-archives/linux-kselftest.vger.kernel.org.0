Return-Path: <linux-kselftest+bounces-36582-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFDBAF963A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:06:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36DB37B33A9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0732D8DC8;
	Fri,  4 Jul 2025 15:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="RUs38z5f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73772D77E6;
	Fri,  4 Jul 2025 15:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641540; cv=none; b=sFlwS1QZ+/VVvXUlahbC7vsX7+vq1wZiC9dqFmM+7+RKVoYDKp2Sq4QVoxWl7nKYcFcfQ3tdc2ljh9Ln9LZz1TE+Erp30vAG5XllO7Ev/94BFLW7i6/n6hJjVEoudI2twHbwl1w5PPNYwDg/ZZ44EkU6pDR0RfPZcxyMC3e+eQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641540; c=relaxed/simple;
	bh=hbKqNRayFt4LIIrZhEVvzb9r70LNdGzAbESZORhU2/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVL5xRR3o4hxSLREnAjmPFBGaLfxXPW4tskKR819SO0sRMFqiZzbv7r2xtyLK9Dt7G2lE2b/ENDcVSYsHgHVXVFHv2gDK5Orec95A7oVdKN4a2+7q7Dz1tnWnj3DUzYP+0JVNdhtcrxj3Oeh8Jqi504nFW2zI1d8ZvGYSRp4keQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=RUs38z5f; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=VREAvdW2dJm/U4tSDAEKh5HsiNV3L70v/2/QV6VXkT8=; b=RUs38z5fE2kts+6doWwTtJ4/XF
	oOtlsGhF3Gk/HVX/8yBte6G7+SgG3M8hnpFHhz8amyawrZ9gwrq/sLl+m3kp+hJK8SRUBTrWnms8h
	ye3h+X0w0yGOzyi7LZAjhwZB41vEPO6HYAW2Y8eQ5PY64bkQLheziZAZIjtLxex+N/HVpRCqf3Oz+
	hFKCk214bjpLhFmALZ2Di2Le6DrkYJRtC91WBHl11EhGLgrZWjonkkZxRVfexpANj4AsDvicJOUuI
	i6Odi7L8QLvqKCAzQ6eRnZbaoJtFQTw8bKonjJ05ndn2DhYX9hbUFtd+vAK6Yh8J6gVLn7055AqeO
	YNU6YOYA==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhyn-00CTWt-EV; Fri, 04 Jul 2025 17:05:33 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:07 -0300
Subject: [PATCH 03/15] selftests/futex: Refactor
 futex_requeue_pi_mismatched_ops with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-3-c0ff4f24c4e1@igalia.com>
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

To reduce the boilerplate code, refactor futex_requeue_pi_mismatched_ops
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../functional/futex_requeue_pi_mismatched_ops.c   | 80 +++++-----------------
 tools/testing/selftests/futex/functional/run.sh    |  2 +-
 2 files changed, 19 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c
index d0a4d332ea44131d5e78a4c7d0cd36d36ae468d2..a956fdf931b3b50b25ed71d9034a5f1a5001f77e 100644
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
 
@@ -102,34 +67,25 @@ int main(int argc, char *argv[])
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
+				ksft_test_result_pass("pass");
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
 
 	if (!ret)
 		ret = child_ret;
-
- out:
-	/* If the kernel crashes, we shouldn't return at all. */
-	print_result(TEST_NAME, ret);
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 49edfad884869c7dffce2f482c434003b9cc49d1..f9d598ef43ec3fb7580ab59bf6fc70b6ecd8a82d 100755
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
2.49.0


