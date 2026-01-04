Return-Path: <linux-kselftest+bounces-48146-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9B6CF1682
	for <lists+linux-kselftest@lfdr.de>; Sun, 04 Jan 2026 23:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2701C3008E94
	for <lists+linux-kselftest@lfdr.de>; Sun,  4 Jan 2026 22:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB8B2EBBA2;
	Sun,  4 Jan 2026 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AzpYGunk"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2927B50F;
	Sun,  4 Jan 2026 22:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767564870; cv=none; b=j3Dubc9GLfCLcoCbOcjYaVmJj5PStT6z9GNGrTl7t4NoAkSVceZUhy7UqZbTWNEF1Bj4cTeho2TSyaFm009MglpE63zCY/fRwJ4902cH/tWEfreONPzbg8zaxThyvwLkNQaLb12ABtY+YPqu5uk15oAEb4/pdqz59V0Ga5/nz6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767564870; c=relaxed/simple;
	bh=a8FkxiaD0pnteuH9Mzpab8eTkp7dE4AY53qcox0BsbI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Gz3fkxEY5LZ3dFi9xKikF78XC6uS/7sOjGF+KYlN5LW51VPTKU4vdpVdL1Q8D4bAhFYGl5BaJ8htqx9j60YFZray8fJQ7O2NiLIkBeDIbw77ygfGSzGxPJR6uYc5C3ApuXfut7kF3BIPWO+I3vHJaYfv53mWSaAEiTasLH9W7LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AzpYGunk; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1767564865;
	bh=a8FkxiaD0pnteuH9Mzpab8eTkp7dE4AY53qcox0BsbI=;
	h=From:Date:Subject:To:Cc:From;
	b=AzpYGunkWFfn/y+3cscti6u1Jewk5HG9R56tHKrBs+3AjDxRLTbTZLI5LJnfpON/M
	 leDzVTJBEk0G8iD05PWWvbEgne+J00VIP4RxeKaxIVzsVhId5Nw798pgVP7ZHmUVUI
	 S1gOtX+ceJDKwQx5utcXhxpFREg6VG6SsVl4rqH8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 04 Jan 2026 23:14:13 +0100
Subject: [PATCH] selftests/nolibc: fix sparc32 tests with -mcpu=v9
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260104-nolibc-sparc32-fix-v1-1-e341b06cbdb7@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIADTmWmkC/x2MQQqAIBAAvxJ7bkE3ieor0UFtrYWwUIgg/HvSc
 QZmXsichDNMzQuJb8lyxgq6bcDvNm6MslYGUtQrrQzG8xDnMV82+Y4wyIOG3DCSddqrADW8Elf
 9T+ellA+nkSpKZAAAAA==
X-Change-ID: 20260104-nolibc-sparc32-fix-42b892ab1c0f
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767564865; l=2976;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=a8FkxiaD0pnteuH9Mzpab8eTkp7dE4AY53qcox0BsbI=;
 b=liaAFKqkaeF52M6Sg7AS3jCXFAENhLMgO+KoCcy6W8wGMjD/9Fj0SGi0dnkO0TFW9WcmxdLFq
 bqTQEhxcE75CKUIaJthFplSzYKg1Kjdekj8fMXwZou/e+TpMBO8pI0H
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Since LLVM commit 39e30508a7f6 ("[Driver][Sparc] Default to -mcpu=v9 for
32-bit Linux/sparc64 (#109278)"), clang defaults to -mcpu=v9 for 32-bit
SPARC builds. -mcpu=v9 generates instructions which are not recognized
by qemu-sparc and qemu-system-sparc. Instead qemu-sparc32plus and
qemu-system-sparc64 with a 64-bit kernel and CONFIG_COMPAT are needed.

Rework the test setup so that -mcpu=v9 also works correctly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile.nolibc | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile.nolibc b/tools/testing/selftests/nolibc/Makefile.nolibc
index f9d43cbdc894..18f550c68932 100644
--- a/tools/testing/selftests/nolibc/Makefile.nolibc
+++ b/tools/testing/selftests/nolibc/Makefile.nolibc
@@ -117,7 +117,7 @@ DEFCONFIG_riscv32    = rv32_defconfig
 DEFCONFIG_riscv64    = defconfig
 DEFCONFIG_s390x      = defconfig
 DEFCONFIG_loongarch  = defconfig
-DEFCONFIG_sparc32    = sparc32_defconfig
+DEFCONFIG_sparc32    = sparc64_defconfig
 DEFCONFIG_sparc64    = sparc64_defconfig
 DEFCONFIG_m68k       = virt_defconfig
 DEFCONFIG_sh4        = rts7751r2dplus_defconfig
@@ -155,7 +155,7 @@ QEMU_ARCH_riscv32    = riscv32
 QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_s390x      = s390x
 QEMU_ARCH_loongarch  = loongarch64
-QEMU_ARCH_sparc32    = sparc
+QEMU_ARCH_sparc32    = sparc64
 QEMU_ARCH_sparc64    = sparc64
 QEMU_ARCH_m68k       = m68k
 QEMU_ARCH_sh4        = sh4
@@ -164,6 +164,7 @@ QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 QEMU_ARCH_USER_ppc64le = ppc64le
 QEMU_ARCH_USER_mipsn32le = mipsn32el
 QEMU_ARCH_USER_mipsn32be = mipsn32
+QEMU_ARCH_USER_sparc32 = sparc32plus
 QEMU_ARCH_USER         = $(or $(QEMU_ARCH_USER_$(XARCH)),$(QEMU_ARCH_$(XARCH)))
 
 QEMU_BIOS_DIR = /usr/share/edk2/
@@ -195,7 +196,7 @@ QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_T
 QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390x      = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS_sparc32    = -M SS-5 -m 256M -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_sparc32    = -M sun4u -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_sparc64    = -M sun4u -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_m68k       = -M virt -append "console=ttyGF0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_sh4        = -M r2d -serial file:/dev/stdout -append "console=ttySC1,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"

---
base-commit: 9d16b22b17ddfd27df1da6088a962a72658f46d1
change-id: 20260104-nolibc-sparc32-fix-42b892ab1c0f

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


