Return-Path: <linux-kselftest+bounces-42570-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DDEBA915F
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 13:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E175D3BB7C9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Sep 2025 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA2F3016F7;
	Mon, 29 Sep 2025 11:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZSj0gg2I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A7730275A
	for <linux-kselftest@vger.kernel.org>; Mon, 29 Sep 2025 11:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759146182; cv=none; b=gt9+fUSeViMhCTggCI7iAGmV5VPGKWTMcV4DlMWz1SSCq2O1c1SyKlKviNMRyQojtMjUUd5bNw+7XP+wwf96eP8qWkoemo4I9re65lZMHEP9mcIEJdqLB6rr1MxYiCy5jqgdV6xFcxL1GUQfqSUR5BJHanX+j7ztSn2u/VipjC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759146182; c=relaxed/simple;
	bh=nEtyUr3R4f130JvlekB1xv6q2n31hAktv+O+ORIhXF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E68a9WIsi53wOKcQmlsn5gaqHUZLDRNSiS/Y0hARwqCGvZb6ORYxOAbipSrDYrm2NCv62slNzzBkCmf2JGpFhkTj0DJVPnVblUHq24HJK5qFZFjSHwJXFihwdSDiVfvdleuasxyMibkQrZRd5caHAEBDmieEec4X6awg2614byg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZSj0gg2I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759146179;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wK8XYbna/kr6s7zcm8omtA4zXQRbuBS4F3NKIioLVWg=;
	b=ZSj0gg2IF5T5OourZ/PTpeO5rkku+sRf+lggUxUBchF/ZQRBYEfCnj9npeJ5bIvcg+qF8D
	l4J1Hz3cob6SgUaYq/DDryAmMHmcPvuSnPqyVDDbwBqzhBJd9o/jkj5JzDF3MT2ZuLGMFY
	VLBYOUXj/y6Unk5ZzU2Xl3HuMcr5vLM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-10rq5rxoPQanakT1q6Lsrw-1; Mon,
 29 Sep 2025 07:42:56 -0400
X-MC-Unique: 10rq5rxoPQanakT1q6Lsrw-1
X-Mimecast-MFC-AGG-ID: 10rq5rxoPQanakT1q6Lsrw_1759146174
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C239180057C;
	Mon, 29 Sep 2025 11:42:54 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (unknown [10.44.32.41])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EC3AE19560B9;
	Mon, 29 Sep 2025 11:42:49 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v3 4/4] selftests/rseq: Add test for mm_cid compaction
Date: Mon, 29 Sep 2025 13:42:25 +0200
Message-ID: <20250929114225.36172-5-gmonaco@redhat.com>
In-Reply-To: <20250929114225.36172-1-gmonaco@redhat.com>
References: <20250929114225.36172-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

A task in the kernel (task_mm_cid_work) runs somewhat periodically to
compact the mm_cid for each process. Add a test to validate that it runs
correctly and timely.

The test spawns 1 thread pinned to each CPU, then each thread, including
the main one, runs in short bursts for some time. During this period, the
mm_cids should be spanning all numbers between 0 and nproc.

At the end of this phase, a thread with high enough mm_cid (>= nproc/2)
is selected to be the new leader, all other threads terminate.

After some time, the only running thread should see 0 as mm_cid, if that
doesn't happen, the compaction mechanism didn't work and the test fails.

The test never fails if only 1 core is available, in which case, we
cannot test anything as the only available mm_cid is 0.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 204 ++++++++++++++++++
 3 files changed, 206 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 0fda241fa62b..b3920c59bf40 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -3,6 +3,7 @@ basic_percpu_ops_test
 basic_percpu_ops_mm_cid_test
 basic_test
 basic_rseq_op_test
+mm_cid_compaction_test
 param_test
 param_test_benchmark
 param_test_compare_twice
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 0d0a5fae5954..bc4d940f66d4 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -17,7 +17,7 @@ OVERRIDE_TARGETS = 1
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
 		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice \
