Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88CF16DA4F5
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjDFVzA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjDFVy5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:54:57 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A15A5C5;
        Thu,  6 Apr 2023 14:54:54 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818092;
        bh=NbJkCnxIzyUQDNJwE58LVaz04AmILAiIMxaWQbvg4fY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=EfrlOckNquamOCpt2Qg07OWnXl+Q7E34MZf3dT2VlRwniAdB8ixGkgyTthGTtCdlj
         sXjQ8D03U322k2LkFvj2h3GeVTh1aXxkctwx/1cUjWA9oKIjaUvnCK6cM69vummbtC
         AgRqVseW4yRLIdYIDjMp3X1BkxHEJbO1p/5fRpUM=
Date:   Thu, 06 Apr 2023 21:54:49 +0000
Subject: [PATCH v2 03/11] tools/nolibc: i386: use C89 comment syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-3-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=3632;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=NbJkCnxIzyUQDNJwE58LVaz04AmILAiIMxaWQbvg4fY=;
 b=zz54OEuctYdVaxu5sItH81WYtOWXKLseoGIdt2bcvyzxasrhfgF78XdNqnmA3LvEWeszpYYcW
 AUfR4FA/29OBIoU/FG3QULbHJpejJgTqLhegZTKvfTzrcjBSbH/309m
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
 tools/include/nolibc/arch-i386.h | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 2d98d78fd3f3..7c41897a08ce 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -194,31 +194,31 @@ void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protec
 {
 	__asm__ volatile (
 #ifdef NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   // initialize stack protector
+		"call __stack_chk_init\n"   /* initialize stack protector                    */
 #endif
-		"pop %eax\n"                // argc   (first arg, %eax)
-		"mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
-		"lea 4(%ebx,%eax,4),%ecx\n" // then a NULL then envp (third arg, %ecx)
-		"mov %ecx, environ\n"       // save environ
-		"xor %ebp, %ebp\n"          // zero the stack frame
-		"mov %ecx, %edx\n"          // search for auxv (follows NULL after last env)
+		"pop %eax\n"                /* argc   (first arg, %eax)                      */
+		"mov %esp, %ebx\n"          /* argv[] (second arg, %ebx)                     */
+		"lea 4(%ebx,%eax,4),%ecx\n" /* then a NULL then envp (third arg, %ecx)       */
+		"mov %ecx, environ\n"       /* save environ                                  */
+		"xor %ebp, %ebp\n"          /* zero the stack frame                          */
+		"mov %ecx, %edx\n"          /* search for auxv (follows NULL after last env) */
 		"0:\n"
-		"add $4, %edx\n"            // search for auxv using edx, it follows the
-		"cmp -4(%edx), %ebp\n"      // ... NULL after last env (ebp is zero here)
+		"add $4, %edx\n"            /* search for auxv using edx, it follows the     */
+		"cmp -4(%edx), %ebp\n"      /* ... NULL after last env (ebp is zero here)    */
 		"jnz 0b\n"
-		"mov %edx, _auxv\n"         // save it into _auxv
-		"and $-16, %esp\n"          // x86 ABI : esp must be 16-byte aligned before
-		"sub $4, %esp\n"            // the call instruction (args are aligned)
-		"push %ecx\n"               // push all registers on the stack so that we
-		"push %ebx\n"               // support both regparm and plain stack modes
+		"mov %edx, _auxv\n"         /* save it into _auxv                            */
+		"and $-16, %esp\n"          /* x86 ABI : esp must be 16-byte aligned before  */
+		"sub $4, %esp\n"            /* the call instruction (args are aligned)       */
+		"push %ecx\n"               /* push all registers on the stack so that we    */
+		"push %ebx\n"               /* support both regparm and plain stack modes    */
 		"push %eax\n"
-		"call main\n"               // main() returns the status code in %eax
-		"mov %eax, %ebx\n"          // retrieve exit code (32-bit int)
-		"movl $1, %eax\n"           // NR_exit == 1
-		"int $0x80\n"               // exit now
-		"hlt\n"                     // ensure it does not
+		"call main\n"               /* main() returns the status code in %eax        */
+		"mov %eax, %ebx\n"          /* retrieve exit code (32-bit int)               */
+		"movl $1, %eax\n"           /* NR_exit == 1                                  */
+		"int $0x80\n"               /* exit now                                      */
+		"hlt\n"                     /* ensure it does not                            */
 	);
 	__builtin_unreachable();
 }
 
-#endif // _NOLIBC_ARCH_I386_H
+#endif /* _NOLIBC_ARCH_I386_H */

-- 
2.40.0

