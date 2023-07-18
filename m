Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EE67586AD
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjGRVP1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGRVP0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:15:26 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8121EC0;
        Tue, 18 Jul 2023 14:15:24 -0700 (PDT)
X-QQ-mid: bizesmtp91t1689714915t194m5qj
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 05:15:13 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: lO87fmWkX3FnwSGm+p0pup/4ktDW2xqng3XU6uxahpZJpMrHSZkTO/ZQMQKyN
        UPuxfSq2bT+YWZH8/JoUGxD+9G4acuQLNRp+qxc//cgvPEs5ciLw66XWiRK6yOZO6GK+pdC
        VqNLE6cAOhHSErPFNvNUtD8uSfxg5uNMNKGRb04urZdjpxUUlDI29ZJLnhZVDBM5IkBkPWt
        +l7wWNU3VvOqy8p7rVML4Z9szsWyS3l+Q+p1RflMALejBKs/W5+/i245VHuVLToacNizW7U
        OOtveNPOw3Gs2p8xqw6UM1mgxuYPsoWt9ewH6BzFJdYm4IsXviKAfbpEUPXGalUxPpebOlI
        C4uyKdE7KancNwnMomkEL3dSAbDJjgSTgB/WASQ8BOJwBj9PIREimeXPGB7cw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5940336848902200637
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 5/8] selftests/nolibc: add XARCH and ARCH mapping support
Date:   Wed, 19 Jul 2023 05:15:13 +0800
Message-Id: <90c1d88dabf73e100dc840965fbdfe3ad5dc550f.1689713175.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689713175.git.falcon@tinylab.org>
References: <cover.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To test the architectures not directly supported by kernel, let's add a
new XARCH as our own test input and map between XARCH and ARCH to make
sure pass a right ARCH to kernel for a XARCH input and also configure a
default XARCH for ARCH.

ARCH is a subset of XARCH, to test more architectures than the ARCH
variable directly supported by kernel, the old architecture specific
variables used by our test are converted to use XARCH instead of ARCH.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230702171715.GD16233@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 34 +++++++++++++++----------
 1 file changed, 21 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 08a5ca5f418b..b17a82efe6de 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -14,6 +14,13 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# XARCH and ARCH mapping
+# XARCH is specified by user
+XARCH           ?= $(or $(XARCH_$(ARCH)),$(ARCH))
+
+# ARCH is supported by kernel
+ARCH            := $(or $(ARCH_$(XARCH)),$(XARCH))
+
 # kernel image names by architecture
 IMAGE_i386       = arch/x86/boot/bzImage
 IMAGE_x86_64     = arch/x86/boot/bzImage
@@ -24,7 +31,7 @@ IMAGE_mips       = vmlinuz
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
-IMAGE            = $(IMAGE_$(ARCH))
+IMAGE            = $(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # default kernel configurations that appear to be usable
@@ -37,10 +44,10 @@ DEFCONFIG_mips       = malta_defconfig
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
@@ -55,7 +62,7 @@ QEMU_ARCH_mips       = mipsel  # works with malta_defconfig
 QEMU_ARCH_riscv      = riscv64
 QEMU_ARCH_s390       = s390x
 QEMU_ARCH_loongarch  = loongarch64
-QEMU_ARCH            = $(QEMU_ARCH_$(ARCH))
+QEMU_ARCH            = $(QEMU_ARCH_$(XARCH))
 
 # QEMU_ARGS : some arch-specific args to pass to qemu
 QEMU_ARGS_i386       = -M pc -append "console=ttyS0,9600 i8042.noaux panic=-1 $(TEST:%=NOLIBC_TEST=%)"
@@ -67,7 +74,7 @@ QEMU_ARGS_mips       = -M malta -append "panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_riscv      = -M virt -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_s390       = -M s390-ccw-virtio -m 1G -append "console=ttyS0 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
 QEMU_ARGS_loongarch  = -M virt -append "console=ttyS0,115200 panic=-1 $(TEST:%=NOLIBC_TEST=%)"
-QEMU_ARGS            = $(QEMU_ARGS_$(ARCH)) $(QEMU_ARGS_EXTRA)
+QEMU_ARGS            = $(QEMU_ARGS_$(XARCH)) $(QEMU_ARGS_EXTRA)
 
 # OUTPUT is only set when run from the main makefile, otherwise
 # it defaults to this nolibc directory.
@@ -84,7 +91,7 @@ CFLAGS_mips = -EL
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(call cc-option,-fno-stack-protector) \
-		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
+		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
@@ -99,24 +106,25 @@ help:
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

