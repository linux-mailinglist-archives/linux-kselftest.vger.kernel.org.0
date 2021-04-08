Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FC43580DC
	for <lists+linux-kselftest@lfdr.de>; Thu,  8 Apr 2021 12:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbhDHKhn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 8 Apr 2021 06:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhDHKhP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 8 Apr 2021 06:37:15 -0400
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7268DC0613DB
        for <linux-kselftest@vger.kernel.org>; Thu,  8 Apr 2021 03:37:04 -0700 (PDT)
Received: by mail-wr1-x44a.google.com with SMTP id x18so791261wrt.12
        for <linux-kselftest@vger.kernel.org>; Thu, 08 Apr 2021 03:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ovZor/YA8Mn2bsdM5I3c9xRpJwXvNo3zi3skLZLNZKI=;
        b=ZQEHMvhTux2YO84YdFma3MKfL9DE+W07zpEQDKjc6B56Q95iM1Xxvt2BsuphId4ap2
         RCt5XRiGeZ77QB3hrC4Ze8UE2UwcpwHBC6iafXCuNwMgYZA9X8v7IYwSZWGaqYdfzJXJ
         va7wFa4tKjGIeJnH8Oy4Ll7ZilLxZKvRepBr0Bbd2lXZl5zah26k/pnKDJdpztgba9UR
         awkKoCGjNuR6SF8KXCmVUi8LZUVSXII/ReP+xJOGmKml3XFqFLII58B8vmG/vjM0cfaF
         TpdzEcoT7VNLJJlR9rikiNkGYxglUp780ei5p5LmZ/YnkAIHS0hASGGKlpd7lpI54bsA
         iDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ovZor/YA8Mn2bsdM5I3c9xRpJwXvNo3zi3skLZLNZKI=;
        b=mcdDqjeC+8DQ+iZ3D5wOqnMk1zjZJMgWmj/WD7KIZAIprvGqKlaV2OemSmMzuRkGtl
         WlFL6mvwlzH10ErBHuIJQ7XU52BPoAqW096yF/IHd0rJUCzZdqTqaJdZ7Se5mkFP+28H
         li8Uq2latRVw6wG/G7sG2k7tQu4ekybKXuTe2areR1jmsv/cAXHlfOEsP7tzFZ1seGq2
         3ms77eWTorl5SCPPeK1ykduZKDIW6GzAgnzoKe91zc9+yK44qh/JtBqz11LF4nLk/ame
         tzMF0pvo6WLY2M7EjZF2egYuki1UBlDzOnzaHUw2HrIUj/M+Lzn62h28Vs0Rn3wZtBb5
         Jbpw==
X-Gm-Message-State: AOAM5319crnmAhGBEKnFZ/Igd4X34+aEZ0/w5r6iVfYEmrcybWnBqOs0
        btseNWURmZlcoQ3v7SlxMnRwemysdA==
X-Google-Smtp-Source: ABdhPJxIgDc6WjR28u/P9dTwz6hJ9YB1fxcYI0IYw1md+CAFZXMziZ9BSYbGIP9zaGRHDCDzOXkd758r2w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9038:bbd3:4a12:abda])
 (user=elver job=sendgmr) by 2002:a7b:c159:: with SMTP id z25mr476087wmi.1.1617878222309;
 Thu, 08 Apr 2021 03:37:02 -0700 (PDT)
Date:   Thu,  8 Apr 2021 12:36:02 +0200
In-Reply-To: <20210408103605.1676875-1-elver@google.com>
Message-Id: <20210408103605.1676875-8-elver@google.com>
Mime-Version: 1.0
References: <20210408103605.1676875-1-elver@google.com>
X-Mailer: git-send-email 2.31.0.208.g409f899ff0-goog
Subject: [PATCH v4 07/10] selftests/perf_events: Add kselftest for
 process-wide sigtrap handling
