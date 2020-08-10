Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577E62413CA
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 01:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgHJX1M (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 19:27:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51412 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHJX1H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 19:27:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B004628DB7F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 6/9] kernel: entry: Support Syscall User Dispatch for common syscall entry
Date:   Mon, 10 Aug 2020 19:26:33 -0400
Message-Id: <20200810232636.1415588-7-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810232636.1415588-1-krisman@collabora.com>
References: <20200810232636.1415588-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Syscall User Dispatch (SUD) must take precedence over seccomp, since the
use case is emulation (it can be invoked with a different ABI) such that
seccomp filtering by syscall number doesn't make sense in the first
place.  In addition, either the syscall is dispatched back to userspace,
in which case there is no resource for seccomp to protect, or the
syscall will be executed, and seccomp will execute next.

Regarding ptrace, I experimented with before and after, and while the
same ABI argument applies, I felt it was easier to debug if I let ptrace
happen for syscalls that are dispatched back to userspace.  In addition,
doing it after ptrace makes the code in syscall_exit_work slightly
simpler, since it doesn't require special handling for this feature.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 kernel/entry/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 80db3f146462..f05a4ee094a1 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -6,6 +6,8 @@
 #include <linux/audit.h>
 #include <linux/syscall_intercept.h>
 
+#include "common.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
@@ -47,6 +49,12 @@ static inline long do_syscall_intercept(struct pt_regs *regs)
 	int sysint_work = READ_ONCE(current->syscall_intercept);
 	int ret;
 
+	if (sysint_work & SYSINT_USER_DISPATCH) {
+		ret = do_syscall_user_dispatch(regs);
+		if (ret == -1L)
+			return ret;
+	}
+
 	if (sysint_work & SYSINT_SECCOMP) {
 		ret = __secure_computing(NULL);
 		if (ret == -1L)
-- 
2.28.0

