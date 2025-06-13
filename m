Return-Path: <linux-kselftest+bounces-34883-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DD5AD8767
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 11:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D9FE3B3947
	for <lists+linux-kselftest@lfdr.de>; Fri, 13 Jun 2025 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8DF22C1595;
	Fri, 13 Jun 2025 09:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GNSRHfh3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE05C2C1583
	for <linux-kselftest@vger.kernel.org>; Fri, 13 Jun 2025 09:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749805983; cv=none; b=YfNR+JQYsvilKcXiBwlD4cW0eGFMmwqDqHxC5s/b+NBpd1SxOEHpa3Sy/S9m+wFmeo4g3ZrRJ/OwWDNNIgq/OPE5aOeVcVelK1es5aDCG8M8SjKpKM0VxiIjEGT5lj/cHkUFeZM2UBmnMivKUpT+fdkL3v9TD3yIFp5M7mmdedM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749805983; c=relaxed/simple;
	bh=PptqpAgmoytKqOt6xRbMugtr28u2OtS3tp+zS5kWioE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROx8OHfkboc1lZr0wL+Go9jNc7MXikci1Rf0NZuNhIGBxesVQW6eHxhfT/nZDnLjwycrAQ5bpFXd1G0o1L7YJuVnyFjkIQTlmwt5TXZRGaaa+YfCh5cMdXD0fpg2HrGjlUDN+mrgDDPDW6A5YvwO1CqHKkGlBdUDFoRoQB/Fo28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GNSRHfh3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749805980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb5XjEM8UDjaKosEuY2mp6BwacUxQGhu78cSlZl2o+I=;
	b=GNSRHfh3igJ7uTmB7ZBuJs3l0ofE/tbhTTriuApcnreOCGctzrCeVTBKiZ4qBr6TFnsxJu
	cnYXW2FlmIAqKLlgwdtb3LV8OXpof8kY0Hcskv0yN319Wibqkim+y25IvcXkpvYMdUFF5O
	kvYW3079YZNGq0e4u7I9CfkbQZCrFvw=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-YsHsy2FCPeyyJP82E-SNBw-1; Fri,
 13 Jun 2025 05:12:54 -0400
X-MC-Unique: YsHsy2FCPeyyJP82E-SNBw-1
X-Mimecast-MFC-AGG-ID: YsHsy2FCPeyyJP82E-SNBw_1749805973
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5F4DA19560A2;
	Fri, 13 Jun 2025 09:12:53 +0000 (UTC)
Received: from gmonaco-thinkpadt14gen3.rmtit.com (unknown [10.45.224.102])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0FAC6195E344;
	Fri, 13 Jun 2025 09:12:49 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Ingo Molnar <mingo@redhat.org>
Subject: [RESEND PATCH v13 3/3] selftests/rseq: Add test for mm_cid compaction
Date: Fri, 13 Jun 2025 11:12:28 +0200
Message-ID: <20250613091229.21500-4-gmonaco@redhat.com>
In-Reply-To: <20250613091229.21500-1-gmonaco@redhat.com>
References: <20250613091229.21500-1-gmonaco@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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

Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
---
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../selftests/rseq/mm_cid_compaction_test.c   | 200 ++++++++++++++++++
 3 files changed, 202 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/mm_cid_compaction_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 0fda241fa62b0..b3920c59bf401 100644
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
index 0d0a5fae59547..bc4d940f66d40 100644
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
index 0000000000000..7ddde3b657dd6
--- /dev/null
+++ b/tools/testing/selftests/rseq/mm_cid_compaction_test.c
@@ -0,0 +1,200 @@
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
2.49.0


