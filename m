Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2ED37412B2
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbjF1Nj3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:39:29 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:56764 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbjF1NjG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:39:06 -0400
X-QQ-mid: bizesmtp90t1687959532t6lkbz99
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:38:51 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: fs34Pe/+C2TAGmtvIl5731SN/JR7nW+oSFpCdSEQM3tivCtSYm/L9iQc51+aB
        fFcDYWodV80KzFgfamh05BQPEi0waHVAGyQiVMNLMa1rIAVmeVPDPtO7Eoe2crDK6Y+JrN7
        YI2BR8ZJJ/OrR51LISkScVCLzQimPHH6lS1UQ6PmupxN36ALbS0Es94sQxIQkfTwXi/bZ71
        vK2Mjm0lDlH4e+0ZZ3ziXmrJWYMQVaID7H7YfDo8CNV16ZgS7DK9agY9ko+mAfrnarNWXL9
        R9JWH0xCpka5uVIONnzNQ34wSXwuYb4MuezRmTqiVP6tiU71EMPPW69JSS3Mj6qEewKrpnX
        y+FCe82Q5XKBHlcNHADgnFUfRDW1jBA+E7H0cWXQqKITa1lkmg2tV6dh8F3zw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 618334748572230207
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 09/14] tools/nolibc: add missing my_syscall6() for mips
Date:   Wed, 28 Jun 2023 21:37:29 +0800
Message-Id: <5089ddd75a7cb01486f664c025876c803fe26d5b.1687957589.git.falcon@tinylab.org>
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

It is able to pass the 6th argument like the 5th argument via the stack
for mips, let's add a new my_syscall6() now, see [1] for details:

  The mips/o32 system call convention passes arguments 5 through 8 on
  the user stack.

Both mmap() and pselect6() require my_syscall6().

[1]: https://man7.org/linux/man-pages/man2/syscall.2.html

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-mips.h | 25 +++++++++++++++++++++++++
 tools/include/nolibc/nolibc.h    |  9 ++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 55a9f01825e0..a8b33d6914a4 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -176,6 +176,31 @@ struct sys_stat_struct {
 	_arg4 ? -_num : _num;							\
 })
 
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)			\
+({										\
+	register long _num __asm__ ("v0")  = (num);				\
+	register long _arg1 __asm__ ("a0") = (long)(arg1);			\
+	register long _arg2 __asm__ ("a1") = (long)(arg2);			\
+	register long _arg3 __asm__ ("a2") = (long)(arg3);			\
+	register long _arg4 __asm__ ("a3") = (long)(arg4);			\
+	register long _arg5 = (long)(arg5);					\
+	register long _arg6 = (long)(arg6);					\
+										\
+	__asm__ volatile (							\
+		"addiu $sp, $sp, -32\n"						\
+		"sw %7, 16($sp)\n"						\
+		"sw %8, 20($sp)\n"						\
+		"syscall\n  "							\
+		"addiu $sp, $sp, 32\n"						\
+		: "=r" (_num), "=r"(_arg4)					\
+		: "0"(_num),							\
+		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),	\
+		  "r"(_arg6)							\
+		: SYSCALL_CLOBBERLIST						\
+	);									\
+	_arg4 ? -_num : _num;							\
+})
+
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 05a228a6ee78..1f8d821000ac 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -13,11 +13,10 @@
  * Syscalls are split into 3 levels:
  *   - The lower level is the arch-specific syscall() definition, consisting in
  *     assembly code in compound expressions. These are called my_syscall0() to
- *     my_syscall6() depending on the number of arguments. The MIPS
- *     implementation is limited to 5 arguments. All input arguments are cast
- *     to a long stored in a register. These expressions always return the
- *     syscall's return value as a signed long value which is often either a
- *     pointer or the negated errno value.
+ *     my_syscall6() depending on the number of arguments. All input arguments
+ *     are castto a long stored in a register. These expressions always return
+ *     the syscall's return value as a signed long value which is often either
+ *     a pointer or the negated errno value.
  *
  *   - The second level is mostly architecture-independent. It is made of
  *     static functions called sys_<name>() which rely on my_syscallN()
-- 
2.25.1

