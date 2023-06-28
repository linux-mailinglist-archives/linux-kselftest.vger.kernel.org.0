Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C8F8741232
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjF1NVh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:21:37 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:42078 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229749AbjF1NVf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:21:35 -0400
X-QQ-mid: bizesmtp83t1687958477ta8acygf
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:21:15 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: SehwxFMscw+UHQAFM6Qzy8qMOScisS/QE2BtvFra+u83zr2AABMNeWh7ACuvK
        zRYQe1cvlDyOinxvsvbbdaZ1sr8dW/uzWYAkiEN907iEbLERqULVlBsR/WxDCHwvcidDYb8
        HXDjVsT2rKfxq2a/6i+ksQbXpT1ywVZD70BonHcyXV+i7GBEQB/+LOwKI+iEZ5/JKdVwHa/
        CU2KtfRdKpFJXaQap6pnOBoc5vGpswj5TUVx7280xegIfkKW49U4/0wiSVuGMi984QRFxTP
        8qLNCcr+09I7cIHs4Hrb/XWXBuzhqchPV6PChqupB4pQHKt+cC+MfgFZ3Ej8Ubv7tDM+RKR
        GQCZaxVtZMGS/mQyNFJclyXfwBn6KC7Svk7L7fD2droigKz+49eynbdQR9u2w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11969922623496202983
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 06/14] tools/nolibc: arch-*.h: clean up multiple whitespaces
Date:   Wed, 28 Jun 2023 21:19:33 +0800
Message-Id: <eb4c7a381cf856c9d8e7d679b28507a258cab26a.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To align with Linux code style and let scripts/checkpatch.pl happy, the
multiple whitespaces in arch-<ARCH>.h files are cleaned up.

Most of them are modified by these commands automatically:

    $ sed -i -e '/#define my_syscall/,/})/{s/        /\t/g}' tools/include/nolibc/arch-*.h
    $ sed -i -e '/#define my_syscall/,/})/{s/ *\\$/\t\\/g}' tools/include/nolibc/arch-*.h

And checked with:

    $ grep '  *\\$' tools/include/nolibc/arch-*.h

Besides, more multiple whitespaces are cleaned up:

