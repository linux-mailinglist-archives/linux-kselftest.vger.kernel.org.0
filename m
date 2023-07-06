Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0167497EE
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 11:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGFJH3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 05:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjGFJH1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 05:07:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352AFDB;
        Thu,  6 Jul 2023 02:07:23 -0700 (PDT)
X-QQ-mid: bizesmtp81t1688634431tedi2oin
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 06 Jul 2023 17:07:10 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: PKnEab4175v+t9CqYTAo/O5JuaceUrnTpb45AqS6cHrDzyHh9WlVMKU4Hg/mI
        Ekyw94GRP2P4lGGTZULGJJ5Hg2zzd3bANHqDruHw4zV9IA+8YXPwa4tOy1QDVZOwDerWXrm
        1SiNE6YUekjIgrAcXNvftkWhk4GDBnYMp+8ajIhiRvyQeOIr9+uFcGm+OT7t0skyo91zKKP
        lAsFkE5jgxOrJ82UGI3iBP6LS8WcBjX2EpHCgeu7MlFoh22YIYIJSnE6JVmMBQvmREop4/4
        1DVoeDad4eGPJ97ZfibuQuwDzdeYB/pWXkQ/4t2fpkK+pI0bzBDYYxjhBROice3i0v4XRtg
        od9CDlJRmD8FXf3+MPZRMG8oECmPlcnfUiCzOC2kErvw1Mcj4w5CvxFUZKyGAGHHkwg+O66
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8347753171439475927
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v1 1/5] selftests/nolibc: report: print a summarized test status
Date:   Thu,  6 Jul 2023 17:03:34 +0800
Message-Id: <3ed850006b76a2ca9a07d30cd82bc881690a7098.1688633188.git.falcon@tinylab.org>
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

one of the test status: success, warning and failure is printed to
summarize the passed, skipped and failed values.

- "success" means no skipped and no failed.
- "warning" means has at least one skipped and no failed.
- "failure" means all tests are failed.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/lkml/20230702164358.GB16233@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index d408b688b291..84b9a46ad678 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -85,7 +85,8 @@ CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 \
 LDFLAGS := -s
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++;print} /\[SKIPPED\][\r]*$$/{s++} \
-		END{ printf("%d test(s) passed, %d skipped, %d failed.\n", p, s, f); \
+		END{ printf("%d test(s) passed, %d skipped, %d failed => status: ", p, s, f); \
+		if (f) printf("failure\n"); else if (s) printf("warning\n"); else printf("success\n");; \
 		printf("See all results in %s\n", ARGV[1]); }'
 
 help:
-- 
2.25.1

