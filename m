Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E722A7A2E4F
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Sep 2023 09:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbjIPHNy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Sep 2023 03:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjIPHNx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Sep 2023 03:13:53 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 733BE1BC1;
        Sat, 16 Sep 2023 00:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694848422;
        bh=oT2kEBwaKoAUkh23wcKkuHSU9d9+GU/5x2kZCPlHweE=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=pRYZHs+qpYrm9CcQ5FkPCvwNcw3FXdvsFGAw9uemY81Sgn3gRFE+uJjuGC9wwp4L4
         Wozq1/skugTsnBZUUaqFSn+kZJabFOJr7FT47hReAgP4oZ9S36ePafUac13zYnSRgV
         En1iK0HuJ68yXar6v7LeQsjD1Yl/8WQpAmzzT3fU=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sat, 16 Sep 2023 09:13:28 +0200
Subject: [PATCH RFC 2/3] selftests/nolibc: don't embed initramfs into
 kernel image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230916-nolibc-initramfs-v1-2-4416ecedca6d@weissschuh.net>
References: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
In-Reply-To: <20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694848421; l=5060;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=oT2kEBwaKoAUkh23wcKkuHSU9d9+GU/5x2kZCPlHweE=;
 b=0cIkidM3/ODX5NsYC7xYaNIapE4GXcLskp6UvWs2gvVArc+XdkjfHgdwZVnB53PbOezmmMmFK
 soCuDFi/PiXAofxD7BouOWI7DpvEzFrYllaf47o57cAnLjWxd9gCEAM
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

When the initramfs is embedded into the kernel each rebuild of it will
trigger a full kernel relink and all the expensive postprocessing steps.

Currently nolibc-test and therefore the initramfs are always rebuild,
even without source changes, leading to lots of slow kernel relinks.

Instead of linking the initramfs into the kernel assemble it manually
and pass it explicitly to qemu.
This avoids all of the kernel relinks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile | 47 +++++++++++++++++----------------
 1 file changed, 24 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 689658f81a19..c62efc62a060 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -131,18 +131,18 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++
 
 help:
 	@echo "Supported targets under selftests/nolibc:"
-	@echo "  all          call the \"run\" target below"
-	@echo "  help         this help"
-	@echo "  sysroot      create the nolibc sysroot here (uses \$$ARCH)"
-	@echo "  nolibc-test  build the executable (uses \$$CC and \$$CROSS_COMPILE)"
-	@echo "  libc-test    build an executable using the compiler's default libc instead"
-	@echo "  run-user     runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
-	@echo "  initramfs    prepare the initramfs with nolibc-test"
-	@echo "  defconfig    create a fresh new default config (uses \$$XARCH)"
-	@echo "  kernel       (re)build the kernel with the initramfs (uses \$$XARCH)"
-	@echo "  run          runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
-	@echo "  rerun        runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
-	@echo "  clean        clean the sysroot, initramfs, build and output files"
+	@echo "  all             call the \"run\" target below"
+	@echo "  help            this help"
+	@echo "  sysroot         create the nolibc sysroot here (uses \$$ARCH)"
+	@echo "  nolibc-test     build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  libc-test       build an executable using the compiler's default libc instead"
+	@echo "  run-user        runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
+	@echo "  initramfs.cpio  prepare the initramfs with nolibc-test"
+	@echo "  defconfig       create a fresh new default config (uses \$$XARCH)"
+	@echo "  kernel          (re)build the kernel with the initramfs (uses \$$XARCH)"
+	@echo "  run             runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
+	@echo "  rerun           runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
+	@echo "  clean           clean the sysroot, initramfs, build and output files"
 	@echo ""
 	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
 	@echo ""
@@ -195,25 +195,26 @@ run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
-initramfs: nolibc-test
-	$(QUIET_MKDIR)mkdir -p initramfs
-	$(call QUIET_INSTALL, initramfs/init)
-	$(Q)cp nolibc-test initramfs/init
+$(srctree)/usr/gen_init_cpio:
+	$(Q)$(MAKE) -C $(srctree) usr_gen_init_cpio
+
+initramfs.cpio: $(srctree)/usr/gen_init_cpio nolibc-test
+	$(QUIET_GEN)echo 'file /init nolibc-test 755 0 0' | $(srctree)/usr/gen_init_cpio - > initramfs.cpio
 
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
-kernel: initramfs
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+kernel:
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)
 
 # run the tests after building the kernel
-run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+run: kernel initramfs.cpio
+	qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # report with existing test log
@@ -227,8 +228,8 @@ clean:
 	$(Q)rm -f nolibc-test
 	$(call QUIET_CLEAN, libc-test)
 	$(Q)rm -f libc-test
-	$(call QUIET_CLEAN, initramfs)
-	$(Q)rm -rf initramfs
+	$(call QUIET_CLEAN, initramfs.cpio)
+	$(Q)rm -rf initramfs.cpio
 	$(call QUIET_CLEAN, run.out)
 	$(Q)rm -rf run.out
 

-- 
2.42.0

