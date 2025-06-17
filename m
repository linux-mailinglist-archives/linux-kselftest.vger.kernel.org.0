Return-Path: <linux-kselftest+bounces-35231-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136DFADDB78
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 20:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44211189DB3C
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Jun 2025 18:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA5D2F2702;
	Tue, 17 Jun 2025 18:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WiU+lJis"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8397C2F94A1;
	Tue, 17 Jun 2025 18:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750185334; cv=none; b=sfD30NOzFY2RT6fUIAXqf37G3DAH5xQbpXPJLKTLDCPo3uavv1M6nePXyGfLaFJdfoYz2sTfdzhzVpremR9nh+xmw/5v/LdRe9VU/RzvyuDUyA/RlbX5TO5PO09yT5ddA/3fAaqW5ptYWcFcbzqujrNwTUE0q8btGSH11y2DXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750185334; c=relaxed/simple;
	bh=PecueBhb3qx1RHFBN98VuO4lhdtWIZM9jToHkTc/HLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CCWPivZ5t3xoloCACOa/veBi9ObqRZBcQbdlVotdBPN8ABlo5qhXxqy9FQSWsNCHRvDUbNldCPBDWOJnE6jHZAiWzgek9fPke7FrOs5Ua6SKeVI+NE/SRu8nuXHafqcaY0Cl0lfgjDrZnCdypU2dG6vS0x54zJod6mnf7LSlUmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WiU+lJis; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=N5VA/SwJ6w5fExHAtI2s26hUsQkblQRmCfj6Ybce2s4=; b=WiU+lJis5rhkm3wXROIn8wWZN6
	1I6y8gGWwWryS5WSvWNumDuNqyc+S+r+S3/hpmGqdolYgxzetUifU6aYcfNdW496COWhFdhGtfelK
	drv4oKxqI90UzEs+pV068X9ZRlvP4VBuLWG6yWEB6TZW3sJOswkDY/b9sNpvRZHiRU5Su/uVMUbaz
	i3DRjLxUpV3LVuX6qv79iye5WOwPC+LOrBHAy/8QLNPB2EZ8eL8fUstEp+gkdqA62FBGPu+ts9UI2
	tAOEai3yqYV8uG+8nIotb5bbTyZjE/oWM6BQiXpJI7A7UobWIXrtHJJB25pRqAwA3MGqNzRsN7Ypp
	1vjWUvvg==;
Received: from [191.204.192.64] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1uRb9W-004j89-8N; Tue, 17 Jun 2025 20:35:22 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Tue, 17 Jun 2025 15:34:24 -0300
Subject: [PATCH RESEND v4 7/7] selftests: futex: Expand robust list test
 for the new interface
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250617-tonyk-robust_futex-v4-7-6586f5fb9d33@igalia.com>
References: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
In-Reply-To: <20250617-tonyk-robust_futex-v4-0-6586f5fb9d33@igalia.com>
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

Expand the current robust list test for the new set_robust_list2
syscall. Create an option to make it possible to run the same tests
using the new syscall, and also add two new relevant test: test long
lists (bigger than ROBUST_LIST_LIMIT) and for unaligned addresses.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/robust_list.c       | 160 ++++++++++++++++++++-
 1 file changed, 156 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
index 42690b2440fd29a9b12c46f67f9645ccc93d1147..004ad79ff6171c411fd47e699e3c38889544218e 100644
--- a/tools/testing/selftests/futex/functional/robust_list.c
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -35,16 +35,45 @@
 #include <stddef.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <stdint.h>
 
 #define STACK_SIZE (1024 * 1024)
 
 #define FUTEX_TIMEOUT 3
 
+#define SYS_set_robust_list2 468
+
+enum robust_list2_type {
+        ROBUST_LIST_32BIT,
+        ROBUST_LIST_64BIT,
+};
+
 static pthread_barrier_t barrier, barrier2;
 
+bool robust2 = false;
+
 int set_robust_list(struct robust_list_head *head, size_t len)
 {
-	return syscall(SYS_set_robust_list, head, len);
+	int ret, flags;
+
+	if (!robust2) {
+		return syscall(SYS_set_robust_list, head, len);
+	}
+
+	if (sizeof(head) == 8)
+		flags = ROBUST_LIST_64BIT;
+	else
+		flags = ROBUST_LIST_32BIT;
+
+	/*
+	 * We act as we have just one list here. We try to use the first slot,
+	 * but if it hasn't been alocated yet we allocate it.
+	 */
+	ret = syscall(SYS_set_robust_list2, head, 0, flags);
+	if (ret == -1 && errno == ENOENT)
+		ret = syscall(SYS_set_robust_list2, head, -1, flags);
+
+	return ret;
 }
 
 int get_robust_list(int pid, struct robust_list_head **head, size_t *len_ptr)
@@ -246,6 +275,11 @@ static void test_set_robust_list_invalid_size(void)
 	size_t head_size = sizeof(struct robust_list_head);
 	int ret;
 
+	if (robust2) {
+		ksft_test_result_skip("This test is only for old robust interface\n");
+		return;
+	}
+
 	ret = set_robust_list(&head, head_size);
 	ASSERT_EQ(ret, 0);
 
@@ -321,6 +355,11 @@ static void test_get_robust_list_child(void)
 	struct robust_list_head head, *get_head;
 	size_t len_ptr;
 
