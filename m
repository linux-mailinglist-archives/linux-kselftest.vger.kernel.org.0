Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF306765D30
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjG0UYW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjG0UYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:24:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA473AA9;
        Thu, 27 Jul 2023 13:24:01 -0700 (PDT)
X-QQ-mid: bizesmtp89t1690489430taupjqmr
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:23:49 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 7YFKcddXagjClmzXEeTqsqBAti0I7zGcNw3o74NJMlrB+NIXdu4Mxu64pWeI9
        GijqOI4AwCKaIHI/71zr/Ho8fvrwScEzDbge6LU/OzZVI8OcxxnXpE5/C7HW6mgyrxWjGNO
        w1Xc/7vadlLRWh2EbZ0ka+sr5L8ZEwX55NLKhW+bY31wiI9scpTopIQKJqCmPFjoSFkukjr
        l6LBxQwXlEOFL36ga555U6uaXkPq15LVx8sYhIPctX5dgTWtDCwJoeut+40i9e8ufwdJ4gT
        ZyuJF/u28VGFLMo+cKSoC/+kKerNQKF7vNPXdTX+1djVsLZqQDGYjkxAFUxHkVcIRQzhor3
        KSTH0IHJMUn9ztJ3QB32ky7Ud4fZIW9voWqvJocuRGvKnn1RZLBJLNtxmpKyAdsQofJuila
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1357808437858265146
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 02/12] selftests/nolibc: add macros to reduce duplicated changes
Date:   Fri, 28 Jul 2023 04:23:49 +0800
Message-Id: <7d033dcf0bc499de1269af8b436133733a1710f1.1690489039.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690489039.git.falcon@tinylab.org>
References: <cover.1690489039.git.falcon@tinylab.org>
MIME-Version: 1.0
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

The kernel targets share the same kernel make operations, the same
.config file, the same kernel image, add MAKE_KERNEL, KERNEL_CONFIG and
KERNEL_IMAGE for them.

Many targets use the same log file, add RUN_OUT to allow save log by
architecture, for example: 'make RUN_OUT=$PWD/run.$arch.out'.

The qemu run/rerun targets share the same qemu system run command, add
QEMU_SYSTEM_RUN for them.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230722122009.GE17311@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 41 ++++++++++++++++---------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 75419b695f0d..bfea1ea0b4e7 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -169,47 +169,58 @@ endif
 libc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) -o $@ $<
 
+# common macros for logging
+RUN_OUT = $(CURDIR)/run.out
+
 # local libc-test
 run-libc-test: libc-test
-	$(Q)./libc-test > "$(CURDIR)/run.out" || :
-	$(Q)$(REPORT) $(CURDIR)/run.out
+	$(Q)./libc-test > "$(RUN_OUT)" || :
+	$(Q)$(REPORT) "$(RUN_OUT)"
 
 # local nolibc-test
 run-nolibc-test: nolibc-test
-	$(Q)./nolibc-test > "$(CURDIR)/run.out" || :
-	$(Q)$(REPORT) $(CURDIR)/run.out
+	$(Q)./nolibc-test > "$(RUN_OUT)" || :
+	$(Q)$(REPORT) "$(RUN_OUT)"
 
 # qemu user-land test
 run-user: nolibc-test
-	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(CURDIR)/run.out" || :
-	$(Q)$(REPORT) $(CURDIR)/run.out
+	$(Q)qemu-$(QEMU_ARCH) ./nolibc-test > "$(RUN_OUT)" || :
+	$(Q)$(REPORT) "$(RUN_OUT)"
 
 initramfs: nolibc-test
 	$(QUIET_MKDIR)mkdir -p initramfs
 	$(call QUIET_INSTALL, initramfs/init)
 	$(Q)cp nolibc-test initramfs/init
 
+# common macros for kernel targets
+MAKE_KERNEL   = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
+KERNEL_CONFIG = $(srctree)/.config
+KERNEL_IMAGE  = $(srctree)/$(IMAGE)
+
 defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
-	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
+	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
+	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
+	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
 
 kernel: initramfs
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+	$(Q)$(MAKE_KERNEL) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+
+# common macros for qemu run/rerun targets
+QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
 
 # run the tests after building the kernel
 run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)$(REPORT) $(CURDIR)/run.out
+	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
+	$(Q)$(REPORT) "$(RUN_OUT)"
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)$(REPORT) $(CURDIR)/run.out
+	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
+	$(Q)$(REPORT) "$(RUN_OUT)"
 
 # report with existing test log
 report:
-	$(Q)$(REPORT_RUN_OUT)
+	$(Q)$(REPORT) "$(RUN_OUT)"
 
 clean:
 	$(call QUIET_CLEAN, sysroot)
-- 
2.25.1

