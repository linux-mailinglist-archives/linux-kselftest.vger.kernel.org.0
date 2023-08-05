Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60795771183
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 20:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbjHESnD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 14:43:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHESnD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 14:43:03 -0400
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FA21FA;
        Sat,  5 Aug 2023 11:43:00 -0700 (PDT)
X-QQ-mid: bizesmtp82t1691260969t7f7paue
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Aug 2023 02:42:48 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000B00A0000000
X-QQ-FEAT: hoArX50alxHe+LG930oTCoN8UcIoR96135u+XWn6mkEwd0LvnmOseMiK8ZsCV
        qTdHjFayED5dmWG/j2aRiB/U7nISQB6crrt+wKiBXvCD+SVM9GlVhi4TqAo7HUs7MKxEl+e
        ntC0Q8LUNa0MemGLXOrJ699PaKzoDM8K9Aq264BQM2akqEdUVivCkPVb2irFUO1PuqKvj7d
        b+kpaTH0ZWlSNLQGey/P84QkeMgvRneKrCpvEctlKMW/Tk6LF3uSu2N3P2OjRA4yaDU50EC
        IQiqh2rlLFyyxOB7lbutJI5PbVPKNzeYXbGDdgoDym7a7Xpblweq7xoTzYo2Jx7VQMkSIFT
        Yqxn5kVoVso9Spa+uZ0pBEBuA193UlPX2Hh1vC14yKviuS1mkPTNfT6MTJCa/XEvo5HQZcT
        s2f1kFm1vAE=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1566790808252503887
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, tanyuan@tinylab.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v6 4/8] selftests/nolibc: add test support for ppc
Date:   Sun,  6 Aug 2023 02:42:43 +0800
Message-Id: <f597dca2bd3baed4cc9aab7621a7b76481fdb3ce.1691259983.git.falcon@tinylab.org>
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
ppc variant for 32-bit PowerPC and uses it as the default variant of
powerpc architecture.

Users can pass XARCH=ppc (or ARCH=powerpc) to test 32-bit PowerPC.

The default qemu-system-ppc g3beige machine [1] is used to run 32-bit
powerpc kernel with pmac32_defconfig. The missing PMACZILOG serial tty
and console are enabled in another patch [2].

Note,

- zImage doesn't boot due to "qemu-system-ppc: Some ROM regions are
  overlapping" error, so, vmlinux is used instead.

- since the VSX support may be disabled in kernel side, to avoid
  "illegal instruction" errors due to missing VSX kernel support, let's
  simply let compiler not generate vector/scalar (VSX) instructions via
  the '-mno-vsx' option.

- as 'man gcc' shows, '-mmultiple' is used to generate code that uses
  the load multiple word instructions and the store multiple word
  instructions. Those instructions do not work when the processor is in
  little-endian mode (except PPC740/PPC750), so, we only enable it
  for big endian powerpc.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powermac.html
[2]: https://lore.kernel.org/lkml/bb7b5f9958b3e3a20f6573ff7ce7c5dc566e7e32.1690982937.git.tanyuan@tinylab.org/

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZL9leVOI25S2+0+g@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 46a2312b06f5..cac501e0c7cf 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -30,9 +30,11 @@ endif
 # architectures where both are equal.
 
 # configure default variants for target kernel supported architectures
+XARCH_powerpc    = ppc
 XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
+ARCH_ppc         = powerpc
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -42,6 +44,7 @@ IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
+IMAGE_ppc        = vmlinux
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -55,6 +58,7 @@ DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
+DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -70,6 +74,7 @@ QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
+QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -82,6 +87,7 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -97,6 +103,7 @@ else
 Q=@
 endif
 
+CFLAGS_ppc = -m32 -mbig-endian -mno-vsx $(call cc-option,-mmultiple)
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
-- 
2.25.1

