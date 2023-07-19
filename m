Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C71759696
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jul 2023 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGSNZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 19 Jul 2023 09:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGSNZH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 19 Jul 2023 09:25:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD83BFD;
        Wed, 19 Jul 2023 06:25:05 -0700 (PDT)
X-QQ-mid: bizesmtp80t1689773096tvcme5mq
Received: from linux-lab-host.localdomain ( [119.123.130.39])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Jul 2023 21:24:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0X000000A0000000
X-QQ-FEAT: HzdOSj0Bmys3/fOoqbEWdmxqkRROHEaQlEr+veWl6qr7J4qAL4t6mLHXQg1Ae
        oJ1k9dIndDeyN6LIRorFFpXBgVRAoP/Ui+ew0uZZJnIffORC7NlmPt5jJTyXQThDo2gDs0E
        o046oUM4s5eX2dJRXtSBVY62qAJYmoHZ5T9ySwt+qTYQHFyk7X4lJE6wwdvosb/orSpuTip
        tBGneNnha00pwUhzibN40qIlMYGfOcwSO5THfqdn9dRkZaYUVIg2MqmfDJjH45RNFbNL1n4
        5q3a4pg/WmGF8aqkdlpJNgBa0iTMEpcVgRmXsXCR2jIeIT8sGHS1o2glMnR9M20tQDwi8HY
        n8vlR7Z1rYuxE97wp8KcHmo6Y2GEqegrELfozgtqD2YjCldim0=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7211787249313186061
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 07/14] selftests/nolibc: defconfig: remove mrproper target
Date:   Wed, 19 Jul 2023 21:24:54 +0800
Message-Id: <ba8ce60152aa03c73f9b33960d3be8af0e377a49.1689759351.git.falcon@tinylab.org>
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

The O=/path/to/kernel-<ARCH> option allows to build kernel for different
architectures in different output directories, in this scene, it doesn't
need the mrproper operation for defconfig anymore.

If really require to clean up the source code tree, let users run the
standalone mrproper target on demand.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 9d9902b54e5e..83cb4b017bef 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -203,7 +203,7 @@ mrproper:
 	$(Q)$(MAKE_KERNEL) mrproper
 
 defconfig:
-	$(Q)$(MAKE_KERNEL) mrproper $(DEFCONFIG) prepare
+	$(Q)$(MAKE_KERNEL) $(DEFCONFIG) prepare
 
 menuconfig:
 	$(Q)$(MAKE_KERNEL) menuconfig
-- 
2.25.1

