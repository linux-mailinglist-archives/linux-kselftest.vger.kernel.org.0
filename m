Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A967077117D
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 20:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjHESkv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESku (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 14:40:50 -0400
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E5FB7;
        Sat,  5 Aug 2023 11:40:44 -0700 (PDT)
X-QQ-mid: bizesmtp77t1691260833tbkk0zgs
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 02:40:32 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: 96VJ2VzXm/qdtVNFs2llxvJYD1e7vTK/6sALo+w7KpYnEx5xxyFVMgmbni986
        I+ubWSZeNYyKq7ve3SC2kqvKaunRY+GWoCA9DxAFziLaMTjrTAEzJnMm54xMLRQrBRO1vpt
        UElu7Wn3n99SnR7UnCtVyGOrhb433wF9G9nvE5EafhPnryICXtaazTBbnRwTdeieN6GqEzp
        hxlufo1G+WxGmiOppTQYcrDrtun2YC6ofAup1A2/xTBvhBIUZhVUzTZxOCOwiD4fbfPiGYT
        yzImKaZ1m145V2VTqnF/f/tb5BfBILZYAY2vGfcsnhDzcg90DgjIgcTt1Rv/DvvjNZ4JCaP
        HZQUN5Gj87cuy8toh2/opdzwH3Lf5a5FCUifUKg2JwHb+gX9QqWWCANxMiTCSweA39za5wi
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16661133259475389670
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v6 2/8] tools/nolibc: add support for powerpc64
Date:   Sun,  6 Aug 2023 02:40:31 +0800
Message-Id: <aee1833915ecd814a6c692071b6461d7c15d4f2e.1691259983.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691259983.git.falcon@tinylab.org>
References: <cover.1691259983.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_PASS,
        T_SPF_HELO_TEMPERROR,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This follows the 64-bit PowerPC ABI [1], refers to the slides: "A new
ABI for little-endian PowerPC64 Design & Implementation" [2] and the
musl code in arch/powerpc64/crt_arch.h.

First, stdu and clrrdi are used instead of stwu and clrrwi for
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
 tools/include/nolibc/arch-powerpc.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 8332c9d3e5d6..76c3784f9dc7 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -172,6 +172,7 @@
 	_ret;                                                                \
 })
 
+#ifndef __powerpc64__
 /* FIXME: For 32-bit PowerPC, with newer gcc compilers (e.g. gcc 13.1.0),
  * "omit-frame-pointer" fails with __attribute__((no_stack_protector)) but
  * works with __attribute__((__optimize__("-fno-stack-protector")))
@@ -180,10 +181,24 @@
 #undef __no_stack_protector
 #define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
 #endif
+#endif /* !__powerpc64__ */
 
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
@@ -191,6 +206,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"stwu   1, -16(1)\n"    /* the initial stack frame                       */
 		"bl     _start_c\n"     /* transfer to c runtime                         */
 	);
+#endif
 	__builtin_unreachable();
 }
 
-- 
2.25.1

