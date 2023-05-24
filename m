Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1F970FD34
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 May 2023 19:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjEXRvf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 May 2023 13:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjEXRvb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 May 2023 13:51:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C38119;
        Wed, 24 May 2023 10:51:26 -0700 (PDT)
X-QQ-mid: bizesmtp74t1684950681t6yn0ug4
Received: from linux-lab-host.localdomain ( [116.30.125.36])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 25 May 2023 01:51:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: XBN7tc9DADIjgXxH3TLgSj0VxrQrlL8zhmh+je68CBXjsGiccEXwXly8k6tY2
        sC6ZTFBT/sSxaXpDpmnl0LuhIAIGbtTvL5iSFY/1OirQIpXra0UPbmdM27b0Too6T6HMjnI
        SfX8v6h6fpBl9pr85gssp4sQRvlDlefaiz21KSWLsuDAH+5hlMhyWQ9dJJ0jaTZjmnUgZTl
        WfBb83pbAN6Y2MHZ0Z1N0713TbxSUgJgxPdTE5p4QCAwVJzfrLjfM+rchc1rauuUwS9ZL2Q
        +zzJYhPPZycNK74ty8mb/+lulh9ITcXDtfNrrrTrPvtIKDqUWa71PYM6R8Zc7w8Tx+dB1h5
        gc0kJfc4Uo+Z7HG2jUcWLfat5YfgHjhNbNwJaOt7iBXLsZ1r9c10EoJ9fC8kA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9362597726359131940
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        palmer@dabbelt.com, paul.walmsley@sifive.com, thomas@t-8ch.de
Subject: [PATCH 05/13] selftests/nolibc: riscv: customize makefile for rv32
Date:   Thu, 25 May 2023 01:50:57 +0800
Message-Id: <7adb27a7c56dd06d782710a5f684ea6263900f98.1684949268.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1684949267.git.falcon@tinylab.org>
References: <cover.1684949267.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

both riscv64 and riscv32 have the same ARCH value, it is riscv, the
default defconfig enables 64bit, to support riscv32, let's allow pass
"ARCH=riscv32" or "ARCH=riscv CONFIG_32BIT=1" to customize riscv32
setting.

Note: glibc >= 2.33 is required to avoid a bug of the old
bits/wordsize.h.

  /usr/riscv64-linux-gnu/include/bits/wordsize.h:28:3: error: #error "rv32i-based targets are not supported"
           28 | # error "rv32i-based targets are not supported"

This can not pass compile, several time64 syscalls are still missing.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 47c3c89092e4..9adc8944dd80 100644
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
 
+CFLAGS_riscv = $(if $(CONFIG_32BIT),-march=rv32im -mabi=ilp32)
 CFLAGS_s390 = -m64
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
-- 
2.25.1

