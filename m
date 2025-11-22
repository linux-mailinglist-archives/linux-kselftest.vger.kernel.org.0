Return-Path: <linux-kselftest+bounces-46307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1CEC7C83F
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E8766360A4E
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CB82D193C;
	Sat, 22 Nov 2025 05:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="dVfge20E"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807862BEFE8;
	Sat, 22 Nov 2025 05:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790697; cv=none; b=fKEGtA63ArXRyeXcYAf7d/cvDCn1Cg58tnMS+JF8lC11f3SulAtdEQQdtz3hq6JCFeslTce15m+HP6KpdymV1wXvzRNt1XLUps0qgiylhhEnmLlWweo9qnftQO7BWt3Pv2MSD2uQxKNDXllzUI5EKz+PT/aFak5LUUWuSH1rJO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790697; c=relaxed/simple;
	bh=nso+CpOJpPRJzd43Dl8ff2FCkPlbBHzXlwd/WnDkI78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b26gnVOJ0RQ+sUs9KEfcoJtf4Va0OLCJZNUcyyAj9II5qdY7gZN28xqb1LrnoU4WLg/5Cw4zl3BO9Ag0eLkssZAdckkEJ4qxC5HM3nA2qYOXy/oZSv7EtE55myihkvXQVpt0CEw0j3Cdo1yH/OzMLGDshs10bzJPXNn6SeBeMRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=dVfge20E; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+L/tOyy8M0DyWtdQicdo29LsLyCaZTO29YU1zlSFePI=; b=dVfge20E/ggOVpv5kMRv3uE5gE
	q9Q2RWKPO/DHN0u+1ptRIclNYiG4+f24klHjLQANR39drTY0FfsUJIk8VlFj2AKXksOpC7NkUzRg8
	HjKW2g1tHYbjK7c/TEb6UCr+wq11+wG0XdkUVFFmNxABqF0HzJA3j6XGqJx/Ym7ls5aiqzlI5Lnx7
	+IlKx/X6qNkwqX03wRqEBYrjTDxj1TggyjUO+AeEh75iD4hsnqLI86SwX8j4PXUGQdu2lNOLji8Sk
	v2no1CfBkZNkc1hBlPz3ze4ll5Uooj34pRfGDcepfbAsxaDjiBjOTV41LJ22yfGZx4DBk13cf8/ph
	SPloxU4Q==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWv-003xEt-Gs; Sat, 22 Nov 2025 06:51:29 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:49 -0300
Subject: [PATCH v6 7/9] selftests/futex: Expand for set_robust_list2()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-7-05fea005a0fd@igalia.com>
References: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
In-Reply-To: <20251122-tonyk-robust_futex-v6-0-05fea005a0fd@igalia.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Darren Hart <dvhart@infradead.org>, 
 Davidlohr Bueso <dave@stgolabs.net>, Arnd Bergmann <arnd@arndb.de>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Waiman Long <longman@redhat.com>, Ryan Houdek <Sonicadvance1@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, kernel-dev@igalia.com, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.3

Reuse the same selftest for the original set_robust_list() syscall for
the new set_robust_list2() syscall. Use kselftest variants feature to
run the relevant tests for both interfaces. Create new test cases for
checking invalid parameters, the ability to correctly set multiple lists
for the same task, and to use 32-bit lists in a 64-bit task.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/robust_list.c       | 409 +++++++++++++++++++--
 1 file changed, 387 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
index e7d1254e18ca..bf47e9ab2951 100644
--- a/tools/testing/selftests/futex/functional/robust_list.c
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -42,6 +42,27 @@
 
 #define SLEEP_US 100
 
+#ifndef SYS_set_robust_list2
+# define SYS_set_robust_list2 470
+
+enum robust_list_cmd {
+	FUTEX_ROBUST_LIST_CMD_SET_64,
+	FUTEX_ROBUST_LIST_CMD_SET_32,
+	FUTEX_ROBUST_LIST_CMD_LIST_LIMIT,
+	FUTEX_ROBUST_LIST_CMD_USER_MAX,
+};
+
+struct robust_list32 {
+	uint32_t next;
+};
+
+struct robust_list_head32 {
+	struct robust_list32	list;
+	int32_t			futex_offset;
+	uint32_t		list_op_pending;
+};
+#endif
+
 static pthread_barrier_t barrier, barrier2;
 
 static int set_robust_list(struct robust_list_head *head, size_t len)
