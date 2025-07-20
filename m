Return-Path: <linux-kselftest+bounces-37726-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9031EB0B8CE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E098189B16E
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C22C23D283;
	Sun, 20 Jul 2025 22:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="d5Oc/nGM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3294823C50D;
	Sun, 20 Jul 2025 22:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050584; cv=none; b=MXbZupid88yr59OVB7DW7lhY3u+Ub6/VsnOv3nK3OGFClikbdoDQ9s8huScW5QEXf0nARn/UY3JJU3zR/vJS2VjDKIdv6eAoerLBnYUkYBv3IJb+0TAOFPCyG89U2M9JlV3zVmvtHgi0vO92pME7vax1IJqEQlHgc/5TwECy/Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050584; c=relaxed/simple;
	bh=bkAOA4TRMEm0ZjBJsKGjzG9giej+uCf3V9kPzJ+5xSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BhsUHlCUR6Hy2G6YyDhcMILsl/4uTNrQiYhTEU4wEcdB+SaOFSYOFfaTGbGpKY6/jS1cD3AMYjTcfTrKlpNWqqgotqXinohdD0zOC2HDwivYhEZd4sfAEvAMUry/YUFsoDMN4+O6EbnvtG8axut5sFAyDaFLacK536jbHCpgdpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=d5Oc/nGM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nUlsjbhQS+CcitjgKLfLvIqeacMtXqVQqlZ4yfLSgLA=; b=d5Oc/nGMKxnR2zXiXJpXN5cXHY
	iI65reyzcytCewk5uMaVCFumpeWhJYFehF+oHmzBspYazNAUuR5oE/pHqD/4mbR6jZ/3DciVV5nc6
	K+UCVpt3H+VxjbqRxKfYlIsqz1j/RtN6Lwjquxsgx+cKaE6gMMnTiDm+zKOhKxQDEu5LF1Dt4MNYi
	v39ik7yhH8p+8Rn3oDZIqkv1mXFhr/yO7OP8C879S0Zd3kfgFhCzUZo0Ukpyv9cKgWqjElqq1BMe9
	ua/kJTsG6NFm4uoKJiLoC14hsVVzCa2K3n7RxG5pIRJKZTheMwls9Sedpk5xRHx5tQP45uEbJ4B4I
	VbK22LZw==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcXN-001Sqt-1L; Mon, 21 Jul 2025 00:29:41 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:29:11 -0300
Subject: [PATCH v2 13/15] selftests/futex: Refactor futex_numa_mpol with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-13-1f9bcb5b7294@igalia.com>
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

To reduce the boilerplate code, refactor futex_numa_mpol test to use
kselftest_harness header instead of futex's logging header.

Using kselftest_harness produces a side effect of having two adjacents
buffers, because test_harness_run() calls mmap() before this test
calling mmap(). This makes the "Memory out of range" subtest fail,
because the test address falls inside the first mmap() region, thus
being a valid address. Create a "buffer zone" with mmap(PROT_NONE) to
make sure there's invalid memory between the two mmaps and munmap() them
by the end of the test.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_numa_mpol.c   | 57 ++++++++--------------
 tools/testing/selftests/futex/functional/run.sh    | 15 +-----
 2 files changed, 21 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_numa_mpol.c b/tools/testing/selftests/futex/functional/futex_numa_mpol.c
index a9ecfb2d3932add7e560d885dc2088313fbb63bb..8d8d117b095f267af08fddcf13337f4674c44863 100644
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
 
@@ -130,44 +130,25 @@ static void test_futex_mpol(void *futex_ptr, int must_fail)
 	__test_futex(futex_ptr, must_fail, FUTEX2_SIZE_U32 | FUTEX_PRIVATE_FLAG | FUTEX2_NUMA | FUTEX2_MPOL);
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
-int main(int argc, char *argv[])
+TEST(futex_numa_mpol)
 {
 	struct futex32_numa *futex_numa;
 	int mem_size, i;
-	void *futex_ptr;
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
-	ksft_set_plan(1);
+	void *futex_ptr, *buffer_zone;
 
 	mem_size = sysconf(_SC_PAGE_SIZE);
+
+	/*
+	 * test_harness_run() calls mmap(..., MAP_SHARED, ...), which can create
+	 * a valid access memory region just bellow the mmap() issue here. Then,
+	 * the test for "Memory out of range" will fail because it will succeed
+	 * accessing the memory address after the range. To avoid this we create
+	 * a "Buffer zone" with PROT_NONE between the two mmap's.
+	 */
+	buffer_zone = mmap(NULL, mem_size, PROT_NONE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (buffer_zone == MAP_FAILED)
+		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
+
 	futex_ptr = mmap(NULL, mem_size, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 	if (futex_ptr == MAP_FAILED)
 		ksft_exit_fail_msg("mmap() for %d bytes failed\n", mem_size);
@@ -229,7 +210,9 @@ int main(int argc, char *argv[])
 			}
 		}
 	}
-	ksft_test_result_pass("NUMA MPOL tests passed\n");
-	ksft_finished();
-	return 0;
+
+	munmap(buffer_zone, mem_size);
+	munmap(futex_ptr, mem_size);
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
2.50.1


