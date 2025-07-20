Return-Path: <linux-kselftest+bounces-37722-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 888ECB0B8C8
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Jul 2025 00:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEB71898E76
	for <lists+linux-kselftest@lfdr.de>; Sun, 20 Jul 2025 22:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E8423ABAB;
	Sun, 20 Jul 2025 22:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WJDWmYFM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F9722F765;
	Sun, 20 Jul 2025 22:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753050574; cv=none; b=m83tEe2gmxu2e4gOFn1Rvkp07zz+031zPoqiZX2wW0bgnegzsUHTCwYHrKePfx+CngGxLIPp6Tw83O0i8h7+M1W/1CpO1PxRyFhYI+WfdzENwgbR6jIdkDZu8pXpmeQNUgx6/OAFGQ5mulV8lnYYW8WJYpdcujFe3JJkvgrBbu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753050574; c=relaxed/simple;
	bh=SHXQzogJle6zb2ggQaIPE1pbW44L3WCIfuJBatrfcoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lOgGjtc4/t+qfzQifgZJ44sFCCCB7b1O0hxVgeFhYR9Q5Hb/izstiJMPR6FHXrEi/NBKtw102/M+vtjaWXnQYsapPVhPqdHf/P9wcT16eIrlD7PpeqoyOZizW4EGP6y/gnqn6Diuij21ISBq7sFISeMFaQp3d/vLEmu0KZrriiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WJDWmYFM; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=501cgrThcpUucYbfX94YP7iljBRWK0XWMfv4/scQlGI=; b=WJDWmYFMTrI+DQtsL46ER4HKC7
	C2mLenW7NbxQDpaKvr9m37LnagwMzGIQsG7uX2XnbotjSyb/c/sepFQD5WjI4sIhS+rcPnnwTh/gc
	++rmuhHykLeGwTCGL8LJCQQhQYu2yHLSHnjbsU/5QjjFLd2YzuwO1zJb5n4bTYvyWE76X+NeSy5QQ
	CXYxU2eeJdHzGG4y6Xqi0G/8jdtZ7aUJHRvtxsey72DYX4G47lUrKIcHxjHst66QU0kbMNyGuYVQj
	NqN64b+TEhAs73rrTRD0aJE2OK1go8KCmO15mSxYG64cVAtEwnbraGTWP1QQRobBOC1m807/KjIUB
	4Fife6Yw==;
Received: from [187.57.76.50] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1udcXC-001Sqt-Di; Mon, 21 Jul 2025 00:29:30 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sun, 20 Jul 2025 19:29:07 -0300
Subject: [PATCH v2 09/15] selftests/futex: Refactor futex_wait with
 kselftest_harness.h
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250720-tonyk-robust_test_cleanup-v2-9-1f9bcb5b7294@igalia.com>
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
2.50.1


