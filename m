Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EF6498609
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244273AbiAXRNR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:17 -0500
Received: from mail.efficios.com ([167.114.26.124]:47718 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244226AbiAXRNK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:10 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 7889F34505A;
        Mon, 24 Jan 2022 12:13:09 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id dNVoBbm7khw3; Mon, 24 Jan 2022 12:13:08 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 5B27D345056;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 5B27D345056
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044385;
        bh=QwwQMSP03A+KEeC+Dceg3C+tGl78L+8u/KYMQ8AZLww=;
        h=From:To:Date:Message-Id;
        b=R5HTWDXywDbK/A4kZVcYHMC9QSVImn1Yy51MZnSEpvHHEON+7nkL34T5BFQhaczYo
         Di1p87NgfzcU4EOpnlU+GWVR0Do4NTAEXygW+OsFtbRagG9/Wnv+5yj92AymCYMQwd
         aFOavmTiU+czUxGrh+mkbXBt77grUkgREthBOvUrzK/oKXs6rkQ5r3kF1EwrSSC6hg
         OcVMNddDQzc7WnIh4DRywEXVq+5rX0Aa5olp9B/0L8FWUROHOsEFnrKgYGT0VxR5kt
         9bu6gMRgHcTH0xuO0OJNrohzLbcWCiNN1bHFcbqLENOs4NdHj1trueMEoMuE4Y0lCj
         Ql22/2Hi1oXgg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id VnpF75HxbK6K; Mon, 24 Jan 2022 12:13:05 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id A3DDB344ED7;
        Mon, 24 Jan 2022 12:13:03 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RFC PATCH 07/15] selftests/rseq: Uplift rseq selftests for compatibility with glibc-2.35
Date:   Mon, 24 Jan 2022 12:12:45 -0500
Message-Id: <20220124171253.22072-8-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

glibc-2.35 (upcoming release date 2022-02-01) exposes the rseq per-thread
data in the TCB, accessible at an offset from the thread pointer, rather
than through an actual Thread-Local Storage (TLS) variable, as the
Linux kernel selftests initially expected.

The __rseq_abi TLS and glibc-2.35's ABI for per-thread data cannot
actively coexist in a process, because the kernel supports only a single
rseq registration per thread.

Here is the scheme introduced to ensure selftests can work both with an
older glibc and with glibc-2.35+:

- librseq exposes its own "rseq_offset, rseq_size, rseq_flags" ABI.

- librseq queries for glibc rseq ABI (__rseq_offset, __rseq_size,
  __rseq_flags) using dlsym() in a librseq library constructor. If those
  are found, copy their values into rseq_offset, rseq_size, and
  rseq_flags.

- Else, if those glibc symbols are not found, handle rseq registration
  from librseq and use its own IE-model TLS to implement the rseq ABI
  per-thread storage.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/Makefile |   2 +-
 tools/testing/selftests/rseq/rseq.c   | 161 ++++++++++++--------------
 tools/testing/selftests/rseq/rseq.h   |  13 ++-
 3 files changed, 88 insertions(+), 88 deletions(-)

diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 2af9d39a9716..215e1067f037 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -6,7 +6,7 @@ endif
 
 CFLAGS += -O2 -Wall -g -I./ -I../../../../usr/include/ -L$(OUTPUT) -Wl,-rpath=./ \
 	  $(CLANG_FLAGS)
-LDLIBS += -lpthread
+LDLIBS += -lpthread -ldl
 
 # Own dependencies because we only want to build against 1st prerequisite, but
 # still track changes to header files and depend on shared object.
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 1f905b60728a..07ba0d463a96 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -26,130 +26,123 @@
 #include <assert.h>
 #include <signal.h>
 #include <limits.h>
+#include <dlfcn.h>
 
 #include "../kselftest.h"
 #include "rseq.h"
 
-__thread struct rseq_abi __rseq_abi = {
-	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
-};
+static const int *libc_rseq_offset_p;
+static const unsigned int *libc_rseq_size_p;
+static const unsigned int *libc_rseq_flags_p;
 
-/*
- * Shared with other libraries. This library may take rseq ownership if it is
- * still 0 when executing the library constructor. Set to 1 by library
- * constructor when handling rseq. Set to 0 in destructor if handling rseq.
- */
-int __rseq_handled;
+/* Offset from the thread pointer to the rseq area.  */
+int rseq_offset;
+
+/* Size of the registered rseq area.  0 if the registration was
+   unsuccessful.  */
+unsigned int rseq_size = -1U;
+
+/* Flags used during rseq registration.  */
+unsigned int rseq_flags;
 
-/* Whether this library have ownership of rseq registration. */
 static int rseq_ownership;
 
-static __thread volatile uint32_t __rseq_refcount;
+static
+__thread struct rseq_abi __rseq_abi __attribute__((tls_model("initial-exec"))) = {
+	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
+};
 
-static void signal_off_save(sigset_t *oldset)
+static int sys_rseq(struct rseq_abi *rseq_abi, uint32_t rseq_len,
+		    int flags, uint32_t sig)
 {
-	sigset_t set;
-	int ret;
-
-	sigfillset(&set);
-	ret = pthread_sigmask(SIG_BLOCK, &set, oldset);
-	if (ret)
-		abort();
+	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
 }
 
