Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8559376BE09
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjHATqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjHATp7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:45:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2FA2114;
        Tue,  1 Aug 2023 12:45:57 -0700 (PDT)
X-QQ-mid: bizesmtp76t1690919148ty1bac8r
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:45:47 +0800 (CST)
X-QQ-SSF: 00200000000000E0X000000A0000000
X-QQ-FEAT: 96VJ2VzXm/qtcW83G+rHd8m5WjuxNQBWKPUUXvOrXDI9B+etoLQfu8ZCvn2fw
        tYjN7Veqc/sXQ1SSALLcaHQgL+obZbeIdrIFk2aQdIgQAwPMXYO47Ooy3v0yWPpDUybg9b5
        gbSP0C6G15zDR8IWZ12c8TQppAGXlQiTlyL8lJxbZ2k9aXWuJqUhr/5kyg3QLq7OkzALSiI
        EXkwSrkiB9TPYkc3UPoZaS+9h01jg0LqY183MwVDopZCh9HsXaGOvcVae4/jA2B/Moq/JZ4
        IBEjom6N300FTouvb8DksVKEzy4t9JxZ68XvfoNUDDpG6GYw5UGPVlBktbFRIyJU3f0jlk5
        kpQqRmqaROTQjKkkw0dSYaH+YdqNtIDWk5f0S1bnX6TtnAWwzd7PoM16ZmegmJWtjcoyuhz
        aLAO4t/cxto=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5754352481238065369
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 09/12] selftests/nolibc: add test support for ppc64le
Date:   Wed,  2 Aug 2023 03:45:47 +0800
Message-Id: <9f20dae8ceec373408ab05140710ae1552082982.1690916314.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690916314.git.falcon@tinylab.org>
References: <cover.1690916314.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
ppc64le variant for little endian 64-bit PowerPC, users can pass
XARCH=ppc64le to test it.

The powernv machine of qemu-system-ppc64le is used for there is just a
working powernv_defconfig.

As the document [1] shows:

  PowerNV (as Non-Virtualized) is the “bare metal” platform using the
  OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can be
  used as an hypervisor OS, running KVM guests, or simply as a host OS.

Note, since the VSX support may be disabled in kernel side, to avoid
"illegal instruction" errors due to missing VSX kernel support, let's
simply let compiler not generate vector/scalar (VSX) instructions via
the '-mno-vsx' option.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powernv.html

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230722120747.GC17311@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 29e02b49903a..8ec2ae33fdcd 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -38,6 +38,7 @@ XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # map from user input variants to their kernel supported architectures
 ARCH_ppc         = powerpc
+ARCH_ppc64le     = powerpc
 ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -48,6 +49,7 @@ IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
 IMAGE_ppc        = vmlinux
+IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -62,6 +64,7 @@ DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_ppc        = pmac32_defconfig
+DEFCONFIG_ppc64le    = powernv_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -82,6 +85,7 @@ QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_ppc        = ppc
+QEMU_ARCH_ppc64le    = ppc64le
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -95,6 +99,7 @@ QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_ppc64le    = -M powernv -append "console=hvc0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -110,6 +115,7 @@ else
 Q=@
 endif
 
+CFLAGS_ppc64le = -m64 -mlittle-endian -Wl,-EL,-melf64ppc -mno-vsx
 CFLAGS_s390 = -m64
 CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
-- 
2.25.1

