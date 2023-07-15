Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B45754AAB
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGOS0z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGOS0y (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:26:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D77A1B6;
        Sat, 15 Jul 2023 11:26:52 -0700 (PDT)
X-QQ-mid: bizesmtp82t1689445603tsgi0gsl
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:26:42 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: qOAV9bwDT/kSqlse5e4lug4VHat/aabuEX5Xe9QzvVHXgMbvO7tddyAjjH/68
        xTd05Ua+5kRzIU5qS1j5MKyAqWhZyjT91W5Oi6Bmglyi5TVZajNBXqoYE/oDVBrueWFhwz7
        WMmg8VfRnNbuOfHL5euQK/qBWuOCcOKUEizedUGzSr795imKLa69WK2Wlx6gLhqllep1ALC
        iOlC5LPc8IjWcCrdAvX0M3Jcryn00W04sAN04OWwN2Bv0DC/aUns7qmZvcyjbgJJQ5SFLko
        9DCcTYm/Fj7VatdK1Aqi8fnm3SPUhp/Ze4x8Hq2vJXBF8eUrFVql7n5ja1/V/f62aPvSIhr
        7ZpmSgWV0UxpglS68tAFjWNsHsEpkFSdxtEpx6yHUG0tkLZ5RJ7KYCYUtzMNg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1089036118975101126
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 09/18] tools/nolibc: i386: shrink _start with _start_c
Date:   Sun, 16 Jul 2023 02:26:42 +0800
Message-Id: <d8e0da4a25e9f9d0fd234cd00de9b787e233f250.1689444638.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-i386.h | 34 +++++++-------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index fe0b73f032c3..64415b9fac77 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_ARCH_I386_H
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for i386 :
  *   - mostly similar to x86_64
@@ -154,9 +155,6 @@
 	_eax;							\
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -167,30 +165,12 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                    */
-#endif
-		"pop %eax\n"                /* argc   (first arg, %eax)                      */
-		"mov %esp, %ebx\n"          /* argv[] (second arg, %ebx)                     */
-		"lea 4(%ebx,%eax,4),%ecx\n" /* then a NULL then envp (third arg, %ecx)       */
-		"mov %ecx, environ\n"       /* save environ                                  */
-		"xor %ebp, %ebp\n"          /* zero the stack frame                          */
-		"mov %ecx, %edx\n"          /* search for auxv (follows NULL after last env) */
-		"0:\n"
-		"add $4, %edx\n"            /* search for auxv using edx, it follows the     */
-		"cmp -4(%edx), %ebp\n"      /* ... NULL after last env (ebp is zero here)    */
-		"jnz 0b\n"
-		"mov %edx, _auxv\n"         /* save it into _auxv                            */
-		"and $-16, %esp\n"          /* x86 ABI : esp must be 16-byte aligned before  */
-		"sub $4, %esp\n"            /* the call instruction (args are aligned)       */
-		"push %ecx\n"               /* push all registers on the stack so that we    */
-		"push %ebx\n"               /* support both regparm and plain stack modes    */
-		"push %eax\n"
-		"call main\n"               /* main() returns the status code in %eax        */
-		"mov %eax, %ebx\n"          /* retrieve exit code (32-bit int)               */
-		"movl $1, %eax\n"           /* NR_exit == 1                                  */
-		"int $0x80\n"               /* exit now                                      */
-		"hlt\n"                     /* ensure it does not                            */
+		"xor  %ebp, %ebp\n"       /* zero the stack frame                                */
+		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c     */
+		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned        */
+		"push %eax\n"             /* push arg1 on stack to support plain stack modes too */
+		"call _start_c\n"         /* transfer to c runtime                               */
+		"hlt\n"                   /* ensure it does not return                           */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

