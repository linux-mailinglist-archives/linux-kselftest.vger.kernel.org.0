Return-Path: <linux-kselftest+bounces-41777-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3160DB81F55
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E03FD720DE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46FA31062D;
	Wed, 17 Sep 2025 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="cf8EyPGa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3797A3101A9;
	Wed, 17 Sep 2025 21:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144209; cv=none; b=NLWtGSHP6iabX5s/xP077Wvo0i67M7jJd6z2cI8LZKbPsCeMtg71rNhr5xjc1zyYUi8maBaBpaBIvHZjMsocnFZJHl8AFwFQKFiu1wr7UZuLg8xQmvk73wZfpGJGB05cZQJdwVXOVybNvsL/ANazttIWkKCUQziINc/+hnjhD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144209; c=relaxed/simple;
	bh=pqw8nNA03uWYatAtp667EchelVCKgMD8tugcKbIy4YM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGA16ySJBn8yk2a2v7u6KjoZV5KVKWj0ecQYLsgG+bcWkLu0BZi4HsXyStHCegeV3hJ/XfTc6fQUDrnV0wjKrsOxOCOGZoHe2jAIqiBTTCwvNNI71rYJzZqcjwkaWcApQre9ERxuVd0l2QLVqHhYLApE8LvQCuAUkrGlhh+yMjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=cf8EyPGa; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YhlOvvSM5hh3gzgwP5617LIrDcARnvfh4VFWk9tr+EA=; b=cf8EyPGaoJZX+l+wUGu4NMvVOR
	YO8Z8oXhi8QyeF5+Nyrf5K3lBr/m2x7sQIlzRLCmoOO8UbJ1h+S8RW4eb8CXdkHqdY9ZI3e3ZrSYg
	9CelP+MwzUsOGbPblYKgyJvcCf4yNA18wE4MvjAtQiW2GKz9rI94Y6NhORLqN+C4CciZ6ptvt2fpq
	Ci08IZoaFNEhjPmQjFFHgXS88wa8vElWn52+alkM6YpSV7B2hltab+eDcIrhgKkqovnh+3KBNW+w8
	TTtyx25jqfEqQXnfuhauE4DqtX8ut6s2BYi2UZHwT275neNyGVjpMDqVHbfCnI+jP0qeOUY/+4vuH
	Fk2AphRA==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzcc-00CsMq-6H; Wed, 17 Sep 2025 23:23:26 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:51 -0300
Subject: [PATCH v3 12/15] selftests/futex: Refactor futex_priv_hash with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-12-306b373c244d@igalia.com>
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

To reduce the boilerplate code, refactor futex_priv_hash test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_priv_hash.c   | 48 ++++------------------
 tools/testing/selftests/futex/functional/run.sh    |  2 +-
 2 files changed, 8 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 95f01603a6813cdfd6ec9ee1f22c4c4f5061004c..3b7b5851f290fcabd693276fc6746cfe30ca9520 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -14,7 +14,7 @@
 #include <linux/prctl.h>
 #include <sys/prctl.h>
 
-#include "logging.h"
+#include "../../kselftest_harness.h"
 
 #define MAX_THREADS	64
 
@@ -128,45 +128,14 @@ static void futex_dummy_op(void)
 		ksft_exit_fail_msg("pthread_mutex_timedlock() did not timeout: %d.\n", ret);
 }
 
-static void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c    Use color\n");
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
@@ -279,7 +248,7 @@ int main(int argc, char *argv[])
 	ret = futex_hash_slots_set(0);
 	ksft_test_result(ret == 0, "Global hash request\n");
 	if (ret != 0)
-		goto out;
+		return;
 
 	futex_hash_slots_set_must_fail(4);
 	futex_hash_slots_set_must_fail(8);
@@ -288,17 +257,14 @@ int main(int argc, char *argv[])
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
index 4a7b0efbcce2962a2cc40e3911711079a4e70243..f725531f06c4a88e6d3ebbabb628a5d5009eaa3b 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -60,7 +60,7 @@ echo
 ./futex_waitv
 
 echo
-./futex_priv_hash $COLOR
+./futex_priv_hash
 
 echo
 ./futex_numa_mpol $COLOR

-- 
2.51.0


