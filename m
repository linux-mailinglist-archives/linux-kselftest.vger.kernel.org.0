Return-Path: <linux-kselftest+bounces-15649-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0399956D26
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 16:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6D71F242FB
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Aug 2024 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546E316F27C;
	Mon, 19 Aug 2024 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="jVjIaA3u"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797D216D9A4;
	Mon, 19 Aug 2024 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724077489; cv=none; b=pRshjTsllpl61V+32IVv+FtwMgucLEHKocc10v2yshkPtbwPtdMn6BitWO9gWecVITfm3muEqoXFEKZY63mw8POXE7NjjFlUeIjTT3JvKc3HYiEnsQ4ODQfhip4/BWHgEK4vEAQcJDehKL/kNSUOgqWSK6E2BktVAmkMJ45Kzro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724077489; c=relaxed/simple;
	bh=RjoBZ0RC9t+J8YPy3KqE0+7gzbB14ug6icqY6ivCwU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZMDuYHfsCHxzLXY/Mmkydv1Qu5ApsMuh7n4IvubA8gRIZvLv4IHYVctGc7PqAlRkMsmV4S7JUS7WWnIDlRaui2ktlBhOCqIQEpSIQ7d+ZYM/cAxG6jBppfGOdCTViz0DQvCM4QvHMZAlzTAULMGdQLikqhav/UF5dCeZn78SCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=jVjIaA3u; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1724077483;
	bh=RjoBZ0RC9t+J8YPy3KqE0+7gzbB14ug6icqY6ivCwU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jVjIaA3uJKw84Hpm1kazZUWmxmgvN0rQv+rtckMGEWtzUGZFPcy8i0doYiNbzezz4
	 o88QfhKpfredf49Vh8ZQiRmF7qOmG20HbwvQlhTN4ve02RvKGTaloMuN0tlny9rAZB
	 hhx48yu0ci5m0KfVVQBh5k2X0PV+ERxQn7OmofpdXUYPZko99/nbEZ4vVAcVRHupv4
	 vYPzRtFdV/5j6T6gb94ekKKAffQfihzJhUv9/8J2N+2bzTDS0u49hFGhdak5WqFBHa
	 4WZXPRI2PN/t17rY+jGsIXa508Bx9lapw9NNmE2r+vGuX7JY09BQuBlXq568kchAEi
	 o5gSbcragBBoA==
Received: from thinkos.internal.efficios.com (109.56.13.38.mobile.3.dk [109.56.13.38])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4WnZc916vwz1HSQ;
	Mon, 19 Aug 2024 10:24:41 -0400 (EDT)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Mel Gorman <mgorman@suse.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ben Segall <bsegall@google.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-kselftest@vger.kernel.org
Subject: [RFC PATCH 5/5] selftests/rseq: Implement NUMA node id vs mm_cid invariant test
Date: Mon, 19 Aug 2024 16:24:06 +0200
Message-Id: <20240819142406.339084-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
References: <20240819142406.339084-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test validates that the mapping between a mm_cid and a NUMA node id
remains invariant for the process lifetime for a process with a number of
threads >= number of allowed CPUs. In other words, it validates that if
any thread within the process running on behalf of a mm_cid N observes a
NUMA node id M, all threads within this process will always observe the
same NUMA node id value when running on behalf of that same mm_cid.

This characteristic is important for NUMA locality.

On all architectures except Power, the NUMA topology is never
reconfigured after a CPU has been associated with a NUMA node in the
system lifetime. Even on Power, we can assume that NUMA topology
reconfiguration happens rarely, and therefore we do not expect it to
happen while the NUMA test is running.

As a result the NUMA node id associated with a mm_cid should be
invariant as long as:

- A process has a number of threads >= number of allowed CPUs,
- The allowed CPUs mask is unchanged, and
- The NUMA configuration is unchanged.

This test is skipped on architectures that do not implement
rseq_load_u32_u32.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   2 +-
 .../testing/selftests/rseq/basic_numa_test.c  | 144 ++++++++++++++++++
 3 files changed, 146 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/basic_numa_test.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 16496de5f6ce..8a8d163cbb9f 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+basic_numa_test
 basic_percpu_ops_test
 basic_percpu_ops_mm_cid_test
 basic_test
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 5a3432fceb58..9ef1c949114a 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -14,7 +14,7 @@ LDLIBS += -lpthread -ldl
 # still track changes to header files and depend on shared object.
 OVERRIDE_TARGETS = 1
 
-TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
+TEST_GEN_PROGS = basic_test basic_numa_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
 		param_test_benchmark param_test_compare_twice param_test_mm_cid \
 		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
 
