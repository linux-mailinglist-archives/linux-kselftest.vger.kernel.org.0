Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62315741876
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 20:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjF1S70 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 14:59:26 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:50950 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbjF1S5s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 14:57:48 -0400
X-QQ-mid: bizesmtp72t1687978659t3keb3dh
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 29 Jun 2023 02:57:38 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: KvvwR/hcPA35iAr8TQYDvxZOkDcgAM3TIY87E/9m40p4dKpVt+fphBTPFnApg
        cm8CqegYIrMMP7buadH2bcEjPZgnbPX4xzvowbn6G1s+64nmmgJaOe9ns+CWK3tXfrlH+cs
        /MjQq3sTuUJ5KDFemeGMQPH4c5BE3EkCn7au7Ro17HXjdLJ3FIkMo5p4R+YpMp4wCF7EGMv
        JaxQCrRYQnno7PmRxBlxC1Q9VJSKY8nwTHVpXkzkHibixC4A2T4aqs6tAIJZ1BNHC91ec0f
        hmkHi0Te9PGaNE4g7qedn3c3t0lD1E0O0BLd5mr1MnbtknEIdnVRCjLsHVEzxmEUSR67QiS
        20y+PWFkCrx46YGTbC6zNW4jIwi1YGYyTROXXfQi5Nvnw3mKqQ=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2412116737021503385
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [PATCH v1 05/11] tools/nolibc: aarch64: shrink _start with _start_c
Date:   Thu, 29 Jun 2023 02:57:23 +0800
Message-Id: <1adc51e395e76ad05e15b5d41b6460a191d10997.1687976753.git.falcon@tinylab.org>
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
 tools/include/nolibc/arch-aarch64.h | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 4a8a6f386865..ef98a751783f 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -143,33 +143,16 @@
 	_arg1;									\
 })
 
-char **environ __attribute__((weak));
-const unsigned long *_auxv __attribute__((weak));
-
 /* startup code */
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"bl __stack_chk_init\n"   /* initialize stack protector                     */
+		"bl __stack_chk_init\n"	/* initialize stack protector			*/
 #endif
-		"ldr x0, [sp]\n"     /* argc (x0) was in the stack                          */
-		"add x1, sp, 8\n"    /* argv (x1) = sp                                      */
-		"lsl x2, x0, 3\n"    /* envp (x2) = 8*argc ...                              */
-		"add x2, x2, 8\n"    /*           + 8 (skip null)                           */
-		"add x2, x2, x1\n"   /*           + argv                                    */
-		"adrp x3, environ\n"          /* x3 = &environ (high bits)                  */
-		"str x2, [x3, #:lo12:environ]\n" /* store envp into environ                 */
-		"mov x4, x2\n"       /* search for auxv (follows NULL after last env)       */
-		"0:\n"
-		"ldr x5, [x4], 8\n"  /* x5 = *x4; x4 += 8                                   */
-		"cbnz x5, 0b\n"      /* and stop at NULL after last env                     */
-		"adrp x3, _auxv\n"   /* x3 = &_auxv (high bits)                             */
-		"str x4, [x3, #:lo12:_auxv]\n" /* store x4 into _auxv                       */
-		"and sp, x1, -16\n"  /* sp must be 16-byte aligned in the callee            */
-		"bl main\n"          /* main() returns the status code, we'll exit with it. */
-		"mov x8, 93\n"       /* NR_exit == 93                                       */
-		"svc #0\n"
+		"mov x0, sp\n"		/* save stack pointer to x0, as arg1 of _start_c*/
+		"and sp, x0, -16\n"	/* sp must be 16-byte aligned in the callee	*/
+		"bl  _start_c\n"	/* transfer to c runtime			*/
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

