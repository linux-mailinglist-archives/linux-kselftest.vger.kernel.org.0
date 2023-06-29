Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12DDE743111
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 01:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjF2X0K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jun 2023 19:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjF2X0F (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jun 2023 19:26:05 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66FD1FE4;
        Thu, 29 Jun 2023 16:26:03 -0700 (PDT)
X-QQ-mid: bizesmtp91t1688081154tyi55hnf
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 07:25:52 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: 6aXALTFZqPuZikFTnD0XtTrqnijJVdsBQ+fxB4J0aSCn27CFnCwO6LrrmluGc
        rpV/PikWplX1NtR6o5wbyCcv6WlYJCsSsHhUrWWybJrEciGHc9kgBfM70mFeFNYeglnMGaR
        8kBS1WA6Q4/vvjTcUxQL//bO5Mn1EJTJzocmcqmGvmgq8MovuFny2kYrND2di0t/ae2si6k
        109qlRNSTq5XbQJp2wTmaL7ZX5Rjgx+UyLcnaw17iJFrYU343Cyv7rqi6hV2Y2LZVOQSE7e
        eCT6Z5+JLR3XMhW7o4gCnAQAkgPr6qWY9aNtjTcvynXUgcu82JGWCvCw6lg1FETscw+rksp
        6s6sRAan4j8fts6W6DRZYa0tWkZ42qJoAMsqUqJ/6sX6qmg4pm+krnciMniTQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12284148764811659706
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v2 02/15] selftests/nolibc: gettid: restore for glibc and musl
Date:   Fri, 30 Jun 2023 07:25:14 +0800
Message-Id: <e9cc14be8114661c32f0d3e361fbe30cb8a5184c.1688078605.git.falcon@tinylab.org>
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

As the gettid manpage [1] shows, glibc 2.30 has gettid support, so,
let's enable the test for glibc >= 2.30.

gettid works on musl too.

[1]: https://man7.org/linux/man-pages/man2/gettid.2.html

Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index a2eacd6436d0..785b1f4cbdc5 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -659,6 +659,7 @@ int run_syscall(int min, int max)
 	int tmp;
 	int ret = 0;
 	void *p1, *p2;
+	int has_gettid = 1;
 
 	/* <proc> indicates whether or not /proc is mounted */
 	proc = stat("/proc", &stat_buf) == 0;
@@ -666,6 +667,11 @@ int run_syscall(int min, int max)
 	/* this will be used to skip certain tests that can't be run unprivileged */
 	euid0 = geteuid() == 0;
 
+	/* from 2.30, glibc provides gettid() */
+#if defined(__GLIBC_MINOR__) && defined(__GLIBC__)
+	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
+#endif
+
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
 
@@ -675,9 +681,7 @@ int run_syscall(int min, int max)
 		switch (test + __LINE__ + 1) {
 		CASE_TEST(getpid);            EXPECT_SYSNE(1, getpid(), -1); break;
 		CASE_TEST(getppid);           EXPECT_SYSNE(1, getppid(), -1); break;
-#ifdef NOLIBC
-		CASE_TEST(gettid);            EXPECT_SYSNE(1, gettid(), -1); break;
-#endif
+		CASE_TEST(gettid);            EXPECT_SYSNE(has_gettid, gettid(), -1); break;
 		CASE_TEST(getpgid_self);      EXPECT_SYSNE(1, getpgid(0), -1); break;
 		CASE_TEST(getpgid_bad);       EXPECT_SYSER(1, getpgid(-1), -1, ESRCH); break;
 		CASE_TEST(kill_0);            EXPECT_SYSZR(1, kill(getpid(), 0)); break;
-- 
2.25.1

