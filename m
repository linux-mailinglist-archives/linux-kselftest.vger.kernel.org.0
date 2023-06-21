Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D009E7384AC
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjFUNQg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjFUNQf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:16:35 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3051994;
        Wed, 21 Jun 2023 06:16:31 -0700 (PDT)
X-QQ-mid: bizesmtp64t1687353381tybgz1rn
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:16:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: OtIeQkg1QQGRU6D6w1usUxm5UtoUxl8mHkGDNVB6rKGyKV5kvrl1yVbh7EPcT
        YR7tOU85DSoQ0Z0birjpP0DbP9SyBUaeu8YgRnIl+kX2dhPTaOp2uVTTw2qlzqvirWouum2
        T/nPkr61O1qJUrgpGptq7at6lRZndbusEdtbR88mSPvh8BVHOJK+VMdej8eknGixsuHHUtD
        VDyUxNsgO8ENogsBF8U5GKwnwdqDC6mnohFDX0R45jdvxPDoWfP4iwcXMhAeVSmzIas7VrX
        o09AxNafPK/tp5+tnsbEfzimFzAFdWRkepC7gPLul6j6YJF5QrjvtwFklYs113Jdzr1N/dB
        AzokAAND7DPeo8iRsfs/OVUYJ9AnaDMAtGJhXrrESOxbGRtwS9jyBQCFiHewQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1238278600326820981
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 14/17] selftests/nolibc: rename chroot_exe to chroot_file
Date:   Wed, 21 Jun 2023 21:13:20 +0800
Message-Id: <217a4460a1f4e5fa6fd0312340ea7b7b32ac225f.1687344643.git.falcon@tinylab.org>
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

When there is no procfs, let's use tmpfs and create a tmp file for
chroot_exe test.

Since chroot_exe is mainly testing the not directory case (ENOTDIR), so,
rename it to chroot_file may be better.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index c900564219e8..19e4ef5ce578 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -547,11 +547,14 @@ int run_syscall(int min, int max)
 	int has_proc;
 	int test;
 	int tmp;
+	int fd;
 	int ret = 0;
 	void *p1, *p2;
 	int has_gettid = 1;
 	int has_tmpdir = 0;
+	int has_tmpfile = 0;
 	char *tmpdir = NULL;
+	char *tmpfile = NULL;
 
 	/* <has_proc> indicates whether or not /proc is mounted */
 	has_proc = stat("/proc", &stat_buf) == 0;
@@ -560,10 +563,20 @@ int run_syscall(int min, int max)
 	if (stat("/proc/self/net", &stat_buf) == 0) {
 		tmpdir = "/proc/self/net";
 		has_tmpdir = 1;
+
+		tmpfile = "/proc/self/exe";
+		has_tmpfile = 1;
 	} else if (stat("/tmp/.", &stat_buf) == 0) {
 		tmpdir = "/tmp/blah";
 		if (mkdir(tmpdir, 0755) == 0)
 			has_tmpdir = 1;
+
+		tmpfile = "/tmp/dummy";
+		fd = open(tmpfile, O_CREAT);
+		if (fd != -1) {
+			has_tmpfile = 1;
+			close(fd);
+		}
 	}
 
 	/* this will be used to skip certain tests that can't be run unprivileged */
@@ -599,7 +612,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chown_self);        EXPECT_SYSER(has_proc, chown("/proc/self", 0, 0), -1, EPERM); break;
 		CASE_TEST(chroot_root);       EXPECT_SYSZR(is_root, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
-		CASE_TEST(chroot_exe);        EXPECT_SYSER(has_proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
+		CASE_TEST(chroot_file);       EXPECT_SYSER(has_tmpfile, chroot(tmpfile), -1, ENOTDIR); break;
 		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
 		CASE_TEST(close_dup);         EXPECT_SYSZR(1, close(dup(0))); break;
 		CASE_TEST(dup_0);             tmp = dup(0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
-- 
2.25.1

