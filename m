Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0175A6AF88D
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 23:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjCGWXg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 17:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbjCGWXB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 17:23:01 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C851A4B32;
        Tue,  7 Mar 2023 14:22:44 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678227762;
        bh=7B9eU1poI//tORVnXKk/Isa53ZRzzHKFs17ILGS5uAY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=O14LOF3jp44o43W/cVAfN9UTGrU7Je+MZjmS8/5gJ4yidCy575yHJhQLBk5PMdFBV
         alOFaqyfDBKT6HrppTAb/4QzqYt6ypX8cNQd6df+N+pGhRorDA+VAvuIy4YeoqipFz
         d01UbPM7K8OKyuMzMPTzzciEvgC7rsCKQCHlanIg=
Date:   Tue, 07 Mar 2023 22:22:33 +0000
Subject: [PATCH RFC 4/5] tools/nolibc: add support for stack protector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v1-4-3e74d81b3f21@weissschuh.net>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678227756; l=7186;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7B9eU1poI//tORVnXKk/Isa53ZRzzHKFs17ILGS5uAY=;
 b=0uWbmRx4pY+W8ydurYQGxLqGKtMnVJBCi+t7ihfRpjbO56SVmFC+cnXWLko3NNRsh+oJEUd4n
 aMc2socQ8bFCC9xZ/UrHsR/nm6UWEQSgS8tFlk+Fwj7dTIE+whBYu5+
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Stack protection is a feature to detect and handle stack buffer
overflows at runtime.
For this to work the compiler and libc have to collaborate.

This patch adds the following parts to nolibc that are required by the
compiler:

* __stack_chk_guard: random sentinel value
* __stack_chk_fail: handler for detected stack smashes

In addition an initialization function is added that randomizes the
sentinel value.

Only support for global guards is implemented.
Register guards are useful in multi-threaded context which nolibc does
not provide support for.

Link: https://lwn.net/Articles/584225/

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/Makefile           |  4 +--
 tools/include/nolibc/arch-i386.h        |  8 +++++-
 tools/include/nolibc/arch-x86_64.h      |  5 ++++
 tools/include/nolibc/nolibc.h           |  1 +
 tools/include/nolibc/stackprotector.h   | 48 +++++++++++++++++++++++++++++++++
 tools/testing/selftests/nolibc/Makefile | 12 +++++++++
 6 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index ec57d3932506..9839feafd38a 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -25,8 +25,8 @@ endif
 
 nolibc_arch := $(patsubst arm64,aarch64,$(ARCH))
 arch_file := arch-$(nolibc_arch).h
-all_files := ctype.h errno.h nolibc.h signal.h std.h stdint.h stdio.h stdlib.h \
-             string.h sys.h time.h types.h unistd.h
+all_files := ctype.h errno.h nolibc.h signal.h stackprotector.h std.h stdint.h \
+             stdio.h stdlib.h string.h sys.h time.h types.h unistd.h
 
 # install all headers needed to support a bare-metal compiler
 all: headers
