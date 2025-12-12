Return-Path: <linux-kselftest+bounces-47474-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 21707CB7C38
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59B5305F321
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770FD3009E3;
	Fri, 12 Dec 2025 03:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="rABEoZXS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E24D2D0C85;
	Fri, 12 Dec 2025 03:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.192
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509946; cv=none; b=pIa3N6NIMNpVJncRNMhMU5D0RpKnSKeo+JNsHbjQogmtgIep2jyq+eW4NPH5xxM7YAKB0ZY8j1nxQduBYUd/HJWa0rN8Rivum6EpNLQcgLDsczgXnnji8F0mNslrn3HrLo2NH6knk0PC6CuWn9ukw/7Lq4oQkbRJTJArip0wFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509946; c=relaxed/simple;
	bh=Nex/oon8j7jao0rAiMT18+Qlahb70pnvBFyuLcCfMtc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=sakZeuWhjIAKVcVNVetoScdonIwMWqxDDGX3vVTiV7LX5cZhcHMSsdbOnvMNZcQ6QnsojT8sICziX69uDO/hw3aqNsBJF8w6c+gveYNr+RajolAMj9uL0VjCmbD1hFPXcxIWsqROLLe6egQpzZMqB8pfFqm//Rf37NZKg2lR6yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=rABEoZXS; arc=none smtp.client-ip=203.205.221.192
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765509937;
	bh=QK3nE1ne7aea/LyPtdjql3srPWIhxJ56KdqwzowyUvM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=rABEoZXS/iZZ06TQXz4JRJIS0v4lmJ013Ah+Dq5Xk5vZkeVYEziugQGsK4zDDgfwA
	 Mr+NWac/qywBu12QmmNZVUD0iE+uRmctIyyUchq81Pu9jSFqwSj0wa6iwdcLGhddC4
	 jKkFWxoG8viWksuGDmGAJ/QYoEKwVSf2XJBhedpA=
Received: from meizu-Precision-3660.meizu.com ([112.91.84.72])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 661906EA; Fri, 12 Dec 2025 11:25:33 +0800
X-QQ-mid: xmsmtpt1765509933tfdq12r78
Message-ID: <tencent_52B929C6A35C2BCE33F3F2BEF4BAA48A4409@qq.com>
X-QQ-XMAILINFO: NXu+3P8uW1MUEv+H/F6HGCU2EvaME7SX3ol31+NZMZH5H4z0YN4PGf25oh3DZP
	 qrNoEwRPgOlym9OY1dfS961s6R5w7Zc8hdK9rzHqGG10GUZ9M18BWLmdDnTr3UkvZO8zn3zr86Se
	 nWMMAKEBTKtTxudBghmBhVgh1g6ZXPOS0l77MByfLs+Dlq3qARshcyIWCztzaKzQ//BTMahSrF+K
	 YXln1qWRQVDJZxCh9ONnnCaRGZmDvkADBg+oz2x0xNd+hNedDHgyq5iGB0fXST8vbty0vRnY4mgv
	 Z+qxnzT6WIrHp9WTAL7bcjl6bo2YMmG4ZyoCUnSBL114LWE5T9zhBs0kp7+mnkyJ/iAjhC8Q4ss5
	 D7dSVFyNmxj680so1bNAjU6p2LTJBTd9geG4WgEQxR+q+uFdKKfI6S2PK5T4qcbisp44Bud2KZo5
	 MPlqlsKbRXa0SF5Du6z65Hz8wBoF6v+TFnIzSqSmrKmDisTAJq/wEaK1By0oherpXGkJaWD8vDTq
	 /FdBLnOku2LYXh3IdkK/KO9PczU6+zNN720QtEfnQGjXpceDbrCdvdRYoG0vY9SBKNWngEB/bAre
	 H4gCDnlLtOrpS/XdXihaDEbb30xXBSYZtJIKPo0pKUjOtlP0gFtHNtVLkke4ctY1vRFU4VaTzQU5
	 M8DgxZEVWnHnmfMEfuqlf+MXXsvyVEkNmb0EcgcaZQs+++c+OzjCNEb9I4Pq74kAgUUBMPcT7ONA
	 0s7Bo0Xebb7a50vKsjEHkMVtebGU1/G4Ks8IEcJBDgGtYS/68FEnTKkgWRoye5RlzCsYFSZw8kgR
	 wznkj0FPHM5WY0GvToPg41Ny9b5iiLbim48TGClsCn2gzmsERi7HVO5CeY1Jjo7eELWQ6Gn4wupS
	 BR5Wfw07NNqVNMrEiqV+Z722jw0vT5VP3e4MAIEu1ZDiWIE2FkmFBLzCfyx50rQOlkezWgQrSRed
	 J8w176cqLr6u9WEYmUiO8pg0ZjbnIIuxFISYifJWNk6blquIFTU0EeU55Tem6GlGfgfHZXPIhxw5
	 BrsD5MTAJFTBg1SEF3ecy/G0RpsLVQnwOVV5b4q7qcgxXakkjcS/o52qWt13nujifeo/xJJQKYSw
	 fMB0t+etVp7s013dKT2e2ovx8RIGk84fPupPBrq3B2mukF4skq54mv4bEUzQ==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: andrealmeid@igalia.com,
	bigeasy@linutronix.de,
	colin.i.king@gmail.com,
	dave@stgolabs.net,
	dvhart@infradead.org,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com,
	Edward Liaw <edliaw@google.com>