diff --git a/tools/testing/selftests/rseq/basic_numa_test.c b/tools/testing/selftests/rseq/basic_numa_test.c
new file mode 100644
index 000000000000..8e51c662057d
--- /dev/null
+++ b/tools/testing/selftests/rseq/basic_numa_test.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * Basic rseq NUMA test. Validate that (mm_cid, numa_node_id) pairs are
+ * invariant when the number of threads >= number of allowed CPUs, as
+ * long as those preconditions are respected:
+ *
+ *   - A process has a number of threads >= number of allowed CPUs,
+ *   - The allowed CPUs mask is unchanged, and
+ *   - The NUMA configuration is unchanged.
+ */
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <poll.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+#define NR_LOOPS	100
+
+static int nr_threads, nr_active_threads, test_go, test_stop;
+
+#ifdef RSEQ_ARCH_HAS_LOAD_U32_U32
+
+static int cpu_numa_id[CPU_SETSIZE];
+
+static int get_affinity_weight(void)
+{
+	cpu_set_t allowed_cpus;
+
+	if (sched_getaffinity(0, sizeof(allowed_cpus), &allowed_cpus)) {
+		perror("sched_getaffinity");
+		abort();
+	}
+	return CPU_COUNT(&allowed_cpus);
+}
+
+static void numa_id_init(void)
+{
+	int i;
+
+	for (i = 0; i < CPU_SETSIZE; i++)
+		cpu_numa_id[i] = -1;
+}
+
+static void *test_thread(void *arg)
+{
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	/*
+	 * Rendez-vous across all threads to make sure the number of
+	 * threads >= number of possible CPUs for the entire test duration.
+	 */
+	if (__atomic_add_fetch(&nr_active_threads, 1, __ATOMIC_RELAXED) == nr_threads)
+		__atomic_store_n(&test_go, 1, __ATOMIC_RELAXED);
+	while (!__atomic_load_n(&test_go, __ATOMIC_RELAXED))
+		rseq_barrier();
+
+	for (i = 0; i < NR_LOOPS; i++) {
+		uint32_t mm_cid, node;
+		int cached_node_id;
+
+		while (rseq_load_u32_u32(RSEQ_MO_RELAXED, &mm_cid,
+					 &rseq_get_abi()->mm_cid,
+					 &node, &rseq_get_abi()->node_id) != 0) {
+			/* Retry. */
+		}
+		cached_node_id = RSEQ_READ_ONCE(cpu_numa_id[mm_cid]);
+		if (cached_node_id == -1) {
+			RSEQ_WRITE_ONCE(cpu_numa_id[mm_cid], node);
+		} else {
+			if (node != cached_node_id) {
+				fprintf(stderr, "Error: NUMA node id discrepancy: mm_cid %u cached node id %d node id %u.\n",
+					mm_cid, cached_node_id, node);
+				fprintf(stderr, "This is likely a kernel bug, or caused by a concurrent NUMA topology reconfiguration.\n");
+				abort();
+			}
+		}
+		(void) poll(NULL, 0, 10);	/* wait 10ms */
+	}
+	/*
+	 * Rendez-vous before exiting all threads to make sure the
+	 * number of threads >= number of possible CPUs for the entire
+	 * test duration.
+	 */
+	if (__atomic_sub_fetch(&nr_active_threads, 1, __ATOMIC_RELAXED) == 0)
+		__atomic_store_n(&test_stop, 1, __ATOMIC_RELAXED);
+	while (!__atomic_load_n(&test_stop, __ATOMIC_RELAXED))
+		rseq_barrier();
+
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		abort();
+	}
+	return NULL;
+}
+
+static int test_numa(void)
+{
+	pthread_t tid[nr_threads];
+	int err, i;
+	void *tret;
+
+	numa_id_init();
+
+	printf("testing rseq (mm_cid, numa_node_id) invariant, multi-threaded (%d threads)\n",
+	       nr_threads);
+
+	for (i = 0; i < nr_threads; i++) {
+		err = pthread_create(&tid[i], NULL, test_thread, NULL);
+		if (err != 0)
+			abort();
+	}
+
+	for (i = 0; i < nr_threads; i++) {
+		err = pthread_join(tid[i], &tret);
+		if (err != 0)
+			abort();
+	}
+
+	return 0;
+}
+#else
+static int test_numa(void)
+{
+	fprintf(stderr, "rseq_load_u32_u32 is not implemented on this architecture. Skipping numa test.\n");
+	return 0;
+}
+#endif
+
+int main(int argc, char **argv)
+{
+	nr_threads = get_affinity_weight();
+	return test_numa();
+}
-- 
2.39.2


