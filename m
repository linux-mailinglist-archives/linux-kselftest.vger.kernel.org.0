Return-Path: <linux-kselftest+bounces-35875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968EAAEA429
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 19:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABD711763B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4CE2ECEAE;
	Thu, 26 Jun 2025 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hBRwMc1C"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DF62DAFB8;
	Thu, 26 Jun 2025 17:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750957986; cv=none; b=i6wPHSD3TYvguKg+V+8BvMceycGqAtx5mJGqm8RbyscAPhyCDodVzowz/aIT7PBlZsOYyCNyShl8vlmhlFCc61k4keElPcrffY131tj6WzFs2TPcymgZ3lgRqMPc8pF5OpP6mW803ufuTBM4cjgrMH70c80UkWvtDrT2AKSZHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750957986; c=relaxed/simple;
	bh=p9OxylzOn1x+Z0h4DjLFmO+VL7+e+zX+Iqn1+qvIeRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CglaT1C9VLS96HJPUdMsXdtrF5QffbaytHjsdnUf0hc3tZnIrUMROWnm8UyZV/fwqmXiiJUR/PXUaYvjyPCbPzfOqVthemNdo5Kja9XwGK9UupirH4yiT2jpgJ3XnYz1SoaAKZoIlNsNTPaGBqSC1twIvF6+wzzTejf17C4pSlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hBRwMc1C; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=a7HhJSTSoQPpCiYuDEPoOl5BDkkqhEUMv1ZWqnafcSg=; b=hBRwMc1CNfCbXl3eGLoWH9NzIg
	THvOjaT7UR+pOLzJkzvocYiYsF8pTf6Y9lno92LbOadaN1rPHDTBzTkgYDXCDHfu288SLJI4XPZzL
	J8/PxZj7oudRpp2UVxjKEkVwJs0CBIZwo5BiiqKOy9AbHN4DOkPJoddEeU33+3PSKKRcGn6d9SyY4
	+3+n0Y5PWRiPj/OZE3QiKYmB1QtYlU72L2WpZ5Q9lXTIHQiOrkP0OTOtsabF/8zNNCgiTdaqulgwf
	cGPVf2wxdRAT7VKxEaqkno/6YSew/zfaQFZ4nPu1qJljI0gC2IweyroQvo2GCFSuYUDQJME/KrhAp
	1rin8wNg==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uUq9l-009491-3G; Thu, 26 Jun 2025 19:13:01 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 26 Jun 2025 14:11:26 -0300
Subject: [PATCH v5 2/7] selftests/futex: Create test for robust list
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250626-tonyk-robust_futex-v5-2-179194dbde8f@igalia.com>
References: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
In-Reply-To: <20250626-tonyk-robust_futex-v5-0-179194dbde8f@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Shuah Khan <shuah@kernel.org>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Create a test for the robust list mechanism. Test the following uAPI
operations:

- Creating a robust mutex where the lock waiter is wake by the kernel
  when the lock owner died
- Setting a robust list to the current task
- Getting a robust list from the current task
- Getting a robust list from another task
- Using the list_op_pending field from robust_list_head struct to test
  robustness when the lock owner dies before completing the locking
- Setting a invalid size for syscall argument `len`
- Adding multiple elements to a robust list wait waiting for each of
  them
- Creating a circular list and checking that the kernel does not get
  stuck in an infinity loop

This is the expected output:

 TAP version 13
 1..7
 ok 1 test_robustness
 ok 2 test_set_robust_list_invalid_size
 ok 3 test_get_robust_list_self
 ok 4 test_get_robust_list_child
 ok 5 test_set_list_op_pending
 ok 6 test_robust_list_multiple_elements
 ok 7 test_circular_list
 # Totals: pass:7 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../testing/selftests/futex/functional/.gitignore  |   1 +
 tools/testing/selftests/futex/functional/Makefile  |   3 +-
 .../selftests/futex/functional/robust_list.c       | 554 +++++++++++++++++++++
 3 files changed, 557 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index 7b24ae89594a9db211d4b8469ebcef8d1f7012d8..7f447ebfbc62bbad9add0dc86a75abcdb8a4d9a7 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -11,3 +11,4 @@ futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_waitv
+robust_list
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index 8cfb87f7f7c5059c82f1e6290c076d3f13f5ea41..e6fa66e622dee4de74c31c8b9b486ca01de35737 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -20,7 +20,8 @@ TEST_GEN_PROGS := \
 	futex_priv_hash \
 	futex_numa_mpol \
 	futex_waitv \
