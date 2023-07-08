Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E43D74BE34
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjGHPbR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGHPbQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:31:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E890;
        Sat,  8 Jul 2023 08:31:15 -0700 (PDT)
X-QQ-mid: bizesmtp86t1688830265t9d8l2g9
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:31:03 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: eEaWPhs2DhvhZjsqAkJMMlzDeo2Sh5soRzY51O43vfpZnHRFckDc/KC+Whroj
        xugcXLSy7ICVFoiqSeTqCxTxDobCGlqVytmjm0QCDA4tguduQfJzEfDRcxmIlotOOEJXxoc
        Szs+owZ8ZdluFmUsrVqHiJdJRNXczXWNaeeYPWWWTKlBKPSwP4H3fmn6kDuV7Jgf7IhvcyF
        Y8jIw9/qDAPT3SPiuBrsnURgvLq+VWA9y/xT93260LoCPfi+IHVypNKboYor7z24/ElvVLv
        p5L1kmZJ/ainACsUtabnDfg1JQfM14itwmu6i6doAuz2mSNSJfH/hiigypC77vcvFbn4tFc
        DiYkkoHr/ovqEbIBaEx5pATYUoVOXFT9LNZQ7ULn54b9FrgnXEpUdehQ8s64qqtJLxkPGgf
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5492700503261273189
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 05/12] tools/nolibc: arm/crt.h: shrink _start with _start_c
Date:   Sat,  8 Jul 2023 23:31:03 +0800
Message-Id: <3b38249bfc9d36db3f33e44b42d34740b9de100a.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arm/crt.h | 38 +++++-----------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/tools/include/nolibc/arm/crt.h b/tools/include/nolibc/arm/crt.h
index 7b3b9e21e5c4..75c097027a80 100644
--- a/tools/include/nolibc/arm/crt.h
+++ b/tools/include/nolibc/arm/crt.h
@@ -12,40 +12,12 @@ void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_
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

