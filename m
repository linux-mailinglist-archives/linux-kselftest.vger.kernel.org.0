Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 798F12C705B
	for <lists+linux-kselftest@lfdr.de>; Sat, 28 Nov 2020 19:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbgK0TtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Nov 2020 14:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbgK0Trl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Nov 2020 14:47:41 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5347DC061A51;
        Fri, 27 Nov 2020 11:32:52 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0B81A1F465A0
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de, keescook@chromium.org
Cc:     gofmanp@gmail.com, christian.brauner@ubuntu.com,
        peterz@infradead.org, willy@infradead.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, x86@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v8 2/7] signal: Expose SYS_USER_DISPATCH si_code type
Date:   Fri, 27 Nov 2020 14:32:33 -0500
Message-Id: <20201127193238.821364-3-krisman@collabora.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127193238.821364-1-krisman@collabora.com>
References: <20201127193238.821364-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SYS_USER_DISPATCH will be triggered when a syscall is sent to userspace
by the Syscall User Dispatch mechanism.  This adjusts eventual
BUILD_BUG_ON around the tree.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Acked-by: Kees Cook <keescook@chromium.org>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index a7f3e12cfbdb..d7b51870f16b 100644
--- a/arch/x86/kernel/signal_compat.c
+++ b/arch/x86/kernel/signal_compat.c
@@ -31,7 +31,7 @@ static inline void signal_compat_build_tests(void)
 	BUILD_BUG_ON(NSIGBUS  != 5);
 	BUILD_BUG_ON(NSIGTRAP != 5);
 	BUILD_BUG_ON(NSIGCHLD != 6);
-	BUILD_BUG_ON(NSIGSYS  != 1);
+	BUILD_BUG_ON(NSIGSYS  != 2);
 
 	/* This is part of the ABI and can never change in size: */
 	BUILD_BUG_ON(sizeof(compat_siginfo_t) != 128);
diff --git a/include/uapi/asm-generic/siginfo.h b/include/uapi/asm-generic/siginfo.h
index 7aacf9389010..d2597000407a 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -286,7 +286,8 @@ typedef struct siginfo {
  * SIGSYS si_codes
  */
 #define SYS_SECCOMP	1	/* seccomp triggered */
-#define NSIGSYS		1
+#define SYS_USER_DISPATCH 2	/* syscall user dispatch triggered */
+#define NSIGSYS		2
 
 /*
  * SIGEMT si_codes
-- 
2.29.2

