Return-Path: <linux-kselftest+bounces-36585-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8F77AF963E
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 073337B77AF
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6A13093B3;
	Fri,  4 Jul 2025 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OeD7H49y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22A128B518;
	Fri,  4 Jul 2025 15:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641546; cv=none; b=A3vD2xM+s5nILjnTjZbLbinhD1pUJV3eDEPRrRrhuYCZBvBWRXcfPaloINMNSos0db0si035MSWO6J42RHVwbwWkjWtfsGCsLV+ePcnFuukAIAvrw37U/MNupoJaA/IPxl8nvmiInFrlsR4lxX0AlH0b6LNa2PATZoPyGnTzDek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641546; c=relaxed/simple;
	bh=odnkQvkojvnteSaHtbFSOTRRo8C2vgZLNLqrTgVa+Gw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=X/HXG1LJ9mLeBJTKSiRE5l3AK9dqadg1fh1Oun3pfFsdiA96v7zdAYS96u3aAnkNf2CRMbOBvcu7aZ/PSUY014ib4YFMwU55VJm8Uh1hjoaDkT+cAxUdoy5fcOWuS+zapmpOL+GKzFS4boy6pqQpwT0QV8B6BaxOh9mOZNqXS7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OeD7H49y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=t9TXouFtixw7kd2vb5hlpDTW7gPiyDOyqgfXJ7aDhq0=; b=OeD7H49ywdUGuxO3/Uus4wmIuX
	nfrDmvNRi3aPtpSI0XY7s8PgyfClWgFdpxsr5+jIgCN0kK/r0s5iNdGCmE1mHBlXXTc8KN7bJZUgf
	ryvMmU5LLhPeXapNBMCxTt0/fOVJATgmMxMUyMnYK5nhV2puhP0C+O7WqAH09YA0oCqgDqDobIblt
	scKqSy5igSIkkD7BSrKeWp62JGA1w/tE93wvlaD4KjQZSIoHGAf8E35jpsPLH6TiBNJU/NdvYmiPN
	m9tsS5OLX5fQifCvJZ+vJMvPaKXr9n/GLAvBER/jIhIivY9E4wga+WlBIygoJ+tyAU//YvLU9z+IT
	Jg4iAf5w==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhyv-00CTWt-Fb; Fri, 04 Jul 2025 17:05:41 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:10 -0300
Subject: [PATCH 06/15] selftests/futex: Refactor futex_wait_wouldblock with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-6-c0ff4f24c4e1@igalia.com>
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
index d42a8f4cf0a3d4361fd9d1196cb385a3ae38a04a..4a4fe9891f1ef8d69bb968a3a2be6c7dccd3575f 100755
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
2.49.0


