Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C94771189
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 20:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbjHESpP (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 14:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESpO (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 14:45:14 -0400
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9331BE4;
        Sat,  5 Aug 2023 11:45:10 -0700 (PDT)
X-QQ-mid: bizesmtp78t1691261100tidbvvh9
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 02:44:59 +0800 (CST)
X-QQ-SSF: 00200000000000E0X000B00A0000000
X-QQ-FEAT: UJd4nZbM1CcH9VmzxClkr0cKwdDukNdu9aGDvRmht/UB70m5zE7F3giKejMEj
        JUN8J66vLKn6mlGW3Jza2xaIB5Dh3+tIqiX8BmRKEZdO/aVqXvaCjk2QGC5PbLe/PwxVoE7
        QOQ5UaPdMgrfUR3NQ2dtJ6cJitapMwzZBd8444fG/y8C2dhF0xfwSxhLCfEj899ySPFTRHB
        Dtr8zZkNc+NXt1h7Vg90U1eMsyaBJmTTZA50nbUho6y7PR4SnOOalGqPj+mpW3rScYtcU8I
        ZxneTrjfDCaKRQJp8QYbBK+3fpxIOP96gwZ3tzMQZukeyd/fOivAc8c1OXlTuVsOHzJQ3uC
        vHgSVGmha1k+9tLwiVb48pIVmrmEa21PY5X4tAiBEfD84E+uo3V2luZqBBIeVDErI59BfyS
        ESGfsOOjJQM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3337033072005867611
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v6 6/8] selftests/nolibc: add test support for ppc64
Date:   Sun,  6 Aug 2023 02:44:58 +0800
Message-Id: <ad54ccbf909547053e0c8a7dab0c38b3e919d377.1691259983.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691259983.git.falcon@tinylab.org>
References: <cover.1691259983.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
ppc64 variant for big endian 64-bit PowerPC, users can pass XARCH=ppc64
to test it.

The powernv machine of qemu-system-ppc64 is used with
powernv_be_defconfig.

As the document [1] shows:

  PowerNV (as Non-Virtualized) is the “bare metal” platform using the
  OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can be
  used as an hypervisor OS, running KVM guests, or simply as a host OS.

Notes,

- differs from little endian 64-bit PowerPC, vmlinux is used instead of
  zImage, because big endian zImage [2] only boot on qemu with x-vof=on
  (added from qemu v7.0) and a fixup patch [3] for qemu v7.0.51:

- since the VSX support may be disabled in kernel side, to avoid
  "illegal instruction" errors due to missing VSX kernel support, let's
  simply let compiler not generate vector/scalar (VSX) instructions via
  the '-mno-vsx' option.

- as 'man gcc' shows, '-mmultiple' is used to generate code that uses
  the load multiple word instructions and the store multiple word
  instructions. Those instructions do not work when the processor is in
  little-endian mode (except PPC740/PPC750), so, we only enable it
  for big endian powerpc.

- for big endian ppc64, as the help message from arch/powerpc/Kconfig
  shows, the V2 ABI is standard for 64-bit little-endian, but for
  big-endian it is less well tested by kernel and toolchain, so, use
  elfv1 as-is, no need to explicitly ask toolchain to use elfv2 here.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powernv.html
[2]: https://github.com/linuxppc/issues/issues/402
[3]: https://lore.kernel.org/qemu-devel/20220504065536.3534488-1-aik@ozlabs.ru/

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230722121019.GD17311@1wt.eu/
Link: https://lore.kernel.org/lkml/20230719043353.GC5331@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 586f278ddd66..452d8e424d28 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -35,6 +35,7 @@ XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
 ARCH_ppc         = powerpc
+ARCH_ppc64       = powerpc
 ARCH_ppc64le     = powerpc
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
@@ -46,6 +47,7 @@ IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
 IMAGE_ppc        = vmlinux
+IMAGE_ppc64      = vmlinux
 IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
@@ -61,6 +63,7 @@ DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_ppc        = pmac32_defconfig
+DEFCONFIG_ppc64      = powernv_be_defconfig
 DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
@@ -78,6 +81,7 @@ QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
+QEMU_ARCH_ppc64      = ppc64
 QEMU_ARCH_ppc64le    = ppc64le
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
@@ -92,6 +96,7 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_ppc64      = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -109,6 +114,7 @@ Q=@
 endif
 
 CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
+CFLAGS_ppc64 = -m64 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_ppc64le = -m64 -mlittle-endian -mno-vsx $(call cc-option,-mabi=elfv2)
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
-- 
2.25.1

