Return-Path: <linux-kselftest+bounces-37218-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43370B032D6
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 22:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A0623B6D53
	for <lists+linux-kselftest@lfdr.de>; Sun, 13 Jul 2025 20:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6936283141;
	Sun, 13 Jul 2025 20:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="hjwcAA+d"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345321A5B8C;
	Sun, 13 Jul 2025 20:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752437410; cv=none; b=BAM9zdCqRfLof5trW1Vtc30PyPNRKz61WdPVxfw93YsMxDwQWjIZ40RzUK1sIhIJs+8RQilvn4ilsip3bEKPW3kTFdPI1cCbN+3p6WabJ6eoOhP7lAchm5zs6ol8RQskm/76oaXOQbVRyXG1kpFGwJqx00zb9oIHZ+Ot9wKKetU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752437410; c=relaxed/simple;
	bh=tvrmaUUFeqBTIKybhuu9LjjUFSmtG0wf0U3nFvkk64g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DdXm8KH+W5mIIzCVexGWYzsymxFIHmwL4xP9j01DisIwCWLEv2wlH2uCTEKRNkKeDthc9z/w1TL1YvyVxOcNNhY30annTvYONOhrYYlw1s+Pfz3RAfEO3sNuVUmL2MjpdaOGGxcAF+VDzgq+UhkQOVP9TSkOfcKM1hXsLS0r/kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=hjwcAA+d; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752437405;
	bh=tvrmaUUFeqBTIKybhuu9LjjUFSmtG0wf0U3nFvkk64g=;
	h=From:Date:Subject:To:Cc:From;
	b=hjwcAA+dIphMPBY7g1dyF5jo1FrMJnNm7KJy76E8cuNSQLIOfPxXLYJcNm02jvf2l
	 Kal+vah2Rd4w6qhQz0KoZLQCbAiWGWxf37NpB3w0wXr+06fmoEjzW8/pbmX2t9fInR
	 ffcsLRNU70xctSlFdndMBgPuvr53pbxqOjZAsohQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 13 Jul 2025 22:08:08 +0200
Subject: [PATCH] tools/nolibc: add support for Alpha
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250713-nolibc-alpha-v1-1-10216333d308@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIACcSdGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDMwNL3bz8nMykZN3EnIKMRF1j41RzSzMTE1MTk2QloJaCotS0zAqwcdG
 xtbUAkxcZR14AAAA=
X-Change-ID: 20250609-nolibc-alpha-33e79644544c
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Matt Turner <mattst88@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-alpha@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752437405; l=14943;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tvrmaUUFeqBTIKybhuu9LjjUFSmtG0wf0U3nFvkk64g=;
 b=Wpfo+nhRDe9nhTC0hvzSS63wSWWcoEP5n1bMqmruMQNX4g5yFYZEKOrSgwSznIKs3wHACtMnU
 fQttQClZI0vAghOmpcCXLDdhSJpKvBKyjIBEa0zWj8LxXW2IY3w7/kY
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

A straightforward new architecture.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Only tested on QEMU so far.
Testing on real hardware would be very welcome.

Test instructions:
$ cd tools/testings/selftests/nolibc/
$ make -f Makefile.nolibc ARCH=alpha CROSS_COMPILE=alpha-linux- nolibc-test
$ file nolibc-test
nolibc-test: ELF 64-bit LSB executable, Alpha (unofficial), version 1 (SYSV), statically linked, not stripped
$ ./nolibc-test
Running test 'startup'
0 argc = 1                                                        [OK]
...
Total number of errors: 0
Exiting with status 0
---
 tools/include/nolibc/arch-alpha.h              | 164 +++++++++++++++++++++++++
 tools/include/nolibc/arch.h                    |   2 +
 tools/testing/selftests/nolibc/Makefile.nolibc |   5 +
 tools/testing/selftests/nolibc/nolibc-test.c   |   4 +
 tools/testing/selftests/nolibc/run-tests.sh    |   3 +-
 5 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-alpha.h b/tools/include/nolibc/arch-alpha.h
