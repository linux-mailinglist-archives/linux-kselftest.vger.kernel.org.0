Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5747656AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 17:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjG0PC3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 11:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjG0PCX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 11:02:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E1230DD;
        Thu, 27 Jul 2023 08:02:21 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690470132tx5a4qcf
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 27 Jul 2023 23:02:11 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: 0b1/4t+gNkKytBjCTqeXnq1dFQWJAzuDxRmoAl6R9LQsxrXNcL71OJByKVTCI
        OFdLjLXL1o+c7vcbOerWQMZZosERU2yYpAZQGKmyHfwhFQXp3ksXlOXeGrA/hYoGsGZeLd+
        EYdJXpJm7Ym/nQZlWxOUOkCyI4hN88LC5uMwCYGd8VEKSc1Zsa5rpEerxrnBY2/U3JW828A
        bWi0k0tb7ZG1Ao68fLJ1H1folKBub3b2By8QBwFT7HZbx6kWVLi6exJprTYBbZ+aUm7Q40W
        hWFvLT5vYQXYg62jpuLqSfltc27lyaenFJ2nzrkercv63NSzdf2CJ+7CNt4M9hW7RbPkof0
        eVpiON3gzl8JwNr7UbaE7I9fU3plbmRKrIFp/Du6XpUvmi4UE55yZu9TLnZIcAKWk3+WxN8
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1921293056862354421
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 3/7] selftests/nolibc: add extra configs customize support
Date:   Thu, 27 Jul 2023 23:02:02 +0800
Message-Id: <8e9e5ac6283c6ec2ecf10a70ce55b219028497c1.1690468707.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1690468707.git.falcon@tinylab.org>
References: <cover.1690468707.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default DEFCONFIG_<ARCH> may not always work for all architectures,
some architectures require to add extra kernel config options, this
allows to add extra options in the defconfig target.

Based on the .config generated from DEFCONFIG_<ARCH>, It allows to
customize extra kernel config options via both the common common.config
and the architecture specific <ARCH>.config, at last trigger
'allnoconfig' to let them take effect with missing config options as
disabled.

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

