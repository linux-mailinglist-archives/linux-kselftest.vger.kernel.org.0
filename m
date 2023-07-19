Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAEC75967F
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjGSNVo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGSNVo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:21:44 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B973C10FE;
        Wed, 19 Jul 2023 06:21:40 -0700 (PDT)
X-QQ-mid: bizesmtp82t1689772890ty9q7xay
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:21:29 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: r7EP/KuzAv8EqZ+SJffUfZBdMtI1nkzgD6ro01hnSaF51Og9hAgW29XL4W3Al
        ppLr/GYJVVlMZk7h+6fi7kR8pA/JLEFOAyDlqpuOUHwDRhBXzrLNE64VeS3PKfvvpI6CXeJ
        0kydvZH/SrharXA9Is+1UoB0kDNPtcU9IZ36DHV56Yl9QQIO7jLRP7/+kG1g3HZyU9DA37d
        CFf4o578Az9IohYXlkq6VPqkoq9dAub/t2ecSak3ZtRBT4Vqy08XgRCMzMnlCMof+ZnZVZ5
        nWrXfEMPHmL2NoZ2fNT8daNO6A+WpSt1HgsGrOzQ58k0rMFM4HjGzEbYckfHOYgf/7K5v7S
        1ucwJoO6g8uX3y3oLmf+/SdTsKnS8NsAtBzZxKN4hA2E9qMwMr53ku+fazOTMo1POppaGTZ
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12083779158113029408
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 04/14] selftests/nolibc: fix up O= option support
Date:   Wed, 19 Jul 2023 21:21:24 +0800
Message-Id: <be9381f3ab1ca9e291fd17d3ad275bb310de3613.1689759351.git.falcon@tinylab.org>
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
index f1c8e4a0f1b2..058e7be070ea 100644
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
@@ -193,14 +196,14 @@ initramfs: nolibc-test
 
 # common macros for kernel targets
 MAKE_KERNEL   = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
-KERNEL_CONFIG = $(srctree)/.config
-KERNEL_IMAGE  = $(srctree)/$(IMAGE)
+KERNEL_CONFIG = $(objtree)/.config
+KERNEL_IMAGE  = $(objtree)/$(IMAGE)
 
 defconfig:
 	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
 
 extconfig:
-	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(srctree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
+	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
 	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
 
 kernel: initramfs
-- 
2.25.1