+	if (robust2) {
+		ksft_test_result_skip("Not implemented in the new robust interface\n");
+		return;
+	}
+
 	ret = pthread_barrier_init(&barrier, NULL, 2);
 	ret = pthread_barrier_init(&barrier2, NULL, 2);
 	ASSERT_EQ(ret, 0);
@@ -332,7 +371,7 @@ static void test_get_robust_list_child(void)
 
 	ret = get_robust_list(tid, &get_head, &len_ptr);
 	ASSERT_EQ(ret, 0);
-	ASSERT_EQ(&head, get_head);
+	ASSERT_EQ(get_head, &head);
 
 	pthread_barrier_wait(&barrier2);
 
@@ -507,11 +546,119 @@ static void test_circular_list(void)
 	ksft_test_result_pass("%s\n", __func__);
 }
 
+#define ROBUST_LIST_LIMIT	2048
+#define CHILD_LIST_LIMIT (ROBUST_LIST_LIMIT + 10)
+
+static int child_robust_list_limit(void *arg)
+{
+	struct lock_struct *locks;
+	struct robust_list *list;
+	struct robust_list_head head;
+	int ret, i;
+
+	locks = (struct lock_struct *) arg;
+
+	ret = set_list(&head);
+	if (ret)
+		ksft_test_result_fail("set_list error\n");
+
+	/*
+	 * Create a very long list of locks
+	 */
+	head.list.next = &locks[0].list;
+
+	list = head.list.next;
+	for (i = 0; i < CHILD_LIST_LIMIT - 1; i++) {
+		list->next = &locks[i+1].list;
+		list = list->next;
+	}
+	list->next = &head.list;
+
+	/*
+	 * Grab the lock in the last one, and die without releasing it
+	 */
+	mutex_lock(&locks[CHILD_LIST_LIMIT], &head, false);
+	pthread_barrier_wait(&barrier);
+
+	sleep(1);
+
+	return 0;
+}
+
+/*
+ * The old robust list used to have a limit of 2048 items from the kernel side.
+ * After this limit the kernel stops walking the list and ignore the other
+ * futexes, causing deadlocks.
+ *
+ * For the new interface, test if we can wait for a list of more than 2048
+ * elements.
+ */
+static void test_robust_list_limit(void)
+{
+	struct lock_struct locks[CHILD_LIST_LIMIT + 1];
+	_Atomic(unsigned int) *futex = &locks[CHILD_LIST_LIMIT].futex;
+	struct robust_list_head head;
+	int ret;
+
+	if (!robust2) {
+		ksft_test_result_skip("This test is only for new robust interface\n");
+		return;
+	}
+
+	*futex = 0;
+
+	ret = set_list(&head);
+	ASSERT_EQ(ret, 0);
+
+	ret = pthread_barrier_init(&barrier, NULL, 2);
+	ASSERT_EQ(ret, 0);
+
+	create_child(child_robust_list_limit, locks);
+
+	/*
+	 * After the child thread creates the very long list of locks, wait on
+	 * the last one.
+	 */
+	pthread_barrier_wait(&barrier);
+	ret = mutex_lock(&locks[CHILD_LIST_LIMIT], &head, false);
+
+	if (ret != 0)
+		printf("futex wait returned %d\n", errno);
+	ASSERT_EQ(ret, 0);
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
+ * The kernel should refuse an unaligned head pointer
+ */
+static void test_unaligned_address(void)
+{
+	struct robust_list_head head, *h;
+	int ret;
+
+	if (!robust2) {
+		ksft_test_result_skip("This test is only for new robust interface\n");
+		return;
+	}
+
+	h = (struct robust_list_head *) ((uintptr_t) &head + 1);
+	ret = set_list(h);
+	ASSERT_EQ(ret, -1);
+	ASSERT_EQ(errno, EINVAL);
+}
+
 void usage(char *prog)
 {
 	printf("Usage: %s\n", prog);
 	printf("  -c	Use color\n");
 	printf("  -h	Display this help message\n");
+	printf("  -n	Use robust2 syscall\n");
 	printf("  -v L	Verbosity level: %d=QUIET %d=CRITICAL %d=INFO\n",
 	       VQUIET, VCRITICAL, VINFO);
 }
@@ -520,7 +667,7 @@ int main(int argc, char *argv[])
 {
 	int c;
 
-	while ((c = getopt(argc, argv, "cht:v:")) != -1) {
+	while ((c = getopt(argc, argv, "chnt:v:")) != -1) {
 		switch (c) {
 		case 'c':
 			log_color(1);
@@ -531,6 +678,9 @@ int main(int argc, char *argv[])
 		case 'v':
 			log_verbosity(atoi(optarg));
 			break;
+		case 'n':
+			robust2 = true;
+			break;
 		default:
 			usage(basename(argv[0]));
 			exit(1);
@@ -538,7 +688,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(7);
+	ksft_set_plan(8);
 
 	test_robustness();
 
@@ -548,6 +698,8 @@ int main(int argc, char *argv[])
 	test_set_list_op_pending();
 	test_robust_list_multiple_elements();
 	test_circular_list();
+	test_robust_list_limit();
+	test_unaligned_address();
 
 	ksft_print_cnts();
 	return 0;

-- 
2.49.0


