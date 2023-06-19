Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462E57356CF
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 14:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjFSM1v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 08:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjFSM1u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 08:27:50 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E42E65;
        Mon, 19 Jun 2023 05:27:21 -0700 (PDT)
X-QQ-mid: bizesmtp66t1687177631teie4acy
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 20:27:10 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: FVl8EHhfVR4G8njjimH22Yic6dkZ/h69DI80pcJOhgqYGvZ/p2pAaliIhKcCV
        E2+RX78p2BQadDdb1HY3kl9GzWyCiyTmwr4LHv+OGA+S9WNC/ll+g68ESp594/X4kMaOphE
        vh2WS3CuISBsyl3Zz8fGxxQiLLuoLKlSt3i1DJBxrhCqNFbafjCsK6PiFPlBhiVnO9zrTPp
        DlMsNAixfnzM4wnTPRdMU6LO1myVXaj+DDdtE8KSdsUz6rj7JsIww6pmS9w0DjbVzGUVl6x
        j0Mu6TJlhXjREv5DVU2tF5ejBOyvD+jjmeyLM9yjpUbPyP4VlLiP+tJPQwZ7dEzhYI7ng/4
        zAQBbLmoodaPmW2bY7PuhOtE17nv67t3cNSXEPjaZPp+bYdRNCYfbInGOOuiaTx6rlcgFDz
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9699929361938748553
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v5 3/5] selftests/nolibc: allow customize kernel specific ARCH variable
Date:   Mon, 19 Jun 2023 20:27:06 +0800
Message-Id: <0deeb36e44db5abb936a99d855b86a3c76d2a102.1687176996.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687176996.git.falcon@tinylab.org>
References: <cover.1687176996.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some architectures (e.g. riscv, mips) share the same ARCH variable (the
one supported by top-level kernel Makefile) between 32bit and 64bit
architecture variants and even more, some of them have little endian and
big endian variants.

Let's add KARCH to allow architectures customize their own kernel
specific ARCH variable, so, ARCH=$(KARCH) is required by all of the
top-level kernel Makefile targets.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZIAywHvr6UB1J4of@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 000621f21adc..ebecb8cfd947 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -14,6 +14,9 @@ include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
 endif
 
+# kernel supported ARCH names by architecture
+KARCH            = $(or $(KARCH_$(ARCH)),$(ARCH))
+
 # kernel image names by architecture
 IMAGE_i386       = arch/x86/boot/bzImage
 IMAGE_x86_64     = arch/x86/boot/bzImage
@@ -143,10 +146,10 @@ initramfs: nolibc-test
 	$(Q)cp nolibc-test initramfs/init
 
 defconfig:
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
 kernel: initramfs
-	$(Q)$(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
 # run the tests after building the kernel
 run: kernel
-- 
2.25.1

