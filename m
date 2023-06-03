Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C62720EDA
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 11:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjFCJGX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 05:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFCJGT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 05:06:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2EE1B5;
        Sat,  3 Jun 2023 02:06:17 -0700 (PDT)
X-QQ-mid: bizesmtp76t1685783167t32ijw6q
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 17:06:06 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: XBN7tc9DADKW+yryutXgxkBktiocyVQWqIBJpHLPEYQQnedoqzSogJlmBvRch
        UNUBX4WxjurDWKmNTfPSC/M9TEYXV3HyQsc69/eU2u2ydk/ZOAHadlF7T5yBR9SLziXeNzZ
        y1gbAvQGaP56JA+VTBffneB/pGSwFKsN2TqmsgnrvnBijWdEtG7Y8erMbLLlXrxyDVCTrQ8
        j8uK1oQLbkgTFGAkrh72oZHh3CPMlzfII5e1tfN9lPwP0daM8tuwo4UiidXJWrt3BGnZKxK
        Z7GsmYsjGBzzVQGbj2jFO/yv1qhOoGd/u+TOzIWqYCmBCV1sofw9bJAhaAYDVNolJpIwBlT
        84q6FFYa13cajHnJq4k/YKSwLSfRZBWrfOTHJ/0y+pUcOspWnourKnqNfE7msxkJesw9aYe
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10907565282954652268
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 3/3] selftests/nolibc: riscv: customize makefile for rv32
Date:   Sat,  3 Jun 2023 17:05:58 +0800
Message-Id: <ca162c288c3eeda309c33049711b5272eb80f8e2.1685780412.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685780412.git.falcon@tinylab.org>
References: <cover.1685780412.git.falcon@tinylab.org>
MIME-Version: 1.0
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

* the same ARCH value, it is riscv
* the same arch/riscv source code tree

The only differences are:

* riscv64 uses defconfig, riscv32 uses rv32_defconfig
* riscv64 uses qemu-system-riscv64, riscv32 uses qemu-system-riscv32
* riscv32 has different compiler options (-march= and -mabi=)

So, riscv32 can share most of the settings with riscv64, there is no
need to add it as a whole new architecture but just need a flag to
record and reflect the difference.

The 32bit mips and loongarch may be able to use the same method, so,
let's use a meaningful flag: CONFIG_32BIT. If required in the future,
this flag can also be automatically loaded from
include/config/auto.conf.

With this patch, it is able to run nolibc test for rv32 like this:

    $ make run ARCH=riscv32 CROSS_COMPILE=riscv64-linux-gnu- ...

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 44088535682e..ea434a0acdc1 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -14,6 +14,12 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# Allow pass ARCH=riscv|riscv32|riscv64, riscv implies riscv64
+ifneq ($(findstring xriscv,x$(ARCH)),)
+  CONFIG_32BIT := $(if $(findstring 32x,$(ARCH)x),1)
+  override ARCH := riscv
+endif
+
 # kernel image names by architecture
 IMAGE_i386       = arch/x86/boot/bzImage
 IMAGE_x86_64     = arch/x86/boot/bzImage
@@ -34,7 +40,7 @@ DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
-DEFCONFIG_riscv      = defconfig
+DEFCONFIG_riscv      = $(if $(CONFIG_32BIT),rv32_defconfig,defconfig)
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(ARCH))
@@ -49,7 +55,7 @@ QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
-QEMU_ARCH_riscv      = riscv64
+QEMU_ARCH_riscv      = $(if $(CONFIG_32BIT),riscv32,riscv64)
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
 QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
@@ -76,6 +82,7 @@ else
 Q=@
 endif
 
+CFLAGS_riscv = $(if $(CONFIG_32BIT),-march=rv32i -mabi=ilp32)
 CFLAGS_s390 = -m64
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
-- 
2.25.1

