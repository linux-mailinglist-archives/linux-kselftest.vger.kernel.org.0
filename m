Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F12E676
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Apr 2019 17:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfD2PaA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Apr 2019 11:30:00 -0400
Received: from mail.efficios.com ([167.114.142.138]:57094 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbfD2P3b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Apr 2019 11:29:31 -0400
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1F01D1C1D4A;
        Mon, 29 Apr 2019 11:29:30 -0400 (EDT)
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10032)
        with ESMTP id 0g6-ZTDFo15p; Mon, 29 Apr 2019 11:29:29 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
        by mail.efficios.com (Postfix) with ESMTP id 1C56B1C1D14;
        Mon, 29 Apr 2019 11:29:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 1C56B1C1D14
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1556551768;
        bh=nW4BGYiihytL59f9HWiNlAoKc8vsS6yIYb6E80hetmo=;
        h=From:To:Date:Message-Id;
        b=Y3yklawlSZbZYB3xJuRaKKuSFgQw1ObbOijJlsp2HyrcMLdR8AXqIM3b36CLl9gtI
         SpTPcvTXbKGWDwj4wVqq83+vQZiCfTOh958wEUPxDRAEkQyHHUZ/7RjBBH95PX74Nf
         eKRIZXywpDl5UdWGJOKF/nekVZiEOHb6BYHAWePR0EoVfxAZkQuE7DKjuGzq8569Ze
         wgzTYxe+D1khvc60k3moVag+V+JV2dTjlxZt8wH+jCQVSOG3R5RKErQ9b5g2T5ATBw
         CijPq8l125z98MUs/+EUrYL3aRXgoAkSdFIJXexicEqEpboAU0R8AQAeckMazMSLSt
         pacIlbWAm8sdg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([IPv6:::1])
        by localhost (mail02.efficios.com [IPv6:::1]) (amavisd-new, port 10026)
        with ESMTP id oHQ_3PqiPhQl; Mon, 29 Apr 2019 11:29:28 -0400 (EDT)
Received: from thinkos.internal.efficios.com (192-222-157-41.qc.cable.ebox.net [192.222.157.41])
        by mail.efficios.com (Postfix) with ESMTPSA id C73A51C1CF3;
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
Subject: [PATCH for 5.2 09/12] rseq/selftests: aarch64 code signature: handle big-endian environment
Date:   Mon, 29 Apr 2019 11:28:00 -0400
Message-Id: <20190429152803.7719-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
References: <20190429152803.7719-1-mathieu.desnoyers@efficios.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Handle compiling with -mbig-endian on aarch64, which generates binaries
with mixed code vs data endianness (little endian code, big endian
data).

Else mismatch between code endianness for the generated signatures and
data endianness for the RSEQ_SIG parameter passed to the rseq
registration will trigger application segmentation faults when the
kernel try to abort rseq critical sections.

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
---
 tools/testing/selftests/rseq/rseq-arm64.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index b41a2a48e965..200dae9e4208 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -6,7 +6,20 @@
  * (C) Copyright 2018 - Will Deacon <will.deacon@arm.com>
  */
 
-#define RSEQ_SIG	0xd428bc00	/* BRK #0x45E0 */
+/*
+ * aarch64 -mbig-endian generates mixed endianness code vs data:
+ * little-endian code and big-endian data. Ensure the RSEQ_SIG signature
+ * matches code endianness.
+ */
+#define RSEQ_SIG_CODE	0xd428bc00	/* BRK #0x45E0.  */
+
+#ifdef __AARCH64EB__
+#define RSEQ_SIG_DATA	0x00bc28d4	/* BRK #0x45E0.  */
+#else
+#define RSEQ_SIG_DATA	RSEQ_SIG_CODE
+#endif
+
+#define RSEQ_SIG	RSEQ_SIG_DATA
 
 #define rseq_smp_mb()	__asm__ __volatile__ ("dmb ish" ::: "memory")
 #define rseq_smp_rmb()	__asm__ __volatile__ ("dmb ishld" ::: "memory")
@@ -121,7 +134,7 @@ do {										\
 
 #define RSEQ_ASM_DEFINE_ABORT(label, abort_label)				\
 	"	b	222f\n"							\
-	"	.inst 	"	__rseq_str(RSEQ_SIG) "\n"			\
+	"	.inst 	"	__rseq_str(RSEQ_SIG_CODE) "\n"			\
 	__rseq_str(label) ":\n"							\
 	"	b	%l[" __rseq_str(abort_label) "]\n"			\
 	"222:\n"
-- 
2.11.0