From:   Marco Elver <elver@google.com>
To:     elver@google.com, peterz@infradead.org,
        alexander.shishkin@linux.intel.com, acme@kernel.org,
        mingo@redhat.com, jolsa@redhat.com, mark.rutland@arm.com,
        namhyung@kernel.org, tglx@linutronix.de
Cc:     glider@google.com, viro@zeniv.linux.org.uk, arnd@arndb.de,
        christian@brauner.io, dvyukov@google.com, jannh@google.com,
        axboe@kernel.dk, mascasa@google.com, pcc@google.com,
        irogers@google.com, oleg@redhat.com, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a kselftest for testing process-wide perf events with synchronous
SIGTRAP on events (using breakpoints). In particular, we want to test
that changes to the event propagate to all children, and the SIGTRAPs
are in fact synchronously sent to the thread where the event occurred.

Note: The "signal_stress" test case is also added later in the series to
perf tool's built-in tests. The test here is more elaborate in that
respect, which on one hand avoids bloating the perf tool unnecessarily,
but we also benefit from structured tests with TAP-compliant output that
the kselftest framework provides.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Update for new perf_event_attr::sig_data / si_perf handling.

v3:
* Fix for latest libc signal.h.

v2:
* Patch added to series.
---
 .../testing/selftests/perf_events/.gitignore  |   2 +
 tools/testing/selftests/perf_events/Makefile  |   6 +
 tools/testing/selftests/perf_events/config    |   1 +
 tools/testing/selftests/perf_events/settings  |   1 +
 .../selftests/perf_events/sigtrap_threads.c   | 210 ++++++++++++++++++
 5 files changed, 220 insertions(+)
 create mode 100644 tools/testing/selftests/perf_events/.gitignore
 create mode 100644 tools/testing/selftests/perf_events/Makefile
 create mode 100644 tools/testing/selftests/perf_events/config
 create mode 100644 tools/testing/selftests/perf_events/settings
 create mode 100644 tools/testing/selftests/perf_events/sigtrap_threads.c

