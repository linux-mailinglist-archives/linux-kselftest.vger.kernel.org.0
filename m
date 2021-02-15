Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B6B31BC5E
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Feb 2021 16:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbhBOP0q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Feb 2021 10:26:46 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60336 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhBOP0W (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Feb 2021 10:26:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id C62C11F44F30
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     kernel@collabora.com, krisman@collabora.com,
        pgriffais@valvesoftware.com, z.figura12@gmail.com,
        joel@joelfernandes.org, malteskarupke@fastmail.fm,
        linux-api@vger.kernel.org, fweimer@redhat.com,
        libc-alpha@sourceware.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, acme@kernel.org, corbet@lwn.net,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 12/13] perf bench: Add futex2 benchmark tests
Date:   Mon, 15 Feb 2021 12:24:03 -0300
Message-Id: <20210215152404.250281-13-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210215152404.250281-1-andrealmeid@collabora.com>
References: <20210215152404.250281-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support at the existing futex benchmarking code base to enable
futex2 calls. `perf bench` tests can be used not only as a way to
measure the performance of implementation, but also as stress testing
for the kernel infrastructure.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 tools/arch/x86/include/asm/unistd_64.h | 12 ++++++
 tools/perf/bench/bench.h               |  4 ++
 tools/perf/bench/futex-hash.c          | 24 +++++++++--
 tools/perf/bench/futex-requeue.c       | 57 ++++++++++++++++++++------
 tools/perf/bench/futex-wake-parallel.c | 41 +++++++++++++++---
 tools/perf/bench/futex-wake.c          | 37 +++++++++++++----
 tools/perf/bench/futex.h               | 47 +++++++++++++++++++++
 tools/perf/builtin-bench.c             | 18 ++++++--
 8 files changed, 206 insertions(+), 34 deletions(-)

diff --git a/tools/arch/x86/include/asm/unistd_64.h b/tools/arch/x86/include/asm/unistd_64.h
index 4205ed4158bf..cf5ad4ea1c1f 100644
--- a/tools/arch/x86/include/asm/unistd_64.h
+++ b/tools/arch/x86/include/asm/unistd_64.h
@@ -17,3 +17,15 @@
 #ifndef __NR_setns
 #define __NR_setns 308
 #endif
+
+#ifndef __NR_futex_wait
+# define __NR_futex_wait 442
+#endif
+
+#ifndef __NR_futex_wake
+# define __NR_futex_wake 443
+#endif
+
+#ifndef __NR_futex_requeue
+# define __NR_futex_requeue 445
+#endif
diff --git a/tools/perf/bench/bench.h b/tools/perf/bench/bench.h
index eac36afab2b3..12346844b354 100644
--- a/tools/perf/bench/bench.h
+++ b/tools/perf/bench/bench.h
@@ -38,9 +38,13 @@ int bench_mem_memcpy(int argc, const char **argv);
 int bench_mem_memset(int argc, const char **argv);
 int bench_mem_find_bit(int argc, const char **argv);
 int bench_futex_hash(int argc, const char **argv);
+int bench_futex2_hash(int argc, const char **argv);
 int bench_futex_wake(int argc, const char **argv);
+int bench_futex2_wake(int argc, const char **argv);
 int bench_futex_wake_parallel(int argc, const char **argv);
+int bench_futex2_wake_parallel(int argc, const char **argv);
 int bench_futex_requeue(int argc, const char **argv);
+int bench_futex2_requeue(int argc, const char **argv);
 /* pi futexes */
 int bench_futex_lock_pi(int argc, const char **argv);
 int bench_epoll_wait(int argc, const char **argv);
diff --git a/tools/perf/bench/futex-hash.c b/tools/perf/bench/futex-hash.c
index 915bf3da7ce2..6e62e7708fde 100644
--- a/tools/perf/bench/futex-hash.c
+++ b/tools/perf/bench/futex-hash.c
@@ -34,7 +34,7 @@ static unsigned int nthreads = 0;
 static unsigned int nsecs    = 10;
 /* amount of futexes per thread */
 static unsigned int nfutexes = 1024;
-static bool fshared = false, done = false, silent = false;
+static bool fshared = false, done = false, silent = false, futex2 = false;
 static int futex_flag = 0;
 
 struct timeval bench__start, bench__end, bench__runtime;
@@ -86,7 +86,10 @@ static void *workerfn(void *arg)
 			 * such as internal waitqueue handling, thus enlarging
 			 * the critical region protected by hb->lock.
 			 */
