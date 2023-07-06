Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B96F87497FE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231860AbjGFJKY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230159AbjGFJKX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:10:23 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B5EDB;
        Thu,  6 Jul 2023 02:10:22 -0700 (PDT)
X-QQ-mid: bizesmtp80t1688634613ts83xwgr
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 06 Jul 2023 17:10:11 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: znfcQSa1hKZ0tbn8MHp6xFgP1iCflF/1wRHbbM/MX29g0UPfyXKPGv7UuxKRc
        o+VMYE/xIBRFYN6vNLhFVe25N4UPDV6vCrk5TNaJaQRJPK4UANWpvCMQvmt4xX+IY0r1p5o
        hFAHSJeAGBUMoaP7tyPaChYBWxv5UXyjaRofqIXHcbOUssCCQX5acT4O1BlJ3JeZgwH7If3
        XtzumcHZU61a2mgPs6BbIFukdhH5VKoDPIr2cIeEqnvasg8/8O8bk546SpKWS43woGClCbE
        357R8kSWQ+LeRSFMHIlVh/PyZY/ECFXt+VkpwZsUKziVn93RlyBAmoBR4GgO+yUZ43RxH9a
        MVatrs3slDMmIoTtZ2PyptUL1kDEgK0+5zMQly/izoXLhRVVWeLxwF2T3382A==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13378550366425220871
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v1 3/5] selftests/nolibc: report: align passed, skipped and failed
Date:   Thu,  6 Jul 2023 17:10:08 +0800
Message-Id: <9620a07294e4c099587170e84aba167bf849e841.1688633188.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688633188.git.falcon@tinylab.org>
References: <cover.1688633188.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

align the test values for different runs and different architectures.

Since the total number of tests is not bigger than 1000 currently, let's
align them with "%03d".

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index a02be8b0a569..2c53bf41967b 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -85,7 +85,7 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 LDFLAGS := -s
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\r]*$$/{s++} \
-		END{ printf("%d test(s): %d passed, %d skipped, %d failed => status: ", p+s+f, p, s, f); \
+		END{ printf("%03d test(s): %03d passed, %03d skipped, %03d failed => status: ", p+s+f, p, s, f); \
 		if (f) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
 		printf("See all results in %s\n", ARGV[1]); }'
 
-- 
2.25.1


