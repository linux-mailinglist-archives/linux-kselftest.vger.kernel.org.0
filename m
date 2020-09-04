Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F31325E2C9
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Sep 2020 22:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbgIDUcH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Sep 2020 16:32:07 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:42066 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgIDUcD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Sep 2020 16:32:03 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id F401129B03B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, willy@infradead.org,
        linux-kselftest@vger.kernel.org, shuah@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 2/9] kernel: entry: Support TIF_SYSCAL_INTERCEPT on common entry code
Date:   Fri,  4 Sep 2020 16:31:40 -0400
Message-Id: <20200904203147.2908430-3-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200904203147.2908430-1-krisman@collabora.com>
References: <20200904203147.2908430-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Syscalls that use common entry code (x86 at the moment of this writing)
need to have their defines updated inside this commit.  This added a
measureable overhead of 1ns to seccomp_benchmark selftests on a
bare-metal AMD system.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/thread_info.h |  4 ++--
 include/linux/entry-common.h       |  6 +-----
 kernel/entry/common.c              | 24 +++++++++++++++++++++---
 3 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 267701ae3d86..cf723181e1f2 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -82,7 +82,7 @@ struct thread_info {
 #define TIF_SSBD		5	/* Speculative store bypass disable */
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
-#define TIF_SECCOMP		8	/* secure computing */
+#define TIF_SYSCALL_INTERCEPT	8	/* Intercept system call */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
 #define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
@@ -112,7 +112,7 @@ struct thread_info {
 #define _TIF_SSBD		(1 << TIF_SSBD)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
-#define _TIF_SECCOMP		(1 << TIF_SECCOMP)
+#define _TIF_SYSCALL_INTERCEPT	(1 << TIF_SYSCALL_INTERCEPT)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
 #define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index efebbffcd5cc..72ce9ca860c6 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -21,10 +21,6 @@
 # define _TIF_SYSCALL_TRACEPOINT	(0)
 #endif
 
-#ifndef _TIF_SECCOMP
-# define _TIF_SECCOMP			(0)
-#endif
-
 #ifndef _TIF_SYSCALL_AUDIT
 # define _TIF_SYSCALL_AUDIT		(0)
 #endif
@@ -45,7 +41,7 @@
 #endif
 
 #define SYSCALL_ENTER_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP |	\
+	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SYSCALL_INTERCEPT | \
 	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
 	 ARCH_SYSCALL_ENTER_WORK)
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index fcae019158ca..44fd089d59da 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -4,6 +4,7 @@
 #include <linux/entry-common.h>
 #include <linux/livepatch.h>
 #include <linux/audit.h>
+#include <linux/syscall_intercept.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
@@ -41,6 +42,20 @@ static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 	}
 }
 
+static inline long do_syscall_intercept(struct pt_regs *regs)
+{
+	int sysint_work = READ_ONCE(current->syscall_intercept);
+	int ret;
+
+	if (sysint_work & SYSINT_SECCOMP) {
+		ret = __secure_computing(NULL);
+		if (ret == -1L)
+			return ret;
+	}
+
+	return 0;
+}
+
 static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 				unsigned long ti_work)
 {
@@ -53,9 +68,12 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 			return -1L;
 	}
 
-	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (ti_work & _TIF_SECCOMP) {
-		ret = __secure_computing(NULL);
+	/*
+	 * Do syscall interception like seccomp after ptrace, to catch
+	 * any tracer changes.
+	 */
+	if (ti_work & _TIF_SYSCALL_INTERCEPT) {
+		ret = do_syscall_intercept(regs);
 		if (ret == -1L)
 			return ret;
 	}
-- 
2.28.0

