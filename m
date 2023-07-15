Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B709B754AB5
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjGOSbZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGOSbZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:31:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A07D1B6;
        Sat, 15 Jul 2023 11:31:22 -0700 (PDT)
X-QQ-mid: bizesmtp72t1689445874tvr47aga
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:31:13 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: D2GZf6M6C/iOJuK1ehyY8lqNdJkrB5J9lu3rL9aR9HRkOz88df4imZA2U7I6G
        0Il34kU2d7bL4oRr/nER1ZJ3nEaIjN3KJI+uPw+tv2VfFzfVDMKLfPeqldu2cxVCJr0wLhR
        olsxbn4a4T8kp0BB60X35yXYfscStOLXqo2cnW78m6PspB3j7WtoJLnjkesU3CF6GJq+As6
        HrC6f0jOTQOzAztT+gOZccyiLWEzFj1U79wR/a1SoyQ8BuWkvNFwWFDLSzt/k/oAgrE48kz
        Q4zgYWKpdatXgGzBM18bfQPETzgxh4gGwIGAu7PSI25ABvcBMj2aGtagBUmTem8MdSK4CTx
        btHlWP07Yv2ukJQpCIbg+yc7hN3cZnaCw6yCvXjFs6R4esUJIe1HExspSHEPQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4600884106439397780
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 13/18] tools/nolibc: riscv: shrink _start with _start_c
Date:   Sun, 16 Jul 2023 02:31:12 +0800
Message-Id: <d243c31d0b57cbaaf8e5be9c1861722c2ecf5810.1689444638.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-riscv.h | 44 ++++---------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index d49f5ecbf815..950cc2283fd7 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -8,18 +8,7 @@
 #define _NOLIBC_ARCH_RISCV_H
 
 #include "compiler.h"
-
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
+#include "crt.h"
 
 /* Syscalls for RISCV :
  *   - stack is 16-byte aligned
@@ -153,40 +142,17 @@
 	_arg1;                                                                \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
 		".option norelax\n"
-		"lla   gp, __global_pointer$\n"
+		"lla  gp, __global_pointer$\n"
 		".option pop\n"
-#ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"    /* initialize stack protector                          */
-#endif
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

