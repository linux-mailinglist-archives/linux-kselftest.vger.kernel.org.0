Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DEE49E605
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jan 2022 16:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiA0P1c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jan 2022 10:27:32 -0500
Received: from mail.efficios.com ([167.114.26.124]:56128 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237542AbiA0P1b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jan 2022 10:27:31 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id F1AEA3698BE;
        Thu, 27 Jan 2022 10:27:30 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id iNVvjsDn1UKo; Thu, 27 Jan 2022 10:27:30 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 40DF5369B88;
        Thu, 27 Jan 2022 10:27:30 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 40DF5369B88
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1643297250;
        bh=cRqh6zSj9GZH8t608eqoD75yviKq/ALEi5aVTfTfbkI=;
        h=From:To:Date:Message-Id;
        b=kUCrNk9hvekCSfXQh7ZOludwqXf07XZyEnGKe3+trdCkJi7pO+6neIMhOJ6Kq8N7T
         NhRe44ydQOjQA1zTXhQH2dArS3nHYNp+cip5c/MrFwTx/lWdKP3cQU4wZrgnVrSkbS
         emYljpzganzbCl6w3YZ5S88nh3izZRP5gd61DGJsPzBQChHaG8ptHuWP8iI7HhwC2x
         Q2NOBzQi9JF7qzhIC0Cm8yw/yHaDPN6aEzUVms6iNUVHd86FgdrAvLdwnWimZRDi2f
         R+zVxXse2O2KMMZuz1voxmJI8NKOT7vBwkytzJEmQHdm22Q2i8673kgrGH5Unbm4wE
         gBa/7RwcX1bvg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 9PLYYLCLjF8C; Thu, 27 Jan 2022 10:27:30 -0500 (EST)
Received: from localhost.localdomain (192-222-180-24.qc.cable.ebox.net [192.222.180.24])
        by mail.efficios.com (Postfix) with ESMTPSA id 8AEF3369A41;
        Thu, 27 Jan 2022 10:27:29 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Paul Turner <pjt@google.com>,
        linux-api@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Florian Weimer <fw@deneb.enyo.de>,
        Andy Lutomirski <luto@amacapital.net>,
        Dave Watson <davejwatson@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@arm.linux.org.uk>,
        Andi Kleen <andi@firstfloor.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Ben Maurer <bmaurer@fb.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Joel Fernandes <joelaf@google.com>
Subject: [RFC PATCH v2] rseq: Remove broken uapi field layout on 32-bit little endian
Date:   Thu, 27 Jan 2022 10:27:20 -0500
Message-Id: <20220127152720.25898-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1116876795.2062.1643223596536.JavaMail.zimbra@efficios.com>
References: <1116876795.2062.1643223596536.JavaMail.zimbra@efficios.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The rseq rseq_cs.ptr.{ptr32,padding} uapi endianness handling is
entirely wrong on 32-bit little endian: a preprocessor logic mistake
wrongly uses the big endian field layout on 32-bit little endian
architectures.

Fortunately, those ptr32 accessors were never used within the kernel,
and only meant as a convenience for user-space.

Remove those and replace the whole rseq_cs union by a __u64 type, as
this is the only thing really needed to express the ABI. Document how
32-bit architectures are meant to interact with this field.

Fixes: ec9c82e03a74 ("rseq: uapi: Declare rseq_cs field as union, update includes")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Florian Weimer <fw@deneb.enyo.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-api@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Watson <davejwatson@fb.com>
Cc: Paul Turner <pjt@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <andi@firstfloor.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Ben Maurer <bmaurer@fb.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Michael Kerrisk <mtk.manpages@gmail.com>
Cc: Joel Fernandes <joelaf@google.com>
Cc: Paul E. McKenney <paulmck@kernel.org>
---
 include/uapi/linux/rseq.h | 20 ++++----------------
 kernel/rseq.c             |  8 ++++----
 2 files changed, 8 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/rseq.h b/include/uapi/linux/rseq.h
index 9a402fdb60e9..77ee207623a9 100644
--- a/include/uapi/linux/rseq.h
+++ b/include/uapi/linux/rseq.h
@@ -105,23 +105,11 @@ struct rseq {
 	 * Read and set by the kernel. Set by user-space with single-copy
 	 * atomicity semantics. This field should only be updated by the
 	 * thread which registered this data structure. Aligned on 64-bit.
+	 *
+	 * 32-bit architectures should update the low order bits of the
+	 * rseq_cs field, leaving the high order bits initialized to 0.
 	 */
-	union {
-		__u64 ptr64;
-#ifdef __LP64__
-		__u64 ptr;
-#else
-		struct {
-#if (defined(__BYTE_ORDER) && (__BYTE_ORDER == __BIG_ENDIAN)) || defined(__BIG_ENDIAN)
-			__u32 padding;		/* Initialized to zero. */
-			__u32 ptr32;
-#else /* LITTLE */
-			__u32 ptr32;
-			__u32 padding;		/* Initialized to zero. */
-#endif /* ENDIAN */
-		} ptr;
-#endif
-	} rseq_cs;
+	__u64 rseq_cs;
 
 	/*
 	 * Restartable sequences flags field.
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 6d45ac3dae7f..97ac20b4f738 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -128,10 +128,10 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	int ret;
 
 #ifdef CONFIG_64BIT
-	if (get_user(ptr, &t->rseq->rseq_cs.ptr64))
+	if (get_user(ptr, &t->rseq->rseq_cs))
 		return -EFAULT;
 #else
-	if (copy_from_user(&ptr, &t->rseq->rseq_cs.ptr64, sizeof(ptr)))
+	if (copy_from_user(&ptr, &t->rseq->rseq_cs, sizeof(ptr)))
 		return -EFAULT;
 #endif
 	if (!ptr) {
@@ -217,9 +217,9 @@ static int clear_rseq_cs(struct task_struct *t)
 	 * Set rseq_cs to NULL.
 	 */
 #ifdef CONFIG_64BIT
-	return put_user(0UL, &t->rseq->rseq_cs.ptr64);
+	return put_user(0UL, &t->rseq->rseq_cs);
 #else
-	if (clear_user(&t->rseq->rseq_cs.ptr64, sizeof(t->rseq->rseq_cs.ptr64)))
+	if (clear_user(&t->rseq->rseq_cs, sizeof(t->rseq->rseq_cs)))
 		return -EFAULT;
 	return 0;
 #endif
-- 
2.17.1

