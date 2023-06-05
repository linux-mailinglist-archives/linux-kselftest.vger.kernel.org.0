Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3977721CB1
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 05:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjFED4t (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 4 Jun 2023 23:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232781AbjFED4s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 4 Jun 2023 23:56:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED18DA6;
        Sun,  4 Jun 2023 20:56:46 -0700 (PDT)
X-QQ-mid: bizesmtp82t1685937396t1aouh5f
Received: from linux-lab-host.localdomain ( [61.141.77.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 05 Jun 2023 11:56:35 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: lm7sZZPcOdbJD8cVKMiASAi6Ml/t7tG1bkV1nfPLPi2vvHA+K/8f3KsCqtD4h
        LE7aT9mS730pQq+6dEcXz/fpRaJJRtqKoGlSuiNVsKvopYVg0cchyzAmQN9oq/txeCU22Sd
        CtnySZNGMOe0xBHD2xeYxw2OQr70b6yN+52l56pzPKka2ALTCEBKeBuW23qLP+UI0C17/ZT
        FDVh4zmtUmyLVGcrRaHhAefpzv6rSxiSNhLs0n/lIGGT3uPSjid8Wb+hDTXXLloZckxNl7C
        Xk8INamYkM+Qj5L/j5hdbxmrrK3ixkkfp0o5M+oHUvvv3n5hMAY+4nr40sgBq2pu3rQgU2K
        dP6IxQmVW1fAi4AhrjN1OKB0FAz02D2lObYwHl7xcncwCU+IL3Csj8V2sYGTTnAA3pKlDul
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9763339930852643474
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 2/4] selftests/nolibc: allow run test-report directly
Date:   Mon,  5 Jun 2023 11:50:04 +0800
Message-Id: <ab62c7a15acbfb6347ddb7569246e46df4e2ec3a.1685936428.git.falcon@tinylab.org>
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

This allows to re-check the test report via 'make test-report' without
the requirement to re-run the dependency targets.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 8149ace2938a..5b0af8d8f5f3 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -128,10 +128,10 @@ libc-test: nolibc-test.c
 	$(QUIET_CC)$(CC) -o $@ $<
 
 test-report:
-	$(Q)awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
+	$(Q)[ -f $(CURDIR)/run.out ] && awk '/\[OK\]$$/{p++} /\[FAIL\]$$/{f++} /\[SKIPPED\]$$/{s++} \
 	         END{ printf("%d test(s) passed, %d skipped, %d failed.", p, s, f); \
 	         if (s+f > 0) printf(" See all results in %s\n", ARGV[1]); else print; }' \
-	         $(CURDIR)/run.out
+		 $(CURDIR)/run.out || :
 
 # qemu user-land test
 _run-user: nolibc-test
-- 
2.25.1

