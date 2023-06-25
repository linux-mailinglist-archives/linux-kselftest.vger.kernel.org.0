Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFFD73D20E
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjFYQSe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:18:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjFYQSd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:18:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A8B18D;
        Sun, 25 Jun 2023 09:18:31 -0700 (PDT)
X-QQ-mid: bizesmtp79t1687709901tb2iajrv
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:18:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3hcF+S99Fpw/jxjR7hoHB1tjQPBUK8gngnJMi+HZ2VtCebvgRwRp
        y9Rc5husLEZJxYSNuJLBiqv1VvbA7z4Bh5k9x6oCWZR3j+I7wa/PncQEDZKTcOuuBOLOlWo
        s3+XSH5JiK0/PzxZVKyhmUAVuYOZk4hKY8a6RhTkte4JjGcXsjcZleXt0Wy8BKMWe14H/Rr
        oKGXxweT29IeiZuEWTl+VZUaGonZWfGCEdaoKk7TiPbIG6lnm/gP9v3ciVxPpDNWGJo5R1x
        ZF8MtgZemdf0EdEqLGD/wtVaP7sQIaoJZ4KRn8f5DpkWXj9fhmayPJOCLDWHNMieCuh0IGM
        aXQuZTofIvKITjgkBAMFI3lvaF8wTV+A2UVr846ThvApEtSUHfYc2Ij9KJfAw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10532903300621852071
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 04/22] selftests/nolibc: add menuconfig target for manual config
Date:   Mon, 26 Jun 2023 00:15:58 +0800
Message-Id: <c63ebf3eff3013d8525426f62a39ef63f4b77f58.1687706332.git.falcon@tinylab.org>
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
let's allow users to tune some configs with 'menuconfig'.

This is important when porting nolibc to a new architecture, it also
allows to speed up nolibc 'run' target testing via manually disabling
tons of unnecessary configs.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index f8be0de0ce0e..10579396e60e 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -177,6 +177,9 @@ initramfs: nolibc-test
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
+menuconfig:
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) menuconfig
+
 kernel: initramfs
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) $(IMAGE_NAME) CONFIG_INITRAMFS_SOURCE=$(CURDIR)/initramfs
 
-- 
2.25.1

