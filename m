Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED3A661569
	for <lists+linux-kselftest@lfdr.de>; Sun,  8 Jan 2023 14:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235364AbjAHNLL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 8 Jan 2023 08:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234817AbjAHNLE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 8 Jan 2023 08:11:04 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DB4F038;
        Sun,  8 Jan 2023 05:10:56 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.183.184])
        by gnuweeb.org (Postfix) with ESMTPSA id EC04B7E608;
        Sun,  8 Jan 2023 13:10:52 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1673183455;
        bh=FDH1SiFwyTAYw73kTXZ3LWXEORDAq51IpBI/AfSBiCw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHCB4Wa03U16A5et4qHAdqJlgi4ONmQjmrLdiT8BZTB5JQllKYVsN+eHqzlwLs1FQ
         j90XgXpG1Y1tnigshdVDUStKwdMSe/gg45D/RS69c8b5sLjqEz5DuuF8c5Syd+1fwI
         PAGMf9X+KSQmAcrX2mDcSSTk5epyFly4HuT76WbzPJIB81IXv9agIUJuZ+PwI3op73
         20I/e6Uq60Lfu1/Hlvh4/Oret0lRF/c7BGN4vb58+qRN+Sys4gsOVkbQbp+cjr5jTY
         5W3pqypaRVgzTQMbZPkQ/Ggq67YYlRXhRbCUwZhrnNMm6XxNbPdZZ+6xKhb7ieU/ax
         NL2T+VEk4a+uw==
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
Subject: [PATCH v2 3/4] selftests/nolibc: Add `fork(2)` selftest
Date:   Sun,  8 Jan 2023 20:10:37 +0700
Message-Id: <20230108131038.841204-4-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230108131038.841204-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com> <20221222043452.GB29086@1wt.eu> <20221222134615.3535422-1-ammar.faizi@intel.com> <20221227062640.GA5337@1wt.eu> <00eee75f-59fa-83b2-c7e1-f0da347b2dde@gnuweeb.org> <20221227184902.GA6287@1wt.eu> <23e84c59-4f2c-01b4-5b8a-80af39a1d761@gnuweeb.org> <20221228133513.GA7457@1wt.eu> <39d68044-2641-75da-929a-f5e852f0a3d0@gnuweeb.org> <CAOG64qOT6wa+ShCuV3wM0QYy6TBOYap8xoAbUBU5DM_bhdafYg@mail.gmail.com> <20230103035427.GA4474@1wt.eu> <086ff43d-2647-0459-d993-6fc90d7ae779@gnuweeb.org>
 <20230108131038.841204-1-ammar.faizi@intel.com>
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