@@ -54,6 +75,58 @@ static int get_robust_list(int pid, struct robust_list_head **head, size_t *len_
 	return syscall(SYS_get_robust_list, pid, head, len_ptr);
 }
 
+static int set_robust_list2(struct robust_list_head *head, int index,
+			    enum robust_list_cmd cmd, unsigned int flags)
+{
+	return syscall(SYS_set_robust_list2, head, index, cmd, flags);
+}
+
+static bool robust_list2_support(void)
+{
+	int ret = set_robust_list2(0, 0, FUTEX_ROBUST_LIST_CMD_LIST_LIMIT, 0);
+
+	if (ret == -1 && errno == ENOSYS)
+		return false;
+
+	return true;
+}
+
+/*
+ * Return the set command according to the app bitness
+ */
+static int get_cmd_set(void)
+{
+	return sizeof(uintptr_t) == 8 ? FUTEX_ROBUST_LIST_CMD_SET_64 :
+	       FUTEX_ROBUST_LIST_CMD_SET_32;
+}
+
+FIXTURE(robust_api) {};
+
+FIXTURE_VARIANT(robust_api)
+{
+	bool robust2;
+};
+
+FIXTURE_SETUP(robust_api)
+{
+	if (!variant->robust2)
+		return;
+
+	ASSERT_NE(robust_list2_support(), false);
+}
+
+FIXTURE_TEARDOWN(robust_api) {}
+
+FIXTURE_VARIANT_ADD(robust_api, robust1)
+{
+	.robust2 = false,
+};
+
+FIXTURE_VARIANT_ADD(robust_api, robust2)
+{
+	.robust2 = true,
+};
+
 /*
  * Basic lock struct, contains just the futex word and the robust list element
  * Real implementations have also a *prev to easily walk in the list
@@ -61,6 +134,12 @@ static int get_robust_list(int pid, struct robust_list_head **head, size_t *len_
 struct lock_struct {
 	_Atomic(unsigned int)	futex;
 	struct robust_list	list;
+	bool			robust2;
+};
+
+struct lock_struct32 {
+	_Atomic(uint32_t)	futex;
+	struct robust_list32	list;
 };
 
 /*
@@ -89,20 +168,17 @@ static int create_child(int (*fn)(void *arg), void *arg)
 /*
  * Helper function to prepare and register a robust list
  */
-static int set_list(struct robust_list_head *head)
+static int set_list(struct robust_list_head *head, bool robust2, int index)
 {
-	int ret;
-
-	ret = set_robust_list(head, sizeof(*head));
-	if (ret)
-		return ret;
-
 	head->futex_offset = (size_t) offsetof(struct lock_struct, futex) -
 			     (size_t) offsetof(struct lock_struct, list);
 	head->list.next = &head->list;
 	head->list_op_pending = NULL;
 
-	return 0;
+	if (!robust2)
+		return set_robust_list(head, sizeof(*head));
+
+	return set_robust_list2(head, index, get_cmd_set(), 0);
 }
 
 /*
@@ -174,7 +250,7 @@ static int child_fn_lock(void *arg)
 	struct robust_list_head head;
 	int ret;
 
-	ret = set_list(&head);
+	ret = set_list(&head, lock->robust2, 0);
 	if (ret) {
 		ksft_test_result_fail("set_robust_list error\n");
 		return ret;
@@ -204,14 +280,16 @@ static int child_fn_lock(void *arg)
  * in the robust list and die. The parent thread will wait on this futex, and
  * should be waken up when the child exits.
  */
