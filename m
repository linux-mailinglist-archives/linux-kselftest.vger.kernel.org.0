Return-Path: <linux-kselftest+bounces-41778-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C49BB81F5B
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 23:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0133720E9C
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Sep 2025 21:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3043112DD;
	Wed, 17 Sep 2025 21:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="OSp7pNyA"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBFA3112B4;
	Wed, 17 Sep 2025 21:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758144212; cv=none; b=b/OWyahvmFm9gkEPRr3MyH8MhFEtbIRaZADP0kXyGibSO4Q55/9cMW3KMwTo5GNIWHcevMEQPgI3CQP+HNJgyyLQIwVub8ZGr1sc5flAJLWmKVtSt7UJgCRKWUdt2gNSgiCddOUgfyC9HfR6JKKBexPtFtFvDOMoqi36q1Hn+2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758144212; c=relaxed/simple;
	bh=VXKKuMFJnXVQ9FAkAm8KvPW5mpMDMGKwIup7lW2I3/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uk8XGvvvYuvMUpDR7JM/yQg3ryAQTbXGQ55NU24gktV7jRH+ryfJR7Ra9OoLI9DYd4ciosCQ0fLQlHrvHKGq1z5cxbIg/v7+do3fxPuO/vwg/c5KUW/UncNDb3dHHmqIMdvpiF/NfZYF7X7rn0gXldYfhsCZhArmd4WIpvVJTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=OSp7pNyA; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=SyphIoIZLFKsAFVPvQVh7MacEXoHxvDRfffviBfe4RE=; b=OSp7pNyAtSaHa8ll7qUZO6Ue45
	H9Aoq0Rt7O8HBYWqfNF2sHLLu6OIQRzyqBSf/5XFalhdShIKkfot++ADmzW5JryUuh9JlZznnuRFv
	NqD/XIEL76t21f5sNo3GOBDWWF8MoqA7C5xdde6Xridm13g/r4eX5V5+fqGqumqtH3/r4L+RSRF0J
	rAaZVbwwb4LRqbIZJ4u68qBmNiGx+c26uKZj6u9AHMMp1NLVdeJeEOGKdtntEvMFvr6gg+le3yOre
	75OW3wVqL4jMbfLAgDLsbsm6E9lKrZeNQ+xZOxjaN/lrH0eusQ/Eu7/pOnMbEdf0eR4UXYG33sHtH
	rzBYcuoQ==;
Received: from [191.204.197.103] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uyzce-00CsMq-Rx; Wed, 17 Sep 2025 23:23:29 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Wed, 17 Sep 2025 18:21:52 -0300
Subject: [PATCH v3 13/15] selftests/futex: Refactor futex_numa_mpol with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250917-tonyk-robust_test_cleanup-v3-13-306b373c244d@igalia.com>
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

To reduce the boilerplate code, refactor futex_numa_mpol test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_numa_mpol.c   | 39 ++++------------------
 tools/testing/selftests/futex/functional/run.sh    | 15 +--------
 2 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index 722427fe90bf0f6ba52556cde0999dc3abcaae37..9189a634bf11e6ad32fc0d41c4014956fb158dea 100644
--- a/tools/testing/selftests/futex/functional/futex_numa_mpol.c
+++ b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
@@ -16,9 +16,9 @@
 #include <linux/futex.h>
 #include <sys/mman.h>
 
-#include "logging.h"
 #include "futextest.h"
 #include "futex2test.h"
+#include "../../kselftest_harness.h"
 
 #define MAX_THREADS	64
 
@@ -131,42 +131,16 @@ static void test_futex(void *futex_ptr, int err_value)
 	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA);
 }
 
-static void usage(char *prog)
+static void test_futex_mpol(void *futex_ptr, int err_value)
 {
-	printf("Usage: %s\n", prog);
-	printf("  -c    Use color\n");
-	printf("  -h    Display this help message\n");
-	printf("  -v L  Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
+	__test_futex(futex_ptr, err_value, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
 }
 
-int main(int argc, char *argv[])
+TEST(futex_numa_mpol)
 {
 	struct futex32_numa *futex_numa;
 	int mem_size;
 	void *futex_ptr;
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
-	ksft_set_plan(2);
 
 	mem_size = sysconf(_SC_PAGE_SIZE);
 	futex_ptr = mmap(NULL, mem_size * 2, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
@@ -239,6 +213,7 @@ int main(int argc, char *argv[])
 #else
 	ksft_test_result_skip("futex2 MPOL hints test requires libnuma 2.0.16+\n");
 #endif
-	ksft_finished();
-	return 0;
+	munmap(futex_ptr, mem_size * 2);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index f725531f06c4a88e6d3ebbabb628a5d5009eaa3b..e88545c06d57a7b202e9a65a66d129996b4ebd27 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -18,19 +18,6 @@
 #
 ###############################################################################
 
-# Test for a color capable console
-if [ -z "$USE_COLOR" ]; then
-    tput setf 7 || tput setaf 7
-    if [ $? -eq 0 ]; then
-        USE_COLOR=1
-        tput sgr0
-    fi
-fi
-if [ "$USE_COLOR" -eq 1 ]; then
-    COLOR="-c"
-fi
-
-
 echo
 ./futex_requeue_pi
 
@@ -63,4 +50,4 @@ echo
 ./futex_priv_hash
 
 echo
-./futex_numa_mpol $COLOR
+./futex_numa_mpol

-- 
2.51.0


