Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE6570EE66
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 08:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239074AbjEXGqs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 02:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234559AbjEXGpw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 02:45:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3167E5D;
        Tue, 23 May 2023 23:44:51 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1684910689;
        bh=reqmiExzGTQxklSzXm/noKKOAtLNvVE59PGDoFayN1w=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=T5SmGOkI29IEM9XLSnj/i28kCVnJ1iPZXPvU8IsemBikgoO7uMwTYcYpUYVPF3d/V
         oR29290VK+P963iAIaUBPnyiysG3V/TjFDNENC4DJD4RzCCj42362qbBnOLzA7pQwL
         FWbUt3btYEL2eEYtlYxmBTxdg/HpRJhc/5STdbTU=
Date:   Wed, 24 May 2023 08:44:44 +0200
Subject: [PATCH 3/3] tools/nolibc: fix segfaults on compilers without
 attribute no_stack_protector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230523-nolibc-stackprotector-gcc9-v1-3-3e4804235d50@weissschuh.net>
References: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
In-Reply-To: <20230523-nolibc-stackprotector-gcc9-v1-0-3e4804235d50@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhangjin Wu <falcon@tinylab.org>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684910688; l=6337;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=reqmiExzGTQxklSzXm/noKKOAtLNvVE59PGDoFayN1w=;
 b=37z0/+Hv+PAPuNXfne/yE/xDem/kRyC8T7qzhC9LLT1n00nsJ7pvhUOMzZ8UIuX5RNyAfO/UW
 3I0zQDK4E1GBPAb9uGHQraM8gl/1B96DWTzSLOn25HI2PoDEM0vqOz0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Not all compilers, notably GCC < 10, have support for
__attribute__((no_stack_protector)).
Fall back to a mechanism that also works there.

Tested with GCC 9.5.0 from kernel.org crosstools.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-aarch64.h   |  2 +-
 tools/include/nolibc/arch-arm.h       |  2 +-
 tools/include/nolibc/arch-i386.h      |  2 +-
 tools/include/nolibc/arch-loongarch.h |  2 +-
 tools/include/nolibc/arch-mips.h      |  2 +-
 tools/include/nolibc/arch-riscv.h     |  2 +-
 tools/include/nolibc/arch-x86_64.h    |  2 +-
 tools/include/nolibc/compiler.h       | 10 ++++++++++
 tools/include/nolibc/stackprotector.h |  2 +-
 9 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/tools/include/nolibc/arch-aarch64.h b/tools/include/nolibc/arch-aarch64.h
index 64ec65b4ee38..11f294a406b7 100644
--- a/tools/include/nolibc/arch-aarch64.h
+++ b/tools/include/nolibc/arch-aarch64.h
@@ -175,7 +175,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-arm.h b/tools/include/nolibc/arch-arm.h
index 924169522cf7..45b89ffe8247 100644
--- a/tools/include/nolibc/arch-arm.h
+++ b/tools/include/nolibc/arch-arm.h
@@ -202,7 +202,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index 37f813912957..3d672d925e9e 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
index d8ea7e787df4..ad3f266e7093 100644
--- a/tools/include/nolibc/arch-loongarch.h
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -172,7 +172,7 @@ const unsigned long *_auxv __attribute__((weak));
 #endif
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 9860236e5340..db24e0837a39 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -182,7 +182,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code, note that it's called __start on MIPS */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) __start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector __start(void)
 {
 	__asm__ volatile (
 		/*".set nomips16\n"*/
diff --git a/tools/include/nolibc/arch-riscv.h b/tools/include/nolibc/arch-riscv.h
index 86616aeb77a0..a2e8564e66d6 100644
--- a/tools/include/nolibc/arch-riscv.h
+++ b/tools/include/nolibc/arch-riscv.h
@@ -180,7 +180,7 @@ char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
 /* startup code */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 		".option push\n"
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 485a7ff72a87..6fc4d8392742 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -190,7 +190,7 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be zero (the %rbp).
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) __no_stack_protector _start(void)
 {
 	__asm__ volatile (
 #ifdef _NOLIBC_STACKPROTECTOR
diff --git a/tools/include/nolibc/compiler.h b/tools/include/nolibc/compiler.h
index 57da75cea799..beddc3665d69 100644
--- a/tools/include/nolibc/compiler.h
+++ b/tools/include/nolibc/compiler.h
@@ -12,4 +12,14 @@
 
 #endif /* defined(__SSP__) ... */
 
+#if defined(__has_attribute)
+#  if __has_attribute(no_stack_protector)
+#    define __no_stack_protector __attribute__((no_stack_protector))
+#  else
+#    define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
+#  endif
+#else
+#  define __no_stack_protector __attribute__((__optimize__("-fno-stack-protector")))
+#endif /* defined(__has_attribute) */
+
 #endif /* _NOLIBC_COMPILER_H */
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
index 0a89e2b89ca6..88f7b2d098ff 100644
--- a/tools/include/nolibc/stackprotector.h
+++ b/tools/include/nolibc/stackprotector.h
@@ -37,7 +37,7 @@ void __stack_chk_fail_local(void)
 __attribute__((weak,section(".data.nolibc_stack_chk")))
 uintptr_t __stack_chk_guard;
 
-__attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
+__attribute__((weak,section(".text.nolibc_stack_chk"))) __no_stack_protector
 void __stack_chk_init(void)
 {
 	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);

-- 
2.40.1

