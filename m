Return-Path: <linux-kselftest+bounces-26187-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5A4A2F25B
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 16:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1581888D8C
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B5B12441AD;
	Mon, 10 Feb 2025 15:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7ebf5nn"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFC824419F;
	Mon, 10 Feb 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739203162; cv=none; b=CgyDrcQimS/ccuofk69WVMd8tvyjyRqPBsJKPgLbfWSW63Zos+rRiBsA1nVZUziVlUigB5pQoIRgvLrYYM98Ua8lE5ACnQ6M2Pr0YLRL567pOjEoqGPlD8ISArKQlHMjQCTbIh1lhvyC57xrozarL1wnY7BpwiyYaclpJK3G81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739203162; c=relaxed/simple;
	bh=yLyvAuyXh25VE7eka4iWVG9OmfECMKl8nCUieykIFlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E8IyvKoIayZxPGXpo7Pw6KWV8qv99c1DlFA/KC/jT5yljDCRv7+NLbhv4E2Nl8cjfduL7NEvX7uV7koRJl4sduNxIXgeEB6AtGTozA46DvN20fEegSW1vwWd4Cht/qY6YzhQTgJoeX/KjLysndEXSTUUGDaCcFZstYmNoGfOT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y7ebf5nn; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7c053a107b8so203808585a.3;
        Mon, 10 Feb 2025 07:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739203159; x=1739807959; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S6XdbqsKECb/QW9CdvNEgKkofwrG3vJgPiPaRkRoP6g=;
        b=Y7ebf5nnkpdUCr/U5t19j802ct/325b9KHN5bOav1CVLDRywoFtGp8fq68iYzXsxkQ
         5yWKsQco4K6XpLLLMDpUbomwFsrfKv6WmdKbdrGC0yU9lF0SNKQ22FT6IzBWhU1hR8xj
         UBTOe52uRmRCPLFO5vBEezSGz/zgGjUrzKqkXwm/Yu5mqvt6OQBkbiNrE+7pDsJvDQLo
         k50hHAOMGchF7Isw4LAHl1kwC6dB/UztiiFllIkWO/DgRTZKSeJVw3yRWurNhVg/rUTD
         kWC5yff9ddu8MmmTnrYvWeGlPpsmywrnU/MHd2IA39eb8adIA2aA8wQLnqbI4i1+ci+Q
         +2HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739203159; x=1739807959;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S6XdbqsKECb/QW9CdvNEgKkofwrG3vJgPiPaRkRoP6g=;
        b=eMq/4zn7RaorIFxFdAuG7oOgjk94CbtCAoMGFu7hup7rX8MJK/zJ9jvRPzGvUWrF0V
         pzPRHqh/n6EiulgZSZ/iPrWhkkkSzW7dT9Q+PNFaRXcvmhpypDIKgQBMku8TJO6dKwm8
         ai+aLVPsWVj5mxNbcD0DtTzDWuqBx9BKq/EEHrrSvmoQDpS7+YJI/EBydxbufqXMEYKI
         Q4b2q+rdcxlXZ8c3QDo7V8za9hv33tmUPoXm1QlbKJcJj5c3isGhIRDMnSJPLkecMMFT
         SqFvOVF6FhnvVGwZp6cFNm8g4S9LZ/mzQoLeZPitjyhMMhIi6yzhLyYR4Y51IUezH6Qk
         iZuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXW6k1XlhDCMf0+U4WdztrbPNRxKmgNEsMbRmyUiAqalEHvz/JIGEMAbRHs2TYnjilXJSaqpkYWWgrfr3r+JJ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgvY2QRhfe6S+PhDG/HdhRAQMSHbCJUrvqoJ6wLDJbNe2/w9Ai
	eimEN85vfcPIYJKfBL/E/Q/uk1OPucuZEFqXYlTiItnI0qKIo5/N
