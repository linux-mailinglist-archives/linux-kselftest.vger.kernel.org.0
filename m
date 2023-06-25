Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4792373D210
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjFYQUZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFYQUZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:20:25 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2B95196;
        Sun, 25 Jun 2023 09:20:23 -0700 (PDT)
X-QQ-mid: bizesmtp71t1687710014tpfmvubo
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:20:13 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: jXjag1m6xl6R91bDdyf1kEZlGAuEgRHMqwEDnc6K0vRXlfiEBLwMKYD92YoTN
        pjBT+ISlgvbX0swP/T8UItt1HmbMqxTkrdMjG0NeRlSMeCZB2iprXG8R93kuvFWk9Nqun1c
        ok2HuytLUklY/iTjypQ1RAszOxis1N60KzDTHVQaPd0TT3W8qUSql2jbeG5EIIMCIeqMW62
        qbkLaecm3oKftgevIaIy4LwjvOigmvKTdBNAXkljZX1RlC3Flc+OsmHH/iqSrCfCCaAR268
        iT/BZaVryHiHDJ3++DkT2xsMVASigy6QTOQ9BMhOW29RFJCySflN0kE4xnkwAMQT8J4buXx
        XWv3ZXOkiW1iKOwtLtkpv8IXoTwoL3vdtEXxozeINhRJg6xkBlJ2rO06i+1BQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10052516696424218847
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v1 05/22] selftests/nolibc: add tinyconfig target
Date:   Mon, 26 Jun 2023 00:19:25 +0800
Message-Id: <cbadfa58968020bdb0fab63e6db4e223a6dff336.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The default DEFCONFIG_<ARCH> enables too many options, the kernel
building with such options is very slow.

To speed up the 'run' target, in parallel with the 'defconfig' target,
another 'tinyconfig' target is added to allow only enable necessary
options to just let nolibc-test pass.

Note, this 'tinyconfig' target is not enough to let qemu really boot and
print, the coming patches will add more options to let nolibc-test be
able to run, print the results and let all tests pass.

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/lkml/bc635c4f-67fe-4e86-bfdf-bcb4879b928d@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 10579396e60e..5caf3e7023d7 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -177,6 +177,9 @@ initramfs: nolibc-test
 defconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper $(DEFCONFIG) prepare
 
+tinyconfig:
+	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) mrproper tinyconfig prepare
+
 menuconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) menuconfig
 
-- 
2.25.1

