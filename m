Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B9B74BE3C
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230346AbjGHPfm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjGHPfl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:35:41 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33595B9;
        Sat,  8 Jul 2023 08:35:39 -0700 (PDT)
X-QQ-mid: bizesmtp64t1688830529tddkhgwo
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:35:28 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: SFhf6fKhx/8MNvygIFrN5Ea7ntRZXkmkNIkR/K+V5n83hDBFmZTb/GNM4JKdB
        3pLoKQYJFayAbbQVDEHt1sPPe2SJsrbCY36y7lRh4Z8SAlqSFwoOozouaXGMHwqB0/5sYoT
        09Y2nTr9XT1/GBc2Cp4f/PpRj1/e/QvzYIQBV5RIOvJezSaF7WwEAk+eztGDPlgGS2grtyH
        luGNPXiPr320kjyzVQTrbFhoU5YyYIRduR6fp+OpJ42jTMYk8VCZKH5Ik3tO6hEwyf7E+p4
        oU/J2BPZG3Oc6wclKBPLwKHg3a4Qd5RtL7fGspx1G+d5jv8vyoStsfBE00wE+yoUku4pTX0
        k9lPSI+Np5AaTo31XGYcowaGH///UZRzFCJbSBUwyJv83YVawQzy/0NNwlxqw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5730267673946759822
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 09/12] tools/nolibc: mips/crt.h: shrink _start with _start_c
Date:   Sat,  8 Jul 2023 23:35:28 +0800
Message-Id: <26b030bd7e0d48e60350c1b325dd0668f0caf803.1688828139.git.falcon@tinylab.org>
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

Also clean up the instructions in delay slots.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/mips/crt.h | 42 +++++++--------------------------
 1 file changed, 9 insertions(+), 33 deletions(-)

diff --git a/tools/include/nolibc/mips/crt.h b/tools/include/nolibc/mips/crt.h
index 38df52d8ec16..a49632b64fdd 100644
--- a/tools/include/nolibc/mips/crt.h
+++ b/tools/include/nolibc/mips/crt.h
@@ -11,43 +11,19 @@
 void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
 {
 	__asm__ volatile (
-		/*".set nomips16\n"*/
 		".set push\n"
-		".set    noreorder\n"
+		".set noreorder\n"
 		".option pic0\n"
 #ifdef _NOLIBC_STACKPROTECTOR
-		"jal __stack_chk_init\n" /* initialize stack protector                         */
-		"nop\n"                  /* delayed slot                                       */
+		"jal __stack_chk_init\n" /* initialize stack protector                     */
+		" nop\n"                 /* delayed slot                                   */
 #endif
-		/*".ent __start\n"*/
-		/*"__start:\n"*/
-		"lw $a0,($sp)\n"        /* argc was in the stack                               */
-		"addiu  $a1, $sp, 4\n"  /* argv = sp + 4                                       */
-		"sll $a2, $a0, 2\n"     /* a2 = argc * 4                                       */
-		"add   $a2, $a2, $a1\n" /* envp = argv + 4*argc ...                            */
-		"addiu $a2, $a2, 4\n"   /*        ... + 4                                      */
-		"lui $a3, %hi(environ)\n"     /* load environ into a3 (hi)                     */
-		"addiu $a3, %lo(environ)\n"   /* load environ into a3 (lo)                     */
-		"sw $a2,($a3)\n"              /* store envp(a2) into environ                   */
-
-		"move $t0, $a2\n"             /* iterate t0 over envp, look for NULL           */
-		"0:"                          /* do {                                          */
-		"lw $a3, ($t0)\n"             /*   a3=*(t0);                                   */
-		"bne $a3, $0, 0b\n"           /* } while (a3);                                 */
-		"addiu $t0, $t0, 4\n"         /* delayed slot: t0+=4;                          */
-		"lui $a3, %hi(_auxv)\n"       /* load _auxv into a3 (hi)                       */
-		"addiu $a3, %lo(_auxv)\n"     /* load _auxv into a3 (lo)                       */
-		"sw $t0, ($a3)\n"             /* store t0 into _auxv                           */
-
-		"li $t0, -8\n"
-		"and $sp, $sp, $t0\n"   /* sp must be 8-byte aligned                           */
-		"addiu $sp,$sp,-16\n"   /* the callee expects to save a0..a3 there!            */
-		"jal main\n"            /* main() returns the status code, we'll exit with it. */
-		"nop\n"                 /* delayed slot                                        */
-		"move $a0, $v0\n"       /* retrieve 32-bit exit code from v0                   */
-		"li $v0, 4001\n"        /* NR_exit == 4001                                     */
-		"syscall\n"
-		/*".end __start\n"*/
+		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
+		"li    $t0, -8\n"
+		"and   $sp, $sp, $t0\n"  /* $sp must be 8-byte aligned                     */
+		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
+		"jal   _start_c\n"       /* transfer to c runtime                          */
+		" nop\n"                 /* delayed slot                                   */
 		".set pop\n"
 	);
 	__builtin_unreachable();
-- 
2.25.1

