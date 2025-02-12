Return-Path: <linux-kselftest+bounces-26485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC4A32EE4
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 19:50:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B41A91651E5
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Feb 2025 18:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDAE25E47E;
	Wed, 12 Feb 2025 18:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UKxDLnY2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A261F76A5;
	Wed, 12 Feb 2025 18:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739386201; cv=none; b=tV2zOTeGUbSZMyoGA8kk8lISGZVV76UzOomTzJZrT9DBQyxAZ4HHi0LpfkFpGYPT38dMXiu6lVYXNMn+fBW9533CYisSQ2Q0lDSg0zlBCP1Rqt1xTbdEBBgyqaAZ35NkRw4sbg2DozsbjbQ2T3NELm/1iSiFYzqV+s4XpEF+5EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739386201; c=relaxed/simple;
	bh=vu/S2RZbUfTFDpEZ+G6eOzeYrcGNsKSvqgwI/yu81Uw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=GHJ/vhLAS8OjU2OsQHZrRkGrZlHuCsU0oZKkqjqonNqBDyAh6CIGA14uiQ6pZYnpVnaUqRlcNAMYdFJ1k9Vxb1g6ZTOxvlXX6etm3y2sGcl74DEs4kdIrD6ePdaBZxWkr42l1ohKivmYzbcIjYXZ6Rsi5myrtNL/zVV6Qz52+SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UKxDLnY2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1739386196;
	bh=vu/S2RZbUfTFDpEZ+G6eOzeYrcGNsKSvqgwI/yu81Uw=;
	h=From:Date:Subject:To:Cc:From;
	b=UKxDLnY2/xgJQleyx8PHJpHlNfMk7zojUVuoCY+2NDUYCyMGhj3ls+fNFlnU+6E5+
	 /SGSWlw2uLO/AEBrkP+osxyG+Vx4b6lxatKL+9Z2wdeBGa5S0Gt0bD7i32yIr1XtXz
	 4yngatUNfUFkp3iHtMEKA9torm7NU0U8qEXbvYyE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 12 Feb 2025 19:49:53 +0100
Subject: [PATCH] tools/nolibc: add support for N64 and N32 ABIs
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250212-nolibc-mips-n32-v1-1-6892e58d1321@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAFDtrGcC/x3MQQqAIBBA0avErBtwtBZ1lWiROtVAqShEEN09a
 fkW/z9QOAsXGJsHMl9SJIYKahtw+xI2RvHVoJU2RKrHEA+xDk9JBYPRqE03KLJ+IOWhVinzKvd
 /nOb3/QBHe6BUYQAAAA==
X-Change-ID: 20231105-nolibc-mips-n32-234901bd910d
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-mips@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739386195; l=17021;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=vu/S2RZbUfTFDpEZ+G6eOzeYrcGNsKSvqgwI/yu81Uw=;
 b=PwRHnfI90MKkGr3FXenyrK/242S36TnUvFQmFKLGcoV+aLYLY/jUNN0XTnoF6gjlWWSgLauhC
 yNAdY5uOKN4AuEApISH+aWIJSss3FjBtjOE9faYu0/eq6CiIxmr9Ev9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Add support for the MIPS 64bit N64 and ILP32 N32 ABIs.

In addition to different byte orders and ABIs there are also different
releases of the MIPS architecture. To avoid blowing up the test matrix,
only add a subset of all possible test combinations.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-mips.h            | 119 ++++++++++++++++++++++++----
 tools/testing/selftests/nolibc/Makefile     |  28 ++++++-
 tools/testing/selftests/nolibc/run-tests.sh |   2 +-
 3 files changed, 131 insertions(+), 18 deletions(-)

diff --git a/tools/include/nolibc/arch-mips.h b/tools/include/nolibc/arch-mips.h
index 753a8ed2cf695f0b5eac4b5e4d317fdb383ebf93..638520a3427a985fdbd5f5a49b55853bbadeee75 100644
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
+#elif defined(_ABIN32) || defined(_ABI64)
+
+/* binutils, GCC and clang disagree about register aliases, use numbers instead. */
+#define _NOLIBC_SYSCALL_CLOBBERLIST \
+	"memory", "cc", "at", "v1", \
+	"10", "11", "12", "13", "14", "15", "24", "25"
+
+#define _NOLIBC_SYSCALL_STACK_RESERVE
+#define _NOLIBC_SYSCALL_STACK_UNRESERVE
+
+#endif
 
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
@@ -164,11 +187,11 @@
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
 		: "=r" (_num), "=r"(_arg4)                                    \
 		: "0"(_num),                                                  \
 		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
