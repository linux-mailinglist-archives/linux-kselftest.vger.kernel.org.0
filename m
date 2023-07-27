Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3BD7656B1
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 17:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjG0PDc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 11:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234106AbjG0PDb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 11:03:31 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406CA0;
        Thu, 27 Jul 2023 08:03:29 -0700 (PDT)
X-QQ-mid: bizesmtp77t1690470199tpjd4kf7
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jul 2023 23:03:18 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: rZJGTgY0+YMRpS1qYEzYM26oLmGEy05P+ZWt64uSt0g1LCQW3zax2yYj9/qE/
        IAqlig2SaXfAtDFWaLCNxZmPwrueHkgrcNnbL1xx/W3qKbQd1y/hoyrrbHEBZZNioU2VNkz
        NwqYZ3Mx9mOxo6WGpa4NpdfNmDVYc6CcadAUbBBaj46f+OSCxq1WzoFKsW7YA7Yn/sgn+5z
        MR8/omeirrpLVw8B6PgInOT4aMPnXBPb7m9eovpqVLfpuFYBkqRUO2xlN5TAsruSQi5bmar
        H4y4KSPH5lx5BFqs2EEhJ5UEzGrO3I6KF6h4Jt3IFdFxHVfIHhlBUQ7iTiWgblGTvr1/cNJ
        mXtn9RdCG9PuJT7FzaAeRwaaxwKEZtjNvKEbAk1HA10VnWg1fZyFBV5UeCaC9WbiFd6mShN
        FPhi3BB9CkM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16471828213070841702
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 4/7] selftests/nolibc: add XARCH and ARCH mapping support
Date:   Thu, 27 Jul 2023 23:03:17 +0800
Message-Id: <45cc24c1cf8794782be2ae631ca01bcd136da6d9.1690468707.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690468707.git.falcon@tinylab.org>
References: <cover.1690468707.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most of the CPU architectures have different variants, but kernel
usually only accepts parts of them via the ARCH variable, the others
should be customized via kernel config files.

To simplify testing, the external ARCH variable is extended to accept
more CPU variants from user's input, a new internal XARCH variable is
added to save users' ARCH input and used to customize variant specific
variables, at last XARCH is converted to the internal ARCH variable
acceptable by kernel:

  e.g. make run ARCH=<one of the supported variants>
               /
              v
  external ARCH from cmdline -> internal XARCH -> internal ARCH for kernel
                                          |
                                          `--> variant specific variables

XARCH and ARCH are carefully mapped to allow users to pass architecture
variants via external ARCH (or XARCH) from cmdline:

- From developers' perspective

  - XARCH records the architecture variant from user's ARCH input, after
    'override ARCH', ARCH is overridden and mapped from XARCH to the one
    supported by kernel

  - Map from XARCH to the kernel supported ARCH: 'ARCH_<XARCH> = <ARCH>'

  - Configure a default variant for kernel supported ARCH: 'XARCH_<ARCH> = <XARCH>'

- From users' perspective

  - ARCH (or XARCH) are architecture variants of a target architecture

  - the variants are XARCH names from the "ARCH_<XARCH> = <ARCH>" mapping list

PowerPC is the first user and also a very good reference architecture of
this mapping, it has variants with different combinations of
32-bit/64-bit and bit endian/little endian.

To use this mapping, the other architectures can refer to PowerPC, If
the target architecture only has one variant, XARCH is simply an alias
of ARCH, no additional mapping required.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230702171715.GD16233@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 9576f1a0a98d..5afb3e7d7723 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -14,6 +14,14 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# XARCH is used to save user-input ARCH variant
+# configure default variants for target kernel supported architectures
+XARCH           := $(or $(XARCH_$(ARCH)),$(ARCH))
+
+# ARCH is supported by kernel
+# map from user input variants to their kernel supported architectures
+override ARCH   := $(or $(ARCH_$(XARCH)),$(XARCH))
+
 # kernel image names by architecture
 IMAGE_i386       = arch/x86/boot/bzImage
 IMAGE_x86_64     = arch/x86/boot/bzImage
@@ -24,7 +32,7 @@ IMAGE_mips       = vmlinuz
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
-IMAGE            = $(IMAGE_$(ARCH))
+IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # default kernel configurations that appear to be usable
@@ -37,10 +45,10 @@ DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
-DEFCONFIG            = $(DEFCONFIG_$(ARCH))
+DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 # extra kernel config files under configs/, include common + architecture specific
-EXTCONFIG            = common.config $(ARCH).config
+EXTCONFIG            = common.config $(XARCH).config
 
 # optional tests to run (default = all)
 TEST =
@@ -55,7 +63,7 @@ QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
-QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
+QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
 QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -67,7 +75,7 @@ QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
+QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
@@ -84,7 +92,7 @@ CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
-		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
+		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
@@ -111,12 +119,13 @@ help:
 	@echo ""
 	@echo "Currently using the following variables:"
 	@echo "  ARCH          = $(ARCH)"
+	@echo "  XARCH         = $(XARCH)"
 	@echo "  CROSS_COMPILE = $(CROSS_COMPILE)"
 	@echo "  CC            = $(CC)"
 	@echo "  OUTPUT        = $(OUTPUT)"
 	@echo "  TEST          = $(TEST)"
-	@echo "  QEMU_ARCH     = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$ARCH]"
-	@echo "  IMAGE_NAME    = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$ARCH]"
+	@echo "  QEMU_ARCH     = $(if $(QEMU_ARCH),$(QEMU_ARCH),UNKNOWN_ARCH) [determined from \$$XARCH]"
+	@echo "  IMAGE_NAME    = $(if $(IMAGE_NAME),$(IMAGE_NAME),UNKNOWN_ARCH) [determined from \$$XARCH]"
 	@echo ""
 
 all: run
-- 
2.25.1

