Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9571C74BE40
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:38:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjGHPiC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:38:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjGHPh4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:37:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCCFB8;
        Sat,  8 Jul 2023 08:37:54 -0700 (PDT)
X-QQ-mid: bizesmtp90t1688830664t3wo1csv
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:37:43 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: ILHsT53NKPhgnsUgVDz2srbYQCVF7irYB8/gpXVXYeOJXG3utdg0qHYBiAiGX
        bhoNiWLXPcmqeL426w5U3+Eaa3MCeWLJ0Zn/Tav1QL3t7wnrGMIqQzmN/aRyzW4ktmt7wfs
        ndhkkHeuMR1R0zevTJ6pefES/orySXRx9B4BPbaZ15g875YxxSmZGQq7VLzo5oh3qvBWgMy
        ICwr0fwm+YuWjr5XHeJ7DPZNU70KUIw+a8l4xM8blSZXyElZBZWzjsc7ISekOnLXct22G50
        6bdFQj1eVNchTz0I5iByAHaFrK5OqS1+kHHYREW+dWAwO0dGlMhUL4WJd23IQpWE5G2jpOU
        /0DqYPgWEZyx/EKtawUeoyaFhUZqfFcl59TNgC35rXC/uQujKuP/gfYc23TbjwsArS07kjC
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2342700909173157500
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 11/12] tools/nolibc: riscv/crt.h: shrink _start with _start_c
Date:   Sat,  8 Jul 2023 23:37:43 +0800
Message-Id: <1b7959f4aa03f6e0c797a891322d1db6f65688d3.1688828139.git.falcon@tinylab.org>
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
 tools/include/nolibc/riscv/crt.h | 39 ++++----------------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/tools/include/nolibc/riscv/crt.h b/tools/include/nolibc/riscv/crt.h
index 1f81a2e47a48..2b8df4c478d5 100644
--- a/tools/include/nolibc/riscv/crt.h
+++ b/tools/include/nolibc/riscv/crt.h
@@ -7,49 +7,20 @@
 #ifndef _NOLIBC_RISCV_CRT_H
 #define _NOLIBC_RISCV_CRT_H
 
-#if   __riscv_xlen == 64
-#define PTRLOG "3"
-#define SZREG  "8"
-#define REG_L  "ld"
-#define REG_S  "sd"
-#elif __riscv_xlen == 32
-#define PTRLOG "2"
-#define SZREG  "4"
-#define REG_L  "lw"
-#define REG_S  "sw"
-#endif
-
 /* startup code */
 void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
 		".option norelax\n"
-		"lla   gp, __global_pointer$\n"
+		"lla  gp, __global_pointer$\n"
 		".option pop\n"
 #ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"    /* initialize stack protector                          */
+		"call __stack_chk_init\n" /* initialize stack protector                    */
 #endif
-		REG_L" a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
-		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
-		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
-		"add   a2, a2, "SZREG"\n"    /*             + SZREG (skip null)                     */
-		"add   a2,a2,a1\n"           /*             + argv                                  */
-
-		"add   a3, a2, zero\n"       /* iterate a3 over envp to find auxv (after NULL)      */
-		"0:\n"                       /* do {                                                */
-		REG_L" a4, 0(a3)\n"          /*   a4 = *a3;                                         */
-		"add   a3, a3, "SZREG"\n"    /*   a3 += sizeof(void*);                              */
-		"bne   a4, zero, 0b\n"       /* } while (a4);                                       */
-		"lui   a4, %hi(_auxv)\n"     /* a4 = &_auxv (high bits)                             */
-		REG_S" a3, %lo(_auxv)(a4)\n" /* store a3 into _auxv                                 */
-
-		"lui   a3, %hi(environ)\n"   /* a3 = &environ (high bits)                           */
-		REG_S" a2,%lo(environ)(a3)\n"/* store envp(a2) into environ                         */
-		"andi  sp,a1,-16\n"          /* sp must be 16-byte aligned                          */
-		"call  main\n"               /* main() returns the status code, we'll exit with it. */
-		"li a7, 93\n"                /* NR_exit == 93                                       */
-		"ecall\n"
+		"mv   a0, sp\n"           /* save stack pointer to a0, as arg1 of _start_c */
+		"andi sp, a0, -16\n"      /* sp must be 16-byte aligned                    */
+		"call _start_c\n"         /* transfer to c runtime                         */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

