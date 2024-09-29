Return-Path: <linux-kselftest+bounces-18551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E66E9897FD
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 23:47:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38955282B26
	for <lists+linux-kselftest@lfdr.de>; Sun, 29 Sep 2024 21:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7732A17BED0;
	Sun, 29 Sep 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="lqi3T4Ro"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6BC768E1;
	Sun, 29 Sep 2024 21:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727646471; cv=none; b=ml7AkzG+ojCZM3RbrCGlDpnYBgoOwocTtKGHQ2Ls3ByZjMVWR0SfS8nXhRVKoXcKwXOuviNuJYWRTJJomUmZy9Wd32FtOz/VDKn5x16beUpiLkewYbLk6ANV/yG88aMspW3z1w/KiTrNqYV4NUHan2ys9kjalFQZ02YU+MGG9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727646471; c=relaxed/simple;
	bh=kt49PtAybWU6qeBrvK9KHknH5KAfe1qC7aTKAetqLQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k9tHMMArFOgIULOJmdnePlhJJOB0NxFpfFsaXzAuWadI8lRYYw2Jfqsjrl4BwWC+xtAW1D2D/m0TVmydJgZmSf/BtodII73xcEw6GtAk4y9z+4JKReqPReb0Xm2BS9sqM5hrB3am7av1YOfHbSWnYxRYBwbTVDhvLbh8Xy5f6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=lqi3T4Ro; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1727646464;
	bh=kt49PtAybWU6qeBrvK9KHknH5KAfe1qC7aTKAetqLQU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lqi3T4Rof3pcEBQn9Txflv6Rl8qZ3R7I2czIVsAYeNyosxPBt5I2bBK/XCFzeT1q9
	 zczc8gkoWcllZj0oz2mlWIZ5j/cgvp+AtRG7GNI8xKaGww2vFnr0pMntTiJZR+lAfV
	 hPxXOSQIrVcXKi6D1msI1LUh8slGmJVpf3X9namM=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 29 Sep 2024 23:47:39 +0200
Subject: [PATCH 4/5] tools/nolibc: add csky support
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240929-nolibc-csky-v1-4-bb28031a73b0@weissschuh.net>
References: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
In-Reply-To: <20240929-nolibc-csky-v1-0-bb28031a73b0@weissschuh.net>
To: Guo Ren <guoren@kernel.org>, Willy Tarreau <w@1wt.eu>, 
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727646464; l=14066;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kt49PtAybWU6qeBrvK9KHknH5KAfe1qC7aTKAetqLQU=;
 b=28wJKP4GSe3f4ZHO5k7yeetugZfYRZKOlRHphSaay8uGd/N2oOkRWCtCmQCbCT7Mo4ZcbJgKu
 sOCfW3ALEZXAGJJGSuSm8o2EHpTlJ318zEWDaBhAm5S8zUFnZWs/aKQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for the C-SKY architecture, which is very similar to
LoongArch.
Only v2 ABI is supported.
Optimizations are disabled as the compiler[0] seems to misoptimize the
code, especially the r4 register gets clobbered.
Compile the initramfs directly into the kernel, as qemu does not support
passing the initrd via OF.

There is no qemu mainline support for qemu.
Testing was done with commit 1f172a2c7cd5c2e7 of the downstream csky qemu [1].
Some tiny changes were necessary on top [2].

[0] gcc 13.2.0 and 14.2.0 from kernel.org crosstools
[1] https://github.com/XUANTIE-RV/qemu/
[2]

diff --git a/target/csky/cpu-param.h b/target/csky/cpu-param.h
index 80554cc0fc03..9181b602a26f 100644
--- a/target/csky/cpu-param.h
+++ b/target/csky/cpu-param.h
@@ -24,11 +24,7 @@
 #define TARGET_PAGE_BITS    12
 #define TARGET_PHYS_ADDR_SPACE_BITS 32

-#ifdef CONFIG_USER_ONLY
-#define TARGET_VIRT_ADDR_SPACE_BITS 30
-#else
 #define TARGET_VIRT_ADDR_SPACE_BITS 32
-#endif
 #define TCG_GUEST_DEFAULT_MO      (0)

 #endif
diff --git a/target/csky/op_vdsp2.c b/target/csky/op_vdsp2.c
index a9985a03be33..d953f5ea94fe 100644
--- a/target/csky/op_vdsp2.c
+++ b/target/csky/op_vdsp2.c
@@ -4784,7 +4784,7 @@ void VDSP2_HELPER(vmulae)(CPUCSKYState *env, uint32_t insn)

     wid = ((insn >> 20) & 0x1) | ((insn >> 24) & 0x2);
     lng = 8 * pow(2, wid);
