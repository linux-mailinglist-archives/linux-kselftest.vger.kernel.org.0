Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FC1765D67
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjG0UcQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbjG0UcK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:32:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B7930F5;
        Thu, 27 Jul 2023 13:32:00 -0700 (PDT)
X-QQ-mid: bizesmtp65t1690489565tg42khc4
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:26:04 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: SO65WgIymiHJ7FcToC7kLxdI0mhJp0wkOEo+Sirw0umysYn9kh0wsqMc5pGqj
        kO1TSVq8llQr9cwcIYvv7VfJgl3PSzINEZkitkWxZFiiueP0GsxyyrOCe3tOx7Gnu8k7B4d
        3dc/Ur36CeAh0rcHzK0EWcasxUczJP8IlemGAFgUj0CUnX7V0JrPeJwZlxg0cZYfJA0xnL8
        i2r01JxV/uZh/dfEvSg9ODOD716/+Vu5vvDay73TO1PXlevJDttZYOzabewiCuZL0R3Ng+/
        wMpZqSlgytjC21/r9RukLL8G8gdKvCzVzVSra6JhSHt4cAMhM4i1NoBsJ7CHzAxollzipHv
        2GOnQ6uWxXlivYeq8+5I+StbFQFwasQphaGSkBgMd3K+FoVk9C9hGX4X3DcQi3LF6jrK4yV
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17663128529755387531
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 04/12] selftests/nolibc: string the core targets
Date:   Fri, 28 Jul 2023 04:26:03 +0800
Message-Id: <9b52e26748eda1ac108d569207bf428bf37b3bbc.1690489039.git.falcon@tinylab.org>
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

To avoid run targets one by one manually and boringly, let's string them
with IMAGE and .config, the MAKE command will trigger the dependencies
for us.

Note, defconfig target is only triggered while the .config is not there,
it means only trigger defconfig for the first run or after a mrproper.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230725142017.37103-1-falcon@tinylab.org/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f5680b9ed85c..3a61fa7e42a0 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -153,6 +153,7 @@ all: run
 
 sysroot: sysroot/$(ARCH)/include
 
+PHONY = sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
@@ -205,14 +206,21 @@ defconfig:
 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
 	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
 
-kernel: initramfs
+PHONY += $(KERNEL_CONFIG)
+$(KERNEL_CONFIG):
+	$(Q)if [ ! -f "$(KERNEL_CONFIG)" ]; then $(MAKE) --no-print-directory defconfig; fi
+
+kernel: $(KERNEL_CONFIG)
+	$(Q)$(MAKE) --no-print-directory initramfs
 	$(Q)$(MAKE_KERNEL) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # common macros for qemu run/rerun targets
 QEMU_SYSTEM_RUN = qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(KERNEL_IMAGE)" -serial stdio $(QEMU_ARGS)
 
 # run the tests after building the kernel
-run: kernel
+PHONY += $(KERNEL_IMAGE)
+$(KERNEL_IMAGE): kernel
+run: $(KERNEL_IMAGE)
 	$(Q)$(QEMU_SYSTEM_RUN) > "$(RUN_OUT)"
 	$(Q)$(REPORT) "$(RUN_OUT)"
 
@@ -237,4 +245,4 @@ clean:
 	$(call QUIET_CLEAN, run.out)
 	$(Q)rm -rf run.out
 
-.PHONY: sysroot/$(ARCH)/include
+.PHONY: $(PHONY)
-- 
2.25.1

