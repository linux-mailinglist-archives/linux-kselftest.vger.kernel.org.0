Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD5CF7502FB
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjGLJYq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232475AbjGLJYm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:24:42 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508741995;
        Wed, 12 Jul 2023 02:24:21 -0700 (PDT)
X-QQ-mid: bizesmtp74t1689153852t7x4q3lf
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:24:11 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 7jw2iSiCazrYV30tqA3rE/xk9YB446MUEUfOtIQC4wAExzPRDbLzHgqE9b1Zm
        I2p1W+qGWca7sApfHy5SvhFkO0VunsETK7Kh6N1KjRgGEML/roQB+/F3p2X5KQi+yZ6I6pn
        VDhAESpTzlhYjfrbcCTKuk4qQFv7NakQVLs4DfRuKxJh94TpZ7f/Kfze+ix2Xvs3jwywbGh
        f86pV5ZP07NUwLipz5WQ1YsOO/PAZ0TTVe3dRXV30dTX+lpkzmsAHxwlV9K+XTzy7sTPCSm
        wqpSMKNNifEA6EKAOzW318c5AIxixFcA2fUwQcFlp16BhrNTYFL+oUyy85nhbLZ/4ptyTw9
        hPYb/Sy2GUraSshYqx8VlvVnSuSoesUATEcQTFy1SUGVO/JwtkBoFZJkkUM5A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17383144857410459709
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 08/11] tools/nolibc: loongarch: shrink _start with _start_c
Date:   Wed, 12 Jul 2023 17:24:10 +0800
Message-Id: <d2d15e849bbbd554746a2fcd2af4174d20ec2d63.1689150149.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-loongarch.h | 43 ++++-----------------------
 1 file changed, 5 insertions(+), 38 deletions(-)

diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 8aa7724fe38e..9db70d6f2c31 100644
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
 
@@ -171,28 +155,11 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_pr
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"               /* initialize stack protector                          */
+		"bl __stack_chk_init\n"            /* initialize stack protector                     */
 #endif
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


