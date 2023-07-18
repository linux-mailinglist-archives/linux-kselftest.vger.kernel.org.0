Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08B5758692
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjGRVLC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbjGRVLC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:11:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CDAAEC;
        Tue, 18 Jul 2023 14:10:59 -0700 (PDT)
X-QQ-mid: bizesmtp70t1689714650ti363d26
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 05:10:49 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: wPivafIDGPPEvqeYZTPmewPyvVWylqcAja+mkp8ND6UqgiOzbaRKXCiHoclg8
        YoxnLzcOckWPg+3DMm7n5F/IXhD2CKmcsZAgst044DG4HdtnJCC4VZig0bEEnMhzKVHsfxw
        kqaMdtSytK+0A8csmqqHPK1lGDEfp+38E3v5G7CflcJCUIzIqbN4O65TDlbjHXxnXq5oaaX
        6gZo2u3yyKD46zQO7GvOw9+0WD7nV2lgw6xPJd2wqjP+jQkr2/3AZpmXYSUL69GXuvZJghl
        YX7sYBRQMrp0apBHoWlUWwyfL7stsDO1hIMNn+X/Rqh+3zRHS9w4dePUoUZ0R1McY+kJ1Ty
        qsd7+IA+jLKWO6NIAxnsi+n7E4cVqvxgrjPZNtKTEQsVpol+9xlzMZx1+h6FA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7805254917606532531
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 1/8] tools/nolibc: add support for powerpc
Date:   Wed, 19 Jul 2023 05:10:48 +0800
Message-Id: <f733876f6e711c37afc3c34a71b241c9f734d62e.1689713175.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689713175.git.falcon@tinylab.org>
References: <cover.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
normalized to easier the __sysret helper, return -value when there is an
error, otheriwse, return value directly.

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
bit with the 'bns' instruction:

    /* no summary overflow bit means no error, return value directly */
    bns+ 1f
    /* otherwise, return negated value */
    neg r3, r3
    1:

    -->

    10000418:       40 a3 00 08     bns     0x10000420
    1000041c:       7c 63 00 d0     neg     r3,r3

The later one is smaller, here applies it.

arch/powerpc/include/asm/vdso/gettimeofday.h file uses the smaller
method for do_syscall_2() too.

