Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67527656BE
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 17:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjG0PEj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 11:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232513AbjG0PEi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 11:04:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243061B8;
        Thu, 27 Jul 2023 08:04:34 -0700 (PDT)
X-QQ-mid: bizesmtp70t1690470266t586bzuu
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jul 2023 23:04:25 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: 3M0okmaRx3gPFTAlMPOq33XYBppQ3ibHL9kcA4lcT102GiH/EzFE2/pUKdKg/
        qX746XefN/rEXBljm6dggSvFNhOHt957ygPgTxnvJDL8JQuUCQhkrUB/2CT/zuq1iuCqXxz
        X3enym8Rq/k8b/Ex50PlgNuPDG11o6TQHTdWK5gR9JBdQxtqcFZQG2oNeXGqbQW66HJQv/g
        44i3g4qQQaZgDCTy5SChRCYUYs1rq3zW9h2ZJBr7KkJHhMYikt750oVmV3M0KLZbQVYLVPA
        sH6GpIGoWlyh+iQB0EZ14rHAetiIANAQlOyk3o918hY9MfrU7lkwNgDo2RzT8R61jTasdTg
        aey92Igt3Y4evnlgFO5IrY+GpTTvO1VprhEewU5/qacrSvOqXBQSqUP7U7sxDEFCOi3W93c
        CuqI6uKNy58=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14717604939975229498
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 5/7] selftests/nolibc: add test support for ppc
Date:   Thu, 27 Jul 2023 23:04:24 +0800
Message-Id: <8019280baee8efb6c82f5ce766fcd826b7d1ffa2.1690468707.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690468707.git.falcon@tinylab.org>
References: <cover.1690468707.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Kernel uses ARCH=powerpc for both 32-bit and 64-bit PowerPC, here adds a
ppc variant for 32-bit PowerPC and uses it as the default variant of
powerpc architecture.

Users can pass ARCH=powerpc or ARCH=ppc to test 32-bit PowerPC.

The default qemu-system-ppc g3beige machine [1] is used to run 32-bit
powerpc kernel.

The pmac32_defconfig is used with extra PMACZILOG console options to
enable normal print.

Note, zImage doesn't boot due to "qemu-system-ppc: Some ROM regions are
overlapping" error, so, vmlinux is used instead.

[1]: https://qemu.readthedocs.io/en/latest/system/ppc/powermac.html

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZL9leVOI25S2+0+g@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile           | 6 ++++++
 tools/testing/selftests/nolibc/configs/ppc.config | 3 +++
 2 files changed, 9 insertions(+)
 create mode 100644 tools/testing/selftests/nolibc/configs/ppc.config

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 5afb3e7d7723..832b9ffcbac4 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -16,10 +16,12 @@ endif
 
 # XARCH is used to save user-input ARCH variant
 # configure default variants for target kernel supported architectures
+XARCH_powerpc    = ppc
 XARCH           := $(or $(XARCH_$(ARCH)),$(ARCH))
 
 # ARCH is supported by kernel
 # map from user input variants to their kernel supported architectures
+ARCH_ppc         = powerpc
 override ARCH   := $(or $(ARCH_$(XARCH)),$(XARCH))
 
 # kernel image names by architecture
@@ -29,6 +31,7 @@ IMAGE_x86        = arch/x86/boot/bzImage
 IMAGE_arm64      = arch/arm64/boot/Image
 IMAGE_arm        = arch/arm/boot/zImage
 IMAGE_mips       = vmlinuz
+IMAGE_ppc        = vmlinux
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
@@ -42,6 +45,7 @@ DEFCONFIG_x86        = defconfig
 DEFCONFIG_arm64      = defconfig
 DEFCONFIG_arm        = multi_v7_defconfig
 DEFCONFIG_mips       = malta_defconfig
+DEFCONFIG_ppc        = pmac32_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
@@ -60,6 +64,7 @@ QEMU_ARCH_x86        = x86_64
 QEMU_ARCH_arm64      = aarch64
 QEMU_ARCH_arm        = arm
 QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
+QEMU_ARCH_ppc        = ppc
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
@@ -72,6 +77,7 @@ QEMU_ARGS_x86        = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(
 QEMU_ARGS_arm64      = -M virt -cpu cortex-a53 -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_arm        = -M virt -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
+QEMU_ARGS_ppc        = -M g3beige -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
diff --git a/tools/testing/selftests/nolibc/configs/ppc.config b/tools/testing/selftests/nolibc/configs/ppc.config
new file mode 100644
index 000000000000..b1975f8253f7
--- /dev/null
+++ b/tools/testing/selftests/nolibc/configs/ppc.config
@@ -0,0 +1,3 @@
+CONFIG_SERIAL_PMACZILOG=y
+CONFIG_SERIAL_PMACZILOG_TTYS=y
+CONFIG_SERIAL_PMACZILOG_CONSOLE=y
-- 
2.25.1

