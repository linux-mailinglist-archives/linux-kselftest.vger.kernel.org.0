Return-Path: <linux-kselftest+bounces-46308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EA2C7C863
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 06:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE4A3A9716
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Nov 2025 05:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6192D12F5;
	Sat, 22 Nov 2025 05:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="iQsPBf/y"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE212BF3CC;
	Sat, 22 Nov 2025 05:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763790698; cv=none; b=RI2swh1CAaeuRJzb2CHn03ldRgb6fblD/lz1Pg+k5Q+S60lXvAbM7Rc9trBrDr4IXVYHdwu/co1JYTlb8Ze77a/ypzkt7dkRaxcxGOgW40iO5HJK6oYBE3j56xDYjlJzZgr+zfDsnyO7KeQpa1lbPHhdcrArRP9gG3IWiiTQ63I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763790698; c=relaxed/simple;
	bh=wuR9Um2tq6ZLxAMhCeO1aI1vzR2V/4QxRww9FgFxO+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tz9bZeQtS5sAQ9y6TNPp90lIMHBJzONIBRTDVjmvAh1AAXnaLpRhSj+dAnMvN4n6uFPjfVccT6YXBglUGLncqnBlzr0W7Gn4FdjdqjyIXg3NF2cMUTrrmEbcXjFXS/JWfqoCejLpD8FXt98+mSGhINg4KkUzSb5lFIDzKZdIkKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=iQsPBf/y; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LKeIFtce+QsZcKJRLYOqSL7Yn9CvqGTf+rY/2k+4SUM=; b=iQsPBf/y1zugpmsmXvi3q3F7vS
	fuxgWKGLLEHjAl84au4opyj/rlgtjvqPFyv/a4De1lpEp1lB6jxPEuTui78cofYIgHBq5gPrjUNq7
	B1Cr5xOA+vy9Z4ZBWKKR8/yA49ShiMYfsbsDsqNzfLIQ3qgtVRNX2aX2qOWXUB5CK/rHIV8dzOOrz
	x3jm4275/hL4Xlpbrz9AMRFUQTH1daXR5jlfs6OKCPImxn0azKI7VJmnpBvse5xsOhBsMpDfvAFOE
	dmobrJan9iSLCwk1yIAzcyVLK8qwyoHcfcllkRK8uTy64e/VIOydNwUIhFdjHsrp1E4b81JnifMpj
	Ooj0hBIQ==;
Received: from [187.101.0.152] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vMgWy-003xEt-Mh; Sat, 22 Nov 2025 06:51:32 +0100
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Sat, 22 Nov 2025 02:50:50 -0300
Subject: [PATCH v6 8/9] selftests/futex: Expand for get_robust_list2()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251122-tonyk-robust_futex-v6-8-05fea005a0fd@igalia.com>
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
run the relevant tests for both interfaces. Create a new test case to
get different lists from the same task.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 .../selftests/futex/functional/robust_list.c       | 95 ++++++++++++++++++----
 1 file changed, 81 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/robust_list.c b/tools/testing/selftests/futex/functional/robust_list.c
index bf47e9ab2951..e6b26d7b9502 100644
--- a/tools/testing/selftests/futex/functional/robust_list.c
+++ b/tools/testing/selftests/futex/functional/robust_list.c
@@ -44,6 +44,7 @@
 
 #ifndef SYS_set_robust_list2
 # define SYS_set_robust_list2 470