Subject: [PATCH v2 5/5] selftests/futex: fix the issue of abnormal test results caused by thread timing
Date: Fri, 12 Dec 2025 11:25:32 +0800
X-OQ-MSGID: <20251212032532.1842495-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
References: <tencent_E8629E1FE67D7F457479179170238F07B90A@qq.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes a race between parent and child threads in futex_requeue.

Similar to commit fbf4dec70277 ("selftests/futex: Order calls to
futex_lock_pi"), which fixed a flake in futex_lock_pi due to racing
between the parent and child threads.

The same issue can occur in the futex_requeue test, because it expects
waiterfn to make progress to futex_wait before the parent starts to
requeue. This is mitigated by the parent sleeping for WAKE_WAIT_US, but
it still fails occasionally. This can be reproduced by adding a sleep in
the waiterfn before futex_wait:

TAP version 13
1..2
not ok 1 futex_requeue simple returned: 0
not ok 2 futex_requeue simple returned: 0
not ok 3 futex_requeue many returned: 0
not ok 4 futex_requeue many returned: 0

This issue can be resolved by checking whether the child thread is in a
sleeping state. This is because when the child thread goes to sleep, it
indicates that it is waiting for the futex lock.

Fixes: 7cb5dd8e2c8c ("selftests: futex: Add futex compare requeue test")
Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
Co-developed-by: Edward Liaw <edliaw@google.com>
Signed-off-by: Edward Liaw <edliaw@google.com>
---
 .../futex/functional/futex_requeue.c          | 58 ++++++++++++++++---
 1 file changed, 51 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools/testing/selftests/futex/functional/futex_requeue.c
index 7a22458c7fc96..994295fac6972 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -7,6 +7,7 @@
 
 #include <pthread.h>
 #include <limits.h>
+#include <linux/compiler.h>
 
 #include "futextest.h"
 #include "../../kselftest_harness.h"
@@ -15,6 +16,7 @@
 #define WAKE_WAIT_US 10000
 
 volatile futex_t *f1;
+static pthread_barrier_t barrier;
 
 void *waiterfn(void *arg)
 {
@@ -23,28 +25,59 @@ void *waiterfn(void *arg)
 	to.tv_sec = 0;
 	to.tv_nsec = timeout_ns;
 
+	WRITE_ONCE(*((pid_t *)arg), gettid());
+	pthread_barrier_wait(&barrier);
+
 	if (futex_wait(f1, *f1, &to, 0))
 		printf("waiter failed errno %d\n", errno);
 
 	return NULL;
 }
 
+static int get_thread_state(pid_t pid)
+{
+	FILE *fp;
+	char buf[80], tag[80];
+	char val = 0;
+
+	snprintf(buf, sizeof(buf), "/proc/%d/status", pid);
+	fp = fopen(buf, "r");
+	if (!fp)
+		return -1;
+
+	while (fgets(buf, sizeof(buf), fp))
+		if (fscanf(fp, "%s %c\n", tag, &val) == 2 && !strcmp(tag, "State:"))
+			break;
+
+	fclose(fp);
+	return val;
+}
+
 TEST(requeue_single)
 {
 	volatile futex_t _f1 = 0;
 	volatile futex_t f2 = 0;
 	pthread_t waiter;
-	int res;
+	pid_t tids;
+	int res, state;
 
 	f1 = &_f1;
+	pthread_barrier_init(&barrier, NULL, 2);
 
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
-	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+	if (pthread_create(&waiter, NULL, waiterfn, &tids))
 		ksft_exit_fail_msg("pthread_create failed\n");
 
-	usleep(WAKE_WAIT_US);
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_destroy(&barrier);
+	while ((state = get_thread_state(READ_ONCE(tids))) != 'S') {
+		usleep(WAKE_WAIT_US);
+
+		if (state < 0)
+			break;
+	}
 
 	ksft_print_dbg_msg("Requeuing 1 futex from f1 to f2\n");
 	res = futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
@@ -71,7 +104,8 @@ TEST(requeue_multiple)
 	volatile futex_t _f1 = 0;
 	volatile futex_t f2 = 0;
 	pthread_t waiter[10];
-	int res, i;
+	pid_t tids[10];
+	int res, i, state;
 
 	f1 = &_f1;
 
@@ -80,11 +114,21 @@ TEST(requeue_multiple)
 	 * At futex_wake, wake INT_MAX (should be exactly 7).
 	 */
 	for (i = 0; i < 10; i++) {
-		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
+		pthread_barrier_init(&barrier, NULL, 2);
+
+		if (pthread_create(&waiter[i], NULL, waiterfn, &tids[i]))
 			ksft_exit_fail_msg("pthread_create failed\n");
-	}
 
-	usleep(WAKE_WAIT_US);
+		pthread_barrier_wait(&barrier);
+		pthread_barrier_destroy(&barrier);
+
+		while ((state = get_thread_state(READ_ONCE(tids[i]))) != 'S') {
+			usleep(WAKE_WAIT_US);
+
+			if (state < 0)
+				break;
+		}
+	}
 
 	ksft_print_dbg_msg("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
 	res = futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
-- 
2.34.1


