Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4673FFAC
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 Jun 2023 17:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjF0P3o (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Jun 2023 11:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231637AbjF0P3m (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Jun 2023 11:29:42 -0400
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA0E1BCF;
        Tue, 27 Jun 2023 08:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1687879779;
        bh=JFXZOyA+MaNEabXquELDZyqKe3MTOQ5kU8hAyTwsfD4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dKIIJDfoTTs+30uLmwEbMUJNd5+s/W+E3r8raAud+wS/HMFcv3azT3BIcxFZJ3V8C
         3s5AlHrgjySwakSB+cq0/FSoJpkUpSErmSm0KqD6fPZhfHLQsa3uKw8ArrP33GlHa5
         9Xy+7pTbENE0utQBhsYr1qQ242gnc1Wy5iOmfbqkV/bH1XUz1TAjDc9DkVMyJkQjxd
         XH3j9E+pOZIwLt4ci5YcmveVWNx5fFjdNq4xOtlBm5jttHzOV7+STet3LOl1U5e+Jc
         /P4xN23KoLGxhXWAlYBo9OzAbryZxes/j2+8e5nENsMhMYEV6c2JO7lvE+9a1wouIo
         8PjfdXoTa7PJQ==
Received: from localhost.localdomain (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4Qr7tW3401z19RR;
        Tue, 27 Jun 2023 11:29:39 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: [PATCH 3/4] selftests/rseq: Fix arm64 buggy load-acquire/store-release macros
Date:   Tue, 27 Jun 2023 11:29:22 -0400
Message-Id: <20230627152923.133238-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627152923.133238-1-mathieu.desnoyers@efficios.com>
References: <20230627152923.133238-1-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The arm64 load-acquire/store-release macros from the Linux kernel rseq
selftests are buggy. Remplace them by a working implementation.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 tools/testing/selftests/rseq/rseq-arm64.h | 58 ++++++++++++-----------
 1 file changed, 30 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/rseq/rseq-arm64.h b/tools/testing/selftests/rseq/rseq-arm64.h
index 85b90977e7e6..21e1626a7235 100644
--- a/tools/testing/selftests/rseq/rseq-arm64.h
+++ b/tools/testing/selftests/rseq/rseq-arm64.h
@@ -27,59 +27,61 @@
 
 #define rseq_smp_load_acquire(p)						\
 __extension__ ({								\
-	__typeof(*p) ____p1;							\
-	switch (sizeof(*p)) {							\
+	union { rseq_unqual_scalar_typeof(*(p)) __val; char __c[sizeof(*(p))]; } __u; \
+	switch (sizeof(*(p))) {							\
 	case 1:									\
-		asm volatile ("ldarb %w0, %1"					\
-			: "=r" (*(__u8 *)p)					\
-			: "Q" (*p) : "memory");					\
+		__asm__ __volatile__ ("ldarb %w0, %1"				\
+			: "=r" (*(__u8 *)__u.__c)				\
+			: "Q" (*(p)) : "memory");				\
 		break;								\
 	case 2:									\
-		asm volatile ("ldarh %w0, %1"					\
-			: "=r" (*(__u16 *)p)					\
-			: "Q" (*p) : "memory");					\
+		__asm__ __volatile__ ("ldarh %w0, %1"				\
+			: "=r" (*(__u16 *)__u.__c)				\
+			: "Q" (*(p)) : "memory");				\
 		break;								\
 	case 4:									\
-		asm volatile ("ldar %w0, %1"					\
-			: "=r" (*(__u32 *)p)					\
-			: "Q" (*p) : "memory");					\
+		__asm__ __volatile__ ("ldar %w0, %1"				\
+			: "=r" (*(__u32 *)__u.__c)				\
+			: "Q" (*(p)) : "memory");				\
 		break;								\
 	case 8:									\
-		asm volatile ("ldar %0, %1"					\
-			: "=r" (*(__u64 *)p)					\
-			: "Q" (*p) : "memory");					\
+		__asm__ __volatile__ ("ldar %0, %1"				\
+			: "=r" (*(__u64 *)__u.__c)				\
+			: "Q" (*(p)) : "memory");				\
 		break;								\
 	}									\
-	____p1;									\
+	(rseq_unqual_scalar_typeof(*(p)))__u.__val;				\
 })
 
 #define rseq_smp_acquire__after_ctrl_dep()	rseq_smp_rmb()
 
 #define rseq_smp_store_release(p, v)						\
 do {										\
-	switch (sizeof(*p)) {							\
+	union { rseq_unqual_scalar_typeof(*(p)) __val; char __c[sizeof(*(p))]; } __u = \
+		{ .__val = (rseq_unqual_scalar_typeof(*(p))) (v) };		\
+	switch (sizeof(*(p))) {							\
 	case 1:									\
-		asm volatile ("stlrb %w1, %0"					\
-				: "=Q" (*p)					\
-				: "r" ((__u8)v)					\
+		__asm__ __volatile__ ("stlrb %w1, %0"				\
+				: "=Q" (*(p))					\
+				: "r" (*(__u8 *)__u.__c)			\
 				: "memory");					\
 		break;								\
 	case 2:									\
-		asm volatile ("stlrh %w1, %0"					\
-				: "=Q" (*p)					\
-				: "r" ((__u16)v)				\
+		__asm__ __volatile__ ("stlrh %w1, %0"				\
+				: "=Q" (*(p))					\
+				: "r" (*(__u16 *)__u.__c)			\
 				: "memory");					\
 		break;								\
 	case 4:									\
-		asm volatile ("stlr %w1, %0"					\
-				: "=Q" (*p)					\
-				: "r" ((__u32)v)				\
+		__asm__ __volatile__ ("stlr %w1, %0"				\
+				: "=Q" (*(p))					\
+				: "r" (*(__u32 *)__u.__c)			\
 				: "memory");					\
 		break;								\
 	case 8:									\
-		asm volatile ("stlr %1, %0"					\
-				: "=Q" (*p)					\
-				: "r" ((__u64)v)				\
+		__asm__ __volatile__ ("stlr %1, %0"				\
+				: "=Q" (*(p))					\
+				: "r" (*(__u64 *)__u.__c)			\
 				: "memory");					\
 		break;								\
 	}									\
-- 
2.25.1

