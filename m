Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CD1750315
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjGLJ2w (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbjGLJ2u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:28:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1546139;
        Wed, 12 Jul 2023 02:28:48 -0700 (PDT)
X-QQ-mid: bizesmtp64t1689153721th57ji5d
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:22:00 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: ILHsT53NKPjtB6FRZNFER3rcR7JDnPatbvx5VZiH7Ka3nO5WQOLWEFZpPEe8B
        Yg20t6QwyoFCV7b02MyegxMbyGupz2otIOof0G6QMVqebibWpCYSMNtwV2M05N2VPvYciuL
        jF5v/Go5WOVHowGe5VRc1vEC41oiM+YrlHt+5weearunvpqX1+GxfH0v7Syit0E+URdtohu
        9hwfCZcaKT3NdX/a/Ps8iFWFV2qcRE0U7fuz5iTPfe/tlJk3Xw30z1Y2BGkAYdt8EwEnHr+
        1D/z5iJXvKaMQlS54kqs6mjGkWD1h3QFRBbwa6cUKarbLnaykhdxAmgGnkbFZy0WopMoW+8
        apB15xrFXXrVeJf4imx2XhfhUHdkT8KcK0gALHVxGN9UEKsEoDXvi4foD2v5W+1himpDZ7d
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13879264576707349728
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 06/11] tools/nolibc: x86_64: shrink _start with _start_c
Date:   Wed, 12 Jul 2023 17:22:00 +0800
Message-Id: <8bdc96799300a5c5a40320d4f66ad54e97b4b9de.1689150149.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689150149.git.falcon@tinylab.org>
References: <cover.1689150149.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-x86_64.h | 28 +++++++---------------------
 1 file changed, 7 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index e980ca5417d0..0048adf6b11f 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_ARCH_X86_64_H
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for x86_64 :
  *   - registers are 64-bit
@@ -153,9 +154,6 @@
 	_ret;                                                                 \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -167,25 +165,13 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                          */
+		"call __stack_chk_init\n" /* initialize stack protector                      */
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
+		"xor  %ebp, %ebp\n"       /* zero the stack frame                            */
+		"mov  %rsp, %rdi\n"       /* save stack pointer to %rdi, as arg1 of _start_c */
+		"and  $-16, %rsp\n"       /* %rsp must be 16-byte aligned before call        */
+		"call _start_c\n"         /* transfer to c runtime                           */
+		"hlt\n"                   /* ensure it does not return                       */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