-		syscall_errors_test
+		syscall_errors_test mm_cid_compaction_test
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
diff --git a/tools/testing/selftests/rseq/mm_cid_compaction_test.c b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
new file mode 100644
index 000000000000..d13623625f5a
--- /dev/null
+++ b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: LGPL-2.1
+#define _GNU_SOURCE
+#include <assert.h>
+#include <pthread.h>
+#include <sched.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stddef.h>
+
+#include "../kselftest.h"
+#include "rseq.h"
+
+#define VERBOSE 0
+#define printf_verbose(fmt, ...)                    \
+	do {                                        \
+		if (VERBOSE)                        \
+			printf(fmt, ##__VA_ARGS__); \
+	} while (0)
+
+/* 50 ms */
+#define RUNNER_PERIOD 50000
+/*
+ * Number of runs before we terminate or get the token.
+ * The number is slowly increasing with the number of CPUs as the compaction
+ * process can take longer on larger systems. This is an arbitrary value.
+ */
+#define THREAD_RUNS (3 + args->num_cpus/8)
+
+/*
+ * Number of times we check that the mm_cid were compacted.
+ * Checks are repeated every RUNNER_PERIOD.
+ */
+#define MM_CID_COMPACT_TIMEOUT 10
+
+struct thread_args {
+	int cpu;
+	int num_cpus;
+	pthread_mutex_t *token;
+	pthread_barrier_t *barrier;
+	pthread_t *tinfo;
+	struct thread_args *args_head;
+};
+
+static void __noreturn *thread_runner(void *arg)
+{
+	struct thread_args *args = arg;
+	int i, ret, curr_mm_cid;
+	cpu_set_t cpumask;
+
+	CPU_ZERO(&cpumask);
+	CPU_SET(args->cpu, &cpumask);
+	ret = pthread_setaffinity_np(pthread_self(), sizeof(cpumask), &cpumask);
+	if (ret) {
+		errno = ret;
+		perror("Error: failed to set affinity");
+		abort();
+	}
+	pthread_barrier_wait(args->barrier);
+
+	for (i = 0; i < THREAD_RUNS; i++)
+		usleep(RUNNER_PERIOD);
+	curr_mm_cid = rseq_current_mm_cid();
+	/*
+	 * We select one thread with high enough mm_cid to be the new leader.
+	 * All other threads (including the main thread) will terminate.
+	 * After some time, the mm_cid of the only remaining thread should
+	 * converge to 0, if not, the test fails.
+	 */
+	if (curr_mm_cid >= args->num_cpus / 2 &&
+	    !pthread_mutex_trylock(args->token)) {
+		printf_verbose(
+			"cpu%d has mm_cid=%d and will be the new leader.\n",
+			sched_getcpu(), curr_mm_cid);
+		for (i = 0; i < args->num_cpus; i++) {
+			if (args->tinfo[i] == pthread_self())
+				continue;
+			ret = pthread_join(args->tinfo[i], NULL);
+			if (ret) {
+				errno = ret;
+				perror("Error: failed to join thread");
+				abort();
+			}
+		}
+		pthread_barrier_destroy(args->barrier);
+		free(args->tinfo);
+		free(args->token);
+		free(args->barrier);
+		free(args->args_head);
+
+		for (i = 0; i < MM_CID_COMPACT_TIMEOUT; i++) {
+			curr_mm_cid = rseq_current_mm_cid();
+			printf_verbose("run %d: mm_cid=%d on cpu%d.\n", i,
+				       curr_mm_cid, sched_getcpu());
+			if (curr_mm_cid == 0)
+				exit(EXIT_SUCCESS);
+			usleep(RUNNER_PERIOD);
+		}
+		exit(EXIT_FAILURE);
+	}
+	printf_verbose("cpu%d has mm_cid=%d and is going to terminate.\n",
+		       sched_getcpu(), curr_mm_cid);
+	pthread_exit(NULL);
+}
+
+int test_mm_cid_compaction(void)
+{
+	cpu_set_t affinity;
+	int i, j, ret = 0, num_threads;
+	pthread_t *tinfo;
+	pthread_mutex_t *token;
+	pthread_barrier_t *barrier;
+	struct thread_args *args;
+
+	sched_getaffinity(0, sizeof(affinity), &affinity);
+	num_threads = CPU_COUNT(&affinity);
+	tinfo = calloc(num_threads, sizeof(*tinfo));
+	if (!tinfo) {
+		perror("Error: failed to allocate tinfo");
+		return -1;
+	}
+	args = calloc(num_threads, sizeof(*args));
+	if (!args) {
+		perror("Error: failed to allocate args");
+		ret = -1;
+		goto out_free_tinfo;
+	}
+	token = malloc(sizeof(*token));
+	if (!token) {
+		perror("Error: failed to allocate token");
+		ret = -1;
+		goto out_free_args;
+	}
+	barrier = malloc(sizeof(*barrier));
+	if (!barrier) {
+		perror("Error: failed to allocate barrier");
+		ret = -1;
+		goto out_free_token;
+	}
+	if (num_threads == 1) {
+		fprintf(stderr, "Cannot test on a single cpu. "
+				"Skipping mm_cid_compaction test.\n");
+		/* only skipping the test, this is not a failure */
+		goto out_free_barrier;
+	}
+	pthread_mutex_init(token, NULL);
+	ret = pthread_barrier_init(barrier, NULL, num_threads);
+	if (ret) {
+		errno = ret;
+		perror("Error: failed to initialise barrier");
+		goto out_free_barrier;
+	}
+	for (i = 0, j = 0; i < CPU_SETSIZE && j < num_threads; i++) {
+		if (!CPU_ISSET(i, &affinity))
+			continue;
+		args[j].num_cpus = num_threads;
+		args[j].tinfo = tinfo;
+		args[j].token = token;
+		args[j].barrier = barrier;
+		args[j].cpu = i;
+		args[j].args_head = args;
+		if (!j) {
+			/* The first thread is the main one */
+			tinfo[0] = pthread_self();
+			++j;
+			continue;
+		}
+		ret = pthread_create(&tinfo[j], NULL, thread_runner, &args[j]);
+		if (ret) {
+			errno = ret;
+			perror("Error: failed to create thread");
+			abort();
+		}
+		++j;
+	}
+	printf_verbose("Started %d threads.\n", num_threads);
+
+	/* Also main thread will terminate if it is not selected as leader */
+	thread_runner(&args[0]);
+
+	/* only reached in case of errors */
+out_free_barrier:
+	free(barrier);
+out_free_token:
+	free(token);
+out_free_args:
+	free(args);
+out_free_tinfo:
+	free(tinfo);
+
+	return ret;
+}
+
+int main(int argc, char **argv)
+{
+	if (!rseq_mm_cid_available()) {
+		fprintf(stderr, "Error: rseq_mm_cid unavailable\n");
+		return -1;
+	}
+	if (test_mm_cid_compaction())
+		return -1;
+	return 0;
+}
-- 
2.51.0


