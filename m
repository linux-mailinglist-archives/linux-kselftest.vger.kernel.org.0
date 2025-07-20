Return-Path: <linux-kselftest+bounces-37719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 547D7B0B8BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC1C83BB834
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB8238C25;
	Sun, 20 Jul 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="rE3nk+Gu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEFB22B5A5;
	Sun, 20 Jul 2025 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050566; cv=none; b=A4P2rR1yxaSUJHd3fWDzTAyiDw0L/QuH8jyGJ7cqHVMqhTvwKXxe7y8Z/INKp4FrrnTzc8ApJMZqUbGocGHlr5T9CQ+rDal9s1yYr2UnpjuOxeYsIRVKArpJxvph1eXkNr50ii2uSswgTNm7c/A0zWpt6A8jPFRNT/rP3lZ+TuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050566; c=relaxed/simple;
	bh=Hq2+xjGIy2DzCfd4T5+mZsHyWUKRy+1sCAwvwDxSK0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=khYw5pPJz6YJ9PA2kvV5JIjLeJMdeWmhgyF4I4LblmKGFiR0mFz3t/nlW2WxHPnGnNBGOZ2jzFk1DtNU0//982qNCKtZzBuVdg7ylJAK6z+3ExO5y04VXavUeZVIX/rmh9kjBJjBwAqzeOuawv9PpGt6sVyHnR3wwkYHLjiMAFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=rE3nk+Gu; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YPNXWndBWQ8xrGjO6eUsAfMTH8DWeRtjGlmmP8sYh8k=; b=rE3nk+GuwQLOjVvngu9E6JZxlS
	e2gTUfjsM7IlZetxnXUMSlkDM0/tunRr7H+sIUnnP9iSmzDno/XqVYafGJXgn1uRoYm9mX5+0qwhH
	cBm4/1nF6BHQY/ThPUqpo2Em1ynMoxfOd4YNhn5aehN9w7In5zXS9I8tGf6EPs215SzQPusgZN3gn
	xStXsP8UYW290ZEPkJL/JH1cxGknUsgzEz85P+6phElQme8q3lhU+xLmV98BASBVs5Xn/TcTjXaMN
	gkp+j6ANJetUT0wKoipYlzDpqqPsnTwCbg/QkCO9MsQrR8i9r/ULjbR3JtFiyx2JW+qG7U4dOXQ0n
	xFNO857w==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcX4-001Sqt-EZ; Mon, 21 Jul 2025 00:29:22 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:29:04 -0300
Subject: [PATCH v2 06/15] selftests/futex: Refactor futex_wait_wouldblock
 with kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-6-1f9bcb5b7294@igalia.com>
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
2.50.1