+# define SYS_get_robust_list2 471
 
 enum robust_list_cmd {
 	FUTEX_ROBUST_LIST_CMD_SET_64,
@@ -81,6 +82,12 @@ static int set_robust_list2(struct robust_list_head *head, int index,
 	return syscall(SYS_set_robust_list2, head, index, cmd, flags);
 }
 
+static int get_robust_list2(int pid, struct robust_list_head **head,
+			    unsigned int index, unsigned int flags)
+{
+	return syscall(SYS_get_robust_list2, pid, head, index, flags);
+}
+
 static bool robust_list2_support(void)
 {
 	int ret = set_robust_list2(0, 0, FUTEX_ROBUST_LIST_CMD_LIST_LIMIT, 0);
@@ -181,6 +188,23 @@ static int set_list(struct robust_list_head *head, bool robust2, int index)
 	return set_robust_list2(head, index, get_cmd_set(), 0);
 }
 
+static int get_list(pid_t pid, struct robust_list_head **head, bool robust2, int index)
+{
+	int ret;
+
+	if (!robust2) {
+		size_t len_ptr;
+
+		ret = get_robust_list(pid, head, &len_ptr);
+		if (sizeof(**head) != len_ptr)
+			return -EINVAL;
+
+		return ret;
+	}
+
+	return get_robust_list2(pid, head, index, 0);
+}
+
 /*
  * A basic (and incomplete) mutex lock function with robustness
  */
@@ -391,37 +415,44 @@ TEST(test_set_robust_list2_inval)
 /*
  * Test get_robust_list with pid = 0, getting the list of the running thread
  */
-TEST(test_get_robust_list_self)
+TEST_F(robust_api, test_get_robust_list_self)
 {
 	struct robust_list_head head, head2, *get_head;
-	size_t head_size = sizeof(head), len_ptr;
+	bool robust2 = variant->robust2;
 	int ret;
 
-	ret = set_robust_list(&head, head_size);
+	ret = set_list(&head, robust2, 0);
 	ASSERT_EQ(ret, 0);
 
-	ret = get_robust_list(0, &get_head, &len_ptr);
+	ret = get_list(0, &get_head, robust2, 0);
 	ASSERT_EQ(ret, 0);
 	ASSERT_EQ(get_head, &head);
-	ASSERT_EQ(head_size, len_ptr);
 
-	ret = set_robust_list(&head2, head_size);
+	ret = set_list(&head2, robust2, 0);
 	ASSERT_EQ(ret, 0);
 
-	ret = get_robust_list(0, &get_head, &len_ptr);
+	ret = get_list(0, &get_head, robust2, 0);
 	ASSERT_EQ(ret, 0);
 	ASSERT_EQ(get_head, &head2);
-	ASSERT_EQ(head_size, len_ptr);
 
 	ksft_test_result_pass("%s\n", __func__);
 }
 
+struct child_arg_struct {
+	struct robust_list_head *head;
+	bool robust2;
+};
+
 static int child_list(void *arg)
 {
-	struct robust_list_head *head = arg;
+	struct child_arg_struct *child = arg;
+	struct robust_list_head *head;
+	bool robust2 = child->robust2;
 	int ret;
 
-	ret = set_robust_list(head, sizeof(*head));
+	head = child->head;
+
+	ret = set_list(head, robust2, 0);
 	if (ret) {
 		ksft_test_result_fail("set_robust_list error\n");
 		return -1;
@@ -444,23 +475,26 @@ static int child_list(void *arg)
  * parent
  *   2) the child thread still alive when we try to get the list from it
  */
-TEST(test_get_robust_list_child)
+TEST_F(robust_api, test_get_robust_list_child)
 {
 	struct robust_list_head head, *get_head;
+	bool robust2 = variant->robust2;
+	struct child_arg_struct child =
+		{.robust2 = robust2, .head = &head};
 	int ret, wstatus;
-	size_t len_ptr;
 	pid_t tid;
 
+
 	ret = pthread_barrier_init(&barrier, NULL, 2);
 	ret = pthread_barrier_init(&barrier2, NULL, 2);
 	ASSERT_EQ(ret, 0);
 
-	tid = create_child(&child_list, &head);
+	tid = create_child(&child_list, &child);
 	ASSERT_NE(tid, -1);
 
 	pthread_barrier_wait(&barrier);
 
-	ret = get_robust_list(tid, &get_head, &len_ptr);
+	ret = get_list(tid, &get_head, robust2, 0);
 	ASSERT_EQ(ret, 0);
 	ASSERT_EQ(&head, get_head);
 
@@ -914,4 +948,37 @@ TEST(test_32bit_lists)
 	munmap(locks, sizeof(*locks) * CHILD_NR);
 }
 
+/*
+ * Test setting and getting mutiples head lists
+ */
+TEST(set_and_get_robust2)
+{
+	struct robust_list_head *head = NULL, *heads;
+	int i, list_limit, ret;
+
+	if (!robust_list2_support()) {
+		ksft_test_result_skip("robust_list2 not supported\n");
+		return;
+	}
+
+	list_limit = set_robust_list2(NULL, 0, FUTEX_ROBUST_LIST_CMD_LIST_LIMIT, 0);
+
+	heads = malloc(list_limit * sizeof(*heads));
+	ASSERT_NE(heads, NULL);
+
+	for (i = 0; i < list_limit; i++) {
+		ret = set_list(&heads[i], true, i);
+		ASSERT_EQ(ret, 0);
+	}
+
+	for (i = 0; i < list_limit; i++) {
+		ret = get_list(0, &head, true, i);
+		ASSERT_EQ(ret, 0);
+		ASSERT_EQ(head, &heads[i]);
+	}
+
+	free(heads);
+	ksft_test_result_pass("%s\n", __func__);
+}
+
 TEST_HARNESS_MAIN

-- 
2.52.0


