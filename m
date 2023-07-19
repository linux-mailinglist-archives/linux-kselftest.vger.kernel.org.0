Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F0C759691
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjGSNYB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGSNYB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:24:01 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462CEFD;
        Wed, 19 Jul 2023 06:23:59 -0700 (PDT)
X-QQ-mid: bizesmtp85t1689773030t5e87exz
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:23:49 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: 3M0okmaRx3hNEMaNV2ioaObF5OMlW4ww9cct06aqxtedtRCfN70YUmF3a484b
        9Qjbfp6aj9FY1AKa7K9kAHuWursDDOWcZoJgbNNRrs/V+KNyYZaDEGlwRoH/ib0d5FT6ZOL
        cveUkLm+0DaUPwrlGCrGJhHP+w2meeI96aA+kuHnMb3ZdIgHe7jV0WId4rG1T4LJdAPUxkV
        HIcERzcKwwEOUmmyjtbUBz39qzmo5rl1HFT/LmUmfP7joFD6tBfEtZygyydZezi8wic9O3z
        lMHAG1sCFWCHMIrzfZgha001OwwRZhf2AaMTNdQNuWzONlCCSr9OVyoX1IiGs880pf9TDpK
        D6ZsgwuXgQLzee68YjD58Iig0WHxM2QIUrNU0Q7tDUQeAh/hBuKj+XHASpPfw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 37435219588245657
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 06/14] selftests/nolibc: add mrproper for development
Date:   Wed, 19 Jul 2023 21:23:48 +0800
Message-Id: <30b7328645ad7baec6e63daaf069dd97d5456269.1689759351.git.falcon@tinylab.org>
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

When want to start a new building with O= option, the old generated
files in the source code tree must be mrproper-ed, adding mrproper
target here to avoid switch to the source code tree manually.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 06954b4b3885..9d9902b54e5e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -199,6 +199,9 @@ MAKE_KERNEL   = $(MAKE) -C $(srctree) ARCH=$(ARCH) CC=$(CC) CROSS_COMPILE=$(CROS
 KERNEL_CONFIG = $(objtree)/.config
 KERNEL_IMAGE  = $(objtree)/$(IMAGE)
 
+mrproper:
+	$(Q)$(MAKE_KERNEL) mrproper
+
 defconfig:
 	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
 
-- 
2.25.1

