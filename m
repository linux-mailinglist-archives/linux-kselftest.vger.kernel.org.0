Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340B8738460
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjFUNGa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 09:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjFUNG3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 09:06:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8811E57;
        Wed, 21 Jun 2023 06:06:27 -0700 (PDT)
X-QQ-mid: bizesmtp65t1687352778tfzegumg
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 21:06:17 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKYEx/R7zmeq5Pbdlh4EGiuKPzQGqg8HVlwQy22R4D7wTw/S/Dvan
        LTYrlLqMaz7n6ftUXrgKDFc4ydLGJIHgIWP7OY8waXj1STgmIEQa8Q68FoV+DUIUK2uauQT
        tYuvEhuiKk9CaD83sCePkBIF6eVPSzWgog2XYDYiEe/fgt/y6pBc0T+I6pYhjj3MmSyYhpn
        m+YYnS0XNr2dKcyJBED+awWBKaB4lLzk/sHfAD3rOTU/GRplDbyudJ8u7qOVxktmX0yKJ8o
        87uWKnrvOWoK7e5kmB1OrReBvDWdUTd17zghAsNdomfEfotBIlquGI4wOGBA3Ih0b8jYSkq
        qORUx91Bgs7X1UtbDnLWYJqqaxgdgaLuH7f7KxztBXwzjrHWIL5TANcdEZ01g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15848095737819457792
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 10/17] selftests/nolibc: rename euid0 variable to is_root
Date:   Wed, 21 Jun 2023 21:05:49 +0800
Message-Id: <9547ea8320074269751eb4e54bcbd1395e66c5f5.1687344643.git.falcon@tinylab.org>
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

euid0 is converted to is_root to indicate whether or not running as
root.

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 929d43b95acc..69f59a395746 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -543,7 +543,7 @@ int run_syscall(int min, int max)
 	struct timeval tv;
 	struct timezone tz;
 	struct stat stat_buf;
-	int euid0;
+	int is_root;
 	int has_proc;
 	int test;
 	int tmp;
@@ -555,7 +555,7 @@ int run_syscall(int min, int max)
 	has_proc = stat("/proc", &stat_buf) == 0;
 
 	/* this will be used to skip certain tests that can't be run unprivileged */
-	euid0 = geteuid() == 0;
+	is_root = geteuid() == 0;
 
 	/* from 2.30, glibc provides gettid() */
 #if defined(__GLIBC_MINOR__) && defined(__GLIBC__)
@@ -585,7 +585,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(chmod_net);         EXPECT_SYSZR(has_proc, chmod("/proc/self/net", 0555)); break;
 		CASE_TEST(chmod_self);        EXPECT_SYSER(has_proc, chmod("/proc/self", 0555), -1, EPERM); break;
 		CASE_TEST(chown_self);        EXPECT_SYSER(has_proc, chown("/proc/self", 0, 0), -1, EPERM); break;
-		CASE_TEST(chroot_root);       EXPECT_SYSZR(euid0, chroot("/")); break;
+		CASE_TEST(chroot_root);       EXPECT_SYSZR(is_root, chroot("/")); break;
 		CASE_TEST(chroot_blah);       EXPECT_SYSER(1, chroot("/proc/self/blah"), -1, ENOENT); break;
 		CASE_TEST(chroot_exe);        EXPECT_SYSER(has_proc, chroot("/proc/self/exe"), -1, ENOTDIR); break;
 		CASE_TEST(close_m1);          EXPECT_SYSER(1, close(-1), -1, EBADF); break;
@@ -607,7 +607,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(ioctl_tiocinq);     EXPECT_SYSZR(1, ioctl(0, TIOCINQ, &tmp)); break;
 		CASE_TEST(link_root1);        EXPECT_SYSER(1, link("/", "/"), -1, EEXIST); break;
 		CASE_TEST(link_blah);         EXPECT_SYSER(1, link("/proc/self/blah", "/blah"), -1, ENOENT); break;
-		CASE_TEST(link_dir);          EXPECT_SYSER(euid0, link("/", "/blah"), -1, EPERM); break;
+		CASE_TEST(link_dir);          EXPECT_SYSER(is_root, link("/", "/blah"), -1, EPERM); break;
 		CASE_TEST(link_cross);        EXPECT_SYSER(has_proc, link("/proc/self/net", "/blah"), -1, EXDEV); break;
 		CASE_TEST(lseek_m1);          EXPECT_SYSER(1, lseek(-1, 0, SEEK_SET), -1, EBADF); break;
 		CASE_TEST(lseek_0);           EXPECT_SYSER(1, lseek(0, 0, SEEK_SET), -1, ESPIPE); break;
-- 
2.25.1

