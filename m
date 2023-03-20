Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C626C1A49
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Mar 2023 16:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjCTPub (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 20 Mar 2023 11:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbjCTPts (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 20 Mar 2023 11:49:48 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05ADB2FCEC;
        Mon, 20 Mar 2023 08:41:24 -0700 (PDT)
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1679326882;
        bh=JyOrsnSClXzOy2qb2h3WcW0lX0xzEzpyA/yocZM6rxk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=ATWiycxwuKiBrIWlMK6qq40IkPG4fH++buyOoo6EGOYoFOtSIGAzoZsAqXb+2dGJQ
         ZEsaZVM8N7TMR8AO7nan8A8YlRSv4SuFmUL/dpDSXCBUDA7W2CYyCUYR8urCh5DKeO
         //bGbQYqU1BLQYufbCKrxNIL1vihCbzzHJHDHQpo=
Date:   Mon, 20 Mar 2023 15:41:06 +0000
Subject: [PATCH v2 6/8] tools/nolibc: tests: add test for -fstack-protector
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230223-nolibc-stackprotector-v2-6-4c938e098d67@weissschuh.net>
References: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
In-Reply-To: <20230223-nolibc-stackprotector-v2-0-4c938e098d67@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679326878; l=2836;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JyOrsnSClXzOy2qb2h3WcW0lX0xzEzpyA/yocZM6rxk=;
 b=a8YNdJ/4b1JkbNuPWAJxJ2gYEKeTzYJ/KBfT3JFHFpkMiK7scEvSx+YJxAFnH7vcPBtu7lnN1
 1oEQfg/daTYBQT1LG3XdxgmNwz9NXGeuhjVPrKHGPlSaeDbU9zJpMMv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test the previously introduce stack protector functionality in nolibc.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile      |  3 ++
 tools/testing/selftests/nolibc/nolibc-test.c | 62 +++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 236c0364f5fb..b4f818547f35 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -76,6 +76,9 @@ else
 Q=@
 endif
 
+CFLAGS_STACKPROTECTOR = -DNOLIBC_STACKPROTECTOR \
+			$(call cc-option,-mstack-protector-guard=global) \
+			$(call cc-option,-fstack-protector-all)
 CFLAGS_s390 = -m64
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables \
 		$(call cc-option,-fno-stack-protector) \
diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
index fb2d4872fac9..21bacc928bf7 100644
--- a/tools/testing/selftests/nolibc/nolibc-test.c
+++ b/tools/testing/selftests/nolibc/nolibc-test.c
@@ -667,6 +667,63 @@ int run_stdlib(int min, int max)
 	return ret;
 }
 
+#if defined(__clang__)
+__attribute__((optnone))
+#elif defined(__GNUC__)
+__attribute__((optimize("O0")))
+#endif
+static int smash_stack(void)
+{
+	char buf[100];
+
+	for (size_t i = 0; i < 200; i++)
+		buf[i] = 'P';
+
+	return 1;
+}
+
+static int run_protection(int min, int max)
+{
+	pid_t pid;
+	int llen = 0, status;
+
+	llen += printf("0 -fstackprotector ");
+
+#if !defined(NOLIBC_STACKPROTECTOR)
+	llen += printf("not supported");
+	pad_spc(llen, 64, "[SKIPPED]\n");
+	return 0;
+#endif
+
+	pid = -1;
+	pid = fork();
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
+		smash_stack();
+		return 1;
+
+	default:
+		pid = waitpid(pid, &status, 0);
+
+		if (pid == -1 || !WIFSIGNALED(status) || WTERMSIG(status) != SIGABRT) {
+			llen += printf("waitpid()");
+			pad_spc(llen, 64, "[FAIL]\n");
+			return 1;
+		}
+		pad_spc(llen, 64, " [OK]\n");
+		return 0;
+	}
+}
+
 /* prepare what needs to be prepared for pid 1 (stdio, /dev, /proc, etc) */
 int prepare(void)
 {
@@ -719,8 +776,9 @@ int prepare(void)
 /* This is the definition of known test names, with their functions */
 static const struct test test_names[] = {
 	/* add new tests here */
-	{ .name = "syscall",   .func = run_syscall  },
-	{ .name = "stdlib",    .func = run_stdlib   },
+	{ .name = "syscall",    .func = run_syscall    },
+	{ .name = "stdlib",     .func = run_stdlib     },
+	{ .name = "protection", .func = run_protection },
 	{ 0 }
 };
 

-- 
2.40.0

