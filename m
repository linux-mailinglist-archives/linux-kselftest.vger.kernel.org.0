Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253AB6E33D8
	for <lists+linux-kselftest@lfdr.de>; Sat, 15 Apr 2023 23:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjDOV2x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 15 Apr 2023 17:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbjDOV2w (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 15 Apr 2023 17:28:52 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615AA30C3;
        Sat, 15 Apr 2023 14:28:50 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1681594128;
        bh=Serav5NsrGD7AG0O6Mn+YtgEHgPcj/qioSXyB4VmbSc=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Snq8rnmGEhznB84w1h1GMX2CCLnPQiQYZsr7CzHsiLIF0csWLWmOE5ELA15vljlvC
         s46bmjPStN3vU9wE2zoXbsvn8jXtSdqRvPv8bz/7Wzn1It6pIsB8hDZSumyA7CR067
         HSfD1ctfwSw8qR5Krd7KchDszRkk2CAawuIgB+7g=
Date:   Sat, 15 Apr 2023 23:28:48 +0200
Subject: [PATCH 2/2] tools/nolibc: add testcase for fork()/waitpid()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230415-nolibc-fork-v1-2-9747c73651c5@weissschuh.net>
References: <20230415-nolibc-fork-v1-0-9747c73651c5@weissschuh.net>
In-Reply-To: <20230415-nolibc-fork-v1-0-9747c73651c5@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681594127; l=1787;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Serav5NsrGD7AG0O6Mn+YtgEHgPcj/qioSXyB4VmbSc=;
 b=CpgzObVEN4lDAf4txDLUIMfLrZ7bQE/nT95ucHYkuVj5n26guKfZ+O3iP0qg8Ub9+Ilj6WS7g
 cpuzD12N0V7C5TkrMonxcca/bN3j+hm4BHn81dgd4x4FEoZOr1noMTW
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On s390 the arguments to clone() which is used by fork() are different
than other archs.
Make sure everything works correctly.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index 888da60eb5ba..d294338cf141 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -474,6 +474,25 @@ static int test_getpagesize(void)
 	return !c;
 }
 
+static int test_fork(void)
+{
+	int status;
+	pid_t pid = fork();
+
+	switch (pid) {
+	case -1:
+		return 1;
+
+	case 0:
+		exit(123);
+
+	default:
+		pid = waitpid(pid, &status, 0);
+
+		return pid == -1 || !WIFEXITED(status) || WEXITSTATUS(status) != 123;
+	}
+}
+
 /* Run syscall tests between IDs <min> and <max>.
  * Return 0 on success, non-zero on failure.
  */
@@ -530,6 +549,7 @@ int run_syscall(int min, int max)
 		CASE_TEST(dup3_0);            tmp = dup3(0, 100, 0);  EXPECT_SYSNE(1, tmp, -1); close(tmp); break;
 		CASE_TEST(dup3_m1);           tmp = dup3(-1, 100, 0); EXPECT_SYSER(1, tmp, -1, EBADF); if (tmp != -1) close(tmp); break;
 		CASE_TEST(execve_root);       EXPECT_SYSER(1, execve("/", (char*[]){ [0] = "/", [1] = NULL }, NULL), -1, EACCES); break;
+		CASE_TEST(fork);              EXPECT_SYSZR(1, test_fork()); break;
 		CASE_TEST(getdents64_root);   EXPECT_SYSNE(1, test_getdents64("/"), -1); break;
 		CASE_TEST(getdents64_null);   EXPECT_SYSER(1, test_getdents64("/dev/null"), -1, ENOTDIR); break;
 		CASE_TEST(gettimeofday_null); EXPECT_SYSZR(1, gettimeofday(NULL, NULL)); break;

-- 
2.40.0

