Return-Path: <linux-kselftest+bounces-27493-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB57A44781
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 18:11:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACAF19C422D
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BCCC19E83C;
	Tue, 25 Feb 2025 17:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AGIt1U3l"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091919AA58;
	Tue, 25 Feb 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740503353; cv=none; b=fokV6n3C9pDFsTqFbWG1dwToOloVuLtBc+zgp1kxkKA86Sx5/sLsDz7bpNazTd4rf28zZPNENbU4qv3TbThs8LwjOM9bjtfqI1UvgTkt8mPfZ0N/VI3ZvXlcxnaT4rUiOokB1DHwLqn43RDS58sB1bHqqKHXmNW5v7Q5w6dOPLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740503353; c=relaxed/simple;
	bh=fbtK/DeC9RhX+XdpZ8rYzaCI9N8rTTZCIBBEn0NP5U4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZS2upLfBj/1rgNH8/pXalEYy+UnaRWscmVu7sx+5vLw+jBfmuJDWX9H+hGczFvNJ3ZqK5Fq/Fq7WGkyuu0HDRz4ZxqcE4/RundNp5qrgQArZy3AR3tznVdICF3PpbPwtUUdlCVddnJoqhT9fACvmdaL1CPnnpCw94XdpUgc3mwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AGIt1U3l; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740503338;
	bh=fbtK/DeC9RhX+XdpZ8rYzaCI9N8rTTZCIBBEn0NP5U4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AGIt1U3luHcjk1wNbEF/Hk6d3qjkMDnJRdYzOKvYtLVHX3H4pIzgKVxYaK18Gsm5i
	 x+Kscaqr/WhYtxBYMe7rvN8unMWt56otl54lQzcom7VspwwQbUOp63a2dO3BWqu8j4
	 yr5CxWiCJZ+HSA+oybz+9LB89wArREX4wNNX1jCo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 25 Feb 2025 18:02:38 +0100
Subject: [PATCH v2 4/4] tools/nolibc: MIPS: add support for N64 and N32
 ABIs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250225-nolibc-mips-n32-v2-4-664b47d87fa0@weissschuh.net>
References: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
In-Reply-To: <20250225-nolibc-mips-n32-v2-0-664b47d87fa0@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740503008; l=16065;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=fbtK/DeC9RhX+XdpZ8rYzaCI9N8rTTZCIBBEn0NP5U4=;
 b=h/cNlSC956ZPDHdI6QUkeP5VHKx+YbN/0pE2Ps5NkdnrvtgPgDqDC1uLeD8X+FWeqRtgelXzB
 7bbfxPAGvuoCIVb/7WUqfvzwt2V7MtCsauBiyo3g+0Dy3lFNvdE8YY1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for the MIPS 64bit N64 and ILP32 N32 ABIs.

In addition to different byte orders and ABIs there are also different
releases of the MIPS architecture. To avoid blowing up the test matrix,
only add a subset of all possible test combinations.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-mips.h            | 105 ++++++++++++++++++++++++----
 tools/testing/selftests/nolibc/Makefile     |  28 +++++++-
 tools/testing/selftests/nolibc/run-tests.sh |   2 +-
 3 files changed, 118 insertions(+), 17 deletions(-)

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
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 14fc8c7e7c3067efddf0f729890fb78df731efb3..7db2a7b1c94ff79cd9410c66205aa1dc5fdcb4f8 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -52,6 +52,10 @@ ARCH_ppc64       = powerpc
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
@@ -65,6 +69,10 @@ IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips32le   = vmlinuz
 IMAGE_mips32be   = vmlinuz
+IMAGE_mipsn32le  = vmlinuz
+IMAGE_mipsn32be  = vmlinuz
+IMAGE_mips64le   = vmlinuz
+IMAGE_mips64be   = vmlinuz
 IMAGE_ppc        = vmlinux
 IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
@@ -85,6 +93,10 @@ DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips32le   = malta_defconfig
 DEFCONFIG_mips32be   = malta_defconfig generic/eb.config
+DEFCONFIG_mipsn32le  = malta_defconfig generic/64r2.config
+DEFCONFIG_mipsn32be  = malta_defconfig generic/64r6.config generic/eb.config
+DEFCONFIG_mips64le   = malta_defconfig generic/64r6.config
+DEFCONFIG_mips64be   = malta_defconfig generic/64r2.config generic/eb.config
 DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
@@ -108,7 +120,11 @@ QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips32le   = mipsel  # works with malta_defconfig
-QEMU_ARCH_mips32be  = mips
+QEMU_ARCH_mips32be   = mips
+QEMU_ARCH_mipsn32le  = mips64el
+QEMU_ARCH_mipsn32be  = mips64
+QEMU_ARCH_mips64le   = mips64el
+QEMU_ARCH_mips64be   = mips64
 QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64
@@ -121,6 +137,8 @@ QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 QEMU_ARCH_USER_ppc64le = ppc64le
+QEMU_ARCH_USER_mipsn32le = mipsn32el
+QEMU_ARCH_USER_mipsn32be = mipsn32
 QEMU_ARCH_USER         = $(or $(QEMU_ARCH_USER_$(XARCH)),$(QEMU_ARCH_$(XARCH)))
 
 QEMU_BIOS_DIR = /usr/share/edk2/
@@ -138,6 +156,10 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips32le   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips32be   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mipsn32le  = -M malta -cpu 5KEc -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mipsn32be  = -M malta -cpu I6400 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips64le   = -M malta -cpu I6400 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_mips64be   = -M malta -cpu 5KEc -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -167,6 +189,10 @@ CFLAGS_s390x = -m64
 CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
+CFLAGS_mipsn32le = -EL -mabi=n32 -fPIC -march=mips64r2
+CFLAGS_mipsn32be = -EB -mabi=n32 -march=mips64r6
+CFLAGS_mips64le = -EL -mabi=64 -march=mips64r6
+CFLAGS_mips64be = -EB -mabi=64 -march=mips64r2
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) $(call cc-option,-Wmissing-prototypes) \
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index b5ded13bdda2702bbc3b84f7e5249fe79bca6dc6..dff5c1aac4d333b8264373e67d753dfb55e9c7c0 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -20,7 +20,7 @@ llvm=
 all_archs=(
 	i386 x86_64
 	arm64 arm
-	mips32le mips32be
+	mips32le mips32be mipsn32le mipsn32be mips64le mips64be
 	ppc ppc64 ppc64le
 	riscv32 riscv64
 	s390x s390

-- 
2.48.1


