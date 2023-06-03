Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2B720EAD
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjFCIN7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFCIN7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:13:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A19FE1B3;
        Sat,  3 Jun 2023 01:13:57 -0700 (PDT)
X-QQ-mid: bizesmtp81t1685780027txyb6un4
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:13:46 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: OFQdrTmJ2CRnGX8nVsKHr+YHzlkPZt5cNCRThmliWSmaPWUuX+pWuPeCQB+Y8
        JAfkpUn4w/DJAP1he/6M6/LIY+/AKW0VDoLH6gY98CM1dwtMvU3KdeSla8x9I65C6c0zhCD
        5GVxav2Y/twBS7c81AJzmqjCmamH64ivTPSG5MEs0J7mbN5L9hQhZlHZVC6T4MhKNkYBx2n
        AAzFJJ+WvSyRQD+Y28jCE+3/LpyzXP+sN05kqIsroD8fn1ddQxDdAblDbh0421O0z2ZpRAe
        eTYQNVt7ysvNJbIEPEkE1QtaKOM4UOF1bIDUVEBFZUwhVUUYB9VMT/5bDGhPMDlKzmP1kk/
        EVzZu8CpRkCu6YK13JMMnBVFyCE0Tke3T/K0PmxriXuJIVr8KaQ3IRdq8GrMUdI5vs59tVX
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1522453405928296276
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH v3 09/12] selftests/nolibc: support two errnos with EXPECT_SYSER2()
Date:   Sat,  3 Jun 2023 16:13:40 +0800
Message-Id: <220827b791ed94a465d03545caa490fdbbd47d1f.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
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

Some functions may be implemented with different syscalls in different
platforms, these syscalls may set different errnos for the same
arguments, let's support such cases.

Suggested-by: Willy Tarreau <w@1wt.eu>
Link: https://lore.kernel.org/linux-riscv/20230528113325.GJ1956@1wt.eu/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a8fcad801cf2..a1c402ce32f4 100644
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

