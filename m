Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2F07586AA
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jul 2023 23:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjGRVOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Jul 2023 17:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjGRVOV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Jul 2023 17:14:21 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4A6C0;
        Tue, 18 Jul 2023 14:14:19 -0700 (PDT)
X-QQ-mid: bizesmtp76t1689714848tywoz5oa
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 05:14:07 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: tJPajVdBfNIK2jxArdUWYFT16jn6ztkWRncwJYA/LCJCGKduhgveUNIZLG4JM
        n2oXYzi9kWKFTKTs66un9clianapv6W7HqIAE3p9mJvLcb2yRSJYREt+J04+h2Tbj8FRt66
        XqqfSoAIxuRyxtOWChZqbONtmAf0R9vp041dPA0/5wFaHxSE+OE3fEbaA1lEAc3/x8fU9IB
        9bBZUiTMU9XdJy+Clz/WobmhLn//ADk+ZKbcXG8+FhQB9LVNOfRkWJB2PtnMwZq2Hr5RJ7X
        HooTWAdGrYAP7eGfD2NAzaosBmpLE/P4gARAo6Pm7rzkP9i7ZwPSl/7/ukTdU/4HexqkeCg
        jeg24Wq3PI6R352t53XZSSli+8EbjgKgCqeVy93AovVbfa2CJfOOu/NiGcPriOACoXIsX62
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12934479316635104382
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v1 4/8] selftests/nolibc: add extra config file customize support
Date:   Wed, 19 Jul 2023 05:14:07 +0800
Message-Id: <ecd5cd252bc728df1becfebff772713e8edce1ec.1689713175.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689713175.git.falcon@tinylab.org>
References: <cover.1689713175.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The default DEFCONFIG_<ARCH> may not always work for all architectures,
some architectures require to add extra kernel config options, this adds
a new 'extconfig' target for this requirement.

It allows to customize extra kernel config options via the common
common.config and the architecture specific <ARCH>.config, at last
trigger 'allnoconfig' to let them take effect with missing config
options as disabled.

The scripts/kconfig/merge_config.sh tool is used to merge the extra
config files.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f42adef87e12..08a5ca5f418b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -39,6 +39,9 @@ DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(ARCH))
 
+# extra kernel config files under configs/, include common + architecture specific
+EXTCONFIG            = common.config $(ARCH).config
+
 # optional tests to run (default = all)
 TEST =
 
@@ -162,6 +165,10 @@ initramfs: nolibc-test
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
+extconfig:
+	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
+
 kernel: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
-- 
2.25.1

