Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BD273D212
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjFYQVu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFYQVt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:21:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4656A8;
        Sun, 25 Jun 2023 09:21:46 -0700 (PDT)
X-QQ-mid: bizesmtp87t1687710097tb0hug14
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:21:36 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: xwvWJGGFd7OpckdxdG9LSdgq7u/95vEIQ4fFtJ7ibMS131dQf/iSj19Z7iyZB
        LPUobVEaAbpGncd4a28NvNHDXa4p514cbGVK4Pfbg5ou4M8S18404GherJ8BriFkhEsA+cc
        oL4JAFEmm+AxUxofALbjSu8MNrA/5DurqmnWKlTDB5ADkhfNI/YVUxCLDO2PAMQTM33og0c
        xPf00HBJxozyti9AGEnVpESan5ViGLVv0Wzc2VlmzDpXFOk0hGYKYC8pzYSwEEHWBox3GjF
        WVXgPkl+t886mLVlIHJVBplw0vlKxbB5gIpVZuekWPw4M/WcfTKUntap1DhJ7jDXo8Xlwgh
        pVc5uuzJZtKWffJAKjd7UipxbhH9x66h+FmsMbGFwR7VgdzLEY=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14215416064968937971
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 06/22] selftests/nolibc: allow customize extra kernel config options
Date:   Mon, 26 Jun 2023 00:21:18 +0800
Message-Id: <d637c287ad32be58a3398f2b8b64e74b82faaf79.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default DEFCONFIG_<ARCH> may not really work for all architectures,
tuning it with the 'menuconfig' target is good for development stage,
but not enough for the default compile.

Since both of the 'defconfig' and 'tinyconfig' targets may not meet our
requirement, just like the 'CONFIG_INITRAMFS_SOURCE' we added, some
architectures may require to add extra configs, this adds a new
'extconfig' target to unify such requirement.

It allows to customize extra config options by architecture and then
trigger 'allnoconfig' to let them take effect and with missing configs
as disabled.

The old common 'CONFIG_INITRAMFS_SOURCE' setting from the 'kernel'
target is moved to this target too.

It is safe enough to share this 'extconfig' between 'defconfig' and
'tinyconfig', because 'extconfig' is often a subset of 'defconfig' or an
additions of 'defconfig' and 'tinyconfig'.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 5caf3e7023d7..0b810681547b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -48,6 +48,15 @@ DEFCONFIG_s390       = defconfig
 DEFCONFIG_loongarch  = defconfig
 DEFCONFIG            = $(DEFCONFIG_$(ARCH))
 
+# extra kernel configs shared among architectures
+EXTCONFIG_COMMON     = --set-str CONFIG_INITRAMFS_SOURCE $(CURDIR)/initramfs
+
+# extra kernel configs by architecture
+EXTCONFIG_ARCH       = $(EXTCONFIG_$(ARCH))
+
+# extra kernel configs, include common + architecture specific
+EXTCONFIG            = $(EXTCONFIG_ARCH) $(EXTCONFIG_COMMON)
+
 # optional tests to run (default = all)
 TEST =
 
@@ -183,8 +192,12 @@ tinyconfig:
 menuconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) menuconfig
 
-kernel: initramfs
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+extconfig:
+	$(Q)$(srctree)/scripts/config --file $(srctree)/.config $(EXTCONFIG)
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG=$(srctree)/.config allnoconfig
+
+kernel: initramfs extconfig
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME)
 
 # run the tests after building the kernel
 run: kernel
-- 
2.25.1

