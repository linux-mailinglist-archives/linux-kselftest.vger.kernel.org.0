Return-Path: <linux-kselftest+bounces-23723-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D848D9FA11A
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 15:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21CD81890973
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 14:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0185E1FDE2C;
	Sat, 21 Dec 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DVfvFFAx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D701FD780;
	Sat, 21 Dec 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792279; cv=none; b=puJmf99oOjxnuEDIpXNrQ8oETqnT8c3r96O9EVGloaCBdGROq2bAuhRK2Ilh60Be+p145ohxVVOdCDobNH31M0YX5VmwywEy0N6EFfhf8KG3bgWZsXGXzeA/24v0PpabsUVbd2S1RuTe8aDTCAAM4ro3wW1RG+tBt5T/q+ONCN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792279; c=relaxed/simple;
	bh=aeC+A4pV2HWdlsm6EkBuWMFp7lqNtxjQtDsfDD7yt+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tRuZl39Y1TZKEeFzsDcxylemN2E7+gS4TdWk3BAbVGesd3FhfeOyaB06FrRU0tRI1AygqBYOnNpMGLwPW+8Xor3HDXQ67ctPZ7kENA83M/Xn52/SqL78+VlrnJKlOzpXNiazI0sYOgFdCqDA78b31ZeEieindiZnTdJ9aWNfNl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DVfvFFAx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734792273;
	bh=aeC+A4pV2HWdlsm6EkBuWMFp7lqNtxjQtDsfDD7yt+U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DVfvFFAxN0lAeJgPVZ4fb4kJ1yCtViQZBydzRkTUY9RCVepnz7eL7u1gGHf9QeWPN
	 CYTbtFkj1O7ZnXDAcYUqkeHTtKhYxmDgSMe7646IHIZ4Is4IYyZlLxtbcdSAleEK77
	 it8JQE1CjE1rHNNzDwHM2r+ogpqAUA9wDsdKSiQA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 21 Dec 2024 15:44:32 +0100
Subject: [PATCH 5/6] selftests/nolibc: rename riscv to riscv64
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-nolibc-rv32-v1-5-d9ef6dab7c63@weissschuh.net>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
In-Reply-To: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792271; l=3677;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=aeC+A4pV2HWdlsm6EkBuWMFp7lqNtxjQtDsfDD7yt+U=;
 b=kwEIY97BM65Wh57NezW76D9+hJKaHBZIqYvFW90fQ3JhDgz4M4S6HUudIF0hm56vsibeeWwN4
 LT6zf6mEOkECwkSneF/AI1lblToMpbJR1Ko5fkodxDy3yPU3yhng7sr
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

riscv32 support is about the be added. To keep the naming clear and
consistent with other architectures rename riscv to riscv64, as that is
what it actually represents.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile     | 6 ++++++
 tools/testing/selftests/nolibc/run-tests.sh | 2 +-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index e92e0b88586111072a0e043cb15f3b59cf42c3a6..78f47e85b389ac229ac13f3e7c8299fb3ec92197 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -43,6 +43,7 @@ cc-option = $(call __cc-option, $(CC),$(CLANG_CROSS_FLAGS),$(1),$(2))
 # configure default variants for target kernel supported architectures
 XARCH_powerpc    = ppc
 XARCH_mips       = mips32le
+XARCH_riscv      = riscv64
 XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
@@ -51,6 +52,7 @@ ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
 ARCH_mips32le    = mips
 ARCH_mips32be    = mips
+ARCH_riscv64     = riscv
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -65,6 +67,7 @@ IMAGE_ppc        = vmlinux
 IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
+IMAGE_riscv64    = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
@@ -82,6 +85,7 @@ DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
+DEFCONFIG_riscv64    = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
@@ -104,6 +108,7 @@ QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64
 QEMU_ARCH_riscv      = riscv64
+QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
@@ -130,6 +135,7 @@ QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIB
 QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index e7ecda4ae796fbf0d389f20144511e66ce4f0b30..caa1ae40fe9a2faf8931c299aacd19716227e2b8 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -17,7 +17,7 @@ perform_download=0
 test_mode=system
 werror=1
 llvm=
-archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv s390 loongarch"
+archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv64 s390 loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
 

-- 
2.47.1


