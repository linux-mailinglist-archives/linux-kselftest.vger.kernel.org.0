Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2284A702EE7
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 May 2023 15:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbjEON6P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 May 2023 09:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbjEON6N (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 May 2023 09:58:13 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B15AA10F3;
        Mon, 15 May 2023 06:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1684159090;
        bh=sUuJuaMEmAlyyRMOf/8VHfapTZrVaMFeI2CoS0ABZ7s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OLGh+GAmojuyW9nF5IZa1yyHZguiFtCo48Dr4T78gRkjmCD2LtK36gXCWFsgzVmqr
         AigmiKda9NxWxPjvZQIHO2s6Xa8wUrjPNOdxsTUvGbku5uABfZMfpktJQx2Upe4jRz
         OHv9qTlMt10FM3dGaLKsbhHMl2AOKp1bePfdXbB/YyDdwGsRgjakA1JgYV2HVvBFfV
         tyGhRW2xQ+DM5lhFcqh5c7OoWQiSGrlHJoIB2R6YD7EiAR6xt5cuR+rcYJRaV8Zh4j
         ryOdcPwN0AIUr8chVvN+t2UQ4oWKaOCD18vybGGblyj0RTYOEYjQb/hhFrz6BQJTR9
         e1cHzV3jVuoFQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4QKgtn6RPlz12dT;
        Mon, 15 May 2023 09:58:09 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [PATCH 4/4] selftests/rseq: Use rseq_unqual_scalar_typeof in macros
Date:   Mon, 15 May 2023 09:58:01 -0400
Message-Id: <20230515135801.15220-5-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
References: <20230515135801.15220-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Use rseq_unqual_scalar_typeof() rather than typeof() in macros to remove
the volatile qualifier (if there is one in the input argument), thus
generating better assembly code in those scenarios.

Also add extra brackets around the "p" parameter in RSEQ_READ_ONCE(),
RSEQ_WRITE_ONCE(), and rseq_unqual_scalar_typeof() across architectures
to preserve expectations of operator priority. Here is an example that
shows how operator priority may be an issue with missing parentheses:

    #define m(p) \
    do { \
            __typeof__(*p) v = 0; \
    } while (0)

    void fct(unsigned long long *p1)
    {
            m(p1 + 1);      /* works */
            m(1 + p1);      /* broken */
    }

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/testing/selftests/rseq/rseq-arm.h   | 4 ++--
 tools/testing/selftests/rseq/rseq-mips.h  | 4 ++--
 tools/testing/selftests/rseq/rseq-ppc.h   | 4 ++--
 tools/testing/selftests/rseq/rseq-riscv.h | 6 +++---
 tools/testing/selftests/rseq/rseq-s390.h  | 4 ++--
 tools/testing/selftests/rseq/rseq-x86.h   | 4 ++--
 6 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm.h b/tools/testing/selftests/rseq/rseq-arm.h
index 8414fc3eac15..d887b3bbe257 100644
--- a/tools/testing/selftests/rseq/rseq-arm.h
+++ b/tools/testing/selftests/rseq/rseq-arm.h
@@ -66,7 +66,7 @@
 
 #define rseq_smp_load_acquire(p)					\
 __extension__ ({							\
-	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
 	rseq_smp_mb();							\
 	____p1;								\
 })
@@ -76,7 +76,7 @@ __extension__ ({							\
 #define rseq_smp_store_release(p, v)					\
 do {									\
 	rseq_smp_mb();							\
-	RSEQ_WRITE_ONCE(*p, v);						\
+	RSEQ_WRITE_ONCE(*(p), v);					\
 } while (0)
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
diff --git a/tools/testing/selftests/rseq/rseq-mips.h b/tools/testing/selftests/rseq/rseq-mips.h
index 50b950cf9585..42ef8e946693 100644
--- a/tools/testing/selftests/rseq/rseq-mips.h
+++ b/tools/testing/selftests/rseq/rseq-mips.h
@@ -45,7 +45,7 @@
 
 #define rseq_smp_load_acquire(p)					\
 __extension__ ({							\
-	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
 	rseq_smp_mb();							\
 	____p1;								\
 })
@@ -55,7 +55,7 @@ __extension__ ({							\
 #define rseq_smp_store_release(p, v)					\
 do {									\
 	rseq_smp_mb();							\
-	RSEQ_WRITE_ONCE(*p, v);						\
+	RSEQ_WRITE_ONCE(*(p), v);					\
 } while (0)
 
 #if _MIPS_SZLONG == 64
diff --git a/tools/testing/selftests/rseq/rseq-ppc.h b/tools/testing/selftests/rseq/rseq-ppc.h
index dc9190facee9..57b160597189 100644
--- a/tools/testing/selftests/rseq/rseq-ppc.h
+++ b/tools/testing/selftests/rseq/rseq-ppc.h
@@ -23,7 +23,7 @@
 
 #define rseq_smp_load_acquire(p)					\
 __extension__ ({							\
-	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
 	rseq_smp_lwsync();						\
 	____p1;								\
 })
@@ -33,7 +33,7 @@ __extension__ ({							\
 #define rseq_smp_store_release(p, v)					\
 do {									\
 	rseq_smp_lwsync();						\
-	RSEQ_WRITE_ONCE(*p, v);						\
+	RSEQ_WRITE_ONCE(*(p), v);					\
 } while (0)
 
 /*
diff --git a/tools/testing/selftests/rseq/rseq-riscv.h b/tools/testing/selftests/rseq/rseq-riscv.h
index 17932a79e066..37e598d0a365 100644
--- a/tools/testing/selftests/rseq/rseq-riscv.h
+++ b/tools/testing/selftests/rseq/rseq-riscv.h
@@ -36,8 +36,8 @@
 
 #define rseq_smp_load_acquire(p)					\
 __extension__ ({							\
-	__typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));			\
-	RISCV_FENCE(r, rw)						\
+	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
+	RISCV_FENCE(r, rw);						\
 	____p1;								\
 })
 
@@ -46,7 +46,7 @@ __extension__ ({							\
 #define rseq_smp_store_release(p, v)					\
 do {									\
 	RISCV_FENCE(rw, w);						\
-	RSEQ_WRITE_ONCE(*(p), v);						\
+	RSEQ_WRITE_ONCE(*(p), v);					\
 } while (0)
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags, start_ip,	\
diff --git a/tools/testing/selftests/rseq/rseq-s390.h b/tools/testing/selftests/rseq/rseq-s390.h
index 46c92598acc7..33baaa9f9997 100644
--- a/tools/testing/selftests/rseq/rseq-s390.h
+++ b/tools/testing/selftests/rseq/rseq-s390.h
@@ -15,7 +15,7 @@
 
 #define rseq_smp_load_acquire(p)					\
 __extension__ ({							\
-	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
 	rseq_barrier();							\
 	____p1;								\
 })
@@ -25,7 +25,7 @@ __extension__ ({							\
 #define rseq_smp_store_release(p, v)					\
 do {									\
 	rseq_barrier();							\
-	RSEQ_WRITE_ONCE(*p, v);						\
+	RSEQ_WRITE_ONCE(*(p), v);					\
 } while (0)
 
 #ifdef __s390x__
diff --git a/tools/testing/selftests/rseq/rseq-x86.h b/tools/testing/selftests/rseq/rseq-x86.h
index fb65ef54b0fb..a2aa428ba151 100644
--- a/tools/testing/selftests/rseq/rseq-x86.h
+++ b/tools/testing/selftests/rseq/rseq-x86.h
@@ -42,7 +42,7 @@
 
 #define rseq_smp_load_acquire(p)					\
 __extension__ ({							\
-	__typeof(*p) ____p1 = RSEQ_READ_ONCE(*p);			\
+	rseq_unqual_scalar_typeof(*(p)) ____p1 = RSEQ_READ_ONCE(*(p));	\
 	rseq_barrier();							\
 	____p1;								\
 })
@@ -52,7 +52,7 @@ __extension__ ({							\
 #define rseq_smp_store_release(p, v)					\
 do {									\
 	rseq_barrier();							\
-	RSEQ_WRITE_ONCE(*p, v);						\
+	RSEQ_WRITE_ONCE(*(p), v);					\
 } while (0)
 
 #define __RSEQ_ASM_DEFINE_TABLE(label, version, flags,			\
-- 
2.25.1

