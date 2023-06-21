Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A54738422
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Jun 2023 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbjFUMzL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Jun 2023 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbjFUMzK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Jun 2023 08:55:10 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029FAE7D;
        Wed, 21 Jun 2023 05:55:08 -0700 (PDT)
X-QQ-mid: bizesmtp66t1687352100tvb06x1e
Received: from linux-lab-host.localdomain ( [116.30.126.60])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 21 Jun 2023 20:54:59 +0800 (CST)
X-QQ-SSF: 01200000000000D0V000000A0000000
X-QQ-FEAT: znfcQSa1hKZcFXPQnd4RVj09C3OnkJWSkgLOL6bViSkPod9ouiMy9YOYaykXy
        MyO4BJF4HrBpb3CtZbIMxoxb0B6lkVlmh6fyGDCoX2fTYobW1h4DSy7NbZaBbeHKZE+Zi4C
        cvR4FQVVd+Cf4yDQRUKYc12aKstmn0hMbRbzp5rrpjwlrDEAarUPxpISJH7M8eSOMheHt+a
        8oFAgquo0VJe41uTRGNumpHRqWbHfBcrCNjHOWvi4qAkef7DYMfiC6Uy/g7pm+tYbXaq/wO
        jUkX3tm2VVyxKprhTftxC7sgB/SLY5moBwhe3r7d0gAPAEQovCVxRFjIE8JEmo59d7CC69D
        VMjtnLwhGv/WiaoO/Ns0yAp9xcRJWoyympa24xwUHueqaviAbk=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 455061309582853142
From:   Zhangjin Wu <falcon@tinylab.org>
To:     w@1wt.eu
Cc:     thomas@t-8ch.de, arnd@arndb.de, falcon@tinylab.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v1 02/17] selftests/nolibc: gettid: restore for glibc and musl
Date:   Wed, 21 Jun 2023 20:54:53 +0800
Message-Id: <7268483c95af54c95c1da6fd5d6d0d08c1be2392.1687344643.git.falcon@tinylab.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1687344643.git.falcon@tinylab.org>
References: <cover.1687344643.git.falcon@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrsz:qybglogicsvrsz3a-3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
index 99afec93dfae..739c9daa91b6 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -548,6 +548,7 @@ int run_syscall(int min, int max)
 	int tmp;
 	int ret = 0;
 	void *p1, *p2;
+	int has_gettid = 1;
 
 	/* <proc> indicates whether or not /proc is mounted */
 	proc = stat("/proc", &stat_buf) == 0;
@@ -555,6 +556,11 @@ int run_syscall(int min, int max)
 	/* this will be used to skip certain tests that can't be run unprivileged */
 	euid0 = geteuid() == 0;
 
+	/* from 2.30, glibc provides gettid() */
+#if defined(__GLIBC_MINOR__) && defined(__GLIBC__)
+	has_gettid = __GLIBC__ > 2 || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 30);
+#endif
+
 	for (test = min; test >= 0 && test <= max; test++) {
 		int llen = 0; /* line length */
 
@@ -564,9 +570,7 @@ int run_syscall(int min, int max)
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

