Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920777502C1
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjGLJUG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231578AbjGLJUC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:20:02 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C89139;
        Wed, 12 Jul 2023 02:20:00 -0700 (PDT)
X-QQ-mid: bizesmtp75t1689153591t4m7hhbh
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:19:50 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: uGhnJwy6xZIttFNE7Y1G6BS+94JXqZJfIlXFCaabP2xXLECfQZ3BaGBSMm/IR
        NGCzIYlWnLkXTYKMoCzHgVtI1SBTHE9zAuWjLHH9wKFzqJuFZHLCr4fL45h4/YMd5ju4dIZ
        5ABy2E/ms4YpCXYwtpJ+Ri6OwV0W0JZNuRO0p78K1tySDRnhvVYkIerPi5oJ+ZrTErnqtZD
        ldIr8vumsmcR2TGV09ciofi67DbgZjSLpaOSJqhqwD91vpoDD8AQcnJb91AK6VTO/8oOP4v
        a1cXAFizdBzZHVJJASYpRXPQslKbYvozXKwNbq20vudoZncGqCqkdlEVf0EkQmbUbyzYODd
        ECJDStT5M2CNQFnqbjA0OLuScaUJhgbCQPcjyTbZh0MH3OJ7iQFb0giFTpN3w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5769694176344349855
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 04/11] tools/nolibc: aarch64: shrink _start with _start_c
Date:   Wed, 12 Jul 2023 17:19:50 +0800
Message-Id: <cf75d6c666fc7110807516e6fa70f706857ab7b4.1689150149.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-aarch64.h | 26 +++++---------------------
 1 file changed, 5 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 1bf122cd5966..e52fa5a20d71 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_ARCH_AARCH64_H
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for AARCH64 :
  *   - registers are 64-bit
@@ -143,33 +144,16 @@
 	_arg1;                                                                \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"   /* initialize stack protector                     */
+		"bl __stack_chk_init\n" /* initialize stack protector                    */
 #endif
-		"ldr x0, [sp]\n"     /* argc (x0) was in the stack                          */
-		"add x1, sp, 8\n"    /* argv (x1) = sp                                      */
-		"lsl x2, x0, 3\n"    /* envp (x2) = 8*argc ...                              */
-		"add x2, x2, 8\n"    /*           + 8 (skip null)                           */
-		"add x2, x2, x1\n"   /*           + argv                                    */
-		"adrp x3, environ\n"          /* x3 = &environ (high bits)                  */
-		"str x2, [x3, #:lo12:environ]\n" /* store envp into environ                 */
-		"mov x4, x2\n"       /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"ldr x5, [x4], 8\n"  /* x5 = *x4; x4 += 8                                   */
-		"cbnz x5, 0b\n"      /* and stop at NULL after last env                     */
-		"adrp x3, _auxv\n"   /* x3 = &_auxv (high bits)                             */
-		"str x4, [x3, #:lo12:_auxv]\n" /* store x4 into _auxv                       */
-		"and sp, x1, -16\n"  /* sp must be 16-byte aligned in the callee            */
-		"bl main\n"          /* main() returns the status code, we'll exit with it. */
-		"mov x8, 93\n"       /* NR_exit == 93                                       */
-		"svc #0\n"
+		"mov x0, sp\n"          /* save stack pointer to x0, as arg1 of _start_c */
+		"and sp, x0, -16\n"     /* sp must be 16-byte aligned in the callee      */
+		"bl  _start_c\n"        /* transfer to c runtime                         */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

