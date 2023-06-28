Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384B1741871
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231452AbjF1S6V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:58:21 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:22828 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbjF1S4a (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:56:30 -0400
X-QQ-mid: bizesmtp66t1687978579tbslkfmx
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 02:56:18 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: CR3LFp2JE4myL95Bwy4YA+PlVj9c4rCxTO0cf3tpSnq4AppLl9rYNCM+pxYWU
        85WwvNW4tuBtdM9saYd8fKHWyVNTzgqBFOQ7Tj573N32L3L1hma3fsXS3oAm9gSuKH5AlVo
        1u5B3rl7TURqs7ZPJv1OvrdgdefC0C2rpabwBjDRYuzh3a9DpjzBIpMdzyxF0JI3wfddcDj
        uUXMsItEirc4c2MVlSNMaqgOIKlKB0UQdoQOlBSNOkT7vrAHYpAloMkgLUBN4kDzl2fJ0FX
        /DCeTcsJQUsNseXiYNiJ1Hf0b47baGzRqIoVb5tN/PKl0Cj8RCn4vMkP7eQHzi7Eu/LXNOU
        PHrAGTFqRGq3xyDEU4qlJPzKdstMgA8zU1cFTjbSr9TWNOl0jg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15633203404087285430
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 04/11] tools/nolibc: arm: shrink _start with _start_c
Date:   Thu, 29 Jun 2023 02:55:48 +0800
Message-Id: <30376b12e786f10ac8735431c35bc629f92a7d32.1687976753.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-arm.h | 42 ++++-----------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index a2ea5756cef2..573f8fe31cee 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -183,49 +183,17 @@
 	_arg1;									\
 })
 
-
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"       /* initialize stack protector                          */
+		"bl __stack_chk_init\n"	/* initialize stack protector			*/
 #endif
-		"pop {%r0}\n"                 /* argc was in the stack                               */
-		"mov %r1, %sp\n"              /* argv = sp                                           */
-
-		"add %r2, %r0, $1\n"          /* envp = (argc + 1) ...                               */
-		"lsl %r2, %r2, $2\n"          /*        * 4        ...                               */
-		"add %r2, %r2, %r1\n"         /*        + argv                                       */
-		"ldr %r3, 1f\n"               /* r3 = &environ (see below)                           */
-		"str %r2, [r3]\n"             /* store envp into environ                             */
-
-		"mov r4, r2\n"                /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"mov r5, r4\n"                /* r5 = r4                                             */
-		"add r4, r4, #4\n"            /* r4 += 4                                             */
-		"ldr r5,[r5]\n"               /* r5 = *r5 = *(r4-4)                                  */
-		"cmp r5, #0\n"                /* and stop at NULL after last env                     */
-		"bne 0b\n"
-		"ldr %r3, 2f\n"               /* r3 = &_auxv (low bits)                              */
-		"str r4, [r3]\n"              /* store r4 into _auxv                                 */
-
-		"mov %r3, $8\n"               /* AAPCS : sp must be 8-byte aligned in the            */
-		"neg %r3, %r3\n"              /*         callee, and bl doesn't push (lr=pc)         */
-		"and %r3, %r3, %r1\n"         /* so we do sp = r1(=sp) & r3(=-8);                    */
-		"mov %sp, %r3\n"
-
-		"bl main\n"                   /* main() returns the status code, we'll exit with it. */
-		"movs r7, $1\n"               /* NR_exit == 1                                        */
-		"svc $0x00\n"
-		".align 2\n"                  /* below are the pointers to a few variables           */
-		"1:\n"
-		".word environ\n"
-		"2:\n"
-		".word _auxv\n"
+		"mov %r0, sp\n"		/* save stack pointer to r0, as arg1 of _start_c*/
+		"and ip, %r0, #-8\n"	/* sp must be 8-byte aligned in the callee	*/
+		"mov sp, ip\n"
+		"bl  _start_c\n"	/* transfer to c runtime			*/
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1


