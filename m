Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669107497F3
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjGFJJR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjGFJJP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:09:15 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 651921BD6;
        Thu,  6 Jul 2023 02:09:13 -0700 (PDT)
X-QQ-mid: bizesmtp80t1688634544tzw1dfgq
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 06 Jul 2023 17:09:02 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: z3fUwT6ITpvQJtKJFntzr+v2DtfIaW5KgRkd/rkN5GZYpqpEsPysfSUogpnFG
        UONU+yid/rMV1/tzEJqTV0VAEIyNNoCAFM1TQJR/xQhxcGMQ9XT/kDy+tGEyaTm9JxIKdC+
        31ZSDLlFs6bTJfkakq9xg6wKYtdbqqkRtyL/vgt6YKgsCkR1m0l7WwMGXtS1zANiWEMn/H+
        GH8OIkSE6dwEAqYTE/koCzlZmfUPCLK78WQO5SJorwletzGNpgpYIKIIDcTTKv4iHO/Y6UZ
        RTOJsQi7zwle/SSPN+t5W1v8oDsCwPTSpOph6VIgFBRJ/0CmOdzK64Md6RrktFzIyIYDEt1
        K3FyBFczgiPdJR5bKYvAoBwrV0xTfDVstN+pCVT5mCdmGPyCWZhzWExSisB2w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12299753033176172041
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v1 2/5] selftests/nolibc: report: print total tests
Date:   Thu,  6 Jul 2023 17:08:16 +0800
Message-Id: <6397c1e3ff7ad95ddf9d12fb429310e57aed8d79.1688633188.git.falcon@tinylab.org>
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

Let's count and print the total number of tests, now, the data of
passed, skipped and failed have the same format.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 84b9a46ad678..a02be8b0a569 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -85,7 +85,7 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 LDFLAGS := -s
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\r]*$$/{s++} \
-		END{ printf("%d test(s) passed, %d skipped, %d failed => status: ", p, s, f); \
+		END{ printf("%d test(s): %d passed, %d skipped, %d failed => status: ", p+s+f, p, s, f); \
 		if (f) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
 		printf("See all results in %s\n", ARGV[1]); }'
 
-- 
2.25.1

