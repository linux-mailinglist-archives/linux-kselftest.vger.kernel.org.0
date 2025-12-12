Return-Path: <linux-kselftest+bounces-47472-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69558CB7C23
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 04:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D4D230133AF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Dec 2025 03:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C4F22FFDFF;
	Fri, 12 Dec 2025 03:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="FLmOI9Vk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE542F8BC8;
	Fri, 12 Dec 2025 03:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509933; cv=none; b=KmaQQc8FfaYlBK4DfetQVaC6nAjzzYXN5i+WZzaAQt9ATUpjiT3UdDSNf8OkUoDNaKqbKwQvdNs/Suf+qiYAEC7R6VLr983KqZDKe0isrtvXlpKoN9EaWGwHLOPMhstysBNxiYSI/eskh9QZv5vUbNymusc/P6ftv9jKIi6GruA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509933; c=relaxed/simple;
	bh=Q9Dt8zcXiFFbcg9AaMquAPxodgc5EtsCma0SZrxjPgg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=LybRF8bCLzPUtsUDN3VGniGausJFNVds/sPQxEOrN1OwQlwrxr0Qjrjg0dZ/+k/x/pg33bpSyJY/dUNMk4QgWuEE2jXC1jsHIcuXJ26qrft8Ev8TQ0ymjbjGZcz7PIbTJPVnARpP2lBnaWnfo1eSh35Kzjzz7SNq6oISaz+1Qms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=FLmOI9Vk; arc=none smtp.client-ip=203.205.221.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1765509912;
	bh=PfKTM9YgO72StMOXeVof7To4faRXvcAqJFGn8si/NpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FLmOI9VkUrXlDGCd63Ktut57BvK0+vhMYcI+dF/R3cfciL3YgXtqbVRVJCyx9glR3
	 xZUY8Y+mnV97fJxByPNMTR74VDGDcEmTcLex/sl4DJkJMTdtJKGjPat+//xuL4OWju
	 QKmPLNsLVvK6bjyGEo3G/WXy7MsyTDTZFYFJO8Iw=
Received: from meizu-Precision-3660.meizu.com ([14.21.33.152])
	by newxmesmtplogicsvrsza53-0.qq.com (NewEsmtp) with SMTP
	id 6490C8D9; Fri, 12 Dec 2025 11:25:09 +0800
X-QQ-mid: xmsmtpt1765509909tn6u96rrw
Message-ID: <tencent_7DA95D2C454DDCF1E381AE2EE7F7793A5F08@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAdhwvCmJC9UnurEtbtGWLtP5D3BlrF7Y9xZghT1i/8wHWvswme0
	 OgLdlXUTzS25H2js3MegDq25De3v5okQsUIRWZBOuKT5zv8rSjuh8bj7c4fuu+DTw9E/ygH67EkX
	 4CJbO6w4z786Bdvgv2uGue5GMkMtvjZ0xOuzA9aWyGFisZd8HlLnRfRir2Ej+SVoT4Y9lSwRSVLv
	 t9VNQ3cWXXjBd4IdwVxTLYEv+pG3gB2cxDIRi93LIOqqDyQFemWLAnZeNaozi5/u9WZua9KQoJpW
	 JdzSoEgCUVa9TdAlK8RUKGw7Mxnyih+TvNRNXSEjtYsXs1IhgMEJ5jo3KDIJ679T4iq7YLKt3fT9
	 n5tF5nlKdDKb/jadXbgFXYGdgAvQFiGwrgm+JL5wmXsWh6PuRuQPK5H/++wTEfv7XCtwRQh3xBZy
	 0E6za12iLvMHAeyBSRy4ivn/UKn2G4RVeHZWnEAYn5+hlwnz3pxKO4HmpXgBWrIH/TxqN3liTZZv
	 FlsxcV+Ii9AdZF2iHSN7lott32hvfsNIjUSN2oCEuLjNi3gAyo4jt7Onl4fZlOSSYYNcTKmR3LfU
	 ZIgLF0433PE5hRhFPDWC/rBcHD+UnZ3uq9DI99yDjrBWmLdjRJf9Olk1JR1BfY5OJHlCX3iaR49D
	 0dGeaj217wXPfi21e6U2DJIR8cQyYQwpEKEdqcLaV6ylwGGD8XL8h0TRXxakLo8L0nFf31JDqUQ+
	 y5LeTFQcokykcELu/6xBTZJ+W9tO/2MAhVaJmZuK6uR14644szUjmj0tXFrpGvL3o/mM2dndEty9
	 AJH+56Nl8xY2KTGerQT9muQczJBaXcxmDn03op8vegXGw6G+3/Ezs+WjYyx6Iv2toww6XuKnpC1Y
	 xi9AkW/vwFZvOWNRQF0l3G5G08ztTteqH15WV/ZrXNP/DeZZRoPoDq6WsX1chsPy7WNvvQwZxl2D
	 yKPIK6kffB4mIDCdY2z3cnRSBlHXC0LzpF4wEPOC/3+EplQ+QWkV4Lgpdg1L70Su4jZpVheY+xSH
	 v6bILJuPa5C9cmSuHh9gGb4qjIEh5SuBA5kFyHULzmtsbN6j0dcy9yhbhsVRC66asH2BElPlz4tm
	 pKehwZ
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
	usama.anjum@collabora.com
