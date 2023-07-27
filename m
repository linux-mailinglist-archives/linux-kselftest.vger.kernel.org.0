Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1802F765D79
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjG0UfQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjG0UfP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:35:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4828271C;
        Thu, 27 Jul 2023 13:35:13 -0700 (PDT)
X-QQ-mid: bizesmtp65t1690490104tdo0lyfq
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:35:02 +0800 (CST)
X-QQ-SSF: 01200000002000D0X000B00A0000000
X-QQ-FEAT: rZJGTgY0+YOFURgI4rO4FCPYfZtEtfnMGBKFe0DXq/9mV7CVBMsYHOMR4+JVr
        IOjcZ4pyh73O5L5n/JDvdzIMMCtbuhFCCO44m0pvqeXuESuDcN2xUKASBx63aVhk3t7tc54
        K5DJI5ifluK37jWOc54qO9uY6B3j7f6msEJ8K4yVhVodJOILbBFPFeriiptpNxGRDN0SVzJ
        Q6zx9zbVOo6TBjyF0plarqxyqxegL9TDqmSSy4/oP38NYrS2lTTjvH79Hzqz5m4OQVs6vjL
        vsaaZv8k0s2lQFP7yYJ4HG9hvlPonlQFkvnbhJJHdbZbXZYswjhieFAky/22sa+CtrvtdqC
        igOmTDSJsdVqG0HL6MOGxfRS1rUxlxkwcxbP5F0GyD0dy1RYaF83ud/JsEbRQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17780552390268563941
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 12/12] selftests/nolibc: speed up some targets with multiple jobs
Date:   Fri, 28 Jul 2023 04:35:01 +0800
Message-Id: <ca03989b38085a74bde33b7dc5040b33a76f3c4b.1690489039.git.falcon@tinylab.org>
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

The sysroot install and kernel build targets are time cost, let's use
-j<N> to parallelize them with multiple jobs.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index ad2538ec5eb0..1b45c22f9a94 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -171,7 +171,7 @@ PHONY = sysroot/$(ARCH)/include
 sysroot/$(ARCH)/include:
 	$(Q)rm -rf sysroot/$(ARCH) sysroot/sysroot
 	$(QUIET_MKDIR)mkdir -p sysroot
-	$(Q)$(MAKE) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
+	$(Q)$(MAKE) -j$$(nproc) -C ../../../include/nolibc ARCH=$(ARCH) OUTPUT=$(CURDIR)/sysroot/ headers_standalone
 	$(Q)mv sysroot/sysroot sysroot/$(ARCH)
 
 ifneq ($(NOLIBC_SYSROOT),0)
@@ -211,7 +211,7 @@ initramfs: nolibc-test
 	$(Q)cp nolibc-test initramfs/init
 
 # common macros for kernel targets
-MAKE_KERNEL   = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
+MAKE_KERNEL   = $(MAKE) -j$$(nproc) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE)
 KERNEL_CONFIG = $(objtree)/.config
 KERNEL_IMAGE  = $(objtree)/$(IMAGE)
 
-- 
2.25.1

