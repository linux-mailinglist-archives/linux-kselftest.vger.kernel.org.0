Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7C07502B7
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGLJTE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjGLJTA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:19:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48BF1998;
        Wed, 12 Jul 2023 02:18:55 -0700 (PDT)
X-QQ-mid: bizesmtp85t1689153526tjyf6k0s
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:18:45 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: zT6n3Y95oi1Q7MFa1CSS57hNQnv1/10jeqfsHZAQQpZlJ7diAVk+VgwixNHdq
        pPfLew8XIjf5N6Y6zQDz0VgwQbg0pOxJBb/7Y9Ns4t1fUKIfnMoL+f+OhNv8jE5PinsTe/+
        6Ob8p8vQ51rivPl6WQQcDxak7bsvxbRn/FzV64sqW7YGjqFKlJfu0iSY89VZ4EYpSizGJer
        xhB2OPJSGLH8ORqD3cO+8BVNxlKeBfqtdHpI/tdsl2NTFx1tnsjZ4NDuFgwKZdPmSOY0YhE
        t+BDN0u+0jKvxQQRtxa6rGKCZOdI1hbC+EFpjK2yF6YW6DWYMOL0flgKqqFQAe4MAyRX6Cw
        ix+dMWsCIoFvThWzd/fk7lpBhbKO9kTk5Saox0V7DiWHElQNs9RRU8A4ZvbexEqFKh42b/7
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11721497453081374856
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 03/11] tools/nolibc: arm: shrink _start with _start_c
Date:   Wed, 12 Jul 2023 17:18:44 +0800
Message-Id: <b06c91904facbcc647f7fce9d8f2eba3a59905d3.1689150149.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-arm.h | 43 +++++----------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index ea723596ed23..74773ddcf4ca 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_ARCH_ARM_H
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for ARM in ARM or Thumb modes :
  *   - registers are 32-bit
@@ -183,49 +184,17 @@
 	_arg1;                                                                \
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
+		"bl __stack_chk_init\n" /* initialize stack protector                     */
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
+		"mov %r0, sp\n"         /* save stack pointer to %r0, as arg1 of _start_c */
+		"and ip, %r0, #-8\n"    /* sp must be 8-byte aligned in the callee        */
+		"mov sp, ip\n"
+		"bl  _start_c\n"        /* transfer to c runtime                          */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

