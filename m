Return-Path: <linux-kselftest+bounces-47398-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77EA8CB522E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 09:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 313E43027DBA
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Dec 2025 08:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC16F2D7803;
	Thu, 11 Dec 2025 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="KxgZr0aa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B466BFCE
	for <linux-kselftest@vger.kernel.org>; Thu, 11 Dec 2025 08:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765442329; cv=none; b=HBfADlM5YsLEYxrrN2Iz3N9Jm/mj08AUauSQByTgu/cZB/p/E+RtklYXJIxtaRAFWyyv4VTvfwROREkyXYZ7fSBlUp0hzlOS6TjLjn6C55KrpWkllYqJ26AyOykxYtBizJslBwnrmZTkZEsxlOGVYI0IcefwVVdro9sRCvsAhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765442329; c=relaxed/simple;
	bh=OaSgAGZgu5RG4Xl0VKKZRIVm/ecsyP8/6HPNanHuPCQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CN6dNouzcTfVrarStmGaIUfsGl/M7wxljW3H/sCxrUCaCteo3CpAE+emezWtqLgat5rBczaKZOzOlKXZOxAyDsfGrhCw82w6GULPI6jmmNAQ/IPhcZJIhYt5qRdTtPF57PHlLpldfWxTzmm2vdXtzo0skNj4lORXfnXPn8Nd7H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=KxgZr0aa; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765442322;
	bh=n4KWtaaPkv1fkuquVXbchtgc+gwGqnmVqPn1pkVnRo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KxgZr0aaP4DL/BzgQTFbQxkvjQDbcQ7DwA7xLJeLV7FIE68Id7erq1/hvYoGkHXDm
	 vMtcRQVBtD+WiZe3Vb1sm0csMEvrTCjoZXVUh/j33hEOpX8PgDYJm4a3m43dfI6FFx
	 doBoGwfHqVLVAQEoijgu632KjvgrOSg4NNV5tZ0U=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 9A636453; Thu, 11 Dec 2025 16:38:38 +0800
X-QQ-mid: xmsmtpt1765442318tebfhy6c9
Message-ID: <tencent_04CCE3CDAE57E7D479575F525D694530DC08@qq.com>
X-QQ-XMAILINFO: M0Sh0xCkwVkdNmtdG9antE7A0JygJOTcZ/0i9oZMHT46MtOuBLbHgVyB72/9V8
	 UvtFGqsf63EpkuctT7U9hgXYrjahGbQFWV6mCmiGhaA7DHWiaObcM0/NAvH3U5RynJDUY3sA/5/q
	 IJg2Nboe7TlOa9ih8MVRWdiDaqigI6j4cAaH5QzeEUYdpi0DD0WGGLsLeMSCqPpXgPOXXdfhegNe
	 yJi5JGYaFjOmzn8pLRUI3tMuXOLxLz7+Oqk1ZMq/abGvvy8aUkxOoS4fbo0K8ZsY8xVIcxBEUmgW
	 WihdnLg7FEXR0dbaekbYp7a9c5yeLdGNDo7rSXn0FC4ckKc6yq2MgW8zsqJPk9mz2IkGJh/OaiCa
	 jNRxiyh8Ww+fBFn5foGNuE2KrZH6uDhazMFE+zAR7naUUTzy4UPE902ygSKFDZlkmrkE0sgly7CE
	 VbASL9pw4b4D/T7qnvp41f/amcjOilTgsN+17YUJqmpNm319l1P1bQ4uQEeZTeI32U+XErY6q/Q8
	 LJCwADdCt3aBz5NvpOC0z68HGnmNR3PwVgQmFwfqQTFCWjmVfZOGIwgCvVdT3grA1nSo4fhR22LZ
	 p9bAL+6A2KxPc3PTHEpMCrBql1pB8U054cTTaP6hyUJmHVvTtT2ODEsYDF3nP1oIc5cqbcR28O0x
	 u5J7zmvDF9RNpX4GE4I8BJb0FrxkXpWtV67aLmeM1w17viwXjRSU8wH5okLSf+AGR8tuJsZ3ua8B
	 fClQUtRLdZeRGOkItayI/ZckKBzBSMMBI+dMnztAM+WmwBuaqLGf0NTbLd/evkjday0764Mysmrt
	 POWx3kkJIXsTkV89/tGQTKI/OqnZkag+CHjXLqgFAr3dm+dExkVkrvCTz21XQoFKAhWAJ3E5EBh/
	 lwY1Iz0Q4wyL/3zBQbk1aQQmUEM6v5cLP0vSJ5u+7EyPDH6Avk7EGdN9RUZzoz1DK5Zo97m+Mwj+
	 OXoGMSEWKt+HE3JFvERbUG65BDlTRszkplbE8q2ZgkCVLV6C9xel0hFU85Srl2W2rgJoay7kMHOL
	 AjIxexUIMq9J4fnBrZ09YaMJsDQUaCgEzDeE+dlZncqqmJyQzSd42gANUuw5WobEmEc/01JKVpWJ
	 SJHSz/2Xfa0rYibuPPkMvagJPZi0hj5O1FrsNnCx+TlhawHh4=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Yuwen Chen <ywen.chen@foxmail.com>
To: ywen.chen@foxmail.com
Cc: akpm@linux-foundation.org,
	andrealmeid@igalia.com,
	dave@stgolabs.net,
	dbueso@suse.de,
	dvhart@infradead.org,
	edliaw@google.com,
	hpa@linux.intel.com,
	justinstitt@google.com,
	kernel-team@android.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	llvm@lists.linux.dev,
	luto@mit.edu,
	mingo@redhat.com,
	morbo@google.com,
	nathan@kernel.org,
	ndesaulniers@google.com,
	peterz@infradead.org,
	shuah@kernel.org,
	tglx@linutronix.de,
	usama.anjum@collabora.com
Subject: [PATCH 3/3] selftests/futex: fix the issue of abnormal test results caused by thread timing
Date: Thu, 11 Dec 2025 16:38:36 +0800
X-OQ-MSGID: <20251211083836.1795902-1-ywen.chen@foxmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
References: <tencent_3739CFB7F300BEAEBB928A0EB8D1C6875C09@qq.com>
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
---
 .../selftests/futex/functional/Makefile       |  2 +-
 .../futex/functional/futex_requeue.c          | 58 ++++++++++++++++---
 2 files changed, 52 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 490ace1f017e8..8589917a4b126 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -2,7 +2,7 @@
 PKG_CONFIG ?= pkg-config
 LIBNUMA_TEST = $(shell sh -c "$(PKG_CONFIG) numa --atleast-version 2.0.16 > /dev/null 2>&1 && echo SUFFICIENT || echo NO")
 
-INCLUDES := -I../include -I../../ $(KHDR_INCLUDES)
+INCLUDES := -I../include -I../../ $(KHDR_INCLUDES) -I../../../../include
 CFLAGS := $(CFLAGS) -g -O2 -Wall -pthread -D_FILE_OFFSET_BITS=64 -D_TIME_BITS=64 $(INCLUDES) $(KHDR_INCLUDES) -DLIBNUMA_VER_$(LIBNUMA_TEST)=1
 LDLIBS := -lpthread -lrt -lnuma
 
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


