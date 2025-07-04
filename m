Return-Path: <linux-kselftest+bounces-36588-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEBBAF9646
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 17:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C3411CA80C3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Jul 2025 15:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C41309DD0;
	Fri,  4 Jul 2025 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="JJUifL6C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E9C309DB9;
	Fri,  4 Jul 2025 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641553; cv=none; b=WBej1wBKArbTIfL/ho+CFDEUaGukZypHpGXjZutAHyE9PY8FfP9C93q+HmQTu3ykIsIYpH0lI1+IK4UsqSWqbKycWitOJaW6/hW48WpEzcSkmA8DcauH04T/uPQY7XpKmHAOggrnOoHBEgcPh6uenDx2NOLdSMZI/bBd/gVKnCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641553; c=relaxed/simple;
	bh=8RzRZSLDMjobrezoZPjBrKTp5EQRctaBkvLREMCWMVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O7LN5GkpS8GtXgu/8v10c8q9Zu1wXVizHmWYO/ljIo5EuiEdFCHQYVcNUa72bpSQtkv2V5+BmSQgq2Tp+6Rc/D2FE0HSr1Kc0jwsExkoM+Zn1FTZvOMf9pHbH0BdwAK0EXA0xm7OFTnpyoauneNz8vy/OjG3YWNA/Ci1cgW2pmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=JJUifL6C; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=byWJufBHF2TZ6Av5c14+Z5l9xUJ+8KykWZvC68i3/FY=; b=JJUifL6CXzSUOEnDvCAqHwzyCf
	rWRQipugqAN1DT+omUjGJ1KhXVF17oiLYgupArwyYU89Eo6ttfxAGvqV6M/9EF+3xuySQGIBFtGdR
	iHyZGwctLjoJNnQq5KtAkGPi7mYhmHvGFai6eGk15jFLlnGfHhbNtmKZjNJmSXgPTYixohO7Z+K18
	SqS3Yo2V6/Wgz7lh1mLBhgbulIUcnq6sAf//Kih+AC7/E3R7/kjo78FNmMcGFSeSEgyRSwCMBtgY8
	OYYp1byX1XsgSDR2KBvoQ6SIN4L/c9lylUgnY1RpvNGq86xeYvp5bqO3v3pr3G1avbMBp3nxgUzsp
	+JU0T31g==;
Received: from [179.100.5.63] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uXhz3-00CTWt-GJ; Fri, 04 Jul 2025 17:05:49 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Fri, 04 Jul 2025 12:05:13 -0300
Subject: [PATCH 09/15] selftests/futex: Refactor futex_wait with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250704-tonyk-robust_test_cleanup-v1-9-c0ff4f24c4e1@igalia.com>
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

To reduce the boilerplate code, refactor futex_wait test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/futex_wait.c        | 103 ++++++++-------------
 tools/testing/selftests/futex/functional/run.sh    |   2 +-
 2 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/testing/selftests/futex/functional/futex_wait.c
index 685140d9b93d2f71f7f1d9f07c29bfd38adfd059..5a772a7e6831b13c3d63084c7759560825b93628 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -9,25 +9,16 @@
 #include <sys/shm.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "logging.h"
+
 #include "futextest.h"
+#include "../../kselftest_harness.h"
 
-#define TEST_NAME "futex-wait"
 #define timeout_ns  30000000
 #define WAKE_WAIT_US 10000
 #define SHM_PATH "futex_shm_file"
 
 void *futex;
 
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 static void *waiterfn(void *arg)
 {
 	struct timespec to;
@@ -45,53 +36,37 @@ static void *waiterfn(void *arg)
 	return NULL;
 }
 
-int main(int argc, char *argv[])
+TEST(private_futex)
 {
-	int res, ret = RET_PASS, fd, c, shm_id;
-	u_int32_t f_private = 0, *shared_data;
+	int res;
+	u_int32_t f_private = 0;
 	unsigned int flags = FUTEX_PRIVATE_FLAG;
 	pthread_t waiter;
-	void *shm;
 
 	futex = &f_private;
 
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
-	ksft_set_plan(3);
-	ksft_print_msg("%s: Test futex_wait\n", basename(argv[0]));
-
 	/* Testing a private futex */
-	info("Calling private futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling private futex_wait on futex: %p\n", futex);
 	if (pthread_create(&waiter, NULL, waiterfn, (void *) &flags))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
 
 	usleep(WAKE_WAIT_US);
 
-	info("Calling private futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling private futex_wake on futex: %p\n", futex);
 	res = futex_wake(futex, 1, FUTEX_PRIVATE_FLAG);
 	if (res != 1) {
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      errno, strerror(errno));
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake private succeeds\n");
 	}
+}
+
+TEST(anon_page)
+{
+	u_int32_t *shared_data;
+	pthread_t waiter;
+	int res, shm_id;
 
 	/* Testing an anon page shared memory */
 	shm_id = shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
@@ -105,67 +80,65 @@ int main(int argc, char *argv[])
 	*shared_data = 0;
 	futex = shared_data;
 
-	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (page anon) futex_wait on futex: %p\n", futex);
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
 
 	usleep(WAKE_WAIT_US);
 
-	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (page anon) futex_wake on futex: %p\n", futex);
 	res = futex_wake(futex, 1, 0);
 	if (res != 1) {
 		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
 				      errno, strerror(errno));
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
 	}
 
+	shmdt(shared_data);
+}
+
+TEST(file_backed)
+{
+	u_int32_t f_private = 0;
+	pthread_t waiter;
+	int res, fd;
+	void *shm;
 
 	/* Testing a file backed shared memory */
 	fd = open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
-	if (fd < 0) {
-		perror("open");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_msg("open");
 
-	if (ftruncate(fd, sizeof(f_private))) {
-		perror("ftruncate");
-		exit(1);
-	}
+	if (ftruncate(fd, sizeof(f_private)))
+		ksft_exit_fail_msg("ftruncate");
 
 	shm = mmap(NULL, sizeof(f_private), PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
-	if (shm == MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (shm == MAP_FAILED)
+		ksft_exit_fail_msg("mmap");
 
 	memcpy(shm, &f_private, sizeof(f_private));
 
 	futex = shm;
 
-	info("Calling shared (file backed) futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (file backed) futex_wait on futex: %p\n", futex);
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
 
 	usleep(WAKE_WAIT_US);
 
-	info("Calling shared (file backed) futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (file backed) futex_wake on futex: %p\n", futex);
 	res = futex_wake(shm, 1, 0);
 	if (res != 1) {
 		ksft_test_result_fail("futex_wake shared (file backed) returned: %d %s\n",
 				      errno, strerror(errno));
-		ret = RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake shared (file backed) succeeds\n");
 	}
 
-	/* Freeing resources */
-	shmdt(shared_data);
 	munmap(shm, sizeof(f_private));
 	remove(SHM_PATH);
 	close(fd);
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/selftests/futex/functional/run.sh
index 2b3409d2513ea6b2c29efbcbdedfedd525f64151..b461a0a075a2ae526d37a1fcd09e196e48c2d4ff 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -51,7 +51,7 @@ echo
 ./futex_wait_private_mapped_file
 
 echo
-./futex_wait $COLOR
+./futex_wait
 
 echo
 ./futex_requeue $COLOR

-- 
2.49.0


