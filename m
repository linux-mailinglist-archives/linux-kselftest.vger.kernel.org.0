Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEC3B6DA505
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjDFVzb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbjDFVzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:55:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDCFAD1F;
        Thu,  6 Apr 2023 14:54:59 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818094;
        bh=Qe8nJyPjBlgmIx599eDy96a3x+QpMDsnrKcc0Qv66Ts=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ATnC3jHsaUStckaLysEVMZrrbG0rnq87drAcNeh9DF9hkWl+2+XhjIk81Tgkc0H0O
         jpuImOwKvA22HpAMPFLYvAPoQiYNLKdVV3ReUc1DSNTIHGVW6L1rmkuHjvHO4bapBu
         8c4G35FzuM9YqekvgqcN71MVcj9d0AYzzvidyZOs=
Date:   Thu, 06 Apr 2023 21:54:54 +0000
Subject: [PATCH v2 08/11] tools/nolibc: mips: use C89 comment syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-8-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=4214;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Qe8nJyPjBlgmIx599eDy96a3x+QpMDsnrKcc0Qv66Ts=;
 b=idk4i0dx9aQMIIIuqV3T2Pxpyz4qWL8BNHt3AQEwQ6WUS0osDqTsirey4HbMn872g968Y+d9Z
 XUYG17J9e1JD8u+XPccmRLVAM9vp9dj3SWfkh5uBk0g2Kzgq/uOQaUI
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most of nolibc is already using C89 comments.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-mips.h | 56 ++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index bf83432d23ed..8822f150e72f 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -183,42 +183,42 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __start(void)
 {
 	__asm__ volatile (
-		//".set nomips16\n"
+		/*".set nomips16\n"*/
 		".set push\n"
 		".set    noreorder\n"
 		".option pic0\n"
-		//".ent __start\n"
-		//"__start:\n"
-		"lw $a0,($sp)\n"        // argc was in the stack
-		"addiu  $a1, $sp, 4\n"  // argv = sp + 4
-		"sll $a2, $a0, 2\n"     // a2 = argc * 4
-		"add   $a2, $a2, $a1\n" // envp = argv + 4*argc ...
-		"addiu $a2, $a2, 4\n"   //        ... + 4
-		"lui $a3, %hi(environ)\n"     // load environ into a3 (hi)
-		"addiu $a3, %lo(environ)\n"   // load environ into a3 (lo)
-		"sw $a2,($a3)\n"              // store envp(a2) into environ
-
-		"move $t0, $a2\n"             // iterate t0 over envp, look for NULL
-		"0:"                          // do {
-		"lw $a3, ($t0)\n"             //   a3=*(t0);
-		"bne $a3, $0, 0b\n"           // } while (a3);
-		"addiu $t0, $t0, 4\n"         // delayed slot: t0+=4;
-		"lui $a3, %hi(_auxv)\n"       // load _auxv into a3 (hi)
-		"addiu $a3, %lo(_auxv)\n"     // load _auxv into a3 (lo)
-		"sw $t0, ($a3)\n"             // store t0 into _auxv
+		/*".ent __start\n"*/
+		/*"__start:\n"*/
+		"lw $a0,($sp)\n"        /* argc was in the stack                               */
+		"addiu  $a1, $sp, 4\n"  /* argv = sp + 4                                       */
+		"sll $a2, $a0, 2\n"     /* a2 = argc * 4                                       */
+		"add   $a2, $a2, $a1\n" /* envp = argv + 4*argc ...                            */
+		"addiu $a2, $a2, 4\n"   /*        ... + 4                                      */
+		"lui $a3, %hi(environ)\n"     /* load environ into a3 (hi)                     */
+		"addiu $a3, %lo(environ)\n"   /* load environ into a3 (lo)                     */
+		"sw $a2,($a3)\n"              /* store envp(a2) into environ                   */
+
+		"move $t0, $a2\n"             /* iterate t0 over envp, look for NULL           */
+		"0:"                          /* do {                                          */
+		"lw $a3, ($t0)\n"             /*   a3=*(t0);                                   */
+		"bne $a3, $0, 0b\n"           /* } while (a3);                                 */
+		"addiu $t0, $t0, 4\n"         /* delayed slot: t0+=4;                          */
+		"lui $a3, %hi(_auxv)\n"       /* load _auxv into a3 (hi)                       */
+		"addiu $a3, %lo(_auxv)\n"     /* load _auxv into a3 (lo)                       */
+		"sw $t0, ($a3)\n"             /* store t0 into _auxv                           */
 
 		"li $t0, -8\n"
-		"and $sp, $sp, $t0\n"   // sp must be 8-byte aligned
-		"addiu $sp,$sp,-16\n"   // the callee expects to save a0..a3 there!
-		"jal main\n"            // main() returns the status code, we'll exit with it.
-		"nop\n"                 // delayed slot
-		"move $a0, $v0\n"       // retrieve 32-bit exit code from v0
-		"li $v0, 4001\n"        // NR_exit == 4001
+		"and $sp, $sp, $t0\n"   /* sp must be 8-byte aligned                           */
+		"addiu $sp,$sp,-16\n"   /* the callee expects to save a0..a3 there!            */
+		"jal main\n"            /* main() returns the status code, we'll exit with it. */
+		"nop\n"                 /* delayed slot                                        */
+		"move $a0, $v0\n"       /* retrieve 32-bit exit code from v0                   */
+		"li $v0, 4001\n"        /* NR_exit == 4001                                     */
 		"syscall\n"
-		//".end __start\n"
+		/*".end __start\n"*/
 		".set pop\n"
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_MIPS_H
+#endif /* _NOLIBC_ARCH_MIPS_H */

-- 
2.40.0

