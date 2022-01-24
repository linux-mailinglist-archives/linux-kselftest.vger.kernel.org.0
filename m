Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E811E49861C
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244247AbiAXRNs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:48 -0500
Received: from mail.efficios.com ([167.114.26.124]:47802 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244246AbiAXRNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 587FB34505E;
        Mon, 24 Jan 2022 12:13:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id DwxKvkw3Jz5v; Mon, 24 Jan 2022 12:13:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id A0D95344FB3;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com A0D95344FB3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044385;
        bh=OuVVpgVcaTvkBsmmH+pl9+TR2bo31cIUaQhlOs7ALyo=;
        h=From:To:Date:Message-Id;
        b=RthDqMiXC1YOA0Eir6sHOy4JKEWmNSDECqp1jVikwaW4SPfALO3MNbG5HGiMwuguO
         7yuPDMaZR7OM+eKM1KGQHun/Kb/TfQjKubvQTJPgCWgN6HsZlWPTwUjvBWizagLzCB
         8dgj67oLukhA1qZtaYUqxAIkWHYi1ETuQAYpwK9mn8X3aUL4RgCOeWrcGhlFJobKde
         u0RBLCbcuuZ0mGU5gI2bz+FSaqvQ37BhDvmaGbytekeglsTB+fe9PHjq/vRWeeQie2
         LcK3itnEMM7pd5XY52nU3N1NYZ7zCbjct+DdBRMKZMdP//jbEeU/dX5FGuEwTD6LxZ
         J/47RXxMPvi1g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q6-C3dk3igRW; Mon, 24 Jan 2022 12:13:05 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 9D6B3344E62;
        Mon, 24 Jan 2022 12:13:04 -0500 (EST)
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
Subject: [RFC PATCH 11/15] selftests/rseq: Fix warnings about #if checks of undefined tokens
Date:   Mon, 24 Jan 2022 12:12:49 -0500
Message-Id: <20220124171253.22072-12-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/param_test.c | 2 +-
 tools/testing/selftests/rseq/rseq-x86.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index 335c290b39e7..da23c22d5882 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -161,7 +161,7 @@ unsigned int yield_mod_cnt, nr_abort;
 	"	cbnz	" INJECT_ASM_REG ", 222b\n"			\
 	"333:\n"
 
-#elif __PPC__
+#elif defined(__PPC__)
 
 #define RSEQ_INJECT_INPUT \
 	, [loop_cnt_1]"m"(loop_cnt[1]) \
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 0ee6c041d4be..e444563c6999 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -600,7 +600,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 #endif /* !RSEQ_SKIP_FASTPATH */
 
-#elif __i386__
+#elif defined(__i386__)
 
 #define rseq_smp_mb()	\
 	__asm__ __volatile__ ("lock; addl $0,-128(%%esp)" ::: "memory", "cc")
-- 
2.17.1

