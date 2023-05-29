Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C11671502A
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 22:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjE2UDb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 16:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjE2UDa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 16:03:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1E2B7;
        Mon, 29 May 2023 13:03:28 -0700 (PDT)
X-QQ-mid: bizesmtp69t1685390599tn4jgnkv
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 04:03:18 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: k0mQ4ihyJQNl0tPjdjOgNqX0jjoVkxp1GSPuWGQl656yikeNBviNJKBitUkp6
        lm+aMUjEhrGBVafJe/0RXm005dmvPr0svXZCa00fN2INLXf8FnX81RmDUt2RhzUgAQmcJaY
        X/4en6armYsi4js8RQbWSj7MXj+1rrUUZu0TBjhA9ohK0H0sNutaoVfQBevgcxiUkv87vvL
        +//jtz8F0e5Q0CYbDrwZ5uz07UcKaxwX0zS7KvhqZyM0K2PQzxduLNZPan30L2AVmLACHeh
        eURVC7zC4QyiX2NfPz2+tAWb4UnLZt1DZtzFcv2zFEbXFBGRgAzzEve+INc5O82EGXUTX6q
        Jn2upXB9ZPMongQJPWwow/0kN1eZf1RBE53Rw0kETzF1NOKT5hNlIbUUAZG6V5q2HzXpa8i
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5246615934604989803
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 13/13] selftests/nolibc: riscv: customize makefile for rv32
Date:   Tue, 30 May 2023 04:03:13 +0800
Message-Id: <6f065441a6be9e63238ffb3d43cf09a6e4ac6773.1685387485.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685387484.git.falcon@tinylab.org>
References: <cover.1685387484.git.falcon@tinylab.org>
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

