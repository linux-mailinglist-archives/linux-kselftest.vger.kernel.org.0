Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B926D75968C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjGSNWz (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbjGSNWy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:22:54 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3C4113;
        Wed, 19 Jul 2023 06:22:52 -0700 (PDT)
X-QQ-mid: bizesmtp82t1689772962tgim8kcd
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:22:41 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: +bXiSo2NuBcL7jnLryDuQMhX+oFM/svSg3z6REjIYNvM0REi9CZiqEZnjWRCL
        ssb+wsQjZ8s935FBqNK3tojAPMVXvl8aV9UwAK4EfLNhW/r5ms/tCdMPpdIOt+EflVmdYDz
        bGXR5iCBo5Msz82inD3wj21q5qlY68UzWajtjYfmI/qROoSLF/gr8+RZjy0dVjexSpSJAWe
        ZMJFwMm3toAP1U5OAgMvedAY1thea5XkWrW/IQqVygK0NmrlAtUEjTSFS7v7Asp9KE6SapD
        ssDVy24csF5bypQdq1aRUxLKlNl2YDCxZxGTf7JBgTaIAPsl6Ys5c8tmCsUlV0nTxpiLOX5
        sT+xKsrQRu+BO6ZbNbJYCo79gZik5C5S+DdEarQ8QOA74L72Jrnms/QqWlLrSNmZW5/ZfEV
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1272607350294726886
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 05/14] selftests/nolibc: add menuconfig for development
Date:   Wed, 19 Jul 2023 21:22:37 +0800
Message-Id: <a7fcca12e0f567efd29314172ccf1ad4cd279bf7.1689759351.git.falcon@tinylab.org>
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

The default DEFCONFIG_<ARCH> may not always work for all architectures,
let's allow users to tune some kernel config options with 'menuconfig'.

This is important when porting nolibc to a new architecture, it also
allows to speed up nolibc 'run' target testing via manually disabling
tons of unnecessary kernel config options.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 058e7be070ea..06954b4b3885 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -202,6 +202,9 @@ KERNEL_IMAGE  = $(objtree)/$(IMAGE)
 defconfig:
 	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
 
+menuconfig:
+	$(Q)$(MAKE_KERNEL) menuconfig
+
 extconfig:
 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
 	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
-- 
2.25.1

