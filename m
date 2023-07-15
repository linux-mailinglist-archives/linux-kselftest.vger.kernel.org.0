Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6F0754AAE
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjGOS2C (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjGOS2A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:28:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF80F1B6;
        Sat, 15 Jul 2023 11:27:58 -0700 (PDT)
X-QQ-mid: bizesmtp73t1689445670tnf9mugr
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:27:49 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: tB2bQ4otxw0mXiN/0bzMGk5SK8lnpxJLlWDnpOCFWjqq9NHVt1hoTOYTRsVDa
        B7K7JtHYkKM/27cruda3LF6r/VgHxf/IyAlEZFBbHjbXkfnXDArngcd+7PbRcOMfb9aSsC4
        FxzF4pgQ14uFgPs35gIJLL3KnnRiw0osyvKJ8QBlbsFAT1XGQ2qsIuQVEBAqyI6LuUJwBUc
        /xlEXTc6GK/Cg9uNDdiEqR+RIb5H/BLoId0iAnkzM2B/CFQok+4YDrX5mtBqEez9mvDQkiX
        CBEYYajq9/Lnp1/+1APvjMnZ3l6ue8s2C0bosl90yqddAv0eZ+cWWGYqJU7M6frSI7mtW92
        fyMZb46mOVmFYVIPSg3/ohPg+a9nggYSmQh4hVGOgR4Q1B5CK/1te456RU45g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 370488260156682455
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 10/18] tools/nolibc: x86_64: shrink _start with _start_c
Date:   Sun, 16 Jul 2023 02:27:49 +0800
Message-Id: <9f3ad3ebbad1b939825cbc6f0c87b4d327b70469.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

move most of the _start operations to _start_c(), include the
stackprotector initialization.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-x86_64.h | 29 ++++++-----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 6b494ca471ef..e5ccb926c903 100644
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
@@ -166,26 +164,11 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                          */
-#endif
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