[1]: https://man7.org/linux/man-pages/man2/syscall.2.html

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-powerpc.h | 156 ++++++++++++++++++++++++++++
 1 file changed, 156 insertions(+)
 create mode 100644 tools/include/nolibc/arch-powerpc.h

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
new file mode 100644
index 000000000000..100ec0f412dc
--- /dev/null
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -0,0 +1,156 @@
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
+	"memory", "cr0", "r9", "r10", "r11", "r12"
+
+#define my_syscall0(num)                                                     \
+({                                                                           \
+	register long r0 __asm__ ("r0") = (num);                             \
+	register long r3 __asm__ ("r3");                                     \
+									     \
+	__asm__ volatile (                                                   \
+		"sc; bns+ 1f; neg %1, %1; 1:\n"                              \
+		: "+r"(r0), "=r"(r3)                                         \
+		:: "r4", "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST \
+	);                                                                   \
+	r3;                                                                  \
+})
+
+#define my_syscall1(num, arg1)                                               \
+({                                                                           \
+	register long r0 __asm__ ("r0") = (num);                             \
+	register long r3 __asm__ ("r3") = (long)(arg1);                      \
+									     \
+	__asm__ volatile (                                                   \
+		"sc; bns+ 1f; neg %1, %1; 1:\n"                              \
+		: "+r"(r0), "+r"(r3)                                         \
+		:: "r4", "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST \
+	);                                                                   \
+	r3;                                                                  \
+})
+
+
+#define my_syscall2(num, arg1, arg2)                                         \
+({                                                                           \
+	register long r0 __asm__ ("r0") = (num);                             \
+	register long r3 __asm__ ("r3") = (long)(arg1);                      \
+	register long r4 __asm__ ("r4") = (long)(arg2);                      \
+									     \
+	__asm__ volatile (                                                   \
+		"sc; bns+ 1f; neg %1, %1; 1:\n"                              \
+		: "+r"(r0), "+r"(r3),                                        \
+		  "+r"(r4)                                                   \
+		:: "r5", "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST       \
+	);                                                                   \
+	r3;                                                                  \
+})
+
+
+#define my_syscall3(num, arg1, arg2, arg3)                                   \
+({                                                                           \
+	register long r0 __asm__ ("r0") = (num);                             \
+	register long r3 __asm__ ("r3") = (long)(arg1);                      \
+	register long r4 __asm__ ("r4") = (long)(arg2);                      \
+	register long r5 __asm__ ("r5") = (long)(arg3);                      \
+									     \
+	__asm__ volatile (                                                   \
+		"sc; bns+ 1f; neg %1, %1; 1:\n"                              \
+		: "+r"(r0), "+r"(r3),                                        \
+		  "+r"(r4), "+r"(r5)                                         \
+		:: "r6", "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST             \
+	);                                                                   \
+	r3;                                                                  \
+})
+
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)                             \
+({                                                                           \
+	register long r0 __asm__ ("r0") = (num);                             \
+	register long r3 __asm__ ("r3") = (long)(arg1);                      \
+	register long r4 __asm__ ("r4") = (long)(arg2);                      \
+	register long r5 __asm__ ("r5") = (long)(arg3);                      \
+	register long r6 __asm__ ("r6") = (long)(arg4);                      \
+									     \
+	__asm__ volatile (                                                   \
+		"sc; bns+ 1f; neg %1, %1; 1:\n"                              \
+		: "+r"(r0), "+r"(r3),                                        \
+		  "+r"(r4), "+r"(r5), "+r"(r6)                               \
+		:: "r7", "r8", _NOLIBC_SYSCALL_CLOBBERLIST                   \
+	);                                                                   \
+	r3;                                                                  \
+})
+
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                       \
+({                                                                           \
+	register long r0 __asm__ ("r0") = (num);                             \
+	register long r3 __asm__ ("r3") = (long)(arg1);                      \
+	register long r4 __asm__ ("r4") = (long)(arg2);                      \
+	register long r5 __asm__ ("r5") = (long)(arg3);                      \
+	register long r6 __asm__ ("r6") = (long)(arg4);                      \
+	register long r7 __asm__ ("r7") = (long)(arg5);                      \
+									     \
+	__asm__ volatile (                                                   \
+		"sc; bns+ 1f; neg %1, %1; 1:\n"                              \
+		: "+r"(r0), "+r"(r3),                                        \
+		  "+r"(r4), "+r"(r5), "+r"(r6), "+r"(r7)                     \
+		:: "r8", _NOLIBC_SYSCALL_CLOBBERLIST                         \
+	);                                                                   \
+	r3;                                                                  \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                 \
+({                                                                           \
+	register long r0 __asm__ ("r0") = (num);                             \
+	register long r3 __asm__ ("r3") = (long)(arg1);                      \
+	register long r4 __asm__ ("r4") = (long)(arg2);                      \
+	register long r5 __asm__ ("r5") = (long)(arg3);                      \
+	register long r6 __asm__ ("r6") = (long)(arg4);                      \
+	register long r7 __asm__ ("r7") = (long)(arg5);                      \
+	register long r8 __asm__ ("r8") = (long)(arg6);                      \
+									     \
+	__asm__ volatile (                                                   \
+		"sc; bns+ 1f; neg %1, %1; 1:\n"                              \
+		: "+r"(r0), "+r"(r3),                                        \
+		  "+r"(r4), "+r"(r5), "+r"(r6), "+r"(r7), "+r"(r8)           \
+		:: _NOLIBC_SYSCALL_CLOBBERLIST                               \
+	);                                                                   \
+	r3;                                                                  \
+})
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
-- 
2.25.1

