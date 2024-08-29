Return-Path: <linux-kselftest+bounces-16714-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14200964DB8
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 20:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 222721C22854
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 18:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFAB1B29D5;
	Thu, 29 Aug 2024 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Gb4h82BX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9024D59F;
	Thu, 29 Aug 2024 18:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956553; cv=none; b=TLnyLRAq1X7dqrJBXtkTM0tfeTeNv2R917Radst/h4ckJl8oANrSroOU2lzeWRxhle14l9RZan6kWDwCwnymyakD3vCflSQXpPr9Wof7KhGHvZmDlnjRG1Dvyv9Qpo9FfuHF5CbhbnEH9pH/Z8MFQIVmVRStKUKmC4RFinv5bRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956553; c=relaxed/simple;
	bh=wVlzubrhl8me3pktlcYB9t8OxWQeRqTssyNf8HMscOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d8ZRPSmAfHrYjJ54fwqUpb71yOTllLOkctUTVsabX2tZOmKKmdqF5X63sEKaqp6ue6u/Cm94J6OvAvOw0/5gdDWSDHYC1bgAnVhwzZM8lhvoxT0g2WAcydB9TT6Rw6XM1ktbK4sRaCqWmFCXUH3HvCVuYNDrdl6B9/p2BZJhSMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Gb4h82BX; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=murwYKquf/wnpI4nZOyolNgeGVMs6mWKwkIkxY+alMo=; b=Gb4h82BX3RrGMpQC1by8ISPvV6
	B+v55q8luZoCXqt098lwHF9UoXxzXacCTggdEPVKHfE1j90hinsdrf+8iXKWBB7umB2HoMXWEDF8P
	IzZgN5uUdaC7sF6GFUjFezMdoqFYp9mYAT9TQlAp4/PDP6h+FBRT1n5l0Aahqff0kWAl68FsROgi/
	+GUvCklTkgaShbRNWH6xfuUHioaLs95C/SrYkSTLOa1QyhjqiItzJc8G7sR4AWx2YVzBp4rUsJNV1
	Y2qJji95ccJXxmEBTeQo9eLb30gJgeRdxDzHF3O8OrKwRPue7NlmOiMZ3/gF81FYj7Ep+Zub4Chu8
	du/C9Trw==;
Received: from [177.172.124.139] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sjjzI-006qwq-DT; Thu, 29 Aug 2024 20:35:16 +0200
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
Subject: [PATCH] selftests/futex: Create test for robust list
Date: Thu, 29 Aug 2024 15:35:09 -0300
Message-ID: <20240829183509.446934-1-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Create a test for the robust list mechanism.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/.gitignore     |   1 +
 .../selftests/futex/functional/Makefile       |   3 +-
 .../selftests/futex/functional/robust_list.c  | 450 ++++++++++++++++++
 3 files changed, 453 insertions(+), 1 deletion(-)
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
index 000000000000..5cc0edaaf028
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Igalia, 2024
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
+#include "../../kselftest_harness.h"
+
+#include "futextest.h"
+
+#include <pthread.h>
+#include <stdatomic.h>
+#include <stddef.h>
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
+int futex2_wait(void *futex, int val, struct timespec *timo)
+{
+	return syscall(SYS_futex_wait, futex, val, ~0U, FUTEX2_SIZE_U32, timo, CLOCK_MONOTONIC);
+}
+
+/*
+ * Basic lock struct, contains just the futex word and the robust list element
+ * Real implementations have also a *prev to easily walk in the list
+ */
+struct lock_struct {
+	int futex;
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
+	int *futex = &lock->futex, zero = 0, ret = -1;
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
+		clock_gettime(CLOCK_MONOTONIC, &to);
+		to.tv_sec = to.tv_sec + FUTEX_TIMEOUT;
+
+		tid = atomic_load(futex);
+		/* Kernel ignores futexes without the waiters flag */
+		tid |= FUTEX_WAITERS;
+		atomic_store(futex, tid);
+
+		ret = futex2_wait(futex, tid, &to);
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
+TEST(robustness)
+{
+	struct lock_struct lock = { .futex = 0 };
+	struct robust_list_head head;
+	int ret, *futex = &lock.futex;
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
+	ASSERT_EQ(ret, 0) TH_LOG("futex wait returned %d", errno);
+	ASSERT_TRUE(*futex | FUTEX_OWNER_DIED);
+
+	pthread_barrier_destroy(&barrier);
+}
+
+/*
+ * The only valid value for len is sizeof(*head)
+ */
+TEST(set_robust_list_invalid_size)
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
+}
+
+/*
+ * Test get_robust_list with pid = 0, getting the list of the running thread
+ */
+TEST(get_robust_list_self)
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
+TEST(get_robust_list_child)
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
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
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
+TEST(set_list_op_pending)
+{
+	struct lock_struct lock = { .futex = 0 };
+	struct robust_list_head head;
+	int ret, *futex = &lock.futex;
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
+	ASSERT_EQ(ret, 0) TH_LOG("futex wait returned %d", errno);
+	ASSERT_TRUE(*futex | FUTEX_OWNER_DIED);
+
+	pthread_barrier_destroy(&barrier);
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
+TEST(robust_list_multiple_elements)
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
+}
+
+TEST_HARNESS_MAIN
-- 
2.46.0


