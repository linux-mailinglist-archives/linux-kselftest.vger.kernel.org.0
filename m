Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8409674B634
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 20:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjGGSZd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 14:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGGSZd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 14:25:33 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A1951FEF;
        Fri,  7 Jul 2023 11:25:31 -0700 (PDT)
X-QQ-mid: bizesmtp70t1688754321tmaef10w
Received: from linux-lab-host.localdomain ( [116.30.131.119])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 08 Jul 2023 02:25:20 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: eCJvJF4ptHAtnbbaPwc47aTRbhYkkrfXtqT9G41b5rpNHFwk2Vwq29QTGN+1N
        QhHOU4ekwfeupUA5ICP/pbXkF1za1ckb77bO4HdRm88TKxiykufqnCu4oVIlXNNUCviQvjz
        /Nk6ToRqvIw0rn+n9mR6Bzrkil92rYxg3PLnb+AdgzS0uTMx8jQi+gjZSBE4pfspWtYf4G7
        vyTtV9RA+mhar+9xk8A17WOp15ObCy4Va0A8I+9++PangUMrTVKZyfMRXZaWR9/Q4xRVVmF
        V00caUFP00VVnetlMH4kw2/nnJZtmC4JmPoZOT2as/Qh4oEJHsNROofRUoB39ouPIR4670+
        e4me1glggNeMnMemhMx10tGgI5ArASsCaCdBsgEyDcJmqGFn3AxxyH8vh+H96UpptOOUtsf
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10722182004068960664
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, thomas@t-8ch.de,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v4 03/18] selftests/nolibc: gettid: restore for glibc and musl
Date:   Sat,  8 Jul 2023 02:25:11 +0800
Message-Id: <879d87ac5eccbaa08bb471f88f5253d4b9d496cf.1688750763.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688750763.git.falcon@tinylab.org>
References: <cover.1688750763.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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

Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index b4b64125d418..b63afe1975c4 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -668,6 +668,7 @@ int run_syscall(int min, int max)
 	int tmp;
 	int ret = 0;
 	void *p1, *p2;
+	int has_gettid = 1;
 
 	/* <proc> indicates whether or not /proc is mounted */
 	proc = stat("/proc", &stat_buf) == 0;
@@ -675,6 +676,11 @@ int run_syscall(int min, int max)
 	/* this will be used to skip certain tests that can't be run unprivileged */
 	euid0 = geteuid() == 0;
 
+	/* from 2.30, glibc provides gettid() */
+#if defined(__GLIBC_MINOR__) && defined(__GLIBC__)
+	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
+#endif
+
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
 
@@ -684,9 +690,7 @@ int run_syscall(int min, int max)
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

