Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C138715590
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 May 2023 08:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjE3GiI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 May 2023 02:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjE3GiH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 May 2023 02:38:07 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B0292;
        Mon, 29 May 2023 23:38:05 -0700 (PDT)
X-QQ-mid: bizesmtp79t1685428676txj83914
Received: from linux-lab-host.localdomain ( [119.123.130.226])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 30 May 2023 14:37:55 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: jXjag1m6xl6889Jpgjswy33PSiv3wgSWqoIFui+aUZWHp4mxjk63aUjgGRhFQ
        LMNAUVD9PsUqGVCwHm0hlN5+3sRmrdAVW2PozVMKCw9Db26XQE0Rh65aO20dBDmZGj3g4xj
        i0rY9p/BqHACni0/Ku/45kqRCIc8paxw41FdN7fY/4035HCnWNSJbxMVMhFOplBnbmzw8Uj
        7H8k4Zi9eFlRPn45MvIkFwKtCXWWYCjKOBYpCJo6sBYqsqhYKgEE3ZMUhvXrDB4qltlfFcI
        eEYwBS++g4usHpxxiA4zwoqVlVzpjQpulO0AMmg4eRMb0Xyg9adG8t6O6FU1yxpRCC7RwvM
        WdoOxhFh2t5cqot1k+y9uv06H+ORfS64hQ0rQdFKcCI0nsoYxqCit5lHLyUIzyiFRTz6La0
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15317070203822882915
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-riscv@lists.infradead.org,
        thomas@t-8ch.de
Subject: [PATCH 1/2] selftests/nolibc: add new gettimeofday test cases
Date:   Tue, 30 May 2023 14:37:49 +0800
Message-Id: <bfc3dba52300dcce03ae1c7c41f2bb8984cf459b.1685428087.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1685428087.git.falcon@tinylab.org>
References: <cover.1685428087.git.falcon@tinylab.org>
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

These 3 test cases are added to cover the normal using scenes of
gettimeofday().

They have been used to trigger and fix up such issue:

    nolibc-test.c:(.text.gettimeofday+0x54): undefined reference to `__aeabi_ldivmod'

This issue happens while there is no "unsigned int" conversion in the
new clock_gettime / clock_gettime64 syscall path of gettimeofday():

    tv->tv_usec = ts.tv_nsec / 1000;

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 8ba8c2fc71a0..20d184da9a2b 100644
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
@@ -588,6 +590,9 @@ int run_syscall(int min, int max)
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
+		CASE_TEST(gettimeofday_tv);   EXPECT_SYSZR(1, gettimeofday(&tv, NULL)); break;
+		CASE_TEST(gettimeofday_tz);   EXPECT_SYSZR(1, gettimeofday(NULL, &tz)); break;
+		CASE_TEST(gettimeofday_tv_tz);EXPECT_SYSZR(1, gettimeofday(&tv, &tz)); break;
 		CASE_TEST(getpagesize);       EXPECT_SYSZR(1, test_getpagesize()); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
-- 
2.25.1

