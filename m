Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6650DE682
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 17:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbfD2PaW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 11:30:22 -0400
Received: from mail.efficios.com ([167.114.142.138]:56924 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728672AbfD2P31 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 11:29:27 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id B80931C1CE7;
        Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 2gPY819J-axm; Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 511631C1CDC;
        Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 511631C1CDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551765;
        bh=ywHZBM285Oi7ZNY1INp8Fr4OzMaiucwZoNO/gC6Rwc8=;
        h=From:To:Date:Message-Id;
        b=cFDn/eIovgRc3tS5s+n5klc3EYh/x2iot7j09siSgkU1bHG39u1Q4b6f6HHS77dWC
         fXm6aUrBmqBtwdmw7yu+FAayOxJnnck7EjyMnUd80O1fFSbSEdgcwvEPJ8iG147wqf
         4OuL2NppXePrK87yRQ3zOIYGDFvV36kOBFD74LD8PBakVUk7pVg07zOR9bwl5nMjHI
         cB/l2cBax4ajTRSGrNyQoGPl4GILFDvfOXil9fAYd8wZo7tczC/cbUK8b7tUNTesuN
         hvsjLU8kb2nmkP/eEuvvv+mOMIcF5vrHhZgvUY+VTAujx4FMmvZ3r4fePFATvuleRb
         vOIiKtLW630gQ==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id ZjrLtblpKBDb; Mon, 29 Apr 2019 11:29:25 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id 62D531C1CC5;
        Mon, 29 Apr 2019 11:29:24 -0400 (EDT)
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
Subject: [PATCH for 5.2 05/12] rseq/selftests: s390: use jg instruction for jumps outside of the asm
Date:   Mon, 29 Apr 2019 11:27:56 -0400
Message-Id: <20190429152803.7719-6-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The branch target range of the "j" instruction is 64K, which is not
enough for the general case.

Suggested-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
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
 tools/testing/selftests/rseq/rseq-s390.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index fbb97815d71c..7c4f3a70b6c7 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -117,14 +117,14 @@ do {									\
 		".long " __rseq_str(RSEQ_SIG) "\n\t"			\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
-		"j %l[" __rseq_str(abort_label) "]\n\t"			\
+		"jg %l[" __rseq_str(abort_label) "]\n\t"		\
 		".popsection\n\t"
 
 #define RSEQ_ASM_DEFINE_CMPFAIL(label, teardown, cmpfail_label)		\
 		".pushsection __rseq_failure, \"ax\"\n\t"		\
 		__rseq_str(label) ":\n\t"				\
 		teardown						\
-		"j %l[" __rseq_str(cmpfail_label) "]\n\t"		\
+		"jg %l[" __rseq_str(cmpfail_label) "]\n\t"		\
 		".popsection\n\t"
 
 static inline __attribute__((always_inline))
-- 
2.11.0

