Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0237A361F
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Sep 2023 17:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229594AbjIQPWG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 17 Sep 2023 11:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjIQPVr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 17 Sep 2023 11:21:47 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0468B5;
        Sun, 17 Sep 2023 08:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694964099;
        bh=IIibg1/4WvIjXQyZJl+4IBf/DvAGCXDdcSGNSt2pWjA=;
        h=From:Date:Subject:To:Cc:From;
        b=LlqUgOyEsBqAZqjJivPFcSsQLVsFgWx5g0J7ezOBTL/g0AJZYqIhsArLRKAkEKYwa
         2DCtFNjYNDQQTkXxJ6gKzi+WDjtKJx4OXgMHeNOWpvuI7lx441MwIrivlZjiVXYxMH
         gkxxH3KX0nTexxX7Po80lIjCgsDBLSB98egltGts=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 17 Sep 2023 17:21:38 +0200
Subject: [PATCH RFC v2] selftests/nolibc: don't embed initramfs into kernel
 image
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230917-nolibc-initramfs-v2-1-f0f293a8b198@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAIEZB2UC/3WNwQrCMBBEf6Xs2UiSxoCehIIf4FV6iMnWLGgq2
 ViV0n839O7xzTBvZmDMhAyHZoaMEzGNqYLeNOCjSzcUFCqDlrqVe2VFGu909YISleweAwszBCn
 R+VbvLNTZM+NAn1V5gfOpg76GkbiM+bveTGqt/hsnJaQwRln0GLyz4fhGYmYfX3GbsEC/LMsPb
 8YCkLoAAAA=
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Willy Tarreau <w@1wt.eu>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694964099; l=5921;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=IIibg1/4WvIjXQyZJl+4IBf/DvAGCXDdcSGNSt2pWjA=;
 b=TMywZlcbRfqxkouH8taMqHBh3L3qIqomdcFFYO6Sgvb1gIcjNkUTBZBzTsZX2PgpnQIyVEeek
 RpFYtG0ll4MB5N+H1KBQwsBkanZ7UaY2LH6RT6Wp84CFmzlJLUWQu9r
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
Currently the nolibc testsuite embeds the test executable into a kernel
image with CONFIG_INITRAMFS_SOURCE.
This forces a full kernel relink everytime the test executable is
updated.

This relinking step dominates the test cycle.
It is slower than building and running the test in qemu together.

With a bit of Makefile-shuffling the relinking can be avoided.
---
Changes in v2:
- avoid need to modify top-level Makefile
- drop patch removing "rerun" target
- add kernel-standalone target
- Link to v1: https://lore.kernel.org/r/20230916-nolibc-initramfs-v1-0-4416ecedca6d@weissschuh.net
---
 tools/testing/selftests/nolibc/Makefile | 42 ++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 689658f81a19..ee6a9ad28cfd 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -131,18 +131,20 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++
 
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
+	@echo "  all               call the \"run\" target below"
+	@echo "  help              this help"
+	@echo "  sysroot           create the nolibc sysroot here (uses \$$ARCH)"
+	@echo "  nolibc-test       build the executable (uses \$$CC and \$$CROSS_COMPILE)"
+	@echo "  libc-test         build an executable using the compiler's default libc instead"
+	@echo "  run-user          runs the executable under QEMU (uses \$$XARCH, \$$TEST)"
+	@echo "  initramfs.cpio    prepare the initramfs archive with nolibc-test"
+	@echo "  initramfs         prepare the initramfs tree with nolibc-test"
+	@echo "  defconfig         create a fresh new default config (uses \$$XARCH)"
+	@echo "  kernel            (re)build the kernel (uses \$$XARCH)"
+	@echo "  kernel-standalone (re)build the kernel with the initramfs (uses \$$XARCH)"
+	@echo "  run               runs the kernel in QEMU after building it (uses \$$XARCH, \$$TEST)"
+	@echo "  rerun             runs a previously prebuilt kernel in QEMU (uses \$$XARCH, \$$TEST)"
+	@echo "  clean             clean the sysroot, initramfs, build and output files"
 	@echo ""
 	@echo "The output file is \"run.out\". Test ranges may be passed using \$$TEST."
 	@echo ""
@@ -195,6 +197,9 @@ run-user: nolibc-test
 	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+initramfs.cpio: kernel nolibc-test
+	$(QUIET_GEN)echo 'file /init nolibc-test 755 0 0' | $(srctree)/usr/gen_init_cpio - > initramfs.cpio
+
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
 	$(call QUIET_INSTALL, initramfs/init)
@@ -203,17 +208,20 @@ initramfs: nolibc-test
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
-kernel: initramfs
+kernel:
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)
+
+kernel-standalone: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # run the tests after building the kernel
-run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+run: kernel initramfs.cpio
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -initrd initramfs.cpio -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # report with existing test log
@@ -227,6 +235,8 @@ clean:
 	$(Q)rm -f nolibc-test
 	$(call QUIET_CLEAN, libc-test)
 	$(Q)rm -f libc-test
+	$(call QUIET_CLEAN, initramfs.cpio)
+	$(Q)rm -rf initramfs.cpio
 	$(call QUIET_CLEAN, initramfs)
 	$(Q)rm -rf initramfs
 	$(call QUIET_CLEAN, run.out)

---
base-commit: 3f79a57865b33f49fdae6655510bd27c8e6610e0
change-id: 20230916-nolibc-initramfs-4fd00eac3256

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

