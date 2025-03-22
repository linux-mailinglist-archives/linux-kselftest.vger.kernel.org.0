Return-Path: <linux-kselftest+bounces-29597-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7D4A6C837
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 09:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17C931896B27
	for <lists+linux-kselftest@lfdr.de>; Sat, 22 Mar 2025 08:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1FD51D5CE8;
	Sat, 22 Mar 2025 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="eEz0AwM5"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6610542052;
	Sat, 22 Mar 2025 08:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742631075; cv=none; b=EibdhtZTE3ONahVoFsBz7U42VcbeKOkCzOhTG2VI1Y/OkUPDbEUKk6N9qKzQ8TF4xdRn8PlYddQegAQ5MwVP2QM1eUTizdr0L53ZlXCEKjQUBU1RCW93mwXqLSF1k68b6rWHkfHZ2fWnhNQYqMfxe5s6mcatdIBNUHfwmOwPrXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742631075; c=relaxed/simple;
	bh=3mJRJDHMlrPaF9fpdmO1kBL5+Ko/Wd4L7orgR9YZccw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LDnXhIqmAB44QfASmaOMVvIphMOoUdwoguGSj5MH3lm6V4VLXDs31O5mROAfdaMGGi/YIxQx9A5LXqtDzKyxePzoGP1H8oGwqNMw/K87bxNjsmSisKrKfrVOiH/ZzeLp6Xbkxz95KNLqwHA6FUva4QLF+SLPnNhs2gT7k4jK2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=eEz0AwM5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742631061;
	bh=3mJRJDHMlrPaF9fpdmO1kBL5+Ko/Wd4L7orgR9YZccw=;
	h=From:Date:Subject:To:Cc:From;
	b=eEz0AwM50djTkRrmR5FEWelcF3YI/orDa6XvFqllfqyL1ylJd5J4plpJIVFid2YrF
	 ozOgFwCs2GTWERpetuLjPbtENxYK2ZOIDTkeY3eCnTZwE7EhNhN7iAryUVDx+ervzX
	 0nXQ68WOtNLRdJ9A2jdGAZRcehcj3q/YGmytWDBM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 22 Mar 2025 09:10:51 +0100
Subject: [PATCH v2] tools/nolibc: Add support for SPARC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250322-nolibc-sparc-v2-1-89af018c6296@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIpw3mcC/13NwQ6CMAzG8VchPTvDiohy8j0MhzGKa2I2siJqy
 N7diTeP/y/prysIRSaBtlgh0sLCwefAXQHWGX8jxUNuwBLrEvGofLhzb5VMJlpl+vHQNPVgT7q
 CfDJFGvm1cdcut2OZQ3xv+qK/6w+q9B+0aKUV0rnJP4aa0F6exCJi3cPtPc3QpZQ+v+sQla0AA
 AA=
X-Change-ID: 20250226-nolibc-sparc-abf4775dc813
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, Chris Torek <chris.torek@gmail.com>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742631061; l=14265;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=3mJRJDHMlrPaF9fpdmO1kBL5+Ko/Wd4L7orgR9YZccw=;
 b=msqva+7I3IzpEBW/Xw49b7MmcH72i58+ObkVc/OstVs9m7IlSeyauXcXgvmsw7j4aCWLSY/PS
 Agvh8qCze6hA9reQhHNCH7zVmCc0vjG943Rs7oa5f2tww4Tku7eTI5g
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for 32bit and 64bit SPARC to nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Acked-by: Willy Tarreau <w@1wt.eu>
Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc> # UltraSparc T4 (Niagara4)
---
This is only tested on QEMU.
Any tests on real hardware would be very welcome.
---
Changes in v2:
- Pick up tags
- Fix comment about syscall return register
- Reword comment about stackpointer offsets
- Link to v1: https://lore.kernel.org/r/20250316-nolibc-sparc-v1-1-2e97022d5e2c@weissschuh.net
---
 tools/include/nolibc/arch-sparc.h           | 191 ++++++++++++++++++++++++++++
 tools/include/nolibc/arch.h                 |   2 +
 tools/testing/selftests/nolibc/Makefile     |  11 ++
 tools/testing/selftests/nolibc/run-tests.sh |   2 +
 4 files changed, 206 insertions(+)

diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
new file mode 100644
index 0000000000000000000000000000000000000000..1435172f3dfe33566cd8c61d726455702c804f6a
--- /dev/null
+++ b/tools/include/nolibc/arch-sparc.h
@@ -0,0 +1,191 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * SPARC (32bit and 64bit) specific definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_ARCH_SPARC_H
+#define _NOLIBC_ARCH_SPARC_H
+
+#include <linux/unistd.h>
+
+#include "compiler.h"
+#include "crt.h"
+
+/*
+ * Syscalls for SPARC:
+ *   - registers are native word size
+ *   - syscall number is passed in g1
+ *   - arguments are in o0-o5
+ *   - the system call is performed by calling a trap instruction
+ *   - syscall return value is in o0
+ *   - syscall error flag is in the carry bit of the processor status register
+ */
+
+#ifdef __arch64__
+
+#define _NOLIBC_SYSCALL "t	0x6d\n"                                       \
+			"bcs,a	%%xcc, 1f\n"                                  \
+			"sub	%%g0, %%o0, %%o0\n"                           \
+			"1:\n"
+
+#else
+
+#define _NOLIBC_SYSCALL "t	0x10\n"                                       \
+			"bcs,a	1f\n"                                         \
+			"sub	%%g0, %%o0, %%o0\n"                           \
+			"1:\n"
+
+#endif /* __arch64__ */
+
+#define my_syscall0(num)                                                      \
+({                                                                            \
+	register long _num  __asm__ ("g1") = (num);                           \
+	register long _arg1 __asm__ ("o0");                                   \
+									      \
+	__asm__ volatile (                                                    \
+		_NOLIBC_SYSCALL                                               \
+		: "+r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall1(num, arg1)                                                \
+({                                                                            \
+	register long _num  __asm__ ("g1") = (num);                           \
+	register long _arg1 __asm__ ("o0") = (long)(arg1);                    \
+									      \
+	__asm__ volatile (                                                    \
+		_NOLIBC_SYSCALL                                               \
+		: "+r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("g1") = (num);                           \
+	register long _arg1 __asm__ ("o0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("o1") = (long)(arg2);                    \
+									      \
+	__asm__ volatile (                                                    \
+		_NOLIBC_SYSCALL                                               \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_num)                                       \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)                                    \
+({                                                                            \
+	register long _num  __asm__ ("g1") = (num);                           \
+	register long _arg1 __asm__ ("o0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("o1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("o2") = (long)(arg3);                    \
+									      \
+	__asm__ volatile (                                                    \
+		_NOLIBC_SYSCALL                                               \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_num)                           \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+({                                                                            \
+	register long _num  __asm__ ("g1") = (num);                           \
+	register long _arg1 __asm__ ("o0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("o1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("o2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("o3") = (long)(arg4);                    \
+									      \
+	__asm__ volatile (                                                    \
+		_NOLIBC_SYSCALL                                               \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_num)               \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+({                                                                            \
+	register long _num  __asm__ ("g1") = (num);                           \
+	register long _arg1 __asm__ ("o0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("o1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("o2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("o3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("o4") = (long)(arg5);                    \
+									      \
+	__asm__ volatile (                                                    \
+		_NOLIBC_SYSCALL                                               \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_num)   \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num  __asm__ ("g1") = (num);                           \
+	register long _arg1 __asm__ ("o0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("o1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("o2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("o3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("o4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("o5") = (long)(arg6);                    \
+									      \
+	__asm__ volatile (                                                    \
+		_NOLIBC_SYSCALL                                               \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
+		  "r"(_num)                                                   \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+/* startup code */
+void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+		/*
+		 * Save argc pointer to o0, as arg1 of _start_c.
+		 * Account for the window save area, which is 16 registers wide.
+		 */
+#ifdef __arch64__
+		"add %sp, 128 + 2047, %o0\n" /* on sparc64 / v9 the stack is offset by 2047 */
+#else
+		"add %sp, 64, %o0\n"
+#endif
+		"b,a _start_c\n"     /* transfer to c runtime */
+	);
+	__nolibc_entrypoint_epilogue();
+}
+
+static pid_t getpid(void);
+
+static __attribute__((unused))
+pid_t sys_fork(void)
+{
+	pid_t parent, ret;
+
+	parent = getpid();
+	ret = my_syscall0(__NR_fork);
+
+	/* The syscall returns the parent pid in the child instead of 0 */
+	if (ret == parent)
+		return 0;
+	else
+		return ret;
+}
+#define sys_fork sys_fork
+
+#endif /* _NOLIBC_ARCH_SPARC_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 8a2c143c0fba288147e5a7bf9db38ffb08367616..b8c1da9a88d1593d5a97f60909ede5d0c17699eb 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -33,6 +33,8 @@
 #include "arch-s390.h"
 #elif defined(__loongarch__)
 #include "arch-loongarch.h"
+#elif defined(__sparc__)
+#include "arch-sparc.h"
 #else
 #error Unsupported Architecture
 #endif
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 58bcbbd029bc3ad9ccac968191b703ccf5df0717..5060e189dc842d761dd13d70b8afdb2ff3390bc5 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -56,6 +56,8 @@ ARCH_mips32be    = mips
 ARCH_riscv32     = riscv
 ARCH_riscv64     = riscv
 ARCH_s390x       = s390
+ARCH_sparc32     = sparc
+ARCH_sparc64     = sparc
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -76,6 +78,8 @@ IMAGE_riscv64    = arch/riscv/boot/Image
 IMAGE_s390x      = arch/s390/boot/bzImage
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
+IMAGE_sparc32    = arch/sparc/boot/image
+IMAGE_sparc64    = arch/sparc/boot/image
 IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
@@ -97,6 +101,8 @@ DEFCONFIG_riscv64    = defconfig
 DEFCONFIG_s390x      = defconfig
 DEFCONFIG_s390       = defconfig compat.config
 DEFCONFIG_loongarch  = defconfig
+DEFCONFIG_sparc32    = sparc32_defconfig
+DEFCONFIG_sparc64    = sparc64_defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
@@ -122,6 +128,8 @@ QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_s390x      = s390x
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
+QEMU_ARCH_sparc32    = sparc
+QEMU_ARCH_sparc64    = sparc64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 QEMU_ARCH_USER_ppc64le = ppc64le
@@ -152,6 +160,8 @@ QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_T
 QEMU_ARGS_s390x      = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_sparc32    = -M SS-5 -m 256M -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_sparc64    = -M sun4u -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
@@ -174,6 +184,7 @@ CFLAGS_s390x = -m64
 CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
+CFLAGS_sparc32 = $(call cc-option,-m32)
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 0299a0912d4049dd12217f9835b81d231e1d2bfd..040956a9f5b8dda3e78abc0d4b6073f4fcd9e3ee 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -25,6 +25,7 @@ all_archs=(
 	riscv32 riscv64
 	s390x s390
 	loongarch
+	sparc32 sparc64
 )
 archs="${all_archs[@]}"
 
@@ -111,6 +112,7 @@ crosstool_arch() {
 	loongarch) echo loongarch64;;
 	mips*) echo mips;;
 	s390*) echo s390;;
+	sparc*) echo sparc64;;
 	*) echo "$1";;
 	esac
 }

---
base-commit: bceb73904c855c78402dca94c82915f078f259dd
change-id: 20250226-nolibc-sparc-abf4775dc813

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


