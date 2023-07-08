Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C982274BE3E
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjGHPgy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHPgx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:36:53 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25CFB8;
        Sat,  8 Jul 2023 08:36:50 -0700 (PDT)
X-QQ-mid: bizesmtp86t1688830599tw66g3er
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:36:37 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: W+onFc5Tw4Pe9rZqENKFEXMbSRh7Eb3+Jr9OU9bz39iaWL+qI45aWo7EyeNr5
        vz/B5cB4JSaGvK2qJUl6k2KQNV3MGBN6Uj84RTUkDwdW2jEEp3Hz9lm5A7br7JwDjuZASLD
        wRsVyB6VsMDvRVOGmaOgXLxG1OkaU1/AlC56GNg5PI5O7M45DLBXrPNKO9+Ten5f6DiC6m3
        ivOeaBse7tvOVGGif1d1+qQsGTYRZk93BsQBDX8PoIsojSAXqWy//4mKs0yLQbQ4akgIokO
        ilS870OH4IeIpSYz9UfkjAID068mm54T0k+ga4VCzPvwdu+OHNmA/ISEYEhpnrRJUE65MrI
        VnGwkdNzlRmZ3A2fwhM/CKPln7zQFLwE4SYbElvYflo2nofzwdZEvNnX1s8gMEQdAPH/SGu
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3025394520600983061
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 10/12] tools/nolibc: loongarch/crt.h: shrink _start with _start_c
Date:   Sat,  8 Jul 2023 23:36:33 +0800
Message-Id: <47893d501e6d4ededa233e2596ac32f219480270.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
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

move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/loongarch/crt.h | 39 +++-------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/tools/include/nolibc/loongarch/crt.h b/tools/include/nolibc/loongarch/crt.h
index 253d2fccea1e..00bfc36b0747 100644
--- a/tools/include/nolibc/loongarch/crt.h
+++ b/tools/include/nolibc/loongarch/crt.h
@@ -8,22 +8,8 @@
 #define _NOLIBC_LOONGARCH_CRT_H
 
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
 
@@ -32,28 +18,11 @@ void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_
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


