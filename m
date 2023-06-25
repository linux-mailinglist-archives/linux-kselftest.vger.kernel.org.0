Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E465273D281
	for <lists+linux-kselftest@lfdr.de>; Sun, 25 Jun 2023 18:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFYQm4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 25 Jun 2023 12:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjFYQmz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 25 Jun 2023 12:42:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7620B9;
        Sun, 25 Jun 2023 09:42:53 -0700 (PDT)
X-QQ-mid: bizesmtp68t1687711364tfahxxx2
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 00:42:43 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKZz5eb5VjrwTSUMnFub5FvDyyA4AG4JS/NVFi6m4xL1PtTDGgki7
        SnsDQs5vU8T2xxkzc/oQqnSLaM+Eb1dLFNj38am5/Wsi7PonpRZPJLPoSX7a3tMDRZLk/pV
        71pkSdtf97HRjCdyV3yJW9/Dydg25/CNLggbKiBiZmd5B/Dz6F8hkfadC1zK8vAdTd8jtBL
        kxsqr/munTIt4/beyvN1G7SHWaLcUKzcqMcrvv+x6q7ntH0mgrZeMwEk6TTDdV7uicaBSbv
        r65823BCKd6NGoenKBL68UpMVikNP1JDO2ZkWo4EtJ4O0FzjR5q80g9NjOSaS2qhIVjv7nH
        J6GTuwkFT1S3q6lNOQeiOMy3m1bCOW7k52mr0noySIBSO43zao=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11765547641019653024
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v1 20/22] selftests/nolibc: add run-tiny and run-default
Date:   Mon, 26 Jun 2023 00:41:23 +0800
Message-Id: <c1142457987895ebc2e3f378c7b30494f45ca48e.1687706332.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687706332.git.falcon@tinylab.org>
References: <cover.1687706332.git.falcon@tinylab.org>
MIME-Version: 1.0
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

These two targets allow to do config and run together.

- run-tiny: do tinyconfig, extconfig and then run.
- run-default: do defconfig, extconfig and then run.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index a847a2264fed..3e7e51bd7082 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -156,6 +156,14 @@ REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\
 		END{ printf("%d test(s) passed, %d skipped, %d failed.\n", p, s, f); \
 		printf("See all results in %s\n", ARGV[1]); }'
 
+# allow run with a config target together: run-tiny = tinyconfig + run; run-default = defconfig + run
+ifeq (run-tiny, $(MAKECMDGOALS))
+AUTOCONFIG ?= tinyconfig
+endif
+ifeq (run-default, $(MAKECMDGOALS))
+AUTOCONFIG ?= defconfig
+endif
+
 # allow switch nolibc headers include method: 1 for sysroot, 0 for nolibc.h
 SYSROOT ?= 1
 
@@ -228,7 +236,7 @@ tinyconfig:
 menuconfig:
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) menuconfig
 
-extconfig:
+extconfig: $(AUTOCONFIG)
 	$(Q)$(srctree)/scripts/config --file $(srctree)/.config $(EXTCONFIG)
 	$(Q)$(MAKE) -C $(srctree) ARCH=$(KARCH) CC=$(CC) CROSS_COMPILE=$(CROSS_COMPILE) KCONFIG_ALLCONFIG=$(srctree)/.config allnoconfig
 
@@ -240,6 +248,8 @@ run: kernel
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) $(LOG_OUTPUT)
 	$(Q)$(REPORT) $(CURDIR)/run.out
 
+run-tiny run-default: run
+
 # re-run the tests from an existing kernel
 rerun:
 	$(Q)qemu-system-$(QEMU_ARCH) -display none -no-reboot -kernel "$(srctree)/$(IMAGE)" -serial stdio $(QEMU_ARGS) $(LOG_OUTPUT)
-- 
2.25.1

