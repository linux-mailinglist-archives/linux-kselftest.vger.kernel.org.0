Return-Path: <linux-kselftest+bounces-41771-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FAE1B81F29
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8C84A4B30
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2E8130DD20;
	Wed, 17 Sep 2025 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="EddLs+xZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E49730C620;
	Wed, 17 Sep 2025 21:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144193; cv=none; b=mGDg6ek4AYS3eV9j9HLYLddv9WmISGToCP4HAVtwSOefY9P5aUvZQBErBpAVoHSy3umXLrbhRzICiVqzMUCd1IKzPaUPjgOwAIolDLA/6hyi+DsCA73CQgUzYyPpEURPXG67c2YWZtWr8HH6IvMKnqnfJtnQry7oir2keTb8nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144193; c=relaxed/simple;
	bh=vJBF7xnyH6eY+Ij59jETYymm0hpvX6bnTNxb0Syzueo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AGwuDZ8H5G/u9Wgg1s7+CMYt6XUS/rXMyatRBsipP2vV588cEGJKZ4qsnCZtj6FP9GKPxJg4PsOgdVU5Rn0bwR4PwEIC5lUZetFpPI8NYcqj4EXWygqNCll6zw1KfMk7CnvlRxMD/AY7q94kuSPAo2hYyxOpp+qKnm7WdK2hBtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=EddLs+xZ; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=BU9FnS6Oehk7szHXJ/JJaYmuuyjtZYFzwkh2Du3BYF8=; b=EddLs+xZCKLgL+hfXosYhhAP0a
	0oYROtG3OEH9N8GaI/MOTmporUzN9Psf1Jg5rrmDIpUIHNoniejHCSuGc8B32/GjmlqC48vHRxekP
	Vm8Ogo77+exRIPDhMY6EZvpMUI3CfjaWciBvlJeHpD9+Avb0B/y1b0ZdlPCvIddLvgWEAUehQskIn
	gAOPcNhndlecIgbPTnFzd4tmCFfIKXfmLpP+WENlIxdlWsrQw6HVUPx+rFJhGG1/fcGpsuNfv1YUO
	LR0Z0Xf00OBH/NliBsDzDA9nBpjZVWlCI0D7dNSdkBDElTQW36B+l31/HpZRqT2OqtSHHJSKnDMN/
	aZBHoA2A==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzcM-00CsMq-6R; Wed, 17 Sep 2025 23:23:10 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:45 -0300
Subject: [PATCH v3 06/15] selftests/futex: Refactor futex_wait_wouldblock
 with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-6-306b373c244d@igalia.com>
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

To reduce the boilerplate code, refactor futex_wait_wouldblock test to
use kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../futex/functional/futex_wait_wouldblock.c       | 75 +++++++---------------
 tools/testing/selftests/futex/functional/run.sh    |  2 +-
 2 files changed, 23 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 2d8230da906429cd9f1f9021e8df23e12398429e..7bb4ff4dcd9d5fef289b1012975558f19e1490e0 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -21,72 +21,43 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
 
-#define TEST_NAME "futex-wait-wouldblock"
 #define timeout_ns 100000
 
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
-int main(int argc, char *argv[])
+TEST(futex_wait_wouldblock)
 {
 	struct timespec to = {.tv_sec = 0, .tv_nsec = timeout_ns};
 	futex_t f1 = FUTEX_INITIALIZER;
-	int res, ret = RET_PASS;
-	int c;
-	struct futex_waitv waitv = {
-			.uaddr = (uintptr_t)&f1,
-			.val = f1+1,
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
-	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
-	       basename(argv[0]));
+	int res;
 
-	info("Calling futex_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
+	ksft_print_dbg_msg("Calling futex_wait on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
 	res = futex_wait(&f1, f1+1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno != EWOULDBLOCK) {
 		ksft_test_result_fail("futex_wait returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wait\n");
 	}
+}
 
-	if (clock_gettime(CLOCK_MONOTONIC, &to)) {
-		error("clock_gettime failed\n", errno);
-		return errno;
-	}
+TEST(futex_waitv_wouldblock)
+{
+	struct timespec to = {.tv_sec = 0, .tv_nsec = timeout_ns};
+	futex_t f1 = FUTEX_INITIALIZER;
+	int res;
+	struct futex_waitv waitv = {
+			.uaddr = (uintptr_t)&f1,
+			.val = f1+1,
+			.flags = FUTEX_32,
+			.__reserved = 0
+		};
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		ksft_exit_fail_msg("clock_gettime failed %d\n", errno);
 
 	to.tv_nsec += timeout_ns;
 
@@ -95,17 +66,15 @@ int main(int argc, char *argv[])
 		to.tv_nsec -= 1000000000;
 	}
 
-	info("Calling futex_waitv on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
+	ksft_print_dbg_msg("Calling futex_waitv on f1: %u @ %p with val=%u\n", f1, &f1, f1+1);
 	res = futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
 	if (!res || errno != EWOULDBLOCK) {
 		ksft_test_result_fail("futex_waitv returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 0af695038003b1ded7b21959d5f85105282811df..a5246d59849853bb70ecf836f0520053cf1fee76 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -44,7 +44,7 @@ echo
 ./futex_wait_timeout
 
 echo
-./futex_wait_wouldblock $COLOR
+./futex_wait_wouldblock
 
 echo
 ./futex_wait_uninitialized_heap $COLOR

-- 
2.51.0


