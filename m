Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5751574187E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjF1TBS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 15:01:18 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:35030 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232772AbjF1TAU (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 15:00:20 -0400
X-QQ-mid: bizesmtp86t1687978810tf2ar9vw
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 03:00:08 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: +ynUkgUhZJneCqf/WiFIlQeErW4hE9O+nEPddl2PRkjGlBZEniPrcbaTTc7s2
        5f7+aA6vYP9PgLSC4T+j0tcUHwDVAnq8K7wx2MCiGSfUIbExALiKcxf1iKlDVqafqQCqd7u
        w6L2PnJbHsPLcw/lQuF2hvLgUlEij/5DAIfSAqE1oRd1Y5ZtWZoW+kxKtrEEg616wwLLjoF
        3yRqaVk1PLD1I42O+doEPlLna5UF0Ob/6v7p7L7gjJVYrJVWrIr8SAIrcz/RsiRD27lBnl5
        TElxw/lGgBlRGo6OFU0/aBHG2qDnPSoZHBD6UI8D2fq8Cje2g2Dm5BiBWqCmJr2l+N/eX6q
        xVeXxjtbPRXqoMegPcU9CcfyiG5e0xQGVdKth5kBBUlzsUSr6bbfGY2eD8fsg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10657381781421926358
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 07/11] tools/nolibc: x86_64: shrink _start with _start_c
Date:   Thu, 29 Jun 2023 02:59:59 +0800
Message-Id: <e041d383165f05b964c9b1ce7e5aeb5d0a3a1e09.1687976753.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687976753.git.falcon@tinylab.org>
References: <cover.1687976753.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-x86_64.h | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 4c0192815a59..116dcd8e1413 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -153,9 +153,6 @@
 	_ret;									\
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -167,25 +164,13 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                          */
+		"call __stack_chk_init\n"	/* initialize stack protector				*/
 #endif
-		"pop %rdi\n"                /* argc   (first arg, %rdi)                            */
-		"mov %rsp, %rsi\n"          /* argv[] (second arg, %rsi)                           */
-		"lea 8(%rsi,%rdi,8),%rdx\n" /* then a NULL then envp (third arg, %rdx)             */
-		"mov %rdx, environ\n"       /* save environ                                        */
-		"xor %ebp, %ebp\n"          /* zero the stack frame                                */
-		"mov %rdx, %rax\n"          /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"add $8, %rax\n"            /* search for auxv using rax, it follows the           */
-		"cmp -8(%rax), %rbp\n"      /* ... NULL after last env (rbp is zero here)          */
-		"jnz 0b\n"
-		"mov %rax, _auxv\n"         /* save it into _auxv                                  */
-		"and $-16, %rsp\n"          /* x86 ABI : esp must be 16-byte aligned before call   */
-		"call main\n"               /* main() returns the status code, we'll exit with it. */
-		"mov %eax, %edi\n"          /* retrieve exit code (32 bit)                         */
-		"mov $60, %eax\n"           /* NR_exit == 60                                       */
-		"syscall\n"                 /* really exit                                         */
-		"hlt\n"                     /* ensure it does not return                           */
+		"xor  %ebp, %ebp\n"		/* zero the stack frame					*/
+		"mov  %rsp, %rdi\n"		/* save stack pointer to rdi, as arg1 of _start_c	*/
+		"and  $-16, %rsp\n"		/* rsp must be 16-byte aligned before call		*/
+		"call _start_c\n"		/* transfer to c runtime				*/
+		"hlt\n"				/* ensure it does not return				*/
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

