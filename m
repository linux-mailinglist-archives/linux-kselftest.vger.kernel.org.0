Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1C5489E2A
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Jan 2022 18:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238091AbiAJRQX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Jan 2022 12:16:23 -0500
Received: from mail.efficios.com ([167.114.26.124]:49772 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbiAJRQW (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Jan 2022 12:16:22 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 22A5C3C3FC7;
        Mon, 10 Jan 2022 12:16:21 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FluvXcoMxg-w; Mon, 10 Jan 2022 12:16:20 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 1D14F3C404F;
        Mon, 10 Jan 2022 12:16:20 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1D14F3C404F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1641834980;
        bh=Towac6KJ7yE8kwfiBvUBWER2B3g42+m8jmEfU1OrHR8=;
        h=From:To:Date:Message-Id;
        b=FNZGoJ+ji3+KJ0N7E1MVYjA2FSvwvgAT6td3ox4rAz31KlgfwU1BTTcHZ/LDAQilb
         doPvp5drAltzI3Tj/vbq6YpnMZz4Z+RneylJ2XDXjiJs2PjwS5+Mc3zuy3iuFoijgN
         iSEUvDTUNHxNDV8rSOFWCMiuBaDpXdv3MEMuYrJ/998zncQ1rmbMn4CSyq9uRM2CM7
         u5TQdGZb876AB0w6w5zqmMPqwYtQVJniQim7YdkrGg08w2En8uvJ6oYTz9PfPIYRta
         DQePgpv0HTh9y25+2ZAfoe6Z2yYelbrJUcH0XlGl+ZFxFsSm3k1KFTDjTttN98jPKS
         kF2B5Nb6mBBdg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id FDrewIecm0n3; Mon, 10 Jan 2022 12:16:20 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id C75773C4232;
        Mon, 10 Jan 2022 12:16:19 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fw@deneb.enyo.de>, David.Laight@ACULAB.COM,
        carlos@redhat.com,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Subject: [RFC PATCH v2 2/2] selftests: rseq: test abort-at-ip extension on x86
Date:   Mon, 10 Jan 2022 12:16:11 -0500
Message-Id: <20220110171611.8351-2-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
References: <20220110171611.8351-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/rseq/.gitignore       |   1 +
 tools/testing/selftests/rseq/Makefile         |   3 +-
 tools/testing/selftests/rseq/rseq.c           |  21 ++
 tools/testing/selftests/rseq/rseq.h           |  12 +
 .../selftests/rseq/rseq_ext_abort_at_ip.c     | 285 ++++++++++++++++++
 5 files changed, 321 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rseq/rseq_ext_abort_at_ip.c

diff --git a/tools/testing/selftests/rseq/.gitignore b/tools/testing/selftests/rseq/.gitignore
index 5910888ebfe1..472152afab77 100644
--- a/tools/testing/selftests/rseq/.gitignore
+++ b/tools/testing/selftests/rseq/.gitignore
@@ -5,3 +5,4 @@ basic_rseq_op_test
 param_test
 param_test_benchmark
 param_test_compare_twice
+rseq_ext_abort_at_ip
diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
index 2af9d39a9716..dae0dba7552b 100644
--- a/tools/testing/selftests/rseq/Makefile
+++ b/tools/testing/selftests/rseq/Makefile
@@ -13,7 +13,8 @@ LDLIBS += -lpthread
 OVERRIDE_TARGETS = 1
 
 TEST_GEN_PROGS = basic_test basic_percpu_ops_test param_test \
-		param_test_benchmark param_test_compare_twice
+		param_test_benchmark param_test_compare_twice \
+		rseq_ext_abort_at_ip
 
 TEST_GEN_PROGS_EXTENDED = librseq.so
 
diff --git a/tools/testing/selftests/rseq/rseq.c b/tools/testing/selftests/rseq/rseq.c
index 7159eb777fd3..3e012f581ddb 100644
--- a/tools/testing/selftests/rseq/rseq.c
+++ b/tools/testing/selftests/rseq/rseq.c
@@ -73,6 +73,27 @@ static int sys_rseq(volatile struct rseq *rseq_abi, uint32_t rseq_len,
 	return syscall(__NR_rseq, rseq_abi, rseq_len, flags, sig);
 }
 
+/*
+ * Return 0 if extension is available, negative error otherwise.
+ */
+int rseq_query_extension(enum rseq_extension ext)
+{
+	int ret;
+	unsigned int flags;
+
+	switch (ext) {
+	case RSEQ_EXT_ABORT_AT_IP:
+		flags = RSEQ_FLAG_QUERY_ABORT_AT_IP;
+		break;
+	default:
+		return -EINVAL;
+	}
+	ret = sys_rseq(NULL, 0, flags, 0);
+	if (!ret)
+		return 0;
+	return -errno;
+}
+
 int rseq_register_current_thread(void)
 {
 	int rc, ret = 0;
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 3f63eb362b92..34c80402c078 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -67,6 +67,12 @@ extern int __rseq_handled;
 		abort();		\
 	} while (0)
 
+enum rseq_extension {
+	RSEQ_EXT_ABORT_AT_IP = 0,
+};
+
+#define ASM_RSEQ_CS_FLAG_ABORT_AT_IP	(1U << 3)
+
 #if defined(__x86_64__) || defined(__i386__)
 #include <rseq-x86.h>
 #elif defined(__ARMEL__)
@@ -162,4 +168,10 @@ static inline void rseq_prepare_unload(void)
 	rseq_clear_rseq_cs();
 }
 
+/*
+ * Query whether rseq extension is available. Return 0 if available, negative
+ * error value otherwise.
+ */
+int rseq_query_extension(enum rseq_extension ext);
+
 #endif  /* RSEQ_H_ */
diff --git a/tools/testing/selftests/rseq/rseq_ext_abort_at_ip.c b/tools/testing/selftests/rseq/rseq_ext_abort_at_ip.c
new file mode 100644
index 000000000000..4cddf7433cc3
--- /dev/null
+++ b/tools/testing/selftests/rseq/rseq_ext_abort_at_ip.c
@@ -0,0 +1,285 @@
+// SPDX-License-Identifier: LGPL-2.1
+/*
+ * RSEQ abort-at-ip extension test.
+ *
+ * The test test_abort_at_ip_loop() implements an infinite loop which only exits when
+ * aborted.  This rseq critical section is defined with the abort-at-ip
+ * extension, which requires the userspace abort handler to reajust the stack pointer.
+ * This test validates that the abort-at-ip value is within the address range of the
+ * rseq critical section.
+ *
+ * The test test_abort_at_ip_undo() validates that when aborted between two
+ * consecutive increments of two distinct variables, those variables are indeed one
+ * value apart.  This validates that abort undo operations based on the abort-at-ip
+ * work as expected.
+ */
+
+#define _GNU_SOURCE
+#include <assert.h>
+#include <sched.h>
+#include <signal.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/time.h>
+
+#include "rseq.h"
+
+const int nr_iter = 10;
+
+#ifdef __x86_64__
+static void test_abort_at_ip_loop(void)
+{
+	void *abort_ip_addr, *abort_ip_start, *abort_ip_end;
+
+	printf("Testing abort_at_ip infinite loop\n");
+
+	__asm__ __volatile__ goto (
+		__RSEQ_ASM_DEFINE_TABLE(3, 0x0, ASM_RSEQ_CS_FLAG_ABORT_AT_IP, 1f, (2f - 1f), 4f) /* start, post_commit_offset, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		"rep; nop\n\t"	/* cpu_relax for busy loop. */
+		"jmp 1b\n\t"	/* infinite loop. */
+		"2:\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			/* abort-at-ip must be pop from the stack. */
+			"popq %%rcx\n\t"
+			"addq $128, %%rsp\n\t"	/* x86-64 redzone */
+			"movq %%rcx, %[abort_ip_addr]\n\t"
+			"lea 1b(%%rip), %%rcx\n\t"
+			"movq %%rcx, %[abort_ip_start]\n\t"
+			"lea 2b(%%rip), %%rcx\n\t"
+			"movq %%rcx, %[abort_ip_end]\n\t",
+			abort)
+		: /* gcc asm goto does not allow outputs */
+		: [rseq_abi]		"r" (&__rseq_abi),
+		  [abort_ip_addr]	"m" (abort_ip_addr),
+		  [abort_ip_start]	"m" (abort_ip_start),
+		  [abort_ip_end]	"m" (abort_ip_end)
+		: "memory", "cc", "rcx"
+		: abort
+	);
+	fprintf(stderr, "Error: infinite loop should never exit gracefully.\n");
+	abort();
+
+abort:
+	printf("Critical section aborted (as expected) at ip %p, within range [%p,%p[\n",
+			abort_ip_addr, abort_ip_start, abort_ip_end);
+	if (abort_ip_addr < abort_ip_start || abort_ip_addr >= abort_ip_end) {
+		fprintf(stderr, "Error: abort-ip is outside of expected range\n");
+		abort();
+	}
+}
+
+static void test_abort_at_ip_undo(void)
+{
+	void *abort_ip_addr, *abort_ip_start, *abort_ip_end, *ip_after_first_inc, *ip_after_second_inc;
+	unsigned long v[2] = { 0, 0 };
+
+	printf("Testing abort_at_ip undo\n");
+
+	__asm__ __volatile__ goto (
+		__RSEQ_ASM_DEFINE_TABLE(3, 0x0, ASM_RSEQ_CS_FLAG_ABORT_AT_IP, 1f, (2f - 1f), 4f) /* start, post_commit_offset, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		"incq %[v0]\n\t"
+		"10:\n\t"
+		"rep; nop\n\t"
+		"incq %[v1]\n\t"
+		"20:\n\t"
+		"rep; nop\n\t"
+		"jmp 1b\n\t"	/* infinite loop. */
+		"2:\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			/* abort-at-ip must be pop from the stack. */
+			"popq %%rcx\n\t"
+			"addq $128, %%rsp\n\t"	/* x86-64 redzone */
+			"movq %%rcx, %[abort_ip_addr]\n\t"
+			"lea 1b(%%rip), %%rcx\n\t"
+			"movq %%rcx, %[abort_ip_start]\n\t"
+			"lea 2b(%%rip), %%rcx\n\t"
+			"movq %%rcx, %[abort_ip_end]\n\t"
+			"lea 10b(%%rip), %%rcx\n\t"
+			"movq %%rcx, %[ip_after_first_inc]\n\t"
+			"lea 20b(%%rip), %%rcx\n\t"
+			"movq %%rcx, %[ip_after_second_inc]\n\t",
+			abort)
+		: /* gcc asm goto does not allow outputs */
+		: [rseq_abi]		"r" (&__rseq_abi),
+		  [abort_ip_addr]	"m" (abort_ip_addr),
+		  [abort_ip_start]	"m" (abort_ip_start),
+		  [abort_ip_end]	"m" (abort_ip_end),
+		  [ip_after_first_inc]	"m" (ip_after_first_inc),
+		  [ip_after_second_inc]	"m" (ip_after_second_inc),
+		  [v0]			"m" (v[0]),
+		  [v1]			"m" (v[1])
+		: "memory", "cc", "rcx"
+		: abort
+	);
+	fprintf(stderr, "Error: infinite loop should never exit gracefully.\n");
+	abort();
+
+abort:
+	printf("Critical section aborted (as expected) at ip %p, within range [%p,%p[\n",
+			abort_ip_addr, abort_ip_start, abort_ip_end);
+	if (abort_ip_addr < abort_ip_start || abort_ip_addr >= abort_ip_end) {
+		fprintf(stderr, "Error: abort-ip is outside of expected range\n");
+		abort();
+	}
+	printf("ip after first inc: %p, ip after second inc: %p\n",
+			ip_after_first_inc, ip_after_second_inc);
+	printf("Counter values: v0: %lu v1: %lu\n", v[0], v[1]);
+	if (abort_ip_addr < ip_after_first_inc || abort_ip_addr >= ip_after_second_inc) {
+		if (v[0] != v[1])
+			abort();
+	} else {
+		if (v[0] != v[1] + 1)
+			abort();
+	}
+}
+#elif defined (__i386__)
+static void test_abort_at_ip_loop(void)
+{
+	void *abort_ip_addr, *abort_ip_start, *abort_ip_end;
+
+	printf("Testing abort_at_ip infinite loop\n");
+
+	__asm__ __volatile__ goto (
+		__RSEQ_ASM_DEFINE_TABLE(3, 0x0, ASM_RSEQ_CS_FLAG_ABORT_AT_IP, 1f, (2f - 1f), 4f) /* start, post_commit_offset, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		"rep; nop\n\t"	/* cpu_relax for busy loop. */
+		"jmp 1b\n\t"	/* infinite loop. */
+		"2:\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			/* abort-at-ip must be pop from the stack. */
+			"popl %%ecx\n\t"
+			"movl %%ecx, %[abort_ip_addr]\n\t"
+			"movl $1b, %%ecx\n\t"
+			"movl %%ecx, %[abort_ip_start]\n\t"
+			"movl $2b, %%ecx\n\t"
+			"movl %%ecx, %[abort_ip_end]\n\t",
+			abort)
+		: /* gcc asm goto does not allow outputs */
+		: [rseq_abi]		"r" (&__rseq_abi),
+		  [abort_ip_addr]	"m" (abort_ip_addr),
+		  [abort_ip_start]	"m" (abort_ip_start),
+		  [abort_ip_end]	"m" (abort_ip_end)
+		: "memory", "cc", "ecx"
+		: abort
+	);
+	fprintf(stderr, "Error: infinite loop should never exit gracefully.\n");
+	abort();
+
+abort:
+	printf("Critical section aborted (as expected) at ip %p, within range [%p,%p[\n",
+			abort_ip_addr, abort_ip_start, abort_ip_end);
+	if (abort_ip_addr < abort_ip_start || abort_ip_addr >= abort_ip_end) {
+		fprintf(stderr, "Error: abort-ip is outside of expected range\n");
+		abort();
+	}
+}
+
+static void test_abort_at_ip_undo(void)
+{
+	void *abort_ip_addr, *abort_ip_start, *abort_ip_end, *ip_after_first_inc, *ip_after_second_inc;
+	unsigned long v[2] = { 0, 0 };
+
+	printf("Testing abort_at_ip undo\n");
+
+	__asm__ __volatile__ goto (
+		__RSEQ_ASM_DEFINE_TABLE(3, 0x0, ASM_RSEQ_CS_FLAG_ABORT_AT_IP, 1f, (2f - 1f), 4f) /* start, post_commit_offset, abort */
+		/* Start rseq by storing table entry pointer into rseq_cs. */
+		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
+		"incl %[v0]\n\t"
+		"10:\n\t"
+		"rep; nop\n\t"
+		"incl %[v1]\n\t"
+		"20:\n\t"
+		"rep; nop\n\t"
+		"jmp 1b\n\t"	/* infinite loop. */
+		"2:\n\t"
+		RSEQ_ASM_DEFINE_ABORT(4,
+			/* abort-at-ip must be pop from the stack. */
+			"popl %%ecx\n\t"
+			"movl %%ecx, %[abort_ip_addr]\n\t"
+			"movl $1b, %%ecx\n\t"
+			"movl %%ecx, %[abort_ip_start]\n\t"
+			"movl $2b, %%ecx\n\t"
+			"movl %%ecx, %[abort_ip_end]\n\t"
+			"movl $10b, %%ecx\n\t"
+			"movl %%ecx, %[ip_after_first_inc]\n\t"
+			"movl $20b, %%ecx\n\t"
+			"movl %%ecx, %[ip_after_second_inc]\n\t",
+			abort)
+		: /* gcc asm goto does not allow outputs */
+		: [rseq_abi]		"r" (&__rseq_abi),
+		  [abort_ip_addr]	"m" (abort_ip_addr),
+		  [abort_ip_start]	"m" (abort_ip_start),
+		  [abort_ip_end]	"m" (abort_ip_end),
+		  [ip_after_first_inc]	"m" (ip_after_first_inc),
+		  [ip_after_second_inc]	"m" (ip_after_second_inc),
+		  [v0]			"m" (v[0]),
+		  [v1]			"m" (v[1])
+		: "memory", "cc", "rcx"
+		: abort
+	);
+	fprintf(stderr, "Error: infinite loop should never exit gracefully.\n");
+	abort();
+
+abort:
+	printf("Critical section aborted (as expected) at ip %p, within range [%p,%p[\n",
+			abort_ip_addr, abort_ip_start, abort_ip_end);
+	if (abort_ip_addr < abort_ip_start || abort_ip_addr >= abort_ip_end) {
+		fprintf(stderr, "Error: abort-ip is outside of expected range\n");
+		abort();
+	}
+	printf("ip after first inc: %p, ip after second inc: %p\n",
+			ip_after_first_inc, ip_after_second_inc);
+	printf("Counter values: v0: %lu v1: %lu\n", v[0], v[1]);
+	if (abort_ip_addr < ip_after_first_inc || abort_ip_addr >= ip_after_second_inc) {
+		if (v[0] != v[1])
+			abort();
+	} else {
+		if (v[0] != v[1] + 1)
+			abort();
+	}
+}
+#else
+static void test_abort_at_ip_loop(void)
+{
+	abort();
+}
+static void test_abort_at_ip_undo(void)
+{
+	abort();
+}
+#endif
+
+int main(int argc, char **argv)
+{
+	int i;
+
+	if (rseq_register_current_thread()) {
+		fprintf(stderr, "Error: rseq_register_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto init_thread_error;
+	}
+	printf("testing abort-at-ip extension\n");
+	if (rseq_query_extension(RSEQ_EXT_ABORT_AT_IP) != 0) {
+		fprintf(stderr, "RSEQ abort-at-ip extension is not supported, skipping test.\n");
+		return 0;
+	}
+	for (i = 0; i < nr_iter; i++)
+		test_abort_at_ip_loop();
+	for (i = 0; i < nr_iter; i++)
+		test_abort_at_ip_undo();
+	if (rseq_unregister_current_thread()) {
+		fprintf(stderr, "Error: rseq_unregister_current_thread(...) failed(%d): %s\n",
+			errno, strerror(errno));
+		goto init_thread_error;
+	}
+	return 0;
+
+init_thread_error:
+	return -1;
+}
-- 
2.17.1