diff --git a/tools/testing/selftests/perf_events/.gitignore b/tools/testing/selftests/perf_events/.gitignore
new file mode 100644
index 000000000000..4dc43e1bd79c
--- /dev/null
+++ b/tools/testing/selftests/perf_events/.gitignore
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+sigtrap_threads
diff --git a/tools/testing/selftests/perf_events/Makefile b/tools/testing/selftests/perf_events/Makefile
new file mode 100644
index 000000000000..973a2c39ca83
--- /dev/null
+++ b/tools/testing/selftests/perf_events/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
+CFLAGS += -Wl,-no-as-needed -Wall -I../../../../usr/include
+LDFLAGS += -lpthread
+
+TEST_GEN_PROGS := sigtrap_threads
+include ../lib.mk
diff --git a/tools/testing/selftests/perf_events/config b/tools/testing/selftests/perf_events/config
new file mode 100644
index 000000000000..ba58ff2203e4
--- /dev/null
+++ b/tools/testing/selftests/perf_events/config
@@ -0,0 +1 @@
+CONFIG_PERF_EVENTS=y
diff --git a/tools/testing/selftests/perf_events/settings b/tools/testing/selftests/perf_events/settings
new file mode 100644
index 000000000000..6091b45d226b
--- /dev/null
+++ b/tools/testing/selftests/perf_events/settings
@@ -0,0 +1 @@
+timeout=120
diff --git a/tools/testing/selftests/perf_events/sigtrap_threads.c b/tools/testing/selftests/perf_events/sigtrap_threads.c
new file mode 100644
index 000000000000..9c0fd442da60
--- /dev/null
+++ b/tools/testing/selftests/perf_events/sigtrap_threads.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test for perf events with SIGTRAP across all threads.
+ *
+ * Copyright (C) 2021, Google LLC.
+ */
+
+#define _GNU_SOURCE
+
+/* We need the latest siginfo from the kernel repo. */
+#include <sys/types.h>
+#include <asm/siginfo.h>
+#define __have_siginfo_t 1
+#define __have_sigval_t 1
+#define __have_sigevent_t 1
+#define __siginfo_t_defined
+#define __sigval_t_defined
+#define __sigevent_t_defined
+#define _BITS_SIGINFO_CONSTS_H 1
+#define _BITS_SIGEVENT_CONSTS_H 1
+
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <linux/hw_breakpoint.h>
+#include <linux/perf_event.h>
+#include <pthread.h>
+#include <signal.h>
+#include <sys/ioctl.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+
+#include "../kselftest_harness.h"
+
+#define NUM_THREADS 5
+
+/* Data shared between test body, threads, and signal handler. */
+static struct {
+	int tids_want_signal;		/* Which threads still want a signal. */
+	int signal_count;		/* Sanity check number of signals received. */
+	volatile int iterate_on;	/* Variable to set breakpoint on. */
+	siginfo_t first_siginfo;	/* First observed siginfo_t. */
+} ctx;
+
+/* Unique value to check si_perf is correctly set from perf_event_attr::sig_data. */
+#define TEST_SIG_DATA(addr) (~(uint64_t)(addr))
+
+static struct perf_event_attr make_event_attr(bool enabled, volatile void *addr)
+{
+	struct perf_event_attr attr = {
+		.type		= PERF_TYPE_BREAKPOINT,
+		.size		= sizeof(attr),
+		.sample_period	= 1,
+		.disabled	= !enabled,
+		.bp_addr	= (unsigned long)addr,
+		.bp_type	= HW_BREAKPOINT_RW,
+		.bp_len		= HW_BREAKPOINT_LEN_1,
+		.inherit	= 1, /* Children inherit events ... */
+		.inherit_thread = 1, /* ... but only cloned with CLONE_THREAD. */
+		.remove_on_exec = 1, /* Required by sigtrap. */
+		.sigtrap	= 1, /* Request synchronous SIGTRAP on event. */
+		.sig_data	= TEST_SIG_DATA(addr),
+	};
+	return attr;
+}
+
+static void sigtrap_handler(int signum, siginfo_t *info, void *ucontext)
+{
+	if (info->si_code != TRAP_PERF) {
+		fprintf(stderr, "%s: unexpected si_code %d\n", __func__, info->si_code);
+		return;
+	}
+
+	/*
+	 * The data in siginfo_t we're interested in should all be the same
+	 * across threads.
+	 */
+	if (!__atomic_fetch_add(&ctx.signal_count, 1, __ATOMIC_RELAXED))
+		ctx.first_siginfo = *info;
+	__atomic_fetch_sub(&ctx.tids_want_signal, syscall(__NR_gettid), __ATOMIC_RELAXED);
+}
+
+static void *test_thread(void *arg)
+{
+	pthread_barrier_t *barrier = (pthread_barrier_t *)arg;
+	pid_t tid = syscall(__NR_gettid);
+	int iter;
+	int i;
+
+	pthread_barrier_wait(barrier);
+
+	__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+	iter = ctx.iterate_on; /* read */
+	for (i = 0; i < iter - 1; i++) {
+		__atomic_fetch_add(&ctx.tids_want_signal, tid, __ATOMIC_RELAXED);
+		ctx.iterate_on = iter; /* idempotent write */
+	}
+
+	return NULL;
+}
+
+FIXTURE(sigtrap_threads)
+{
+	struct sigaction oldact;
+	pthread_t threads[NUM_THREADS];
+	pthread_barrier_t barrier;
+	int fd;
+};
+
+FIXTURE_SETUP(sigtrap_threads)
+{
+	struct perf_event_attr attr = make_event_attr(false, &ctx.iterate_on);
+	struct sigaction action = {};
+	int i;
+
+	memset(&ctx, 0, sizeof(ctx));
+
+	/* Initialize sigtrap handler. */
+	action.sa_flags = SA_SIGINFO | SA_NODEFER;
+	action.sa_sigaction = sigtrap_handler;
+	sigemptyset(&action.sa_mask);
+	ASSERT_EQ(sigaction(SIGTRAP, &action, &self->oldact), 0);
+
+	/* Initialize perf event. */
+	self->fd = syscall(__NR_perf_event_open, &attr, 0, -1, -1, PERF_FLAG_FD_CLOEXEC);
+	ASSERT_NE(self->fd, -1);
+
+	/* Spawn threads inheriting perf event. */
+	pthread_barrier_init(&self->barrier, NULL, NUM_THREADS + 1);
+	for (i = 0; i < NUM_THREADS; i++)
+		ASSERT_EQ(pthread_create(&self->threads[i], NULL, test_thread, &self->barrier), 0);
+}
+
+FIXTURE_TEARDOWN(sigtrap_threads)
+{
+	pthread_barrier_destroy(&self->barrier);
+	close(self->fd);
+	sigaction(SIGTRAP, &self->oldact, NULL);
+}
+
+static void run_test_threads(struct __test_metadata *_metadata,
+			     FIXTURE_DATA(sigtrap_threads) *self)
+{
+	int i;
+
+	pthread_barrier_wait(&self->barrier);
+	for (i = 0; i < NUM_THREADS; i++)
+		ASSERT_EQ(pthread_join(self->threads[i], NULL), 0);
+}
+
+TEST_F(sigtrap_threads, remain_disabled)
+{
+	run_test_threads(_metadata, self);
+	EXPECT_EQ(ctx.signal_count, 0);
+	EXPECT_NE(ctx.tids_want_signal, 0);
+}
+
+TEST_F(sigtrap_threads, enable_event)
+{
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	run_test_threads(_metadata, self);
+
+	EXPECT_EQ(ctx.signal_count, NUM_THREADS);
+	EXPECT_EQ(ctx.tids_want_signal, 0);
+	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
+	EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
+
+	/* Check enabled for parent. */
+	ctx.iterate_on = 0;
+	EXPECT_EQ(ctx.signal_count, NUM_THREADS + 1);
+}
+
+/* Test that modification propagates to all inherited events. */
+TEST_F(sigtrap_threads, modify_and_enable_event)
+{
+	struct perf_event_attr new_attr = make_event_attr(true, &ctx.iterate_on);
+
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_MODIFY_ATTRIBUTES, &new_attr), 0);
+	run_test_threads(_metadata, self);
+
+	EXPECT_EQ(ctx.signal_count, NUM_THREADS);
+	EXPECT_EQ(ctx.tids_want_signal, 0);
+	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
+	EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
+
+	/* Check enabled for parent. */
+	ctx.iterate_on = 0;
+	EXPECT_EQ(ctx.signal_count, NUM_THREADS + 1);
+}
+
+/* Stress test event + signal handling. */
+TEST_F(sigtrap_threads, signal_stress)
+{
+	ctx.iterate_on = 3000;
+
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_ENABLE, 0), 0);
+	run_test_threads(_metadata, self);
+	EXPECT_EQ(ioctl(self->fd, PERF_EVENT_IOC_DISABLE, 0), 0);
+
+	EXPECT_EQ(ctx.signal_count, NUM_THREADS * ctx.iterate_on);
+	EXPECT_EQ(ctx.tids_want_signal, 0);
+	EXPECT_EQ(ctx.first_siginfo.si_addr, &ctx.iterate_on);
+	EXPECT_EQ(ctx.first_siginfo.si_errno, PERF_TYPE_BREAKPOINT);
+	EXPECT_EQ(ctx.first_siginfo.si_perf, TEST_SIG_DATA(&ctx.iterate_on));
+}
+
+TEST_HARNESS_MAIN
-- 
2.31.0.208.g409f899ff0-goog

