Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFAB57DD720
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Oct 2023 21:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbjJaUhH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Oct 2023 16:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjJaUhG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Oct 2023 16:37:06 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62480F9;
        Tue, 31 Oct 2023 13:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1698784621;
        bh=LNx+nj4jlE223VhzZ9GFi7fWQ5Fyb/XHvEpIBKCFyVM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=GHEQO9ebq4PLKKuavypuPdsKYAWA8jQ3FdQE572za9KmzKD/5aHkznU/oKFr+nvAA
         wHIZQ55uC4ZX8MAZWYAoXOUGqp2p4dNd2h5pWZ59WxUauUdl21qw5+f1Lm0V0nK8o+
         unVBlzuKOc3qS32OuEc0ZTDD7jTZN0/RzvBRgrmk=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Tue, 31 Oct 2023 21:37:00 +0100
Subject: [PATCH 3/3] selftests/nolibc: support out-of-tree builds
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231031-nolibc-out-of-tree-v1-3-47c92f73590a@weissschuh.net>
References: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
In-Reply-To: <20231031-nolibc-out-of-tree-v1-0-47c92f73590a@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698784620; l=4087;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=LNx+nj4jlE223VhzZ9GFi7fWQ5Fyb/XHvEpIBKCFyVM=;
 b=TyJDLtPEizhFex+t38T4ccb988q2/Hc4CqgbIfibOz8zcilrEO/oxpLY4PuAYAfPLiZ9Q5QzK
 /633oAtcuJ/AQUmBFWa6JJqhBE+U6Fxh8nQtdlKHFMuYgBkK4ZOqrdX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
Co-developed-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index b1129be98376..c5df1617cbc3 100644
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
@@ -174,6 +183,7 @@ sysroot: sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
+	$(Q)$(MAKE) -C $(srctree) outputmakefile
 	$(Q)$(MAKE) -C $(srctree)/tools/include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
@@ -206,7 +216,7 @@ run-user: nolibc-test
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 initramfs.cpio: kernel nolibc-test
-	$(QUIET_GEN)echo 'file /init nolibc-test 755 0 0' | $(srctree)/usr/gen_init_cpio - > initramfs.cpio
+	$(QUIET_GEN)echo 'file /init nolibc-test 755 0 0' | $(objtree)/usr/gen_init_cpio - > initramfs.cpio
 
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
@@ -224,12 +234,12 @@ kernel-standalone: initramfs
 
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

