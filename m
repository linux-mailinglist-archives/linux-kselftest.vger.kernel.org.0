Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29027586A3
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjGRVMY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjGRVMT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:12:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7821FEE;
        Tue, 18 Jul 2023 14:12:05 -0700 (PDT)
X-QQ-mid: bizesmtp67t1689714716ty3d409i
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 05:11:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: znfcQSa1hKbIWy9/nudIS6dweUsnw6YVkjkrjXVuU+TODYlb+AgCL6pXkl2Fl
        tSsRaDf72WXJcU3KEzH9E4XSY2yEuk3T/diWm8Ne5HqGX0DrjpE477mcQpG4G5DFd9ODAOv
        uaikbHrw6qk530JkQ8AXJcHgiIds6d+3aJefPFODPpZsURPJhdgFwh0jQjZ/vmKkYggOmvg
        aszaovcQXFBHNKeguR9bBylNG6atlyI7bfvZaKxSTY+3RBNZwLkFtoz5htQh0d6mbj20RuF
        K+5rrb2HGie6OTmRGi4ibC/KnE/f91NZCFgxKvguB/uEmc1BehQ7DhvhA7zqSZvkzSXxWHD
        9PT7i9S5yx9Zpsyo+xynEYrc3KrTZZkfVU5bd7OV511CmwkmBLBB7D8q7X6YQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11373982133652074623
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 2/8] tools/nolibc: add support for powerpc64
Date:   Wed, 19 Jul 2023 05:11:54 +0800
Message-Id: <a32fc49e089ca6f8c7a0adc5995253ed30e89179.1689713175.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689713175.git.falcon@tinylab.org>
References: <cover.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/include/nolibc/arch-powerpc.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 100ec0f412dc..7b28ebcfcc23 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -143,6 +143,19 @@
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
@@ -150,6 +163,7 @@ void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_
 		"stwu   1, -16(1)\n"    /* the initial stack frame                       */
 		"bl     _start_c\n"     /* transfer to c runtime                         */
 	);
+#endif
 	__builtin_unreachable();
 }
 
-- 
2.25.1

