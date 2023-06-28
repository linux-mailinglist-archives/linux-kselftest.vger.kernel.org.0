Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8462774189E
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 21:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbjF1TGE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 15:06:04 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:51133 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjF1TFt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 15:05:49 -0400
X-QQ-mid: bizesmtp81t1687979140twy3oz5l
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 03:05:38 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: QityeSR92A0ivM8Oe5i1P8PgBPy/0WKQrP/bau1yZUyBIMxZ5v5/nq5XSmhEo
        YaCWksBQ8b9i4Oiy0QKM2HQhJUQxhtH6I0PmpEJH68qNQ2/UUaq1iQcgOX+RFZ7zBKo7g2i
        8fglSXNIJqe1lroojRhULNzSXIilkUv2ECoShgSwtnYMb8eO2nqScTXKGmhyfnDiF9jnlDx
        EoLxIAA7wqjl9DMajcD+s3Rmv+4Agv5M+PyV3e1dbGHOM6kMSvcfKligJTkTbcrf1Q4vzhI
        RHzPS9ot3goSP+6inAJpovN0PDWV+1j5DgDpGx20+T9RNlw8H3wOshH2sdaJnutu92MSj60
        JpBup9/hmlDjscis/Y5N6ZqzwwRTzi7UX5BHcqVDB3wJsLZSWcsAmohQngzAg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17283120326487235982
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 10/11] tools/nolibc: riscv: shrink _start with _start_c
Date:   Thu, 29 Jun 2023 03:04:12 +0800
Message-Id: <4a6e7245c3aa07eb20fd6c6aa43bc663e480e0c5.1687976753.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687976753.git.falcon@tinylab.org>
References: <cover.1687976753.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Let's move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-riscv.h | 42 ++++---------------------------
 1 file changed, 5 insertions(+), 37 deletions(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 7f4abcc15206..ec0f9c597d0b 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -9,18 +9,6 @@
 
 #include "compiler.h"
 
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
 /* Syscalls for RISCV :
  *   - stack is 16-byte aligned
  *   - syscall number is passed in a7
@@ -153,40 +141,20 @@
 	_arg1;									\
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
+		"call __stack_chk_init\n"	/* initialize stack protector			*/
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
+		"mv   a0, sp\n"			/* save stack pointer to a0, as arg1 of _start_c*/
+		"andi sp, a0, -16\n"		/* sp must be 16-byte aligned			*/
+		"call _start_c\n"		/* transfer to c runtime			*/
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

