Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66EE976BDFA
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232582AbjHATls (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232579AbjHATls (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:41:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D3C1FF3;
        Tue,  1 Aug 2023 12:41:36 -0700 (PDT)
X-QQ-mid: bizesmtp63t1690918887tcphyv4r
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:41:26 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: nMuci6qhceNBRU+sDADE7/JtUrCHaoVrlifjCBDUL/jBJl0rtLP+oHvUfnRqC
        i/gsuROO441HGXQZcSyxvg9IBfxJFwT38fc4uyMi/CVsu2P9+jh7eLJBBuy2sP7lGj1VqmI
        5CBpoaaHzYnPvkYWGwrTm4z7ZiNH9QrByWSGmgedwfHdVvr8pCeHavaYZkDE8tSeM5DAwEY
        X1hC/rz2f/5sGi5i6YHLJ6SWzKTURFFCUUuHomAiYdQv1LPiBRUczYmMnc6H2Y+BZhHUFLc
        0i5jUYAvmZZ2Bn3jkKOxqCXE5GvhXQ5AGrBE2rBJmYOsuipqId1rgNaqa28M0P21hengeK/
        oOc3xhr97IrWEaFRoM+5pFdtlCkDCO97FhtrfcQpzFDzYtFzogDvANJu3Ss3MSkdGKp5CxK
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16416427454383325419
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 05/12] selftests/nolibc: add XARCH and ARCH mapping support
Date:   Wed,  2 Aug 2023 03:41:26 +0800
Message-Id: <67396957cee44f6002d5a0dd74fbaeaa50d7d803.1690916314.git.falcon@tinylab.org>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Most of the CPU architectures have different variants, but kernel
usually only accepts parts of them via the ARCH variable, the others
should be customized via kernel config files.

To simplify testing, a new XARCH variable is added to extend the
kernel's ARCH with a few variants of the same architecture, and it is
used to customize variant specific variables, at last XARCH is converted
to the kernel's ARCH:

  e.g. make run XARCH=<one of the supported variants>
                | \
                |  `-> variant specific variables:
                |      IMAGE, DEFCONFIG, QEMU_ARCH, QEMU_ARGS, CFLAGS ...
                \
                 `---> kernel's ARCH

XARCH and ARCH are carefully mapped to allow users to pass architecture
variants via XARCH or pass architecture via ARCH from cmdline.

PowerPC is the first user and also a very good reference architecture of
this mapping, it has variants with different combinations of
32-bit/64-bit and bit endian/little endian.

To use this mapping, the other architectures can refer to PowerPC, If
the target architecture only has one variant, XARCH is simply an alias
of ARCH, no additional mapping required.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230702171715.GD16233@1wt.eu/
Link: https://lore.kernel.org/lkml/20230730061801.GA7690@1wt.eu/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 46 ++++++++++++++++++-------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index fdc72ca75589..7902b86911a5 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -17,6 +17,27 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# XARCH extends the kernel's ARCH with a few variants of the same
+# architecture that only differ by the configuration, the toolchain
+# and the Qemu program used. It is copied as-is into ARCH except for
+# a few specific values which are mapped like this:
+#
+#  XARCH        | ARCH      | config
+#  -------------|-----------|-------------------------
+#  ppc          | powerpc   | 32 bits
+#  ppc64        | powerpc   | 64 bits big endian
+#  ppc64le      | powerpc   | 64 bits little endian
+#
+# It is recommended to only use XARCH, though it does not harm if
+# ARCH is already set. For simplicity, ARCH is sufficient for all
+# architectures where both are equal.
+
+# configure default variants for target kernel supported architectures
+XARCH            = $(or $(XARCH_$(ARCH)),$(ARCH))
+
+# map from user input variants to their kernel supported architectures
+ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
+
 # kernel image names by architecture
 IMAGE_i386       = arch/x86/boot/bzImage
 IMAGE_x86_64     = arch/x86/boot/bzImage
@@ -27,7 +48,7 @@ IMAGE_mips       = vmlinuz
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
-IMAGE            = $(IMAGE_$(ARCH))
+IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # default kernel configurations that appear to be usable
@@ -40,7 +61,7 @@ DEFCONFIG_mips       = malta_defconfig
 DEFCONFIG_riscv      = defconfig
 DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
-DEFCONFIG            = $(DEFCONFIG_$(ARCH))
+DEFCONFIG            = $(DEFCONFIG_$(XARCH))
 
 # optional tests to run (default = all)
 TEST =
@@ -55,7 +76,7 @@ QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
-QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
+QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
 QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -67,7 +88,7 @@ QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
+QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
@@ -84,7 +105,7 @@ CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
-		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
+		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
@@ -99,24 +120,25 @@ help:
 	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
 	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
 	@echo "  libc-test    build an executable using the compiler's default libc instead"
-	@echo "  run-user     runs the executable under QEMU (uses \$$ARCH, \$$TEST)"
+	@echo "  run-user     runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
 	@echo "  initramfs    prepare the initramfs with nolibc-test"
-	@echo "  defconfig    create a fresh new default config (uses \$$ARCH)"
-	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$ARCH)"
-	@echo "  run          runs the kernel in QEMU after building it (uses \$$ARCH, \$$TEST)"
-	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$ARCH, \$$TEST)"
+	@echo "  defconfig    create a fresh new default config (uses \$$XARCH)"
+	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$XARCH)"
+	@echo "  run          runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
+	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
 	@echo "  clean        clean the sysroot, initramfs, build and output files"
 	@echo ""
 	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
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

