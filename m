Return-Path: <linux-kselftest+bounces-36591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B378FAF964C
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68BE1CA88BD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5143930B9B8;
	Fri,  4 Jul 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="C2+InXdP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C3830B9AA;
	Fri,  4 Jul 2025 15:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641561; cv=none; b=I8AGEy7NyPs92lwX059cxqCEg2EIrkq1yixNsgHvnlbbZa2Emk6Anuqff6/cj84U8BIqc9oh/Vb7u8TY/jwnOlcJLFt9re990SL7J9vaqMZSHBUucqj9KE38zLYbwZNFwP22Ss241Br+B2M1U0WtWMd5ZevxF5UE5PnSJQ+7ZZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641561; c=relaxed/simple;
	bh=kAi9i9IfyttvVKnUHDkuA9SHG5Amwz3TQLac87kM/c4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9RK+RVQo6SuXooe8GhjH91fA4rVzOyMUTAuXyf7O+H3o6nngQ2VxNx1am5Glu81vRshCjISlbmZ0ujTlm1Dwo726cm37Ds3ojPOgXF+1leeXwfvGPnQAnQsvRCxQRzICSwpA++06vlG3d+nFwitZ9AKhnpMqR6AlKfk0/Vu/eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=C2+InXdP; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XxdhNpyBlGxsIIdE0FBlYLv5Nk70hHWxt9uMVX8H2OM=; b=C2+InXdP77V9nIzDoUT0OGvb8Q
	DoIWX3XwpacKNLtlz4B/8G4IN344LI8/fRmJqgcXqjSwQ2ketxPaCrRFPs6jt3Tg/F2QvEuU5lNzY
	UWSIgX0sFvJhx3hHI4+GSwjpk18iZlgjAG5Nvn4cqE7wyVRuQ5zvq2kgS3UiYPaeK6tGiqUVLGqBr
	E2Ga3IMFFbbWI6hRZyUzOALh0a90xhbgeTTW2tuikgqYH4MMWErhuA90Rsvln1nDKiXTy80CTaK5e
	1U8KhYj8naYE7Oz1jhKKSwN5Nun+ty1+5hYN58eYw0FcW7QOwjjBl5TaCyK89vtcPtGie+HCD7UWY
	/WDjnk/A==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhzB-00CTWt-Gx; Fri, 04 Jul 2025 17:05:57 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:16 -0300
Subject: [PATCH 12/15] selftests/futex: Refactor futex_priv_hash with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-12-c0ff4f24c4e1@igalia.com>
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

To reduce the boilerplate code, refactor futex_priv_hash test to use
kselftest_harness header instead of futex's logging header.

Use the fixture feature to run the same test with different parameters
(with global hash enabled and disabled).

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_priv_hash.c   | 79 ++++++++++------------
 tools/testing/selftests/futex/functional/run.sh    |  3 +-
 2 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_priv_hash.c b/tools/testing/selftests/futex/functional/futex_priv_hash.c
index 24a92dc94eb86cc0e03ded5d6a4a0a96b0dc8a36..8ad7135cb59adc16bd2ff9ea57796a3a5c282ae5 100644
--- a/tools/testing/selftests/futex/functional/futex_priv_hash.c
+++ b/tools/testing/selftests/futex/functional/futex_priv_hash.c
@@ -14,7 +14,7 @@
 #include <linux/prctl.h>
 #include <sys/prctl.h>
 
-#include "logging.h"
+#include "../../kselftest_harness.h"
 
 #define MAX_THREADS	64
 
@@ -111,50 +111,42 @@ static void join_max_threads(void)
 	}
 }
 
-static void usage(char *prog)
+static const char *test_msg_auto_create = "Automatic hash bucket init on thread creation.\n";
+static const char *test_msg_auto_inc = "Automatic increase with more than 16 CPUs\n";
+
+FIXTURE(global_hash)
+{
+};
+
+FIXTURE_VARIANT(global_hash)
+{
+	bool use_global_hash;
+};
+
+FIXTURE_VARIANT_ADD(global_hash, enabled)
+{
+	.use_global_hash = true,
+};
+
+FIXTURE_VARIANT_ADD(global_hash, disabled)
+{
+	.use_global_hash = false,
+};
+
+FIXTURE_SETUP(global_hash)
 {
-	printf("Usage: %s\n", prog);
-	printf("  -c    Use color\n");
-	printf("  -g    Test global hash instead intead local immutable \n");
-	printf("  -h    Display this help message\n");
-	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
 }
 
-static const char *test_msg_auto_create = "Automatic hash bucket init on thread creation.\n";
-static const char *test_msg_auto_inc = "Automatic increase with more than 16 CPUs\n";
+FIXTURE_TEARDOWN(global_hash)
+{
+}
 
-int main(int argc, char *argv[])
+TEST_F(global_hash, priv_hash)
 {
 	int futex_slots1, futex_slotsn, online_cpus;
 	pthread_mutexattr_t mutex_attr_pi;
-	int use_global_hash = 0;
+	int use_global_hash = variant->use_global_hash;
 	int ret;
-	int c;
-
-	while ((c = getopt(argc, argv, "cghv:")) != -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'g':
-			use_global_hash = 1;
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
-	ksft_set_plan(22);
 
 	ret = pthread_mutexattr_init(&mutex_attr_pi);
 	ret |= pthread_mutexattr_setprotocol(&mutex_attr_pi, PTHREAD_PRIO_INHERIT);
@@ -259,7 +251,7 @@ int main(int argc, char *argv[])
 		ksft_test_result(ret == 0, "Immutable resize to 4\n");
 	}
 	if (ret != 0)
-		goto out;
+		return;
 
 	futex_hash_slots_set_must_fail(4, 0);
 	futex_hash_slots_set_must_fail(4, FH_FLAG_IMMUTABLE);
@@ -269,10 +261,9 @@ int main(int argc, char *argv[])
 	futex_hash_slots_set_must_fail(6, FH_FLAG_IMMUTABLE);
 
 	ret = pthread_barrier_init(&barrier_main, NULL, MAX_THREADS);
-	if (ret != 0) {
+	if (ret != 0)
 		ksft_exit_fail_msg("pthread_barrier_init failed: %m\n");
-		return 1;
-	}
+
 	create_max_threads(thread_lock_fn);
 	join_max_threads();
 
@@ -285,8 +276,6 @@ int main(int argc, char *argv[])
 
 	ret = futex_hash_immutable_get();
 	ksft_test_result(ret == 1, "Hash reports to be immutable\n");
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
2.49.0


