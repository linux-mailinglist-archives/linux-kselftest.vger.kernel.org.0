Return-Path: <linux-kselftest+bounces-35648-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D956AE5084
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 23:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E9E4402CC
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 21:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C1F2222B7;
	Mon, 23 Jun 2025 21:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CoxXizIW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B47D1E51FA;
	Mon, 23 Jun 2025 21:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713946; cv=none; b=l/4dOl9AoVBNvhqH2U+0kAy6ljU5lESy5l2CxJ75C4v8Omg5ODjsxXvFf1LSD9wiglQ+J1BatgktjlGtgtEyc5YQBlFd0S2CKDxPMfRn6JniOLQrka3G02xTgfWhRRQuYO3g1ZkvPaUzmf8b60eU+9V13IV387em3TLccOK9j0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713946; c=relaxed/simple;
	bh=UeQDK9ENQ7vUtQyrUkOq5dcJzYpYWfOhsPHIfj1iITM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cBIwq0UIWR2sMHZmANyHLNbFyzGZKSGIcgY0JCWb6xwQodODB5Rom2olbyGkJaeWsWwx+azeROkR5R0lENd0DC5s6wcQAP4qiO/Q0gorl/K5CAIoTmYjopYgZPdYVdpyZ6TRnE08+iou4XIY/W3yaMBuMdOStldma5+SFm/+9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CoxXizIW; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1750713942;
	bh=UeQDK9ENQ7vUtQyrUkOq5dcJzYpYWfOhsPHIfj1iITM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CoxXizIW+zt23YgX9hL6aDtyR+6dStg/ArgBUfBGU+NvbJa/SrbWXY2oRjP5gqI2m
	 VyjAVfHA4J706yFRVCR4jgNw2DGoqp1i0eQcQTczeV/msqMA4tkaV/DeqBPFG1c0Jv
	 +Ek5aRkMm/QUWu6wtkihp592R/E81shvYqY2F6BU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 23 Jun 2025 23:25:39 +0200
Subject: [PATCH v3 4/4] tools/nolibc: MIPS: add support for N64 and N32
 ABIs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250623-nolibc-mips-n32-v3-4-6ae2d89f4259@weissschuh.net>
References: <20250623-nolibc-mips-n32-v3-0-6ae2d89f4259@weissschuh.net>
In-Reply-To: <20250623-nolibc-mips-n32-v3-0-6ae2d89f4259@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750713941; l=15927;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UeQDK9ENQ7vUtQyrUkOq5dcJzYpYWfOhsPHIfj1iITM=;
 b=eh141JVPYa/Hx3BdzR2cslKxpOvpD/40HYaLrS0vPt2xxDo7mm9I29mAbnesO9Xjqc56nLXd+
 OChk5v/lnOSD+YtP9o2n8Z/boEd740VwuOVZLqfg2KJqupexatsMqMj
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for the MIPS 64bit N64 and ILP32 N32 ABIs.

In addition to different byte orders and ABIs there are also different
releases of the MIPS architecture. To avoid blowing up the test matrix,
only add a subset of all possible test combinations.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Tested-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
---
 tools/include/nolibc/arch-mips.h               | 105 +++++++++++++++++++++----
 tools/testing/selftests/nolibc/Makefile.nolibc |  26 ++++++
 tools/testing/selftests/nolibc/run-tests.sh    |   2 +-
 3 files changed, 117 insertions(+), 16 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 4f0b969f66af610d3c986f3ff0e1c3f3a0be16b5..0cbac63b249adf80ecbf70ba074f9ea5d56d9278 100644
--- a/tools/include/nolibc/arch-mips.h
+++ b/tools/include/nolibc/arch-mips.h
@@ -10,7 +10,7 @@
 #include "compiler.h"
 #include "crt.h"
 
-#if !defined(_ABIO32)
+#if !defined(_ABIO32) && !defined(_ABIN32) && !defined(_ABI64)
 #error Unsupported MIPS ABI
 #endif
 
@@ -32,11 +32,32 @@
  *   - the arguments are cast to long and assigned into the target registers
  *     which are then simply passed as registers to the asm code, so that we
  *     don't have to experience issues with register constraints.
+ *
+ * Syscalls for MIPS ABI N32, same as ABI O32 with the following differences :
+ *   - arguments are in a0, a1, a2, a3, t0, t1, t2, t3.
+ *     t0..t3 are also known as a4..a7.
+ *   - stack is 16-byte aligned
  */
 
+#if defined(_ABIO32)
+
 #define _NOLIBC_SYSCALL_CLOBBERLIST \
 	"memory", "cc", "at", "v1", "hi", "lo", \
 	"t0", "t1", "t2", "t3", "t4", "t5", "t6", "t7", "t8", "t9"
