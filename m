Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A77741880
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 21:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjF1TAn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 15:00:43 -0400
Received: from bg4.exmail.qq.com ([43.154.54.12]:64558 "EHLO bg4.exmail.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232277AbjF1S7E (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:59:04 -0400
X-QQ-mid: bizesmtp78t1687978735t1k8oxv4
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 02:58:53 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: znfcQSa1hKbNtlJaExe6GfPAoc0Ow5+wEWHtPLG7/Q1ge+0ox0JyU9wMZjrJB
        FtypQUSuK8tr3GynT9yFI2sUEDe1ixy87NqzzYo8mCDDjD4dEQp9RNDNmknFPKNEDwCqTTl
        rBh23PghpE0BeEpgR9KmVOl+x6kRiFqrD1NrVUE2gl94i2AKJsaWbJp3ZeZGKvRlk+DQ4Ua
        uOO9ts/jzsDuTn2eozBWxv4Ec183BmS/Dt8SsvwS8U3L/XhRTcoe1D9KbI2yDgvp4zNzmoO
        wqXMiCqMx94azMgzMWL/tOLzm3ucmctRTOQ1QXkNIK3OZP5rMZuFMNFnotyiTvh7b8t7Bx6
        uFwXiRjLkfGw04uw1vIX0ZKUEPWkOUAKqz01NmfaznPq3tpd5uMtTO+IyQZMw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10494488464373133128
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 06/11] tools/nolibc: i386: shrink _start with _start_c
Date:   Thu, 29 Jun 2023 02:58:43 +0800
Message-Id: <27783ab1bed69fd99319aa52e03e204ef1160d74.1687976753.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-i386.h | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 418554435545..b56046f1d0c0 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -154,9 +154,6 @@
 	_eax;								\
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 /*
  * i386 System V ABI mandates:
@@ -168,29 +165,14 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                    */
+		"call __stack_chk_init\n"	/* initialize stack protector				*/
 #endif
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
+		"xor  %ebp, %ebp\n"		/* zero the stack frame					*/
+		"mov  %esp, %eax\n"		/* save stack pointer to eax, as arg1 of _start_c	*/
+		"and  $-16, %esp\n"		/* last pushed argument must be 16-byte aligned		*/
+		"push %eax\n"			/* push arg1 on stack to support plain stack modes too	*/
+		"call _start_c\n"		/* transfer to c runtime				*/
+		"hlt\n"				/* ensure it does not return				*/
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

