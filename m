Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9783C7639A4
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234075AbjGZOyu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbjGZOyt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:54:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F10D2135;
        Wed, 26 Jul 2023 07:54:45 -0700 (PDT)
X-QQ-mid: bizesmtp67t1690383276tza3l49q
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 22:54:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: r/cTxDoDoiFjb4JVRsMIgBybvgGHeXlw6CGhAu8N0T0dgbDdPlnhEzj5qjA9U
        RGODEI2n+1TT4nmIX3JXDAh/Z5olvgc1R5vAdtpGjKPrv4ckIFp3ciD1SXhl8sVkSEA75zM
        nXA6uJ4mZOYuQgqiQhrwISXcL7SvqvKH93rc7xvehVM1kQA4jEPe/JMduL8gOoO15+tnCuy
        YT0lx5a3u465mj5R1oz78QjysAdkkwIn1/PCC3x5nHK5wKVL76lSai4M9WxQcxfxHeHEm4j
        4eiCoeNzvQIX+FqBJiLoFB2bthvw0UAf7ZeLLj6s1GFT1mKLud6P3dLdbXIVTIe/10n6fF+
        Z3Q7mbKNdvYhXT56sEwKXo1ydqP20Q6TXk8m0bSJt3/BBFSHTDLroEdklq3mELFUS6w0XYG
        leSO6sakNHw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7571784619353913893
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 4/7] selftests/nolibc: add XARCH and ARCH mapping support
Date:   Wed, 26 Jul 2023 22:54:23 +0800
Message-Id: <4260bf6df7417ba5395e7a1f71609690bbd11b17.1690373704.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690373704.git.falcon@tinylab.org>
References: <cover.1690373704.git.falcon@tinylab.org>
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
usually only accept parts of them via the ARCH variable, the others
should be customized via kernel config file.

To simplify testing, the external ARCH variable is extended to accept
more CPU variants from user's input, a new internal XARCH variable is
added to save users' ARCH input and used to customize variant specific
variables, at last convert XARCH to the internal ARCH variable
acceptable by kernel:

  e.g. make run-user ARCH=<variants>
        |
        v
  external ARCH from cmdline -> internal XARCH -> internal ARCH for kernel
                                          |
                                          `--> variant specific variables

XARCH and ARCH are carefully mapped to allow users to pass architecture
variants via external ARCH (or XARCH) from cmdline:

- From developers' perspective

  - XARCH records the architecture variant from user's ARCH input, after
    'override ARCH', ARCH is overridden by the one supported by kernel

  - Map from XARCH to the kernel supported ARCH: 'ARCH_<XARCH> = <ARCH>'

  - Configure a default variant for kernel supported ARCH: 'XARCH_<ARCH> = <XARCH>'

- From users' perspective

  - ARCH (or XARCH) are architecture variants of a target architecture

  - the variants are XARCH names from the "ARCH_<XARCH> = <ARCH>" mapping list

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230702171715.GD16233@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 27 ++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 9576f1a0a98d..f04ec1cc132b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -14,6 +14,14 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# XARCH is used to save user-input ARCH variant
+# allow configure default variant for target ARCH
+XARCH           := $(or $(XARCH_$(ARCH)),$(ARCH))
+
+# ARCH is supported by kernel
+# map from user-input variant to kernel-supported
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
@@ -102,7 +110,7 @@ help:
 	@echo "  run-user     runs the executable under QEMU (uses \$$ARCH, \$$TEST)"
 	@echo "  initramfs    prepare the initramfs with nolibc-test"
 	@echo "  defconfig    create a fresh new default config (uses \$$ARCH)"
-	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$ARCH)"
+	@echo "  kernel       (re)build the kernel with the initramfs (uses $$ARCH)"
 	@echo "  run          runs the kernel in QEMU after building it (uses \$$ARCH, \$$TEST)"
 	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$ARCH, \$$TEST)"
 	@echo "  clean        clean the sysroot, initramfs, build and output files"
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

