Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 686AB6615A1
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:59:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbjAHN7p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:59:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbjAHN72 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:59:28 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDC5DEAB;
        Sun,  8 Jan 2023 05:59:21 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id 1CD0A7E6EE;
        Sun,  8 Jan 2023 13:59:17 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673186360;
        bh=FDH1SiFwyTAYw73kTXZ3LWXEORDAq51IpBI/AfSBiCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NpytHYUzml+I6lOZoeqsb+qnJPvs010A+G1N2Z9l8NpQYtjmmimkeEjDJP25fuWTQ
         zox777FEhhiFuYO4tuPBCojzPKsK8J9abdl29cNZBvhfCwGEVf2TMtV1r7tE6YI1p1
         AkB8EbBJ34fFK3w0z+kKCKGQRBIUB3X6vwCqScP8GvMZqZOt3xD1NFYcv+pli4DSGd
         anXffvFKretW9siunjzWXt+Wl1vg/NctDdzOI9ViOAPUbiqOlPAZ9u7lDLrGYmmdbo
         pom3VPP3fyGLnM/zO/qVnoiBnqe4pA+m95u/r6L9PlWW9wqsxCSjfGsc88U2FdSvFS
         ngQzUaHwBUckQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [PATCH v3 3/5] selftests/nolibc: Add `fork(2)` selftest
Date:   Sun,  8 Jan 2023 20:59:02 +0700
Message-Id: <20230108135904.851762-4-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108135904.851762-1-ammar.faizi@intel.com>
References: <20230108135904.851762-1-ammar.faizi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

Ensure the fork() function can create a child process. Also, when the
child exits, the parent must be able to get the child's exit code
via waitpid().

Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 45 ++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 3a78399f4624..cb6ec9f71aae 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -471,6 +471,50 @@ static int test_getpagesize(void)
 	return !c;
 }
 
+/*
+ * Test fork().
+ * Make sure the exit code can be read from the parent process.
+ */
+static int test_fork_and_exit(int expected_code)
+{
+	int status;
+	int code;
+	pid_t ret;
+	pid_t p;
+
+	p = fork();
+	if (p < 0)
+		return p;
+
+	if (!p)
+		exit(expected_code);
+
+	do {
+		ret = waitpid(p, &status, 0);
+		if (ret < 0)
+			return ret;
+	} while (!WIFEXITED(status));
+
+	code = WEXITSTATUS(status);
+	if (code != expected_code) {
+		printf("test_fork_and_exit(): waitpid(): Invalid exit code: %d; expected = %d\n", code, expected_code);
+		return -1;
+	}
+
+	return 0;
+}
+
+static int test_fork(void)
+{
+	int i;
+
+	for (i = 0; i < 255; i++) {
+		if (test_fork_and_exit(i))
+			return -1;
+	}
+	return 0;
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -523,6 +567,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
 		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
 		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
+		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
-- 
Ammar Faizi

