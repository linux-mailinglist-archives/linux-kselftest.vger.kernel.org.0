Return-Path: <linux-kselftest+bounces-25893-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6C1A2A1D0
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 08:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFE93A3916
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Feb 2025 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA39224AF5;
	Thu,  6 Feb 2025 07:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YcfqLmcz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82CDFC0A;
	Thu,  6 Feb 2025 07:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738825842; cv=none; b=XGcvpWvNTe6duMz5AgFTzZJwSQqhrjiLaNi5bAWe7/vjquaTNaEyBGYMFFR5pp7gXhaQetd6tfO6kKMy2z1Gy9mpAwRqVPzTDXhuTJtHiDDt6S5tK4U00p1maQVxqqAxgNii4tKNc3GFy9Z9YGV9m0yUt0FwpyA3kJL/KGMLMyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738825842; c=relaxed/simple;
	bh=Xsdq4NXE16lhcQ4MiAG9uVFtsVVpTdqUxfcUaUcEIGs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=km2qQ1OYGEoX/HIzzefa2tCm629eLKSgA6eA4+vbUsj+7zHDrc2IHxD+hIxBvsBPeSg6ICo/0hE1bNfZaDVjCIF+cX679+wqa5rs3CNT/ZcOkrANV/HxXpu13EQklYc0eVTEC/qoKb2wR41Abf/EgeZBgHbjn1dVuRM0L+GTr7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YcfqLmcz; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1738825829;
	bh=Xsdq4NXE16lhcQ4MiAG9uVFtsVVpTdqUxfcUaUcEIGs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YcfqLmczTkw4gb7ICbUddeJpsRGZ5OYc7Tvqc6wGEiFwmByHp+omiEjmTLcPugtFy
	 BjsTkpaiufmn+6zTCfJ2Iix7O+jv7aP24+xvyluU3o8xA28EEtw2PQJ+UCOe6J/k4E
	 LrpJnvt8EvdCXaS1bthOGsdDUXQf+gGaXKTaN3jk=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 06 Feb 2025 08:10:27 +0100
Subject: [PATCH v2 2/2] tools/nolibc: add support for 32-bit s390
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250206-nolibc-s390-v2-2-991ad97e3d58@weissschuh.net>
References: <20250206-nolibc-s390-v2-0-991ad97e3d58@weissschuh.net>
In-Reply-To: <20250206-nolibc-s390-v2-0-991ad97e3d58@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Sven Schnelle <svens@linux.ibm.com>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738825829; l=5296;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Xsdq4NXE16lhcQ4MiAG9uVFtsVVpTdqUxfcUaUcEIGs=;
 b=ZvZMOAMldk55CravjTao0fE5dAmoi1DKG/qtE+eyvw2i77hiyymuBLO6shDg3kNWeky50mWzi
 d3u1Y2Qiqd4Cr/85+FpSGKnvD65I9H2IuJoBKKGjUl7I3LcAWE6BgBb
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

32-bit s390 is very close to the existing 64-bit implementation.

Some special handling is necessary as there is neither LLVM nor
QEMU support. Also the kernel itself can not build natively for 32-bit
s390, so instead the test program is executed with a 64-bit kernel.

Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-s390.h            | 5 +++++
 tools/include/nolibc/arch.h                 | 2 +-
 tools/testing/selftests/nolibc/Makefile     | 5 +++++
 tools/testing/selftests/nolibc/run-tests.sh | 6 +++++-
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index f9ab83a219b8a2d5e53b0b303d8bf0bf78280d5f..acfee7e9d5e2bb65718cb947110d2c5e1cdeba9b 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -143,8 +143,13 @@
 void __attribute__((weak, noreturn)) __nolibc_entrypoint __no_stack_protector _start(void)
 {
 	__asm__ volatile (
+#ifdef __s390x__
 		"lgr	%r2, %r15\n"          /* save stack pointer to %r2, as arg1 of _start_c */
 		"aghi	%r15, -160\n"         /* allocate new stackframe                        */
+#else
+		"lr	%r2, %r15\n"
+		"ahi	%r15, -96\n"
+#endif
 		"xc	0(8,%r15), 0(%r15)\n" /* clear backchain                                */
 		"brasl	%r14, _start_c\n"     /* transfer to c runtime                          */
 	);
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index c8f4e5d3add9eb5b8a438900c084dc0449fcfbd6..8a2c143c0fba288147e5a7bf9db38ffb08367616 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -29,7 +29,7 @@
 #include "arch-powerpc.h"
 #elif defined(__riscv)
 #include "arch-riscv.h"
-#elif defined(__s390x__)
+#elif defined(__s390x__) || defined(__s390__)
 #include "arch-s390.h"
 #elif defined(__loongarch__)
 #include "arch-loongarch.h"
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 97e08b92bee32300922c27ccd7c07e9eddc7162e..14fc8c7e7c3067efddf0f729890fb78df731efb3 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -72,6 +72,7 @@ IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_riscv32    = arch/riscv/boot/Image
 IMAGE_riscv64    = arch/riscv/boot/Image
 IMAGE_s390x      = arch/s390/boot/bzImage
+IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
@@ -91,6 +92,7 @@ DEFCONFIG_riscv      = defconfig
 DEFCONFIG_riscv32    = rv32_defconfig
 DEFCONFIG_riscv64    = defconfig
 DEFCONFIG_s390x      = defconfig
+DEFCONFIG_s390       = defconfig compat.config
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
@@ -114,6 +116,7 @@ QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_riscv32    = riscv32
 QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_s390x      = s390x
+QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
@@ -142,6 +145,7 @@ QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_T
 QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390x      = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
@@ -160,6 +164,7 @@ CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390x = -m64
+CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index e1c6e86912d5d4910f45d7061ee619841cf1ffd9..fd01aa4900c912e62722603fb9750bd23f27e45c 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -17,7 +17,7 @@ perform_download=0
 test_mode=system
 werror=1
 llvm=
-archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390x loongarch"
+archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390x s390 loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
 
@@ -170,6 +170,10 @@ test_arch() {
 			exit 1
 	esac
 	printf '%-15s' "$arch:"
+	if [ "$arch" = "s390" ] && ([ "$llvm" = "1" ] || [ "$test_mode" = "user" ]); then
+		echo "Unsupported configuration"
+		return
+	fi
 
 	mkdir -p "$build_dir"
 	swallow_output "${MAKE[@]}" defconfig

-- 
2.48.1