-	futex_numa
+	futex_numa \
+	robust_list
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
new file mode 100644
index 0000000000000000000000000000000000000000..42690b2440fd29a9b12c46f67f9645ccc93d1147
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -0,0 +1,554 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2024 Igalia S.L.
+ *
+ * Robust list test by André Almeida <andrealmeid@igalia.com>
+ *
+ * The robust list uAPI allows userspace to create "robust" locks, in the sense
+ * that if the lock holder thread dies, the remaining threads that are waiting
+ * for the lock won't block forever, waiting for a lock that will never be
+ * released.
+ *
+ * This is achieve by userspace setting a list where a thread can enter all the
+ * locks (futexes) that it is holding. The robust list is a linked list, and
+ * userspace register the start of the list with the syscall set_robust_list().
+ * If such thread eventually dies, the kernel will walk this list, waking up one
+ * thread waiting for each futex and marking the futex word with the flag
+ * FUTEX_OWNER_DIED.
+ *
+ * See also
+ *	man set_robust_list
+ *	Documententation/locking/robust-futex-ABI.rst
+ *	Documententation/locking/robust-futexes.rst
+ */
+
+#define _GNU_SOURCE
+
+#include "futextest.h"
+#include "logging.h"
+
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <stdatomic.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+
+#define STACK_SIZE (1024 * 1024)
+
+#define FUTEX_TIMEOUT 3
+
+static pthread_barrier_t barrier, barrier2;
+
+int set_robust_list(struct robust_list_head *head, size_t len)
+{
+	return syscall(SYS_set_robust_list, head, len);
+}
+
+int get_robust_list(int pid, struct robust_list_head **head, size_t *len_ptr)
+{
+	return syscall(SYS_get_robust_list, pid, head, len_ptr);
+}
+
+/*
+ * Basic lock struct, contains just the futex word and the robust list element
+ * Real implementations have also a *prev to easily walk in the list
+ */
+struct lock_struct {
+	_Atomic(unsigned int) futex;
+	struct robust_list list;
+};
+
+/*
+ * Helper function to spawn a child thread. Returns -1 on error, pid on success
+ */
+static int create_child(int (*fn)(void *arg), void *arg)
+{
+	char *stack;
+	pid_t pid;
+
+	stack = mmap(NULL, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS | MAP_STACK, -1, 0);
+	if (stack == MAP_FAILED)
+		return -1;
+
+	stack += STACK_SIZE;
+
+	pid = clone(fn, stack, CLONE_VM | SIGCHLD, arg);
+
+	if (pid == -1)
+		return -1;
+
+	return pid;
+}
+
+/*
+ * Helper function to prepare and register a robust list
+ */
+static int set_list(struct robust_list_head *head)
+{
+	int ret;
+
+	ret = set_robust_list(head, sizeof(struct robust_list_head));
+	if (ret)
+		return ret;
+
+	head->futex_offset = (size_t) offsetof(struct lock_struct, futex) -
+			     (size_t) offsetof(struct lock_struct, list);
+	head->list.next = &head->list;
+	head->list_op_pending = NULL;
+
+	return 0;
+}
+
+/*
+ * A basic (and incomplete) mutex lock function with robustness
+ */
+static int mutex_lock(struct lock_struct *lock, struct robust_list_head *head, bool error_inject)
+{
+	_Atomic(unsigned int) *futex = &lock->futex;
+	unsigned int zero = 0;
+	int ret = -1;
+	pid_t tid = gettid();
+
+	/*
+	 * Set list_op_pending before starting the lock, so the kernel can catch
+	 * the case where the thread died during the lock operation
+	 */
+	head->list_op_pending = &lock->list;
+
+	if (atomic_compare_exchange_strong(futex, &zero, tid)) {
+		/*
+		 * We took the lock, insert it in the robust list
+		 */
+		struct robust_list *list = &head->list;
+
+		/* Error injection to test list_op_pending */
+		if (error_inject)
+			return 0;
+
+		while (list->next != &head->list)
+			list = list->next;
+
+		list->next = &lock->list;
+		lock->list.next = &head->list;
+
+		ret = 0;
+	} else {
+		/*
+		 * We didn't take the lock, wait until the owner wakes (or dies)
+		 */
+		struct timespec to;
+
+		to.tv_sec = FUTEX_TIMEOUT;
+		to.tv_nsec = 0;
+
+		tid = atomic_load(futex);
+		/* Kernel ignores futexes without the waiters flag */
+		tid |= FUTEX_WAITERS;
+		atomic_store(futex, tid);
+
+		ret = futex_wait((futex_t *) futex, tid, &to, 0);
+
+		/*
+		 * A real mutex_lock() implementation would loop here to finally
+		 * take the lock. We don't care about that, so we stop here.
+		 */
+	}
+
+	head->list_op_pending = NULL;
+
+	return ret;
+}
+
+/*
+ * This child thread will succeed taking the lock, and then will exit holding it
+ */
+static int child_fn_lock(void *arg)
+{
+	struct lock_struct *lock = (struct lock_struct *) arg;
+	struct robust_list_head head;
+	int ret;
+
+	ret = set_list(&head);
+	if (ret)
+		ksft_test_result_fail("set_robust_list error\n");
+
+	ret = mutex_lock(lock, &head, false);
+	if (ret)
+		ksft_test_result_fail("mutex_lock error\n");
+
+	pthread_barrier_wait(&barrier);
+
+	/*
+	 * There's a race here: the parent thread needs to be inside
+	 * futex_wait() before the child thread dies, otherwise it will miss the
+	 * wakeup from handle_futex_death() that this child will emit. We wait a
+	 * little bit just to make sure that this happens.
+	 */
+	sleep(1);
+
+	return 0;
+}
+
+/*
+ * Spawns a child thread that will set a robust list, take the lock, register it
+ * in the robust list and die. The parent thread will wait on this futex, and
+ * should be waken up when the child exits.
+ */
+static void test_robustness(void)
+{
+	struct lock_struct lock = { .futex = 0 };
+	struct robust_list_head head;
+	_Atomic(unsigned int) *futex = &lock.futex;
+	int ret;
+
+	ret = set_list(&head);
+	ASSERT_EQ(ret, 0);
+
+	/*
+	 * Lets use a barrier to ensure that the child thread takes the lock
+	 * before the parent
+	 */
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	ret = create_child(&child_fn_lock, &lock);
+	ASSERT_NE(ret, -1);
+
+	pthread_barrier_wait(&barrier);
+	ret = mutex_lock(&lock, &head, false);
+
+	/*
+	 * futex_wait() should return 0 and the futex word should be marked with
+	 * FUTEX_OWNER_DIED
+	 */
+	ASSERT_EQ(ret, 0);
+	if (ret != 0)
+		printf("futex wait returned %d", errno);
+
+	ASSERT_TRUE(*futex | FUTEX_OWNER_DIED);
+
+	wait(NULL);
+	pthread_barrier_destroy(&barrier);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+/*
+ * The only valid value for len is sizeof(*head)
+ */
+static void test_set_robust_list_invalid_size(void)
+{
+	struct robust_list_head head;
+	size_t head_size = sizeof(struct robust_list_head);
+	int ret;
+
+	ret = set_robust_list(&head, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret = set_robust_list(&head, head_size * 2);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = set_robust_list(&head, head_size - 1);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = set_robust_list(&head, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+/*
+ * Test get_robust_list with pid = 0, getting the list of the running thread
+ */
+static void test_get_robust_list_self(void)
+{
+	struct robust_list_head head, head2, *get_head;
+	size_t head_size = sizeof(struct robust_list_head), len_ptr;
+	int ret;
+
+	ret = set_robust_list(&head, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret = get_robust_list(0, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(get_head, &head);
+	ASSERT_EQ(head_size, len_ptr);
+
+	ret = set_robust_list(&head2, head_size);
+	ASSERT_EQ(ret, 0);
+
+	ret = get_robust_list(0, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(get_head, &head2);
+	ASSERT_EQ(head_size, len_ptr);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_list(void *arg)
+{
+	struct robust_list_head *head = (struct robust_list_head *) arg;
+	int ret;
+
+	ret = set_robust_list(head, sizeof(struct robust_list_head));
+	if (ret)
+		ksft_test_result_fail("set_robust_list error\n");
+
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_wait(&barrier2);
+
+	return 0;
+}
+
+/*
+ * Test get_robust_list from another thread. We use two barriers here to ensure
+ * that:
+ *   1) the child thread set the list before we try to get it from the
+ * parent
+ *   2) the child thread still alive when we try to get the list from it
+ */
+static void test_get_robust_list_child(void)
+{
+	pid_t tid;
+	int ret;
+	struct robust_list_head head, *get_head;
+	size_t len_ptr;
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ret = pthread_barrier_init(&barrier2, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	tid = create_child(&child_list, &head);
+	ASSERT_NE(tid, -1);
+
+	pthread_barrier_wait(&barrier);
+
+	ret = get_robust_list(tid, &get_head, &len_ptr);
+	ASSERT_EQ(ret, 0);
+	ASSERT_EQ(&head, get_head);
+
+	pthread_barrier_wait(&barrier2);
+
+	wait(NULL);
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_fn_lock_with_error(void *arg)
+{
+	struct lock_struct *lock = (struct lock_struct *) arg;
+	struct robust_list_head head;
+	int ret;
+
+	ret = set_list(&head);
+	if (ret)
+		ksft_test_result_fail("set_robust_list error\n");
+
+	ret = mutex_lock(lock, &head, true);
+	if (ret)
+		ksft_test_result_fail("mutex_lock error\n");
+
+	pthread_barrier_wait(&barrier);
+
+	sleep(1);
+
+	return 0;
+}
+
+/*
+ * Same as robustness test, but inject an error where the mutex_lock() exits
+ * earlier, just after setting list_op_pending and taking the lock, to test the
+ * list_op_pending mechanism
+ */
+static void test_set_list_op_pending(void)
+{
+	struct lock_struct lock = { .futex = 0 };
+	struct robust_list_head head;
+	_Atomic(unsigned int) *futex = &lock.futex;
+	int ret;
+
+	ret = set_list(&head);
+	ASSERT_EQ(ret, 0);
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	ret = create_child(&child_fn_lock_with_error, &lock);
+	ASSERT_NE(ret, -1);
+
+	pthread_barrier_wait(&barrier);
+	ret = mutex_lock(&lock, &head, false);
+
+	ASSERT_EQ(ret, 0);
+	if (ret != 0)
+		printf("futex wait returned %d", errno);
+
+	ASSERT_TRUE(*futex | FUTEX_OWNER_DIED);
+
+	wait(NULL);
+	pthread_barrier_destroy(&barrier);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+#define CHILD_NR 10
+
+static int child_lock_holder(void *arg)
+{
+	struct lock_struct *locks = (struct lock_struct *) arg;
+	struct robust_list_head head;
+	int i;
+
+	set_list(&head);
+
+	for (i = 0; i < CHILD_NR; i++) {
+		locks[i].futex = 0;
+		mutex_lock(&locks[i], &head, false);
+	}
+
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_wait(&barrier2);
+
+	sleep(1);
+	return 0;
+}
+
+static int child_wait_lock(void *arg)
+{
+	struct lock_struct *lock = (struct lock_struct *) arg;
+	struct robust_list_head head;
+	int ret;
+
+	pthread_barrier_wait(&barrier2);
+	ret = mutex_lock(lock, &head, false);
+
+	if (ret)
+		ksft_test_result_fail("mutex_lock error\n");
+
+	if (!(lock->futex | FUTEX_OWNER_DIED))
+		ksft_test_result_fail("futex not marked with FUTEX_OWNER_DIED\n");
+
+	return 0;
+}
+
+/*
+ * Test a robust list of more than one element. All the waiters should wake when
+ * the holder dies
+ */
+static void test_robust_list_multiple_elements(void)
+{
+	struct lock_struct locks[CHILD_NR];
+	int i, ret;
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+	ret = pthread_barrier_init(&barrier2, NULL, CHILD_NR + 1);
+	ASSERT_EQ(ret, 0);
+
+	create_child(&child_lock_holder, &locks);
+
+	/* Wait until the locker thread takes the look */
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < CHILD_NR; i++)
+		create_child(&child_wait_lock, &locks[i]);
+
+	/* Wait for all children to return */
+	while (wait(NULL) > 0);
+
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+static int child_circular_list(void *arg)
+{
+	static struct robust_list_head head;
+	struct lock_struct a, b, c;
+	int ret;
+
+	ret = set_list(&head);
+	if (ret)
+		ksft_test_result_fail("set_list error\n");
+
+	head.list.next = &a.list;
+
+	/*
+	 * The last element should point to head list, but we short circuit it
+	 */
+	a.list.next = &b.list;
+	b.list.next = &c.list;
+	c.list.next = &a.list;
+
+	return 0;
+}
+
+/*
+ * Create a circular robust list. The kernel should be able to destroy the list
+ * while processing it so it won't be trapped in an infinite loop while handling
+ * a process exit
+ */
+static void test_circular_list(void)
+{
+	create_child(child_circular_list, NULL);
+
+	wait(NULL);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -c	Use color\n");
+	printf("  -h	Display this help message\n");
+	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+}
+
+int main(int argc, char *argv[])
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
+		switch (c) {
+		case 'c':
+			log_color(1);
+			break;
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	ksft_print_header();
+	ksft_set_plan(7);
+
+	test_robustness();
+
+	test_set_robust_list_invalid_size();
+	test_get_robust_list_self();
+	test_get_robust_list_child();
+	test_set_list_op_pending();
+	test_robust_list_multiple_elements();
+	test_circular_list();
+
+	ksft_print_cnts();
+	return 0;
+}

-- 
2.49.0


