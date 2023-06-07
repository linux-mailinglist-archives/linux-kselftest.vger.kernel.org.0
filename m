Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539B7725AE3
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Jun 2023 11:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239492AbjFGJn2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Jun 2023 05:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239485AbjFGJn1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Jun 2023 05:43:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C132EB;
        Wed,  7 Jun 2023 02:43:24 -0700 (PDT)
X-QQ-mid: bizesmtp80t1686130994t5ggma8m
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 07 Jun 2023 17:43:13 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: CR3LFp2JE4mfAn2LSTK1xi8qQ4UyRaoYMHxJsMRywKHgdAG3qZj5i/iI8Gq2F
        qluTGaMPCQg796dEjFelUhz3yE2cRQpMvoRAnhlccXre+mIYL9qQKu4FMQhAgYBJSweglF9
        kr/0leOh4j8oBKxFg2gyyU9V4K8lOvNTc9+IyvSJpknvm0Jzi96r0jlC9kGPAKAOg3NKisU
        cWrZgto44qMqQuSFpnk1OcEj3Tt/+aCPDl2NgC+RN85mQQVMP0ndJNtF9xySZ9dMSJM1XLq
        byk1dnIYv3TABQOU5bFFTJIe9OxHppx3H3IykqTdkFIjFRI8u00KYm8ryj+Vx4BSU5xFBNZ
        6I11YXK6OZjQJ06s26jew+8E/pe+8Dosv1Fu1grJgVykfNd5N/UZrVsKqjH/WsYVgpQ9RTJ
        r2CCAVQVlBKzO2SjacAyKA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1815332739325030604
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 3/3] selftests/nolibc: riscv: customize makefile for rv32
Date:   Wed,  7 Jun 2023 17:37:01 +0800
Message-Id: <3698e3629148550146b986cda61539a647ebd589.1686128703.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1686128703.git.falcon@tinylab.org>
References: <cover.1686128703.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Both riscv64 and riscv32 have:

* the same arch/riscv source code tree
* the same tools/include/nolibc/arch-riscv.h
* the same ARCH=riscv value passed to top-level kernel Makefile

The only differences are:

* riscv64 uses defconfig, riscv32 uses rv32_defconfig
* riscv64 uses qemu-system-riscv64, riscv32 uses qemu-system-riscv32
* riscv32 has different compiler options (-march= and -mabi=)

So, riscv32 can share most of the settings with riscv64, add riscv32
support like the original ARCH=riscv support.

To align with x86, the default riscv is reserved for riscv64 and a new
riscv64 is also added to allow users pass ARCH=riscv64 directly.

Since top-level kernel Makefile only accept ARCH=riscv, to make it
happy, let's add a KARCH, set it as riscv for riscv32 and riscv64, and
set it as original ARCH for the others, at last pass it to kernel
targets with ARCH=$(KARCH).

The same ARCH=$(KARCH) passed to tools/include/nolibc/Makefile, for both
arch-riscv.h and the headers_standalone target require it too.

Usage:

    $ make defconfig ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- ...
    $ make run ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- ...

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/4a3b1cdf-91d5-4668-925e-21f8f5c64a92@t-8ch.de/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-riscv/d1c83340-af4c-4780-a101-b9d22b47379c@app.fastmail.com/
Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZIAywHvr6UB1J4of@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 4a3a105e1fdf..48fa22817d90 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -14,6 +14,11 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# kernel supported ARCH names by architecture
+KARCH_riscv32    = riscv
+KARCH_riscv64    = riscv
+KARCH            = $(or $(KARCH_$(ARCH)),$(ARCH))
+
 # kernel image names by architecture
 IMAGE_i386       = arch/x86/boot/bzImage
 IMAGE_x86_64     = arch/x86/boot/bzImage
@@ -21,6 +26,8 @@ IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
+IMAGE_riscv32    = arch/riscv/boot/Image
+IMAGE_riscv64    = arch/riscv/boot/Image
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -34,6 +41,8 @@ DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
+DEFCONFIG_riscv32    = rv32_defconfig
+DEFCONFIG_riscv64    = defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -49,6 +58,8 @@ QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
+QEMU_ARCH_riscv32    = riscv32
+QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -61,6 +72,8 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -76,6 +89,7 @@ else
 Q=@
 endif
 
+CFLAGS_riscv32 = -march=rv32im -mabi=ilp32
 CFLAGS_s390 = -m64
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
@@ -117,7 +131,7 @@ sysroot: sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
-	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
+	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(KARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
 nolibc-test: nolibc-test.c sysroot/$(ARCH)/include
@@ -141,10 +155,10 @@ initramfs: nolibc-test
 	$(Q)cp nolibc-test initramfs/init
 
 defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
 kernel: initramfs
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # run the tests after building the kernel
 run: kernel
-- 
2.25.1

