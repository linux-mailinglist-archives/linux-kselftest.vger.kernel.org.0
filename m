Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59DCDE67C
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 17:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728549AbfD2PaM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 11:30:12 -0400
Received: from mail.efficios.com ([167.114.142.138]:56924 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbfD2P33 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 11:29:29 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 0757E1C1D0A;
        Mon, 29 Apr 2019 11:29:28 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id S035iER66EGa; Mon, 29 Apr 2019 11:29:27 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 4350A1C1CF9;
        Mon, 29 Apr 2019 11:29:27 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 4350A1C1CF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551767;
        bh=jy4yDKrc4yriyy49NKNbIGeaZKEJiVoy7GIQXjy8eHI=;
        h=From:To:Date:Message-Id;
        b=IqcNxVj5SMIS/lcqYa2p35vuIYHO9Hrsr2r3ebI4sV+I7kWUHuQ7flOhkhT9ErcW6
         9nXSTvCAcY+lVu29tE1G1ceEqhzuPlzLWAhfr3mx5gB2FnOrfz3s5uMbNpMTVej5jy
         2gtsUOU+1MuOxpt1YIAq8ZoNC6dnruNnsiCSE1cE84Feb94fes/nrpaUvpJfWm1h8L
         rhUrLfLqG70AMw9SpRSQag4vXIwXD7pavQPkLtd2jE4xU1VtAtJ+wXiwHXQFsa1mP9
         Wf3yI5C+qrTcnO7DgPxuE5GIdZadlqLgtgNx6Wut+NJAyfsTRy7GD2H1HUo5l3KSah
         YN7X4MEw2nuCQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id bS8psTWBszyc; Mon, 29 Apr 2019 11:29:27 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 0F8961C1CC8;
        Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
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
Subject: [PATCH for 5.2 06/12] rseq/selftests: x86: use ud1 instruction as RSEQ_SIG opcode
Date:   Mon, 29 Apr 2019 11:27:57 -0400
Message-Id: <20190429152803.7719-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use ud1 as the guard instruction for the restartable sequence abort
handler. Its benefit compared to nopl is to trap execution if the
program ends up trying to execute it by mistake, which makes debugging
easier.

The 4-byte signature per se is unchanged (it is the instruction
operand). Only the opcode is changed from nopl to ud1.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
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
 tools/testing/selftests/rseq/rseq-x86.h | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 03095236f6fa..b2da6004fe30 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -7,6 +7,13 @@
 
 #include <stdint.h>
 
+/*
+ * RSEQ_SIG is used with the following reserved undefined instructions, which
+ * trap in user-space:
+ *
+ * x86-32:    0f b9 3d 53 30 05 53      ud1    0x53053053,%edi
+ * x86-64:    0f b9 3d 53 30 05 53      ud1    0x53053053(%rip),%edi
+ */
 #define RSEQ_SIG	0x53053053
 
 /*
@@ -88,8 +95,8 @@ do {									\
 
 #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
 		".pushsection __rseq_failure, \"ax\"\n\t"		\
-		/* Disassembler-friendly signature: nopl <sig>(%rip). */\
-		".byte 0x0f, 0x1f, 0x05\n\t"				\
+		/* Disassembler-friendly signature: ud1 <sig>(%rip),%edi. */ \
+		".byte 0x0f, 0xb9, 0x3d\n\t"				\
 		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
@@ -609,8 +616,8 @@ do {									\
 
 #define RSEQ_ASM_DEFINE_ABORT(label, teardown, abort_label)		\
 		".pushsection __rseq_failure, \"ax\"\n\t"		\
-		/* Disassembler-friendly signature: nopl <sig>. */	\
-		".byte 0x0f, 0x1f, 0x05\n\t"				\
+		/* Disassembler-friendly signature: ud1 <sig>,%edi. */	\
+		".byte 0x0f, 0xb9, 0x3d\n\t"				\
 		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
-- 
2.11.0