-			ret = futex_wait(&w->futex[i], 1234, NULL, futex_flag);
+			if (!futex2)
+				ret = futex_wait(&w->futex[i], 1234, NULL, futex_flag);
+			else
+				ret = futex2_wait(&w->futex[i], 1234, futex_flag, NULL);
 			if (!silent &&
 			    (!ret || errno != EAGAIN || errno != EWOULDBLOCK))
 				warn("Non-expected futex return call");
@@ -117,7 +120,7 @@ static void print_summary(void)
 	       (int)bench__runtime.tv_sec);
 }
 
-int bench_futex_hash(int argc, const char **argv)
+static int __bench_futex_hash(int argc, const char **argv)
 {
 	int ret = 0;
 	cpu_set_t cpuset;
@@ -149,7 +152,9 @@ int bench_futex_hash(int argc, const char **argv)
 	if (!worker)
 		goto errmem;
 
-	if (!fshared)
+	if (futex2)
+		futex_flag = FUTEX_32 | (fshared * FUTEX_SHARED_FLAG);
+	else if (!fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
 	printf("Run summary [PID %d]: %d threads, each operating on %d [%s] futexes for %d secs.\n\n",
@@ -229,3 +234,14 @@ int bench_futex_hash(int argc, const char **argv)
 errmem:
 	err(EXIT_FAILURE, "calloc");
 }
+
+int bench_futex_hash(int argc, const char **argv)
+{
+	return __bench_futex_hash(argc, argv);
+}
+
+int bench_futex2_hash(int argc, const char **argv)
+{
+	futex2 = true;
+	return __bench_futex_hash(argc, argv);
+}
diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 7a15c2e61022..4c7486fbe923 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2013  Davidlohr Bueso <davidlohr@hp.com>
  *
- * futex-requeue: Block a bunch of threads on futex1 and requeue them
- *                on futex2, N at a time.
+ * futex-requeue: Block a bunch of threads on addr1 and requeue them
+ *                on addr2, N at a time.
  *
  * This program is particularly useful to measure the latency of nthread
  * requeues without waking up any tasks -- thus mimicking a regular futex_wait.
@@ -29,7 +29,10 @@
 #include <stdlib.h>
 #include <sys/time.h>
 
-static u_int32_t futex1 = 0, futex2 = 0;
+static u_int32_t addr1 = 0, addr2 = 0;
+
+static struct futex_requeue rq1 = { .uaddr = &addr1, .flags = FUTEX_32 };
+static struct futex_requeue rq2 = { .uaddr = &addr2, .flags = FUTEX_32 };
 
 /*
  * How many tasks to requeue at a time.
@@ -38,7 +41,7 @@ static u_int32_t futex1 = 0, futex2 = 0;
 static unsigned int nrequeue = 1;
 
 static pthread_t *worker;
-static bool done = false, silent = false, fshared = false;
+static bool done = false, silent = false, fshared = false, futex2 = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats requeuetime_stats, requeued_stats;
@@ -80,7 +83,11 @@ static void *workerfn(void *arg __maybe_unused)
 	pthread_cond_wait(&thread_worker, &thread_lock);
 	pthread_mutex_unlock(&thread_lock);
 
-	futex_wait(&futex1, 0, NULL, futex_flag);
+	if (!futex2)
+		futex_wait(&addr1, 0, NULL, futex_flag);
+	else
+		futex2_wait(&addr1, 0, futex_flag, NULL);
+
 	return NULL;
 }
 
@@ -112,7 +119,7 @@ static void toggle_done(int sig __maybe_unused,
 	done = true;
 }
 
-int bench_futex_requeue(int argc, const char **argv)
+static int __bench_futex_requeue(int argc, const char **argv)
 {
 	int ret = 0;
 	unsigned int i, j;
@@ -140,15 +147,20 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (!worker)
 		err(EXIT_FAILURE, "calloc");
 
-	if (!fshared)
+	if (futex2) {
+		futex_flag = FUTEX_32 | (fshared * FUTEX_SHARED_FLAG);
+		rq1.flags |= FUTEX_SHARED_FLAG * fshared;
+		rq2.flags |= FUTEX_SHARED_FLAG * fshared;
+	} else if (!fshared) {
 		futex_flag = FUTEX_PRIVATE_FLAG;
+	}
 
 	if (nrequeue > nthreads)
 		nrequeue = nthreads;
 
 	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %p), "
 	       "%d at a time.\n\n",  getpid(), nthreads,
-	       fshared ? "shared":"private", &futex1, &futex2, nrequeue);
+	       fshared ? "shared":"private", &addr1, &addr2, nrequeue);
 
 	init_stats(&requeued_stats);
 	init_stats(&requeuetime_stats);
@@ -177,11 +189,15 @@ int bench_futex_requeue(int argc, const char **argv)
 		gettimeofday(&start, NULL);
 		while (nrequeued < nthreads) {
 			/*
-			 * Do not wakeup any tasks blocked on futex1, allowing
+			 * Do not wakeup any tasks blocked on addr1, allowing
 			 * us to really measure futex_wait functionality.
 			 */
-			nrequeued += futex_cmp_requeue(&futex1, 0, &futex2, 0,
-						       nrequeue, futex_flag);
+			if (!futex2)
+				nrequeued += futex_cmp_requeue(&addr1, 0, &addr2,
+							0, nrequeue, futex_flag);
+			else
+				nrequeued += futex2_requeue(&rq1, &rq2,
+							0, nrequeue, 0, 0);
 		}
 
 		gettimeofday(&end, NULL);
@@ -195,8 +211,12 @@ int bench_futex_requeue(int argc, const char **argv)
 			       j + 1, nrequeued, nthreads, runtime.tv_usec / (double)USEC_PER_MSEC);
 		}
 
