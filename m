Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BABDD754AA6
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:24:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGOSYl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGOSYl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:24:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47C3126AF;
        Sat, 15 Jul 2023 11:24:39 -0700 (PDT)
X-QQ-mid: bizesmtp66t1689445470tmh7la4l
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:24:29 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: XBN7tc9DADLd+8HjQGb0FOWlOVPqo5Ahl4SrFFvntkNjTbYnk6cZ4spbHoNlE
        oi7hFMRBk9vB/IF5nDv1ubzWujRzBVzSaUAU3tsTlmDlhiEgfrWUeXeCaK7a8NaHGY3oaFv
        HNc/y/DivXfWCkWcezk1+++8WCaUbrICbieLR1R/TbU/p/2geyJUuX3ClF/KKToZKd0x/ub
        c+ILyKS1XwMF8wn2NIoDufokixLCrj5g/9RC+KW1/W1U97MT/j9C/Qcb89cICTlybihlO0b
        JA+MUErYgOOljYQQ0OrgMI6DXToHIF4LRKnd5q2f4BSpmDaYGstKIIaIlIQT1/U/GP9eIGn
        wMQacP38nQH7gRoU8tNhXc3H8jZjo/EJvCOqyKh3fKy6xgduGTMefaGjcCvPg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6138912096365051430
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 07/18] tools/nolibc: arm: shrink _start with _start_c
Date:   Sun, 16 Jul 2023 02:24:29 +0800
Message-Id: <5cdded9a3bd45b035ab25cba1996745d7009f02e.1689444638.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-arm.h | 44 ++++-----------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index a06dad789a22..cae4afa7c1c7 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_ARCH_ARM_H
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for ARM in ARM or Thumb modes :
  *   - registers are 32-bit
@@ -183,49 +184,14 @@
 	_arg1;                                                                \
 })
 
-
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"       /* initialize stack protector                          */
-#endif
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
+		"mov %r0, sp\n"         /* save stack pointer to %r0, as arg1 of _start_c */
+		"and ip, %r0, #-8\n"    /* sp must be 8-byte aligned in the callee        */
+		"mov sp, ip\n"
+		"bl  _start_c\n"        /* transfer to c runtime                          */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