X-Gm-Gg: ASbGnctPk6DHzLjpatw20IRXOVvsN2UucrCgA0836ysnnI6ngL5RXIge9wfuek3HzBp
	/NBW2p7eR5LL8Pu0T29SC0hDJyWHXIMFw9Xv4eLJN+Dn9Q9xUQPs7usex6973e8qnJHvWbyzVvn
	pWsH1BiHg+VBAI+090HVl6/GWTE/N+5M3tVlIr7ID5CZUvaU3FnPo6xIdmKdCpWL9iRzOpCYwP4
	zMxlPjgquYhcdCKkgYS67lAOgqN/gGqw3hFKAPfrtetXDFwJESeOrdo00oqgVTWhnYNoQZ02M4Z
	tEWjLdaqYrddEdv3LS9Fw+3fEW/eKMkvXof/dhe+34WkE0IW1aJYoY3jgSmh4jhpZ5b9VNTeqDs
	oCamFGmuxM4ZvKtDJ92cQxcIC
X-Google-Smtp-Source: AGHT+IGOiU9C4sgd1ZVAQtMQ0ngsSJNT9RZCUok5P+bwMk+E44n0pLy60g/OpTPPF38RryyUXQO+oQ==
X-Received: by 2002:a05:620a:bcb:b0:7be:39e7:a025 with SMTP id af79cd13be357-7c047c3885dmr1943585685a.26.1739203158863;
        Mon, 10 Feb 2025 07:59:18 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:cc94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c0615b0725sm88917685a.41.2025.02.10.07.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 07:59:17 -0800 (PST)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 10 Feb 2025 10:59:12 -0500
Subject: [PATCH] ww_mutex: convert self-test to KUnit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-ww_mutex-kunit-convert-v1-1-972f0201f71e@gmail.com>
X-B4-Tracking: v=1; b=H4sIAE8iqmcC/x3MSQqAMAxA0atI1gZqcMKriEjVqEGs0tYBxLtbX
 L7F/w84tsIOqugBy6c42UxAEkfQz9pMjDIEAynKFKkSr6tdD883LocRj/1mTrYei6RMSRc675g
 gxLvlUe5/XDfv+wHUmJCCaAAAAA==
X-Change-ID: 20250208-ww_mutex-kunit-convert-71842a7a6be2
To: David Gow <davidgow@google.com>, Peter Zijlstra <peterz@infradead.org>, 
 Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, 
 Boqun Feng <boqun.feng@gmail.com>, Waiman Long <longman@redhat.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 llvm@lists.linux.dev, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Convert this unit test to a KUnit test.

Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
I tested this using:
$ tools/testing/kunit/kunit.py run --arch arm64 --make_options LLVM=1 ww_mutex

On success:
; [12:48:16] ================== ww_mutex (5 subtests) ===================
; [12:48:16] ======================= test_mutex  ========================
; [12:48:16] [PASSED] flags=0
; [12:48:16] [PASSED] flags=1
; [12:48:16] [PASSED] flags=2
; [12:48:16] [PASSED] flags=3
; [12:48:16] [PASSED] flags=4
; [12:48:17] [PASSED] flags=5
; [12:48:17] [PASSED] flags=6
; [12:48:17] [PASSED] flags=7
; [12:48:17] =================== [PASSED] test_mutex ====================
; [12:48:17] ========================= test_aa  =========================
; [12:48:17] [PASSED] lock
; [12:48:17] [PASSED] trylock
; [12:48:17] ===================== [PASSED] test_aa =====================
; [12:48:17] ======================== test_abba  ========================
; [12:48:17] [PASSED] trylock=0,resolve=0
; [12:48:17] [PASSED] trylock=1,resolve=1
; [12:48:17] [PASSED] trylock=0,resolve=0
; [12:48:17] [PASSED] trylock=1,resolve=1
; [12:48:17] ==================== [PASSED] test_abba ====================
; [12:48:17] ======================= test_cycle  ========================
; [12:48:17] [PASSED] nthreads=2
; [12:48:17] =================== [PASSED] test_cycle ====================
; [12:48:21] ========================= stress  ==========================
; [12:48:21] [PASSED] nlocks=16,nthreads_per_cpu=2,flags=1
; [12:48:23] [PASSED] nlocks=16,nthreads_per_cpu=2,flags=2
; [12:48:23] [PASSED] nlocks=2046,nthreads_per_cpu=3,flags=7
; [12:48:23] ===================== [PASSED] stress ======================
; [12:48:23] ==================== [PASSED] ww_mutex =====================
; [12:48:23] ============================================================
; [12:48:23] Testing complete. Ran 18 tests: passed: 18

