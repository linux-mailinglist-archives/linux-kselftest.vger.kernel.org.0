Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066C27356E2
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229932AbjFSMaI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjFSM36 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 08:29:58 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC0791;
        Mon, 19 Jun 2023 05:29:55 -0700 (PDT)
X-QQ-mid: bizesmtp73t1687177786tu58ycog
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 20:29:45 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: FVl8EHhfVR6mCyZUawKuNgOeziftOVI0KH5LBW2YGVs3vsD+ECpNHgIeXFx/q
        55cBDOd3xctgZvSpVrgb9ncBLZmJvIhXd0bvaDoGUnDSGwfJwgKXoZBOkt6tveDZZtIBOYe
        yuUlrH/9m695KsRymGnpX9XEsCpjLYr58ubytYfvtvKx97yA35zYpfrtNc3svfC6JQ2JpMw
        hcDSSJ+eskWbHKlMVocljtJZKEb6zGLyGABTNMRap3dnet7EGZJthiLydfUncjWsxNi7xSJ
        3BVwRqCjrRMXAhmcehIoXbGhc3LkE9qI3Wfy54GOnDfaNFoXeepNrZpDk+5AiyVj3e0ZZnR
        IJYKyS445erEkiQ1yfg/CulKRr82dBR/SqneBCvfF/u8j0LPDsJzx2dCCknULy9rL0MqK26
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17039376255074177118
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v5 5/5] selftests/nolibc: riscv: customize makefile for rv32
Date:   Mon, 19 Jun 2023 20:29:38 +0800
Message-Id: <2ebfb48c66b18a5fd7d0bd6b7c832a5d8ce6486f.1687176996.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687176996.git.falcon@tinylab.org>
References: <cover.1687176996.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

Since top-level kernel Makefile only accept ARCH=riscv, to make kernel
happy, let's set kernel specific KARCH as riscv for both riscv32 and
riscv64.

And since they share the same arch-riscv.h, let's set nolibc specific
NARCH as riscv too.

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
 tools/include/nolibc/Makefile           |  4 ++++
 tools/testing/selftests/nolibc/Makefile | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/tools/include/nolibc/Makefile b/tools/include/nolibc/Makefile
index 14a6416fa57f..875e13e3c851 100644
--- a/tools/include/nolibc/Makefile
+++ b/tools/include/nolibc/Makefile
@@ -24,9 +24,13 @@ Q=@
 endif
 
 # kernel supported ARCH names by architecture
+KARCH_riscv32    = riscv
+KARCH_riscv64    = riscv
 KARCH            = $(or $(KARCH_$(ARCH)),$(ARCH))
 
 # nolibc supported ARCH names by architecture
+NARCH_riscv32    = riscv
+NARCH_riscv64    = riscv
 NARCH_arm64      = aarch64
 NARCH            = $(or $(NARCH_$(ARCH)),$(ARCH))
 
diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index ebecb8cfd947..848884204a84 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -15,6 +15,8 @@ ARCH = $(SUBARCH)
 endif
 
 # kernel supported ARCH names by architecture
+KARCH_riscv32    = riscv
+KARCH_riscv64    = riscv
 KARCH            = $(or $(KARCH_$(ARCH)),$(ARCH))
 
 # kernel image names by architecture
@@ -24,6 +26,8 @@ IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
+IMAGE_riscv32    = arch/riscv/boot/Image
+IMAGE_riscv64    = arch/riscv/boot/Image
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -37,6 +41,8 @@ DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
+DEFCONFIG_riscv32    = rv32_defconfig
+DEFCONFIG_riscv64    = defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -52,6 +58,8 @@ QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
+QEMU_ARCH_riscv32    = riscv32
+QEMU_ARCH_riscv64    = riscv64
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -64,6 +72,8 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv32    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_riscv64    = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -79,6 +89,7 @@ else
 Q=@
 endif
 
+CFLAGS_riscv32 = -march=rv32im -mabi=ilp32
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
-- 
2.25.1

