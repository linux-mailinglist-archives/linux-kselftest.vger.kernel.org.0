Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D1A76E731
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Aug 2023 13:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjHCLoa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Aug 2023 07:44:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbjHCLoa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Aug 2023 07:44:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F041B2;
        Thu,  3 Aug 2023 04:44:27 -0700 (PDT)
X-QQ-mid: bizesmtp75t1691063056t3xoxs0j
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 03 Aug 2023 19:44:15 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: Sy85gTauCelobQRRLx7OT4W1HI19VjNnJwUYVHussW5QsEbHd9E6smTiBjWmE
        XWHw661oWp+XdYsJUbRPrPvqeZTd3IIGQ4nMQZO6sW47H8u0LPEfuYZjLLdIhAH/7A0VPqc
        xcLZWg7eUZA9Q5vxK7zAojT0JSXBTyLfSXnawyr/LJQ6pZ/iIKb3Zn/xDb89YdnaBiQuu3r
        jUHwxicHDEK615WkyA9XrEd3bkIuujXoDbk1MyZTy5rNJgAPh6WCl63xipd4EJ0MvnGuj7i
        qPTPPKonN91zAgWu7SlyxLpCYPt8BcGghvNJFDGVQ1UVEfj0JKYRZggAc25+Rjhh+KaMFRI
        AgDiojbJ4CfML1CErN4odt8bgDG4rkMksagt0KBnxO6PFjIdy6mNgCGvKmuD3UCQlbriCdy
        K45UR44aufA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12572933172373456038
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 1/8] tools/nolibc: add support for powerpc
Date:   Thu,  3 Aug 2023 19:44:14 +0800
Message-Id: <158150995a718a974d506a8ffc62942c7460be1c.1691062722.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691062722.git.falcon@tinylab.org>
References: <cover.1691062722.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both syscall declarations and _start code definition are added for
powerpc to nolibc.

Like mips, powerpc uses a register (exactly, the summary overflow bit)
to record the error occurred, and uses another register to return the
value [1]. So, the return value of every syscall declaration must be
normalized to match the __sysret() helper, return -value when there is
an error, otheriwse, return value directly.

Glibc and musl use different methods to check the summary overflow bit,
glibc (sysdeps/unix/sysv/linux/powerpc/sysdep.h) saves the cr register
to r0 at first, and then check the summary overflow bit in cr0:

    mfcr r0
    r0 & (1 << 28) ? -r3 : r3

    -->

    10003c14:       7c 00 00 26     mfcr    r0
    10003c18:       74 09 10 00     andis.  r9,r0,4096
    10003c1c:       41 82 00 08     beq     0x10003c24
    10003c20:       7c 63 00 d0     neg     r3,r3

Musl (arch/powerpc/syscall_arch.h) directly checks the summary overflow
bit with the 'bns' instruction, it is smaller:

    /* no summary overflow bit means no error, return value directly */
    bns+ 1f
    /* otherwise, return negated value */
    neg r3, r3
    1:

    -->

    10000418:       40 a3 00 08     bns     0x10000420
    1000041c:       7c 63 00 d0     neg     r3,r3

Like musl, Linux (arch/powerpc/include/asm/vdso/gettimeofday.h) uses the
same method for do_syscall_2() too.

Here applies the second method to get smaller size.

