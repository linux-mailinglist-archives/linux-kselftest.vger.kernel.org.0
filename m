Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FFB486E4
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jun 2019 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbfFQPXV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jun 2019 11:23:21 -0400
Received: from mail.efficios.com ([167.114.142.138]:49246 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfFQPXV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jun 2019 11:23:21 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 826181D3299;
        Mon, 17 Jun 2019 11:23:19 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id ngNwKsoUCGaa; Mon, 17 Jun 2019 11:23:19 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id EE5031D3296;
        Mon, 17 Jun 2019 11:23:18 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EE5031D3296
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1560784999;
        bh=f6zEYKJAJi61hi21J79TEKs+00z096e7T6EdDgLZ27Q=;
        h=From:To:Date:Message-Id;
        b=XUfSTY7iw/fxGCimF720oI0UhmPxVmZr0fed4jAc6D0gpqwoyfmz/Cwdohyvv/Hm2
         y6PMBYLiVQ8f/wDBthKLFyVvTG8sbCkTX9TBdZEaTT992gFU3Di082S30pv6t2wXJi
         umbT3GGplzzGAxcu5tCOM0tw0waBdnivsaWvyIhSisWysalMqcYYMvOg6f+ndVje5q
         VrWzzpTooBDGyo7nrHsXcIDlNeqgo7xQaRFKCZ1Q5ftx7cbXsDoUb34kR3Esax76OI
         I3RF37qUbredmBKubaVKwjbIp0bF0aiL7gDknaLY9IPWqMKxjJu1SJg0gW9aSBa7SZ
         hkIPnRV2GTO0g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id NWfrek6MexdY; Mon, 17 Jun 2019 11:23:18 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-181-218.qc.cable.ebox.net [192.222.181.218])
        by mail.efficios.com (Postfix) with ESMTPSA id 61ADB1D3291;
        Mon, 17 Jun 2019 11:23:18 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>, Will Deacon <will.deacon@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Andi Kleen <andi@firstfloor.org>,
        linux-kselftest@vger.kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Chris Lameter <cl@linux.com>,
        Russell King <linux@arm.linux.org.uk>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        "Paul E . McKenney" <paulmck@linux.vnet.ibm.com>,
        Paul Turner <pjt@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Maurer <bmaurer@fb.com>, linux-api@vger.kernel.org,
        Andy Lutomirski <luto@amacapital.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Carlos O'Donell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>
Subject: [RFC PATCH 1/1] Revert "rseq/selftests: arm: use udf instruction for RSEQ_SIG"
Date:   Mon, 17 Jun 2019 17:23:04 +0200
Message-Id: <20190617152304.23371-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit 2b845d4b4acd9422bbb668989db8dc36dfc8f438.

That commit introduces build issues for programs compiled in Thumb mode.
Rather than try to be clever and emit a valid trap instruction on arm32,
which requires special care about big/little endian handling on that
architecture, just emit plain data. Data in the instruction stream is
technically expected on arm32: this is how literal pools are
implemented. Reverting to the prior behavior does exactly that.

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
CC: Carlos O'Donell <carlos@redhat.com>
CC: Florian Weimer <fweimer@redhat.com>
---
 tools/testing/selftests/rseq/rseq-arm.h | 52 ++-------------------------------
 1 file changed, 2 insertions(+), 50 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 84f28f147fb6..5f262c54364f 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -5,54 +5,7 @@
  * (C) Copyright 2016-2018 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
 
-/*
- * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
- * value 0x5de3. This traps if user-space reaches this instruction by mistake,
- * and the uncommon operand ensures the kernel does not move the instruction
- * pointer to attacker-controlled code on rseq abort.
- *
- * The instruction pattern in the A32 instruction set is:
- *
- * e7f5def3    udf    #24035    ; 0x5de3
- *
- * This translates to the following instruction pattern in the T16 instruction
- * set:
- *
- * little endian:
- * def3        udf    #243      ; 0xf3
- * e7f5        b.n    <7f5>
- *
- * pre-ARMv6 big endian code:
- * e7f5        b.n    <7f5>
- * def3        udf    #243      ; 0xf3
- *
- * ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
- * code and big-endian data. Ensure the RSEQ_SIG data signature matches code
- * endianness. Prior to ARMv6, -mbig-endian generates big-endian code and data
- * (which match), so there is no need to reverse the endianness of the data
- * representation of the signature. However, the choice between BE32 and BE8
- * is done by the linker, so we cannot know whether code and data endianness
- * will be mixed before the linker is invoked.
- */
-
-#define RSEQ_SIG_CODE	0xe7f5def3
-
-#ifndef __ASSEMBLER__
-
-#define RSEQ_SIG_DATA							\
-	({								\
-		int sig;						\
-		asm volatile ("b 2f\n\t"				\
-			      "1: .inst " __rseq_str(RSEQ_SIG_CODE) "\n\t" \
-			      "2:\n\t"					\
-			      "ldr %[sig], 1b\n\t"			\
-			      : [sig] "=r" (sig));			\
-		sig;							\
-	})
-
-#define RSEQ_SIG	RSEQ_SIG_DATA
-
-#endif
+#define RSEQ_SIG	0x53053053
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
 #define rseq_smp_rmb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
@@ -125,8 +78,7 @@ do {									\
 		__rseq_str(table_label) ":\n\t"				\
 		".word " __rseq_str(version) ", " __rseq_str(flags) "\n\t" \
 		".word " __rseq_str(start_ip) ", 0x0, " __rseq_str(post_commit_offset) ", 0x0, " __rseq_str(abort_ip) ", 0x0\n\t" \
-		".arm\n\t"						\
-		".inst " __rseq_str(RSEQ_SIG_CODE) "\n\t"		\
+		".word " __rseq_str(RSEQ_SIG) "\n\t"			\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
 		"b %l[" __rseq_str(abort_label) "]\n\t"
-- 
2.11.0

