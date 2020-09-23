Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E72032764A2
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Sep 2020 01:37:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgIWXgc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Sep 2020 19:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWXg1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Sep 2020 19:36:27 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26984C0613D1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 16:36:27 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id h191so885631qke.1
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Sep 2020 16:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=iBEW324qVsBn+Epu6t5+eFVQzIF+eeHU0CdjJmhI4ig=;
        b=R+YYI7bzN+y9ybelrj03v9yVBy9KOM9LM9YbCLKgeZU77/2czxKFM8tBA4tCE9de2L
         jjsfQsJUURxTos9yQl01QPTRxGutAPERDkbqdYuEp1IqLl3cd/9JjZZVZGUUI79kP5an
         l8zRMiCluRYNBfuN1fYgaXq5oXND39wo06YvRtAfQHX9uUQzikEPkYn1WlpX7+/otv2J
         1Y9hjhy44qByuUaA9YJREK1fyD9Y/3tq5U+LEP8OwgEQTQeKUtJxxOygrHTcnoPez6Tg
         U0Flwlr5hVIzUtk5I8u8Ou4XYuY7lvE2Yhc7JZW2MAncjl4RYbTwZS3dCIhFPTKIMfF9
         tqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iBEW324qVsBn+Epu6t5+eFVQzIF+eeHU0CdjJmhI4ig=;
        b=Pm9JKCpuWQlaFWq6y5u3W2EugJRKb743CsQQ4xeRZ5S/T5Mrpt7fL1GaYhVHxIXMXS
         dSfnKmPC1o2+6Qo9CqaLjcIY/mSXwXNtius7UshU8mNdk1eiQwD3eDUm5VQ6pfpXEaiA
         +iNdezKkIYqjOS1TWswlpHBUaxFQFH4e8ewzPSMgL7mt2BriTRgyBd59pJY6DItQINS0
         fXB3fGSbDeRtq7gmkFWRbqwLawa9Wtl6dLkhUZPKV75kEB7MJKGtLUWmpWhurea5IuWR
         h040B3QDADS0ZiWBDHvxBIGYUjTV/6wo2MT+IPsZvbnaDf7itq0DqBrI9Mwq/9kUucwH
         uXkw==
X-Gm-Message-State: AOAM532hSudN9rqEbaJVnuFb/ZUUKGCKRIOcEjT9tbQXHr7Icwnfbwfd
        xOlQZ/uNckYIurB7/r2I9jgPDknb
X-Google-Smtp-Source: ABdhPJxQWHAyw0zXo4j/eKFXglIg954rKcdnGn3Sy2nfZv4ULfeAWE93q93uZOsZbj4A62+ULPn74YkT
Sender: "posk via sendgmr" <posk@posk.svl.corp.google.com>
X-Received: from posk.svl.corp.google.com ([2620:15c:2cd:202:7220:84ff:fe09:7598])
 (user=posk job=sendgmr) by 2002:a0c:b29e:: with SMTP id r30mr2672693qve.38.1600904186187;
 Wed, 23 Sep 2020 16:36:26 -0700 (PDT)
Date:   Wed, 23 Sep 2020 16:36:18 -0700
In-Reply-To: <20200923233618.2572849-1-posk@google.com>
Message-Id: <20200923233618.2572849-3-posk@google.com>
Mime-Version: 1.0
References: <20200923233618.2572849-1-posk@google.com>
X-Mailer: git-send-email 2.28.0.709.gb0816b6eb0-goog
Subject: [PATCH v8 3/3] rseq/selftests: test MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ
From:   Peter Oskolkov <posk@google.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Paul Turner <pjt@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Peter Oskolkov <posk@posk.io>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org, Peter Oskolkov <posk@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Based on Google-internal RSEQ work done by
Paul Turner and Andrew Hunter.

This patch adds a selftest for MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ.
The test quite often fails without the previous patch in this patchset,
but consistently passes with it.

v3: added rseq_offset_deref_addv() to x86_64 to make the test
    more explicit; on other architectures I kept using existing
    rseq_cmpeqv_cmpeqv_storev() as I have no easy way to test
    there.  Added a comment explaining why the test works this way.
v4: skipped the test if rseq_offset_deref_addv() is not present
    (that is, on all architectures other than x86_64).
v8: split rseq_offset_deref_addv() into a separate patch;
    moved the test to param_test; other minor tweaks.