+#define _NOLIBC_SYSCALL_STACK_RESERVE "addiu $sp, $sp, -32\n"
+#define _NOLIBC_SYSCALL_STACK_UNRESERVE "addiu $sp, $sp, 32\n"
+
+#else /* _ABIN32 || _ABI64 */
+
+/* binutils, GCC and clang disagree about register aliases, use numbers instead. */
+#define _NOLIBC_SYSCALL_CLOBBERLIST \
+	"memory", "cc", "at", "v1", \
+	"10", "11", "12", "13", "14", "15", "24", "25"
+
+#define _NOLIBC_SYSCALL_STACK_RESERVE
+#define _NOLIBC_SYSCALL_STACK_UNRESERVE
+
+#endif /* _ABIO32 */
 
 #define my_syscall0(num)                                                      \
 ({                                                                            \
@@ -44,9 +65,9 @@
 	register long _arg4 __asm__ ("a3");                                   \
 									      \
 	__asm__ volatile (                                                    \
-		"addiu $sp, $sp, -32\n"                                       \
+		_NOLIBC_SYSCALL_STACK_RESERVE                                 \
 		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
+		_NOLIBC_SYSCALL_STACK_UNRESERVE                               \
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "r"(_num)                                                   \
 		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
@@ -61,9 +82,9 @@
 	register long _arg4 __asm__ ("a3");                                   \
 									      \
 	__asm__ volatile (                                                    \
-		"addiu $sp, $sp, -32\n"                                       \
+		_NOLIBC_SYSCALL_STACK_RESERVE                                 \
 		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
+		_NOLIBC_SYSCALL_STACK_UNRESERVE                               \
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "0"(_num),                                                  \
 		  "r"(_arg1)                                                  \
@@ -80,9 +101,9 @@
 	register long _arg4 __asm__ ("a3");                                   \
 									      \
 	__asm__ volatile (                                                    \
-		"addiu $sp, $sp, -32\n"                                       \
+		_NOLIBC_SYSCALL_STACK_RESERVE                                 \
 		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
+		_NOLIBC_SYSCALL_STACK_UNRESERVE                               \
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2)                                      \
@@ -100,9 +121,9 @@
 	register long _arg4 __asm__ ("a3");                                   \
 									      \
 	__asm__ volatile (                                                    \
-		"addiu $sp, $sp, -32\n"                                       \
+		_NOLIBC_SYSCALL_STACK_RESERVE                                 \
 		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
+		_NOLIBC_SYSCALL_STACK_UNRESERVE                               \
 		: "=r"(_num), "=r"(_arg4)                                     \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3)                          \
@@ -120,9 +141,9 @@
 	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
 									      \
 	__asm__ volatile (                                                    \
-		"addiu $sp, $sp, -32\n"                                       \
+		_NOLIBC_SYSCALL_STACK_RESERVE                                 \
 		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
+		_NOLIBC_SYSCALL_STACK_UNRESERVE                               \
 		: "=r" (_num), "=r"(_arg4)                                    \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)              \
@@ -131,6 +152,8 @@
 	_arg4 ? -_num : _num;                                                 \
 })
 
+#if defined(_ABIO32)
+
 #define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
 ({                                                                            \
 	register long _num __asm__ ("v0") = (num);                            \
@@ -141,10 +164,10 @@
 	register long _arg5 = (long)(arg5);                                   \
 									      \
 	__asm__ volatile (                                                    \
-		"addiu $sp, $sp, -32\n"                                       \
+		_NOLIBC_SYSCALL_STACK_RESERVE                                 \
 		"sw %7, 16($sp)\n"                                            \
 		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
+		_NOLIBC_SYSCALL_STACK_UNRESERVE                               \
 		: "=r" (_num), "=r"(_arg4)                                    \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
@@ -164,11 +187,53 @@
 	register long _arg6 = (long)(arg6);                                   \
 									      \
 	__asm__ volatile (                                                    \
-		"addiu $sp, $sp, -32\n"                                       \
+		_NOLIBC_SYSCALL_STACK_RESERVE                                 \
 		"sw %7, 16($sp)\n"                                            \
 		"sw %8, 20($sp)\n"                                            \
 		"syscall\n"                                                   \
-		"addiu $sp, $sp, 32\n"                                        \
+		_NOLIBC_SYSCALL_STACK_UNRESERVE                               \
+		: "=r" (_num), "=r"(_arg4)                                    \
+		: "0"(_num),                                                  \
+		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
+		  "r"(_arg6)                                                  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg4 ? -_num : _num;                                                 \
+})
+
+#else /* _ABIN32 || _ABI64 */
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+({                                                                            \
+	register long _num __asm__ ("v0") = (num);                            \
+	register long _arg1 __asm__ ("$4") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("$5") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("$6") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("$7") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("$8") = (long)(arg5);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"syscall\n"                                                   \
+		: "=r" (_num), "=r"(_arg4)                                    \
+		: "0"(_num),                                                  \
+		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5)  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg4 ? -_num : _num;                                                 \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num __asm__ ("v0")  = (num);                           \
+	register long _arg1 __asm__ ("$4") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("$5") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("$6") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("$7") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("$8") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("$9") = (long)(arg6);                    \
+									      \
+	__asm__ volatile (                                                    \
+		"syscall\n"                                                   \
 		: "=r" (_num), "=r"(_arg4)                                    \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -178,15 +243,25 @@
 	_arg4 ? -_num : _num;                                                 \
 })
 
+#endif /* _ABIO32 */
+
 /* startup code, note that it's called __start on MIPS */
 void __start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __start(void)
 {
 	__asm__ volatile (
 		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
+#if defined(_ABIO32)
 		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
+#endif /* _ABIO32 */
 		"lui $t9, %hi(_start_c)\n" /* ABI requires current function address in $t9 */
 		"ori $t9, %lo(_start_c)\n"
+#if defined(_ABI64)
+		"lui  $t0, %highest(_start_c)\n"
+		"ori  $t0, %higher(_start_c)\n"
+		"dsll $t0, 0x20\n"
+		"or   $t9, $t0\n"
+#endif /* _ABI64 */
 		"jalr $t9\n"             /* transfer to c runtime                          */
 	);
 	__nolibc_entrypoint_epilogue();
diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 6d62f350d0c16405785a8aabc7f5741b82e55370..9b56191b10b3c2a12da8ae22a41d57167b63707e 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -53,6 +53,10 @@ ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
 ARCH_mips32le    = mips
 ARCH_mips32be    = mips
+ARCH_mipsn32le   = mips
+ARCH_mipsn32be   = mips
+ARCH_mips64le    = mips
+ARCH_mips64be    = mips
 ARCH_riscv32     = riscv
 ARCH_riscv64     = riscv
 ARCH_s390x       = s390
@@ -69,6 +73,10 @@ IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_armthumb   = arch/arm/boot/zImage
 IMAGE_mips32le   = vmlinuz
 IMAGE_mips32be   = vmlinuz
+IMAGE_mipsn32le  = vmlinuz
+IMAGE_mipsn32be  = vmlinuz
+IMAGE_mips64le   = vmlinuz
+IMAGE_mips64be   = vmlinuz
 IMAGE_ppc        = vmlinux
 IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
@@ -93,6 +101,10 @@ DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_armthumb   = multi_v7_defconfig
 DEFCONFIG_mips32le   = malta_defconfig
 DEFCONFIG_mips32be   = malta_defconfig generic/eb.config
+DEFCONFIG_mipsn32le  = malta_defconfig generic/64r2.config
+DEFCONFIG_mipsn32be  = malta_defconfig generic/64r6.config generic/eb.config
+DEFCONFIG_mips64le   = malta_defconfig generic/64r6.config
+DEFCONFIG_mips64be   = malta_defconfig generic/64r2.config generic/eb.config
 DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
@@ -124,6 +136,10 @@ QEMU_ARCH_arm        = arm
 QEMU_ARCH_armthumb   = arm
 QEMU_ARCH_mips32le   = mipsel  # works with malta_defconfig
 QEMU_ARCH_mips32be  = mips
+QEMU_ARCH_mipsn32le  = mips64el
+QEMU_ARCH_mipsn32be  = mips64
+QEMU_ARCH_mips64le   = mips64el
+QEMU_ARCH_mips64be   = mips64
 QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64
@@ -139,6 +155,8 @@ QEMU_ARCH_m68k       = m68k
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 QEMU_ARCH_USER_ppc64le = ppc64le
+QEMU_ARCH_USER_mipsn32le = mipsn32el
+QEMU_ARCH_USER_mipsn32be = mipsn32
 QEMU_ARCH_USER         = $(or $(QEMU_ARCH_USER_$(XARCH)),$(QEMU_ARCH_$(XARCH)))
 
 QEMU_BIOS_DIR = /usr/share/edk2/
@@ -157,6 +175,10 @@ QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_armthumb   = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips32le   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips32be   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mipsn32le  = -M malta -cpu 5KEc -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mipsn32be  = -M malta -cpu I6400 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips64le   = -M malta -cpu I6400 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips64be   = -M malta -cpu 5KEc -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -191,6 +213,10 @@ CFLAGS_s390x = -m64
 CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
+CFLAGS_mipsn32le = -EL -mabi=n32 -fPIC -march=mips64r2
+CFLAGS_mipsn32be = -EB -mabi=n32 -march=mips64r6
+CFLAGS_mips64le = -EL -mabi=64 -march=mips64r6
+CFLAGS_mips64be = -EB -mabi=64 -march=mips64r2
 CFLAGS_sparc32 = $(call cc-option,-m32)
 ifeq ($(origin XARCH),command line)
 CFLAGS_XARCH = $(CFLAGS_$(XARCH))
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 53d843731c3e0d80dac0764d58b63c43a105021f..97fa9b7c7232dc1e3fb79a7cf8ecdb0934cb38be 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -20,7 +20,7 @@ llvm=
 all_archs=(
 	i386 x86_64
 	arm64 arm armthumb
-	mips32le mips32be
+	mips32le mips32be mipsn32le mipsn32be mips64le mips64be
 	ppc ppc64 ppc64le
 	riscv32 riscv64
 	s390x s390

-- 
2.50.0


