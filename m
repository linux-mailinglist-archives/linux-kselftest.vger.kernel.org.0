Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 408ED2413C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 11 Aug 2020 01:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgHJX1C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 10 Aug 2020 19:27:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51386 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHJX1A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 10 Aug 2020 19:27:00 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2908F29480F
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     keescook@chromium.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        willy@infradead.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v5 4/9] signal: Expose SYS_USER_DISPATCH si_code type
Date:   Mon, 10 Aug 2020 19:26:31 -0400
Message-Id: <20200810232636.1415588-5-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200810232636.1415588-1-krisman@collabora.com>
References: <20200810232636.1415588-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

SYS_USER_DISPATCH will be triggered when a syscall is sent to userspace
by the Syscall User Dispatch mechanism.  This adjusts eventual
BUILD_BUG_ON around the tree.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/kernel/signal_compat.c    | 2 +-
 include/uapi/asm-generic/siginfo.h | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/signal_compat.c b/arch/x86/kernel/signal_compat.c
index 9ccbf0576cd0..210aecc6eab9 100644
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
index cb3d6c267181..37741908b846 100644
--- a/include/uapi/asm-generic/siginfo.h
+++ b/include/uapi/asm-generic/siginfo.h
@@ -284,7 +284,8 @@ typedef struct siginfo {
  * SIGSYS si_codes
  */
 #define SYS_SECCOMP	1	/* seccomp triggered */
-#define NSIGSYS		1
+#define SYS_USER_DISPATCH 2	/* syscall user dispatch triggered */
+#define NSIGSYS		2
 
 /*
  * SIGEMT si_codes
-- 
2.28.0

