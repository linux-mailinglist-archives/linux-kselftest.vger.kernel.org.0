Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10C37BFB8B
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Oct 2023 14:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbjJJMeV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Oct 2023 08:34:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjJJMeR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Oct 2023 08:34:17 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A8C11B;
        Tue, 10 Oct 2023 05:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1696941245;
        bh=WxAUHJdppCeTHqWPxWpmIL5UmHFcwDBRqVdmTVlGl0U=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=VEUfNKVPa1jAF4dH/OyzXoKzbUul33LreA4uDaGopOnVixMFIEsnEKf8w1zTyA67o
         /BVTpB6u1/jw6W6yJ1YCcXJ4B1sCMEI9PZSMbCTZ3PHO2mRm97tRQKb9dpdpq4Ytw5
         K6BpTXC/OwCtATJeHVQqXe0Za+nn2ObdUIEJ/VOM=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 10 Oct 2023 14:33:59 +0200
Subject: [PATCH 4/5] selftests/nolibc: support out-of-tree builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231010-nolibc-out-of-tree-v1-4-b6a263859596@weissschuh.net>
References: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
In-Reply-To: <20231010-nolibc-out-of-tree-v1-0-b6a263859596@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1696941244; l=3951;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=WxAUHJdppCeTHqWPxWpmIL5UmHFcwDBRqVdmTVlGl0U=;
 b=/UOEch0A9EzSGr6yYRgdHzLhXIl9y7lRmAKNd1nuNPkIzI2sd3nn09koPBt6Crej7vYWswndr
 lGWQRved7EQCJ2CVmPRuAkpL/QjE2k/JMU3S/GKy7DF/1OGERqN19YQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Out of tree builds are much more convenient when building for multiple
architectures or configurations in parallel.

Only absolute O= parameters are supported as Makefile.include will
always resolve relative paths in relation to $(srctree) instead of the
current directory.

Add a call to "make outputmakefile" to verify that the sourcetree is
clean.

This is based on Zhangjins out-of-tree patch.
It extends that work for get_init_cpio support and also drops relative
O= specifications explicitly.

Link: https://lore.kernel.org/lkml/06d96bd81fe812a9718098a383678ad3beba98b1.1691215074.git.falcon@tinylab.org/
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 598d53c5cb7b..21e3f7da2ecf 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -1,9 +1,16 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for nolibc tests
 include ../../../scripts/Makefile.include
+include ../../../scripts/utilities.mak
 # We need this for the "cc-option" macro.
 include ../../../build/Build.include
 
+ifneq ($(O),)
+ifneq ($(call is-absolute,$(O)),y)
+$(error Only absolute O= parameters are supported)
+endif
+endif
+
 # we're in ".../tools/testing/selftests/nolibc"
 ifeq ($(srctree),)
 srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
@@ -14,6 +21,8 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+objtree ?= $(srctree)
+
 # XARCH extends the kernel's ARCH with a few variants of the same
 # architecture that only differ by the configuration, the toolchain
 # and the Qemu program used. It is copied as-is into ARCH except for
@@ -52,7 +61,7 @@ IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
-IMAGE            = $(IMAGE_$(XARCH))
+IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # default kernel configurations that appear to be usable
@@ -167,6 +176,7 @@ sysroot: sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
+	$(Q)$(MAKE) -C $(srctree) outputmakefile
 	$(Q)$(MAKE) -C $(srctree)/tools/include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
@@ -199,7 +209,7 @@ run-user: nolibc-test
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 initramfs.cpio: kernel nolibc-test
-	$(QUIET_GEN)echo 'file /init nolibc-test 755 0 0' | $(srctree)/usr/gen_init_cpio - > initramfs.cpio
+	$(QUIET_GEN)echo 'file /init nolibc-test 755 0 0' | $(objtree)/usr/gen_init_cpio - > initramfs.cpio
 
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
@@ -217,12 +227,12 @@ kernel-standalone: initramfs
 
 # run the tests after building the kernel
 run: kernel initramfs.cpio
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # report with existing test log

-- 
2.42.0

