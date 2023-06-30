Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5AE743DC3
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Jun 2023 16:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbjF3OoX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Jun 2023 10:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232382AbjF3OoK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Jun 2023 10:44:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163724223;
        Fri, 30 Jun 2023 07:44:02 -0700 (PDT)
X-QQ-mid: bizesmtp62t1688136233td32r9qm
Received: from linux-lab-host.localdomain ( [119.123.131.49])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 30 Jun 2023 22:43:51 +0800 (CST)
X-QQ-SSF: 01200000000000D0W000000A0000000
X-QQ-FEAT: ILHsT53NKPiH69hHrQvaiwgA2zlFoZJKtxC3fQVf7xOa2i8JFvEi+l7cutDAu
        NdSKTsbC9yjEhA6vmXFk52zYQc0pKbNiELQlyjNzuftlI2+C5S6KjlV6ZmpgxTNZYbbmwT3
        XBAqH3DVlvcmqCIlVUIQ5tDSiIc5s7ZO4aw6x3P4BEFHP5IW5xWN3d5R8h6EhyakVqszTjH
        d8c4U4zRgluYH95UaAUrzK8gOV5JlyhGb75ONtswumgTLcvBBAIqAkIu6QFvtT1qjDkNOju
        +dz7qfMaSdRefLXOxX7PKtAZNQA4/zrDxOlVVDC/qI93jjoPyE8OBFOf6PRsrdlBK0gvPQf
        K1pD2PxV9e1EJdrEsOsdraPfpcPBiMHBJo7H6KsMY6+eQIZpiJGyL/KQ1VYkY3uPthpY+tq
        P65JLNq7VMo=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16227406883335655901
From:   Zhangjin Wu <falcon@tinylab.org>
To:     thomas@t-8ch.de, w@1wt.eu
Cc:     arnd@arndb.de, falcon@tinylab.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v3 02/14] selftests/nolibc: gettid: restore for glibc and musl
Date:   Fri, 30 Jun 2023 22:43:49 +0800
Message-Id: <e9dfa1ac893ee0662789365a5ecc6eb7fbd34f17.1688134399.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1688134399.git.falcon@tinylab.org>
References: <cover.1688134399.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
index ffef0ff921bf..be7614c897b4 100644
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