[1]: https://man7.org/linux/man-pages/man2/syscall.2.html

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-powerpc.h | 197 ++++++++++++++++++++++++++++
 tools/include/nolibc/arch.h         |   2 +
 2 files changed, 199 insertions(+)
 create mode 100644 tools/include/nolibc/arch-powerpc.h

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
new file mode 100644
index 000000000000..8332c9d3e5d6
--- /dev/null
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -0,0 +1,197 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * PowerPC specific definitions for NOLIBC
+ * Copyright (C) 2023 Zhangjin Wu <falcon@tinylab.org>
+ */
+
+#ifndef _NOLIBC_ARCH_POWERPC_H
+#define _NOLIBC_ARCH_POWERPC_H
+
+#include "compiler.h"
+#include "crt.h"
+
+/* Syscalls for PowerPC :
+ *   - stack is 16-byte aligned
+ *   - syscall number is passed in r0
+ *   - arguments are in r3, r4, r5, r6, r7, r8, r9
+ *   - the system call is performed by calling "sc"
+ *   - syscall return comes in r3, and the summary overflow bit is checked
+ *     to know if an error occurred, in which case errno is in r3.
+ *   - the arguments are cast to long and assigned into the target
+ *     registers which are then simply passed as registers to the asm code,
+ *     so that we don't have to experience issues with register constraints.
+ */
+
+#define _NOLIBC_SYSCALL_CLOBBERLIST \
+	"memory", "cr0", "r12", "r11", "r10", "r9"
+
+#define my_syscall0(num)                                                     \
+({                                                                           \
+	register long _ret  __asm__ ("r3");                                  \
+	register long _num  __asm__ ("r0") = (num);                          \
+									     \
+	__asm__ volatile (                                                   \
+		"	sc\n"                                                \
+		"	bns+ 1f\n"                                           \
+		"	neg  %0, %0\n"                                       \
+		"1:\n"                                                       \
+		: "=r"(_ret), "+r"(_num)                                     \
+		:                                                            \
+		: _NOLIBC_SYSCALL_CLOBBERLIST, "r8", "r7", "r6", "r5", "r4"  \
+	);                                                                   \
+	_ret;                                                                \
+})
+
+#define my_syscall1(num, arg1)                                               \
+({                                                                           \
+	register long _ret  __asm__ ("r3");                                  \
+	register long _num  __asm__ ("r0") = (num);                          \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
+									     \
+	__asm__ volatile (                                                   \
+		"	sc\n"                                                \
+		"	bns+ 1f\n"                                           \
+		"	neg  %0, %0\n"                                       \
+		"1:\n"                                                       \
+		: "=r"(_ret), "+r"(_num)                                     \
+		: "0"(_arg1)                                                 \
+		: _NOLIBC_SYSCALL_CLOBBERLIST, "r8", "r7", "r6", "r5", "r4"  \
+	);                                                                   \
+	_ret;                                                                \
+})
+
+
+#define my_syscall2(num, arg1, arg2)                                         \
+({                                                                           \
+	register long _ret  __asm__ ("r3");                                  \
+	register long _num  __asm__ ("r0") = (num);                          \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
+									     \
+	__asm__ volatile (                                                   \
+		"	sc\n"                                                \
+		"	bns+ 1f\n"                                           \
+		"	neg  %0, %0\n"                                       \
+		"1:\n"                                                       \
+		: "=r"(_ret), "+r"(_num), "+r"(_arg2)                        \
+		: "0"(_arg1)                                                 \
+		: _NOLIBC_SYSCALL_CLOBBERLIST, "r8", "r7", "r6", "r5"        \
+	);                                                                   \
+	_ret;                                                                \
+})
+
+
+#define my_syscall3(num, arg1, arg2, arg3)                                   \
+({                                                                           \
+	register long _ret  __asm__ ("r3");                                  \
+	register long _num  __asm__ ("r0") = (num);                          \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
+									     \
+	__asm__ volatile (                                                   \
+		"	sc\n"                                                \
+		"	bns+ 1f\n"                                           \
+		"	neg  %0, %0\n"                                       \
+		"1:\n"                                                       \
+		: "=r"(_ret), "+r"(_num), "+r"(_arg2), "+r"(_arg3)           \
+		: "0"(_arg1)                                                 \
+		: _NOLIBC_SYSCALL_CLOBBERLIST, "r8", "r7", "r6"              \
+	);                                                                   \
+	_ret;                                                                \
+})
+
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)                             \
+({                                                                           \
+	register long _ret  __asm__ ("r3");                                  \
+	register long _num  __asm__ ("r0") = (num);                          \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                   \
+									     \
+	__asm__ volatile (                                                   \
+		"	sc\n"                                                \
+		"	bns+ 1f\n"                                           \
+		"	neg  %0, %0\n"                                       \
+		"1:\n"                                                       \
+		: "=r"(_ret), "+r"(_num), "+r"(_arg2), "+r"(_arg3),          \
+		  "+r"(_arg4)                                                \
+		: "0"(_arg1)                                                 \
+		: _NOLIBC_SYSCALL_CLOBBERLIST, "r8", "r7"                    \
+	);                                                                   \
+	_ret;                                                                \
+})
+
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                       \
+({                                                                           \
+	register long _ret  __asm__ ("r3");                                  \
+	register long _num  __asm__ ("r0") = (num);                          \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                   \
+	register long _arg5 __asm__ ("r7") = (long)(arg5);                   \
+									     \
+	__asm__ volatile (                                                   \
+		"	sc\n"                                                \
+		"	bns+ 1f\n"                                           \
+		"	neg  %0, %0\n"                                       \
+		"1:\n"                                                       \
+		: "=r"(_ret), "+r"(_num), "+r"(_arg2), "+r"(_arg3),          \
+		  "+r"(_arg4), "+r"(_arg5)                                   \
+		: "0"(_arg1)                                                 \
+		: _NOLIBC_SYSCALL_CLOBBERLIST, "r8"                          \
+	);                                                                   \
+	_ret;                                                                \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
+({                                                                           \
+	register long _ret  __asm__ ("r3");                                  \
+	register long _num  __asm__ ("r0") = (num);                          \
+	register long _arg1 __asm__ ("r3") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("r4") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("r5") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("r6") = (long)(arg4);                   \
+	register long _arg5 __asm__ ("r7") = (long)(arg5);                   \
+	register long _arg6 __asm__ ("r8") = (long)(arg6);                   \
+									     \
+	__asm__ volatile (                                                   \
+		"	sc\n"                                                \
+		"	bns+ 1f\n"                                           \
+		"	neg  %0, %0\n"                                       \
+		"1:\n"                                                       \
+		: "=r"(_ret), "+r"(_num), "+r"(_arg2), "+r"(_arg3),          \
+		  "+r"(_arg4), "+r"(_arg5), "+r"(_arg6)                      \
+		: "0"(_arg1)                                                 \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                \
+	);                                                                   \
+	_ret;                                                                \
+})
+
+/* FIXME: For 32-bit PowerPC, with newer gcc compilers (e.g. gcc 13.1.0),
+ * "omit-frame-pointer" fails with __attribute__((no_stack_protector)) but
+ * works with __attribute__((__optimize__("-fno-stack-protector")))
+ */
+#ifdef __no_stack_protector
+#undef __no_stack_protector
+#define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
+#endif
+
+/* startup code */
+void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+		"mr     3, 1\n"         /* save stack pointer to r3, as arg1 of _start_c */
+		"clrrwi 1, 1, 4\n"      /* align the stack to 16 bytes                   */
+		"li     0, 0\n"         /* zero the frame pointer                        */
+		"stwu   1, -16(1)\n"    /* the initial stack frame                       */
+		"bl     _start_c\n"     /* transfer to c runtime                         */
+	);
+	__builtin_unreachable();
+}
+
+#endif /* _NOLIBC_ARCH_POWERPC_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 82b43935650f..e276fb0680af 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -25,6 +25,8 @@
 #include "arch-aarch64.h"
 #elif defined(__mips__) && defined(_ABIO32)
 #include "arch-mips.h"
+#elif defined(__powerpc__)
+#include "arch-powerpc.h"
 #elif defined(__riscv)
 #include "arch-riscv.h"
 #elif defined(__s390x__)
-- 
2.25.1

