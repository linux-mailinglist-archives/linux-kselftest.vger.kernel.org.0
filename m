Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5A59771F0F
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Aug 2023 13:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjHGLBK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 7 Aug 2023 07:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjHGLBJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 7 Aug 2023 07:01:09 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AF61701;
        Mon,  7 Aug 2023 04:01:03 -0700 (PDT)
X-QQ-mid: bizesmtp64t1691406050t3gsqv07
Received: from linux-lab-host.localdomain ( [116.30.130.12])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 07 Aug 2023 19:00:49 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: J5JfekO1WsimCxeLeaIRwLKPUP4hLs0KL6RLQnScNWp3T1pU0LAVZjC4TPlkd
        k87XCapHbL4LiEUGX5UZzfPUuqLPBeuaVV+KP1TgwYN7UkHO+yVc+ABChQVqPXW25W9OJby
        8VJAFTRRJjcUrn3uVYbuqzR+WQyMe0Bn25SZCtFh1UrDUTCf1zjc2R9uAAUYlXWusvIOFve
        EFf8yDr5+a4HBvMgz8LsmEVwLXWMGmuKVjORDG8muFdZOfP0KYtkaZcPyPTqRLyc7qJ3IhA
        SWfMtQ5ktT3lDR7PRBcoVeNvp4D4X0KTJQ9rGNoNog53rAKrSD5ZfQF6n1KebVvS50WvULX
        i1BA8QyGptm586LBXjH4xN8xN3X+gV2DtmyvFzbSqd37csOi48U/HGkUDf7Y/bz6a6+fmgO
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 355986596095762811
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux@weissschuh.net,
        tanyuan@tinylab.org, thomas@t-8ch.de
Subject: [PATCH] tools/nolibc: silence ppc64 compile warnings
Date:   Mon,  7 Aug 2023 19:00:48 +0800
Message-Id: <682bbec9ff358b3726daee00752dbe0abc99370a.1691405029.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Silence the following warnings reported by the new -Wall -Wextra options
with pure assembly code.

    In file included from sysroot/powerpc/include/stdio.h:13,
                     from nolibc-test.c:13:
    sysroot/powerpc/include/arch.h: In function '_start':
    sysroot/powerpc/include/arch.h:192:32: warning: unused variable 'r2' [-Wunused-variable]
      192 |         register volatile long r2 __asm__ ("r2") = (void *)&TOC - (void *)_start;
          |                                ^~
    sysroot/powerpc/include/arch.h:187:97: warning: optimization may eliminate reads and/or writes to register variables [-Wvolatile-register-var]
      187 | void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
          |                                                                                                 ^~~~~~

Since only elfv2 ABI requires to save the TOC/GOT pointer to r2
register, when using elfv1 ABI, the old C code is simply ignored by the
compiler, but the compiler can not ignore the inline assembly code and
will introduce build failure or running segfaults. So, let's further
only add the new assembly code for elfv2 ABI with the checking of
_CALL_ELF == 2.

Link: https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.pdf
Link: https://www.llvm.org/devmtg/2014-04/PDFs/Talks/Euro-LLVM-2014-Weigand.pdf
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---

Hi, Willy

When rebase on latest 20230806-for-6.6-1 branch, -Wall -Wextra reported
the above warnings.

Here uses volatile inline assembly code instead of C code to silence the
unused and optimization warnings.

And since only elfv2 require to save TOC pointer to r2 register, this
further only add the assembly code for elfv2.

BR,
Zhangjin

---
 tools/include/nolibc/arch-powerpc.h | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/arch-powerpc.h b/tools/include/nolibc/arch-powerpc.h
index 76c3784f9dc7..ac212e6185b2 100644
--- a/tools/include/nolibc/arch-powerpc.h
+++ b/tools/include/nolibc/arch-powerpc.h
@@ -187,9 +187,17 @@
 void __attribute__((weak, noreturn, optimize("Os", "omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 #ifdef __powerpc64__
-	/* On 64-bit PowerPC, save TOC/GOT pointer to r2 */
-	extern char TOC __asm__ (".TOC.");
-	register volatile long r2 __asm__ ("r2") = (void *)&TOC - (void *)_start;
+#if _CALL_ELF == 2
+	/* with -mabi=elfv2, save TOC/GOT pointer to r2
+	 * r12 is global entry pointer, we use it to compute TOC from r12
+	 * https://www.llvm.org/devmtg/2014-04/PDFs/Talks/Euro-LLVM-2014-Weigand.pdf
+	 * https://refspecs.linuxfoundation.org/ELF/ppc64/PPC-elf64abi.pdf
+	 */
+	__asm__ volatile (
+		"addis  2, 12, .TOC. - _start@ha\n"
+		"addi   2,  2, .TOC. - _start@l\n"
+	);
+#endif /* _CALL_ELF == 2 */
 
 	__asm__ volatile (
 		"mr     3, 1\n"         /* save stack pointer to r3, as arg1 of _start_c */
-- 
2.25.1

