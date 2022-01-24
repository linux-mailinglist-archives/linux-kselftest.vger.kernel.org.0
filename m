Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0447498613
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbiAXRNm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:13:42 -0500
Received: from mail.efficios.com ([167.114.26.124]:47780 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244245AbiAXRNL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:11 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2AF29344EE1;
        Mon, 24 Jan 2022 12:13:11 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1_peO4x6M9WR; Mon, 24 Jan 2022 12:13:10 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 77F3C344E69;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 77F3C344E69
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044385;
        bh=RtUHMShSGmFf9BXN09i3lYBUc9GihuU3n2dEieVQtm0=;
        h=From:To:Date:Message-Id;
        b=lj0XmswSxENwjMCXSIK0PbCocpNsxYVv6mI4ccPntQhkYQtzky/GdBCTqNQpxpFlf
         GCyCghX/mWs4GCqV6kXLrEjDf4/q8sxujk5Ij0KUVe3f7m3in2fMKNw1Jidogcm+Wn
         n50x0vhfnaqfMnMhbz/ZAS5cRIiXQFoU3qWSnMk3r6SoqQ8lbLUfiYAp25zeAD/GIN
         527lfvfwj4WOvy1BKrScuYf1VuFuNG/UaYm9HsuYDQJx4NdIJoqC8lNZb+yBrLGpLK
         PopcvtuTJxxctjp1YUd0qxLn8WW9w2fcwH/uaTSDurVuuPxuBSeIEOPtN7UOUnpPyr
         2Ivv+16sSTalA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EjBn30sNfs3c; Mon, 24 Jan 2022 12:13:05 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 2AE92345111;
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
Subject: [RFC PATCH 09/15] selftests/rseq: Fix ppc32 missing instruction selection "u" and "x" for load/store
Date:   Mon, 24 Jan 2022 12:12:47 -0500
Message-Id: <20220124171253.22072-10-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Building the rseq basic test  with
gcc version 5.4.0 20160609 (Ubuntu 5.4.0-6ubuntu1~16.04.12)
Target: powerpc-linux-gnu

leads to these errors:

/tmp/ccieEWxU.s: Assembler messages:
/tmp/ccieEWxU.s:118: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:118: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:121: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:121: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:626: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:626: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:629: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:629: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:735: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:735: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:738: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:738: Error: junk at end of line: `,8'
/tmp/ccieEWxU.s:741: Error: syntax error; found `,', expected `('
/tmp/ccieEWxU.s:741: Error: junk at end of line: `,8'
Makefile:581: recipe for target 'basic_percpu_ops_test.o' failed

Based on discussion with Linux powerpc maintainers and review of
the use of the "m" operand in powerpc kernel code, add the missing
%Un%Xn (where n is operand number) to the lwz, stw, ld, and std
instructions when used with "m" operands.

Using "WORD" to mean either a 32-bit or 64-bit type depending on
the architecture is misleading. The term "WORD" really means a
32-bit type in both 32-bit and 64-bit powerpc assembler. The intent
here is to wrap load/store to intptr_t into common macros for both
32-bit and 64-bit.

Rename the macros with a RSEQ_ prefix, and use the terms "INT"
for always 32-bit type, and "LONG" for architecture bitness-sized
type.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/rseq-ppc.h | 55 +++++++++++++------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index c4ba1375285d..87befda47ba4 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -47,10 +47,13 @@ do {									\
 
 #ifdef __PPC64__
 
-#define STORE_WORD	"std "
-#define LOAD_WORD	"ld "
-#define LOADX_WORD	"ldx "
-#define CMP_WORD	"cmpd "
+#define RSEQ_STORE_LONG(arg)	"std%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_STORE_INT(arg)	"stw%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_LOAD_LONG(arg)	"ld%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOAD_INT(arg)	"lwz%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOADX_LONG		"ldx "							/* From base register ("b" constraint) */
+#define RSEQ_CMP_LONG		"cmpd "
+#define RSEQ_CMP_LONG_INT	"cmpdi "
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
 			start_ip, post_commit_offset, abort_ip)			\
@@ -89,10 +92,13 @@ do {									\
 
 #else /* #ifdef __PPC64__ */
 
-#define STORE_WORD	"stw "
-#define LOAD_WORD	"lwz "
-#define LOADX_WORD	"lwzx "
-#define CMP_WORD	"cmpw "
+#define RSEQ_STORE_LONG(arg)	"stw%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* To memory ("m" constraint) */
+#define RSEQ_STORE_INT(arg)	RSEQ_STORE_LONG(arg)					/* To memory ("m" constraint) */
+#define RSEQ_LOAD_LONG(arg)	"lwz%U[" __rseq_str(arg) "]%X[" __rseq_str(arg) "] "	/* From memory ("m" constraint) */
+#define RSEQ_LOAD_INT(arg)	RSEQ_LOAD_LONG(arg)					/* From memory ("m" constraint) */
+#define RSEQ_LOADX_LONG		"lwzx "							/* From base register ("b" constraint) */
+#define RSEQ_CMP_LONG		"cmpw "
+#define RSEQ_CMP_LONG_INT	"cmpwi "
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,				\
 			start_ip, post_commit_offset, abort_ip)			\
@@ -125,7 +131,7 @@ do {									\
 		RSEQ_INJECT_ASM(1)						\
 		"lis %%r17, (" __rseq_str(cs_label) ")@ha\n\t"			\
 		"addi %%r17, %%r17, (" __rseq_str(cs_label) ")@l\n\t"		\
-		"stw %%r17, %[" __rseq_str(rseq_cs) "]\n\t"			\
+		RSEQ_STORE_INT(rseq_cs) "%%r17, %[" __rseq_str(rseq_cs) "]\n\t"	\
 		__rseq_str(label) ":\n\t"
 
 #endif /* #ifdef __PPC64__ */
@@ -136,7 +142,7 @@ do {									\
 
 #define RSEQ_ASM_CMP_CPU_ID(cpu_id, current_cpu_id, label)			\
 		RSEQ_INJECT_ASM(2)						\
-		"lwz %%r17, %[" __rseq_str(current_cpu_id) "]\n\t"		\
+		RSEQ_LOAD_INT(current_cpu_id) "%%r17, %[" __rseq_str(current_cpu_id) "]\n\t" \
 		"cmpw cr7, %[" __rseq_str(cpu_id) "], %%r17\n\t"		\
 		"bne- cr7, " __rseq_str(label) "\n\t"
 
@@ -153,25 +159,25 @@ do {									\
  * 	RSEQ_ASM_OP_* (else): doesn't have hard-code registers(unless cr7)
  */
 #define RSEQ_ASM_OP_CMPEQ(var, expect, label)					\
-		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
-		CMP_WORD "cr7, %%r17, %[" __rseq_str(expect) "]\n\t"		\
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"		\
+		RSEQ_CMP_LONG "cr7, %%r17, %[" __rseq_str(expect) "]\n\t"		\
 		"bne- cr7, " __rseq_str(label) "\n\t"
 
 #define RSEQ_ASM_OP_CMPNE(var, expectnot, label)				\
-		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
-		CMP_WORD "cr7, %%r17, %[" __rseq_str(expectnot) "]\n\t"		\
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"		\
+		RSEQ_CMP_LONG "cr7, %%r17, %[" __rseq_str(expectnot) "]\n\t"		\
 		"beq- cr7, " __rseq_str(label) "\n\t"
 
 #define RSEQ_ASM_OP_STORE(value, var)						\
-		STORE_WORD "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t"
+		RSEQ_STORE_LONG(var) "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t"
 
 /* Load @var to r17 */
 #define RSEQ_ASM_OP_R_LOAD(var)							\
-		LOAD_WORD "%%r17, %[" __rseq_str(var) "]\n\t"
+		RSEQ_LOAD_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"
 
 /* Store r17 to @var */
 #define RSEQ_ASM_OP_R_STORE(var)						\
-		STORE_WORD "%%r17, %[" __rseq_str(var) "]\n\t"
+		RSEQ_STORE_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"
 
 /* Add @count to r17 */
 #define RSEQ_ASM_OP_R_ADD(count)						\
@@ -179,11 +185,11 @@ do {									\
 
 /* Load (r17 + voffp) to r17 */
 #define RSEQ_ASM_OP_R_LOADX(voffp)						\
-		LOADX_WORD "%%r17, %[" __rseq_str(voffp) "], %%r17\n\t"
+		RSEQ_LOADX_LONG "%%r17, %[" __rseq_str(voffp) "], %%r17\n\t"
 
 /* TODO: implement a faster memcpy. */
 #define RSEQ_ASM_OP_R_MEMCPY() \
-		"cmpdi %%r19, 0\n\t" \
+		RSEQ_CMP_LONG_INT "%%r19, 0\n\t" \
 		"beq 333f\n\t" \
 		"addi %%r20, %%r20, -1\n\t" \
 		"addi %%r21, %%r21, -1\n\t" \
@@ -191,16 +197,16 @@ do {									\
 		"lbzu %%r18, 1(%%r20)\n\t" \
 		"stbu %%r18, 1(%%r21)\n\t" \
 		"addi %%r19, %%r19, -1\n\t" \
-		"cmpdi %%r19, 0\n\t" \
+		RSEQ_CMP_LONG_INT "%%r19, 0\n\t" \
 		"bne 222b\n\t" \
 		"333:\n\t" \
 
 #define RSEQ_ASM_OP_R_FINAL_STORE(var, post_commit_label)			\
-		STORE_WORD "%%r17, %[" __rseq_str(var) "]\n\t"			\
+		RSEQ_STORE_LONG(var) "%%r17, %[" __rseq_str(var) "]\n\t"			\
 		__rseq_str(post_commit_label) ":\n\t"
 
 #define RSEQ_ASM_OP_FINAL_STORE(value, var, post_commit_label)			\
-		STORE_WORD "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t" \
+		RSEQ_STORE_LONG(var) "%[" __rseq_str(value) "], %[" __rseq_str(var) "]\n\t" \
 		__rseq_str(post_commit_label) ":\n\t"
 
 static inline __attribute__((always_inline))
@@ -743,9 +749,4 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 #endif
 }
 
-#undef STORE_WORD
-#undef LOAD_WORD
-#undef LOADX_WORD
-#undef CMP_WORD
-
 #endif /* !RSEQ_SKIP_FASTPATH */
-- 
2.17.1

