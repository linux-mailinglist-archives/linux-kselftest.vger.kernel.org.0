Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2FC7596A7
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjGSN0P (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSN0P (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:26:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD116113;
        Wed, 19 Jul 2023 06:26:13 -0700 (PDT)
X-QQ-mid: bizesmtp81t1689773163tzuoiaar
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:26:02 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: Fc2LLDWeHZ8VdczlC7KmDhEPzY0whHqO82tCkg/2DH+O58nfZufXy/1LZ57Ez
        bYwAChOjliqF3DXvAK8o2kR9iCuiP+OI0g9sAaZVoeK3YF2xhwnh5ghx7bXdO8H43l/aM3m
        Bru5MzOnEkD7RbQTnvdurcqkRtaa0Ti/iZoRfkPriK1EHO3Ws1mqhylOyC1YXaWKwUc7CbF
        AqTAxciM24nJjSL+4lOojxVZ5azHBlT3XfogfmGMiSeZhrlYM5F1QSL0avzOy45ESALMgbH
        yeeImRshlL/b1C1wMCnqkpzfeH3oBhycjOtLHYZgbErbI2rr39HsTvCs2w/7cEVyA1gC7ko
        D0B/9RqqtA3ECHFY4D4VV5Dt3EgxY3S+JaGfbjxD3iy1CqjTtqVWUT3pKcTuLrvoGRNE4b2
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17285314132285918324
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 08/14] selftests/nolibc: string the core targets
Date:   Wed, 19 Jul 2023 21:26:01 +0800
Message-Id: <4d6023634c5d97694e75b460b39c25e44642c4d3.1689759351.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689759351.git.falcon@tinylab.org>
References: <cover.1689759351.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

To avoid run targets one by one manually and boringly, let's string them
with IMAGE and .config, the MAKE command will trigger the dependencies
for us.

Note, to allow do menuconfig before extconfig manually, only trigger
defconfig while the .config is not there, it means only trigger
defconfig for the first run or after a mrproper.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 83cb4b017bef..541f3565e584 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -150,6 +150,7 @@ all: run
 
 sysroot: sysroot/$(ARCH)/include
 
+PHONY = sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
@@ -205,21 +206,28 @@ mrproper:
 defconfig:
 	$(Q)$(MAKE_KERNEL) $(DEFCONFIG) prepare
 
-menuconfig:
+PHONY += $(KERNEL_CONFIG)
+$(KERNEL_CONFIG):
+	$(Q)if [ ! -f "$(KERNEL_CONFIG)" ]; then $(MAKE) --no-print-directory defconfig; fi
+
+menuconfig: $(KERNEL_CONFIG)
 	$(Q)$(MAKE_KERNEL) menuconfig
 
-extconfig:
+extconfig: $(KERNEL_CONFIG)
 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
 	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
 
-kernel: initramfs
+kernel: extconfig
+	$(Q)$(MAKE) --no-print-directory initramfs
 	$(Q)$(MAKE_KERNEL) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # common macros for qemu run/rerun targets
 QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
 
 # run the tests after building the kernel
-run: kernel
+PHONY += $(KERNEL_IMAGE)
+$(KERNEL_IMAGE): kernel
+run: $(KERNEL_IMAGE)
 	$(Q)$(QEMU_SYSTEM_RUN) $(LOG_OUT)
 	$(Q)$(REPORT_RUN_OUT)
 
@@ -244,4 +252,4 @@ clean:
 	$(call QUIET_CLEAN, run.out)
 	$(Q)rm -rf run.out
 
-.PHONY: sysroot/$(ARCH)/include
+.PHONY: $(PHONY)
-- 
2.25.1

