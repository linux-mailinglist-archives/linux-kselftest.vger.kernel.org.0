Return-Path: <linux-kselftest+bounces-23313-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC559F08D6
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 10:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF97A283FEF
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Dec 2024 09:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D52641CBEB9;
	Fri, 13 Dec 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aQ+k69NE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3711B4F17
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Dec 2024 09:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734083762; cv=none; b=iGJnOHC/MUgCYIkKeMFqOYETG5LcIO5Wz9E3YISOlCl14ECSMOIhot4jZ+igrs3Bu/Mj/jnhnW7+vnuacvOkJNrFUoNXEPdkLswzezvUJKnMLgk3jHyv5RQbzZz4rNnuACTHIF/F1uRtm+wP5wzneebotBvuXoL8m49S4/zBqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734083762; c=relaxed/simple;
	bh=MSeG7NpeNJTJ59YezyPYGEMwMzK1klEVtFDKR9aNIjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oz49zuDBaEbDfGORaHqrE/jgSw4Ox+Qwgh/aaxqEC+2bwnE/jyCgypf985r2reWd0D9RQcQU+KbgbBWu73ep2WC27elurs6amMgg6Se6AwokqN+kLOJ8sG/D6iAK3bftSme1A9yBXcBxvxmfn1b5N67ytNSBLMcLVHWe1Bry6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aQ+k69NE; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734083759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4j0XdIbHKHBrG40Ri7lqb7eCCeV+N5WkxyRh1PruNqc=;
	b=aQ+k69NEi9odG+QFTufSS5yYrepbAhqEY2oSQBO1Jd6ncg9/PIEt3tq1ndqp/mKf27xBmw
	KcvK2LTGm5Sc5FtQh9hWye2mnuMOLEm7VekPH4dxqbj5STOy1Wvy5VZZp+N7RowAx1yj5/
	aBAaw1cgInBOjnE7k6F1wJ7OAtCjUwE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-503-ljxb3HsdNUafwUf2srUAIw-1; Fri,
 13 Dec 2024 04:55:54 -0500
X-MC-Unique: ljxb3HsdNUafwUf2srUAIw-1
X-Mimecast-MFC-AGG-ID: ljxb3HsdNUafwUf2srUAIw
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1827E1955F25;
	Fri, 13 Dec 2024 09:55:53 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.39.192.43])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F02EC195394B;
	Fri, 13 Dec 2024 09:55:48 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Mel Gorman <mgorman@suse.de>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>
Subject: [PATCH v2 4/4] rseq/selftests: Add test for mm_cid compaction
Date: Fri, 13 Dec 2024 10:54:07 +0100
Message-ID: <20241213095407.271357-5-gmonaco@redhat.com>
In-Reply-To: <20241213095407.271357-1-gmonaco@redhat.com>
References: <20241213095407.271357-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

A task in the kernel (task_mm_cid_work) runs somewhat periodically to
compact the mm_cid for each process, this test tries to validate that
it runs correctly and timely.

The test spawns 1 thread pinned to each CPU, then each thread, including
the main one, run in short bursts for some time. During this period, the
mm_cids should be spanning all numbers between 0 and nproc.

At the end of this phase, a thread with high enough mm_cid (> nproc/2)
is selected to be the new leader, all other threads terminate.

After some time, the only running thread should see 0 as mm_cid, if that
doesn't happen, the compaction mechanism didn't work and the test fails.

