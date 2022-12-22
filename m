Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDBF653B08
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 04:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbiLVDwW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 22:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiLVDwU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 22:52:20 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D0186A6;
        Wed, 21 Dec 2022 19:52:19 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id 0E28E81A14;
        Thu, 22 Dec 2022 03:52:14 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671681139;
        bh=kULCxpE25ChDF6QfgE9AQS3bo2E7ihos1VsI9mS/Wmg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZlzUpeLpn+jVdP9jtnmx4mHFn13ToH+RIy528nBPlj+pDkEW9I1aKV46OdGeur4Y2
         ALPyOg/8i1qcytsNTzW6sFmZMn48TXq7qCgS/tFV6RAo3xIT3y4xvGgo+AYYTWtYgv
         S7XpVIXU/LODBMv1SEaBvn8eWfoG3X7knJQaUE0SynhkH3IL5i2LVj5CUXstzDfc6B
         ehkhaAFPuAgMD2qyoEJO25qZG7ZVg5Zko+Tku+tl1J1fij8xadukBjAQKK8jxpql3o
         UnYEJoBsPa2GOK3+6WXkPUq3qPsvPndaUml7jVYUapTcw6RtgIybno8AojlUJYb/Fx
         ACr1p4G5G4CRw==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v1 1/8] nolibc/sys: Implement `sigaction(2)` function
Date:   Thu, 22 Dec 2022 10:51:27 +0700
Message-Id: <20221222035134.3467659-2-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222035134.3467659-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

This commit adds the initial implementation of nolibc `sigaction()`
function. Currently, this implementation is only available on the
x86-64 arch.

`sigaction()` needs an architecture-dependent "signal trampoline"
function that invokes the __rt_sigreturn syscall to resume the process
after a signal gets handled.

On Linux x86-64, the "signal trampoline" function has to be written in
inline Assembly to prevent the compiler from controlling the `%rsp`
(e.g., with `-fno-omit-frame-pointer`, every function has a `pushq
%rbp` that makes the `%rsp` no longer point to `struct rt_sigframe`).

The "signal trampoline" function is called `__arch_restore_rt` in this
implementation.

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/include/nolibc/arch-x86_64.h | 12 +++++
 tools/include/nolibc/sys.h         | 80 ++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 0e1e9eb8545d..b6470943e836 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -212,4 +212,16 @@ __asm__ (".section .text\n"
     "hlt\n"                     // ensure it does not return
     "");
 
+void __arch_restore_rt(void);
+
+__asm__ (
+".section .text\n"
+"__arch_restore_rt:\n\t"
+	"movl	$0xf, %eax\n\t" // __NR_rt_sigreturn == 0xf
+	"syscall\n\t"           // %rsp must point to a valid struct rt_sigframe.
+	"int3"
+);
+
+#define __HAVE_ARCH_RESTORE_RT
+
 #endif // _NOLIBC_ARCH_X86_64_H
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 3db1dd8c74ee..91532a2fbe2c 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -1026,6 +1026,86 @@ pid_t setsid(void)
 	return ret;
 }
 
+typedef void (*sighandler_t)(int sig);
+
+/*
+ * int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact);
+ */
+
+static __attribute__((unused))
+int sys_sigaction(int signum, const struct sigaction *act,
+		  struct sigaction *oldact)
+{
+	return my_syscall4(__NR_rt_sigaction, signum, act, oldact,
+			   sizeof(sigset_t));
+}
+
+static __attribute__((unused))
+int sigaction(int signum, const struct sigaction *act, struct sigaction *oldact)
+{
+#ifdef __HAVE_ARCH_RESTORE_RT
+	struct sigaction act2 = *act;
+	int ret;
+
+	/*
+	 * On Linux x86-64, libc's sigaction() always sets the
+	 * @act->sa_restorer when the caller passes a NULL.
+	 *
+	 * @act->sa_restorer is an arch-specific function used
+	 * as a "signal trampoline".
+	 *
+	 * @act->sa_handler is a signal handler provided by the
+	 * user.
+	 *
+	 * When the handled signal is caught, the %rip jumps to
+	 * @act->sa_handler with user stack already set by the
+	 * kernel as below:
+	 *
+	 *         |--------------------|
+	 * %rsp -> |  act->sa_restorer  | (return address)
+	 *         |--------------------|
+	 *         | struct rt_sigframe | (process context info)
+	 *         |                    |
+	 *         |                    |
+	 *          ....................
+	 *
+	 * Once this signal handler executes the "ret" instruction,
+	 * the %rip jumps to @act->sa_restorer. The sa_restorer
+	 * function has to invoke the __rt_sigreturn syscall with
+	 * %rsp pointing to the `struct rt_sigframe` that the kernel
+	 * constructed previously to resume the process.
+	 *
+	 * The "signal trampoline" function has to be written in
+	 * inline Assembly to prevent the compiler from controlling
+	 * the %rsp (e.g., with -fno-omit-frame-pointer, every
+	 * function has a `pushq %rbp` that makes the %rsp no longer
+	 * point to `struct rt_sigframe`).
+	 *
+	 * `struct rt_sigframe` contains the registers' value before
+	 * the signal is caught.
+	 *
+	 */
+	if (!act2.sa_restorer) {
+		act2.sa_flags |= SA_RESTORER;
+		act2.sa_restorer = __arch_restore_rt;
+	}
+
+	ret = sys_sigaction(signum, &act2, oldact);
+	if (ret < 0) {
+		SET_ERRNO(-ret);
+		ret = -1;
+	}
+	return ret;
+#else
+	/*
+	 * TODO: Implement sa_restorer ("signal trampoline") for
+	 *       other architectures.
+	 */
+	SET_ERRNO(ENOSYS);
+	return -1;
+#endif
+}
+
 
 /*
  * int stat(const char *path, struct stat *buf);
-- 
Ammar Faizi

