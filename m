Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A07B9735B91
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jun 2023 17:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjFSPx3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 19 Jun 2023 11:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjFSPx1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 19 Jun 2023 11:53:27 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3FA3186;
        Mon, 19 Jun 2023 08:53:24 -0700 (PDT)
X-QQ-mid: bizesmtp85t1687189991tj28c6n8
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 19 Jun 2023 23:53:09 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: IcCSTr/hHjPXBzWN/U8TqAy26Icbc9MCR5PRDeanWzS97OqZQp6D8x32yCRXd
        z7v3lJkDjh8Bnduvjgxp6BUtmiTBWR4NZ+ZdQiVjrii5Yv4zug2TpFN1ywarWMuQiS68CRm
        oI9rETIcMUDABclQFL803tjbxYaTUC8P5gnCkG/xKhjTdifzmw9KjwKDZj9R0x5vjatl5xW
        n44oyKgmuqburMW/jSxFr/Lm/YCcDTSSCHz/KPdiklbNFlPmEQje0supEPDaWXkOp098Hrq
        PWsFjKpwymtqmhg2ZEPFcOKRiDvAB1mdcheA4/IXre18GQrwZVLwISWCRUdKb7ACqM87hMx
        dGz9eICsxNFzymXN/Z7LPoSpK5ykIi/QDivgqdAd+0g6VfRJ7M62nmIGdf8MacIUA3vKknU
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16052288436696807788
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     david.laight@aculab.com, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org, thomas@t-8ch.de
Subject: [PATCH v4 08/10] selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
Date:   Mon, 19 Jun 2023 23:52:31 +0800
Message-Id: <12bd89048c33436a72d2a1b34ea79c60ac3643d5.1687187451.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687187451.git.falcon@tinylab.org>
References: <cover.1687187451.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The syscalls like sbrk() and mmap() return pointers, to test them, more
pointer compare test macros are required, add them:

- EXPECT_PTREQ() expects two equal pointers.
- EXPECT_PTRNE() expects two non-equal pointers.
- EXPECT_PTRER() expects failure with a specified errno.
- EXPECT_PTRER2() expects failure with two specified errnos.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 58 ++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 486334981e60..34af802dadfd 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -361,6 +361,64 @@ static int expect_ptrnz(const void *expr, int llen)
 	return ret;
 }
 
+#define EXPECT_PTREQ(cond, expr, cmp)				\
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptreq(expr, llen, cmp); } while (0)
+
+static int expect_ptreq(const void *expr, int llen, const void *cmp)
+{
+	int ret = 0;
+
+	llen += printf(" = <%p> ", expr);
+	if (expr != cmp) {
+		ret = 1;
+		llen += pad_spc(llen, 64, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 64, " [OK]\n");
+	}
+	return ret;
+}
+
+#define EXPECT_PTRNE(cond, expr, cmp)				\
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrne(expr, llen, cmp); } while (0)
+
+static int expect_ptrne(const void *expr, int llen, const void *cmp)
+{
+	int ret = 0;
+
+	llen += printf(" = <%p> ", expr);
+	if (expr == cmp) {
+		ret = 1;
+		llen += pad_spc(llen, 64, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 64, " [OK]\n");
+	}
+	return ret;
+}
+
+#define EXPECT_PTRER2(cond, expr, expret, experr1, experr2)		\
+	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_ptrerr2(expr, expret, experr1, experr2, llen); } while (0)
+
+#define EXPECT_PTRER(cond, expr, expret, experr)			\
+	EXPECT_PTRER2(cond, expr, expret, experr, 0)
+
+static int expect_ptrerr2(const void *expr, const void *expret, int experr1, int experr2, int llen)
+{
+	int ret = 0;
+	int _errno = errno;
+
+	llen += printf(" = <%p> %s ", expr, errorname(_errno));
+	if (expr != expret || (_errno != experr1 && _errno != experr2)) {
+		ret = 1;
+		if (experr2 == 0)
+			llen += printf(" != (<%p> %s) ", expret, errorname(experr1));
+		else
+			llen += printf(" != (<%p> %s %s) ", expret, errorname(experr1), errorname(experr2));
+		llen += pad_spc(llen, 64, "[FAIL]\n");
+	} else {
+		llen += pad_spc(llen, 64, " [OK]\n");
+	}
+	return ret;
+}
 
 #define EXPECT_STRZR(cond, expr)				\
 	do { if (!cond) pad_spc(llen, 64, "[SKIPPED]\n"); else ret += expect_strzr(expr, llen); } while (0)
-- 
2.25.1