The test never fails if only 1 core is available, in which case, we
cannot test anything as the only available mm_cid is 0.

Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 157 ++++++++++++++++++
 3 files changed, 159 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 16496de5f6ce..2c89f97e4f73 100644
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
index 5a3432fceb58..ce1b38f46a35 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
-		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
+		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice mm_cid_compaction_test
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
diff --git a/tools/testing/selftests/rseq/mm_cid_compaction_test.c b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
new file mode 100644
index 000000000000..9bc7310c3cb5
--- /dev/null
+++ b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
@@ -0,0 +1,157 @@
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
+/* 0.5 s */
+#define RUNNER_PERIOD 500000
+/* Number of runs before we terminate or get the token */
+#define THREAD_RUNS 5
+
+/*
+ * Number of times we check that the mm_cid were compacted.
+ * Checks are repeated every RUNNER_PERIOD
+ */
+#define MM_CID_CLEANUP_TIMEOUT 10
+
+struct thread_args {
+	int num_cpus;
+	pthread_mutex_t token;
+	pthread_t *tinfo;
+};
+
+static void *thread_runner(void *arg)
+{
+	struct thread_args *args = arg;
+	int i, ret, curr_mm_cid;
+
+	for (i = 0; i < THREAD_RUNS; i++)
+		usleep(RUNNER_PERIOD);
+	curr_mm_cid = rseq_current_mm_cid();
+	/*
+	 * We select one thread with high enough mm_cid to be the new leader
+	 * all other threads (including the main thread) will terminate
+	 * After some time, the mm_cid of the only remaining thread should
+	 * converge to 0, if not, the test fails
+	 */
+	if (curr_mm_cid > args->num_cpus / 2 &&
+	    !pthread_mutex_trylock(&args->token)) {
+		printf_verbose("cpu%d has %d and will be the new leader\n",
+			       sched_getcpu(), curr_mm_cid);
+		for (i = 0; i < args->num_cpus; i++) {
+			if (args->tinfo[i] == pthread_self())
+				continue;
+			ret = pthread_join(args->tinfo[i], NULL);
+			if (ret) {
+				fprintf(stderr,
+					"Error: failed to join thread %d (%d): %s\n",
+					i, ret, strerror(ret));
+				assert(ret == 0);
+			}
+		}
+		free(args->tinfo);
+
+		for (i = 0; i < MM_CID_CLEANUP_TIMEOUT; i++) {
+			curr_mm_cid = rseq_current_mm_cid();
+			printf_verbose("run %d: mm_cid %d on cpu%d\n", i,
+				       curr_mm_cid, sched_getcpu());
+			if (curr_mm_cid == 0) {
+				printf_verbose(
+					"mm_cids successfully compacted, exiting\n");
+				pthread_exit(NULL);
+			}
+			usleep(RUNNER_PERIOD);
+		}
+		assert(false);
+	}
+	printf_verbose("cpu%d has %d and is going to terminate\n",
+		       sched_getcpu(), curr_mm_cid);
+	pthread_exit(NULL);
+}
+
+void test_mm_cid_compaction(void)
+{
+	cpu_set_t affinity, test_affinity;
+	int i, j, ret, num_threads;
+	pthread_t *tinfo;
+	struct thread_args args = { .token = PTHREAD_MUTEX_INITIALIZER };
+
+	sched_getaffinity(0, sizeof(affinity), &affinity);
+	CPU_ZERO(&test_affinity);
+	num_threads = CPU_COUNT(&affinity);
+	tinfo = calloc(num_threads, sizeof(*tinfo));
+	if (!tinfo) {
+		fprintf(stderr, "Error: failed to allocate tinfo(%d): %s\n",
+			errno, strerror(errno));
+		assert(ret == 0);
+	}
+	args.num_cpus = num_threads;
+	args.tinfo = tinfo;
+	if (num_threads == 1) {
+		printf_verbose(
+			"Running on a single cpu, cannot test anything\n");
+		return;
+	}
+	for (i = 0, j = 0; i < CPU_SETSIZE && j < num_threads; i++) {
+		if (CPU_ISSET(i, &affinity)) {
+			ret = pthread_create(&tinfo[j], NULL, thread_runner,
+					     &args);
+			if (ret) {
+				fprintf(stderr,
+					"Error: failed to create thread(%d): %s\n",
+					ret, strerror(ret));
+				assert(ret == 0);
+			}
+			CPU_SET(i, &test_affinity);
+			pthread_setaffinity_np(tinfo[j], sizeof(test_affinity),
+					       &test_affinity);
+			CPU_CLR(i, &test_affinity);
+			++j;
+		}
+	}
+	printf_verbose("Started %d threads\n", num_threads);
+
+	/* Also main thread will terminate if it is not selected as leader */
+	thread_runner(&args);
+}
+
+int main(int argc, char **argv)
+{
+	if (rseq_register_current_thread()) {
+		fprintf(stderr,
+			"Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	if (!rseq_mm_cid_available()) {
+		fprintf(stderr, "Error: rseq_mm_cid unavailable\n");
+		goto error;
+	}
+	test_mm_cid_compaction();
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr,
+			"Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto error;
+	}
+	return 0;
+
+error:
+	return -1;
+}
-- 
2.47.1


