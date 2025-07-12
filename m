Return-Path: <linux-kselftest+bounces-37185-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C86B02A34
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 11:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B25F566DBC
	for <lists+linux-kselftest@lfdr.de>; Sat, 12 Jul 2025 09:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80D7227381E;
	Sat, 12 Jul 2025 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="j7X6F1nu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF072236E3;
	Sat, 12 Jul 2025 09:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752310870; cv=none; b=M8roHAAPOlZgpOhDarAfSggD6hkL3vX3BINR1qflsXoJS0ZK/vUAeyFoEDPEGz5yydOmIURTg4klkTUm8DiElEBaDM6DznpFtIyYrehEDy83zPulWa3g04f1y0MrktiSMaa2w/xWJQroxns+LvPEI1iVX5Y5l5O+M4rU27lzlzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752310870; c=relaxed/simple;
	bh=z0mpkzYEyZYkp5eI4TzRWS1qJqzKdrkv1vY/VtruD00=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JhsgFj7tgCa38yq2skh+Xy3jdcO1kSK2LQ2DXmGPg+gCOr4hgY6d8wdHvEFHGzDWs97njMtU/08f1A9HZi1dGWBDiZpiFhwUJm+04ND2+U9iw0rdzF4BE/HNdkBgkCLmOvLQiHDm17KHl2BJKjrOZS6TPfDbvJiJnlGVEYxqf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=j7X6F1nu; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1752310860;
	bh=z0mpkzYEyZYkp5eI4TzRWS1qJqzKdrkv1vY/VtruD00=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=j7X6F1nuKPTuubmTUAkWzeWr2hnzuwSOFPNN6sUQZ6+KFPM5KhCrwRla7oh9LqdKJ
	 XknGtXBpq2ffm5xhSY9Y5Ga3SCPt/h6s7+tJNoY/EZzGwn+H/GEGV+sJ4vRW/86puG
	 ltcuxpUx15OZdirJtwQOAWkxOu70JgYQiBBpCuNo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 12 Jul 2025 11:00:56 +0200
Subject: [PATCH 2/2] selftests/nolibc: add x32 test configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250712-nolibc-x32-v1-2-6d81cb798710@weissschuh.net>
References: <20250712-nolibc-x32-v1-0-6d81cb798710@weissschuh.net>
In-Reply-To: <20250712-nolibc-x32-v1-0-6d81cb798710@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752310859; l=4386;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z0mpkzYEyZYkp5eI4TzRWS1qJqzKdrkv1vY/VtruD00=;
 b=nu+wyouVgc+1vMzG+Qh+sC1cKrHUm3O+feaLWmJfs1CIl9vO/GtjM6Y3SJpYt860CgZvHejds
 AjAd2WWE5BBCsTvIusGWxoV+nQ3JHOBanXaHqIHt88boZ8aBAXjGPcJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Nolibc supports the x32 ABI on x86.
Add a testcase to make sure the support stays functional.

QEMU user does not have support for x32, so skip the test there.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 12 ++++++++++++
 tools/testing/selftests/nolibc/run-tests.sh    |  7 ++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index 51ba853dd97eebed32f9808b0979460071f2514f..0fb759ba992ee6b1693b88f1b2e77463afa9f38b 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -47,6 +47,7 @@ XARCH_riscv      = riscv64
 XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
+ARCH_x32         = x86
 ARCH_armthumb    = arm
 ARCH_ppc         = powerpc
 ARCH_ppc64       = powerpc
@@ -68,6 +69,7 @@ ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 # kernel image names by architecture
 IMAGE_i386       = arch/x86/boot/bzImage
 IMAGE_x86_64     = arch/x86/boot/bzImage
+IMAGE_x32        = arch/x86/boot/bzImage
 IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
@@ -97,6 +99,7 @@ IMAGE_NAME       = $(notdir $(IMAGE))
 # default kernel configurations that appear to be usable
 DEFCONFIG_i386       = defconfig
 DEFCONFIG_x86_64     = defconfig
+DEFCONFIG_x32        = defconfig
 DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
@@ -122,6 +125,7 @@ DEFCONFIG_m68k       = virt_defconfig
 DEFCONFIG_sh4        = rts7751r2dplus_defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
+EXTRACONFIG_x32       = -e CONFIG_X86_X32_ABI
 EXTRACONFIG_arm       = -e CONFIG_NAMESPACES
 EXTRACONFIG_armthumb  = -e CONFIG_NAMESPACES
 EXTRACONFIG_m68k      = -e CONFIG_BLK_DEV_INITRD
@@ -134,6 +138,7 @@ TEST =
 # QEMU_ARCH: arch names used by qemu
 QEMU_ARCH_i386       = i386
 QEMU_ARCH_x86_64     = x86_64
+QEMU_ARCH_x32        = x86_64
 QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
@@ -174,6 +179,7 @@ endif
 # QEMU_ARGS : some arch-specific args to pass to qemu
 QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_x32        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -210,6 +216,7 @@ Q=@
 endif
 
 CFLAGS_i386 = $(call cc-option,-m32)
+CFLAGS_x32 = -mx32
 CFLAGS_arm = -marm
 CFLAGS_armthumb = -mthumb -march=armv6t2
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
@@ -236,6 +243,11 @@ LDFLAGS :=
 
 LIBGCC := -lgcc
 
+ifeq ($(ARCH),x86)
+# Not needed on x86, probably not present for x32
+LIBGCC :=
+endif
+
 ifneq ($(LLVM),)
 # Not needed for clang
 LIBGCC :=
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 43eb30be316ae7bac7f0ba2c38b494a283833bec..e8af1fb505cf3573b4a6b37228dee764fe2e5277 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -18,7 +18,7 @@ test_mode=system
 werror=1
 llvm=
 all_archs=(
-	i386 x86_64
+	i386 x86_64 x32
 	arm64 arm armthumb
 	mips32le mips32be mipsn32le mipsn32be mips64le mips64be
 	ppc ppc64 ppc64le
@@ -115,6 +115,7 @@ crosstool_arch() {
 	mips*) echo mips;;
 	s390*) echo s390;;
 	sparc*) echo sparc64;;
+	x32*) echo x86_64;;
 	*) echo "$1";;
 	esac
 }
@@ -192,6 +193,10 @@ test_arch() {
 		echo "Unsupported configuration"
 		return
 	fi
+	if [ "$arch" = "x32" ] && [ "$test_mode" = "user" ]; then
+		echo "Unsupported configuration"
+		return
+	fi
 
 	mkdir -p "$build_dir"
 	swallow_output "${MAKE[@]}" defconfig

-- 
2.50.1


