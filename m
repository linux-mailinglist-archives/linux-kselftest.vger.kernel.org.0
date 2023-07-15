Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA728754AB3
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGOSaT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGOSaS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:30:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D75AF1B6;
        Sat, 15 Jul 2023 11:30:16 -0700 (PDT)
X-QQ-mid: bizesmtp71t1689445807thyjdi8x
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:30:06 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: jXjag1m6xl5hbKADKfFI+Ze4/oDA7vadapGQ3Gd5tlk2Y2xyyaOcC2vX9MLLt
        M98Kzt+1gJYyaUOttYeMP8Ad6NpIRQtXcjBjKB3MQAcQ57/F+NAybSMgyqWqToXw/tnspYB
        qybvZZzsObs5I5+wqER/YYTaJzKBF5xW8/5JV0u9ruaWmBO7JNuHlPFsWC0quHZ16c8lC0M
        48z1psgOzMPo9JRG6wI55/Ph+1V/ykP3KCYZ5pEkv5QeotEVYwQwb8+pe8OJqv1j8xoBK/1
        jb5UQn3XwRRuSZUJuxhDg7jp9W/f+tm+Kb7ulvFb8RyWtCTUJcVsN9NT3T/YV52lYJP7Y5v
        rMgld/CG1hlWnDbffCZRHpYC75QKHGXeCk8Jh6W/8cAlTizyWyZIc6M9SZyikp/FCXpoNFF
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6242663990711852581
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 12/18] tools/nolibc: loongarch: shrink _start with _start_c
Date:   Sun, 16 Jul 2023 02:30:02 +0800
Message-Id: <774441edc010cc55f11546635dc04fc5604dc29a.1689444638.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-loongarch.h | 44 +++------------------------
 1 file changed, 4 insertions(+), 40 deletions(-)

diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 590155a4e543..bf98f6220195 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_ARCH_LOONGARCH_H
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for LoongArch :
  *   - stack is 16-byte aligned
@@ -143,26 +144,9 @@
 	_arg1;                                                                \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 #if __loongarch_grlen == 32
-#define LONGLOG      "2"
-#define SZREG        "4"
-#define REG_L        "ld.w"
-#define LONG_S       "st.w"
-#define LONG_ADD     "add.w"
-#define LONG_ADDI    "addi.w"
-#define LONG_SLL     "slli.w"
 #define LONG_BSTRINS "bstrins.w"
 #else /* __loongarch_grlen == 64 */
-#define LONGLOG      "3"
-#define SZREG        "8"
-#define REG_L        "ld.d"
-#define LONG_S       "st.d"
-#define LONG_ADD     "add.d"
-#define LONG_ADDI    "addi.d"
-#define LONG_SLL     "slli.d"
 #define LONG_BSTRINS "bstrins.d"
 #endif
 
@@ -170,29 +154,9 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
-#ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"               /* initialize stack protector                          */
-#endif
-		REG_L        " $a0, $sp, 0\n"         /* argc (a0) was in the stack                          */
-		LONG_ADDI    " $a1, $sp, "SZREG"\n"   /* argv (a1) = sp + SZREG                              */
-		LONG_SLL     " $a2, $a0, "LONGLOG"\n" /* envp (a2) = SZREG*argc ...                          */
-		LONG_ADDI    " $a2, $a2, "SZREG"\n"   /*             + SZREG (skip null)                     */
-		LONG_ADD     " $a2, $a2, $a1\n"       /*             + argv                                  */
-
-		"move          $a3, $a2\n"            /* iterate a3 over envp to find auxv (after NULL)      */
-		"0:\n"                                /* do {                                                */
-		REG_L        " $a4, $a3, 0\n"         /*   a4 = *a3;                                         */
-		LONG_ADDI    " $a3, $a3, "SZREG"\n"   /*   a3 += sizeof(void*);                              */
-		"bne           $a4, $zero, 0b\n"      /* } while (a4);                                       */
-		"la.pcrel      $a4, _auxv\n"          /* a4 = &_auxv                                         */
-		LONG_S       " $a3, $a4, 0\n"         /* store a3 into _auxv                                 */
-
-		"la.pcrel      $a3, environ\n"        /* a3 = &environ                                       */
-		LONG_S       " $a2, $a3, 0\n"         /* store envp(a2) into environ                         */
-		LONG_BSTRINS " $sp, $zero, 3, 0\n"    /* sp must be 16-byte aligned                          */
-		"bl            main\n"                /* main() returns the status code, we'll exit with it. */
-		"li.w          $a7, 93\n"             /* NR_exit == 93                                       */
-		"syscall       0\n"
+		"move          $a0, $sp\n"         /* save stack pointer to $a0, as arg1 of _start_c */
+		LONG_BSTRINS " $sp, $zero, 3, 0\n" /* $sp must be 16-byte aligned                    */
+		"bl            _start_c\n"         /* transfer to c runtime                          */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

