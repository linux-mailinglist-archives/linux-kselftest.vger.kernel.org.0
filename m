Return-Path: <linux-kselftest+bounces-27962-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC741A4AAA3
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 12:24:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535261898074
	for <lists+linux-kselftest@lfdr.de>; Sat,  1 Mar 2025 11:24:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EF01DE890;
	Sat,  1 Mar 2025 11:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ifQAO72m"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3203E1DA614;
	Sat,  1 Mar 2025 11:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740828260; cv=none; b=RhscUuvo15yuEOw3KcxcsFM7S+qpBbF0vwO9LPsG8pZOo9ciYsLHvYhFY28TxwlR4RkowdyXelb9gbJ2YEsNXEPKnZ5LxJXcgLHQvIyrILN017b81r84piDovlv43zxw9ncyj2ium/fRYRUXC5wgjC7nrmXGRDmLjN/sHNudHpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740828260; c=relaxed/simple;
	bh=N7ZWUnKVuIBNSW6j79uZezmUkip3hXepNP58JvVypS0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fNXsqfK9u8I27dpqkZ2MZigSVnPTeIHdWksr0ZUeF39NXgCPFFUw5DEAOxcQ8+4gPRXIZq+fZQLwL67f9YNmzv5olyiwRnm17lH6liaWGfhpd9gJMVY6exEzSWmi9I0I4rEi0jRhfy6mtdutFt+IlrNO8HFuzAOJQyeUKv3Z/tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ifQAO72m; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1740828247;
	bh=N7ZWUnKVuIBNSW6j79uZezmUkip3hXepNP58JvVypS0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ifQAO72m5tvA5EjMYl2I4UDlty1hx9BfiiRgItWQH3ISevpMsHar4Gf3IFSYZFekd
	 XufsqsWOvA6sP3M5X8lNtEvOFhY7+Rqz58WDKxDWNYwZQDlATYRksRYCIPBdUSDKPU
	 21v/luRiC6y76ItgQ5WWhz0e0/Kk5QGHsabwpurs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sat, 01 Mar 2025 12:24:00 +0100
Subject: [PATCH 2/2] selftests/nolibc: add armthumb configuration
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250301-nolibc-armthumb-v1-2-d1f04abb5f6d@weissschuh.net>
References: <20250301-nolibc-armthumb-v1-0-d1f04abb5f6d@weissschuh.net>
In-Reply-To: <20250301-nolibc-armthumb-v1-0-d1f04abb5f6d@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740828247; l=3801;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=N7ZWUnKVuIBNSW6j79uZezmUkip3hXepNP58JvVypS0=;
 b=PS9zm1uV+QWq2zw/BHUdLsH0c6niEyt3zZEsDQe1oczKVy7HqYIeBFMVp/lvlctXVKknASmbN
 7aEcnDoTBVEBN5WAp4104H2iP4aBmXhL8IKZ21q8WyOnoWnkmHwU+aw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

While nolibc does support ARM Thumb instructions,
that support was not tested specifically.

Add a new test configuration for it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile     | 6 ++++++
 tools/testing/selftests/nolibc/run-tests.sh | 5 +++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 1dd2841a5fe781254a7f4b7b1ade677bd4bc0691..58bcbbd029bc3ad9ccac968191b703ccf5df0717 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -47,6 +47,7 @@ XARCH_riscv      = riscv64
 XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
+ARCH_armthumb    = arm
 ARCH_ppc         = powerpc
 ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
@@ -63,6 +64,7 @@ IMAGE_x86_64     = arch/x86/boot/bzImage
 IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
+IMAGE_armthumb   = arch/arm/boot/zImage
 IMAGE_mips32le   = vmlinuz
 IMAGE_mips32be   = vmlinuz
 IMAGE_ppc        = vmlinux
@@ -83,6 +85,7 @@ DEFCONFIG_x86_64     = defconfig
 DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
+DEFCONFIG_armthumb   = multi_v7_defconfig
 DEFCONFIG_mips32le   = malta_defconfig
 DEFCONFIG_mips32be   = malta_defconfig generic/eb.config
 DEFCONFIG_ppc        = pmac32_defconfig
@@ -107,6 +110,7 @@ QEMU_ARCH_x86_64     = x86_64
 QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
+QEMU_ARCH_armthumb   = arm
 QEMU_ARCH_mips32le   = mipsel  # works with malta_defconfig
 QEMU_ARCH_mips32be  = mips
 QEMU_ARCH_ppc        = ppc
@@ -136,6 +140,7 @@ QEMU_ARGS_x86_64     = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_armthumb   = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips32le   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips32be   = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -161,6 +166,7 @@ endif
 
 CFLAGS_i386 = $(call cc-option,-m32)
 CFLAGS_arm = -marm
+CFLAGS_armthumb = -mthumb -march=armv6t2
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index d716124f5e82b74deb48c9c2c3c699e4c076418c..0299a0912d4049dd12217f9835b81d231e1d2bfd 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -19,7 +19,7 @@ werror=1
 llvm=
 all_archs=(
 	i386 x86_64
-	arm64 arm
+	arm64 arm armthumb
 	mips32le mips32be
 	ppc ppc64 ppc64le
 	riscv32 riscv64
@@ -103,6 +103,7 @@ fi
 crosstool_arch() {
 	case "$1" in
 	arm64) echo aarch64;;
+	armthumb) echo arm;;
 	ppc) echo powerpc;;
 	ppc64) echo powerpc64;;
 	ppc64le) echo powerpc64;;
@@ -116,7 +117,7 @@ crosstool_arch() {
 
 crosstool_abi() {
 	case "$1" in
-	arm) echo linux-gnueabi;;
+	arm | armthumb) echo linux-gnueabi;;
 	*) echo linux;;
 	esac
 }

-- 
2.48.1


