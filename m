Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732E4765D33
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjG0UZJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjG0UZI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:25:08 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32ECD213A;
        Thu, 27 Jul 2023 13:25:07 -0700 (PDT)
X-QQ-mid: bizesmtp76t1690489498tn31pf5y
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:24:56 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: OFQdrTmJ2CT0tv/k26zD61DgunIr3+i0gone8E+YGqdNlrN1NMVMfNlBeM907
        QHYMz8CJvGbNGo2HcSksGZidroSyt7+Jq0dU4tKx5ZZiLbBmsl82jsZXPz/fIp7su2ohykc
        554yQkRI4nz5yiK3mB6DzQ4AUpgeLhpu3NvDkupV1A4BbpHKbl+nPP2OAKUDI22ThM7qUKK
        flti2txnb6ObvovHXy8v5rve33RQFJdVlo49Y31TT1pCPBQgSu2+DxtHvQf9Pb/7F5LC0/d
        vCjccB3olddvLIM1bmTiA+Wf3Hb76B0A27Y0PylTN7gPtLhNMevIhh9v1KvAmL8lQjHWUUA
        DhqwfpUhbSJaTlO3jnl/uFVJDaGyBW5Ij8WS61t2uqI0G7jdJzG3DM/UvtLyQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6039361887706887061
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 03/12] selftests/nolibc: fix up O= option support
Date:   Fri, 28 Jul 2023 04:24:56 +0800
Message-Id: <1da6cedc8a7232833dbb7aaada5ae9df3e60ed7e.1690489039.git.falcon@tinylab.org>
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

To avoid pollute the source code tree and avoid mrproper for every
architecture switch, the O= argument must be supported.

Both IMAGE and .config are from the building directory, let's use
objtree instead of srctree for them.

If no O= option specified, means building kernel in source code tree,
objtree should be srctree in such case.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/ZK0AB1OXH1s2xYsh@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index bfea1ea0b4e7..f5680b9ed85c 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -9,6 +9,9 @@ ifeq ($(srctree),)
 srctree := $(patsubst %/tools/testing/selftests/,%,$(dir $(CURDIR)))
 endif
 
+# add objtree for O= argument, required by IMAGE and .config
+objtree ?= $(srctree)
+
 ifeq ($(ARCH),)
 include $(srctree)/scripts/subarch.include
 ARCH = $(SUBARCH)
@@ -194,12 +197,12 @@ initramfs: nolibc-test
 
 # common macros for kernel targets
 MAKE_KERNEL   = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
-KERNEL_CONFIG = $(srctree)/.config
-KERNEL_IMAGE  = $(srctree)/$(IMAGE)
+KERNEL_CONFIG = $(objtree)/.config
+KERNEL_IMAGE  = $(objtree)/$(IMAGE)
 
 defconfig:
 	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
-	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
+	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
 	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
 
 kernel: initramfs
-- 
2.25.1

