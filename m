Return-Path: <linux-kselftest+bounces-35646-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDDFAE4F7D
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6398C1B60FAA
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4796122256B;
	Mon, 23 Jun 2025 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DoE976Nf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F286E1F3FF8;
	Mon, 23 Jun 2025 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713373; cv=none; b=jsYNZtX+3mYr2PURneP2v7yGbFgsrYZD/i81SPBE7E4qZtgohVDZvfBtEF/LoHSra6PxcOiaF54JyelAcLi9pXfIuMwWJraTMpDxbA1G/9NorHfsxHKxkri9n//6FQploo00wNJGVH+sJ6HjaQV4QcC3MbMpbiveglNLiz6SVV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713373; c=relaxed/simple;
	bh=YpKOiuy7+fqEFDRa7/CBt4BroadQtFTU7CicTLWPDGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kWjv4EzxHeNV/MN2mLiui6iQ3y1Q67Cg24eg9w+LOsb9pNUYVOOPkU3W0PF8lf5zhw5b+dM/r4k9QD6dMqTT3upxXGklm28zl89hPwmQpGTVJU7Oye26k8eIwXzA0766a33yR6fUWrp2TmOJYyw44RAlPHQJOxjygViO5A5CO9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DoE976Nf; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713368;
	bh=YpKOiuy7+fqEFDRa7/CBt4BroadQtFTU7CicTLWPDGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DoE976Nfz4kVeLHcG/ji1c9wlZUaW5CJBL2lTF3t6y7dBFhAZYPsqjrKiSeuTp6ja
	 Hv3Hn/pndA+m0cEXoT0sVnxmlMJWEZ9hbmogAEFpU7SGnuAj/PxU6/jjPcivm7dRbC
	 4PnMl++xjRbfwTpIw7kn0HHJIoNJuY3Z6jUxrOrU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Jun 2025 23:15:54 +0200
Subject: [PATCH v2 3/3] tools/nolibc: add support for SuperH
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-nolibc-sh-v2-3-0f5b4b303025@weissschuh.net>
References: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
In-Reply-To: <20250623-nolibc-sh-v2-0-0f5b4b303025@weissschuh.net>
To: Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Rich Felker <dalias@libc.org>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-sh@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713367; l=13930;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=YpKOiuy7+fqEFDRa7/CBt4BroadQtFTU7CicTLWPDGE=;
 b=Fpi6WPw4V95ew/7knr+a/8HXPNqQ3QyXiJSXpDWuZfibIPUAaLxXM8Ljaf0/3cyUEUWztgsfR
 tusNO9+kxAJCPi1NQB01fAH0al8InP0WGKZ/lwQTE3xGLLruIa+qG2H
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for SuperH/"sh" to nolibc.
Only sh4 is tested for now.

The startup code is special:

__nolibc_entrypoint_epilogue() calls __builtin_unreachable() which emits
a call to abort(). To make this work a function prologue is generated to
set up a GOT pointer which corrupts "sp".
__builtin_unreachable() is necessary for __attribute__((noreturn)).
Also depending on compiler flags (for example -fPIC) even more prologue
is generated.

Work around this by defining a nested function in asm.

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=70216
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-sh.h                 | 162 +++++++++++++++++++++++++
 tools/include/nolibc/arch.h                    |   2 +
 tools/testing/selftests/nolibc/Makefile.nolibc |   7 ++
 tools/testing/selftests/nolibc/run-tests.sh    |   3 +-
 4 files changed, 173 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-sh.h b/tools/include/nolibc/arch-sh.h
