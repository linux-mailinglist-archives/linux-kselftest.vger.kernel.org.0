Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E83765D59
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jul 2023 22:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjG0U3i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 27 Jul 2023 16:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjG0U3h (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 27 Jul 2023 16:29:37 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A5BC2688;
        Thu, 27 Jul 2023 13:29:35 -0700 (PDT)
X-QQ-mid: bizesmtp65t1690489766t9v338bu
Received: from linux-lab-host.localdomain ( [61.141.78.189])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 28 Jul 2023 04:29:25 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3hs8KjjHXgV3Mnz1SbuFa76sKO20ziBuLGO5QLIvoP9RFy4OEgee
        Cy0+ZWIn7BRQWovusTQnisGvElCqSK+hdthX7FIZJa0rDEywrtYE9JwNPGXNfugDB1nTF7U
        +JD/jIMyAb7+eEg0Bn/XSgdSX5NQVY0+YUYRJWS4/IHQE1Ym0tZSaJxcMRrXSsP6FflLo58
        ld499Ozr6Eo+sFi2CqSszJD/SCrP5OBpOuy7ATwW2fq0QokE/CUxRfcyR92DNJ5NFMCuU7c
        TAx3dnUznunh2zaCrxSAqWa6uSZUfImNSRnq/BT2eRS9LgbGmvO6jNZ56OyddZZ0bBhKyOE
        iCrVoZGvHR+BjNUKyxKqLGA7XIeg1nMUOzYarGvfLMWgJIkVJCEtrVdioJdpq2hM3UldzBO
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17253053822244597306
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 07/12] selftests/nolibc: add menuconfig and mrproper for development
Date:   Fri, 28 Jul 2023 04:29:24 +0800
Message-Id: <45c0c24e77f4ae78ac3ace099f2e6678d15456e0.1690489039.git.falcon@tinylab.org>
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

menuconfig and mrproper are frequently used operations during a new
architecture porting, testing or debugging.

menuconfig is required to tune and test extra kernel config options for
tinyconfig.

mrproper is required to get a clean srctree while want to start a new
building with O= option, the old generated files in srctree must be
mrproper-ed.

differ from local nolibc targets, the menuconfig and mrproper targets
from top-level Makefile accept different ARCH variable and require extra
'-C /path/to/srctree', which make development not consistent and
therefore very painful, let's add local menuconfig and mrproper targets
too.

To reduce duplicated entries, menuconfig and mrproper are added
together.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 6385915d16c9..a214745e0f3e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -215,6 +215,9 @@ defconfig:
 	$(Q)$(srctree)/scripts/kconfig/merge_config.sh -O "$(objtree)" -m "$(KERNEL_CONFIG)" $(foreach c,$(EXTCONFIG),$(wildcard $(CURDIR)/configs/$c))
 	$(Q)$(MAKE_KERNEL) KCONFIG_ALLCONFIG="$(KERNEL_CONFIG)" allnoconfig
 
+menuconfig mrproper:
+	$(Q)$(MAKE_KERNEL) $@
+
 PHONY += $(KERNEL_CONFIG)
 $(KERNEL_CONFIG):
 	$(Q)if [ ! -f "$(KERNEL_CONFIG)" ]; then $(MAKE) --no-print-directory defconfig; fi
-- 
2.25.1

