Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3790B76BDF0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Aug 2023 21:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjHATkf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Aug 2023 15:40:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjHATke (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Aug 2023 15:40:34 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D2019AA;
        Tue,  1 Aug 2023 12:40:32 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690918822txdprirx
Received: from linux-lab-host.localdomain ( [116.30.131.233])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 03:40:21 +0800 (CST)
X-QQ-SSF: 01200000002000E0X000B00A0000000
X-QQ-FEAT: mkz8qCx1xSPVZcKO2fmc3LAHwgMtTWIuFhUvM0Ah3H0V9yzy3C6jPnbyi3oG7
        IaHjirJSaeNisKe1ZE6dMGqfaMDQV8lzetKG3trVM8FLpFopf/5FDgkS4JXY7BmF5w8HwXF
        GszTzjCqu4gCZQa9Kf+Qcp7cRHuIwsdMaU25M2pmyvgLcIicoteXreZSstJoenuuasVWYkU
        7I293AlhT7b2DKX1yMn4k9QQ+tVTnAjuTmSefIG+JHqVC5uYBa4jW6Msa8eDMaepTqrsVJR
        cL9TSwIAGW2UJqusan/rRc3o7Ic8JDAdnEHCPrCaW71WrjxCPM5tESHoIwiAfTp0AXmD2lY
        clOwjDAeftJFT33LBpJZLW7k5rg5K9NrXSYRLLbZc5/mnzr23yBLQLp86lAp7JwOq7jV33C
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10879325403677757569
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, w@1wt.eu
Subject: [PATCH v4 04/12] selftests/nolibc: add macros to reduce duplicated changes
Date:   Wed,  2 Aug 2023 03:40:21 +0800
Message-Id: <d18c46b935f2c7d56a8857b387067cb3fec11d05.1690916314.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690916314.git.falcon@tinylab.org>
References: <cover.1690916314.git.falcon@tinylab.org>
MIME-Version: 1.0
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
 tools/testing/selftests/nolibc/Makefile | 35 ++++++++++++++++---------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f0bda0d28000..fdc72ca75589 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -142,41 +142,52 @@ endif
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
+KERNEL_CONFIG = $(objtree)/.config
+KERNEL_IMAGE  = $(objtree)/$(IMAGE)
+
 defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
 
 kernel: initramfs
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+	$(Q)$(MAKE_KERNEL) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+
+# common macros for qemu run/rerun targets
+QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
 
 # run the tests after building the kernel
 run: kernel
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)$(REPORT) $(CURDIR)/run.out
+	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
+	$(Q)$(REPORT) "$(RUN_OUT)"
 
 # re-run the tests from an existing kernel
 rerun:
-	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(objtree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) > "$(CURDIR)/run.out"
-	$(Q)$(REPORT) $(CURDIR)/run.out
+	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
+	$(Q)$(REPORT) "$(RUN_OUT)"
 
 clean:
 	$(call QUIET_CLEAN, sysroot)
-- 
2.25.1