On failure:
---
 kernel/locking/Makefile                            |   3 +-
 .../locking/{test-ww_mutex.c => ww_mutex_kunit.c}  | 311 ++++++++++-----------
 lib/Kconfig.debug                                  |  12 +-
 tools/testing/selftests/locking/ww_mutex.sh        |  19 --
 4 files changed, 163 insertions(+), 182 deletions(-)

diff --git a/kernel/locking/Makefile b/kernel/locking/Makefile
index 0db4093d17b8..26af3e88fffa 100644
--- a/kernel/locking/Makefile
+++ b/kernel/locking/Makefile
@@ -30,5 +30,6 @@ obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock.o
 obj-$(CONFIG_DEBUG_SPINLOCK) += spinlock_debug.o
 obj-$(CONFIG_QUEUED_RWLOCKS) += qrwlock.o
 obj-$(CONFIG_LOCK_TORTURE_TEST) += locktorture.o
-obj-$(CONFIG_WW_MUTEX_SELFTEST) += test-ww_mutex.o
 obj-$(CONFIG_LOCK_EVENT_COUNTS) += lock_events.o
+
+obj-$(CONFIG_WW_MUTEX_KUNIT_TEST) += ww_mutex_kunit.o
diff --git a/kernel/locking/test-ww_mutex.c b/kernel/locking/ww_mutex_kunit.c
similarity index 67%
rename from kernel/locking/test-ww_mutex.c
rename to kernel/locking/ww_mutex_kunit.c
index bcb1b9fea588..ba89a4a702f9 100644
--- a/kernel/locking/test-ww_mutex.c
+++ b/kernel/locking/ww_mutex_kunit.c
@@ -3,10 +3,10 @@
  * Module-based API test facility for ww_mutexes
  */
 
-#include <linux/kernel.h>
-
+#include <kunit/test.h>
 #include <linux/completion.h>
 #include <linux/delay.h>
+#include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/module.h>
 #include <linux/prandom.h>
@@ -54,12 +54,39 @@ static void test_mutex_work(struct work_struct *work)
 	ww_mutex_unlock(&mtx->mutex);
 }
 
