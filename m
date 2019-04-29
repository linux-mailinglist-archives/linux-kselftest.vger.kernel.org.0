Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85D74E66B
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 17:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbfD2P3a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 11:29:30 -0400
Received: from mail.efficios.com ([167.114.142.138]:56878 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfD2P31 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 11:29:27 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 28F031C1CCF;
        Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id LYiy8g9nm78c; Mon, 29 Apr 2019 11:29:23 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id DBB9B1C1CB6;
        Mon, 29 Apr 2019 11:29:23 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com DBB9B1C1CB6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551763;
        bh=5oUdS+icuBkuPOyTqA3X1w+UYQEJ+ghMDP1uU8+8yJU=;
        h=From:To:Date:Message-Id;
        b=o5UAiBcBpXTaTH+wC8hdXhrMtwrhtTNV7WP98/PFoREClK82WNSONafB1NpLSYV3G
         BAC/hrBXAtedQv9tYhzcFiwyhoQRoXLtZDHtRvfwRbgLwEYgLrZo+2Qir0lfcTYF68
         o1thgyMM5f/TL5gjTNo+432LDps8sj/04743LIHEwnVWNuzEoQ1Y6KrNBw0LCRDj//
         EtkJnwl9SQMAb4G/VbAQDbXgTZuunF3XTrLw/1L+A5HOy2TDav5J1hWA49cZVHjnqi
         vMDnmztYznbKdttbWprulwM2IChVR9xYaZ/0pKU5ZxYT06lX9+fIkItOnC8e1tfRnm
         SuDkREsBWR4Mg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id vUnlW9RAs-s1; Mon, 29 Apr 2019 11:29:23 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id B0C921C1C93;
        Mon, 29 Apr 2019 11:29:22 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>, Paul Turner <pjt@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <andi@firstfloor.org>, Chris Lameter <cl@linux.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kselftest@vger.kernel.org
Subject: [PATCH for 5.2 02/12] rseq/selftests: Add __rseq_exit_point_array section for debuggers
Date:   Mon, 29 Apr 2019 11:27:53 -0400
Message-Id: <20190429152803.7719-3-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Knowing all exit points is useful to assist debuggers stepping over the
rseq critical sections without requiring them to disassemble the content
of the critical section to figure out the exit points.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Joel Fernandes <joelaf@google.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Catalin Marinas <catalin.marinas@arm.com>
CC: Dave Watson <davejwatson@fb.com>
CC: Will Deacon <will.deacon@arm.com>
CC: Shuah Khan <shuah@kernel.org>
CC: Andi Kleen <andi@firstfloor.org>
CC: linux-kselftest@vger.kernel.org
CC: "H . Peter Anvin" <hpa@zytor.com>
CC: Chris Lameter <cl@linux.com>
CC: Russell King <linux@arm.linux.org.uk>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>
CC: Paul Turner <pjt@google.com>
CC: Boqun Feng <boqun.feng@gmail.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ben Maurer <bmaurer@fb.com>
CC: linux-api@vger.kernel.org
CC: Andy Lutomirski <luto@amacapital.net>
CC: Andrew Morton <akpm@linux-foundation.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>
---
 tools/testing/selftests/rseq/rseq-arm.h   | 52 +++++++++++++++++
 tools/testing/selftests/rseq/rseq-arm64.h | 52 +++++++++++++++++
 tools/testing/selftests/rseq/rseq-mips.h  | 53 +++++++++++++++++
 tools/testing/selftests/rseq/rseq-ppc.h   | 66 ++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq-s390.h  | 55 ++++++++++++++++++
 tools/testing/selftests/rseq/rseq-x86.h   | 94 +++++++++++++++++++++++++++++++
 6 files changed, 372 insertions(+)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 3cea19877227..17e8d231943a 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -42,6 +42,19 @@ do {									\
 	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip,			\
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) ", 0x0\n\t" \
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 		RSEQ_INJECT_ASM(1)					\
 		"adr r0, " __rseq_str(cs_label) "\n\t"			\
@@ -87,6 +100,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -149,6 +167,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -215,6 +238,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -267,6 +293,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -337,6 +368,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -408,6 +444,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -486,6 +528,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"str %[src], %[rseq_scratch0]\n\t"
 		"str %[dst], %[rseq_scratch1]\n\t"
 		"str %[len], %[rseq_scratch2]\n\t"
@@ -605,6 +652,11 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"str %[src], %[rseq_scratch0]\n\t"
 		"str %[dst], %[rseq_scratch1]\n\t"
 		"str %[len], %[rseq_scratch2]\n\t"
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 954f34671ca6..2079f71e0ca2 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -95,6 +95,19 @@ do {										\
 	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,			\
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)				\
+	"	.pushsection __rseq_exit_point_array, \"aw\"\n"			\
+	"	.quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n"	\
+	"	.popsection\n"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
 	RSEQ_INJECT_ASM(1)							\
 	"	adrp	" RSEQ_ASM_TMP_REG ", " __rseq_str(cs_label) "\n"	\
@@ -182,6 +195,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -231,6 +249,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -282,6 +305,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -325,6 +351,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -379,6 +410,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -433,6 +469,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error3])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -490,6 +532,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
@@ -545,6 +592,11 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1, 2f, 3f, 4f)
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(2f, %l[error2])
+#endif
 		RSEQ_ASM_STORE_RSEQ_CS(2, 1b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
 		RSEQ_INJECT_ASM(3)
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 7f48ecf46994..25d10ff54769 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -68,6 +68,20 @@ do {									\
 	__RSEQ_ASM_DEFINE_TABLE(0x0, 0x0, start_ip, \
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip) \
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(start_ip)) "\n\t" \
+		LONG " " U32_U64_PAD(__rseq_str(exit_ip)) "\n\t" \
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs) \
 		RSEQ_INJECT_ASM(1) \
 		LONG_LA " $4, " __rseq_str(cs_label) "\n\t" \
