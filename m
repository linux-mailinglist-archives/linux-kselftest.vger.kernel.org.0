Return-Path: <linux-kselftest+bounces-24965-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2159DA198BA
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 19:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEDC43A48D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 22 Jan 2025 18:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B85215798;
	Wed, 22 Jan 2025 18:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="GImT0pzs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5140215F43;
	Wed, 22 Jan 2025 18:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737571431; cv=none; b=QhkUgW9KkHvDbwpfuxHVbbv28QF13cQrAqi15u/IUTeO5HObmMI7GWTOWqrC48hj2sS3CdXCjAqS1tqD8r8AEdvlwLjmX41S2+ydQURsSlgdISUi1dw8SLwqvlJNjIudTsXTmEy2Z11DFO5TajGbRbUv3T8AicPXceoNxAy4/kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737571431; c=relaxed/simple;
	bh=PcJCpE+OHm6iXQvJHp/6Qfw3w2pG3knf627iKQA+ceQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaty1h6acR7SfEDjvovaGdzknZRBHG3sle/hlzeNJXZc4JAV1cJLwlJlTaTkHOc6ugollPhX8DkfhLtT/9QrV2yLnMTvSRnx3m3sz/95MrmqVX/6dkTm6+bju00dZTKbCFrETXymGWCP2aPERBXZLJhd0uiXPoNuLL87tOnKI5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=GImT0pzs; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737571427;
	bh=PcJCpE+OHm6iXQvJHp/6Qfw3w2pG3knf627iKQA+ceQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GImT0pzsDA9ALB57iH2a9oVcPdRWbzs5Q5N649HStOs90T0BCt1hHHq2FJoSuWALo
	 zcENHktj4YqQAbGCr6QQbli78e3BtKT3Es6HZnFeaNH4mAdZ8539IWkGHoxafg3lY2
	 xmUGGEk4/bi11EM5ZJtjfjIl6TwWFXIy/3Gh4nPs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 22 Jan 2025 19:43:46 +0100
Subject: [PATCH 2/2] tools/nolibc: add support for 32-bit s390
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250122-nolibc-s390-v1-2-8c765f00e871@weissschuh.net>
References: <20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net>
In-Reply-To: <20250122-nolibc-s390-v1-0-8c765f00e871@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737571427; l=5354;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PcJCpE+OHm6iXQvJHp/6Qfw3w2pG3knf627iKQA+ceQ=;
 b=JhKzSTcSbjBbW840Kqn0ZhezYNH8cn9QmGD8ydlXv48FiTTPdkp8n6vXSAqjN8s/MsKvHMOuS
 7nELTM6ji/8AiZgqSegFR/vW7Inb1WaFL2z+6bhCU+BoB+lQvvniRbQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

32-bit s390 is very close to the existing 64-bit implementation.

Some special handling is necessary as there is neither LLVM nor
QEMU support. Also the kernel itself can not build natively for 32-bit
s390, so instead the test program is executed with a 64-bit kernel.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/include/nolibc/arch-s390.h            | 5 +++++
 tools/include/nolibc/arch.h                 | 2 +-
 tools/testing/selftests/nolibc/Makefile     | 5 +++++
 tools/testing/selftests/nolibc/run-tests.sh | 7 ++++++-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index f9ab83a219b8a2d5e53b0b303d8bf0bf78280d5f..3f2fb00ca101cc052f3b794b743e9e5734fe5a77 100644
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
+		"ahi	%r15, -160\n"
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
index dad0d9fd7702f8dc9a9a552cda5305f8973c5469..dc5cf19dd74389336b619e15e07f1c635241b7d7 100644
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
 
@@ -112,6 +114,7 @@ QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_riscv32    = riscv32
 QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_s390x      = s390x
+QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
@@ -140,6 +143,7 @@ QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_T
 QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390x      = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_s390       = -M s390-ccw-virtio -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS            = -m 1G $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_BIOS) $(QEMU_ARGS_EXTRA)
 
@@ -158,6 +162,7 @@ CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390x = -m64
+CFLAGS_s390 = -m31
 CFLAGS_mips32le = -EL -mabi=32 -fPIC
 CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index fe4d48cc054abb1e922b31aa7b6a2395aaf61f5f..79874f669b2a364ad1cb2399b4ebbab5ec6c9de9 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -17,7 +17,7 @@ perform_download=0
 test_mode=system
 werror=1
 llvm=
-archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390x loongarch"
+archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv32 riscv64 s390x s390 loongarch"
 
 TEMP=$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
 
@@ -171,6 +171,11 @@ test_arch() {
 			exit 1
 	esac
 	printf '%-15s' "$arch:"
+	if [ "$arch" = "s390" ] && ([ "$llvm" = "1" ] || [ "$test_mode" = "user" ]); then
+		echo "Unsupported configuration"
+		return
+	fi
+
 	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" defconfig "$test_target" V=1
 	cp run.out run.out."${arch}"
 	"${MAKE[@]}" report | grep passed

-- 
2.48.1


