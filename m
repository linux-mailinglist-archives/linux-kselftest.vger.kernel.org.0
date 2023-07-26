Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AE27639AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjGZO5b (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234177AbjGZO5X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:57:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2124A1FD5;
        Wed, 26 Jul 2023 07:57:20 -0700 (PDT)
X-QQ-mid: bizesmtp67t1690383431tm86lr8y
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 22:57:10 +0800 (CST)
X-QQ-SSF: 00200000000000D0X000000A0000000
X-QQ-FEAT: jGGC4gWX7WHeFWhwhxO3Hveq3sSjr6fZllCDxklwiYrc9nm4mcpNtQxmWWNBa
        VvxEPE5vMcFZi8n2pz211ZvCgbuMdXoDtN1TIF+hbVoO0gqzi7zEuwo04zinOGnmc6ZAnWu
        B+OZpH2mC/7Ck6Xsj8KxUBX+4wP3h7xrSUTMouTgr9FMVn5EeDhNkTsrTF2yb7Vm71h5IKD
        +wUZqPZsSlR7Fkrc4xA+MkzdJO6LNW6juDf33sLvj8SlpDLBrwOVaDhFW40rAWytkCBysno
        pIoPP4IgsZdjxs8uyuDY1YgwQLpD9cnYgpEM6GZPGHm9CI81f2ey66o1EGghsWzHH68Qmzz
        E60SNRWV6kbzFnlsMk11SNjUMhetbLU1HNIoaEZ0x2IZEXCk5ClFxHgrFb9XBQeHGSG2gzl
        Zef0r7fk1EM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5434013922193432542
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 6/7] selftests/nolibc: add test support for ppc64le
Date:   Wed, 26 Jul 2023 22:57:05 +0800
Message-Id: <0466baf61a3d501870af172686f81e8d30f95849.1690373704.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690373704.git.falcon@tinylab.org>
References: <cover.1690373704.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Here adds test support for little endian 64-bit PowerPC.

The powernv machine of qemu-system-ppc64le is used for there is just a
working powernv_defconfig.

As the document [1] shows:

  PowerNV (as Non-Virtualized) is the “bare metal” platform using the
  OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can be
  used as an hypervisor OS, running KVM guests, or simply as a host OS.

Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
ppc64le variant for little endian 64-bit PowerPC, users can pass
ARCH=ppc64le to test it.

Note, since the VSX support may be disabled in kernel side, to avoid
"illegal instruction" errors due to missing VSX kernel support, let's
simply let compiler not generate vector/scalar (VSX) instructions via
the '-mno-vsx' option.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powernv.html

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 0e9abb7f3d4f..cd46b97983a4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -22,6 +22,7 @@ XARCH           := $(or $(XARCH_$(ARCH)),$(ARCH))
 # ARCH is supported by kernel
 # map from user-input variant to kernel-supported
 ARCH_ppc         = powerpc
+ARCH_ppc64le     = powerpc
 override ARCH   := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -32,6 +33,7 @@ IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
 IMAGE_ppc        = vmlinux
+IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -46,6 +48,7 @@ DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_ppc        = pmac32_defconfig
+DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -65,6 +68,7 @@ QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
+QEMU_ARCH_ppc64le    = ppc64le
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -78,6 +82,7 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -93,6 +98,7 @@ else
 Q=@
 endif
 
+CFLAGS_ppc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
-- 
2.25.1

