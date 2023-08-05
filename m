Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6BC2770E09
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Aug 2023 08:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjHEGNZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 5 Aug 2023 02:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjHEGNY (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 5 Aug 2023 02:13:24 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288B64ED0;
        Fri,  4 Aug 2023 23:13:22 -0700 (PDT)
X-QQ-mid: bizesmtp71t1691215993ty0dxrkb
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 05 Aug 2023 14:13:12 +0800 (CST)
X-QQ-SSF: 01200000000000E0X000000A0000000
X-QQ-FEAT: VudjVnMJxE6y0HQdOAnIPW2Xm5and1bBaT6pX9ZCs1jzBV+VotcyCU7xHF8c2
        FJ8c1IS734nq3CP1BRwRLg4LfZfUimvLvF/xBDGhTUxe4pd1bybAdcSavoW54CMSSrHpsB2
        mANBiu2rVvVdMcY7IJfVl5cYBAoG8Gq6cpaAnTWvk0cnl9r4JKMabJrlzxI/WvlLkuUr9Hs
        6aM7b/2PH9u/TWGLbkDATDLliZpiME9l9NAccP4y+wcqoMokBowHc7k4HqwryQJ4Gg5ik6t
        ay4C4v5/10U4XvHXebFaLKXL3Vyf5F7Jryf18X3+YtN6z+6mgbkmJznf//wgfner21xQVko
        iKOYjLmMArC5jIDUZp0t3h5fekE5sH+9UqD6m2t6QmLjrpo3Ml8w+rF9JlPTcb6kqgFxxlt
        KaQ2z2e4dmM=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9091032993655144416
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 3/3] selftests/nolibc: fix up O= option support
Date:   Sat,  5 Aug 2023 14:13:11 +0800
Message-Id: <06d96bd81fe812a9718098a383678ad3beba98b1.1691215074.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1691215074.git.falcon@tinylab.org>
References: <cover.1691215074.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid pollute the source code tree and avoid mrproper for every
architecture switch, the O= argument must be supported.

Both IMAGE and .config are from the building directory, let's use
objtree instead of srctree for them.

If no O= option specified, means building kernel in source code tree,
objtree should be srctree in such case.

To support relative path, as suggested by Thomas, $(COMMAND_O) is used
to pass the O=$(ABSOLUTE_O) to the $(MAKE) commands.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/058a264d-45bd-4f1f-8af3-56ed337b3251@t-8ch.de/
Link: https://lore.kernel.org/lkml/500504f6-fed1-45a4-a518-4631a6f3e463@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 51fef5e6a152..20797ba5d393 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -9,6 +9,9 @@ ifeq ($(srctree),)
 srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
+# add objtree for O= option, required by IMAGE and .config
+objtree ?= $(srctree)
+
 ifeq ($(ARCH),)
 include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
@@ -52,7 +55,7 @@ IMAGE_ppc64le    = arch/powerpc/boot/zImage
 IMAGE_riscv      = arch/riscv/boot/Image
 IMAGE_s390       = arch/s390/boot/bzImage
 IMAGE_loongarch  = arch/loongarch/boot/vmlinuz.efi
-IMAGE            = $(IMAGE_$(XARCH))
+IMAGE            = $(objtree)/$(IMAGE_$(XARCH))
 IMAGE_NAME       = $(notdir $(IMAGE))
 
 # CROSS_COMPILE: cross toolchain prefix by architecture
@@ -173,7 +176,7 @@ sysroot: sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
-	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
+	$(Q)$(MAKE) -C ../../../include/nolibc $(COMMAND_O) ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
 ifneq ($(NOLIBC_SYSROOT),0)
@@ -210,19 +213,19 @@ initramfs: nolibc-test
 	$(Q)cp nolibc-test initramfs/init
 
 defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+	$(Q)$(MAKE) -C $(srctree) $(COMMAND_O) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
 kernel: initramfs
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+	$(Q)$(MAKE) -C $(srctree) $(COMMAND_O) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # run the tests after building the kernel
 run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
+	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
 # report with existing test log
-- 
2.25.1