-static void signal_restore(sigset_t oldset)
+int rseq_available(void)
 {
-	int ret;
+	int rc;
 
-	ret = pthread_sigmask(SIG_SETMASK, &oldset, NULL);
-	if (ret)
+	rc = sys_rseq(NULL, 0, 0, 0);
+	if (rc != -1)
 		abort();
-}
-
-static int sys_rseq(volatile struct rseq_abi *rseq_abi, uint32_t rseq_len,
-		    int flags, uint32_t sig)
-{
-	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
+	switch (errno) {
+	case ENOSYS:
+		return 0;
+	case EINVAL:
+		return 1;
+	default:
+		abort();
+	}
 }
 
 int rseq_register_current_thread(void)
 {
-	int rc, ret = 0;
-	sigset_t oldset;
+	int rc;
 
-	if (!rseq_ownership)
+	if (!rseq_ownership) {
+		/* Treat libc's ownership as a successful registration. */
 		return 0;
-	signal_off_save(&oldset);
-	if (__rseq_refcount == UINT_MAX) {
-		ret = -1;
-		goto end;
 	}
-	if (__rseq_refcount++)
-		goto end;
 	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
-	if (!rc) {
-		assert(rseq_current_cpu_raw() >= 0);
-		goto end;
-	}
-	if (errno != EBUSY)
-		RSEQ_WRITE_ONCE(__rseq_abi.cpu_id, RSEQ_ABI_CPU_ID_REGISTRATION_FAILED);
-	ret = -1;
-	__rseq_refcount--;
-end:
-	signal_restore(oldset);
-	return ret;
+	if (rc)
+		return -1;
+	assert(rseq_current_cpu_raw() >= 0);
+	return 0;
 }
 
 int rseq_unregister_current_thread(void)
 {
-	int rc, ret = 0;
-	sigset_t oldset;
+	int rc;
 
-	if (!rseq_ownership)
+	if (!rseq_ownership) {
+		/* Treat libc's ownership as a successful unregistration. */
 		return 0;
-	signal_off_save(&oldset);
-	if (!__rseq_refcount) {
-		ret = -1;
-		goto end;
 	}
-	if (--__rseq_refcount)
-		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi),
-		      RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
-	if (!rc)
-		goto end;
-	__rseq_refcount = 1;
-	ret = -1;
-end:
-	signal_restore(oldset);
-	return ret;
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
+	if (rc)
+		return -1;
+	return 0;
 }
 
-int32_t rseq_fallback_current_cpu(void)
+static __attribute__((constructor))
+void rseq_init(void)
 {
-	int32_t cpu;
-
-	cpu = sched_getcpu();
-	if (cpu < 0) {
-		perror("sched_getcpu()");
-		abort();
+	libc_rseq_offset_p = dlsym(RTLD_NEXT, "__rseq_offset");
+	libc_rseq_size_p = dlsym(RTLD_NEXT, "__rseq_size");
+	libc_rseq_flags_p = dlsym(RTLD_NEXT, "__rseq_flags");
+	if (libc_rseq_size_p && libc_rseq_offset_p && libc_rseq_flags_p) {
+		/* rseq registration owned by glibc */
+		rseq_offset = *libc_rseq_offset_p;
+		rseq_size = *libc_rseq_size_p;
+		rseq_flags = *libc_rseq_flags_p;
+		return;
 	}
-	return cpu;
-}
-
-void __attribute__((constructor)) rseq_init(void)
-{
-	/* Check whether rseq is handled by another library. */
-	if (__rseq_handled)
+	if (!rseq_available())
 		return;
-	__rseq_handled = 1;
 	rseq_ownership = 1;
+	rseq_offset = (void *)&__rseq_abi - rseq_thread_pointer();
+	rseq_size = sizeof(struct rseq_abi);
+	rseq_flags = 0;
 }
 
-void __attribute__((destructor)) rseq_fini(void)
+static __attribute__((destructor))
+void rseq_exit(void)
 {
 	if (!rseq_ownership)
 		return;
-	__rseq_handled = 0;
+	rseq_offset = 0;
+	rseq_size = -1U;
 	rseq_ownership = 0;
 }
+
+int32_t rseq_fallback_current_cpu(void)
+{
+	int32_t cpu;
+
+	cpu = sched_getcpu();
+	if (cpu < 0) {
+		perror("sched_getcpu()");
+		abort();
+	}
+	return cpu;
+}
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index ca668a2af172..17531ccd3090 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -43,12 +43,19 @@
 #define RSEQ_INJECT_FAILED
 #endif
 
-extern __thread struct rseq_abi __rseq_abi;
-extern int __rseq_handled;
+#include "rseq-thread-pointer.h"
+
+/* Offset from the thread pointer to the rseq area.  */
+extern int rseq_offset;
+/* Size of the registered rseq area.  0 if the registration was
+   unsuccessful.  */
+extern unsigned int rseq_size;
+/* Flags used during rseq registration.  */
+extern unsigned int rseq_flags;
 
 static inline struct rseq_abi *rseq_get_abi(void)
 {
-	return &__rseq_abi;
+	return (struct rseq_abi *) ((uintptr_t) rseq_thread_pointer() + rseq_offset);
 }
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
-- 
2.17.1

