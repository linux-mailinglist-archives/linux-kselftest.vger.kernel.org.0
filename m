Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE817502F9
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjGLJYM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjGLJX6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:23:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C5519A7;
        Wed, 12 Jul 2023 02:23:36 -0700 (PDT)
X-QQ-mid: bizesmtp81t1689153787ta408fla
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:23:05 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 239gR2IZrlvYgW4Z4Y00+uFld0r6zVlb6HKvXNeighaOY+7tVJQt96XqmH/mk
        sYLWUoLD6gE+zFqzo7zSHQh6qE6Pg6q/MZliaTZ3tN0ZBAQv+Sd25QUu9CkLQqjlzjO4iBL
        AwWjEf4FgSGRtVRSarzqA9PqIsKjX5M2H7TX7DKbz5gVxJ4fqq45DqQWiV/WEOPxODqf2hP
        B+ssXhUMVmgfP64JPBLhYN0L33/lQoM7WRuCpdxOAWUjKue+gDeoNB2XytT/4KPt/JNHbxY
        x9ultFO9qk848rTdoYdz2Ykhx1IywSNwk7mH/Q1vWUQgHtFmoQaZy6v+S7Bd5TdrLiWQVT8
        g9DtCugDJoXSAYyYX+6wTLa3c1zreP5gOxVsqi8Uits20diOA61dS6O2ESgsA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9583563646986004817
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 07/11] tools/nolibc: mips: shrink _start with _start_c
Date:   Wed, 12 Jul 2023 17:23:05 +0800
Message-Id: <d769c0a075b9e13b283ee682213f9a7dd8462f41.1689150149.git.falcon@tinylab.org>
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

Also clean up the instructions in delayed slots.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-mips.h | 46 +++++++-------------------------
 1 file changed, 10 insertions(+), 36 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index ae40d5268793..b1c070c5b24a 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -8,6 +8,7 @@
 #define _NOLIBC_ARCH_MIPS_H
 
 #include "compiler.h"
+#include "crt.h"
 
 /* Syscalls for MIPS ABI O32 :
  *   - WARNING! there's always a delayed slot!
@@ -173,50 +174,23 @@
 	_arg4 ? -_num : _num;                                                 \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code, note that it's called __start on MIPS */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
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