new file mode 100644
index 0000000000000000000000000000000000000000..6b9bb6c749b931f30ce7bd6cd125622828405604
--- /dev/null
+++ b/tools/include/nolibc/arch-alpha.h
@@ -0,0 +1,164 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * Alpha specific definitions for NOLIBC
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ */
+
+#ifndef _NOLIBC_ARCH_ALPHA_H
+#define _NOLIBC_ARCH_ALPHA_H
+
+#include "compiler.h"
+#include "crt.h"
+
+/*
+ * Syscalls for Alpha:
+ *   - registers are 64-bit
+ *   - syscall number is passed in $0/v0
+ *   - the system call is performed by calling callsys
+ *   - syscall return comes in $0/v0, error flag in $19/a4
+ *   - arguments are passed in $16/a0 to $21/a5
+ *   - GCC does not support symbol register names
+ */
+
+#define my_syscall0(num)                                                      \
+({                                                                            \
+	register long _num __asm__ ("$0") = (num);                            \
+	register long _ret __asm__ ("$0");                                    \
+	register long _err __asm__ ("$19");                                   \
+									      \
+	__asm__ volatile (                                                    \
+		"callsys"                                                     \
+		: "=r"(_ret), "=r"(_err)                                      \
+		: "r"(_num)                                                   \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_err ? -_ret : _ret;                                                  \
+})
+
+#define my_syscall1(num, arg1)                                                \
+({                                                                            \
+	register long _num __asm__ ("$0") = (num);                            \
+	register long _ret __asm__ ("$0");                                    \
+	register long _err __asm__ ("$19");                                   \
+	register long _arg1 __asm__ ("$16") = (long)(arg1);                   \
+									      \
+	__asm__ volatile (                                                    \
+		"callsys"                                                     \
+		: "=r"(_ret), "=r"(_err)                                      \
+		: "r"(_num), "r"(_arg1)                                       \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_err ? -_ret : _ret;                                                  \
+})
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num __asm__ ("$0") = (num);                            \
+	register long _ret __asm__ ("$0");                                    \
+	register long _err __asm__ ("$19");                                   \
+	register long _arg1 __asm__ ("$16") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("$17") = (long)(arg2);                   \
+									      \
+	__asm__ volatile (                                                    \
+		"callsys"                                                     \
+		: "=r"(_ret), "=r"(_err)                                      \
+		: "r"(_num), "r"(_arg1), "r"(_arg2)                           \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_err ? -_ret : _ret;                                                  \
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)                                    \
+({                                                                            \
+	register long _num __asm__ ("$0") = (num);                            \
+	register long _ret __asm__ ("$0");                                    \
+	register long _err __asm__ ("$19");                                   \
+	register long _arg1 __asm__ ("$16") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("$17") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("$18") = (long)(arg3);                   \
+									      \
+	__asm__ volatile (                                                    \
+		"callsys"                                                     \
+		: "=r"(_ret), "=r"(_err)                                      \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3)               \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_err ? -_ret : _ret;                                                  \
+})
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+({                                                                            \
+	register long _num __asm__ ("$0") = (num);                            \
+	register long _ret __asm__ ("$0");                                    \
+	register long _err __asm__ ("$19");                                   \
+	register long _arg1 __asm__ ("$16") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("$17") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("$18") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("$19") = (long)(arg4);                   \
+									      \
+	__asm__ volatile (                                                    \
+		"callsys"                                                     \
+		: "=r"(_ret), "=r"(_err)                                      \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4)   \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_err ? -_ret : _ret;                                                  \
+})
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+({                                                                            \
+	register long _num __asm__ ("$0") = (num);                            \
+	register long _ret __asm__ ("$0");                                    \
+	register long _err __asm__ ("$19");                                   \
+	register long _arg1 __asm__ ("$16") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("$17") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("$18") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("$19") = (long)(arg4);                   \
+	register long _arg5 __asm__ ("$20") = (long)(arg5);                   \
+									      \
+	__asm__ volatile (                                                    \
+		"callsys"                                                     \
+		: "=r"(_ret), "=r"(_err)                                      \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),  \
+		  "r"(_arg5)                                                  \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_err ? -_ret : _ret;                                                  \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num __asm__ ("$0") = (num);                            \
+	register long _ret __asm__ ("$0");                                    \
+	register long _err __asm__ ("$19");                                   \
+	register long _arg1 __asm__ ("$16") = (long)(arg1);                   \
+	register long _arg2 __asm__ ("$17") = (long)(arg2);                   \
+	register long _arg3 __asm__ ("$18") = (long)(arg3);                   \
+	register long _arg4 __asm__ ("$19") = (long)(arg4);                   \
+	register long _arg5 __asm__ ("$20") = (long)(arg5);                   \
+	register long _arg6 __asm__ ("$21") = (long)(arg6);                   \
+									      \
+	__asm__ volatile (                                                    \
+		"callsys"                                                     \
+		: "=r"(_ret), "=r"(_err)                                      \
+		: "r"(_num), "r"(_arg1), "r"(_arg2), "r"(_arg3), "r"(_arg4),  \
+		  "r"(_arg5), "r"(_arg6)                                      \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_err ? -_ret : _ret;                                                  \
+})
+
+/* startup code */
+void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
+{
+	__asm__ volatile (
+		"br $gp, 0f\n"               /* setup $gp, so that 'lda' works                */
+		"0: ldgp $gp, 0($gp)\n"
+		"lda $27, _start_c\n"        /* setup current function address for _start_c   */
+		"mov $sp, $16\n"             /* save argc pointer to $16, as arg1 of _start_c */
+		"br  _start_c\n"             /* transfer to c runtime                         */
+	);
+	__nolibc_entrypoint_epilogue();
+}
+
+#endif /* _NOLIBC_ARCH_ALPHA_H */
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 426c89198135564acca44c485e5c2d8ba36a6fe9..72585d4c04e2896a275faadf881e98286f914fb3 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -37,6 +37,8 @@
 #include "arch-m68k.h"
 #elif defined(__sh__)
 #include "arch-sh.h"
+#elif defined(__alpha__)
+#include "arch-alpha.h"
 #else
 #error Unsupported Architecture
 #endif
diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 0fb759ba992ee6b1693b88f1b2e77463afa9f38b..0da33fe99bd630ec5100b5beed939d524af2b3d4 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -93,6 +93,7 @@ IMAGE_sparc32    = arch/sparc/boot/image
 IMAGE_sparc64    = arch/sparc/boot/image
 IMAGE_m68k       = vmlinux
 IMAGE_sh4        = arch/sh/boot/zImage
+IMAGE_alpha      = vmlinux
 IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
@@ -123,6 +124,7 @@ DEFCONFIG_sparc32    = sparc32_defconfig
 DEFCONFIG_sparc64    = sparc64_defconfig
 DEFCONFIG_m68k       = virt_defconfig
 DEFCONFIG_sh4        = rts7751r2dplus_defconfig
+DEFCONFIG_alpha      = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 EXTRACONFIG_x32       = -e CONFIG_X86_X32_ABI
@@ -130,6 +132,7 @@ EXTRACONFIG_arm       = -e CONFIG_NAMESPACES
 EXTRACONFIG_armthumb  = -e CONFIG_NAMESPACES
 EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
 EXTRACONFIG_sh4       = -e CONFIG_BLK_DEV_INITRD -e CONFIG_CMDLINE_FROM_BOOTLOADER
+EXTRACONFIG_alpha     = -e CONFIG_BLK_DEV_INITRD
 EXTRACONFIG           = $(EXTRACONFIG_$(XARCH))
 
 # optional tests to run (default = all)
@@ -162,6 +165,7 @@ QEMU_ARCH_sparc32    = sparc
 QEMU_ARCH_sparc64    = sparc64
 QEMU_ARCH_m68k       = m68k
 QEMU_ARCH_sh4        = sh4
+QEMU_ARCH_alpha      = alpha
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 QEMU_ARCH_USER_ppc64le = ppc64le
@@ -203,6 +207,7 @@ QEMU_ARGS_sparc32    = -M SS-5 -m 256M -append "console=ttyS0,115200 panic=-1 $(
 QEMU_ARGS_sparc64    = -M sun4u -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_m68k       = -M virt -append "console=ttyGF0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_sh4        = -M r2d -serial file:/dev/stdout -append "console=ttySC1,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_alpha      = -M clipper -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a297ee0d6d0754dfcd9f9e5609d42c7442dabc4e..bbbb2a485f220fed69556baaf2603d9cf24a1c36 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -709,6 +709,10 @@ int run_startup(int min, int max)
 	/* checking NULL for argv/argv0, environ and _auxv is not enough, let's compare with sbrk(0) or &end */
 	extern char end;
 	char *brk = sbrk(0) != (void *)-1 ? sbrk(0) : &end;
+#if defined(__alpha__)
+	/* the ordering above does not work on an alpha kernel */
+	brk = NULL;
+#endif
 	/* differ from nolibc, both glibc and musl have no global _auxv */
 	const unsigned long *test_auxv = (void *)-1;
 #ifdef NOLIBC
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index e8af1fb505cf3573b4a6b37228dee764fe2e5277..8ce57d7006594c531f471d777d579c4f08d87efe 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -28,6 +28,7 @@ all_archs=(
 	sparc32 sparc64
 	m68k
 	sh4
+	alpha
 )
 archs="${all_archs[@]}"
 
@@ -189,7 +190,7 @@ test_arch() {
 		echo "Unsupported configuration"
 		return
 	fi
-	if [ "$arch" = "m68k" -o "$arch" = "sh4" ] && [ "$llvm" = "1" ]; then
+	if [ "$arch" = "m68k" -o "$arch" = "sh4" -o "$arch" = "alpha" ] && [ "$llvm" = "1" ]; then
 		echo "Unsupported configuration"
 		return
 	fi

---
base-commit: b9e50363178a40c76bebaf2f00faa2b0b6baf8d1
change-id: 20250609-nolibc-alpha-33e79644544c

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


