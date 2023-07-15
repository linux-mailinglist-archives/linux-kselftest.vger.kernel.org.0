Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98696754AB9
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Jul 2023 20:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjGOSdi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Jul 2023 14:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjGOSdi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Jul 2023 14:33:38 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F97F128;
        Sat, 15 Jul 2023 11:33:36 -0700 (PDT)
X-QQ-mid: bizesmtp89t1689446007tccdiej5
Received: from linux-lab-host.localdomain ( [119.123.131.162])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 16 Jul 2023 02:33:26 +0800 (CST)
X-QQ-SSF: 01200000002000D0W000B00A0000000
X-QQ-FEAT: ILHsT53NKPio8QXj0SePF8Uv6ufub1HmV7VAtAE5IfpljIxcz2xHRSfOkvFRE
        5ynY8onEmktjHch/b7w6INeCszX3aPulK5C4mOh+SXNOCRZm2VDiidEH38O5BpM9Ul1NMf6
        ARoHScpuEtEDapuBc52c5iWL+AtOnU8ZUXCmTb2b8JLRKm7/qNHyazikg62xSHOdGxJUrjW
        LMjT8h89SzQxiO+JJHHH3NUXQInpRbZh4v0KeTbgFuPSj1m+5yOkJuHyClou5G4RM5KiyXo
        8WbgPMHR81+3koV2C3KK8kPgBuXMtOX7syK20zYWrUAU6VbZKyj4qKcTxku13hB72JAmDUH
        u9+rqgqk2w5fuNV2+VZ2sQ7rFxMwhwEAMlnYEZqtfPPu63bDbJGo/nlyTEQzmLNXKqs9Hy4
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3122993213598175928
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de
Subject: [PATCH v4 15/18] selftests/nolibc: add EXPECT_PTRGE, EXPECT_PTRGT, EXPECT_PTRLE, EXPECT_PTRLT
Date:   Sun, 16 Jul 2023 02:33:26 +0800
Message-Id: <c7c8a0eede09d6b7cd586788a30af6494c042309.1689444638.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1689444638.git.falcon@tinylab.org>
References: <cover.1689444638.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

4 new pointer compare macros are added, they are similar to the integer
compare macros.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 50 ++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index dfadd07ee7d9..3ff706078fbd 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -410,6 +410,56 @@ static int expect_ptrne(const void *expr, int llen, const void *cmp)
 	return ret;
 }
 
+#define EXPECT_PTRGE(cond, expr, cmp)				\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrge(expr, llen, cmp); } while (0)
+
+static int expect_ptrge(const void *expr, int llen, const void *cmp)
+{
+	int ret = !(expr >= cmp);
+
+	llen += printf(" = <%p> ", expr);
+	result(llen, ret ? FAIL : OK);
+	return ret;
+}
+
+#define EXPECT_PTRGT(cond, expr, cmp)				\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrgt(expr, llen, cmp); } while (0)
+
+static int expect_ptrgt(const void *expr, int llen, const void *cmp)
+{
+	int ret = !(expr > cmp);
+
+	llen += printf(" = <%p> ", expr);
+	result(llen, ret ? FAIL : OK);
+	return ret;
+}
+
+
+#define EXPECT_PTRLE(cond, expr, cmp)				\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrle(expr, llen, cmp); } while (0)
+
+static int expect_ptrle(const void *expr, int llen, const void *cmp)
+{
+	int ret = !(expr <= cmp);
+
+	llen += printf(" = <%p> ", expr);
+	result(llen, ret ? FAIL : OK);
+	return ret;
+}
+
+
+#define EXPECT_PTRLT(cond, expr, cmp)				\
+	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrlt(expr, llen, cmp); } while (0)
+
+static int expect_ptrlt(const void *expr, int llen, const void *cmp)
+{
+	int ret = !(expr < cmp);
+
+	llen += printf(" = <%p> ", expr);
+	result(llen, ret ? FAIL : OK);
+	return ret;
+}
+
 #define EXPECT_PTRER2(cond, expr, expret, experr1, experr2)		\
 	do { if (!(cond)) result(llen, SKIPPED); else ret += expect_ptrerr2(expr, expret, experr1, experr2, llen); } while (0)
 
-- 
2.25.1

