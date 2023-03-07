Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F4D96AF88C
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Mar 2023 23:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjCGWXh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Mar 2023 17:23:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbjCGWXD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Mar 2023 17:23:03 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB2D18B0F;
        Tue,  7 Mar 2023 14:22:58 -0800 (PST)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1678227764;
        bh=wMlMqNF3HdsYBhiMwlY00yIFmFgEItJMu93P1cpiTpQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=NmpjSn5YwfoF1abfuFJijYMNNRIa0mx8eQEZFvBSGeYztxwiE/Me+n99EAMrGX6Fv
         gI1qjXLVit3g103iTC5gfOKWsqCRtT/gKQV1Ml8vy3OQvmxwWySaLKhbaErh/KC1cF
         ugjQwa6WJ922MDTuy/bSkVZbcNw3QEdg4L2f8dwI=
Date:   Tue, 07 Mar 2023 22:22:34 +0000
Subject: [PATCH RFC 5/5] tools/nolibc: tests: add test for
 -fstack-protector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v1-5-3e74d81b3f21@weissschuh.net>
References: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v1-0-3e74d81b3f21@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678227756; l=3131;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wMlMqNF3HdsYBhiMwlY00yIFmFgEItJMu93P1cpiTpQ=;
 b=LUG3ujBuABS0LQOJZ/EC+fRvBT+VCTd8tKxSAkaQ/VV8PiWPHofAfK/UB+9qTeTgG+SngI5BU
 Cn6xoSswl9+COeeKYUc6FbOjZ2q/+j/slBLKz6tcRU8R8JIdpFwXD5W
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

Test the previously introduce stack protector functionality in nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/nolibc-test.c | 74 +++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index fb2d4872fac9..4990b2750279 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -45,6 +45,7 @@ char **environ;
 struct test {
 	const char *name;              // test name
 	int (*func)(int min, int max); // handler
+	char skip_by_default;         // don't run by default
 };
 
 #ifndef _NOLIBC_STDLIB_H
@@ -667,6 +668,70 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
+#if defined(__clang__)
+__attribute__((optnone))
+#elif defined(__GNUC__)
+__attribute__((optimize("O0")))
+#endif
+static int run_smash_stack(int min, int max)
+{
+	char buf[100];
+
+	for (size_t i = 0; i < 200; i++)
+		buf[i] = 15;
+
+	return 1;
+}
+
+int run_stackprotector(int min, int max)
+{
+	int llen = 0;
+
+	llen += printf("0 ");
+
+#if !defined(NOLIBC_STACKPROTECTOR)
+	llen += printf("stack smashing detection not supported");
+	pad_spc(llen, 64, "[SKIPPED]\n");
+	return 0;
+#endif
+
+	pid_t pid = fork();
+
+	switch (pid) {
+	case -1:
+		llen += printf("fork()");
+		pad_spc(llen, 64, "[FAIL]\n");
+		return 1;
+
+	case 0:
+		close(STDOUT_FILENO);
+		close(STDERR_FILENO);
+
+		char *const argv[] = {
+			"/proc/self/exe",
+			"_smash_stack",
+			NULL,
+		};
+		execve("/proc/self/exe", argv, NULL);
+		return 1;
+
+	default: {
+		int status;
+
+		pid = waitpid(pid, &status, 0);
+
+		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
+			llen += printf("waitpid()");
+			pad_spc(llen, 64, "[FAIL]\n");
+			return 1;
+		}
+		llen += printf("stack smashing detected");
+		pad_spc(llen, 64, " [OK]\n");
+		return 0;
+	}
+	}
+}
+
 /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
 int prepare(void)
 {
@@ -719,8 +784,11 @@ int prepare(void)
 /* This is the definition of known test names, with their functions */
 static const struct test test_names[] = {
 	/* add new tests here */
-	{ .name = "syscall",   .func = run_syscall  },
-	{ .name = "stdlib",    .func = run_stdlib   },
+	{ .name = "syscall",        .func = run_syscall         },
+	{ .name = "stdlib",         .func = run_stdlib          },
+	{ .name = "stackprotector", .func = run_stackprotector, },
+	{ .name = "_smash_stack",   .func = run_smash_stack,
+	  .skip_by_default = 1                                  },
 	{ 0 }
 };
 
@@ -811,6 +879,8 @@ int main(int argc, char **argv, char **envp)
 	} else {
 		/* no test mentioned, run everything */
 		for (idx = 0; test_names[idx].name; idx++) {
+			if (test_names[idx].skip_by_default)
+				continue;
 			printf("Running test '%s'\n", test_names[idx].name);
 			err = test_names[idx].func(min, max);
 			ret += err;

-- 
2.39.2

