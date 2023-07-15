Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836BA754AA8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjGOSZr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGOSZr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:25:47 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 823E426AF;
        Sat, 15 Jul 2023 11:25:45 -0700 (PDT)
X-QQ-mid: bizesmtp83t1689445536t51qccr6
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:25:35 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: swyrzWPvyR0SVLPCIEBJ3FmK4mjB4Ruu7LCKEoOO7zFGry7kYeP8QMiknFBUy
        KZ5rwT0Hyd+JTw6yPdX7imxsSinX/whs1WBDcP07QNC57ycIEg+nix3fRUBaGuVIVJ4jFqA
        /860YEgXbfBbMtrbFrWr0fEMqYjttIOIV3qeKA+0lHtvpRo4WAPrJC99Tu8CvAeBHWClF36
        dUt/6EDh6U16Sjf1LVDr/ip4ayxNn6mvdkIVFCz5WyVGRF+YkD9uX8K6CSLmnUj7oTPt1Y+
        G8Sz2ZYMhX8vYmrsvdzk9AD6Ut7KlIBblnbJ2J4hS5K3xZmmxIkcdEbOPuoNrjR3WbzdRpr
        viYBFGyVLaRSqku7CGp8xOqTpnt4P5wAr5Fh5AGH6kmlWi+qIxh9O92zOCDOA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2756831456612781110
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 08/18] tools/nolibc: aarch64: shrink _start with _start_c
Date:   Sun, 16 Jul 2023 02:25:35 +0800
Message-Id: <8fe5cfc24f0782bce1f4e1aac6e13ffbf0e3ece9.1689444638.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-aarch64.h | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 3c0a5f47b3e8..6c33c46848e3 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_ARCH_AARCH64_H
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for AARCH64 :
  *   - registers are 64-bit
@@ -143,33 +144,13 @@
 	_arg1;                                                                \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"   /* initialize stack protector                     */
-#endif
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

