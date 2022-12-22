Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA2F9653B10
	for <lists+linux-kselftest@lfdr.de>; Thu, 22 Dec 2022 04:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbiLVDwn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 21 Dec 2022 22:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbiLVDwm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 21 Dec 2022 22:52:42 -0500
Received: from gnuweeb.org (gnuweeb.org [51.81.211.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1444186A6;
        Wed, 21 Dec 2022 19:52:38 -0800 (PST)
Received: from localhost.localdomain (unknown [182.253.88.132])
        by gnuweeb.org (Postfix) with ESMTPSA id 7729A81A0D;
        Thu, 22 Dec 2022 03:52:34 +0000 (UTC)
X-GW-Data: lPqxHiMPbJw1wb7CM9QUryAGzr0yq5atzVDdxTR0iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
        s=default; t=1671681158;
        bh=7CHYFJ/fWvU3HmqUeRZ+VXRA4YRaz7Sx/PWqqaM5V34=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAr/7wyrio6E1/EaQ1M1rE1/PZVifyMfZI3ucHwy85zJYky5RY12Y+9aiE2RZw231
         2feH9uuKuOWyZtteCOwapCVVLvuI4pfaxx2SkRugm8I2vXxfldLaoNWw+0XK7I1jR8
         WGpOhumr90RujdFpnWDTg6xszQEaQaHGqRnSnAqZHgHESJJVTy609MpkLkvRcTjRaT
         0WyC50LXJ7FYc1kIqOh+TvotowI7B1E/wMGdqKj5834q4SSpEfpOerJV+oL29Dx9f/
         ZD1OA4+Qo5fMOmSUs9Uaq5Tkzt7AU8tzmBWfll7ppSBNLmC3pPG0vMs4oqmscV4dtN
         FRcqZfbRnochQ==
From:   Ammar Faizi <ammarfaizi2@gnuweeb.org>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Gilang Fachrezy <gilang4321@gmail.com>,
        VNLX Kernel Department <kernel@vnlx.org>,
        Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
        Kanna Scarlet <knscarlet@gnuweeb.org>,
        Muhammad Rizki <kiizuha@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kselftest Mailing List 
        <linux-kselftest@vger.kernel.org>
Subject: [RFC PATCH v1 5/8] selftests/nolibc: Add `fork(2)` selftest
Date:   Thu, 22 Dec 2022 10:51:31 +0700
Message-Id: <20221222035134.3467659-6-ammar.faizi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221222035134.3467659-1-ammar.faizi@intel.com>
References: <20221222035134.3467659-1-ammar.faizi@intel.com>
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
index 8d69f8a0f35a..309cabbddeec 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -442,6 +442,50 @@ int test_getdents64(const char *dir)
 	return ret;
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
@@ -494,6 +538,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
 		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
 		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
+		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;
-- 
Ammar Faizi