@@ -114,6 +128,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -174,6 +193,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -238,6 +262,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -290,6 +317,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -358,6 +390,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -427,6 +464,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3f, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -501,6 +544,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		LONG_S " %[src], %[rseq_scratch0]\n\t"
 		LONG_S "  %[dst], %[rseq_scratch1]\n\t"
 		LONG_S " %[len], %[rseq_scratch2]\n\t"
@@ -617,6 +665,11 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		LONG_S " %[src], %[rseq_scratch0]\n\t"
 		LONG_S " %[dst], %[rseq_scratch1]\n\t"
 		LONG_S " %[len], %[rseq_scratch2]\n\t"
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index 52630c9f42be..24f95649d71e 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -63,6 +63,19 @@ do {									\
 		"std %%r17, %[" __rseq_str(rseq_cs) "]\n\t"			\
 		__rseq_str(label) ":\n\t"
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n\t" \
+		".popsection\n\t"
+
 #else /* #ifdef __PPC64__ */
 
 #define STORE_WORD	"stw "
@@ -80,6 +93,20 @@ do {									\
 		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) "\n\t" \
 		".popsection\n\t"
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)				\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"		\
+		/* 32-bit only supported on BE */				\
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n\t"	\
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)			\
 		RSEQ_INJECT_ASM(1)						\
 		"lis %%r17, (" __rseq_str(cs_label) ")@ha\n\t"			\
@@ -169,6 +196,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -224,6 +256,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -286,6 +323,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -337,6 +377,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -400,6 +445,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -465,6 +515,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		/* cmp cpuid */
@@ -532,6 +588,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* setup for mempcy */
 		"mr %%r19, %[len]\n\t"
 		"mr %%r20, %[src]\n\t"
