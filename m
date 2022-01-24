Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16C044985FD
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244195AbiAXRNE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:04 -0500
Received: from mail.efficios.com ([167.114.26.124]:47570 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241364AbiAXRND (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:03 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id CCA2D344DF8;
        Mon, 24 Jan 2022 12:13:02 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id ysl8MXygjoqX; Mon, 24 Jan 2022 12:13:02 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 352B6344ECF;
        Mon, 24 Jan 2022 12:13:02 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 352B6344ECF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044382;
        bh=oKlOf+nVMMlHqBqQz2I6FgRkqolRzU2v4PRwhXuP0bM=;
        h=From:To:Date:Message-Id;
        b=fKOXrrAvN44daJhJdyAAVUg1Rodvs3o16nWUNNpLlDVh369vKz9zR0FmRTahXxAqR
         dc3smbsPBfxJ9GAhB4K2Q2ApLbQabjlaXeoyKWsqokgVMFtYfIUI/zGvnbmxbc1ZOq
         znA+nA4j0dQUm4AnUim2njA3bmXiLxbEHIyh2AKxWgBrtCRSjUV1eSOH3GE3fBSw+Z
         MYr0xLVWv3m44vAzj2LooHt6oLJDoRzoa+M09yg89WjLNrcC9IvUnZi1DkQ54zZel7
         leooeYC4706/VWLIE/loMEMMc9Wkq/b9uAtaN8nHwhOFPPQt+ecEuv+FHFcbYoGZcF
         E6hSxT49j6n1w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id J91tDVyZiEOW; Mon, 24 Jan 2022 12:13:02 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id F059734518C;
        Mon, 24 Jan 2022 12:13:01 -0500 (EST)
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
Subject: [RFC PATCH 01/15] selftests/rseq: introduce own copy of rseq uapi header
Date:   Mon, 24 Jan 2022 12:12:39 -0500
Message-Id: <20220124171253.22072-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The Linux kernel rseq uapi header has a broken layout for the
rseq_cs.ptr field on 32-bit little endian architectures. The entire
rseq_cs.ptr field is planned for removal, leaving only the 64-bit
rseq_cs.ptr64 field available.

Both glibc and librseq use their own copy of the Linux kernel uapi
header, where they introduce proper union fields to access to the 32-bit
low order bits of the rseq_cs pointer on 32-bit architectures.

Introduce a copy of the Linux kernel uapi headers in the Linux kernel
selftests.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-abi.h | 151 ++++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.c     |  14 +--
 tools/testing/selftests/rseq/rseq.h     |  10 +-
 3 files changed, 161 insertions(+), 14 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/rseq-abi.h

diff --git a/tools/testing/selftests/rseq/rseq-abi.h b/tools/testing/selftests/rseq/rseq-abi.h
new file mode 100644
index 000000000000..a8c44d9af71f
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq-abi.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
+#ifndef _RSEQ_ABI_H
+#define _RSEQ_ABI_H
+
+/*
+ * rseq-abi.h
+ *
+ * Restartable sequences system call API
+ *
+ * Copyright (c) 2015-2022 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#include <linux/types.h>
+#include <asm/byteorder.h>
+
+enum rseq_abi_cpu_id_state {
+	RSEQ_ABI_CPU_ID_UNINITIALIZED			= -1,
+	RSEQ_ABI_CPU_ID_REGISTRATION_FAILED		= -2,
+};
+
+enum rseq_abi_flags {
+	RSEQ_ABI_FLAG_UNREGISTER = (1 << 0),
+};
+
+enum rseq_abi_cs_flags_bit {
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT	= 0,
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT	= 1,
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT	= 2,
+};
+
+enum rseq_abi_cs_flags {
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT_BIT),
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL_BIT),
+	RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE	=
+		(1U << RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE_BIT),
+};
+
+/*
+ * struct rseq_abi_cs is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line. It is usually declared as
+ * link-time constant data.
+ */
+struct rseq_abi_cs {
+	/* Version of this structure. */
+	__u32 version;
+	/* enum rseq_abi_cs_flags */
+	__u32 flags;
+	__u64 start_ip;
+	/* Offset from start_ip. */
+	__u64 post_commit_offset;
+	__u64 abort_ip;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+/*
+ * struct rseq_abi is aligned on 4 * 8 bytes to ensure it is always
+ * contained within a single cache-line.
+ *
+ * A single struct rseq_abi per thread is allowed.
+ */
+struct rseq_abi {
+	/*
+	 * Restartable sequences cpu_id_start field. Updated by the
+	 * kernel. Read by user-space with single-copy atomicity
+	 * semantics. This field should only be read by the thread which
+	 * registered this data structure. Aligned on 32-bit. Always
+	 * contains a value in the range of possible CPUs, although the
+	 * value may not be the actual current CPU (e.g. if rseq is not
+	 * initialized). This CPU number value should always be compared
+	 * against the value of the cpu_id field before performing a rseq
+	 * commit or returning a value read from a data structure indexed
+	 * using the cpu_id_start value.
+	 */
+	__u32 cpu_id_start;
+	/*
+	 * Restartable sequences cpu_id field. Updated by the kernel.
+	 * Read by user-space with single-copy atomicity semantics. This
+	 * field should only be read by the thread which registered this
+	 * data structure. Aligned on 32-bit. Values
+	 * RSEQ_CPU_ID_UNINITIALIZED and RSEQ_CPU_ID_REGISTRATION_FAILED
+	 * have a special semantic: the former means "rseq uninitialized",
+	 * and latter means "rseq initialization failed". This value is
+	 * meant to be read within rseq critical sections and compared
+	 * with the cpu_id_start value previously read, before performing
+	 * the commit instruction, or read and compared with the
+	 * cpu_id_start value before returning a value loaded from a data
+	 * structure indexed using the cpu_id_start value.
+	 */
+	__u32 cpu_id;
+	/*
+	 * Restartable sequences rseq_cs field.
+	 *
+	 * Contains NULL when no critical section is active for the current
+	 * thread, or holds a pointer to the currently active struct rseq_cs.
+	 *
+	 * Updated by user-space, which sets the address of the currently
+	 * active rseq_cs at the beginning of assembly instruction sequence
+	 * block, and set to NULL by the kernel when it restarts an assembly
+	 * instruction sequence block, as well as when the kernel detects that
+	 * it is preempting or delivering a signal outside of the range
+	 * targeted by the rseq_cs. Also needs to be set to NULL by user-space
+	 * before reclaiming memory that contains the targeted struct rseq_cs.
+	 *
+	 * Read and set by the kernel. Set by user-space with single-copy
+	 * atomicity semantics. This field should only be updated by the
+	 * thread which registered this data structure. Aligned on 64-bit.
+	 */
+	union {
+		__u64 ptr64;
+
+		/*
+		 * The "arch" field provides architecture accessor for
+		 * the ptr field based on architecture pointer size and
+		 * endianness.
+		 */
+		struct {
+#ifdef __LP64__
+			__u64 ptr;
+#elif defined(__BYTE_ORDER) ? (__BYTE_ORDER == __BIG_ENDIAN) : defined(__BIG_ENDIAN)
+			__u32 padding;		/* Initialized to zero. */
+			__u32 ptr;
+#else
+			__u32 ptr;
+			__u32 padding;		/* Initialized to zero. */
+#endif
+		} arch;
+	} rseq_cs;
+
+	/*
+	 * Restartable sequences flags field.
+	 *
+	 * This field should only be updated by the thread which
+	 * registered this data structure. Read by the kernel.
+	 * Mainly used for single-stepping through rseq critical sections
+	 * with debuggers.
+	 *
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_PREEMPT
+	 *     Inhibit instruction sequence block restart on preemption
+	 *     for this thread.
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_SIGNAL
+	 *     Inhibit instruction sequence block restart on signal
+	 *     delivery for this thread.
+	 * - RSEQ_ABI_CS_FLAG_NO_RESTART_ON_MIGRATE
+	 *     Inhibit instruction sequence block restart on migration for
+	 *     this thread.
+	 */
+	__u32 flags;
+} __attribute__((aligned(4 * sizeof(__u64))));
+
+#endif /* _RSEQ_ABI_H */
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index fb440dfca158..bfe1b2692ffc 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -30,8 +30,8 @@
 #include "../kselftest.h"
 #include "rseq.h"
 
-__thread volatile struct rseq __rseq_abi = {
-	.cpu_id = RSEQ_CPU_ID_UNINITIALIZED,
+__thread volatile struct rseq_abi __rseq_abi = {
+	.cpu_id = RSEQ_ABI_CPU_ID_UNINITIALIZED,
 };
 
 /*
@@ -66,7 +66,7 @@ static void signal_restore(sigset_t oldset)
 		abort();
 }
 
-static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
+static int sys_rseq(volatile struct rseq_abi *rseq_abi, uint32_t rseq_len,
 		    int flags, uint32_t sig)
 {
 	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
@@ -86,13 +86,13 @@ int rseq_register_current_thread(void)
 	}
 	if (__rseq_refcount++)
 		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq), 0, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi), 0, RSEQ_SIG);
 	if (!rc) {
 		assert(rseq_current_cpu_raw() >= 0);
 		goto end;
 	}
 	if (errno != EBUSY)
-		__rseq_abi.cpu_id = RSEQ_CPU_ID_REGISTRATION_FAILED;
+		__rseq_abi.cpu_id = RSEQ_ABI_CPU_ID_REGISTRATION_FAILED;
 	ret = -1;
 	__rseq_refcount--;
 end:
@@ -114,8 +114,8 @@ int rseq_unregister_current_thread(void)
 	}
 	if (--__rseq_refcount)
 		goto end;
-	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq),
-		      RSEQ_FLAG_UNREGISTER, RSEQ_SIG);
+	rc = sys_rseq(&__rseq_abi, sizeof(struct rseq_abi),
+		      RSEQ_ABI_FLAG_UNREGISTER, RSEQ_SIG);
 	if (!rc)
 		goto end;
 	__rseq_refcount = 1;
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 3f63eb362b92..cb6bbc53b586 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -16,7 +16,7 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <linux/rseq.h>
+#include "rseq-abi.h"
 
 /*
  * Empty code injection macros, override when testing.
@@ -43,7 +43,7 @@
 #define RSEQ_INJECT_FAILED
 #endif
 
-extern __thread volatile struct rseq __rseq_abi;
+extern __thread volatile struct rseq_abi __rseq_abi;
 extern int __rseq_handled;
 
 #define rseq_likely(x)		__builtin_expect(!!(x), 1)
@@ -139,11 +139,7 @@ static inline uint32_t rseq_current_cpu(void)
 
 static inline void rseq_clear_rseq_cs(void)
 {
-#ifdef __LP64__
-	__rseq_abi.rseq_cs.ptr = 0;
-#else
-	__rseq_abi.rseq_cs.ptr.ptr32 = 0;
-#endif
+	__rseq_abi.rseq_cs.arch.ptr = 0;
 }
 
 /*
-- 
2.17.1

