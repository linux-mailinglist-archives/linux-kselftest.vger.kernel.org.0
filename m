Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E21279691
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Jul 2019 21:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390868AbfG2TxG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Jul 2019 15:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:45068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403961AbfG2TxF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Jul 2019 15:53:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFEBF21773;
        Mon, 29 Jul 2019 19:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564429983;
        bh=gJD8e620zaPYnffCTRC+zsCd09tdPtH5UnNylRM9SSU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DBfIvMaK8nCZHlACUV0qXdOzlvKyC/ApQOzTjZRHSgQZn46dwgEGCLfrZgNsktiM5
         pDMDf2bIKT7/mpVzFQFIDqU3O5pa938VLkJgB5WTFLpKGcVbz3hW3hOB7qs7TG5eCC
         dwywnWkuq+gskCGHVhSQPVa+glonWsRNv9Ip9YRg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joelaf@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Watson <davejwatson@fb.com>,
        Shuah Khan <shuah@kernel.org>,
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
        Carlos ODonell <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 121/215] rseq/selftests: Fix Thumb mode build failure on arm32
Date:   Mon, 29 Jul 2019 21:21:57 +0200
Message-Id: <20190729190800.113109828@linuxfoundation.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729190739.971253303@linuxfoundation.org>
References: <20190729190739.971253303@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

[ Upstream commit ee8a84c60bcc1f1615bd9cb3edfe501e26cdc85b ]

Using ".arm .inst" for the arm signature introduces build issues for
programs compiled in Thumb mode because the assembler stays in the
arm mode for the rest of the inline assembly. Revert to using a ".word"
to express the signature as data instead.

The choice of signature is a valid trap instruction on arm32 little
endian, where both code and data are little endian.

ARMv6+ big endian (BE8) generates mixed endianness code vs data:
little-endian code and big-endian data. The data value of the signature
needs to have its byte order reversed to generate the trap instruction.

Prior to ARMv6, -mbig-endian generates big-endian code and data
(which match), so the endianness of the data representation of the
signature should not be reversed. However, the choice between BE32
and BE8 is done by the linker, so we cannot know whether code and
data endianness will be mixed before the linker is invoked. So rather
than try to play tricks with the linker, the rseq signature is simply
data (not a trap instruction) prior to ARMv6 on big endian. This is
why the signature is expressed as data (.word) rather than as
instruction (.inst) in assembler.

Because a ".word" is used to emit the signature, it will be interpreted
as a literal pool by a disassembler, not as an actual instruction.
Considering that the signature is not meant to be executed except in
scenarios where the program execution is completely bogus, this should
not be an issue.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Acked-by: Will Deacon <will.deacon@arm.com>
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
Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/testing/selftests/rseq/rseq-arm.h | 61 +++++++++++++------------
 1 file changed, 33 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 84f28f147fb6..5943c816c07c 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -6,6 +6,8 @@
  */
 
 /*
+ * - ARM little endian
+ *
  * RSEQ_SIG uses the udf A32 instruction with an uncommon immediate operand
  * value 0x5de3. This traps if user-space reaches this instruction by mistake,
  * and the uncommon operand ensures the kernel does not move the instruction
@@ -22,36 +24,40 @@
  * def3        udf    #243      ; 0xf3
  * e7f5        b.n    <7f5>
  *
- * pre-ARMv6 big endian code:
- * e7f5        b.n    <7f5>
- * def3        udf    #243      ; 0xf3
+ * - ARMv6+ big endian (BE8):
  *
  * ARMv6+ -mbig-endian generates mixed endianness code vs data: little-endian
- * code and big-endian data. Ensure the RSEQ_SIG data signature matches code
- * endianness. Prior to ARMv6, -mbig-endian generates big-endian code and data
- * (which match), so there is no need to reverse the endianness of the data
- * representation of the signature. However, the choice between BE32 and BE8
- * is done by the linker, so we cannot know whether code and data endianness
- * will be mixed before the linker is invoked.
+ * code and big-endian data. The data value of the signature needs to have its
+ * byte order reversed to generate the trap instruction:
+ *
+ * Data: 0xf3def5e7
+ *
+ * Translates to this A32 instruction pattern:
+ *
+ * e7f5def3    udf    #24035    ; 0x5de3
+ *
+ * Translates to this T16 instruction pattern:
+ *
+ * def3        udf    #243      ; 0xf3
+ * e7f5        b.n    <7f5>
+ *
+ * - Prior to ARMv6 big endian (BE32):
+ *
+ * Prior to ARMv6, -mbig-endian generates big-endian code and data
+ * (which match), so the endianness of the data representation of the
+ * signature should not be reversed. However, the choice between BE32
+ * and BE8 is done by the linker, so we cannot know whether code and
+ * data endianness will be mixed before the linker is invoked. So rather
+ * than try to play tricks with the linker, the rseq signature is simply
+ * data (not a trap instruction) prior to ARMv6 on big endian. This is
+ * why the signature is expressed as data (.word) rather than as
+ * instruction (.inst) in assembler.
  */
 
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
+#ifdef __ARMEB__
+#define RSEQ_SIG    0xf3def5e7      /* udf    #24035    ; 0x5de3 (ARMv6+) */
+#else
+#define RSEQ_SIG    0xe7f5def3      /* udf    #24035    ; 0x5de3 */
 #endif
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("dmb" ::: "memory", "cc")
@@ -125,8 +131,7 @@ do {									\
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
2.20.1



