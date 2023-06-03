Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126E5720EB1
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Jun 2023 10:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229582AbjFCIQ3 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 3 Jun 2023 04:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjFCIQ2 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 3 Jun 2023 04:16:28 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E9F1B3;
        Sat,  3 Jun 2023 01:16:26 -0700 (PDT)
X-QQ-mid: bizesmtp77t1685780177tiq7j5j8
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 03 Jun 2023 16:16:15 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: hoArX50alxFFZWWL2Wyj1D3SOa6jZE2VhGESBJVTnGUig23E/NM6osFUoAejc
        ZMnT/lOPYyAss5rGMd5FNaLZyAovm6YOd7t29lhWCVjscHA33su6FF+MkKHvlCsNyzW3iet
        QTTEeqpyfmlHlPe16kFQ8T//b0we/bCoXaw76jfP8nhXhjqXglXlhb3mLhsjItcfXzOcVsn
        ow6D/k9IEf0Q7tF/wtaReG1iUW2jRUByaH8tMIGBtv/FkX2Uc9m49rBTvnu33BAK+aeG/eg
        wXrlbRPV63CeKIcUmlwSnu2AEvTkhVFGK0euwG0yyMpM1m0Px8nY0Z8nIOFF+ohSORa7fjN
        dNu7jD6jHWXx5n2wUcEz9LxNYZixsgris0WcF8ROqihn3JWeCY2apZ5A0RrzSKN4dZp/MJx
        BVUWy7RiVqo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8375714549719897536
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 11/12] selftests/nolibc: add new gettimeofday test cases
Date:   Sat,  3 Jun 2023 16:16:07 +0800
Message-Id: <68dace9e2532316ff454894697ecfd99e419a523.1685777982.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685777982.git.falcon@tinylab.org>
References: <cover.1685777982.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These 2 test cases are added to cover the normal using scenes of
gettimeofday().

They have been used to trigger and fix up such issue with nolibc:

    nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'

This issue happens while there is no "unsigned int" conversion in the
coming new clock_gettime / clock_gettime64 syscall path of
gettimeofday():

    tv->tv_usec = ts.tv_nsec / 1000;

Suggested-by: Thomas Weißschuh <linux@weissschuh.net>
Link: https://lore.kernel.org/linux-riscv/280867a8-7601-4a96-9b85-87668e1f1282@t-8ch.de/
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index bf63fc66e486..e68c5692ec54 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -533,6 +533,8 @@ static int test_stat_timestamps(void)
  */
 int run_syscall(int min, int max)
 {
+	struct timeval tv;
+	struct timezone tz;
 	struct stat stat_buf;
 	int euid0;
 	int proc;
@@ -588,6 +590,8 @@ int run_syscall(int min, int max)
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
+		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
+		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
-- 
2.25.1

