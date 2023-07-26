Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 747E876399A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Jul 2023 16:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbjGZOxb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Jul 2023 10:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233896AbjGZOxa (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Jul 2023 10:53:30 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C181FDD;
        Wed, 26 Jul 2023 07:53:27 -0700 (PDT)
X-QQ-mid: bizesmtp81t1690383196tg3gh1y1
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 26 Jul 2023 22:53:15 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: CR3LFp2JE4lR8uPfZDf/0uFir0EsUHKoIwJEyr/UBQkcQtyYyGJy+e/6T2bhl
        ZIJRDpqjWmsEvMhs7TxXstjU/eRcQx+Luc8vn+wo2GlERyOOmhZlkyrA7rCWWu3ysV3Hh5I
        UU8ha4Ud4zqLREeTs0H1/xM7MXjt6HsVs81LVJLtY2KyZHbiem9ohokvXd/i211/VBPrP9F
        +OdRuATSNtWxecawtfJb6H179BBcc4xS9yMDAQDYKlW6aCjNfYy7J7++YZUSNun3rXu7aI5
        2gfuXzzAhcprbvxAynbM0fN2eK83hWvon+GU4BHxvbIQ6kWPxNEphh0+vHGVPyK7sIz4tGR
        /Z3y5Wyeb+QS2e8Ly474VQH5TNpPj+voCBKRn8SmHq7xm11eXgdQb+pSzN3dXzON9v0UGrj
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13127243865508606372
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 3/7] selftests/nolibc: add extra configs customize support
Date:   Wed, 26 Jul 2023 22:52:56 +0800
Message-Id: <06d7db26484ca13e583ddad43af1bc0e4a99674f.1690373704.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690373704.git.falcon@tinylab.org>
References: <cover.1690373704.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The default DEFCONFIG_<ARCH> may not always work for all architectures,
some architectures require to add extra kernel config options, this
allows to add extra options in the defconfig target.

It allows to customize extra kernel config options via the common
common.config and the architecture specific <ARCH>.config, at last
trigger 'allnoconfig' to let them take effect with missing config
options as disabled.

The scripts/kconfig/merge_config.sh tool is used to merge the extra
config files.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/67eb70d4-c9ff-4afc-bac7-7f36cc2c81bc@t-8ch.de/
Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f42adef87e12..9576f1a0a98d 100644
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
 
@@ -161,6 +164,8 @@ initramfs: nolibc-test
 
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(srctree)/.config" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG="$(srctree)/.config" allnoconfig
 
 kernel: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
-- 
2.25.1