-TEST(test_robustness)
+TEST_F(robust_api, test_robustness)
 {
 	struct lock_struct lock = { .futex = 0 };
 	_Atomic(unsigned int) *futex = &lock.futex;
-	struct robust_list_head head;
 	int ret, pid, wstatus;
+	struct robust_list_head head;
 
-	ret = set_list(&head);
+	lock.robust2 = variant->robust2;
+
+	ret = set_list(&head, lock.robust2, 0);
 	ASSERT_EQ(ret, 0);
 
 	/*
@@ -270,6 +348,46 @@ TEST(test_set_robust_list_invalid_size)
 	ksft_test_result_pass("%s\n", __func__);
 }
 
+/*
+ * Test invalid parameters
+ */
+TEST(test_set_robust_list2_inval)
+{
+	struct robust_list_head head;
+	int ret, list_limit;
+
+	if (!robust_list2_support()) {
+		ksft_test_result_skip("robust_list2 not supported\n");
+		return;
+	}
+
+	/* Bad flag */
+	ret = set_robust_list2(&head, 0, get_cmd_set(), 999);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Bad index */
+	list_limit = set_robust_list2(NULL, 0, FUTEX_ROBUST_LIST_CMD_LIST_LIMIT, 0);
+	ASSERT_GT(list_limit, 0);
+
+	ret = set_robust_list2(&head, -1, get_cmd_set(), 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = set_robust_list2(&head, list_limit + 1, get_cmd_set(), 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	/* Bad command */
+	ret = set_robust_list2(&head, 0, FUTEX_ROBUST_LIST_CMD_USER_MAX, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+
+	ret = set_robust_list2(&head, 0, -1, 0);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
 /*
  * Test get_robust_list with pid = 0, getting the list of the running thread
  */
@@ -363,7 +481,7 @@ static int child_fn_lock_with_error(void *arg)
 	struct robust_list_head head;
 	int ret;
 
-	ret = set_list(&head);
+	ret = set_list(&head, false, 0);
 	if (ret) {
 		ksft_test_result_fail("set_robust_list error\n");
 		return -1;
@@ -388,14 +506,16 @@ static int child_fn_lock_with_error(void *arg)
  * earlier, just after setting list_op_pending and taking the lock, to test the
  * list_op_pending mechanism
  */
-TEST(test_set_list_op_pending)
+TEST_F(robust_api, test_set_list_op_pending)
 {
 	struct lock_struct lock = { .futex = 0 };
 	_Atomic(unsigned int) *futex = &lock.futex;
-	struct robust_list_head head;
 	int ret, wstatus;
+	struct robust_list_head head;
+
+	lock.robust2 = variant->robust2;
 
-	ret = set_list(&head);
+	ret = set_list(&head, lock.robust2, 0);
 	ASSERT_EQ(ret, 0);
 
 	ret = pthread_barrier_init(&barrier, NULL, 2);
@@ -429,7 +549,7 @@ static int child_lock_holder(void *arg)
 	struct robust_list_head head;
 	int i;
 
-	set_list(&head);
+	set_list(&head, locks[0].robust2, 0);
 
 	for (i = 0; i < CHILD_NR; i++) {
 		locks[i].futex = 0;
@@ -471,12 +591,19 @@ static int child_wait_lock(void *arg)
  * Test a robust list of more than one element. All the waiters should wake when
  * the holder dies
  */
-TEST(test_robust_list_multiple_elements)
+TEST_F(robust_api, test_robust_list_multiple_elements)
 {
 	struct lock_struct locks[CHILD_NR];
 	pid_t pids[CHILD_NR + 1];
 	int i, ret, wstatus;
 
+	if (!robust_list2_support()) {
+		ksft_test_result_skip("robust_list2 not supported\n");
+		return;
+	}
+
+	locks[0].robust2 = variant->robust2;
+
 	ret = pthread_barrier_init(&barrier, NULL, 2);
 	ASSERT_EQ(ret, 0);
 	ret = pthread_barrier_init(&barrier2, NULL, CHILD_NR + 1);
@@ -507,13 +634,98 @@ TEST(test_robust_list_multiple_elements)
 		ksft_test_result_pass("%s\n", __func__);
 }
 
+static int child_lock_holder_multiple_lists(void *arg)
+{
+	struct lock_struct *locks = arg;
+	struct robust_list_head *heads;
+	int i, list_limit;
+
+	list_limit = set_robust_list2(NULL, 0, FUTEX_ROBUST_LIST_CMD_LIST_LIMIT, 0);
+
+	heads = malloc(list_limit * sizeof(*heads));
+	if (!heads)
+		return -1;
+
+	for (i = 0; i < list_limit; i++) {
+		set_list(&heads[i], true, i);
+		locks[i].futex = 0;
+		mutex_lock(&locks[i], &heads[i], false);
+	}
+
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_wait(&barrier2);
+
+	/* See comment at child_fn_lock() */
+	usleep(SLEEP_US);
+
+	return 0;
+}
+
+/*
+ * Similar to test_robust_list_multiple_elements, but instead of one list with
+ * several elements, create several lists with one element.
+ */
+TEST(test_robust_list_multiple_lists)
+{
+	int i, ret, wstatus, list_limit;
+	struct lock_struct *locks;
+	pid_t *pids;
+
+	if (!robust_list2_support()) {
+		ksft_test_result_skip("robust_list2 not supported\n");
+		return;
+	}
+
+	list_limit = set_robust_list2(NULL, 0, FUTEX_ROBUST_LIST_CMD_LIST_LIMIT, 0);
+	ASSERT_GT(list_limit, 1);
+
+	locks = malloc(list_limit * sizeof(*locks));
+	ASSERT_NE(locks, NULL);
+
+	pids = malloc(list_limit * sizeof(*pids));
+	ASSERT_NE(pids, NULL);
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+	ret = pthread_barrier_init(&barrier2, NULL, list_limit + 1);
+	ASSERT_EQ(ret, 0);
+
+	pids[0] = create_child(&child_lock_holder_multiple_lists, locks);
+
+	/* Wait until the locker thread takes the look */
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < list_limit; i++)
+		pids[i+1] = create_child(&child_wait_lock, &locks[i]);
+
+	/* Wait for all children to return */
+	ret = 0;
+
+	for (i = 0; i < list_limit; i++) {
+		waitpid(pids[i], &wstatus, 0);
+		if (WEXITSTATUS(wstatus))
+			ret = -1;
+	}
+
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
+
+	/* Pass only if the child hasn't return error */
+	if (!ret)
+		ksft_test_result_pass("%s\n", __func__);
+
+	free(locks);
+	free(pids);
+}
+
 static int child_circular_list(void *arg)
 {
-	static struct robust_list_head head;
+	struct robust_list_head head;
 	struct lock_struct a, b, c;
+	bool robust2 = *(bool *) arg;
 	int ret;
 
-	ret = set_list(&head);
+	ret = set_list(&head, robust2, 0);
 	if (ret) {
 		ksft_test_result_fail("set_list error\n");
 		return -1;
@@ -536,11 +748,12 @@ static int child_circular_list(void *arg)
  * while processing it so it won't be trapped in an infinite loop while handling
  * a process exit
  */
-TEST(test_circular_list)
+TEST_F(robust_api, test_circular_list)
 {
 	int wstatus;
+	bool robust2 = variant->robust2;
 
-	create_child(child_circular_list, NULL);
+	create_child(child_circular_list, &robust2);
 
 	wait(&wstatus);
 
@@ -549,4 +762,156 @@ TEST(test_circular_list)
 		ksft_test_result_pass("%s\n", __func__);
 }
 
+/*
+ * 32-bit version of child_lock_holder. 
+ */
+static int child_lock_holder32(void *arg)
+{
+	struct lock_struct32 *locks = arg;
+	struct robust_list_head32 *head;
+	pid_t tid = gettid();
+	int i, ret;
+
+	head = mmap((void *)0x10000, sizeof(*head), PROT_READ | PROT_WRITE,
+		    MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	if (!head || ((uint32_t)(uintptr_t) head) > 0x7FFFFFFF) {
+		ksft_test_result_fail("child_lock_holder32 error\n");
+		return -1;
+	}
+
+	head->futex_offset = (uint32_t) ((size_t) offsetof(struct lock_struct32, futex) -
+			     (size_t) offsetof(struct lock_struct32, list));
+	head->list.next = (uint32_t)(uintptr_t) &head->list;
+	head->list_op_pending = (uint32_t)(uintptr_t) NULL;
+
+	ret = set_robust_list2((struct robust_list_head *) head, 0,
+			       FUTEX_ROBUST_LIST_CMD_SET_32, 0);
+	if (ret) {
+		ksft_test_result_fail("set_robust_list2 error\n");
+		return -1;
+	}
+
+	/*
+	 * Take all the locks and insert them in the list
+	 */
+	for (i = 0; i < CHILD_NR; i++) {
+		struct robust_list32 *list = &head->list;
+
+		locks[i].futex = tid;
+
+		while (list->next != (uint32_t)(uintptr_t) &head->list)
+			list = (struct robust_list32 *)(uintptr_t) list->next;
+
+		list->next = (uint32_t)(uintptr_t) &locks[i].list;
+		locks[i].list.next = (uint32_t)(uintptr_t) &head->list;
+	}
+
+	pthread_barrier_wait(&barrier);
+	pthread_barrier_wait(&barrier2);
+
+	/* See comment at child_fn_lock() */
+	usleep(SLEEP_US);
+
+	/* Exit holding all the locks */
+	return 0;
+}
+
+static int child_wait_lock32(void *arg)
+{
+	struct lock_struct32 *lock = arg;
+	_Atomic(unsigned int) *futex;
+	struct timespec to;
+	pid_t tid;
+	int ret;
+
+	futex = &lock->futex;
+
+	pthread_barrier_wait(&barrier2);
+
+	to.tv_sec = FUTEX_TIMEOUT;
+	to.tv_nsec = 0;
+
+	tid = atomic_load(futex);
+
+	/* Kernel ignores futexes without the waiters flag */
+	tid |= FUTEX_WAITERS;
+	atomic_store(futex, tid);
+
+	ret = futex_wait((futex_t *) futex, tid, &to, 0);
+
+	if (ret) {
+		ksft_test_result_fail("futex_wait error\n");
+		return -1;
+	}
+
+	if (!(lock->futex & FUTEX_OWNER_DIED)) {
+		ksft_test_result_fail("futex not marked with FUTEX_OWNER_DIED\n");
+		return -1;
+	}
+
+	return 0;
+}
+
+/*
+ * Test to create a 32-bit robust list in a 64-bit kernel. Replicate
+ * test_robust_list_multiple_elements, but it's simplified: don't do all the
+ * mutex lock dance, just insert futexes in the list and check if the kernel
+ * correctly walks the list and wake the threads
+ */
+TEST(test_32bit_lists)
+{
+	struct lock_struct32 *locks;
+	pid_t pids[CHILD_NR + 1];
+	int i, ret, wstatus;
+
+	if (sizeof(uintptr_t) != 8) {
+		ksft_test_result_skip("Test only for 64-bit\n");
+		return;
+	}
+
+	if (!robust_list2_support()) {
+		ksft_test_result_skip("robust_list2 not supported\n");
+		return;
+	}
+
+	locks = mmap((void *)0x20000, sizeof(*locks) * CHILD_NR,
+		     PROT_READ | PROT_WRITE, MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
+		     -1, 0);
+
+	ASSERT_NE(locks, NULL);
+	ASSERT_LT((uintptr_t) locks, 0x7FFFFFFF);
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+	ret = pthread_barrier_init(&barrier2, NULL, CHILD_NR + 1);
+	ASSERT_EQ(ret, 0);
+
+	pids[0] = create_child(&child_lock_holder32, locks);
+
+	/* Wait until the locker thread takes the look */
+	pthread_barrier_wait(&barrier);
+
+	for (i = 0; i < CHILD_NR; i++)
+		pids[i+1] = create_child(&child_wait_lock32, &locks[i]);
+
+	/* Wait for all children to return */
+	ret = 0;
+
+	for (i = 0; i < CHILD_NR; i++) {
+		waitpid(pids[i], &wstatus, 0);
+		if (WEXITSTATUS(wstatus))
+			ret = -1;
+	}
+
+	pthread_barrier_destroy(&barrier);
+	pthread_barrier_destroy(&barrier2);
+
+	/* Pass only if the child hasn't return error */
+	if (!ret)
+		ksft_test_result_pass("%s\n", __func__);
+
+	munmap(locks, sizeof(*locks) * CHILD_NR);
+}
+
 TEST_HARNESS_MAIN

-- 
2.52.0


