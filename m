Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704A1763994
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233701AbjGZOwC (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbjGZOwA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:52:00 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD7D19A0;
        Wed, 26 Jul 2023 07:51:58 -0700 (PDT)
X-QQ-mid: bizesmtp74t1690383109tpb94mlh
Received: from localhost.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 22:51:48 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: OtIeQkg1QQHHCIiiAVCObq1XZpMiZZrep3CdnHIkv0Cbq1h4RDrOm7rMYOmUZ
        TPmC2nvXS5zvaOqkRcYFP7EfRTxQFyzdfssN9/Zr9xCoiY3tRyPj8srSEwFivyx8xeQaLQX
        b3Odf2maFdKYvMj0gCu2tmb4PLz2APzE+8iPcs1RsXJWOiOSXyUWSY4BvsyCLc/90ENTR0t
        vkfEksPIiQbt4oShglA/Z3TXba5fVnLCA5jXsgBn4u+TmtrrxNqAHTiAvJBk9QW/oXJw0GX
        yHdj+I2fEEDUD8nlIrzcPleDk+h/UglC9Cr8TQPiTBTknIe75gEv+IJOBa/s3LWCAetWPu1
        JqzNl/k0pRQXeSgeoZ6pjTQJDInAolTF/IwBwWez3jMOCp2mJukfmi+T11QwA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1055855130666732953
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 2/7] tools/nolibc: add support for powerpc64
Date:   Wed, 26 Jul 2023 22:50:46 +0800
Message-Id: <7a406115cb891105e554d2bebb3532a5de70f5ca.1690373704.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690373704.git.falcon@tinylab.org>
References: <cover.1690373704.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This follows the 64-bit PowerPC ABI [1], refers to the slides: "A new
ABI for little-endian PowerPC64 Design & Implementation" [2] and the
musl code in arch/powerpc64/crt_arch.h.

Firstly, stdu and clrrdi are used instead of stwu and clrrwi for
powerpc64.

Second, the stack frame size is increased to 32 bytes for powerpc64, 32
bytes is the minimal stack frame size supported described in [2].

Besides, the TOC pointer (GOT pointer) must be saved to r2.

This works on both little endian and big endian 64-bit PowerPC.

[1]: https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.pdf
[2]: https://www.llvm.org/devmtg/2014-04/PDFs/Talks/Euro-LLVM-2014-Weigand.pdf

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-powerpc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index caa943e1521a..d783ed0b5dbd 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -175,6 +175,19 @@
 /* startup code */
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
+#ifdef __powerpc64__
+	/* On 64-bit PowerPC, save TOC/GOT pointer to r2 */
+	extern char TOC __asm__ (".TOC.");
+	register volatile long r2 __asm__ ("r2") = (void *)&TOC - (void *)_start;
+
+	__asm__ volatile (
+		"mr     3, 1\n"         /* save stack pointer to r3, as arg1 of _start_c */
+		"clrrdi 1, 1, 4\n"      /* align the stack to 16 bytes                   */
+		"li     0, 0\n"         /* zero the frame pointer                        */
+		"stdu   1, -32(1)\n"    /* the initial stack frame                       */
+		"bl     _start_c\n"     /* transfer to c runtime                         */
+	);
+#else
 	__asm__ volatile (
 		"mr     3, 1\n"         /* save stack pointer to r3, as arg1 of _start_c */
 		"clrrwi 1, 1, 4\n"      /* align the stack to 16 bytes                   */
@@ -182,6 +195,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"stwu   1, -16(1)\n"    /* the initial stack frame                       */
 		"bl     _start_c\n"     /* transfer to c runtime                         */
 	);
+#endif
 	__builtin_unreachable();
 }
 
-- 
2.25.1

