Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDBB498616
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244228AbiAXRNn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:43 -0500
Received: from mail.efficios.com ([167.114.26.124]:47898 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244267AbiAXRNQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BCA89344F73;
        Mon, 24 Jan 2022 12:13:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hpQWMLEKRn2h; Mon, 24 Jan 2022 12:13:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 990E9344ED9;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 990E9344ED9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044385;
        bh=/ZsWmTmMYNDNZVhzLvh2ZqCMKeo8IkeDQhzzyo4aFbo=;
        h=From:To:Date:Message-Id;
        b=pq91ab2rWKkmweqs7QSwE1iZwGxJ6FeTit7exR/JZ+xH/oFNOMxtAeYNw+dwgvIqK
         Di0tWGI3xLLs+yXG9waKHMZCNJfGAZ5oB6J7ltH5C6FMcFLxbmGVO27mx3lbqlFZs8
         zVO3IMucuvOrNm3nXbzKqFsF/cvt0Lp+XzECGWDiojACNlHGIxQRkpgVcHgjOVovn3
         m8TNezoXvXGKaZAeammg7IuA/0vZDDidD6eGijK4dn4NWGyJTixNGgGYCHeLbyHMM7
         waNoOidW2qLUVTrWxe4ndmrMPPTtXljgQ11ct3vUDIHBnmjGVtgol/YKCw5yZ9tFAp
         Nrg9Zg35xdbTA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id BT6zyraXZXYk; Mon, 24 Jan 2022 12:13:05 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 659F6344DF9;
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
Subject: [RFC PATCH 10/15] selftests/rseq: Fix ppc32 offsets by using long rather than off_t
Date:   Mon, 24 Jan 2022 12:12:48 -0500
Message-Id: <20220124171253.22072-11-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The semantic of off_t is for file offsets. We mean to use it as an
offset from a pointer. We really expect it to fit in a single register,
and not use a 64-bit type on 32-bit architectures.

Fix runtime issues on ppc32 where the offset is always 0 due to
inconsistency between the argument type (off_t -> 64-bit) and type
expected by the inline assembler (32-bit).

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/basic_percpu_ops_test.c | 2 +-
 tools/testing/selftests/rseq/param_test.c            | 2 +-
 tools/testing/selftests/rseq/rseq-arm.h              | 2 +-
 tools/testing/selftests/rseq/rseq-arm64.h            | 2 +-
 tools/testing/selftests/rseq/rseq-mips.h             | 2 +-
 tools/testing/selftests/rseq/rseq-ppc.h              | 2 +-
 tools/testing/selftests/rseq/rseq-s390.h             | 2 +-
 tools/testing/selftests/rseq/rseq-skip.h             | 2 +-
 tools/testing/selftests/rseq/rseq-x86.h              | 6 +++---
 9 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/rseq/basic_percpu_ops_test.c b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
index b953a52ff706..517756afc2a4 100644
--- a/tools/testing/selftests/rseq/basic_percpu_ops_test.c
+++ b/tools/testing/selftests/rseq/basic_percpu_ops_test.c
@@ -167,7 +167,7 @@ struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
 	for (;;) {
 		struct percpu_list_node *head;
 		intptr_t *targetptr, expectnot, *load;
-		off_t offset;
+		long offset;
 		int ret, cpu;
 
 		cpu = rseq_cpu_start();
diff --git a/tools/testing/selftests/rseq/param_test.c b/tools/testing/selftests/rseq/param_test.c
index cc2cfc1da938..335c290b39e7 100644
--- a/tools/testing/selftests/rseq/param_test.c
+++ b/tools/testing/selftests/rseq/param_test.c
@@ -549,7 +549,7 @@ struct percpu_list_node *this_cpu_list_pop(struct percpu_list *list,
 	for (;;) {
 		struct percpu_list_node *head;
 		intptr_t *targetptr, expectnot, *load;
-		off_t offset;
+		long offset;
 		int ret;
 
 		cpu = rseq_cpu_start();
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 5f567b3b40f2..ae476af70152 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -217,7 +217,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index d0f2b7feee94..7806817062c2 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -259,7 +259,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 6df54273825d..0d1d9255da70 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -222,7 +222,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index 87befda47ba4..aa18c0eabf40 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -270,7 +270,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 9927021f8bd0..0f523b3ecdef 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -198,7 +198,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
  */
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
diff --git a/tools/testing/selftests/rseq/rseq-skip.h b/tools/testing/selftests/rseq/rseq-skip.h
index 72750b5905a9..7b53dac1fcdd 100644
--- a/tools/testing/selftests/rseq/rseq-skip.h
+++ b/tools/testing/selftests/rseq/rseq-skip.h
@@ -13,7 +13,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	return -1;
 }
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index 1d9fa0516e53..0ee6c041d4be 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -172,7 +172,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
  */
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
@@ -286,7 +286,7 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
  *  *pval += inc;
  */
 static inline __attribute__((always_inline))
-int rseq_offset_deref_addv(intptr_t *ptr, off_t off, intptr_t inc, int cpu)
+int rseq_offset_deref_addv(intptr_t *ptr, long off, intptr_t inc, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
@@ -750,7 +750,7 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
  */
 static inline __attribute__((always_inline))
 int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
-			       off_t voffp, intptr_t *load, int cpu)
+			       long voffp, intptr_t *load, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-- 
2.17.1

