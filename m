Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0183E73845B
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjFUNFA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232167AbjFUNE4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:04:56 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D89FE72;
        Wed, 21 Jun 2023 06:04:54 -0700 (PDT)
X-QQ-mid: bizesmtp75t1687352685tczgblvp
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:04:44 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: 5q30pvLz2idzgSOyYQbpNYjI0MgF9s9bW85QWgt1mwrkwaEVbBHkq3sNw6XbB
        Tk+ffwDM2ZNSXpeVGrBPxLTlOoZuw7O6xm9hJZVGq7ssts7VoitYuxEd5BhNz0D21Tdi8Bl
        /gRzFmT2e6KsLmA7S0mPQiD0omrbNq+fR356wm3dPAwLRhXXKXrgrJc5ypiqoi36SYlGs+1
        7HI7tFE2WQNIrcP5vWu82yzl7EuBU5/zHb/240UGRRRmFjCqhTwgcESQeEz64OHqZkZIubD
        6YkTRjNNactYYsldZQIDDQfEudnbCHpaI0uDRFKKr4Sd3iau/3O4cOv4uQmsu3duG7yKwtm
        +rH3KchgTN3A6ESzsvrtQy4l+bOpd5W367G4bDwpmeiRjXHA4E6LbBz/Sk7Tw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2912981568833336559
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 09/17] selftests/nolibc: rename proc variable to has_proc
Date:   Wed, 21 Jun 2023 21:04:31 +0800
Message-Id: <b8f838a9eac3056d58bfee68d2a3051b11ebb102.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
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

More conditional variables will be added, let's rename them with more
meaningful 'has_' or 'is_' prefix.

This converts proc to has_proc to reflect whether or not proc/ is
mounted.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index e5a218ef8a2d..929d43b95acc 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -544,15 +544,15 @@ int run_syscall(int min, int max)
 	struct timezone tz;
 	struct stat stat_buf;
 	int euid0;
-	int proc;
+	int has_proc;
 	int test;
 	int tmp;
 	int ret = 0;
 	void *p1, *p2;
 	int has_gettid = 1;
 
-	/* <proc> indicates whether or not /proc is mounted */
-	proc = stat("/proc", &stat_buf) == 0;
+	/* <has_proc> indicates whether or not /proc is mounted */
+	has_proc = stat("/proc", &stat_buf) == 0;
 
 	/* this will be used to skip certain tests that can't be run unprivileged */
 	euid0 = geteuid() == 0;
@@ -582,12 +582,12 @@ int run_syscall(int min, int max)
 		CASE_TEST(chdir_root);        EXPECT_SYSZR(1, chdir("/")); break;
 		CASE_TEST(chdir_dot);         EXPECT_SYSZR(1, chdir(".")); break;
 		CASE_TEST(chdir_blah);        EXPECT_SYSER(1, chdir("/blah"), -1, ENOENT); break;
-		CASE_TEST(chmod_net);         EXPECT_SYSZR(proc, chmod("/proc/self/net", 0555)); break;
-		CASE_TEST(chmod_self);        EXPECT_SYSER(proc, chmod("/proc/self", 0555), -1, EPERM); break;
-		CASE_TEST(chown_self);        EXPECT_SYSER(proc, chown("/proc/self", 0, 0), -1, EPERM); break;
+		CASE_TEST(chmod_net);         EXPECT_SYSZR(has_proc, chmod("/proc/self/net", 0555)); break;
+		CASE_TEST(chmod_self);        EXPECT_SYSER(has_proc, chmod("/proc/self", 0555), -1, EPERM); break;
+		CASE_TEST(chown_self);        EXPECT_SYSER(has_proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
-		CASE_TEST(chroot_exe);        EXPECT_SYSER(proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
+		CASE_TEST(chroot_exe);        EXPECT_SYSER(has_proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
 		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
 		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
 		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
@@ -608,7 +608,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
 		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
 		CASE_TEST(link_dir);          EXPECT_SYSER(euid0, link("/", "/blah"), -1, EPERM); break;
-		CASE_TEST(link_cross);        EXPECT_SYSER(proc, link("/proc/self/net", "/blah"), -1, EXDEV); break;
+		CASE_TEST(link_cross);        EXPECT_SYSER(has_proc, link("/proc/self/net", "/blah"), -1, EXDEV); break;
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
 		CASE_TEST(mkdir_root);        EXPECT_SYSER(1, mkdir("/", 0755), -1, EEXIST); break;
-- 
2.25.1