Signed-off-by: Peter Oskolkov <posk@google.com>
---
 tools/testing/selftests/rseq/param_test.c     | 223 +++++++++++++++++-
 .../testing/selftests/rseq/run_param_test.sh  |   2 +
 2 files changed, 224 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index e8a657a5f48a..384589095864 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: LGPL-2.1
 #define _GNU_SOURCE
 #include <assert.h>
+#include <linux/membarrier.h>
 #include <pthread.h>
 #include <sched.h>
+#include <stdatomic.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -1131,6 +1133,220 @@ static int set_signal_handler(void)
 	return ret;
 }
 
+struct test_membarrier_thread_args {
+	int stop;
+	intptr_t percpu_list_ptr;
+};
+
+/* Worker threads modify data in their "active" percpu lists. */
+void *test_membarrier_worker_thread(void *arg)
+{
+	struct test_membarrier_thread_args *args =
+		(struct test_membarrier_thread_args *)arg;
+	const int iters = opt_reps;
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	/* Wait for initialization. */
+	while (!atomic_load(&args->percpu_list_ptr)) {}
+
+	for (i = 0; i < iters; ++i) {
+		int ret;
+
+		do {
+			int cpu = rseq_cpu_start();
+
+			ret = rseq_offset_deref_addv(&args->percpu_list_ptr,
+				sizeof(struct percpu_list_entry) * cpu, 1, cpu);
+		} while (rseq_unlikely(ret));
+	}
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+void test_membarrier_init_percpu_list(struct percpu_list *list)
+{
+	int i;
+
+	memset(list, 0, sizeof(*list));
+	for (i = 0; i < CPU_SETSIZE; i++) {
+		struct percpu_list_node *node;
+
+		node = malloc(sizeof(*node));
+		assert(node);
+		node->data = 0;
+		node->next = NULL;
+		list->c[i].head = node;
+	}
+}
+
+void test_membarrier_free_percpu_list(struct percpu_list *list)
+{
+	int i;
+
+	for (i = 0; i < CPU_SETSIZE; i++)
+		free(list->c[i].head);
+}
+
+static int sys_membarrier(int cmd, int flags, int cpu_id)
+{
+	return syscall(__NR_membarrier, cmd, flags, cpu_id);
+}
+
+/*
+ * The manager thread swaps per-cpu lists that worker threads see,
+ * and validates that there are no unexpected modifications.
+ */
+void *test_membarrier_manager_thread(void *arg)
+{
+	struct test_membarrier_thread_args *args =
+		(struct test_membarrier_thread_args *)arg;
+	struct percpu_list list_a, list_b;
+	intptr_t expect_a = 0, expect_b = 0;
+	int cpu_a = 0, cpu_b = 0;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+
+	/* Init lists. */
+	test_membarrier_init_percpu_list(&list_a);
+	test_membarrier_init_percpu_list(&list_b);
+
+	atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
+
+	while (!atomic_load(&args->stop)) {
+		/* list_a is "active". */
+		cpu_a = rand() % CPU_SETSIZE;
+		/*
+		 * As list_b is "inactive", we should never see changes
+		 * to list_b.
+		 */
+		if (expect_b != atomic_load(&list_b.c[cpu_b].head->data)) {
+			fprintf(stderr, "Membarrier test failed\n");
+			abort();
+		}
+
+		/* Make list_b "active". */
+		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_b);
+		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+					MEMBARRIER_CMD_FLAG_CPU, cpu_a) &&
+				errno != ENXIO /* missing CPU */) {
+			perror("sys_membarrier");
+			abort();
+		}
+		/*
+		 * Cpu A should now only modify list_b, so the values
+		 * in list_a should be stable.
+		 */
+		expect_a = atomic_load(&list_a.c[cpu_a].head->data);
+
+		cpu_b = rand() % CPU_SETSIZE;
+		/*
+		 * As list_a is "inactive", we should never see changes
+		 * to list_a.
+		 */
+		if (expect_a != atomic_load(&list_a.c[cpu_a].head->data)) {
+			fprintf(stderr, "Membarrier test failed\n");
+			abort();
+		}
+
+		/* Make list_a "active". */
+		atomic_store(&args->percpu_list_ptr, (intptr_t)&list_a);
+		if (sys_membarrier(MEMBARRIER_CMD_PRIVATE_EXPEDITED_RSEQ,
+					MEMBARRIER_CMD_FLAG_CPU, cpu_b) &&
+				errno != ENXIO /* missing CPU*/) {
+			perror("sys_membarrier");
+			abort();
+		}
+		/* Remember a value from list_b. */
+		expect_b = atomic_load(&list_b.c[cpu_b].head->data);
+	}
+
+	test_membarrier_free_percpu_list(&list_a);
+	test_membarrier_free_percpu_list(&list_b);
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+/* Test MEMBARRIER_CMD_PRIVATE_RESTART_RSEQ_ON_CPU membarrier command. */
+#ifdef RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV
+void test_membarrier(void)
+{
+	const int num_threads = opt_threads;
+	struct test_membarrier_thread_args thread_args;
+	pthread_t worker_threads[num_threads];
+	pthread_t manager_thread;
+	int i, ret;
+
+	if (sys_membarrier(MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED_RSEQ, 0, 0)) {
+		perror("sys_membarrier");
+		abort();
+	}
+
+	thread_args.stop = 0;
+	thread_args.percpu_list_ptr = 0;
+	ret = pthread_create(&manager_thread, NULL,
+			test_membarrier_manager_thread, &thread_args);
+	if (ret) {
+		errno = ret;
+		perror("pthread_create");
+		abort();
+	}
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_create(&worker_threads[i], NULL,
+				test_membarrier_worker_thread, &thread_args);
+		if (ret) {
+			errno = ret;
+			perror("pthread_create");
+			abort();
+		}
+	}
+
+
+	for (i = 0; i < num_threads; i++) {
+		ret = pthread_join(worker_threads[i], NULL);
+		if (ret) {
+			errno = ret;
+			perror("pthread_join");
+			abort();
+		}
+	}
+
+	atomic_store(&thread_args.stop, 1);
+	ret = pthread_join(manager_thread, NULL);
+	if (ret) {
+		errno = ret;
+		perror("pthread_join");
+		abort();
+	}
+}
+#else /* RSEQ_ARCH_HAS_OFFSET_DEREF_ADDV */
+void test_membarrier(void)
+{
+	fprintf(stderr, "rseq_offset_deref_addv is not implemented on this architecture. "
+			"Skipping membarrier test.\n");
+}
+#endif
+
 static void show_usage(int argc, char **argv)
 {
 	printf("Usage : %s <OPTIONS>\n",
@@ -1153,7 +1369,7 @@ static void show_usage(int argc, char **argv)
 	printf("	[-r N] Number of repetitions per thread (default 5000)\n");
 	printf("	[-d] Disable rseq system call (no initialization)\n");
 	printf("	[-D M] Disable rseq for each M threads\n");
-	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy, (i)ncrement\n");
+	printf("	[-T test] Choose test: (s)pinlock, (l)ist, (b)uffer, (m)emcpy, (i)ncrement, membarrie(r)\n");
 	printf("	[-M] Push into buffer and memcpy buffer with memory barriers.\n");
 	printf("	[-v] Verbose output.\n");
 	printf("	[-h] Show this help.\n");
@@ -1268,6 +1484,7 @@ int main(int argc, char **argv)
 			case 'i':
 			case 'b':
 			case 'm':
+			case 'r':
 				break;
 			default:
 				show_usage(argc, argv);
@@ -1320,6 +1537,10 @@ int main(int argc, char **argv)
 		printf_verbose("counter increment\n");
 		test_percpu_inc();
 		break;
+	case 'r':
+		printf_verbose("membarrier\n");
+		test_membarrier();
+		break;
 	}
 	if (!opt_disable_rseq && rseq_unregister_current_thread())
 		abort();
diff --git a/tools/testing/selftests/rseq/run_param_test.sh b/tools/testing/selftests/rseq/run_param_test.sh
index e426304fd4a0..f51bc83c9e41 100755
--- a/tools/testing/selftests/rseq/run_param_test.sh
+++ b/tools/testing/selftests/rseq/run_param_test.sh
@@ -15,6 +15,7 @@ TEST_LIST=(
 	"-T m"
 	"-T m -M"
 	"-T i"
+	"-T r"
 )
 
 TEST_NAME=(
@@ -25,6 +26,7 @@ TEST_NAME=(
 	"memcpy"
 	"memcpy with barrier"
 	"increment"
+	"membarrier"
 )
 IFS="$OLDIFS"
 
-- 
2.28.0.709.gb0816b6eb0-goog

