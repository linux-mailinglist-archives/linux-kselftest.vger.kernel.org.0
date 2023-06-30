Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5B9743167
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 02:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjF3AA4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 20:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjF3AAz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 20:00:55 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0252972;
        Thu, 29 Jun 2023 17:00:53 -0700 (PDT)
X-QQ-mid: bizesmtp70t1688083243tc6q58s1
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 08:00:43 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: CR3LFp2JE4kswbijyT8FSHr/m5Ro1TRCzo0a8RfheEUvcf/BVZGX2KLlH6E/+
        ShX8DywmRJ9ILMpomwp/MCmci/hDinkPesyIEF8m1z95RH4xr+UNw7Yg9ulHwl3Jt/BEuwK
        wY3rSTi9866Fog1s2TtL6YySRzzpuWzkghoVs58pDr48HYz2G6BLHsnKSvBnuCK3bNxBdn5
        ljA/Au8aGriHhAlDjLeRl6iTzcX0CoK1GI0ozDFMjE4Q9SztOGzJOUw96JOZtXYGlaITQxc
        bkb+eW2apV54E40wx7aRPpITa7SqGh7wpSvibt119O/MtmCGbqN99YMlET+fYnYEA1R1AQI
        cSxavE7nLz/r3EOrqvur7xG9QFph5o5xFoNwERFkEopWHVlaymMKulc5hiamQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14245471600300813277
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 13/15] selftests/nolibc: rename chroot_exe to chroot_tmpfile
Date:   Fri, 30 Jun 2023 08:00:28 +0800
Message-Id: <a38a6057866b597e5f931de550f2a6f24404ecdf.1688078605.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688078604.git.falcon@tinylab.org>
References: <cover.1688078604.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For CONFIG_PROC_FS=n, let's use tmpfs and create a tmp file for
chroot_exe test.

Since chroot_exe is mainly testing the not directory case (ENOTDIR), so,
rename it to chroot_tmpfile may be better.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 1002e0267515..2e9eaa7efa6e 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -682,6 +682,8 @@ int run_syscall(int min, int max)
 	int ret = 0;
 	void *p1, *p2;
 	int has_gettid = 1;
+	const char *tmpfile = get_tmpfile("/tmp/dummy");
+	int has_tmpfile = tmpfile != NULL;
 
 	/* <proc> indicates whether or not /proc is mounted */
 	proc = stat("/proc", &stat_buf) == 0;
@@ -720,7 +722,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
-		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
+		CASE_TEST(chroot_tmpfile);    EXPECT_SYSER(has_tmpfile, chroot(tmpfile), -1, ENOTDIR); break;
 		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
 		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
 		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
-- 
2.25.1

