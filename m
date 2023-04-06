Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945AF6DA501
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239399AbjDFVz3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjDFVzA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:55:00 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E0A5C5;
        Thu,  6 Apr 2023 14:54:58 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818094;
        bh=4SCszC2KSDPDlE8IGIH5s/FBuMphlLwMvBNzJo/XgJ8=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=hXKjheSeo3gegAXDU7i/Ju0XaPy70/OADFdhowIff4dFm4b7PUNQQ1hsI5ppbNmCp
         XtwRnJ1ONXD9sIIIsVcOLRyq/ujUXjpBi9C+s621YM5zsHXosmcUA4iKeWbVuL1kzd
         pPhtCXoIjuGAeI2zBKJWBf7ROVYKVwwJhYHq9gRk=
Date:   Thu, 06 Apr 2023 21:54:55 +0000
Subject: [PATCH v2 09/11] tools/nolibc: loongarch: use C89 comment syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-9-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=4001;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4SCszC2KSDPDlE8IGIH5s/FBuMphlLwMvBNzJo/XgJ8=;
 b=9W/LT+KmPcKghegsVGPha9qxNjwMUGJp1YR20WhUV+vkW/BQ2MHn07aThVZ6HEhc4neLtSXO4
 Zpidt8d08BBCwD943bsqJSBp/WXk5tzXFz87t859ndpKj0SM8wEjHqu
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
 tools/include/nolibc/arch-loongarch.h | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index 029ee3cd6baf..ec3b46a991a9 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -158,7 +158,7 @@ const unsigned long *_auxv __attribute__((weak));
 #define LONG_ADDI    "addi.w"
 #define LONG_SLL     "slli.w"
 #define LONG_BSTRINS "bstrins.w"
-#else // __loongarch_grlen == 64
+#else /* __loongarch_grlen == 64 */
 #define LONGLOG      "3"
 #define SZREG        "8"
 #define REG_L        "ld.d"
@@ -173,28 +173,28 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
-		REG_L        " $a0, $sp, 0\n"         // argc (a0) was in the stack
-		LONG_ADDI    " $a1, $sp, "SZREG"\n"   // argv (a1) = sp + SZREG
-		LONG_SLL     " $a2, $a0, "LONGLOG"\n" // envp (a2) = SZREG*argc ...
-		LONG_ADDI    " $a2, $a2, "SZREG"\n"   //             + SZREG (skip null)
-		LONG_ADD     " $a2, $a2, $a1\n"       //             + argv
+		REG_L        " $a0, $sp, 0\n"         /* argc (a0) was in the stack                          */
+		LONG_ADDI    " $a1, $sp, "SZREG"\n"   /* argv (a1) = sp + SZREG                              */
+		LONG_SLL     " $a2, $a0, "LONGLOG"\n" /* envp (a2) = SZREG*argc ...                          */
+		LONG_ADDI    " $a2, $a2, "SZREG"\n"   /*             + SZREG (skip null)                     */
+		LONG_ADD     " $a2, $a2, $a1\n"       /*             + argv                                  */
 
-		"move          $a3, $a2\n"            // iterate a3 over envp to find auxv (after NULL)
-		"0:\n"                                // do {
-		REG_L        " $a4, $a3, 0\n"         //   a4 = *a3;
-		LONG_ADDI    " $a3, $a3, "SZREG"\n"   //   a3 += sizeof(void*);
-		"bne           $a4, $zero, 0b\n"      // } while (a4);
-		"la.pcrel      $a4, _auxv\n"          // a4 = &_auxv
-		LONG_S       " $a3, $a4, 0\n"         // store a3 into _auxv
+		"move          $a3, $a2\n"            /* iterate a3 over envp to find auxv (after NULL)      */
+		"0:\n"                                /* do {                                                */
+		REG_L        " $a4, $a3, 0\n"         /*   a4 = *a3;                                         */
+		LONG_ADDI    " $a3, $a3, "SZREG"\n"   /*   a3 += sizeof(void*);                              */
+		"bne           $a4, $zero, 0b\n"      /* } while (a4);                                       */
+		"la.pcrel      $a4, _auxv\n"          /* a4 = &_auxv                                         */
+		LONG_S       " $a3, $a4, 0\n"         /* store a3 into _auxv                                 */
 
-		"la.pcrel      $a3, environ\n"        // a3 = &environ
-		LONG_S       " $a2, $a3, 0\n"         // store envp(a2) into environ
-		LONG_BSTRINS " $sp, $zero, 3, 0\n"    // sp must be 16-byte aligned
-		"bl            main\n"                // main() returns the status code, we'll exit with it.
-		"li.w          $a7, 93\n"             // NR_exit == 93
+		"la.pcrel      $a3, environ\n"        /* a3 = &environ                                       */
+		LONG_S       " $a2, $a3, 0\n"         /* store envp(a2) into environ                         */
+		LONG_BSTRINS " $sp, $zero, 3, 0\n"    /* sp must be 16-byte aligned                          */
+		"bl            main\n"                /* main() returns the status code, we'll exit with it. */
+		"li.w          $a7, 93\n"             /* NR_exit == 93                                       */
 		"syscall       0\n"
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_LOONGARCH_H
+#endif /* _NOLIBC_ARCH_LOONGARCH_H */

-- 
2.40.0