@@ -601,6 +662,11 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* setup for mempcy */
 		"mr %%r19, %[len]\n\t"
 		"mr %%r20, %[src]\n\t"
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 1069e85258ce..b8b5b6f900af 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -44,6 +44,19 @@ do {									\
 		".quad " __rseq_str(start_ip) ", " __rseq_str(post_commit_offset) ", " __rseq_str(abort_ip) "\n\t" \
 		".popsection\n\t"
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n\t" \
+		".popsection\n\t"
+
 #elif __s390__
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
@@ -55,6 +68,19 @@ do {									\
 		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) "\n\t" \
 		".popsection\n\t"
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".long 0x0, " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) "\n\t" \
+		".popsection\n\t"
+
 #define LONG_L			"l"
 #define LONG_S			"st"
 #define LONG_LT_R		"ltr"
@@ -102,6 +128,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -160,6 +191,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -220,6 +256,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -268,6 +307,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -339,6 +383,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, rseq_cs)
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, 4f)
@@ -407,6 +457,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		LONG_S " %[src], %[rseq_scratch0]\n\t"
 		LONG_S " %[dst], %[rseq_scratch1]\n\t"
 		LONG_S " %[len], %[rseq_scratch2]\n\t"
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index a5341044a2f5..0668608d3674 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -58,6 +58,19 @@ do {									\
 	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".quad " __rseq_str(start_ip) ", " __rseq_str(exit_ip) "\n\t" \
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 		RSEQ_INJECT_ASM(1)					\
 		"leaq " __rseq_str(cs_label) "(%%rip), %%rax\n\t"	\
@@ -93,6 +106,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -149,6 +167,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -207,6 +230,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -251,6 +277,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -320,6 +351,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -386,6 +423,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"movq %[src], %[rseq_scratch0]\n\t"
 		"movq %[dst], %[rseq_scratch1]\n\t"
 		"movq %[len], %[rseq_scratch2]\n\t"
@@ -535,6 +577,19 @@ do {									\
 	__RSEQ_ASM_DEFINE_TABLE(label, 0x0, 0x0, start_ip,		\
 				(post_commit_ip - start_ip), abort_ip)
 
+/*
+ * Exit points of a rseq critical section consist of all instructions outside
+ * of the critical section where a critical section can either branch to or
+ * reach through the normal course of its execution. The abort IP and the
+ * post-commit IP are already part of the __rseq_table section and should not
+ * be explicitly defined as additional exit points. Knowing all exit points is
+ * useful to assist debuggers stepping over the critical section.
+ */
+#define RSEQ_ASM_DEFINE_EXIT_POINT(start_ip, exit_ip)			\
+		".pushsection __rseq_exit_point_array, \"aw\"\n\t"	\
+		".long " __rseq_str(start_ip) ", 0x0, " __rseq_str(exit_ip) ", 0x0\n\t" \
+		".popsection\n\t"
+
 #define RSEQ_ASM_STORE_RSEQ_CS(label, cs_label, rseq_cs)		\
 		RSEQ_INJECT_ASM(1)					\
 		"movl $" __rseq_str(cs_label) ", " __rseq_str(rseq_cs) "\n\t"	\
@@ -569,6 +624,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -625,6 +685,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -683,6 +748,9 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -727,6 +795,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -788,6 +861,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -852,6 +930,12 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error3])
+#endif
 		/* Start rseq by storing table entry pointer into rseq_cs. */
 		RSEQ_ASM_STORE_RSEQ_CS(1, 3b, RSEQ_CS_OFFSET(%[rseq_abi]))
 		RSEQ_ASM_CMP_CPU_ID(cpu_id, RSEQ_CPU_ID_OFFSET(%[rseq_abi]), 4f)
@@ -920,6 +1004,11 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"movl %[src], %[rseq_scratch0]\n\t"
 		"movl %[dst], %[rseq_scratch1]\n\t"
 		"movl %[len], %[rseq_scratch2]\n\t"
@@ -1027,6 +1116,11 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(3, 1f, 2f, 4f) /* start, commit, abort */
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
+#ifdef RSEQ_COMPARE_TWICE
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error1])
+		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[error2])
+#endif
 		"movl %[src], %[rseq_scratch0]\n\t"
 		"movl %[dst], %[rseq_scratch1]\n\t"
 		"movl %[len], %[rseq_scratch2]\n\t"
-- 
2.11.0



