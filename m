Return-Path: <linux-kselftest+bounces-29155-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B71A635E3
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 14:55:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A8233B0C6F
	for <lists+linux-kselftest@lfdr.de>; Sun, 16 Mar 2025 13:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD101A8405;
	Sun, 16 Mar 2025 13:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="meRnwAQE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F721A2C04;
	Sun, 16 Mar 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742133321; cv=none; b=HWtDc593neeQr7Fj6AgMEt+RvTGPftRPhAA4MKf/sTIUK/3J/XvSORV26kZ/DC6Cju4xXj4fAcbZ1Io1ED9GuaG2uU3K4Uo4yqPojVYhgLrrDvwxp747Gk5TcZeLVfbo0LSbF08aG5meb0hg9JpHlwKBRP6BWAUWMHO0Tizapnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742133321; c=relaxed/simple;
	bh=GZRiOrF8j+cWZZAKUw4Qamv4DWEEg8LV7FygrkdVVbs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bN7Ypy2PreTh9ugu5lT6kKhcHKdfHDBB2CzZkr4j82i8DN/GQ+Eg7H61uj33et1lb1aZyQt0XbYmYpT04PIuFFiQbFSjYTBzNJjpEoixniPzjwJ1yIQ6b1Dppp2ckK5XmmhyFH99tIst1G0tnynRi/yGtewHJdqcCsC3kbprdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=meRnwAQE; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1742133307;
	bh=GZRiOrF8j+cWZZAKUw4Qamv4DWEEg8LV7FygrkdVVbs=;
	h=From:Date:Subject:To:Cc:From;
	b=meRnwAQEV2V0hPiGC9dL85g6vYjKtKgd4n1zp7wwE1qlCRiAGXbCbRgXQRFwSMfeZ
	 B7MHcnGfYWpAZoEWa6B5G3bCEH2toO6nJ2m6ehHZoTVBmKGX+cCtCZJoVWhe2aPgNH
	 d5bpSP/aVXLlSyUGc6Vonnyx2pdfgnhR+c2rTFy4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 16 Mar 2025 14:55:02 +0100
Subject: [PATCH] tools/nolibc: Add support for SPARC
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250316-nolibc-sparc-v1-1-2e97022d5e2c@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADXY1mcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDIyMz3bz8nMykZN3igsSiZN3EpDQTc3PTlGQLQ2MloJaCotS0zAqwcdG
 xtbUAw9KG3l4AAAA=
X-Change-ID: 20250226-nolibc-sparc-abf4775dc813
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, 
 Andreas Larsson <andreas@gaisler.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 sparclinux@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742133306; l=13849;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=GZRiOrF8j+cWZZAKUw4Qamv4DWEEg8LV7FygrkdVVbs=;
 b=q9Y5UPTXq8sEnecv0q5GBE0nDUNXrPKZnU4UNhZsPhHhciZHIB1WvFkzepwhbKVqR6rGAFcrd
 K4JBdEeWfD3C8MCtAKpfTfTxkHmrvk1ACRifPfIwXy0VUJGPGR7nIj6
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for 32bit and 64bit SPARC to nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
This is only tested on QEMU.
Any tests on real hardware would be very welcome.
---
 tools/include/nolibc/arch-sparc.h           | 191 ++++++++++++++++++++++++++++
 tools/include/nolibc/arch.h                 |   2 +
 tools/testing/selftests/nolibc/Makefile     |  11 ++
 tools/testing/selftests/nolibc/run-tests.sh |   2 +
 4 files changed, 206 insertions(+)

diff --git a/tools/include/nolibc/arch-sparc.h b/tools/include/nolibc/arch-sparc.h
new file mode 100644
index 0000000000000000000000000000000000000000..cb5543eca87bb4d52cfba4c0668e35cbbf6dd124
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
+ *   - syscall return value is in 0a
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
+		 * Save stack pointer to o0, as arg1 of _start_c.
+		 * Account for window save area and stack bias.
+		 */
+#ifdef __arch64__
+		"add %sp, 128 + 2047, %o0\n"
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


