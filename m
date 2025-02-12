Return-Path: <linux-kselftest+bounces-26466-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 96933A326A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 14:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AF717A254B
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 13:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E453A20E027;
	Wed, 12 Feb 2025 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="X/3wr0Ht"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BEF3209F4B;
	Wed, 12 Feb 2025 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739365913; cv=none; b=UdwRTiPCHQFGoLyYfDTE+xSbXUEaERTkn2LajUS4cvRrq42AiCD9p6JA+CNpxsJPFqCf++wshE8GEg9RP3BM/KV9UnDU8lzXr8RfC+quDx0QeQb8yIs5gYx5NSkBVzGkhRtB301hCuzxVFSU0As82oRVW4MThaHf6CSE5fSnBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739365913; c=relaxed/simple;
	bh=IgDiC1BcWkK/olWnCwy0mDU9aVI1Hr5H66/GovAH3Uk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5Rfi+Lug/aghJ+0+WShyFzHf/Tu06BewYLFVsNqHXDMSxIF7z6C9jOIbQGXvTCl5pIM5J6FQCSQ6/bP4lOC8sFTGY67h9Uw/8oA+oTJuYcTTY6HdNu3fX/NlEglizSz8lJbaCKdI0ECyga04gzERrwy0eFBrYOTAyZiPOP5JWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=X/3wr0Ht; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VkQwyk0cOJO6HiXnT9sqp/kuPN8by9tTk6usXkAEolk=; b=X/3wr0HtoLnQshC4hvQnHDkkgE
	z/6ZYaOPtxGY3bNdJWZZCn6Aplb2Ga2VkayCQZ9QYeBFkei9s8x3d2Al6zgkLnmDfXVZBx5cqSCe7
	SrKf02MYc5Q8PQyCYW8Sm4Iy0TTp1yXTRGMLWFoSJ423M3vkpiyFIJtDhVixPWtUmSMs6+J8Pl2/C
	rK9ojAQ4H6/RFxCG/hl/mjVAl+23H6KnD363ktqOG4wsO8nJSIYeZopJH9oyktqcurHOlFgX0UwZD
	ybemIJK0s0zlif+aAnArdKtt5c5c5yTOVjXLlNTMfXhLUtuTAnVQwM2k77FjP55EhRXq89qNbcBrF
	dSoVOQpQ==;
Received: from [191.204.194.148] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1tiCWU-008HIt-1W; Wed, 12 Feb 2025 14:11:32 +0100
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kernel-dev@igalia.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 2/2] selftests/futex: Create test for robust list
Date: Wed, 12 Feb 2025 10:11:23 -0300
Message-ID: <20250212131123.37431-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250212131123.37431-1-andrealmeid@igalia.com>
References: <20250212131123.37431-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Changelog:

v5:
 - Added circular list test
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/robust_list.c  | 554 ++++++++++++++++++
 3 files changed, 557 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/robust_list.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/testing/selftests/futex/functional/.gitignore
index fbcbdb6963b3..4726e1be7497 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -9,3 +9,4 @@ futex_wait_wouldblock
 futex_wait
 futex_requeue
 futex_waitv
+robust_list
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testing/selftests/futex/functional/Makefile
index f79f9bac7918..b8635a1ac7f6 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -17,7 +17,8 @@ TEST_GEN_PROGS := \
 	futex_wait_private_mapped_file \
 	futex_wait \
 	futex_requeue \
-	futex_waitv
+	futex_waitv \
+	robust_list
 
 TEST_PROGS := run.sh
 
diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
new file mode 100644
index 000000000000..42690b2440fd
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
2.48.1


