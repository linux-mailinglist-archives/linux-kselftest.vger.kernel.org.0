Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5177A74980A
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjGFJMv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjGFJMt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:12:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0FA1BD3;
        Thu,  6 Jul 2023 02:12:46 -0700 (PDT)
X-QQ-mid: bizesmtp82t1688634755t8dggjlm
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 06 Jul 2023 17:12:34 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: zW5H9jc4KG4l/DMqLN9WXyfKzcgb9HFj0KUXFkALbSbvd9xbR4isjJVslxBTC
        WRbeHFlS7pVHtZkY74+edO+7cXK6Pz/vL5wgDHSPAj3U+R6PYeN8Pza4By3MvmOxDrDZwxH
        idXyhTsJ8k85LBuRoGdNdkNQn9xpWrtlVf4ADs1Z9lIX4mfRbLNbrkISXaLCe2zapniR1WE
        BwqN6xDSngEemBdfLrMVhjh+hSCRd6l/r9tcYnp6lazn9R5eaGsJzlTr9xDNxNtE8kF+nDC
        M4iN7TfLE/ReSoGM3mUXDB26rRgqdFGhMffij5I+HPBfTc3aE9NvlxrbtQYRknLhFamntyk
        jGPzJuRtHkHBbSXy2hYYz9qzCexFRaZWlCT54kx9y9zGjD62RRmoPJSE08ltw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17950684982473940166
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v1 5/5] selftests/nolibc: report: add newline before test failures
Date:   Thu,  6 Jul 2023 17:12:28 +0800
Message-Id: <38d32aa5c477c45a0802b84926f165f82db103c4.1688633188.git.falcon@tinylab.org>
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

a newline is inserted just before the test failures to avoid mixing the
test failures with the raw test log.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 10e9e5c1bdd0..f5c9c6bf7a19 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -84,7 +84,7 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 		$(CFLAGS_$(ARCH)) $(CFLAGS_STACKPROTECTOR)
 LDFLAGS := -s
 
-REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\r]*$$/{s++} \
+REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
 		END{ printf("\n%03d test(s): %03d passed, %03d skipped, %03d failed => status: ", p+s+f, p, s, f); \
 		if (f) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
 		printf("\nSee all results in %s\n", ARGV[1]); }'
-- 
2.25.1

