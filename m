Return-Path: <linux-kselftest+bounces-24964-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91050A198BB
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82F4188BAB0
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6886C21578C;
	Wed, 22 Jan 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WC3j2yKh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C4D215F42;
	Wed, 22 Jan 2025 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571431; cv=none; b=BJ3cFVMoJjirqO+SRVII+rkXk19N3EefRrXtanztfe0bcktdDgUOeWrQWv73eIJRC5OngGEke45Wk7hd3/iEX39sznqBDNsnxOd4q05Bckxn28WRWWpHaxrwRW7aSwjaKoh/5JEm09NKeR4utRx3mj6QvErXFPuLf7KbHW2huUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571431; c=relaxed/simple;
	bh=H+MyRN8zYY9LAZ6Zrgq/Gv/BdcVNW+EWYlmKSZVjTx8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IMAPnt8MuDxPefk1rVCyqFoJM0zr4eGCVjaMkvDJ1YCeeQmO0j/TCwojk5gMvDvhXfcrkm125MKKLICAjZBochdjLp+Do4lwWqvtd1XPXw6NNjZ0/1mn4ccKq1iryxM6f7N/lp7SKYxHyZ546QiDLea/RI/8Q2xT5JEzlaYASEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WC3j2yKh; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571427;
	bh=H+MyRN8zYY9LAZ6Zrgq/Gv/BdcVNW+EWYlmKSZVjTx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WC3j2yKhVJVpkwuggMezctLYTlwCg/LcEdSK0+r7EqBQTl8XBW72HWc52wrVDTBGs
	 1+0t9VOMVyLTDeB+n/dLc9sLLtW5meKIOzpuOpiX6JjyiYVYmBaHYHwyZoK0x+imjn
	 OWSAP4Z3NQ9opLyizcWpHEQGt87Y/0J7Jjw71A6I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 22 Jan 2025 19:43:45 +0100
Subject: [PATCH 1/2] selftests/nolibc: rename s390 to s390x
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-nolibc-s390-v1-1-8c765f00e871@weissschuh.net>
References: <20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net>
In-Reply-To: <20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571427; l=4140;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=H+MyRN8zYY9LAZ6Zrgq/Gv/BdcVNW+EWYlmKSZVjTx8=;
 b=6tOoxDuMIzAUusNCKaq42pxr4CqAg6TXb3tonz5fFfurQzv4X1qPxBV2BCv4yaMmWbPvzUc1K
 ss+zY5Y1TEKCWXnv4mdrWEQEfzekZeKPguTciroKYBRgeBBAgzCqx2k
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Support for 32-bit s390 is about to be added.
As "s39032" would look horrible, use the another naming scheme.
32-bit s390 is "s390" and 64-bit s390 is "s390x",
similar to how it is handled in various toolchain components.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile     | 11 ++++++-----
 tools/testing/selftests/nolibc/run-tests.sh |  3 ++-
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index b74fa74e5ce296f032bec76ce9b3f5a3debe2b40..dad0d9fd7702f8dc9a9a552cda5305f8973c5469 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -54,6 +54,7 @@ ARCH_mips32le    = mips
 ARCH_mips32be    = mips
 ARCH_riscv32     = riscv
 ARCH_riscv64     = riscv
+ARCH_s390x       = s390
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -70,7 +71,7 @@ IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_riscv32    = arch/riscv/boot/Image
 IMAGE_riscv64    = arch/riscv/boot/Image
-IMAGE_s390       = arch/s390/boot/bzImage
+IMAGE_s390x      = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
 IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
@@ -89,7 +90,7 @@ DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_riscv32    = rv32_defconfig
 DEFCONFIG_riscv64    = defconfig
-DEFCONFIG_s390       = defconfig
+DEFCONFIG_s390x      = defconfig
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
@@ -110,7 +111,7 @@ QEMU_ARCH_ppc64le    = ppc64
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_riscv32    = riscv32
 QEMU_ARCH_riscv64    = riscv64
-QEMU_ARCH_s390       = s390x
+QEMU_ARCH_s390x      = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
@@ -138,7 +139,7 @@ QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_s390x      = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
@@ -156,7 +157,7 @@ CFLAGS_i386 = $(call cc-option,-m32)
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
-CFLAGS_s390 = -m64
+CFLAGS_s390x = -m64
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 664f92e1c5500f726ab33247321b96e8602ce185..fe4d48cc054abb1e922b31aa7b6a2395aaf61f5f 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -17,7 +17,7 @@ perform_download=0
 test_mode=system
 werror=1
 llvm=
-archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390 loongarch"
+archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390x loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
 
@@ -100,6 +100,7 @@ crosstool_arch() {
 	riscv) echo riscv64;;
 	loongarch) echo loongarch64;;
 	mips*) echo mips;;
+	s390*) echo s390;;
 	*) echo "$1";;
 	esac
 }

-- 
2.48.1


