Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9302721CB4
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 05:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231968AbjFED6D (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 23:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbjFED6D (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 23:58:03 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858E4A6;
        Sun,  4 Jun 2023 20:57:59 -0700 (PDT)
X-QQ-mid: bizesmtp89t1685937468tqznavd2
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 11:57:47 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: dKvkn8qoLrGXN8h42NRMms+7urQ9WLIQF9jRVidEDJkV0vebFHsuJOValBm6o
        C3EIJxwfkS/a6CpLXS6bvhkA8SoIR1mt3nnZIMpbGaF3twWVbG9DPbwawMfrPT12NcT0xVy
        xxNaUL0PXRcrUQlpm8LPUUvB7Dkgd9ZBgsnt7GRinn9m0wQjnptaR3GWLjyfb5vdEny1J4r
        F4gXLkQBHKu9v1ynmmr7AROd+QdNG66n1ZBKVVI+JGuyNStZawuednjxkv98BAXHYs3JsvE
        FrgTtDwUxyzrgkjN9v6YQAGfJyW1gnxEUkatJDGzoncqAoREl4aTkk/RSNL5x9xWOWXNK93
        yDz01PwbYdrwhRDrKfO6HDEyPbNya71Pu7D/TIflfmDDAfhUCwlPPoDVdNefg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2171116470520406675
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 3/4] selftests/nolibc: always print the log file
Date:   Mon,  5 Jun 2023 11:57:44 +0800
Message-Id: <835e118943d257b7a83066fb4fb77c0e5cf71534.1685936428.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685936428.git.falcon@tinylab.org>
References: <cover.1685936428.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This allows to check the other issues of the output file manually even
when all of them passed.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 5b0af8d8f5f3..518f85c77fe3 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -130,7 +130,7 @@ libc-test: nolibc-test.c
 test-report:
 	$(Q)[ -f $(CURDIR)/run.out ] && awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
 	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
-	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
+	         printf(" See all results in %s\n", ARGV[1]); }' \
 		 $(CURDIR)/run.out || :
 
 # qemu user-land test
-- 
2.25.1

