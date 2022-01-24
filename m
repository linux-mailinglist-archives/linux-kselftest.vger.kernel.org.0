Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8967498610
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244235AbiAXRNl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:41 -0500
Received: from mail.efficios.com ([167.114.26.124]:47818 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244248AbiAXRNM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:12 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8BFCF345199;
        Mon, 24 Jan 2022 12:13:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zb7k1dT-3TH1; Mon, 24 Jan 2022 12:13:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 77E42345059;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 77E42345059
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044385;
        bh=G0tWQ7Ot+jRNS69Wi8kPuuBpjKSPM+6/3Cceh+reZcc=;
        h=From:To:Date:Message-Id;
        b=BXze5+HRNnQ6o+E6dWBnBsWlOgW6HowmSnxJWd8CK0YYVCgMlXtstC+38N9SdIbnz
         aNw9tS9L9KPtMn+MypU3eV4CLZ0MTMBdHJ5UiuqbQ3fMm9Aq0qCygRrplUnrNoDAJ8
         E3rqx66fSs6saAbmmi4Xb9TazfxYNgaYwub6pCxDL/XVwF6cqLfqMYdGw8J/AElYKS
         SU6BF3pZeAVyNg//8Rtw1mem1frjaZLctQ+R6ywXAiqgpks0m5HbCo7L+Jl1RMhbCM
         kOoJ6TlrZ4I9U7tst+zJzLuVxtvbce+R643Ux6krGUXDbL+OmuMKFdYgP8f+TH/Xpa
         bix3JaeXL3FRA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 7UGw_FGyl9q3; Mon, 24 Jan 2022 12:13:05 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id E09CF3450BD;
        Mon, 24 Jan 2022 12:13:03 -0500 (EST)
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
Subject: [RFC PATCH 08/15] selftests/rseq: Fix ppc32: wrong rseq_cs 32-bit field pointer on big endian
Date:   Mon, 24 Jan 2022 12:12:46 -0500
Message-Id: <20220124171253.22072-9-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

ppc32 incorrectly uses padding as rseq_cs pointer field. Fix this by
using the rseq_cs.arch.ptr field.

Use this field across all architectures.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-arm.h   | 16 ++++++++--------
 tools/testing/selftests/rseq/rseq-arm64.h | 16 ++++++++--------
 tools/testing/selftests/rseq/rseq-mips.h  | 16 ++++++++--------
 tools/testing/selftests/rseq/rseq-ppc.h   | 16 ++++++++--------
 tools/testing/selftests/rseq/rseq-s390.h  | 12 ++++++------
 5 files changed, 38 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 6716540e17c6..5f567b3b40f2 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -186,7 +186,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -256,7 +256,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -317,7 +317,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [count]		"Ir" (count)
 		  RSEQ_INJECT_INPUT
@@ -382,7 +382,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -458,7 +458,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -538,7 +538,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -658,7 +658,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -783,7 +783,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index b9d9b3aa6e9b..d0f2b7feee94 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -231,7 +231,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"Qo" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -288,7 +288,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"Qo" (*v),
 		  [expectnot]		"r" (expectnot),
 		  [load]		"Qo" (*load),
@@ -338,7 +338,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"Qo" (*v),
 		  [count]		"r" (count)
 		  RSEQ_INJECT_INPUT
@@ -389,7 +389,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -448,7 +448,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -509,7 +509,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"Qo" (*v),
 		  [expect]		"r" (expect),
 		  [v2]			"Qo" (*v2),
@@ -570,7 +570,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
@@ -630,7 +630,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"Qo" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [expect]		"r" (expect),
 		  [v]			"Qo" (*v),
 		  [newv]		"r" (newv),
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 2b1f5bd95268..6df54273825d 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -191,7 +191,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -259,7 +259,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -320,7 +320,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [count]		"Ir" (count)
 		  RSEQ_INJECT_INPUT
@@ -383,7 +383,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -457,7 +457,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -533,7 +533,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -650,7 +650,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -772,7 +772,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index 2e6b7572ba08..c4ba1375285d 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -236,7 +236,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -302,7 +302,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -360,7 +360,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"r" (count)
@@ -420,7 +420,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -490,7 +490,7 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -561,7 +561,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -636,7 +636,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
@@ -712,7 +712,7 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index b906e044d2a3..9927021f8bd0 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -166,7 +166,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
 		  [newv]		"r" (newv)
@@ -234,7 +234,7 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expectnot]		"r" (expectnot),
@@ -289,7 +289,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [count]		"r" (count)
@@ -348,7 +348,7 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* try store input */
 		  [v2]			"m" (*v2),
 		  [newv2]		"r" (newv2),
@@ -427,7 +427,7 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* cmp2 input */
 		  [v2]			"m" (*v2),
 		  [expect2]		"r" (expect2),
@@ -535,7 +535,7 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		: /* gcc asm goto does not allow outputs */
 		: [cpu_id]		"r" (cpu),
 		  [current_cpu_id]	"m" (rseq_get_abi()->cpu_id),
-		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs),
+		  [rseq_cs]		"m" (rseq_get_abi()->rseq_cs.arch.ptr),
 		  /* final store input */
 		  [v]			"m" (*v),
 		  [expect]		"r" (expect),
-- 
2.17.1