new file mode 100644
index 0000000000000000000000000000000000000000..1ad006cba0f627f663eea36b41bc7399cca4addb
--- /dev/null
+++ b/tools/include/nolibc/arch-sh.h
@@ -0,0 +1,162 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * SuperH specific definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_ARCH_SH_H
+#define _NOLIBC_ARCH_SH_H
+
+#include "compiler.h"
+#include "crt.h"
+
+/*
+ * Syscalls for SuperH:
+ *   - registers are 32bit wide
+ *   - syscall number is passed in r3
+ *   - arguments are in r4, r5, r6, r7, r0, r1, r2
+ *   - the system call is performed by calling trapa #31
+ *   - syscall return value is in r0
+ */
+
+#define my_syscall0(num)                                                      \
+({                                                                            \
+	register long _num __asm__ ("r3") = (num);                            \
+	register long _ret __asm__ ("r0");                                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trapa #31"                                                   \
+		: "+r"(_ret)                                                  \
+		: "r"(_num)                                                   \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define my_syscall1(num, arg1)                                                \
+({                                                                            \
+	register long _num __asm__ ("r3") = (num);                            \
+	register long _ret __asm__ ("r0");                                    \
+	register long _arg1 __asm__ ("r4") = (long)(arg1);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trapa #31"                                                   \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1)                                       \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num __asm__ ("r3") = (num);                            \
+	register long _ret __asm__ ("r0");                                    \
+	register long _arg1 __asm__ ("r4") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r5") = (long)(arg2);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trapa #31"                                                   \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2)                           \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)                                    \
+({                                                                            \
+	register long _num __asm__ ("r3") = (num);                            \
+	register long _ret __asm__ ("r0");                                    \
+	register long _arg1 __asm__ ("r4") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r5") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r6") = (long)(arg3);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trapa #31"                                                   \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3)               \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+({                                                                            \
+	register long _num __asm__ ("r3") = (num);                            \
+	register long _ret __asm__ ("r0");                                    \
+	register long _arg1 __asm__ ("r4") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r5") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r6") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r7") = (long)(arg4);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trapa #31"                                                   \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)   \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+({                                                                            \
+	register long _num __asm__ ("r3") = (num);                            \
+	register long _ret __asm__ ("r0");                                    \
+	register long _arg1 __asm__ ("r4") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r5") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r6") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r7") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r0") = (long)(arg5);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trapa #31"                                                   \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),  \
+		  "r"(_arg5)                                                  \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num __asm__ ("r3") = (num);                            \
+	register long _ret __asm__ ("r0");                                    \
+	register long _arg1 __asm__ ("r4") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r5") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r6") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r7") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r0") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("r1") = (long)(arg6);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trapa #31"                                                   \
+		: "=r"(_ret)                                                  \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),  \
+		  "r"(_arg5), "r"(_arg6)                                      \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_ret;                                                                 \
+})
+
+/* startup code */
+void _start_wrapper(void);
+void __attribute__((weak,noreturn)) __nolibc_entrypoint __no_stack_protector _start_wrapper(void)
+{
+	__asm__ volatile (
+		".global _start\n"           /* The C function will have a prologue,         */
+		".type _start, @function\n"  /* corrupting "sp"                              */
+		".weak _start\n"
+		"_start:\n"
+
+		"mov sp, r4\n"               /* save argc pointer to r4, as arg1 of _start_c */
+		"bsr _start_c\n"             /* transfer to c runtime                        */
+		"nop\n"                      /* delay slot                                   */
+
+		".size _start, .-_start\n"
+	);
+	__nolibc_entrypoint_epilogue();
+}
+
+#endif /* _NOLIBC_ARCH_SH_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 4ae57aaf9779610dfb63458416f147116d0a98e6..5a34bce2981eaec557bc3616c7ef7b809a6dbf0b 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -35,6 +35,8 @@
 #include "arch-sparc.h"
 #elif defined(__m68k__)
 #include "arch-m68k.h"
+#elif defined(__sh__)
+#include "arch-sh.h"
 #else
 #error Unsupported Architecture
 #endif
diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index ba3b762cb103ee87aafecbd5e838fc0e678b7b50..41c708419d761df5de9e7df97b2f070396e8cbf3 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -58,6 +58,7 @@ ARCH_riscv64     = riscv
 ARCH_s390x       = s390
 ARCH_sparc32     = sparc
 ARCH_sparc64     = sparc
+ARCH_sh4         = sh
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -81,6 +82,7 @@ IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE_sparc32    = arch/sparc/boot/image
 IMAGE_sparc64    = arch/sparc/boot/image
 IMAGE_m68k       = vmlinux
+IMAGE_sh4        = arch/sh/boot/zImage
 IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
@@ -105,11 +107,13 @@ DEFCONFIG_loongarch  = defconfig
 DEFCONFIG_sparc32    = sparc32_defconfig
 DEFCONFIG_sparc64    = sparc64_defconfig
 DEFCONFIG_m68k       = virt_defconfig
+DEFCONFIG_sh4        = rts7751r2dplus_defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 EXTRACONFIG_arm       = -e CONFIG_NAMESPACES
 EXTRACONFIG_armthumb  = -e CONFIG_NAMESPACES
 EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
+EXTRACONFIG_sh4       = -e CONFIG_BLK_DEV_INITRD -e CONFIG_CMDLINE_FROM_BOOTLOADER
 EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 
 # optional tests to run (default = all)
@@ -136,6 +140,7 @@ QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH_sparc32    = sparc
 QEMU_ARCH_sparc64    = sparc64
 QEMU_ARCH_m68k       = m68k
+QEMU_ARCH_sh4        = sh4
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 QEMU_ARCH_USER_ppc64le = ppc64le
@@ -169,6 +174,7 @@ QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=N
 QEMU_ARGS_sparc32    = -M SS-5 -m 256M -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_sparc64    = -M sun4u -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_m68k       = -M virt -append "console=ttyGF0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_sh4        = -M r2d -serial file:/dev/stdout -append "console=ttySC1,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
@@ -192,6 +198,7 @@ CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_sparc32 = $(call cc-option,-m32)
+CFLAGS_sh4 = -ml -m4
 ifeq ($(origin XARCH),command line)
 CFLAGS_XARCH = $(CFLAGS_$(XARCH))
 endif
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 279fbd93ef70497868689b7f1e14ddc6c5c1a15f..c55d6d3c10bba5df7f7e6413eea496148a5fbf52 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -27,6 +27,7 @@ all_archs=(
 	loongarch
 	sparc32 sparc64
 	m68k
+	sh4
 )
 archs="${all_archs[@]}"
 
@@ -187,7 +188,7 @@ test_arch() {
 		echo "Unsupported configuration"
 		return
 	fi
-	if [ "$arch" = "m68k" ] && [ "$llvm" = "1" ]; then
+	if [ "$arch" = "m68k" -o "$arch" = "sh4" ] && [ "$llvm" = "1" ]; then
 		echo "Unsupported configuration"
 		return
 	fi

-- 
2.50.0