-static int __test_mutex(unsigned int flags)
+static const unsigned int *gen_range(
+	unsigned int *storage,
+	const unsigned int min,
+	const unsigned int max,
+	const int *prev)
+{
+	if (prev != NULL) {
+		if (*prev >= max)
+			return NULL;
+		*storage = *prev + 1;
+	} else {
+		*storage = min;
+	}
+	return storage;
+}
+
+static const void *test_mutex_gen_params(const void *prev, char *desc)
+{
+	static unsigned int storage;
+	const unsigned int *next = gen_range(&storage, 0, __TEST_MTX_LAST - 1, prev);
+
+	if (next != NULL)
+		snprintf(desc, KUNIT_PARAM_DESC_SIZE, "flags=%x", *next);
+	return next;
+}
+
+static void test_mutex(struct kunit *test)
 {
 #define TIMEOUT (HZ / 16)
+	const unsigned int *param = test->param_value;
+	const unsigned int flags = *param;
 	struct test_mutex mtx;
 	struct ww_acquire_ctx ctx;
-	int ret;
 
 	ww_mutex_init(&mtx.mutex, &ww_class);
 	if (flags & TEST_MTX_CTX)
@@ -79,53 +106,42 @@ static int __test_mutex(unsigned int flags)
 	if (flags & TEST_MTX_SPIN) {
 		unsigned long timeout = jiffies + TIMEOUT;
 
-		ret = 0;
 		do {
 			if (completion_done(&mtx.done)) {
-				ret = -EINVAL;
+				KUNIT_FAIL(test, "mutual exclusion failure");
 				break;
 			}
 			cond_resched();
 		} while (time_before(jiffies, timeout));
 	} else {
-		ret = wait_for_completion_timeout(&mtx.done, TIMEOUT);
+		KUNIT_EXPECT_EQ(test, wait_for_completion_timeout(&mtx.done, TIMEOUT), 0);
 	}
 	ww_mutex_unlock(&mtx.mutex);
 	if (flags & TEST_MTX_CTX)
 		ww_acquire_fini(&ctx);
 
-	if (ret) {
-		pr_err("%s(flags=%x): mutual exclusion failure\n",
-		       __func__, flags);
-		ret = -EINVAL;
-	}
-
 	flush_work(&mtx.work);
 	destroy_work_on_stack(&mtx.work);
-	return ret;
 #undef TIMEOUT
 }
 