-    cnt = 128 / lng;
+    cnt = 64 / lng;
     sign = (insn >> CSKY_VDSP2_SIGN_SHI) & CSKY_VDSP2_SIGN_MASK;
     rx = (insn >> CSKY_VDSP2_VREG_SHI_VRX) & CSKY_VDSP2_VREG_MASK;
     ry = (insn >> CSKY_VDSP2_VREG_SHI_VRY) & CSKY_VDSP2_VREG_MASK;

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-csky.h        | 161 ++++++++++++++++++++++++++++++++
 tools/include/nolibc/arch.h             |   2 +
 tools/testing/selftests/nolibc/Makefile |   8 ++
 3 files changed, 171 insertions(+)

diff --git a/tools/include/nolibc/arch-csky.h b/tools/include/nolibc/arch-csky.h
new file mode 100644
index 0000000000000000000000000000000000000000..158e5499375c22a6572321337ba4e2b8162d0d65
--- /dev/null
+++ b/tools/include/nolibc/arch-csky.h
@@ -0,0 +1,161 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * C-SKY specific definitions for NOLIBC
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ * Copyright (C) 2024 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_ARCH_CSKY_H
+#define _NOLIBC_ARCH_CSKY_H
+
+#include "compiler.h"
+#include "crt.h"
+
+#if __csky__ != 2
+#error Unsupported csky ABI
+#endif
+
+/* Syscalls for C-SKY :
+ *   - stack is 8-byte aligned
+ *   - syscall number is passed in r7
+ *   - arguments are in r0, r1, r2, r3, r4, r5
+ *   - the system call is performed by calling "trap 0"
+ *   - syscall return comes in r0
+ *   - the arguments are cast to long and assigned into the target
+ *     registers which are then simply passed as registers to the asm code,
+ *     so that we don't have to experience issues with register constraints.
+ */
+
+#define _NOLIBC_SYSCALL_CLOBBERLIST \
+	"memory", "t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"
+
+#define my_syscall0(num)                                                      \
+({                                                                            \
+	register long _num  __asm__ ("r7") = (num);                           \
+	register long _arg1 __asm__ ("r0");                                   \
+									      \
+	__asm__ volatile (                                                    \
+		"trap 0\n"                                                    \
+		: "=r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall1(num, arg1)                                                \
+({                                                                            \
+	register long _num  __asm__ ("r7") = (num);                           \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap 0\n"                                                    \
+		: "+r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("r7") = (num);                           \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap 0\n"                                                    \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2),                                                 \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)                                    \
+({                                                                            \
+	register long _num  __asm__ ("r7") = (num);                           \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap 0\n"                                                    \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3),                                     \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+({                                                                            \
+	register long _num  __asm__ ("r7") = (num);                           \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap 0\n"                                                    \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+({                                                                            \
+	register long _num  __asm__ ("r7") = (num);                           \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap 0\n"                                                    \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num  __asm__ ("r7") = (num);                           \
+	register long _arg1 __asm__ ("r0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("r1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("r2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("r3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("r4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("r5") = (long)(arg6);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"trap 0\n"                                                    \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
+		  "r"(_num)                                                   \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+/* startup code */
+void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+		"mov           r0, sp\n"     /* save stack pointer to r0, as arg1 of _start_c */
+		"andni         sp, sp, 8\n"  /* sp must be 8-byte aligned in the callee       */
+		"jbsr          _start_c\n"   /* transfer to c runtime                         */
+	);
+	__nolibc_entrypoint_epilogue();
+}
+
+#endif /* _NOLIBC_ARCH_CSKY_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index c8f4e5d3add9eb5b8a438900c084dc0449fcfbd6..71cdf1eedb2045b9abd22146c72ee891765ad553 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -33,6 +33,8 @@
 #include "arch-s390.h"
 #elif defined(__loongarch__)
 #include "arch-loongarch.h"
+#elif defined(__csky__)
+#include "arch-csky.h"
 #else
 #error Unsupported Architecture
 #endif
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index e8278924cf28f17144044e69724df1d4fde141a3..2f51d8ea45f1c0658584f27553a9c8e1ecf428a9 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -67,6 +67,7 @@ IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
+IMAGE_csky       = arch/csky/boot/Image
 IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
@@ -84,9 +85,11 @@ DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
+DEFCONFIG_csky       = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 EXTRACONFIG_mips32be = -d CONFIG_CPU_LITTLE_ENDIAN -e CONFIG_CPU_BIG_ENDIAN
+EXTRACONFIG_csky     = -e CONFIG_BLK_DEV_INITRD -e CONFIG_VIRT_DRIVERS -e CONFIG_CSKY_EXIT
 EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 
 # optional tests to run (default = all)
@@ -106,6 +109,7 @@ QEMU_ARCH_ppc64le    = ppc64
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
+QEMU_ARCH_csky       = cskyv2
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 QEMU_ARCH_USER_ppc64le = ppc64le
@@ -132,8 +136,11 @@ QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_csky       = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
+QEMU_RUN_STANDALONE_csky = 1
+
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
 OUTPUT ?= $(CURDIR)/
@@ -151,6 +158,7 @@ CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
+CFLAGS_csky = -O0
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) \

-- 
2.46.2


