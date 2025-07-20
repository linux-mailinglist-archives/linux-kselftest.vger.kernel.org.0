Return-Path: <linux-kselftest+bounces-37725-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0119B0B8CA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A1517996A
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880B323C502;
	Sun, 20 Jul 2025 22:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="eTmKPRv8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A567322FF39;
	Sun, 20 Jul 2025 22:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050582; cv=none; b=JRczIw6jMH+Yjkyuh6xG/7PQjmVrSbzA7ZQC5tJiFbH985rvcyH7f9ahlKmDLpUwnhQxIlyD58nmVPiy2X6zgbrWOvrkQkpN1jYkSDjwSa7rr/SAX9nwu2Vxp3HY3ktuGkirJUPW1AtZxAmXTotiyU7SmiZxtBwCDaUD5p2Lh1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050582; c=relaxed/simple;
	bh=fqzbKvy9gjZqk/wALViwbg12qYQNsXNwAPHok2L2O4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R93zGqgqB8XmBzXceMnYTPotu+PyjZ5octvYXTb/KJh8HPs/jWw250UHlFbBB+EFGc2N2WBi4ryXl3ukx+b/usRsgwImjcAUESGJoGnWVTLKx2fHPPuY0xE3IEOisumfgK8HOH6GrPpLbFisbzWyEAYTk5z8onBMHw9LIHZ3tHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=eTmKPRv8; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LsCk8VoPseb/DdlK4W3PUXwTlzdFb6ht6vwBA65vBMc=; b=eTmKPRv8UJKSgE4ipDQZlAUBM7
	zb8mwjoHoLCEGtUYarFbPMuhJN7jwmCjZ6IAkMA6p9iFdbfAsxtTJ1k+g3fbOUh92yZMKpcobWBH3
	eG8oJx2wWHe2Zj6LRGKSzvbraZJjKCjCztIlr3w77N5c0Qx8Q9799R7+pNVO58byNabntpAkIecQY
	NEj9KzRg5GQEaa9zaUHUUDroh8N+rYD29BBkYDs+o75/x8mPrrBYwWP9EaNfUXWMmrEPbcRK3Bh4r
	WjO9Gq4SGIG1pzedn+rqWfxdSGwjure65uedRv9VzlKBCVdBcC+5domFbC1r74n/snH0kHxxrWd5f
	RZ3bjfnA==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcXK-001Sqt-CV; Mon, 21 Jul 2025 00:29:38 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:29:10 -0300
Subject: [PATCH v2 12/15] selftests/futex: Refactor futex_priv_hash with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-12-1f9bcb5b7294@igalia.com>
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

To reduce the boilerplate code, refactor futex_priv_hash test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_priv_hash.c   | 49 ++++------------------
 tools/testing/selftests/futex/functional/run.sh    |  3 +-
 2 files changed, 8 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index a9cedc365102ef701eb47a740ad2933ed60bbdb3..f9e87728850073ca4982379da1d677ea2146cca7 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -14,7 +14,7 @@
 #include <linux/prctl.h>
 #include <sys/prctl.h>
 
-#include "logging.h"
+#include "../../kselftest_harness.h"
 
 #define MAX_THREADS	64
 
@@ -128,46 +128,14 @@ static void futex_dummy_op(void)
 		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", ret);
 }
 
-static void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
-	printf("  -h    Display this help message\n");
-	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 static const char *test_msg_auto_create = "Automatic hash bucket init on thread creation.\n";
 static const char *test_msg_auto_inc = "Automatic increase with more than 16 CPUs\n";
 
-int main(int argc, char *argv[])
+TEST(priv_hash)
 {
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
 	int ret, retry = 20;
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
-			break;
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
-	ksft_set_plan(21);
 
 	ret = pthread_mutexattr_init(&mutex_attr_pi);
 	ret |= pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHERIT);
@@ -280,7 +248,7 @@ int main(int argc, char *argv[])
 	ret = futex_hash_slots_set(0);
 	ksft_test_result(ret == 0, "Global hash request\n");
 	if (ret != 0)
-		goto out;
+		return;
 
 	futex_hash_slots_set_must_fail(4);
 	futex_hash_slots_set_must_fail(8);
@@ -289,17 +257,14 @@ int main(int argc, char *argv[])
 	futex_hash_slots_set_must_fail(6);
 
 	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
-	if (ret != 0) {
+	if (ret != 0)
 		ksft_exit_fail_msg("pthread_barrier_init failed: %m\n");
-		return 1;
-	}
+
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
 
 	ret = futex_hash_slots_get();
 	ksft_test_result(ret == 0, "Continue to use global hash\n");
-
-out:
-	ksft_finished();
-	return 0;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 6086b5652687af3cd2d4e4bd56159149d5bb5fea..f725531f06c4a88e6d3ebbabb628a5d5009eaa3b 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -60,8 +60,7 @@ echo
 ./futex_waitv
 
 echo
-./futex_priv_hash $COLOR
-./futex_priv_hash -g $COLOR
+./futex_priv_hash
 
 echo
 ./futex_numa_mpol $COLOR

-- 
2.50.1