@@ -178,6 +201,50 @@
 	_arg4 ? -_num : _num;                                                 \
 })
 
+#else
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
+		: "=r" (_num), "=r"(_arg4)                                    \
+		: "0"(_num),                                                  \
+		  "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), \
+		  "r"(_arg6)                                                  \
+		: _NOLIBC_SYSCALL_CLOBBERLIST                                 \
+	);                                                                    \
+	_arg4 ? -_num : _num;                                                 \
+})
+
+#endif
+
 /* startup code, note that it's called __start on MIPS */
 void __start(void);
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __start(void)
@@ -190,13 +257,33 @@ void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector __
 		"1:\n"
 		".cpload $ra\n"
 		"move  $a0, $sp\n"       /* save stack pointer to $a0, as arg1 of _start_c */
+
+#if defined(_ABIO32)
 		"addiu $sp, $sp, -4\n"   /* space for .cprestore to store $gp              */
 		".cprestore 0\n"
 		"li    $t0, -8\n"
 		"and   $sp, $sp, $t0\n"  /* $sp must be 8-byte aligned                     */
 		"addiu $sp, $sp, -16\n"  /* the callee expects to save a0..a3 there        */
-		"lui $t9, %hi(_start_c)\n" /* ABI requires current function address in $t9 */
+#else
+		"daddiu $sp, $sp, -8\n"  /* space for .cprestore to store $gp              */
+		".cpsetup $ra, 0, 1b\n"
+		"li    $t0, -16\n"
+		"and   $sp, $sp, $t0\n"  /* $sp must be 16-byte aligned                    */
+#endif
+
+		/* ABI requires current function address in $t9 */
+#if defined(_ABIO32) || defined(_ABIN32)
+		"lui $t9, %hi(_start_c)\n"
 		"ori $t9, %lo(_start_c)\n"
+#else
+		"lui  $t9, %highest(_start_c)\n"
+		"ori  $t9, %higher(_start_c)\n"
+		"dsll $t9, 0x10\n"
+		"ori  $t9, %hi(_start_c)\n"
+		"dsll $t9, 0x10\n"
+		"ori  $t9, %lo(_start_c)\n"
+#endif
+
 		"jalr $t9\n"             /* transfer to c runtime                          */
 		" nop\n"                 /* delayed slot                                   */
 		".set pop\n"
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 983985b7529b65b7ce4a00c28f3f915d83974eea..2dec6ab9596c974b6aac439685e17f5c10a76948 100644
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
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
@@ -64,6 +68,10 @@ IMAGE_arm64      = arch/arm64/boot/Image
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
@@ -83,6 +91,10 @@ DEFCONFIG_arm64      = defconfig
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
@@ -105,7 +117,11 @@ QEMU_ARCH_x86        = x86_64
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
@@ -117,6 +133,8 @@ QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 QEMU_ARCH_USER_ppc64le = ppc64le
+QEMU_ARCH_USER_mipsn32le = mipsn32el
+QEMU_ARCH_USER_mipsn32be = mipsn32
 QEMU_ARCH_USER         = $(or $(QEMU_ARCH_USER_$(XARCH)),$(QEMU_ARCH_$(XARCH)))
 
 QEMU_BIOS_DIR = /usr/share/edk2/
@@ -134,6 +152,10 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
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
@@ -161,6 +183,10 @@ CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
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
index 6db01115276888bc89f6ec5532153c37e55c83d3..f0f3890fb5fa8196cd33aa8681ed30b00d8f474e 100755
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
 	s390

---
base-commit: 16681bea9a80080765c98b545ad74c17de2d513c
change-id: 20231105-nolibc-mips-n32-234901bd910d

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