-		/* everybody should be blocked on futex2, wake'em up */
-		nrequeued = futex_wake(&futex2, nrequeued, futex_flag);
+		/* everybody should be blocked on addr2, wake'em up */
+		if (!futex2)
+			nrequeued = futex_wake(&addr2, nrequeued, futex_flag);
+		else
+			nrequeued = futex2_wake(&addr2, nrequeued, futex_flag);
+
 		if (nthreads != nrequeued)
 			warnx("couldn't wakeup all tasks (%d/%d)", nrequeued, nthreads);
 
@@ -221,3 +241,14 @@ int bench_futex_requeue(int argc, const char **argv)
 	usage_with_options(bench_futex_requeue_usage, options);
 	exit(EXIT_FAILURE);
 }
+
+int bench_futex_requeue(int argc, const char **argv)
+{
+       return __bench_futex_requeue(argc, argv);
+}
+
+int bench_futex2_requeue(int argc, const char **argv)
+{
+       futex2 = true;
+       return __bench_futex_requeue(argc, argv);
+}
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index cd2b81a845ac..8a89c6ab9541 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -17,6 +17,12 @@ int bench_futex_wake_parallel(int argc __maybe_unused, const char **argv __maybe
 	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
 	return 0;
 }
+
+int bench_futex2_wake_parallel(int argc __maybe_unused, const char **argv __maybe_unused)
+{
+	pr_err("%s: pthread_barrier_t unavailable, disabling this test...\n", __func__);
+	return 0;
+}
 #else /* HAVE_PTHREAD_BARRIER */
 /* For the CLR_() macros */
 #include <string.h>
@@ -48,7 +54,7 @@ static unsigned int nwakes = 1;
 static u_int32_t futex = 0;
 
 static pthread_t *blocked_worker;
-static bool done = false, silent = false, fshared = false;
+static bool done = false, silent = false, fshared = false, futex2 = false;
 static unsigned int nblocked_threads = 0, nwaking_threads = 0;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
@@ -79,7 +85,11 @@ static void *waking_workerfn(void *arg)
 
 	gettimeofday(&start, NULL);
 
-	waker->nwoken = futex_wake(&futex, nwakes, futex_flag);
+	if (!futex2)
+		waker->nwoken = futex_wake(&futex, nwakes, futex_flag);
+	else
+		waker->nwoken = futex2_wake(&futex, nwakes, futex_flag);
+
 	if (waker->nwoken != nwakes)
 		warnx("couldn't wakeup all tasks (%d/%d)",
 		      waker->nwoken, nwakes);
@@ -130,8 +140,13 @@ static void *blocked_workerfn(void *arg __maybe_unused)
 	pthread_mutex_unlock(&thread_lock);
 
 	while (1) { /* handle spurious wakeups */
-		if (futex_wait(&futex, 0, NULL, futex_flag) != EINTR)
-			break;
+		if (!futex2) {
+			if (futex_wait(&futex, 0, NULL, futex_flag) != EINTR)
+				break;
+		} else {
+			if (futex2_wait(&futex, 0, futex_flag, NULL) != EINTR)
+				break;
+		}
 	}
 
 	pthread_exit(NULL);