diff --git a/tools/include/nolibc/arch-i386.h b/tools/include/nolibc/arch-i386.h
index e8d0cf545bf1..a8deb123edca 100644
--- a/tools/include/nolibc/arch-i386.h
+++ b/tools/include/nolibc/arch-i386.h
@@ -180,6 +180,9 @@ struct sys_stat_struct {
 
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
+void __stack_chk_init(void) __attribute__((weak));
+
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
 
 /* startup code */
 /*
@@ -188,9 +191,12 @@ const unsigned long *_auxv __attribute__((weak));
  * 2) The deepest stack frame should be set to zero
  *
  */
-void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"),no_stack_protector)) _start(void)
 {
 	__asm__ volatile (
+#ifdef NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"   // initialize stack protector
+#endif
 		"pop %eax\n"                // argc   (first arg, %eax)
 		"mov %esp, %ebx\n"          // argv[] (second arg, %ebx)
 		"lea 4(%ebx,%eax,4),%ecx\n" // then a NULL then envp (third arg, %ecx)
diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index 17f6751208e7..f7f2a11d4c3b 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -181,6 +181,8 @@ struct sys_stat_struct {
 char **environ __attribute__((weak));
 const unsigned long *_auxv __attribute__((weak));
 
+#define __ARCH_SUPPORTS_STACK_PROTECTOR
+
 /* startup code */
 /*
  * x86-64 System V ABI mandates:
@@ -191,6 +193,9 @@ const unsigned long *_auxv __attribute__((weak));
 void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
 {
 	__asm__ volatile (
+#ifdef NOLIBC_STACKPROTECTOR
+		"call __stack_chk_init\n"   // initialize stack protector
+#endif
 		"pop %rdi\n"                // argc   (first arg, %rdi)
 		"mov %rsp, %rsi\n"          // argv[] (second arg, %rsi)
 		"lea 8(%rsi,%rdi,8),%rdx\n" // then a NULL then envp (third arg, %rdx)
diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index b2bc48d3cfe4..04739a6293c4 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -104,6 +104,7 @@
 #include "string.h"
 #include "time.h"
 #include "unistd.h"
+#include "stackprotector.h"
 
 /* Used by programs to avoid std includes */
 #define NOLIBC
diff --git a/tools/include/nolibc/stackprotector.h b/tools/include/nolibc/stackprotector.h
new file mode 100644
index 000000000000..ca1360b7afd8
--- /dev/null
+++ b/tools/include/nolibc/stackprotector.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Stack protector support for NOLIBC
+ * Copyright (C) 2023 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_STACKPROTECTOR_H
+#define _NOLIBC_STACKPROTECTOR_H
+
+#include "arch.h"
+
+#if defined(NOLIBC_STACKPROTECTOR)
+
+#if !defined(__ARCH_SUPPORTS_STACK_PROTECTOR)
+#error "nolibc does not support stack protectors on this arch"
+#endif
+
+#include "sys.h"
+#include "stdlib.h"
+
+__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
+void __stack_chk_fail(void)
+{
+	write(STDERR_FILENO, "!!Stack smashing detected!!\n", 28);
+	abort();
+}
+
+__attribute__((weak,noreturn,section(".text.nolibc_stack_chk")))
+void __stack_chk_fail_local(void)
+{
+	__stack_chk_fail();
+}
+
+__attribute__((weak,section(".data.nolibc_stack_chk")))
+uintptr_t __stack_chk_guard;
+
+__attribute__((weak,no_stack_protector,section(".text.nolibc_stack_chk")))
+void __stack_chk_init(void)
+{
+	// raw syscall assembly as calling a function would trigger the
+	// stackprotector itself
+	my_syscall3(__NR_getrandom, &__stack_chk_guard, sizeof(__stack_chk_guard), 0);
+	// a bit more randomness in case getrandom() fails
+	__stack_chk_guard |= (uintptr_t) &__stack_chk_guard;
+}
+#endif // defined(NOLIBC_STACKPROTECTOR)
+
+#endif // _NOLIBC_STACKPROTECTOR_H
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index ea2b82a3cd86..749a09c9a012 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -1,6 +1,8 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for nolibc tests
 include ../../../scripts/Makefile.include
+# We need this for the "cc-option" macro.
+include ../../../build/Build.include
 
 # we're in ".../tools/testing/selftests/nolibc"
 ifeq ($(srctree),)
@@ -74,7 +76,13 @@ else
 Q=@
 endif
 
+CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
+			$(call cc-option,-mstack-protector-guard=global) \
+			$(call cc-option,-fstack-protector-all)
 CFLAGS_s390 = -m64
+CFLAGS_x86 = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_i386 = $(CFLAGS_STACKPROTECTOR)
+CFLAGS_x86_64 = $(CFLAGS_STACKPROTECTOR)
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables $(CFLAGS_$(ARCH))
 LDFLAGS := -s
 
@@ -118,6 +126,10 @@ nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
 	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
 	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
 
+foo: foo.c sysroot/$(ARCH)/include
+	$(QUIET_CC)$(CC) $(CFLAGS) $(LDFLAGS) -o $@ \
+	  -nostdlib -static -Isysroot/$(ARCH)/include $< -lgcc
+
 # qemu user-land test
 run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :

-- 
2.39.2