Subject: [PATCH v2 3/5] selftests/futex: read atomic variable value with atomic_read
Date: Fri, 12 Dec 2025 11:25:07 +0800
X-OQ-MSGID: <20251212032507.1842436-1-ywen.chen@foxmail.com>
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

Directly reading the internal value of atomic_t externally does
not meet the encapsulation requirements. A new function
atomic_read is added to obtain the value of an atomic variable.

Signed-off-by: Yuwen Chen <ywen.chen@foxmail.com>
---
 .../selftests/futex/functional/futex_requeue_pi.c    | 12 ++++++------
 .../functional/futex_requeue_pi_signal_restart.c     |  4 ++--
 tools/testing/selftests/futex/include/atomic.h       | 12 ++++++++++++
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index f299d75848cd4..5d845b052891b 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -201,7 +201,7 @@ void *broadcast_wakerfn(void *arg)
 	int i = 0;
 
 	ksft_print_dbg_msg("Waker: waiting for waiters to block\n");
-	while (waiters_blocked.val < THREAD_MAX)
+	while (atomic_read(&waiters_blocked) < THREAD_MAX)
 		usleep(1000);
 	usleep(1000);
 
@@ -218,7 +218,7 @@ void *broadcast_wakerfn(void *arg)
 		ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
 	} else if (++i < MAX_WAKE_ITERS) {
 		task_count += args->ret;
-		if (task_count < THREAD_MAX - waiters_woken.val)
+		if (task_count < THREAD_MAX - atomic_read(&waiters_woken))
 			goto continue_requeue;
 	} else {
 		ksft_exit_fail_msg("max broadcast iterations (%d) reached with %d/%d tasks woken or requeued\n",
@@ -247,13 +247,13 @@ void *signal_wakerfn(void *arg)
 	int i = 0;
 
 	ksft_print_dbg_msg("Waker: waiting for waiters to block\n");
-	while (waiters_blocked.val < THREAD_MAX)
+	while (atomic_read(&waiters_blocked) < THREAD_MAX)
 		usleep(1000);
 	usleep(1000);
 
-	while (task_count < THREAD_MAX && waiters_woken.val < THREAD_MAX) {
+	while (task_count < THREAD_MAX && atomic_read(&waiters_woken) < THREAD_MAX) {
 		ksft_print_dbg_msg("task_count: %d, waiters_woken: %d\n",
-		     task_count, waiters_woken.val);
+		     task_count, atomic_read(&waiters_woken));
 		if (args->lock) {
 			ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on mutex=%x @ %p\n",
 			    f2, &f2);
@@ -293,7 +293,7 @@ void *signal_wakerfn(void *arg)
 		args->ret = task_count;
 
 	ksft_print_dbg_msg("Waker: exiting with %d\n", args->ret);
-	ksft_print_dbg_msg("Waker: waiters_woken: %d\n", waiters_woken.val);
+	ksft_print_dbg_msg("Waker: waiters_woken: %d\n", atomic_read(&waiters_woken));
 	pthread_exit((void *)&args->ret);
 }
 
diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
index e34ee0f9ebccd..29f93916b46da 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c
@@ -70,7 +70,7 @@ int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 void handle_signal(int signo)
 {
 	ksft_print_dbg_msg("signal received %s requeue\n",
-	     requeued.val ? "after" : "prior to");
+	     atomic_read(&requeued) ? "after" : "prior to");
 }
 
 void *waiterfn(void *arg)
@@ -83,7 +83,7 @@ void *waiterfn(void *arg)
 	old_val = f1;
 	res = futex_wait_requeue_pi(&f1, old_val, &(f2), NULL,
 				    FUTEX_PRIVATE_FLAG);
-	if (!requeued.val || errno != EWOULDBLOCK) {
+	if (!atomic_read(&requeued) || errno != EWOULDBLOCK) {
 		ksft_test_result_fail("unexpected return from futex_wait_requeue_pi: %d (%s)\n",
 		     res, strerror(errno));
 		ksft_print_dbg_msg("w2:futex: %x\n", f2);
diff --git a/tools/testing/selftests/futex/include/atomic.h b/tools/testing/selftests/futex/include/atomic.h
index 428bcd921bb53..c0dccb1b966ba 100644
--- a/tools/testing/selftests/futex/include/atomic.h
+++ b/tools/testing/selftests/futex/include/atomic.h
@@ -76,4 +76,16 @@ atomic_set(atomic_t *addr, int newval)
 	return newval;
 }
 
+/**
+ * atomic_read() - Atomic read
+ * @addr:	Address of the variable to read
+ *
+ * Return the value of addr->val.
+ */
+static inline int
+atomic_read(atomic_t *addr)
+{
+	return addr->val;
+}
+
 #endif
-- 
2.34.1


