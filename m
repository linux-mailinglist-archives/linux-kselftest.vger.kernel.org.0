Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4862498619
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244370AbiAXRNr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:47 -0500
Received: from mail.efficios.com ([167.114.26.124]:47896 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244266AbiAXRNQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:16 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 83F34344DFC;
        Mon, 24 Jan 2022 12:13:12 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 0HAL0kDLc4ns; Mon, 24 Jan 2022 12:13:11 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id BFAE5344E6A;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com BFAE5344E6A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044385;
        bh=MqSQzh4Cn93iCnZ83/QdcxjSH8xBvJ34aZMuwAMYN68=;
        h=From:To:Date:Message-Id;
        b=NxmrpCwwhhfmR+IoERZqK7b+ZA8iGWXCJTMLxaMofdT3kxw2BRJEN73dp2EYfNXVt
         E0amu4X9LqBbYZtm5YO/STt6YtU3IjxMRcaYmqgwP4HorDhtkaYQ9NCNRvEtDdrc7D
         zXc+7O+kQuDAWc7QY18McGXSkwxDeWbAKeXqPA3CedEamAflF/2kzx+4U0eAtTkmbn
         GYSqUJD6PEbkhoZkkObBW1os4EMc/WEkDICYFwj62WRjuuBZhdnt+B5GzNKQeXfj91
         Wi7+DSK9Wbdr65xXJetXyb+DsT/6qxKhsuqtQGuQRVxZ0QSQo1/YPhkJE1XjLN1Z3l
         GW5RS+WKLp7+A==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S_9ZR7VkxflI; Mon, 24 Jan 2022 12:13:05 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id D72D1344ED8;
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
Subject: [RFC PATCH 12/15] selftests/rseq: Remove arm/mips asm goto compiler work-around
Date:   Mon, 24 Jan 2022 12:12:50 -0500
Message-Id: <20220124171253.22072-13-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The arm and mips work-around for asm goto size guess issues are not
properly documented, and lack reference to specific compiler versions,
upstream compiler bug tracker entry, and reproducer.

I can only find a loosely documented patch in my original LKML rseq post
refering to gcc < 7 on ARM, but it does not appear to be sufficient to
track the exact issue. Also, I am not sure MIPS really has the same
limitation.

Therefore, remove the work-around until we can properly document this.

Link: https://lore.kernel.org/lkml/20171121141900.18471-17-mathieu.desnoyers@efficios.com/
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-arm.h  | 37 ------------------------
 tools/testing/selftests/rseq/rseq-mips.h | 37 ------------------------
 2 files changed, 74 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index ae476af70152..64c3a622107b 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -147,14 +147,11 @@ do {									\
 		teardown						\
 		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
 
-#define rseq_workaround_gcc_asm_size_guess()	__asm__ __volatile__("")
-
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -198,14 +195,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -221,7 +215,6 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -270,14 +263,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -292,7 +282,6 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 #ifdef RSEQ_COMPARE_TWICE
@@ -328,10 +317,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
@@ -347,7 +334,6 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -398,14 +384,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -422,7 +405,6 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -474,14 +456,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -498,7 +477,6 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -554,14 +532,11 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -582,7 +557,6 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -678,21 +652,16 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("cpu_id comparison failed");
 error2:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -706,7 +675,6 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -803,21 +771,16 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("cpu_id comparison failed");
 error2:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 0d1d9255da70..878739fae2fd 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -154,14 +154,11 @@ do {									\
 		teardown \
 		"b %l[" __rseq_str(cmpfail_label) "]\n\t"
 
-#define rseq_workaround_gcc_asm_size_guess()	__asm__ __volatile__("")
-
 static inline __attribute__((always_inline))
 int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -203,14 +200,11 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -226,7 +220,6 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -273,14 +266,11 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -295,7 +285,6 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 #ifdef RSEQ_COMPARE_TWICE
@@ -331,10 +320,8 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
@@ -350,7 +337,6 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -399,14 +385,11 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -423,7 +406,6 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -473,14 +455,11 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -497,7 +476,6 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 {
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -549,14 +527,11 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
@@ -577,7 +552,6 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -670,21 +644,16 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("cpu_id comparison failed");
 error2:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -698,7 +667,6 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 
 	RSEQ_INJECT_C(9)
 
-	rseq_workaround_gcc_asm_size_guess();
 	__asm__ __volatile__ goto (
 		RSEQ_ASM_DEFINE_TABLE(9, 1f, 2f, 4f) /* start, commit, abort */
 		RSEQ_ASM_DEFINE_EXIT_POINT(1f, %l[cmpfail])
@@ -792,21 +760,16 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-	rseq_workaround_gcc_asm_size_guess();
 	return 0;
 abort:
-	rseq_workaround_gcc_asm_size_guess();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
-	rseq_workaround_gcc_asm_size_guess();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("cpu_id comparison failed");
 error2:
-	rseq_workaround_gcc_asm_size_guess();
 	rseq_bug("expected value comparison failed");
 #endif
 }
-- 
2.17.1

