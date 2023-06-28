Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700B07412DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jun 2023 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjF1NqB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jun 2023 09:46:01 -0400
Received: from bg4.exmail.qq.com ([43.155.65.254]:43191 "EHLO
        bg4.exmail.qq.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjF1Npj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jun 2023 09:45:39 -0400
X-QQ-mid: bizesmtp72t1687959924tdeldav3
Received: from linux-lab-host.localdomain ( [116.30.129.193])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 28 Jun 2023 21:45:23 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 3M0okmaRx3hbfDVbYv/1Z/TLd6Ir+AB6pAGiQfbDE/hehL3KYjLzY6o73548z
        E4mqATphOaFmoSi4iLJvd5rkDgbj3ueAMfev9X3KkHCz19jtFSWtubU0dPubSCTu4iCZtvJ
        6+Me1uOjqWESpbZZ0nfkhRs9ifKfgHRoV/A3xmWTBTpwuoibmtb/mBCIo8x1WIRs0EnpGcJ
        LD6F9363XqkEJVSHTVo+dJZgHPzGJ+D4W3bMSJHbGgfHXOM0GPYKRc8q2Tkhzx/jYTAKkGT
        clMThOrDt5eosqiZH0yWeaojISGQtVAcbkIZMgDDMa3BwDki19OJ139cnQGqJvmWbcFoqxk
        4YIbWiWyq87TNjP1IrcPan2dJhbkyvpHO6eXxxP1QEqyl+ILZXhj7Xs+jvE6w==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12436359372428410090
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, david.laight@aculab.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 12/14] selftests/nolibc: add EXPECT_PTREQ, EXPECT_PTRNE and EXPECT_PTRER
Date:   Wed, 28 Jun 2023 21:44:58 +0800
Message-Id: <1c24dab9b346455b627cfef34305ce8028c26156.1687957589.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687957589.git.falcon@tinylab.org>
References: <cover.1687957589.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
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