@@ -218,7 +233,7 @@ static void toggle_done(int sig __maybe_unused,
 	done = true;
 }
 
-int bench_futex_wake_parallel(int argc, const char **argv)
+static int __bench_futex_wake_parallel(int argc, const char **argv)
 {
 	int ret = 0;
 	unsigned int i, j;
@@ -262,7 +277,9 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	if (!blocked_worker)
 		err(EXIT_FAILURE, "calloc");
 
-	if (!fshared)
+	if (futex2)
+		futex_flag = FUTEX_32 | (fshared * FUTEX_SHARED_FLAG);
+	else if (!fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
 	printf("Run summary [PID %d]: blocking on %d threads (at [%s] "
@@ -322,4 +339,16 @@ int bench_futex_wake_parallel(int argc, const char **argv)
 	free(blocked_worker);
 	return ret;
 }
+
+int bench_futex_wake_parallel(int argc, const char **argv)
+{
+	return __bench_futex_wake_parallel(argc, argv);
+}
+
+int bench_futex2_wake_parallel(int argc, const char **argv)
+{
+	futex2 = true;
+	return __bench_futex_wake_parallel(argc, argv);
+}
+
 #endif /* HAVE_PTHREAD_BARRIER */
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 2dfcef3e371e..be4481f5ee98 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -39,7 +39,7 @@ static u_int32_t futex1 = 0;
 static unsigned int nwakes = 1;
 
 pthread_t *worker;
-static bool done = false, silent = false, fshared = false;
+static bool done = false, silent = false, fshared = false, futex2 = false;
 static pthread_mutex_t thread_lock;
 static pthread_cond_t thread_parent, thread_worker;
 static struct stats waketime_stats, wakeup_stats;
@@ -69,8 +69,13 @@ static void *workerfn(void *arg __maybe_unused)
 	pthread_mutex_unlock(&thread_lock);
 
 	while (1) {
-		if (futex_wait(&futex1, 0, NULL, futex_flag) != EINTR)
-			break;
+		if (!futex2) {
+			if (futex_wait(&futex1, 0, NULL, futex_flag) != EINTR)
+				break;
+		} else {
+			if (futex2_wait(&futex1, 0, futex_flag, NULL) != EINTR)
+				break;
+		}
 	}
 
 	pthread_exit(NULL);
@@ -118,7 +123,7 @@ static void toggle_done(int sig __maybe_unused,
 	done = true;
 }
 
-int bench_futex_wake(int argc, const char **argv)
+static int __bench_futex_wake(int argc, const char **argv)
 {
 	int ret = 0;
 	unsigned int i, j;
@@ -148,7 +153,9 @@ int bench_futex_wake(int argc, const char **argv)
 	if (!worker)
 		err(EXIT_FAILURE, "calloc");
 
-	if (!fshared)
+	if (futex2)
+		futex_flag = FUTEX_32 | (fshared * FUTEX_SHARED_FLAG);
+	else if (!fshared)
 		futex_flag = FUTEX_PRIVATE_FLAG;
 
 	printf("Run summary [PID %d]: blocking on %d threads (at [%s] futex %p), "
@@ -180,9 +187,14 @@ int bench_futex_wake(int argc, const char **argv)
 
 		/* Ok, all threads are patiently blocked, start waking folks up */
 		gettimeofday(&start, NULL);
-		while (nwoken != nthreads)
-			nwoken += futex_wake(&futex1, nwakes, futex_flag);
+		while (nwoken != nthreads) {
+			if (!futex2)
+				nwoken += futex_wake(&futex1, nwakes, futex_flag);
+			else
+				nwoken += futex2_wake(&futex1, nwakes, futex_flag);
+		}
 		gettimeofday(&end, NULL);
+
 		timersub(&end, &start, &runtime);
 
 		update_stats(&wakeup_stats, nwoken);
@@ -212,3 +224,14 @@ int bench_futex_wake(int argc, const char **argv)
 	free(worker);
 	return ret;
 }
+
+int bench_futex_wake(int argc, const char **argv)
+{
+	return __bench_futex_wake(argc, argv);
+}
+
+int bench_futex2_wake(int argc, const char **argv)
+{
+	futex2 = true;
+	return __bench_futex_wake(argc, argv);
+}
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 31b53cc7d5bc..6b2213cf3f64 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -86,4 +86,51 @@ futex_cmp_requeue(u_int32_t *uaddr, u_int32_t val, u_int32_t *uaddr2, int nr_wak
 	return futex(uaddr, FUTEX_CMP_REQUEUE, nr_wake, nr_requeue, uaddr2,
 		 val, opflags);
 }
+
+/**
+ * futex2_wait - Wait at uaddr if *uaddr == val, until timo.
+ * @uaddr: User address to wait for
+ * @val:   Expected value at uaddr
+ * @flags: Operation options
+ * @timo:  Optional timeout
+ *
+ * Return: 0 on success, error code otherwise
+ */
+static inline int futex2_wait(volatile void *uaddr, unsigned long val,
+			      unsigned long flags, struct timespec *timo)
+{
+	return syscall(__NR_futex_wait, uaddr, val, flags, timo);
+}
+
+/**
+ * futex2_wake - Wake a number of waiters waiting at uaddr
+ * @uaddr: Address to wake
+ * @nr:    Number of waiters to wake
+ * @flags: Operation options
+ *
+ * Return: number of waked futexes
+ */
+static inline int futex2_wake(volatile void *uaddr, unsigned int nr, unsigned long flags)
+{
+	return syscall(__NR_futex_wake, uaddr, nr, flags);
+}
+
+/**
+ * futex2_requeue - Requeue waiters from an address to another one
+ * @uaddr1:     Address where waiters are currently waiting on
+ * @uaddr2:     New address to wait
+ * @nr_wake:    Number of waiters at uaddr1 to be wake
+ * @nr_requeue: After waking nr_wake, number of waiters to be requeued
+ * @cmpval:     Expected value at uaddr1
+ * @flags: Operation options
+ *
+ * Return: waked futexes + requeued futexes at uaddr1
+ */
+static inline int futex2_requeue(volatile struct futex_requeue *uaddr1,
+				 volatile struct futex_requeue *uaddr2,
+				 unsigned int nr_wake, unsigned int nr_requeue,
+				 unsigned int cmpval, unsigned long flags)
+{
+	return syscall(__NR_futex_requeue, uaddr1, uaddr2, nr_wake, nr_requeue, cmpval, flags);
+}
 #endif /* _FUTEX_H */
diff --git a/tools/perf/builtin-bench.c b/tools/perf/builtin-bench.c
index 62a7b7420a44..e41a95ad2db6 100644
--- a/tools/perf/builtin-bench.c
+++ b/tools/perf/builtin-bench.c
@@ -12,10 +12,11 @@
  *
  *  sched ... scheduler and IPC performance
  *  syscall ... System call performance
- *  mem   ... memory access performance
- *  numa  ... NUMA scheduling and MM performance
- *  futex ... Futex performance
- *  epoll ... Event poll performance
+ *  mem    ... memory access performance
+ *  numa   ... NUMA scheduling and MM performance
+ *  futex  ... Futex performance
+ *  futex2 ... Futex2 performance
+ *  epoll  ... Event poll performance
  */
 #include <subcmd/parse-options.h>
 #include "builtin.h"
@@ -75,6 +76,14 @@ static struct bench futex_benchmarks[] = {
 	{ NULL,		NULL,						NULL			}
 };
 
+static struct bench futex2_benchmarks[] = {
+	{ "hash",	   "Benchmark for futex2 hash table",            bench_futex2_hash	},
+	{ "wake",	   "Benchmark for futex2 wake calls",            bench_futex2_wake	},
+	{ "wake-parallel", "Benchmark for parallel futex2 wake calls",   bench_futex2_wake_parallel },
+	{ "requeue",	   "Benchmark for futex2 requeue calls",         bench_futex2_requeue	},
+	{ NULL,		NULL,						NULL			}
+};
+
 #ifdef HAVE_EVENTFD_SUPPORT
 static struct bench epoll_benchmarks[] = {
 	{ "wait",	"Benchmark epoll concurrent epoll_waits",       bench_epoll_wait	},
@@ -105,6 +114,7 @@ static struct collection collections[] = {
 	{ "numa",	"NUMA scheduling and MM benchmarks",		numa_benchmarks		},
 #endif
 	{"futex",       "Futex stressing benchmarks",                   futex_benchmarks        },
+	{"futex2",      "Futex2 stressing benchmarks",                  futex2_benchmarks        },
 #ifdef HAVE_EVENTFD_SUPPORT
 	{"epoll",       "Epoll stressing benchmarks",                   epoll_benchmarks        },
 #endif
-- 
2.30.1

