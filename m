Return-Path: <linux-kselftest+bounces-23724-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5F69FA113
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 15:46:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B01437A0378
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Dec 2024 14:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316761FDE3B;
	Sat, 21 Dec 2024 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dKEk9Z+Q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D161FCFFE;
	Sat, 21 Dec 2024 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734792280; cv=none; b=etM0Zx395es56OVjmdcT/2oNDSHNjX/iSAcmjnIlhIueHEJaL5tjrpEJw4OWUKUaTQDwa9mBZr8kUYadBcQFIikXjWxM6NV0DRclcKEQrjVNCX+mHpodK2/KYnlLGmVY4lhCIe4WMeMBPnh0YryhfVEe7rNSiqO63nqwuom4rLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734792280; c=relaxed/simple;
	bh=Hm4oTXMI/JqCrQxZ82g7s2Sg91ri2J6sCyZLkfUdK78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lbkr3uIiX+iw0/CHh3osEPp6L+AE+p1zxvaXYKs6aFG2+T6iixZqE9nnTtxWdjBaXzdo/45iReQS4ZOo07i7AYC2JDuCaBGftiFNpQCtUR9HFqaOQIXpZxmwUWALBGLvEqH4/v+HFj09KTs2KwShRkbEJ3la//zZUdFDEiSJenk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dKEk9Z+Q; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1734792273;
	bh=Hm4oTXMI/JqCrQxZ82g7s2Sg91ri2J6sCyZLkfUdK78=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dKEk9Z+QAHT8Hz68ebE73fh6OP1VsVSkZoMG9gFyUGKaoPwqHGvyYVwZZdefJXjvF
	 FZCvx9Oe7hdaYT2k7v8hx9KpxCwBYt3j8h6P5xE9u10gQxU0fnHgAs1lWdrcSCsl3n
	 pXYWNE/pfN0RpeuJv1jMA/yHSL4jWWUi4DyFf2qA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 21 Dec 2024 15:44:33 +0100
Subject: [PATCH 6/6] selftests/nolibc: add configurations for riscv32
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241221-nolibc-rv32-v1-6-d9ef6dab7c63@weissschuh.net>
References: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
In-Reply-To: <20241221-nolibc-rv32-v1-0-d9ef6dab7c63@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Zhangjin Wu <falcon@tinylab.org>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734792271; l=3163;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Hm4oTXMI/JqCrQxZ82g7s2Sg91ri2J6sCyZLkfUdK78=;
 b=zwMCx/hbd+g6QvU5d3rTtD17U0JfAipHmn2dW/Jh+MHAqJ81F/tmth+3uyXgH+ojln3qSklsH
 M2bPfLGMhuxCpe4P9CWTCQ+Nz6+QzUNYQ+ZsMGl5em7AAPtW1OEcpP9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

nolibc already supports riscv32. Wire it up in the testsuite.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile     | 5 +++++
 tools/testing/selftests/nolibc/run-tests.sh | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 78f47e85b389ac229ac13f3e7c8299fb3ec92197..7d14a7c0cb62608f328b251495264517d333db2e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -52,6 +52,7 @@ ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
 ARCH_mips32le    = mips
 ARCH_mips32be    = mips
+ARCH_riscv32     = riscv
 ARCH_riscv64     = riscv
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
@@ -67,6 +68,7 @@ IMAGE_ppc        = vmlinux
 IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
+IMAGE_riscv32    = arch/riscv/boot/Image
 IMAGE_riscv64    = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -85,6 +87,7 @@ DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
+DEFCONFIG_riscv32    = rv32_defconfig
 DEFCONFIG_riscv64    = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -108,6 +111,7 @@ QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64
 QEMU_ARCH_riscv      = riscv64
+QEMU_ARCH_riscv32    = riscv32
 QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -135,6 +139,7 @@ QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIB
 QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index caa1ae40fe9a2faf8931c299aacd19716227e2b8..67fefc847d77165f817c3befa578cfa27e6f93d8 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -17,7 +17,7 @@ perform_download=0
 test_mode=system
 werror=1
 llvm=
-archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv64 s390 loongarch"
+archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390 loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
 

-- 
2.47.1


