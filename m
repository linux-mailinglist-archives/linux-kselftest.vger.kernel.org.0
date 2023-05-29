Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5F714FEE
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 May 2023 21:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjE2TsU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 May 2023 15:48:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjE2TsR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 May 2023 15:48:17 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4685DC;
        Mon, 29 May 2023 12:48:15 -0700 (PDT)
X-QQ-mid: bizesmtp69t1685389686tvz8s19j
Received: from linux-lab-host.localdomain ( [119.123.130.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 03:48:05 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: dKvkn8qoLrH/qrejci3fihvIQXoBf5YJrhmGUUzcf6qh+6IazDSOYdwIhP/YW
        ORgu5EPCd6gOyYSDLJ50tIYOWHXJxLAHR+9ATsEoUhwa54b9uqgZV8rWyvxv5W1sGh3Dw0f
        yzw3WsCbvyXct5MtQJqJt/JFGFvi3IWadG8J3YkTbMp0ForpQJ/4qiirjssVz+7nPuHC5wH
        zOP+3TtFbEJQahQpwJpxiK5lh9V5fPTxAGAibu31tRi7EEfUpX+/b6G5EdjvKBHfJUrz/40
        IcdygC3t7OZS2n+o3MeIYbt6xp+apeSPMnuQC/Qj2LQQeDS/zt6WhRt3e8Ns8QuBKgJ8LoD
        RID1pt1s13NEExuGLJSuUmrq+riUGsiUJO5h+JsZIs+Q6yPZdUdER2Yi1BNlQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17992497824335630657
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v2 02/13] selftests/nolibc: support two errnos with EXPECT_SYSER2()
Date:   Tue, 30 May 2023 03:47:55 +0800
Message-Id: <63510e8d586d2d20337f3bb2ff753db4e09bfe11.1685387484.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685387484.git.falcon@tinylab.org>
References: <cover.1685387484.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some functions may be implemented with different syscalls in different
platforms, these syscalls may set different errnos for the same
arguments, let's support such cases.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 7be2625f952d..bf63fc66e486 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -300,18 +300,24 @@ static int expect_sysne(int expr, int llen, int val)
 }
 
 
+#define EXPECT_SYSER2(cond, expr, expret, experr1, experr2)		\
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr2(expr, expret, experr1, experr2, llen); } while (0)
+
 #define EXPECT_SYSER(cond, expr, expret, experr)			\
-	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_syserr(expr, expret, experr, llen); } while (0)
+	EXPECT_SYSER2(cond, expr, expret, experr, 0)
 
-static int expect_syserr(int expr, int expret, int experr, int llen)
+static int expect_syserr2(int expr, int expret, int experr1, int experr2, int llen)
 {
 	int ret = 0;
 	int _errno = errno;
 
 	llen += printf(" = %d %s ", expr, errorname(_errno));
-	if (expr != expret || _errno != experr) {
+	if (expr != expret || (_errno != experr1 && _errno != experr2)) {
 		ret = 1;
-		llen += printf(" != (%d %s) ", expret, errorname(experr));
+		if (experr2 == 0)
+			llen += printf(" != (%d %s) ", expret, errorname(experr1));
+		else
+			llen += printf(" != (%d %s %s) ", expret, errorname(experr1), errorname(experr2));
 		llen += pad_spc(llen, 64, "[FAIL]\n");
 	} else {
 		llen += pad_spc(llen, 64, " [OK]\n");
-- 
2.25.1

