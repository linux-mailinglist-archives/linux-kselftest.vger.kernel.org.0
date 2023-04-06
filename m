Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40056DA4F2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237326AbjDFVy6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjDFVy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:54:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FC2A5FC;
        Thu,  6 Apr 2023 14:54:55 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818092;
        bh=3MGSvpy8BgTYO3uiUf6A95riQqbsUtkLORdyUz+rY5k=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=YhGVNWFGblJqJWs5/gQoihyXPPCDuEPXbZVJP3XV1KRglAlmIcWaBwLqf/H8CJ61E
         h516d2nFvm/zpOQzOkzlUm9KDG/erlCOyqOb1eUYQ8TrgbiDK0AktAMBIxMJpHXeyb
         htTcz/aZN9FBqV+Ilblc8tuBMwE0h+70rHE1fvp0=
Date:   Thu, 06 Apr 2023 21:54:50 +0000
Subject: [PATCH v2 04/11] tools/nolibc: x86_64: use C89 comment syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-4-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=3259;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3MGSvpy8BgTYO3uiUf6A95riQqbsUtkLORdyUz+rY5k=;
 b=D61vWCH2rhmbgKzdGMopqMSfr6vlwxQF6lgD+EmocanAw8HUPZ5lsikNV4rCjvpy4Ap9DnS3n
 UqAEckRLu2hC/F8gM0MCVDKvCw3U1fBZeVqtWY94dhtzAONYuK4jsiW
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
 tools/include/nolibc/arch-x86_64.h | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index f7f2a11d4c3b..d98f6c89d143 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -194,27 +194,27 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
 #ifdef NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   // initialize stack protector
+		"call __stack_chk_init\n"   /* initialize stack protector                          */
 #endif
-		"pop %rdi\n"                // argc   (first arg, %rdi)
-		"mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
-		"lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
-		"mov %rdx, environ\n"       // save environ
-		"xor %ebp, %ebp\n"          // zero the stack frame
-		"mov %rdx, %rax\n"          // search for auxv (follows NULL after last env)
+		"pop %rdi\n"                /* argc   (first arg, %rdi)                            */
+		"mov %rsp, %rsi\n"          /* argv[] (second arg, %rsi)                           */
+		"lea 8(%rsi,%rdi,8),%rdx\n" /* then a NULL then envp (third arg, %rdx)             */
+		"mov %rdx, environ\n"       /* save environ                                        */
+		"xor %ebp, %ebp\n"          /* zero the stack frame                                */
+		"mov %rdx, %rax\n"          /* search for auxv (follows NULL after last env)       */
 		"0:\n"
-		"add $8, %rax\n"            // search for auxv using rax, it follows the
-		"cmp -8(%rax), %rbp\n"      // ... NULL after last env (rbp is zero here)
+		"add $8, %rax\n"            /* search for auxv using rax, it follows the           */
+		"cmp -8(%rax), %rbp\n"      /* ... NULL after last env (rbp is zero here)          */
 		"jnz 0b\n"
-		"mov %rax, _auxv\n"         // save it into _auxv
-		"and $-16, %rsp\n"          // x86 ABI : esp must be 16-byte aligned before call
-		"call main\n"               // main() returns the status code, we'll exit with it.
-		"mov %eax, %edi\n"          // retrieve exit code (32 bit)
-		"mov $60, %eax\n"           // NR_exit == 60
-		"syscall\n"                 // really exit
-		"hlt\n"                     // ensure it does not return
+		"mov %rax, _auxv\n"         /* save it into _auxv                                  */
+		"and $-16, %rsp\n"          /* x86 ABI : esp must be 16-byte aligned before call   */
+		"call main\n"               /* main() returns the status code, we'll exit with it. */
+		"mov %eax, %edi\n"          /* retrieve exit code (32 bit)                         */
+		"mov $60, %eax\n"           /* NR_exit == 60                                       */
+		"syscall\n"                 /* really exit                                         */
+		"hlt\n"                     /* ensure it does not return                           */
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_X86_64_H
+#endif /* _NOLIBC_ARCH_X86_64_H */

-- 
2.40.0