-static int test_mutex(void)
+static const void *test_aa_gen_params(const void *prev, char *desc)
 {
-	int ret;
-	int i;
+	static unsigned int storage;
+	const unsigned int *next = gen_range(&storage, 0, 1, prev);
 
-	for (i = 0; i < __TEST_MTX_LAST; i++) {
-		ret = __test_mutex(i);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
+	if (next != NULL)
+		snprintf(desc, KUNIT_PARAM_DESC_SIZE, *next ? "trylock" : "lock");
+	return next;
 }
 
-static int test_aa(bool trylock)
+static void test_aa(struct kunit *test)
 {
+	const unsigned int *param = test->param_value;
+	const bool trylock = *param;
 	struct ww_mutex mutex;
 	struct ww_acquire_ctx ctx;
 	int ret;
-	const char *from = trylock ? "trylock" : "lock";
 
 	ww_mutex_init(&mutex, &ww_class);
 	ww_acquire_init(&ctx, &ww_class);
@@ -133,46 +149,42 @@ static int test_aa(bool trylock)
 	if (!trylock) {
 		ret = ww_mutex_lock(&mutex, &ctx);
 		if (ret) {
-			pr_err("%s: initial lock failed!\n", __func__);
+			KUNIT_FAIL(test, "initial lock failed, ret=%d", ret);
 			goto out;
 		}
 	} else {
 		ret = !ww_mutex_trylock(&mutex, &ctx);
 		if (ret) {
-			pr_err("%s: initial trylock failed!\n", __func__);
+			KUNIT_FAIL(test, "initial trylock failed, ret=%d", ret);
 			goto out;
 		}
 	}
 
-	if (ww_mutex_trylock(&mutex, NULL))  {
-		pr_err("%s: trylocked itself without context from %s!\n", __func__, from);
+	ret = ww_mutex_trylock(&mutex, NULL);
+	if (ret)  {
+		KUNIT_FAIL(test, "trylocked itself without context, ret=%d", ret);
 		ww_mutex_unlock(&mutex);
-		ret = -EINVAL;
 		goto out;
 	}
 
-	if (ww_mutex_trylock(&mutex, &ctx))  {
-		pr_err("%s: trylocked itself with context from %s!\n", __func__, from);
+	ret = ww_mutex_trylock(&mutex, &ctx);
+	if (ret) {
+		KUNIT_FAIL(test, "trylocked itself with context, ret=%d", ret);
 		ww_mutex_unlock(&mutex);
-		ret = -EINVAL;
 		goto out;
 	}
 
 	ret = ww_mutex_lock(&mutex, &ctx);
 	if (ret != -EALREADY) {
-		pr_err("%s: missed deadlock for recursing, ret=%d from %s\n",
-		       __func__, ret, from);
+		KUNIT_FAIL(test, "missed deadlock for recursing, ret=%d", ret);
 		if (!ret)
 			ww_mutex_unlock(&mutex);
-		ret = -EINVAL;
 		goto out;
 	}
 
 	ww_mutex_unlock(&mutex);
-	ret = 0;
 out:
 	ww_acquire_fini(&ctx);
-	return ret;
 }
 
 struct test_abba {
@@ -217,11 +229,28 @@ static void test_abba_work(struct work_struct *work)
 	abba->result = err;
 }
 
-static int test_abba(bool trylock, bool resolve)
+static const void *test_abba_gen_params(const void *prev, char *desc)
 {
+	static unsigned int storage;
+	const unsigned int *next = gen_range(&storage, 0b00, 0b11, prev);
+
+	if (next != NULL) {
+		const bool trylock = *next & 0b01 >> 0;
+		const bool resolve = *next & 0b10 >> 1;
+
+		snprintf(desc, KUNIT_PARAM_DESC_SIZE, "trylock=%d,resolve=%d", trylock, resolve);
+	}
+	return next;
+}
+
+static void test_abba(struct kunit *test)
+{
+	const unsigned int *param = test->param_value;
+	const bool trylock = *param & 0b01 >> 0;
+	const bool resolve = *param & 0b10 >> 1;
 	struct test_abba abba;
 	struct ww_acquire_ctx ctx;
-	int err, ret;
+	int err;
 
 	ww_mutex_init(&abba.a_mutex, &ww_class);
 	ww_mutex_init(&abba.b_mutex, &ww_class);
@@ -259,21 +288,17 @@ static int test_abba(bool trylock, bool resolve)
 	flush_work(&abba.work);
 	destroy_work_on_stack(&abba.work);
 
-	ret = 0;
 	if (resolve) {
 		if (err || abba.result) {
-			pr_err("%s: failed to resolve ABBA deadlock, A err=%d, B err=%d\n",
-			       __func__, err, abba.result);
-			ret = -EINVAL;
+			KUNIT_FAIL(test, "failed to resolve ABBA deadlock, A err=%d, B err=%d",
+				   err, abba.result);
 		}
 	} else {
 		if (err != -EDEADLK && abba.result != -EDEADLK) {
-			pr_err("%s: missed ABBA deadlock, A err=%d, B err=%d\n",
-			       __func__, err, abba.result);
-			ret = -EINVAL;
+			KUNIT_FAIL(test, "missed ABBA deadlock, A err=%d, B err=%d",
+				   err, abba.result);
 		}
 	}
-	return ret;
 }
 
 struct test_cycle {
@@ -314,15 +339,25 @@ static void test_cycle_work(struct work_struct *work)
 	cycle->result = err ?: erra;
 }
 
-static int __test_cycle(unsigned int nthreads)
+static const void *test_cycle_gen_params(const void *prev, char *desc)
 {
+	static unsigned int storage;
+	const unsigned int *next = gen_range(&storage, 2, num_online_cpus(), prev);
+
+	if (next != NULL)
+		snprintf(desc, KUNIT_PARAM_DESC_SIZE, "nthreads=%d", *next);
+	return next;
+}
+
+static void test_cycle(struct kunit *test)
+{
+	const unsigned int *param = test->param_value;
+	const unsigned int nthreads = *param;
 	struct test_cycle *cycles;
 	unsigned int n, last = nthreads - 1;
-	int ret;
 
-	cycles = kmalloc_array(nthreads, sizeof(*cycles), GFP_KERNEL);
-	if (!cycles)
-		return -ENOMEM;
+	cycles = kunit_kmalloc_array(test, nthreads, sizeof(*cycles), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, cycles);
 
 	for (n = 0; n < nthreads; n++) {
 		struct test_cycle *cycle = &cycles[n];
@@ -348,41 +383,24 @@ static int __test_cycle(unsigned int nthreads)
 
 	flush_workqueue(wq);
 
-	ret = 0;
 	for (n = 0; n < nthreads; n++) {
 		struct test_cycle *cycle = &cycles[n];
 
 		if (!cycle->result)
 			continue;
 
-		pr_err("cyclic deadlock not resolved, ret[%d/%d] = %d\n",
-		       n, nthreads, cycle->result);
-		ret = -EINVAL;
+		KUNIT_FAIL(test, "cyclic deadlock not resolved, ret[%d/%d] = %d",
+			   n, nthreads, cycle->result);
 		break;
 	}
 
 	for (n = 0; n < nthreads; n++)
 		ww_mutex_destroy(&cycles[n].a_mutex);
-	kfree(cycles);
-	return ret;
-}
-
-static int test_cycle(unsigned int ncpus)
-{
-	unsigned int n;
-	int ret;
-
-	for (n = 2; n <= ncpus + 1; n++) {
-		ret = __test_cycle(n);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
 }
 
 struct stress {
 	struct work_struct work;
+	struct kunit *test;
 	struct ww_mutex *locks;
 	unsigned long timeout;
 	int nlocks;
@@ -401,12 +419,12 @@ static inline u32 prandom_u32_below(u32 ceil)
 	return ret;
 }
 
-static int *get_random_order(int count)
+static int *get_random_order(struct kunit *test, int count)
 {
 	int *order;
 	int n, r;
 
-	order = kmalloc_array(count, sizeof(*order), GFP_KERNEL);
+	order = kunit_kmalloc_array(test, count, sizeof(*order), GFP_KERNEL);
 	if (!order)
 		return order;
 
@@ -435,7 +453,7 @@ static void stress_inorder_work(struct work_struct *work)
 	struct ww_acquire_ctx ctx;
 	int *order;
 
-	order = get_random_order(nlocks);
+	order = get_random_order(stress->test, nlocks);
 	if (!order)
 		return;
 
@@ -472,13 +490,10 @@ static void stress_inorder_work(struct work_struct *work)
 
 		ww_acquire_fini(&ctx);
 		if (err) {
-			pr_err_once("stress (%s) failed with %d\n",
-				    __func__, err);
+			KUNIT_FAIL(stress->test, "lock[%d] failed, err=%d", n, err);
 			break;
 		}
 	} while (!time_after(jiffies, stress->timeout));
-
-	kfree(order);
 }
 
 struct reorder_lock {
@@ -495,19 +510,16 @@ static void stress_reorder_work(struct work_struct *work)
 	int *order;
 	int n, err;
 
-	order = get_random_order(stress->nlocks);
-	if (!order)
-		return;
+	order = get_random_order(stress->test, stress->nlocks);
+	KUNIT_ASSERT_NOT_NULL(stress->test, order);
 
 	for (n = 0; n < stress->nlocks; n++) {
-		ll = kmalloc(sizeof(*ll), GFP_KERNEL);
-		if (!ll)
-			goto out;
+		ll = kunit_kmalloc(stress->test, sizeof(*ll), GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(stress->test, ll);
 
 		ll->lock = &stress->locks[order[n]];
 		list_add(&ll->link, &locks);
 	}
-	kfree(order);
 	order = NULL;
 
 	do {
@@ -523,8 +535,7 @@ static void stress_reorder_work(struct work_struct *work)
 				ww_mutex_unlock(ln->lock);
 
 			if (err != -EDEADLK) {
-				pr_err_once("stress (%s) failed with %d\n",
-					    __func__, err);
+				KUNIT_FAIL(stress->test, "lock failed, err=%d", err);
 				break;
 			}
 
@@ -538,11 +549,6 @@ static void stress_reorder_work(struct work_struct *work)
 
 		ww_acquire_fini(&ctx);
 	} while (!time_after(jiffies, stress->timeout));
-
-out:
-	list_for_each_entry_safe(ll, ln, &locks, link)
-		kfree(ll);
-	kfree(order);
 }
 
 static void stress_one_work(struct work_struct *work)
@@ -558,8 +564,7 @@ static void stress_one_work(struct work_struct *work)
 			dummy_load(stress);
 			ww_mutex_unlock(lock);
 		} else {
-			pr_err_once("stress (%s) failed with %d\n",
-				    __func__, err);
+			KUNIT_FAIL(stress->test, "lock failed, err=%d", err);
 			break;
 		}
 	} while (!time_after(jiffies, stress->timeout));
@@ -570,22 +575,41 @@ static void stress_one_work(struct work_struct *work)
 #define STRESS_ONE BIT(2)
 #define STRESS_ALL (STRESS_INORDER | STRESS_REORDER | STRESS_ONE)
 
-static int stress(int nlocks, int nthreads, unsigned int flags)
+struct stress_case {
+	int nlocks;
+	int nthreads_per_cpu;
+	unsigned int flags;
+};
+
+static const struct stress_case stress_cases[] = {
+	{ 16, 2, STRESS_INORDER },
+	{ 16, 2, STRESS_REORDER },
+	{ 2046, hweight32(STRESS_ALL), STRESS_ALL },
+};
+
+static void stress_case_to_desc(const struct stress_case *param, char *desc)
 {
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE, "nlocks=%d,nthreads_per_cpu=%d,flags=%x",
+		 param->nlocks, param->nthreads_per_cpu, param->flags);
+}
+
+KUNIT_ARRAY_PARAM(stress_cases, stress_cases, stress_case_to_desc);
+
+static void stress(struct kunit *test)
+{
+	const struct stress_case *param = test->param_value;
+	const int nlocks = param->nlocks;
+	int nthreads = param->nthreads_per_cpu * num_online_cpus();
+	const unsigned int flags = param->flags;
 	struct ww_mutex *locks;
 	struct stress *stress_array;
 	int n, count;
 
-	locks = kmalloc_array(nlocks, sizeof(*locks), GFP_KERNEL);
-	if (!locks)
-		return -ENOMEM;
+	locks = kunit_kmalloc_array(test, nlocks, sizeof(*locks), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, locks);
 
-	stress_array = kmalloc_array(nthreads, sizeof(*stress_array),
-				     GFP_KERNEL);
-	if (!stress_array) {
-		kfree(locks);
-		return -ENOMEM;
-	}
+	stress_array = kunit_kmalloc_array(test, nthreads, sizeof(*stress_array), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, stress_array);
 
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_init(&locks[n], &ww_class);
@@ -617,6 +641,7 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 		stress = &stress_array[count++];
 
 		INIT_WORK(&stress->work, fn);
+		stress->test = test;
 		stress->locks = locks;
 		stress->nlocks = nlocks;
 		stress->timeout = jiffies + 2*HZ;
@@ -629,70 +654,42 @@ static int stress(int nlocks, int nthreads, unsigned int flags)
 
 	for (n = 0; n < nlocks; n++)
 		ww_mutex_destroy(&locks[n]);
-	kfree(stress_array);
-	kfree(locks);
-
-	return 0;
 }
 
-static int __init test_ww_mutex_init(void)
+static int ww_mutex_suite_init(struct kunit_suite *suite)
 {
-	int ncpus = num_online_cpus();
-	int ret, i;
-
-	printk(KERN_INFO "Beginning ww mutex selftests\n");
-
-	prandom_seed_state(&rng, get_random_u64());
-
 	wq = alloc_workqueue("test-ww_mutex", WQ_UNBOUND, 0);
 	if (!wq)
 		return -ENOMEM;
 
-	ret = test_mutex();
-	if (ret)
-		return ret;
-
-	ret = test_aa(false);
-	if (ret)
-		return ret;
-
-	ret = test_aa(true);
-	if (ret)
-		return ret;
-
-	for (i = 0; i < 4; i++) {
-		ret = test_abba(i & 1, i & 2);
-		if (ret)
-			return ret;
-	}
-
-	ret = test_cycle(ncpus);
-	if (ret)
-		return ret;
-
-	ret = stress(16, 2*ncpus, STRESS_INORDER);
-	if (ret)
-		return ret;
-
-	ret = stress(16, 2*ncpus, STRESS_REORDER);
-	if (ret)
-		return ret;
-
-	ret = stress(2046, hweight32(STRESS_ALL)*ncpus, STRESS_ALL);
-	if (ret)
-		return ret;
+	prandom_seed_state(&rng, get_random_u64());
 
-	printk(KERN_INFO "All ww mutex selftests passed\n");
 	return 0;
 }
 
-static void __exit test_ww_mutex_exit(void)
+static void ww_mutex_suite_exit(struct kunit_suite *suite)
 {
-	destroy_workqueue(wq);
+	if (wq)
+		destroy_workqueue(wq);
 }
 
-module_init(test_ww_mutex_init);
-module_exit(test_ww_mutex_exit);
+static struct kunit_case ww_mutex_cases[] = {
+	KUNIT_CASE_PARAM(test_mutex, test_mutex_gen_params),
+	KUNIT_CASE_PARAM(test_aa, test_aa_gen_params),
+	KUNIT_CASE_PARAM(test_abba, test_abba_gen_params),
+	KUNIT_CASE_PARAM(test_cycle, test_cycle_gen_params),
+	KUNIT_CASE_PARAM_ATTR(stress, stress_cases_gen_params, {.speed = KUNIT_SPEED_SLOW}),
+	{},
+};
+
+static struct kunit_suite ww_mutex_suite = {
+	.name = "ww_mutex",
+	.suite_init = ww_mutex_suite_init,
+	.suite_exit = ww_mutex_suite_exit,
+	.test_cases = ww_mutex_cases,
+};
+
+kunit_test_suite(ww_mutex_suite);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Intel Corporation");
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 1af972a92d06..a7edcbdc1428 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1586,16 +1586,18 @@ config LOCK_TORTURE_TEST
 	  Say M if you want these torture tests to build as a module.
 	  Say N if you are unsure.
 
-config WW_MUTEX_SELFTEST
-	tristate "Wait/wound mutex selftests"
+config WW_MUTEX_KUNIT_TEST
+	tristate "KUnit test for wait/wound mutex" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
 	help
-	  This option provides a kernel module that runs tests on the
-	  on the struct ww_mutex locking API.
+	  This option provides a KUnit test that exercises the struct
+	  ww_mutex locking API.
 
 	  It is recommended to enable DEBUG_WW_MUTEX_SLOWPATH in conjunction
 	  with this test harness.
 
-	  Say M if you want these self tests to build as a module.
+	  Say M if you want these tests to build as a module.
 	  Say N if you are unsure.
 
 config SCF_TORTURE_TEST
diff --git a/tools/testing/selftests/locking/ww_mutex.sh b/tools/testing/selftests/locking/ww_mutex.sh
deleted file mode 100755
index 91e4ac7566af..000000000000
--- a/tools/testing/selftests/locking/ww_mutex.sh
+++ /dev/null
@@ -1,19 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-# Runs API tests for struct ww_mutex (Wait/Wound mutexes)
-if ! /sbin/modprobe -q -n test-ww_mutex; then
-	echo "ww_mutex: module test-ww_mutex is not found [SKIP]"
-	exit $ksft_skip
-fi
-
-if /sbin/modprobe -q test-ww_mutex; then
-       /sbin/modprobe -q -r test-ww_mutex
-       echo "locking/ww_mutex: ok"
-else
-       echo "locking/ww_mutex: [FAIL]"
-       exit 1
-fi

---
base-commit: a64dcfb451e254085a7daee5fe51bf22959d52d3
change-id: 20250208-ww_mutex-kunit-convert-71842a7a6be2

Best regards,
-- 
Tamir Duberstein <tamird@gmail.com>


