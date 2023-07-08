Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2440574BE38
	for <lists+linux-kselftest@lfdr.de>; Sat,  8 Jul 2023 17:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbjGHPde (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 8 Jul 2023 11:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGHPdd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 8 Jul 2023 11:33:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0048B9;
        Sat,  8 Jul 2023 08:33:29 -0700 (PDT)
X-QQ-mid: bizesmtp82t1688830400tnw4fqr8
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 23:33:18 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 3M0okmaRx3jTqNLxLrG6yWpv/QJkh0QmhXcU6YGQmBWSV1xDrAf8EYRJGwJ1H
        jFLLY1hdkIYFfiWtjxPWqL4fpLl5ROyNnZa6oi5Ocy4gBF5PyzWpNuOROyrfaJZrWzajfT0
        Z1KUfOnxJfg7NGpnCzo3ke0Vgddbhr0tk4Lsq7tuiFulTd45o7nBQkvFmDAJd2o59fk4Glj
        HJ2o7jzru/Crcxa8NKuvMl4/rZ5FoHq1MtamPbm3c23KExrLG3wZb3N2ohpDQo/1Wg0+Ch+
        O4/CEyE/Ftx3UVwnoabRLrg61w4z7yvoE2SbV7zdAH0guEAXtXhKtCEdKQLSU8ee7OQ5aqF
        aSURZqTnuoqUgHLd2iN9kdjOy2z+/48M1eu7TA/hlSoKGrlun46VibjUfXzwQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7735536925553347546
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v2 07/12] tools/nolibc: i386/crt.h: shrink _start with _start_c
Date:   Sat,  8 Jul 2023 23:33:14 +0800
Message-Id: <1ca8535cdd8a6473c1bb6c8c7a8e4ff45e558ea3.1688828139.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688828139.git.falcon@tinylab.org>
References: <cover.1688828139.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

move most of the _start operations to _start_c().

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/i386/crt.h | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/tools/include/nolibc/i386/crt.h b/tools/include/nolibc/i386/crt.h
index 0b88f7c887ae..87f31bc253a3 100644
--- a/tools/include/nolibc/i386/crt.h
+++ b/tools/include/nolibc/i386/crt.h
@@ -18,29 +18,14 @@ void __attribute__((weak, noreturn, optimize("omit-frame-pointer"))) __no_stack_
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
-		"call __stack_chk_init\n"   /* initialize stack protector                    */
+		"call __stack_chk_init\n" /* initialize stack protector                           */
 #endif
-		"pop %eax\n"                /* argc   (first arg, %eax)                      */
-		"mov %esp, %ebx\n"          /* argv[] (second arg, %ebx)                     */
-		"lea 4(%ebx,%eax,4),%ecx\n" /* then a NULL then envp (third arg, %ecx)       */
-		"mov %ecx, environ\n"       /* save environ                                  */
-		"xor %ebp, %ebp\n"          /* zero the stack frame                          */
-		"mov %ecx, %edx\n"          /* search for auxv (follows NULL after last env) */
-		"0:\n"
-		"add $4, %edx\n"            /* search for auxv using edx, it follows the     */
-		"cmp -4(%edx), %ebp\n"      /* ... NULL after last env (ebp is zero here)    */
-		"jnz 0b\n"
-		"mov %edx, _auxv\n"         /* save it into _auxv                            */
-		"and $-16, %esp\n"          /* x86 ABI : esp must be 16-byte aligned before  */
-		"sub $4, %esp\n"            /* the call instruction (args are aligned)       */
-		"push %ecx\n"               /* push all registers on the stack so that we    */
-		"push %ebx\n"               /* support both regparm and plain stack modes    */
-		"push %eax\n"
-		"call main\n"               /* main() returns the status code in %eax        */
-		"mov %eax, %ebx\n"          /* retrieve exit code (32-bit int)               */
-		"movl $1, %eax\n"           /* NR_exit == 1                                  */
-		"int $0x80\n"               /* exit now                                      */
-		"hlt\n"                     /* ensure it does not                            */
+		"xor  %ebp, %ebp\n"       /* zero the stack frame                                 */
+		"mov  %esp, %eax\n"       /* save stack pointer to %eax, as arg1 of _start_c      */
+		"and  $-16, %esp\n"       /* last pushed argument must be 16-byte aligned         */
+		"push %eax\n"             /* push arg1 on stack to support plain stack modes too  */
+		"call _start_c\n"         /* transfer to c runtime                                */
+		"hlt\n"                   /* ensure it does not return                            */
 	);
 	__builtin_unreachable();
 }
-- 
2.25.1

