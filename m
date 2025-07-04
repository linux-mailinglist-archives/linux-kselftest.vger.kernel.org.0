Return-Path: <linux-kselftest+bounces-36592-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7BAF964D
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F2265414A6
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0792430E846;
	Fri,  4 Jul 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="LnXApKQX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CCA2D239F;
	Fri,  4 Jul 2025 15:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641563; cv=none; b=FcD7rJdyQIifHZnrtmkpZvyyThWNMpur6Z/qtqjUNTLJJm5ptiM1iJUFqk8/auXsWg2ZAxEVG8EpnevT8hCJaIFUo7tiN8F0Rd+dN5P5RmEFCsEF+2T469xW50UkjVz8KvDeAOawoZN4F4/xwe9YwfXfG9Q6BQ5rbU/ZY1iQs30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641563; c=relaxed/simple;
	bh=17FfIMnlwwp+CoU5dF8jfiI05bINnG0s1RoAWdgmX/g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DPNFpDj8snlaT88CLZH6UjHamuLg2ykilmNjTUyMUjT+HaT/COIkOfPjZUg26bU5+jIQ/EfBJJOsmB0bVItiE7rHEpnV3ug103MepxCZodVhQeRme4gfLTP86e6G2fNSWyp9O7SitArFVBdaSd/DoZJBjp/Ciyl//EJIgtOT2eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=LnXApKQX; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lTueqYYX+5lziQBuPtjlMwnK94+sxOr/xm3TqVdfy9U=; b=LnXApKQXtXkhNbt8NPS+1B58Kn
	nmdL6ANFFxIoEARwZE9wR+k7CgIV3CNfD3olvUwioh/gc9UQy5qyS5wzyDwQnb1eAD35z2wLA8zPe
	isgS/AvZ5fJNZy/cbCy5Gxx6BEZo+7vVM5z8izZqlBjGCb4iW0FcSQ+l7oZtsL17xqEY+27p5evx2
	eClRbo6jJAOvs+jlMXi3Of5rI35sGRIfpXuu/x1bCzdPQneoNHPzgEagzDmxJfQtcGVRJSRp9IPZl
	ieIMsJbkHHI/G7vwCwCB0RKRqCvNcvZDHjir2+/PVsFuqpaBMiI1nA8sV959N7v1gaZKr5DvxUN31
	XLc1cgxg==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhzE-00CTWt-6h; Fri, 04 Jul 2025 17:06:00 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:17 -0300
Subject: [PATCH 13/15] selftests/futex: Refactor futex_numa_mpol with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-13-c0ff4f24c4e1@igalia.com>
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
2.49.0


