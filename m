Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E323A721CBA
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 05:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbjFED7t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 23:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjFED7s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 23:59:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A795BD;
        Sun,  4 Jun 2023 20:59:47 -0700 (PDT)
X-QQ-mid: bizesmtp68t1685937578tx69i1ko
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 11:59:37 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: lm7sZZPcOdYzjWmXFGgj6E3I64yRDtOeBkKpihw5JkC6Lh5HJLerIyruOvXGE
        kZaWrOoWRl3kQBx61WfeP9JGjH3DVcuICln3tJb6hodrhPrC4CzBb293lFd6sXzKdXUSkYo
        fkvOPxW86R2WYemPnw5yHFVCGrS3BXT5m82EELWi4l7NsT1L7/a3d+SgCnA3y7Z5KDgIUzM
        Lj4owyhk4zremCkMU+87WSmz4hMxzd3fzkDRBRpSbTUgzsPtC7vT3pz4IzKim/SlQr7rYHW
        9K3/kzT9fCpGzRik5GAItVGrbM4SqnTp0TF3XyrNqJlcoFgoB5zbOI1CE0Is01X4gJuhpil
        bAXNTEUPVGbvTyowOFEia/SH6FHOIeTHxV04gii9MpmlGM8W0BVdODaI+JQBQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 185392236661113198
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 4/4] selftests/nolibc: fix up test-report for run target
Date:   Mon,  5 Jun 2023 11:58:56 +0800
Message-Id: <48a994c40ac739a0e20ed7a34f290637e417bb0b.1685936428.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685936428.git.falcon@tinylab.org>
References: <cover.1685936428.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is a '\r' at the end of every log line when run nolibc-test on
qemu-system (make run), add support for this case, otherwise, the test
result will like this:

    0 test(s) passed, 0 skipped, 0 failed.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 518f85c77fe3..70a27fc41c22 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -128,7 +128,7 @@ libc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) -o $@ $<
 
 test-report:
-	$(Q)[ -f $(CURDIR)/run.out ] && awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
+	$(Q)[ -f $(CURDIR)/run.out ] && awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{f++} /\[SKIPPED\][\r]*$$/{s++} \
 	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
 	         printf(" See all results in %s\n", ARGV[1]); }' \
 		 $(CURDIR)/run.out || :
-- 
2.25.1

