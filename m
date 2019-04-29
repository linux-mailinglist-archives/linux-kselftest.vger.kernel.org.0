Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE9BEE679
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 17:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfD2PaG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 11:30:06 -0400
Received: from mail.efficios.com ([167.114.142.138]:56878 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728705AbfD2P3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 11:29:31 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 92EE71C1D3E;
        Mon, 29 Apr 2019 11:29:29 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 2QtgW_yqZKnH; Mon, 29 Apr 2019 11:29:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 8FCD21C1D06;
        Mon, 29 Apr 2019 11:29:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 8FCD21C1D06
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551767;
        bh=DCmt1f7ebDuw8znshKo0sgR6MYHScO2p10uW028uR5A=;
        h=From:To:Date:Message-Id;
        b=aiUupiJHCN2lCITd4TZ3AV4BWiHpStgwEIV4HAl11Q65hX/BDqiODsiV7mRoziZs+
         NqskWeCB0zf9jxtZzAS7+Z6VbN667KF5Dq8wer25GlKdfwgSuqXzgrBe9twlUCzbyk
         fn6y32eH7dVIUjBkZ0TTdoNHu2b+E1ROFWaT0KSDTMMowgwvFTtZPEJEbyJp34YgOM
         Y3dSUu6+bLTY5THZPvl0qdU9O+izV3NkB2h/rx48u3E4yOv9cnayO2eJ+beH+qsSEL
         RbMygON/iQnpZTNTqmAXSJ7haC8Bw9S6YWNHAzd4kdKVfIUE35l4aN+oA9YxzWT+UL
         b1A6bKV2R5p/w==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ikHmD8WesGBG; Mon, 29 Apr 2019 11:29:27 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 45A4B1C1CF1;
        Mon, 29 Apr 2019 11:29:26 -0400 (EDT)
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
Subject: [PATCH for 5.2 08/12] rseq/selftests: arm: use udf instruction for RSEQ_SIG
Date:   Mon, 29 Apr 2019 11:27:59 -0400
Message-Id: <20190429152803.7719-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use udf as the guard instruction for the restartable sequence abort
handler.

Previously, the chosen signature was not a valid instruction, based
on the assumption that it could always sit in a literal pool. However,
there are compilation environments in which literal pools are not
availble, for instance execute-only code. Therefore, we need to
choose a signature value that is also a valid instruction.

Handle compiling with -mbig-endian on ARMv6+, which generates binaries
with mixed code vs data endianness (little endian code, big endian
data).

Else mismatch between code endianness for the generated signatures and
data endianness for the RSEQ_SIG parameter passed to the rseq
registration will trigger application segmentation faults when the
kernel try to abort rseq critical sections.

Prior to ARMv6, -mbig-endian generates big-endian code and data, so
endianness should not be reversed in that case.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
CC: Peter Zijlstra <peterz@infradead.org>
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Joel Fernandes <joelaf@google.com>
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
 tools/testing/selftests/rseq/rseq-arm.h | 52 +++++++++++++++++++++++++++++++--
 1 file changed, 50 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 5f262c54364f..e8ccfc37d685 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -5,7 +5,54 @@
  * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-#define RSEQ_SIG	0x53053053
+/*
+ * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
+ * value 0x5de3. This traps if user-space reaches this instruction by mistake,
+ * and the uncommon operand ensures the kernel does not move the instruction
+ * pointer to attacker-controlled code on rseq abort.
+ *
+ * The instruction pattern in the A32 instruction set is:
+ *
+ * e7f5def3    udf    #24035    ; 0x5de3
+ *
+ * This translates to the following instruction pattern in the T16 instruction
+ * set:
+ *
+ * little endian:
+ * def3        udf    #243      ; 0xf3
+ * e7f5        b.n    <7f5>
+ *
+ * pre-ARMv6 big endian code:
+ * e7f5        b.n    <7f5>
+ * def3        udf    #243      ; 0xf3
+ *
+ * ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
+ * code and big-endian data. Ensure the RSEQ_SIG data signature matches code
+ * endianness. Prior to ARMv6, -mbig-endian generates big-endian code and data
+ * (which match), so there is no need to reverse the endianness of the data
+ * representation of the signature. However, the choice between BE32 and BE8
+ * is done by the linker, so we cannot know whether code and data endianness
+ * will be mixed before the linker is invoked.
+ */
+
+#define RSEQ_SIG_CODE	0xe7f5def3
+
+#ifndef __ASSEMBLER__
+
+#define RSEQ_SIG_DATA							\
+	({								\
+		int sig;						\
+		asm volatile (  "b 2f\n\t"				\
+				"1: .inst " __rseq_str(RSEQ_SIG_CODE) "\n\t" \
+				"2:\n\t"				\
+				"ldr %[sig], 1b\n\t"			\
+				: [sig] "=r" (sig));			\
+		sig;							\
+	})
+
+#define RSEQ_SIG	RSEQ_SIG_DATA
+
+#endif
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
 #define rseq_smp_rmb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
@@ -78,7 +125,8 @@ do {									\
 		__rseq_str(table_label) ":\n\t"				\
 		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
-		".word " __rseq_str(RSEQ_SIG) "\n\t"			\
+		".arm\n\t"						\
+		".inst " __rseq_str(RSEQ_SIG_CODE) "\n\t"		\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
 		"b %l[" __rseq_str(abort_label) "]\n\t"
-- 
2.11.0

