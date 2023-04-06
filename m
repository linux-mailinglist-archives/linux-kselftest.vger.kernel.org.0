Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DACD6DA4F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238653AbjDFVzB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbjDFVy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:54:59 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E18A5FC;
        Thu,  6 Apr 2023 14:54:58 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818094;
        bh=ivxkrkfr/Vz1LAtJgf52WLXoMkNfU0tK0Pz7f9le2Yc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Bm4BZb8GowdJfVz+QTa0kDUjQVG4JNtoLAHtV7dyIDAGx806KXE3j61OLRAptMCY4
         ++NW2oopLQcoYo1MbVL0sBpgsyTEvSEJKPYkQoHTJqZyvuYnwGgBR4JfC+rcbhXtKf
         OThcesSem4AdHBsztxsrlibsHNS32UTHLxXNq/kE=
Date:   Thu, 06 Apr 2023 21:54:51 +0000
Subject: [PATCH v2 05/11] tools/nolibc: riscv: use C89 comment syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-5-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=3358;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ivxkrkfr/Vz1LAtJgf52WLXoMkNfU0tK0Pz7f9le2Yc=;
 b=b1N/Dkx1yViUzSy6LzMrmFZOLq0MQqxbkgmMFxlBOMJP3HJEwJ1jYJ2y70l044ZCNrcOy2vSI
 68nXdzBuMSNDo95qMOER4oS3/JwfMLSEXf6EKjicJ/eCNqtfB/w6z/A
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
 tools/include/nolibc/arch-riscv.h | 40 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index e197fcb10ac0..0d5f15fdedc4 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -181,28 +181,28 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 		".option norelax\n"
 		"lla   gp, __global_pointer$\n"
 		".option pop\n"
-		"lw    a0, 0(sp)\n"          // argc (a0) was in the stack
-		"add   a1, sp, "SZREG"\n"    // argv (a1) = sp
-		"slli  a2, a0, "PTRLOG"\n"   // envp (a2) = SZREG*argc ...
-		"add   a2, a2, "SZREG"\n"    //             + SZREG (skip null)
-		"add   a2,a2,a1\n"           //             + argv
-
-		"add   a3, a2, zero\n"       // iterate a3 over envp to find auxv (after NULL)
-		"0:\n"                       // do {
-		"ld    a4, 0(a3)\n"          //   a4 = *a3;
-		"add   a3, a3, "SZREG"\n"    //   a3 += sizeof(void*);
-		"bne   a4, zero, 0b\n"       // } while (a4);
-		"lui   a4, %hi(_auxv)\n"     // a4 = &_auxv (high bits)
-		"sd    a3, %lo(_auxv)(a4)\n" // store a3 into _auxv
-
-		"lui a3, %hi(environ)\n"     // a3 = &environ (high bits)
-		"sd a2,%lo(environ)(a3)\n"   // store envp(a2) into environ
-		"andi  sp,a1,-16\n"          // sp must be 16-byte aligned
-		"call  main\n"               // main() returns the status code, we'll exit with it.
-		"li a7, 93\n"                // NR_exit == 93
+		"lw    a0, 0(sp)\n"          /* argc (a0) was in the stack                          */
+		"add   a1, sp, "SZREG"\n"    /* argv (a1) = sp                                      */
+		"slli  a2, a0, "PTRLOG"\n"   /* envp (a2) = SZREG*argc ...                          */
+		"add   a2, a2, "SZREG"\n"    /*             + SZREG (skip null)                     */
+		"add   a2,a2,a1\n"           /*             + argv                                  */
+
+		"add   a3, a2, zero\n"       /* iterate a3 over envp to find auxv (after NULL)      */
+		"0:\n"                       /* do {                                                */
+		"ld    a4, 0(a3)\n"          /*   a4 = *a3;                                         */
+		"add   a3, a3, "SZREG"\n"    /*   a3 += sizeof(void*);                              */
+		"bne   a4, zero, 0b\n"       /* } while (a4);                                       */
+		"lui   a4, %hi(_auxv)\n"     /* a4 = &_auxv (high bits)                             */
+		"sd    a3, %lo(_auxv)(a4)\n" /* store a3 into _auxv                                 */
+
+		"lui a3, %hi(environ)\n"     /* a3 = &environ (high bits)                           */
+		"sd a2,%lo(environ)(a3)\n"   /* store envp(a2) into environ                         */
+		"andi  sp,a1,-16\n"          /* sp must be 16-byte aligned                          */
+		"call  main\n"               /* main() returns the status code, we'll exit with it. */
+		"li a7, 93\n"                /* NR_exit == 93                                       */
 		"ecall\n"
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_RISCV_H
+#endif /* _NOLIBC_ARCH_RISCV_H */

-- 
2.40.0

