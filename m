Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BFE6DA4F7
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238433AbjDFVzB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbjDFVy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:54:59 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392729EF3;
        Thu,  6 Apr 2023 14:54:58 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818093;
        bh=au6cL+xeGyBx2JuVA4zq1izj1V8MrbDP7tzalqdO45Y=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=icuaixsvpSV0QsITo91zw6WlzMxn6d38otakt/P+NhT01D90wXdkdo2jZ/qXiNcQl
         16bvVBbPxX8YRXtltRmQO4EnRZ/iR5q0+wHRvR2r2oMda9o48tqXEUAbqdiRIHCKCw
         BLBSdEUVTYVVTkwAsHumsrck8m4vqa0GoXIG6Lw4=
Date:   Thu, 06 Apr 2023 21:54:52 +0000
Subject: [PATCH v2 06/11] tools/nolibc: aarch64: use C89 comment syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-6-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=2890;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=au6cL+xeGyBx2JuVA4zq1izj1V8MrbDP7tzalqdO45Y=;
 b=t6HSMSCHAwNiIiOY7OcGU1mmEiEBHqEReYY/H61cyqGGWnhwXtSJdDQ4CjdbBkKiv4VA5WfgG
 k+n9qJ57Wl9Cjdn6gdhID3hJikA0A3fo/L1pF4QIHmnDnwOz0E/ryv0
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
 tools/include/nolibc/arch-aarch64.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 383baddef701..76ef26520c85 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -176,24 +176,24 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
-		"ldr x0, [sp]\n"     // argc (x0) was in the stack
-		"add x1, sp, 8\n"    // argv (x1) = sp
-		"lsl x2, x0, 3\n"    // envp (x2) = 8*argc ...
-		"add x2, x2, 8\n"    //           + 8 (skip null)
-		"add x2, x2, x1\n"   //           + argv
-		"adrp x3, environ\n"          // x3 = &environ (high bits)
-		"str x2, [x3, #:lo12:environ]\n" // store envp into environ
-		"mov x4, x2\n"       // search for auxv (follows NULL after last env)
+		"ldr x0, [sp]\n"     /* argc (x0) was in the stack                          */
+		"add x1, sp, 8\n"    /* argv (x1) = sp                                      */
+		"lsl x2, x0, 3\n"    /* envp (x2) = 8*argc ...                              */
+		"add x2, x2, 8\n"    /*           + 8 (skip null)                           */
+		"add x2, x2, x1\n"   /*           + argv                                    */
+		"adrp x3, environ\n"          /* x3 = &environ (high bits)                  */
+		"str x2, [x3, #:lo12:environ]\n" /* store envp into environ                 */
+		"mov x4, x2\n"       /* search for auxv (follows NULL after last env)       */
 		"0:\n"
-		"ldr x5, [x4], 8\n"  // x5 = *x4; x4 += 8
-		"cbnz x5, 0b\n"      // and stop at NULL after last env
-		"adrp x3, _auxv\n"   // x3 = &_auxv (high bits)
-		"str x4, [x3, #:lo12:_auxv]\n" // store x4 into _auxv
-		"and sp, x1, -16\n"  // sp must be 16-byte aligned in the callee
-		"bl main\n"          // main() returns the status code, we'll exit with it.
-		"mov x8, 93\n"       // NR_exit == 93
+		"ldr x5, [x4], 8\n"  /* x5 = *x4; x4 += 8                                   */
+		"cbnz x5, 0b\n"      /* and stop at NULL after last env                     */
+		"adrp x3, _auxv\n"   /* x3 = &_auxv (high bits)                             */
+		"str x4, [x3, #:lo12:_auxv]\n" /* store x4 into _auxv                       */
+		"and sp, x1, -16\n"  /* sp must be 16-byte aligned in the callee            */
+		"bl main\n"          /* main() returns the status code, we'll exit with it. */
+		"mov x8, 93\n"       /* NR_exit == 93                                       */
 		"svc #0\n"
 	);
 	__builtin_unreachable();
 }
-#endif // _NOLIBC_ARCH_AARCH64_H
+#endif /* _NOLIBC_ARCH_AARCH64_H */

-- 
2.40.0

