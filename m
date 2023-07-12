Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64AAF7502FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Jul 2023 11:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbjGLJZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Jul 2023 05:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjGLJZ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Jul 2023 05:25:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6199E11D;
        Wed, 12 Jul 2023 02:25:27 -0700 (PDT)
X-QQ-mid: bizesmtp88t1689153918teu0uwlk
Received: from linux-lab-host.localdomain ( [116.30.126.249])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 12 Jul 2023 17:25:16 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 239gR2IZrltKqPhg8ID3o5Pz4jyanvYhDcSzbwRy7HgWu927QkXaP4ef5OeRN
        qtA9Ik35h1ELNf5DWNXSj7UaPkRlJGClZXDclFLxWUvN7KYVyo83R+DOFY7E3AdM+TNayuy
        SaxbUW6yO0YCJcRelPEYJCsdW/6qQAEJCIgLIaG6+H7toJ8VV2DoHLkZKcG9NduG5oRIISv
        KcHn7LkesJ/IKzGbXcvQx3e2SJCFID2ajOR9LQOrwlLP3+LFuGka6gfsl8fE/wSaNB3kQuW
        6F8sNOemZ2blYajmIvx7sSPXS8XShYwFwvHJbF14LQKNzJqisl7xnvJTpihGc/VfsVCkDxi
        kQQHgX4gJ/qH+IxomMFe677EKQIx7GjPvFkKvIF1HyBv1/q3lXej7b6FudZP7TvpdOVejS9
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 86389509092924257
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v3 09/11] tools/nolibc: riscv: shrink _start with _start_c
Date:   Wed, 12 Jul 2023 17:25:15 +0800
Message-Id: <29559df55935d61e7ca774bb36fa3c73e2011090.1689150149.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-riscv.h | 43 +++++--------------------------
 1 file changed, 6 insertions(+), 37 deletions(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 2b89ea59c5e4..2e3fcf925ae9 100644
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
@@ -153,40 +142,20 @@
 	_arg1;                                                                \
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
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