- convert "__asm__  volatile" to "__asm__ volatile"
- "foo _num  bar" should be "foo _num bar"

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-aarch64.h   | 210 +++++++++++-----------
 tools/include/nolibc/arch-arm.h       | 240 +++++++++++++-------------
 tools/include/nolibc/arch-i386.h      | 226 ++++++++++++------------
 tools/include/nolibc/arch-loongarch.h | 222 ++++++++++++------------
 tools/include/nolibc/arch-mips.h      | 218 +++++++++++------------
 tools/include/nolibc/arch-riscv.h     | 208 +++++++++++-----------
 tools/include/nolibc/arch-s390.h      | 202 +++++++++++-----------
 tools/include/nolibc/arch-x86_64.h    | 222 ++++++++++++------------
 8 files changed, 874 insertions(+), 874 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 11f294a406b7..e30056f996db 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -52,123 +52,123 @@ struct sys_stat_struct {
  */
 #define __ARCH_WANT_SYS_PSELECT6
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	register long _num  __asm__ ("x8") = (num);                           \
-	register long _arg1 __asm__ ("x0");                                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
-		: "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall0(num)							\
+({										\
+	register long _num __asm__ ("x8") = (num);				\
+	register long _arg1 __asm__ ("x0");					\
+										\
+	__asm__ volatile (							\
+		"svc #0\n"							\
+		: "=r"(_arg1)							\
+		: "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	register long _num  __asm__ ("x8") = (num);                           \
-	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
-		: "r"(_arg1),                                                 \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall1(num, arg1)							\
+({										\
+	register long _num __asm__ ("x8")  = (num);				\
+	register long _arg1 __asm__ ("x0") = (long)(arg1);			\
+										\
+	__asm__ volatile (							\
+		"svc #0\n"							\
+		: "=r"(_arg1)							\
+		: "r"(_arg1),							\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	register long _num  __asm__ ("x8") = (num);                           \
-	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
-		: "r"(_arg1), "r"(_arg2),                                     \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall2(num, arg1, arg2)						\
+({										\
+	register long _num __asm__ ("x8")  = (num);				\
+	register long _arg1 __asm__ ("x0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("x1") = (long)(arg2);			\
+										\
+	__asm__ volatile (							\
+		"svc #0\n"							\
+		: "=r"(_arg1)							\
+		: "r"(_arg1), "r"(_arg2),					\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	register long _num  __asm__ ("x8") = (num);                           \
-	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({										\
+	register long _num __asm__ ("x8")  = (num);				\
+	register long _arg1 __asm__ ("x0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("x1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("x2") = (long)(arg3);			\
+										\
+	__asm__ volatile (							\
+		"svc #0\n"							\
+		: "=r"(_arg1)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3),				\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	register long _num  __asm__ ("x8") = (num);                           \
-	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"svc #0\n"                                                    \
-		: "=r"(_arg1)                                                 \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)				\
+({										\
+	register long _num __asm__ ("x8")  = (num);				\
+	register long _arg1 __asm__ ("x0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("x1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("x2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("x3") = (long)(arg4);			\
+										\
+	__asm__ volatile (							\
+		"svc #0\n"							\
+		: "=r"(_arg1)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),		\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	register long _num  __asm__ ("x8") = (num);                           \
-	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
-	register long _arg5 __asm__ ("x4") = (long)(arg5);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"svc #0\n"                                                    \
-		: "=r" (_arg1)                                                \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)				\
+({										\
+	register long _num __asm__ ("x8")  = (num);				\
+	register long _arg1 __asm__ ("x0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("x1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("x2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("x3") = (long)(arg4);			\
+	register long _arg5 __asm__ ("x4") = (long)(arg5);			\
+										\
+	__asm__ volatile (							\
+		"svc #0\n"							\
+		: "=r" (_arg1)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
-({                                                                            \
-	register long _num  __asm__ ("x8") = (num);                           \
-	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("x2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("x3") = (long)(arg4);                    \
-	register long _arg5 __asm__ ("x4") = (long)(arg5);                    \
-	register long _arg6 __asm__ ("x5") = (long)(arg6);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"svc #0\n"                                                    \
-		: "=r" (_arg1)                                                \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "r"(_arg6), "r"(_num)                                       \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)			\
+({										\
+	register long _num __asm__ ("x8")  = (num);				\
+	register long _arg1 __asm__ ("x0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("x1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("x2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("x3") = (long)(arg4);			\
+	register long _arg5 __asm__ ("x4") = (long)(arg5);			\
+	register long _arg6 __asm__ ("x5") = (long)(arg6);			\
+										\
+	__asm__ volatile (							\
+		"svc #0\n"							\
+		: "=r" (_arg1)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_arg6), "r"(_num)						\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
 char **environ __attribute__((weak));
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index ca4c66987497..7a64290fc518 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -86,138 +86,138 @@ struct sys_stat_struct {
 
 #endif /* end THUMB */
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
-	register long _arg1 __asm__ ("r0");                                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		_NOLIBC_THUMB_SET_R7                                          \
-		"svc #0\n"                                                    \
-		_NOLIBC_THUMB_RESTORE_R7                                      \
-		: "=r"(_arg1), "=r"(_num)                                     \
-		: "r"(_arg1),                                                 \
-		  "r"(_num)                                                   \
-		: "memory", "cc", "lr"                                        \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall0(num)							\
+({										\
+	register long _num __asm__ (_NOLIBC_SYSCALL_REG) = (num);		\
+	register long _arg1 __asm__ ("r0");					\
+										\
+	__asm__ volatile (							\
+		_NOLIBC_THUMB_SET_R7						\
+		"svc #0\n"							\
+		_NOLIBC_THUMB_RESTORE_R7					\
+		: "=r"(_arg1), "=r"(_num)					\
+		: "r"(_arg1),							\
+		  "r"(_num)							\
+		: "memory", "cc", "lr"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
-	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		_NOLIBC_THUMB_SET_R7                                          \
-		"svc #0\n"                                                    \
-		_NOLIBC_THUMB_RESTORE_R7                                      \
-		: "=r"(_arg1), "=r" (_num)                                    \
-		: "r"(_arg1),                                                 \
-		  "r"(_num)                                                   \
-		: "memory", "cc", "lr"                                        \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall1(num, arg1)							\
+({										\
+	register long _num __asm__ (_NOLIBC_SYSCALL_REG) = (num);		\
+	register long _arg1 __asm__ ("r0") = (long)(arg1);			\
+										\
+	__asm__ volatile (							\
+		_NOLIBC_THUMB_SET_R7						\
+		"svc #0\n"							\
+		_NOLIBC_THUMB_RESTORE_R7					\
+		: "=r"(_arg1), "=r" (_num)					\
+		: "r"(_arg1),							\
+		  "r"(_num)							\
+		: "memory", "cc", "lr"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
-	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		_NOLIBC_THUMB_SET_R7                                          \
-		"svc #0\n"                                                    \
-		_NOLIBC_THUMB_RESTORE_R7                                      \
-		: "=r"(_arg1), "=r" (_num)                                    \
-		: "r"(_arg1), "r"(_arg2),                                     \
-		  "r"(_num)                                                   \
-		: "memory", "cc", "lr"                                        \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall2(num, arg1, arg2)						\
+({										\
+	register long _num __asm__ (_NOLIBC_SYSCALL_REG) = (num);		\
+	register long _arg1 __asm__ ("r0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("r1") = (long)(arg2);			\
+										\
+	__asm__ volatile (							\
+		_NOLIBC_THUMB_SET_R7						\
+		"svc #0\n"							\
+		_NOLIBC_THUMB_RESTORE_R7					\
+		: "=r"(_arg1), "=r" (_num)					\
+		: "r"(_arg1), "r"(_arg2),					\
+		  "r"(_num)							\
+		: "memory", "cc", "lr"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
-	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		_NOLIBC_THUMB_SET_R7                                          \
-		"svc #0\n"                                                    \
-		_NOLIBC_THUMB_RESTORE_R7                                      \
-		: "=r"(_arg1), "=r" (_num)                                    \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
-		  "r"(_num)                                                   \
-		: "memory", "cc", "lr"                                        \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({										\
+	register long _num __asm__ (_NOLIBC_SYSCALL_REG) = (num);		\
+	register long _arg1 __asm__ ("r0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("r1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("r2") = (long)(arg3);			\
+										\
+	__asm__ volatile (							\
+		_NOLIBC_THUMB_SET_R7						\
+		"svc #0\n"							\
+		_NOLIBC_THUMB_RESTORE_R7					\
+		: "=r"(_arg1), "=r" (_num)					\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3),				\
+		  "r"(_num)							\
+		: "memory", "cc", "lr"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
-	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		_NOLIBC_THUMB_SET_R7                                          \
-		"svc #0\n"                                                    \
-		_NOLIBC_THUMB_RESTORE_R7                                      \
-		: "=r"(_arg1), "=r" (_num)                                    \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
-		  "r"(_num)                                                   \
-		: "memory", "cc", "lr"                                        \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)				\
+({										\
+	register long _num __asm__ (_NOLIBC_SYSCALL_REG) = (num);		\
+	register long _arg1 __asm__ ("r0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("r1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("r2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("r3") = (long)(arg4);			\
+										\
+	__asm__ volatile (							\
+		_NOLIBC_THUMB_SET_R7						\
+		"svc #0\n"							\
+		_NOLIBC_THUMB_RESTORE_R7					\
+		: "=r"(_arg1), "=r" (_num)					\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),		\
+		  "r"(_num)							\
+		: "memory", "cc", "lr"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
-	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
-	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		_NOLIBC_THUMB_SET_R7                                          \
-		"svc #0\n"                                                    \
-		_NOLIBC_THUMB_RESTORE_R7                                      \
-		: "=r"(_arg1), "=r" (_num)                                    \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "r"(_num)                                                   \
-		: "memory", "cc", "lr"                                        \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)				\
+({										\
+	register long _num __asm__ (_NOLIBC_SYSCALL_REG) = (num);		\
+	register long _arg1 __asm__ ("r0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("r1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("r2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("r3") = (long)(arg4);			\
+	register long _arg5 __asm__ ("r4") = (long)(arg5);			\
+										\
+	__asm__ volatile (							\
+		_NOLIBC_THUMB_SET_R7						\
+		"svc #0\n"							\
+		_NOLIBC_THUMB_RESTORE_R7					\
+		: "=r"(_arg1), "=r" (_num)					\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_num)							\
+		: "memory", "cc", "lr"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
-({                                                                            \
-	register long _num  __asm__(_NOLIBC_SYSCALL_REG) = (num);             \
-	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
-	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
-	register long _arg6 __asm__ ("r5") = (long)(arg6);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		_NOLIBC_THUMB_SET_R7                                          \
-		"svc #0\n"                                                    \
-		_NOLIBC_THUMB_RESTORE_R7                                      \
-		: "=r"(_arg1), "=r" (_num)                                    \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "r"(_arg6), "r"(_num)                                       \
-		: "memory", "cc", "lr"                                        \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)			\
+({										\
+	register long _num __asm__ (_NOLIBC_SYSCALL_REG) = (num);		\
+	register long _arg1 __asm__ ("r0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("r1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("r2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("r3") = (long)(arg4);			\
+	register long _arg5 __asm__ ("r4") = (long)(arg5);			\
+	register long _arg6 __asm__ ("r5") = (long)(arg6);			\
+										\
+	__asm__ volatile (							\
+		_NOLIBC_THUMB_SET_R7						\
+		"svc #0\n"							\
+		_NOLIBC_THUMB_RESTORE_R7					\
+		: "=r"(_arg1), "=r" (_num)					\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_arg6), "r"(_num)						\
+		: "memory", "cc", "lr"						\
+	);									\
+	_arg1;									\
 })
 
 
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 3d672d925e9e..c2e75ba91b6b 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -53,131 +53,131 @@ struct sys_stat_struct {
  */
 #define __ARCH_WANT_SYS_OLD_SELECT
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__ ("eax") = (num);                           \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall0(num)							\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("eax") = (num);				\
+										\
+	__asm__ volatile (							\
+		"int $0x80\n"							\
+		: "=a" (_ret)							\
+		: "0"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__ ("eax") = (num);                           \
-	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1),                                                 \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall1(num, arg1)							\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("eax")  = (num);				\
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);			\
+										\
+	__asm__ volatile (							\
+		"int $0x80\n"							\
+		: "=a" (_ret)							\
+		: "r"(_arg1),							\
+		  "0"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__ ("eax") = (num);                           \
-	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1), "r"(_arg2),                                     \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall2(num, arg1, arg2)						\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("eax")  = (num);				\
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);			\
+	register long _arg2 __asm__ ("ecx") = (long)(arg2);			\
+										\
+	__asm__ volatile (							\
+		"int $0x80\n"							\
+		: "=a" (_ret)							\
+		: "r"(_arg1), "r"(_arg2),					\
+		  "0"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__ ("eax") = (num);                           \
-	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
-	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("eax")  = (num);				\
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);			\
+	register long _arg2 __asm__ ("ecx") = (long)(arg2);			\
+	register long _arg3 __asm__ ("edx") = (long)(arg3);			\
+										\
+	__asm__ volatile (							\
+		"int $0x80\n"							\
+		: "=a" (_ret)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3),				\
+		  "0"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__ ("eax") = (num);                           \
-	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
-	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
-	register long _arg4 __asm__ ("esi") = (long)(arg4);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)				\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("eax")  = (num);				\
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);			\
+	register long _arg2 __asm__ ("ecx") = (long)(arg2);			\
+	register long _arg3 __asm__ ("edx") = (long)(arg3);			\
+	register long _arg4 __asm__ ("esi") = (long)(arg4);			\
+										\
+	__asm__ volatile (							\
+		"int $0x80\n"							\
+		: "=a" (_ret)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),		\
+		  "0"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num __asm__ ("eax") = (num);                           \
-	register long _arg1 __asm__ ("ebx") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("ecx") = (long)(arg2);                   \
-	register long _arg3 __asm__ ("edx") = (long)(arg3);                   \
-	register long _arg4 __asm__ ("esi") = (long)(arg4);                   \
-	register long _arg5 __asm__ ("edi") = (long)(arg5);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"int $0x80\n"                                                 \
-		: "=a" (_ret)                                                 \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "0"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)				\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("eax")  = (num);				\
+	register long _arg1 __asm__ ("ebx") = (long)(arg1);			\
+	register long _arg2 __asm__ ("ecx") = (long)(arg2);			\
+	register long _arg3 __asm__ ("edx") = (long)(arg3);			\
+	register long _arg4 __asm__ ("esi") = (long)(arg4);			\
+	register long _arg5 __asm__ ("edi") = (long)(arg5);			\
+										\
+	__asm__ volatile (							\
+		"int $0x80\n"							\
+		: "=a" (_ret)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "0"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)	\
-({								\
-	long _eax  = (long)(num);				\
-	long _arg6 = (long)(arg6); /* Always in memory */	\
-	__asm__ volatile (					\
-		"pushl	%[_arg6]\n\t"				\
-		"pushl	%%ebp\n\t"				\
-		"movl	4(%%esp),%%ebp\n\t"			\
-		"int	$0x80\n\t"				\
-		"popl	%%ebp\n\t"				\
-		"addl	$4,%%esp\n\t"				\
-		: "+a"(_eax)		/* %eax */		\
-		: "b"(arg1),		/* %ebx */		\
-		  "c"(arg2),		/* %ecx */		\
-		  "d"(arg3),		/* %edx */		\
-		  "S"(arg4),		/* %esi */		\
-		  "D"(arg5),		/* %edi */		\
-		  [_arg6]"m"(_arg6)	/* memory */		\
-		: "memory", "cc"				\
-	);							\
-	_eax;							\
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)		\
+({									\
+	long _eax  = (long)(num);					\
+	long _arg6 = (long)(arg6); /* Always in memory */		\
+	__asm__ volatile (						\
+		"pushl	%[_arg6]\n\t"					\
+		"pushl	%%ebp\n\t"					\
+		"movl	4(%%esp),%%ebp\n\t"				\
+		"int	$0x80\n\t"					\
+		"popl	%%ebp\n\t"					\
+		"addl	$4,%%esp\n\t"					\
+		: "+a"(_eax)		/* %eax */			\
+		: "b"(arg1),		/* %ebx */			\
+		  "c"(arg2),		/* %ecx */			\
+		  "d"(arg3),		/* %edx */			\
+		  "S"(arg4),		/* %esi */			\
+		  "D"(arg5),		/* %edi */			\
+		  [_arg6]"m"(_arg6)	/* memory */			\
+		: "memory", "cc"					\
+	);								\
+	_eax;								\
 })
 
 char **environ __attribute__((weak));
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index ad3f266e7093..292d6a58dc87 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -23,129 +23,129 @@
  */
 #define __ARCH_WANT_SYS_PSELECT6
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0");                                   \
-									      \
-	__asm__  volatile (                                                   \
-		"syscall 0\n"                                                 \
-		: "=r"(_arg1)                                                 \
-		: "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall0(num)							\
+({										\
+	register long _num __asm__ ("a7") = (num);				\
+	register long _arg1 __asm__ ("a0");					\
+										\
+	__asm__ volatile (							\
+		"syscall 0\n"							\
+		: "=r"(_arg1)							\
+		: "r"(_num)							\
+		: "memory", "$t0", "$t1", "$t2", "$t3",				\
+		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);		      \
-									      \
-	__asm__  volatile (                                                   \
-		"syscall 0\n"                                                 \
-		: "+r"(_arg1)                                                 \
-		: "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall1(num, arg1)							\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+										\
+	__asm__ volatile (							\
+		"syscall 0\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_num)							\
+		: "memory", "$t0", "$t1", "$t2", "$t3",				\
+		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"syscall 0\n"                                                 \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2),                                                 \
-		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall2(num, arg1, arg2)						\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+										\
+	__asm__ volatile (							\
+		"syscall 0\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2),							\
+		  "r"(_num)							\
+		: "memory", "$t0", "$t1", "$t2", "$t3",				\
+		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"syscall 0\n"                                                 \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2), "r"(_arg3),                                     \
-		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+										\
+	__asm__ volatile (							\
+		"syscall 0\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2), "r"(_arg3),					\
+		  "r"(_num)							\
+		: "memory", "$t0", "$t1", "$t2", "$t3",				\
+		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"syscall 0\n"                                                 \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
-		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)				\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+										\
+	__asm__ volatile (							\
+		"syscall 0\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4),				\
+		  "r"(_num)							\
+		: "memory", "$t0", "$t1", "$t2", "$t3",				\
+		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"syscall 0\n"                                                 \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
-		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)				\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+	register long _arg5 __asm__ ("a4") = (long)(arg5);			\
+										\
+	__asm__ volatile (							\
+		"syscall 0\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),		\
+		  "r"(_num)							\
+		: "memory", "$t0", "$t1", "$t2", "$t3",				\
+		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
-	register long _arg6 __asm__ ("a5") = (long)(arg6);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"syscall 0\n"                                                 \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
-		  "r"(_num)                                                   \
-		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
-		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)			\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+	register long _arg5 __asm__ ("a4") = (long)(arg5);			\
+	register long _arg6 __asm__ ("a5") = (long)(arg6);			\
+										\
+	__asm__ volatile (							\
+		"syscall 0\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6),	\
+		  "r"(_num)							\
+		: "memory", "$t0", "$t1", "$t2", "$t3",				\
+		  "$t4", "$t5", "$t6", "$t7", "$t8"				\
+	);									\
+	_arg1;									\
 })
 
 char **environ __attribute__((weak));
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index db24e0837a39..1fd1eedc12a6 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -57,125 +57,125 @@ struct sys_stat_struct {
  *     don't have to experience issues with register constraints.
  */
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	register long _num __asm__ ("v0") = (num);                            \
-	register long _arg4 __asm__ ("a3");                                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"addiu $sp, $sp, -32\n"                                       \
-		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
-		: "=r"(_num), "=r"(_arg4)                                     \
-		: "r"(_num)                                                   \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
-	);                                                                    \
-	_arg4 ? -_num : _num;                                                 \
+#define my_syscall0(num)							\
+({										\
+	register long _num __asm__ ("v0") = (num);				\
+	register long _arg4 __asm__ ("a3");					\
+										\
+	__asm__ volatile (							\
+		"addiu $sp, $sp, -32\n"						\
+		"syscall\n"							\
+		"addiu $sp, $sp, 32\n"						\
+		: "=r"(_num), "=r"(_arg4)					\
+		: "r"(_num)							\
+		: "memory", "cc", "at", "v1", "hi", "lo",			\
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+	);									\
+	_arg4 ? -_num : _num;							\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	register long _num __asm__ ("v0") = (num);                            \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg4 __asm__ ("a3");                                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"addiu $sp, $sp, -32\n"                                       \
-		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
-		: "=r"(_num), "=r"(_arg4)                                     \
-		: "0"(_num),                                                  \
-		  "r"(_arg1)                                                  \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
-	);                                                                    \
-	_arg4 ? -_num : _num;                                                 \
+#define my_syscall1(num, arg1)							\
+({										\
+	register long _num __asm__ ("v0")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg4 __asm__ ("a3");					\
+										\
+	__asm__ volatile (							\
+		"addiu $sp, $sp, -32\n"						\
+		"syscall\n"							\
+		"addiu $sp, $sp, 32\n"						\
+		: "=r"(_num), "=r"(_arg4)					\
+		: "0"(_num),							\
+		  "r"(_arg1)							\
+		: "memory", "cc", "at", "v1", "hi", "lo",			\
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+	);									\
+	_arg4 ? -_num : _num;							\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	register long _num __asm__ ("v0") = (num);                            \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg4 __asm__ ("a3");                                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"addiu $sp, $sp, -32\n"                                       \
-		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
-		: "=r"(_num), "=r"(_arg4)                                     \
-		: "0"(_num),                                                  \
-		  "r"(_arg1), "r"(_arg2)                                      \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
-	);                                                                    \
-	_arg4 ? -_num : _num;                                                 \
+#define my_syscall2(num, arg1, arg2)						\
+({										\
+	register long _num __asm__ ("v0")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg4 __asm__ ("a3");					\
+										\
+	__asm__ volatile (							\
+		"addiu $sp, $sp, -32\n"						\
+		"syscall\n"							\
+		"addiu $sp, $sp, 32\n"						\
+		: "=r"(_num), "=r"(_arg4)					\
+		: "0"(_num),							\
+		  "r"(_arg1), "r"(_arg2)					\
+		: "memory", "cc", "at", "v1", "hi", "lo",			\
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+	);									\
+	_arg4 ? -_num : _num;							\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	register long _num __asm__ ("v0")  = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3");                                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"addiu $sp, $sp, -32\n"                                       \
-		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
-		: "=r"(_num), "=r"(_arg4)                                     \
-		: "0"(_num),                                                  \
-		  "r"(_arg1), "r"(_arg2), "r"(_arg3)                          \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
-	);                                                                    \
-	_arg4 ? -_num : _num;                                                 \
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({										\
+	register long _num __asm__ ("v0")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3");					\
+										\
+	__asm__ volatile (							\
+		"addiu $sp, $sp, -32\n"						\
+		"syscall\n"							\
+		"addiu $sp, $sp, 32\n"						\
+		: "=r"(_num), "=r"(_arg4)					\
+		: "0"(_num),							\
+		  "r"(_arg1), "r"(_arg2), "r"(_arg3)				\
+		: "memory", "cc", "at", "v1", "hi", "lo",			\
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+	);									\
+	_arg4 ? -_num : _num;							\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	register long _num __asm__ ("v0") = (num);                            \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"addiu $sp, $sp, -32\n"                                       \
-		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
-		: "=r" (_num), "=r"(_arg4)                                    \
-		: "0"(_num),                                                  \
-		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)              \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
-	);                                                                    \
-	_arg4 ? -_num : _num;                                                 \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)				\
+({										\
+	register long _num __asm__ ("v0")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+										\
+	__asm__ volatile (							\
+		"addiu $sp, $sp, -32\n"						\
+		"syscall\n"							\
+		"addiu $sp, $sp, 32\n"						\
+		: "=r" (_num), "=r"(_arg4)					\
+		: "0"(_num),							\
+		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)		\
+		: "memory", "cc", "at", "v1", "hi", "lo",			\
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+	);									\
+	_arg4 ? -_num : _num;							\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	register long _num __asm__ ("v0") = (num);                            \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-	register long _arg5 = (long)(arg5);                                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"addiu $sp, $sp, -32\n"                                       \
-		"sw %7, 16($sp)\n"                                            \
-		"syscall\n  "                                                 \
-		"addiu $sp, $sp, 32\n"                                        \
-		: "=r" (_num), "=r"(_arg4)                                    \
-		: "0"(_num),                                                  \
-		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
-		: "memory", "cc", "at", "v1", "hi", "lo",                     \
-	          "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"  \
-	);                                                                    \
-	_arg4 ? -_num : _num;                                                 \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)				\
+({										\
+	register long _num __asm__ ("v0")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+	register long _arg5 = (long)(arg5);					\
+										\
+	__asm__ volatile (							\
+		"addiu $sp, $sp, -32\n"						\
+		"sw %7, 16($sp)\n"						\
+		"syscall\n  "							\
+		"addiu $sp, $sp, 32\n"						\
+		: "=r" (_num), "=r"(_arg4)					\
+		: "0"(_num),							\
+		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)	\
+		: "memory", "cc", "at", "v1", "hi", "lo",			\
+		  "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"	\
+	);									\
+	_arg4 ? -_num : _num;							\
 })
 
 char **environ __attribute__((weak));
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index a2e8564e66d6..4f21e862b412 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -58,122 +58,122 @@ struct sys_stat_struct {
  */
 #define __ARCH_WANT_SYS_PSELECT6
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0");                                   \
-									      \
-	__asm__  volatile (                                                   \
-		"ecall\n\t"                                                   \
-		: "=r"(_arg1)                                                 \
-		: "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall0(num)							\
+({										\
+	register long _num __asm__ ("a7") = (num);				\
+	register long _arg1 __asm__ ("a0");					\
+										\
+	__asm__ volatile (							\
+		"ecall\n\t"							\
+		: "=r"(_arg1)							\
+		: "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);		      \
-									      \
-	__asm__  volatile (                                                   \
-		"ecall\n"                                                     \
-		: "+r"(_arg1)                                                 \
-		: "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall1(num, arg1)							\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+										\
+	__asm__ volatile (							\
+		"ecall\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"ecall\n"                                                     \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2),                                                 \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall2(num, arg1, arg2)						\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+										\
+	__asm__ volatile (							\
+		"ecall\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2),							\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"ecall\n\t"                                                   \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2), "r"(_arg3),                                     \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+										\
+	__asm__ volatile (							\
+		"ecall\n\t"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2), "r"(_arg3),					\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"ecall\n"                                                     \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)				\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+										\
+	__asm__ volatile (							\
+		"ecall\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4),				\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"ecall\n"                                                     \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)				\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+	register long _arg5 __asm__ ("a4") = (long)(arg5);			\
+										\
+	__asm__ volatile (							\
+		"ecall\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),		\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
-({                                                                            \
-	register long _num  __asm__ ("a7") = (num);                           \
-	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
-	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
-	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
-	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
-	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
-	register long _arg6 __asm__ ("a5") = (long)(arg6);                    \
-									      \
-	__asm__  volatile (                                                   \
-		"ecall\n"                                                     \
-		: "+r"(_arg1)                                                 \
-		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
-		  "r"(_num)                                                   \
-		: "memory", "cc"                                              \
-	);                                                                    \
-	_arg1;                                                                \
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)			\
+({										\
+	register long _num __asm__ ("a7")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+	register long _arg5 __asm__ ("a4") = (long)(arg5);			\
+	register long _arg6 __asm__ ("a5") = (long)(arg6);			\
+										\
+	__asm__ volatile (							\
+		"ecall\n"							\
+		: "+r"(_arg1)							\
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6),	\
+		  "r"(_num)							\
+		: "memory", "cc"						\
+	);									\
+	_arg1;									\
 })
 
 char **environ __attribute__((weak));
diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 516dff5bff8b..8cff5b05e841 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -47,119 +47,119 @@ struct sys_stat_struct {
  *
  */
 
-#define my_syscall0(num)						\
-({									\
-	register long _num __asm__ ("1") = (num);			\
-	register long _rc __asm__ ("2");				\
-									\
-	__asm__  volatile (						\
-		"svc 0\n"						\
-		: "=d"(_rc)						\
-		: "d"(_num)						\
-		: "memory", "cc"					\
-		);							\
-	_rc;								\
+#define my_syscall0(num)							\
+({										\
+	register long _num __asm__ ("1") = (num);				\
+	register long _rc __asm__ ("2");					\
+										\
+	__asm__ volatile (							\
+		"svc 0\n"							\
+		: "=d"(_rc)							\
+		: "d"(_num)							\
+		: "memory", "cc"						\
+		);								\
+	_rc;									\
 })
 
-#define my_syscall1(num, arg1)						\
-({									\
-	register long _num __asm__ ("1") = (num);			\
-	register long _arg1 __asm__ ("2") = (long)(arg1);		\
-									\
-	__asm__  volatile (						\
-		"svc 0\n"						\
-		: "+d"(_arg1)						\
-		: "d"(_num)						\
-		: "memory", "cc"					\
-		);							\
-	_arg1;								\
+#define my_syscall1(num, arg1)							\
+({										\
+	register long _num __asm__ ("1")  = (num);				\
+	register long _arg1 __asm__ ("2") = (long)(arg1);			\
+										\
+	__asm__ volatile (							\
+		"svc 0\n"							\
+		: "+d"(_arg1)							\
+		: "d"(_num)							\
+		: "memory", "cc"						\
+		);								\
+	_arg1;									\
 })
 
-#define my_syscall2(num, arg1, arg2)					\
-({									\
-	register long _num __asm__ ("1") = (num);			\
-	register long _arg1 __asm__ ("2") = (long)(arg1);		\
-	register long _arg2 __asm__ ("3") = (long)(arg2);		\
-									\
-	__asm__  volatile (						\
-		"svc 0\n"						\
-		: "+d"(_arg1)						\
-		: "d"(_arg2), "d"(_num)					\
-		: "memory", "cc"					\
-		);							\
-	_arg1;								\
+#define my_syscall2(num, arg1, arg2)						\
+({										\
+	register long _num __asm__ ("1")  = (num);				\
+	register long _arg1 __asm__ ("2") = (long)(arg1);			\
+	register long _arg2 __asm__ ("3") = (long)(arg2);			\
+										\
+	__asm__ volatile (							\
+		"svc 0\n"							\
+		: "+d"(_arg1)							\
+		: "d"(_arg2), "d"(_num)						\
+		: "memory", "cc"						\
+		);								\
+	_arg1;									\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)				\
-({									\
-	register long _num __asm__ ("1") = (num);			\
-	register long _arg1 __asm__ ("2") = (long)(arg1);		\
-	register long _arg2 __asm__ ("3") = (long)(arg2);		\
-	register long _arg3 __asm__ ("4") = (long)(arg3);		\
-									\
-	__asm__  volatile (						\
-		"svc 0\n"						\
-		: "+d"(_arg1)						\
-		: "d"(_arg2), "d"(_arg3), "d"(_num)			\
-		: "memory", "cc"					\
-		);							\
-	_arg1;								\
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({										\
+	register long _num __asm__ ("1")  = (num);				\
+	register long _arg1 __asm__ ("2") = (long)(arg1);			\
+	register long _arg2 __asm__ ("3") = (long)(arg2);			\
+	register long _arg3 __asm__ ("4") = (long)(arg3);			\
+										\
+	__asm__ volatile (							\
+		"svc 0\n"							\
+		: "+d"(_arg1)							\
+		: "d"(_arg2), "d"(_arg3), "d"(_num)				\
+		: "memory", "cc"						\
+		);								\
+	_arg1;									\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)			\
-({									\
-	register long _num __asm__ ("1") = (num);			\
-	register long _arg1 __asm__ ("2") = (long)(arg1);		\
-	register long _arg2 __asm__ ("3") = (long)(arg2);		\
-	register long _arg3 __asm__ ("4") = (long)(arg3);		\
-	register long _arg4 __asm__ ("5") = (long)(arg4);		\
-									\
-	__asm__  volatile (						\
-		"svc 0\n"						\
-		: "+d"(_arg1)						\
-		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_num)		\
-		: "memory", "cc"					\
-		);							\
-	_arg1;								\
+#define my_syscall4(num, arg1, arg2, arg3, arg4)				\
+({										\
+	register long _num __asm__ ("1")  = (num);				\
+	register long _arg1 __asm__ ("2") = (long)(arg1);			\
+	register long _arg2 __asm__ ("3") = (long)(arg2);			\
+	register long _arg3 __asm__ ("4") = (long)(arg3);			\
+	register long _arg4 __asm__ ("5") = (long)(arg4);			\
+										\
+	__asm__ volatile (							\
+		"svc 0\n"							\
+		: "+d"(_arg1)							\
+		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_num)			\
+		: "memory", "cc"						\
+		);								\
+	_arg1;									\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)			\
-({									\
-	register long _num __asm__ ("1") = (num);			\
-	register long _arg1 __asm__ ("2") = (long)(arg1);		\
-	register long _arg2 __asm__ ("3") = (long)(arg2);		\
-	register long _arg3 __asm__ ("4") = (long)(arg3);		\
-	register long _arg4 __asm__ ("5") = (long)(arg4);		\
-	register long _arg5 __asm__ ("6") = (long)(arg5);		\
-									\
-	__asm__  volatile (						\
-		"svc 0\n"						\
-		: "+d"(_arg1)						\
-		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_arg5),	\
-		  "d"(_num)						\
-		: "memory", "cc"					\
-		);							\
-	_arg1;								\
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)				\
+({										\
+	register long _num __asm__ ("1")  = (num);				\
+	register long _arg1 __asm__ ("2") = (long)(arg1);			\
+	register long _arg2 __asm__ ("3") = (long)(arg2);			\
+	register long _arg3 __asm__ ("4") = (long)(arg3);			\
+	register long _arg4 __asm__ ("5") = (long)(arg4);			\
+	register long _arg5 __asm__ ("6") = (long)(arg5);			\
+										\
+	__asm__ volatile (							\
+		"svc 0\n"							\
+		: "+d"(_arg1)							\
+		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_arg5),		\
+		  "d"(_num)							\
+		: "memory", "cc"						\
+		);								\
+	_arg1;									\
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)		\
-({									\
-	register long _num __asm__ ("1") = (num);			\
-	register long _arg1 __asm__ ("2") = (long)(arg1);		\
-	register long _arg2 __asm__ ("3") = (long)(arg2);		\
-	register long _arg3 __asm__ ("4") = (long)(arg3);		\
-	register long _arg4 __asm__ ("5") = (long)(arg4);		\
-	register long _arg5 __asm__ ("6") = (long)(arg5);		\
-	register long _arg6 __asm__ ("7") = (long)(arg6);		\
-									\
-	__asm__  volatile (						\
-		"svc 0\n"						\
-		: "+d"(_arg1)						\
-		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_arg5),	\
-		  "d"(_arg6), "d"(_num)					\
-		: "memory", "cc"					\
-		);							\
-	_arg1;								\
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)			\
+({										\
+	register long _num __asm__ ("1")  = (num);				\
+	register long _arg1 __asm__ ("2") = (long)(arg1);			\
+	register long _arg2 __asm__ ("3") = (long)(arg2);			\
+	register long _arg3 __asm__ ("4") = (long)(arg3);			\
+	register long _arg4 __asm__ ("5") = (long)(arg4);			\
+	register long _arg5 __asm__ ("6") = (long)(arg5);			\
+	register long _arg6 __asm__ ("7") = (long)(arg6);			\
+										\
+	__asm__ volatile (							\
+		"svc 0\n"							\
+		: "+d"(_arg1)							\
+		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_arg5),		\
+		  "d"(_arg6), "d"(_num)						\
+		: "memory", "cc"						\
+		);								\
+	_arg1;									\
 })
 
 char **environ __attribute__((weak));
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 6fc4d8392742..1dc8b60f5153 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -55,129 +55,129 @@ struct sys_stat_struct {
  *
  */
 
-#define my_syscall0(num)                                                      \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__ ("rax") = (num);                          \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall0(num)							\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("rax") = (num);				\
+										\
+	__asm__ volatile (							\
+		"syscall\n"							\
+		: "=a"(_ret)							\
+		: "0"(_num)							\
+		: "rcx", "r11", "memory", "cc"					\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall1(num, arg1)                                                \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__ ("rax") = (num);                          \
-	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1),                                                 \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall1(num, arg1)							\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("rax")  = (num);				\
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);			\
+										\
+	__asm__ volatile (							\
+		"syscall\n"							\
+		: "=a"(_ret)							\
+		: "r"(_arg1),							\
+		  "0"(_num)							\
+		: "rcx", "r11", "memory", "cc"					\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall2(num, arg1, arg2)                                          \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__ ("rax") = (num);                          \
-	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2),                                     \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall2(num, arg1, arg2)						\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("rax")  = (num);				\
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);			\
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);			\
+										\
+	__asm__ volatile (							\
+		"syscall\n"							\
+		: "=a"(_ret)							\
+		: "r"(_arg1), "r"(_arg2),					\
+		  "0"(_num)							\
+		: "rcx", "r11", "memory", "cc"					\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall3(num, arg1, arg2, arg3)                                    \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__ ("rax") = (num);                          \
-	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
-	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3),                         \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall3(num, arg1, arg2, arg3)					\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("rax")  = (num);				\
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);			\
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);			\
+	register long _arg3 __asm__ ("rdx") = (long)(arg3);			\
+										\
+	__asm__ volatile (							\
+		"syscall\n"							\
+		: "=a"(_ret)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3),				\
+		  "0"(_num)							\
+		: "rcx", "r11", "memory", "cc"					\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__ ("rax") = (num);                          \
-	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
-	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
-	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),             \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall4(num, arg1, arg2, arg3, arg4)				\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("rax")  = (num);				\
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);			\
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);			\
+	register long _arg3 __asm__ ("rdx") = (long)(arg3);			\
+	register long _arg4 __asm__ ("r10") = (long)(arg4);			\
+										\
+	__asm__ volatile (							\
+		"syscall\n"							\
+		: "=a"(_ret)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),		\
+		  "0"(_num)							\
+		: "rcx", "r11", "memory", "cc"					\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__ ("rax") = (num);                          \
-	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
-	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
-	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
-	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "0"(_num)                                                   \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)				\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("rax")  = (num);				\
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);			\
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);			\
+	register long _arg3 __asm__ ("rdx") = (long)(arg3);			\
+	register long _arg4 __asm__ ("r10") = (long)(arg4);			\
+	register long _arg5 __asm__ ("r8")  = (long)(arg5);			\
+										\
+	__asm__ volatile (							\
+		"syscall\n"							\
+		: "=a"(_ret)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "0"(_num)							\
+		: "rcx", "r11", "memory", "cc"					\
+	);									\
+	_ret;									\
 })
 
-#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
-({                                                                            \
-	long _ret;                                                            \
-	register long _num  __asm__ ("rax") = (num);                          \
-	register long _arg1 __asm__ ("rdi") = (long)(arg1);                   \
-	register long _arg2 __asm__ ("rsi") = (long)(arg2);                   \
-	register long _arg3 __asm__ ("rdx") = (long)(arg3);                   \
-	register long _arg4 __asm__ ("r10") = (long)(arg4);                   \
-	register long _arg5 __asm__ ("r8")  = (long)(arg5);                   \
-	register long _arg6 __asm__ ("r9")  = (long)(arg6);                   \
-	                                                                      \
-	__asm__  volatile (                                                   \
-		"syscall\n"                                                   \
-		: "=a"(_ret)                                                  \
-		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
-		  "r"(_arg6), "0"(_num)                                       \
-		: "rcx", "r11", "memory", "cc"                                \
-	);                                                                    \
-	_ret;                                                                 \
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)			\
+({										\
+	long _ret;								\
+	register long _num __asm__ ("rax")  = (num);				\
+	register long _arg1 __asm__ ("rdi") = (long)(arg1);			\
+	register long _arg2 __asm__ ("rsi") = (long)(arg2);			\
+	register long _arg3 __asm__ ("rdx") = (long)(arg3);			\
+	register long _arg4 __asm__ ("r10") = (long)(arg4);			\
+	register long _arg5 __asm__ ("r8")  = (long)(arg5);			\
+	register long _arg6 __asm__ ("r9")  = (long)(arg6);			\
+										\
+	__asm__ volatile (							\
+		"syscall\n"							\
+		: "=a"(_ret)							\
+		: "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_arg6), "0"(_num)						\
+		: "rcx", "r11", "memory", "cc"					\
+	);									\
+	_ret;									\
 })
 
 char **environ __attribute__((weak));
-- 
2.25.1

