Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375A22C738E
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Nov 2020 23:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387405AbgK1Vt5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 28 Nov 2020 16:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729811AbgK0TrT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Nov 2020 14:47:19 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2718C061A52;
        Fri, 27 Nov 2020 11:32:59 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 7F3451F4659F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     gofmanp@gmail.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 4/7] entry: Support Syscall User Dispatch on common syscall entry
Date:   Fri, 27 Nov 2020 14:32:35 -0500
Message-Id: <20201127193238.821364-5-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127193238.821364-1-krisman@collabora.com>
References: <20201127193238.821364-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Syscall User Dispatch (SUD) must take precedence over seccomp and
ptrace, since the use case is emulation (it can be invoked with a
different ABI) such that seccomp filtering by syscall number doesn't
make sense in the first place.  In addition, either the syscall is
dispatched back to userspace, in which case there is no resource for to
trace, or the syscall will be executed, and seccomp/ptrace will execute
next.

Since SUD runs before tracepoints, it needs to be a SYSCALL_WORK_EXIT as
well, just to prevent a trace exit event when dispatch was triggered.
For that, the on_syscall_dispatch() examines context to skip the
tracepoint, audit and other work.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
Changes since v6:
  - Update do_syscall_intercept signature (Christian Brauner)
  - Move it to before tracepoints
  - Use SYSCALL_WORK flags
---
 include/linux/entry-common.h |  2 ++
 kernel/entry/common.c        | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 49b26b216e4e..a6e98b4ba8e9 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -44,10 +44,12 @@
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_EMU |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 ARCH_SYSCALL_WORK_ENTER)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
 /*
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f1b12dc32ff4..ec20aba3b890 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -6,6 +6,8 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 
+#include "common.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
@@ -47,6 +49,16 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 {
 	long ret = 0;
 
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (do_syscall_user_dispatch(regs))
+			return -1L;
+	}
+
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret = arch_syscall_enter_tracehook(regs);
@@ -232,6 +244,11 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (on_syscall_dispatch())
+			return;
+	}
+
 	audit_syscall_exit(regs);
 
 	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
-- 
2.29.2

