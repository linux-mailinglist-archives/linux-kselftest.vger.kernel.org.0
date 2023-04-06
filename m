Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B2E6DA4F9
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 23:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238668AbjDFVzD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 17:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236370AbjDFVy7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 17:54:59 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F95A5FF;
        Thu,  6 Apr 2023 14:54:58 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1680818094;
        bh=Rf7Jc56HjkpWDXljnPpY5bO94Kjcb/DhOAnDyw2YeEs=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=knWR5xTcOlKFmcstTjTjzwApExaXWn9NSBrkqKAWsEJSeW5cnYUTZ04QJslMoL/MB
         l0L6bscC6c9V/rD502l7smuFCU5v5R8guvoESxeSkfYj3Xl/tzhpkX9PyYTUwp7Hg0
         w2RhXnhqDkTYmpuYZ0T9JQfGlRv5y7PPedhUif3g=
Date:   Thu, 06 Apr 2023 21:54:53 +0000
Subject: [PATCH v2 07/11] tools/nolibc: arm: use C89 comment syntax
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230328-nolibc-c99-v2-7-c989f2289222@weissschuh.net>
References: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
In-Reply-To: <20230328-nolibc-c99-v2-0-c989f2289222@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680818091; l=3900;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Rf7Jc56HjkpWDXljnPpY5bO94Kjcb/DhOAnDyw2YeEs=;
 b=YwG20llV8yOPYg5+PPSwm+Ukx9mn6MnyiPWyK7kOfNaoTB57yX1mRwtVZw7dwhGZG4Tp6pv8w
 SLMFUB9v5FvCaHdplAPl4PWYUNXfYo7ONwRjPNPAxSdO6C6ENl7+lfo
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
 tools/include/nolibc/arch-arm.h | 42 ++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 42499f23e73c..9fc926f5fbae 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -203,34 +203,34 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
-		"pop {%r0}\n"                 // argc was in the stack
-		"mov %r1, %sp\n"              // argv = sp
+		"pop {%r0}\n"                 /* argc was in the stack                               */
+		"mov %r1, %sp\n"              /* argv = sp                                           */
 
-		"add %r2, %r0, $1\n"          // envp = (argc + 1) ...
-		"lsl %r2, %r2, $2\n"          //        * 4        ...
-		"add %r2, %r2, %r1\n"         //        + argv
-		"ldr %r3, 1f\n"               // r3 = &environ (see below)
-		"str %r2, [r3]\n"             // store envp into environ
+		"add %r2, %r0, $1\n"          /* envp = (argc + 1) ...                               */
+		"lsl %r2, %r2, $2\n"          /*        * 4        ...                               */
+		"add %r2, %r2, %r1\n"         /*        + argv                                       */
+		"ldr %r3, 1f\n"               /* r3 = &environ (see below)                           */
+		"str %r2, [r3]\n"             /* store envp into environ                             */
 
-		"mov r4, r2\n"                // search for auxv (follows NULL after last env)
+		"mov r4, r2\n"                /* search for auxv (follows NULL after last env)       */
 		"0:\n"
-		"mov r5, r4\n"                // r5 = r4
-		"add r4, r4, #4\n"            // r4 += 4
-		"ldr r5,[r5]\n"               // r5 = *r5 = *(r4-4)
-		"cmp r5, #0\n"                // and stop at NULL after last env
+		"mov r5, r4\n"                /* r5 = r4                                             */
+		"add r4, r4, #4\n"            /* r4 += 4                                             */
+		"ldr r5,[r5]\n"               /* r5 = *r5 = *(r4-4)                                  */
+		"cmp r5, #0\n"                /* and stop at NULL after last env                     */
 		"bne 0b\n"
-		"ldr %r3, 2f\n"               // r3 = &_auxv (low bits)
-		"str r4, [r3]\n"              // store r4 into _auxv
+		"ldr %r3, 2f\n"               /* r3 = &_auxv (low bits)                              */
+		"str r4, [r3]\n"              /* store r4 into _auxv                                 */
 
-		"mov %r3, $8\n"               // AAPCS : sp must be 8-byte aligned in the
-		"neg %r3, %r3\n"              //         callee, and bl doesn't push (lr=pc)
-		"and %r3, %r3, %r1\n"         // so we do sp = r1(=sp) & r3(=-8);
-		"mov %sp, %r3\n"              //
+		"mov %r3, $8\n"               /* AAPCS : sp must be 8-byte aligned in the            */
+		"neg %r3, %r3\n"              /*         callee, and bl doesn't push (lr=pc)         */
+		"and %r3, %r3, %r1\n"         /* so we do sp = r1(=sp) & r3(=-8);                    */
+		"mov %sp, %r3\n"
 
-		"bl main\n"                   // main() returns the status code, we'll exit with it.
-		"movs r7, $1\n"               // NR_exit == 1
+		"bl main\n"                   /* main() returns the status code, we'll exit with it. */
+		"movs r7, $1\n"               /* NR_exit == 1                                        */
 		"svc $0x00\n"
-		".align 2\n"                  // below are the pointers to a few variables
+		".align 2\n"                  /* below are the pointers to a few variables           */
 		"1:\n"
 		".word environ\n"
 		"2:\n"

-- 
2.40.0

