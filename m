Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28773498627
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Jan 2022 18:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbiAXROA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 12:14:00 -0500
Received: from mail.efficios.com ([167.114.26.124]:47926 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244272AbiAXRNR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 12:13:17 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 080D6344C62;
        Mon, 24 Jan 2022 12:13:15 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Ep_gnN7YNjQV; Mon, 24 Jan 2022 12:13:13 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id EFCC2345231;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com EFCC2345231
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643044386;
        bh=H+TwBg7+VZwc0Eb+ge/+rN4FKPnVqwOk5+Fw8kYkG2w=;
        h=From:To:Date:Message-Id;
        b=d/8I56Jb4JDFEWkMIAX+jOuVOiwo+7JrKXzS7rKnbNOqIP0HPspnfdTHNwOrM3rAD
         3pDmSbHYEt2fdAdMpv3ikPGlmAfgNo8fOdtZnb2mlKBJYpirt/sSbAGuFm9d5x8oj5
         CqqFXD4Ee0e9+h10f5yO/BnSiM6YZvAqiHRqiOdiC/AOYyEktXKKLFkpS0N3VDbv2x
         /xJUvLopIz96bmnVdxZSWd1ICPZxKb+GxuuEdwXFOxSjWKHlRFV5rJzIJ6vxR2kMcd
         VlSN6PrwYvc9+aWfZ+CXMzvu+HKzf7PFIYDNFEeeRnl05k26bpbvkTGEo/mjfrQxst
         XKz0fZaxKPw2g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id dfRUNhoZ3Y4U; Mon, 24 Jan 2022 12:13:05 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 1854D345052;
        Mon, 24 Jan 2022 12:13:05 -0500 (EST)
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
Subject: [RFC PATCH 13/15] selftests/rseq: Fix: work-around asm goto compiler bugs
Date:   Mon, 24 Jan 2022 12:12:51 -0500
Message-Id: <20220124171253.22072-14-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
References: <20220124171253.22072-1-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

gcc and clang each have their own compiler bugs with respect to asm
goto. Implement a work-around for compiler versions known to have those
bugs.

gcc prior to 4.8.2 miscompiles asm goto.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670

gcc prior to 8.1.0 miscompiles asm goto at O1.
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103908

clang prior to version 13.0.1 miscompiles asm goto at O2.
https://github.com/llvm/llvm-project/issues/52735

Work around these issues by adding a volatile inline asm with
memory clobber in the fallthrough after the asm goto and at each
label target.  Emit this for all compilers in case other similar
issues are found in the future.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 tools/testing/selftests/rseq/compiler.h   | 30 ++++++++++
 tools/testing/selftests/rseq/rseq-arm.h   | 39 +++++++++++++
 tools/testing/selftests/rseq/rseq-arm64.h | 45 +++++++++++++--
 tools/testing/selftests/rseq/rseq-ppc.h   | 39 +++++++++++++
 tools/testing/selftests/rseq/rseq-s390.h  | 29 ++++++++++
 tools/testing/selftests/rseq/rseq-x86.h   | 68 +++++++++++++++++++++++
 tools/testing/selftests/rseq/rseq.h       |  1 +
 7 files changed, 245 insertions(+), 6 deletions(-)
 create mode 100644 tools/testing/selftests/rseq/compiler.h

diff --git a/tools/testing/selftests/rseq/compiler.h b/tools/testing/selftests/rseq/compiler.h
new file mode 100644
index 000000000000..876eb6a7f75b
--- /dev/null
+++ b/tools/testing/selftests/rseq/compiler.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: LGPL-2.1-only OR MIT */
+/*
+ * rseq/compiler.h
+ *
+ * Work-around asm goto compiler bugs.
+ *
+ * (C) Copyright 2021 - Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
+ */
+
+#ifndef RSEQ_COMPILER_H
+#define RSEQ_COMPILER_H
+
+/*
+ * gcc prior to 4.8.2 miscompiles asm goto.
+ * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58670
+ *
+ * gcc prior to 8.1.0 miscompiles asm goto at O1.
+ * https://gcc.gnu.org/bugzilla/show_bug.cgi?id=103908
+ *
+ * clang prior to version 13.0.1 miscompiles asm goto at O2.
+ * https://github.com/llvm/llvm-project/issues/52735
+ *
+ * Work around these issues by adding a volatile inline asm with
+ * memory clobber in the fallthrough after the asm goto and at each
+ * label target.  Emit this for all compilers in case other similar
+ * issues are found in the future.
+ */
+#define rseq_after_asm_goto()	asm volatile ("" : : : "memory")
+
+#endif  /* RSEQ_COMPILER_H_ */
diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 64c3a622107b..893a11eca9d5 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -195,16 +195,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -263,16 +268,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -317,12 +327,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -384,16 +397,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -456,16 +474,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -532,18 +555,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -652,16 +681,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -771,16 +805,21 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 7806817062c2..cbe190a4d005 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -242,17 +242,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -300,16 +304,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -348,12 +357,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -402,17 +414,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -461,17 +477,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -522,19 +542,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -584,17 +609,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -644,17 +673,21 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
-
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index aa18c0eabf40..bab8e0b9fb11 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -254,16 +254,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -322,16 +327,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -378,12 +388,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -442,16 +455,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -512,16 +530,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -583,18 +606,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -659,16 +688,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -735,16 +769,21 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 0f523b3ecdef..4e6dc5f0cb42 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -178,16 +178,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -248,16 +253,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -301,12 +311,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -364,16 +377,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -443,18 +461,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -555,16 +579,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index e444563c6999..4ab2e74811ab 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -152,16 +152,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -220,16 +225,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -269,12 +279,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -387,16 +400,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -464,18 +482,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -574,16 +598,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -730,16 +759,21 @@ int rseq_cmpeqv_storev(intptr_t *v, intptr_t expect, intptr_t newv, int cpu)
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -798,16 +832,21 @@ int rseq_cmpnev_storeoffp_load(intptr_t *v, intptr_t expectnot,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -847,12 +886,15 @@ int rseq_addv(intptr_t *v, intptr_t count, int cpu)
 		  , error1
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 #endif
 }
@@ -909,16 +951,21 @@ int rseq_cmpeqv_trystorev_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -977,16 +1024,21 @@ int rseq_cmpeqv_trystorev_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 
@@ -1047,18 +1099,24 @@ int rseq_cmpeqv_cmpeqv_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2, error3
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("1st expected value comparison failed");
 error3:
+	rseq_after_asm_goto();
 	rseq_bug("2nd expected value comparison failed");
 #endif
 }
@@ -1161,16 +1219,21 @@ int rseq_cmpeqv_trymemcpy_storev(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
@@ -1274,16 +1337,21 @@ int rseq_cmpeqv_trymemcpy_storev_release(intptr_t *v, intptr_t expect,
 		  , error1, error2
 #endif
 	);
+	rseq_after_asm_goto();
 	return 0;
 abort:
+	rseq_after_asm_goto();
 	RSEQ_INJECT_FAILED
 	return -1;
 cmpfail:
+	rseq_after_asm_goto();
 	return 1;
 #ifdef RSEQ_COMPARE_TWICE
 error1:
+	rseq_after_asm_goto();
 	rseq_bug("cpu_id comparison failed");
 error2:
+	rseq_after_asm_goto();
 	rseq_bug("expected value comparison failed");
 #endif
 }
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index 17531ccd3090..6bd0ac466b4a 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -17,6 +17,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include "rseq-abi.h"
+#include "compiler.h"
 
 /*
  * Empty code injection macros, override when testing.
-- 
2.17.1

