Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D2396D98C8
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Apr 2023 15:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbjDFN5u (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Apr 2023 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238843AbjDFN5s (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Apr 2023 09:57:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A61A9775;
        Thu,  6 Apr 2023 06:57:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50E6264827;
        Thu,  6 Apr 2023 13:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F19AC433A4;
        Thu,  6 Apr 2023 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680789443;
        bh=ytJn4w5Dy5SWLa0FnByQtdiXEcdwmqHMOCYVqkoHY8M=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=IJcZ4F1xjaQ4Y8Cse4s6lD4Fs/8+l9oFFrg4IWSplJzD5fDpXHw38gkJNZcoYgy2m
         KxnbKunAaNfykgVwfk7oenBAJ3tVS4CvhZB2G3YJWnSIhD25BjU0AwRpKrDt2cfqzl
         IpO5EbtT2d2k3k9ndhhPzHVsfHix9nIeXQ3IinQiSmgBqIKftv6JD2FVsVcQU+hXsS
         NyQs+Nij+CD1V2BNwoE3OUW/QoN5ziH/3SWf+nSo7xEuOFAtw2KvkTPc11WdY/4bMJ
         S2x49NlI7KdN3KnjBFdzJPGa0nIKpUIByBb+hqeV6J5t6/y82NCV6Bkj7UH4wZhmQ3
         CdFuQzQ6FGmsg==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 06 Apr 2023 14:56:30 +0100
Subject: [PATCH 2/2] kselftest/arm64: Convert za-fork to use kselftest.h
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230405-kselftest-nolibc-v1-2-63fbcd70b202@kernel.org>
References: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
In-Reply-To: <20230405-kselftest-nolibc-v1-0-63fbcd70b202@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-00303
X-Developer-Signature: v=1; a=openpgp-sha256; l=5178; i=broonie@kernel.org;
 h=from:subject:message-id; bh=ytJn4w5Dy5SWLa0FnByQtdiXEcdwmqHMOCYVqkoHY8M=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkLs+80yzLeyGUhQXPJmaYoxHF1c5gwAnwwLgvREBL
 QLj2zJCJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZC7PvAAKCRAk1otyXVSH0MaiB/
 9GqQ45Q2obhNcd6abvqwjxt292Y9OnTQjQAbChlA/DhCQuwldDpml2LncJHCUVlYC7vkLkP8gYktcy
 3aLR1l8sZjDhZez0DEMq6coFfwjkyBx04gTI6oT4wmcDdxgsY3lpJH/bm3dPrBw+R0CutOhRM1PMMb
 Jazidq5KMzV84HbR7bfohl6FBOpAzpt6zLlIBFdL1nsgZqKwB7WbaxsN9NIfnf8BbJnbAHCKfMh80a
 s7F3cRhKbgL8p9dihTUApdIsGfvfuXMiZUEG4w6gMN0Gb+LLFDuaP0kb2CLZyHbQtBwm+8CPnU/z9N
 zuCKHjGpoB1nLU5BZwesCzluYSsYfW
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Now that kselftest.h can be used with nolibc convert the za-fork test to
use it. We do still have to open code ksft_print_msg() but that's not the
end of the world. Some of the advantage comes from using printf() which we
could have been using already.

This does change the output when tests are skipped, bringing it in line
with the standard kselftest output by removing the test name - we move
from

    ok 0 skipped

to

    ok 1 # SKIP fork_test

The old output was not following KTAP format for skips, and the
numbering was not standard or consistent with the reported plan.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile  |  2 +-
 tools/testing/selftests/arm64/fp/za-fork.c | 88 ++++++------------------------
 2 files changed, 17 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 48f56c86ad45..b413b0af07f9 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -38,7 +38,7 @@ $(OUTPUT)/vec-syscfg: vec-syscfg.c $(OUTPUT)/rdvl.o
 $(OUTPUT)/vlset: vlset.c
 $(OUTPUT)/za-fork: za-fork.c $(OUTPUT)/za-fork-asm.o
 	$(CC) -fno-asynchronous-unwind-tables -fno-ident -s -Os -nostdlib \
-		-include ../../../../include/nolibc/nolibc.h \
+		-include ../../../../include/nolibc/nolibc.h -I../..\
 		-static -ffreestanding -Wall $^ -o $@
 $(OUTPUT)/za-ptrace: za-ptrace.c
 $(OUTPUT)/za-test: za-test.S $(OUTPUT)/asm-utils.o
diff --git a/tools/testing/selftests/arm64/fp/za-fork.c b/tools/testing/selftests/arm64/fp/za-fork.c
index ff475c649e96..3acd5621e468 100644
--- a/tools/testing/selftests/arm64/fp/za-fork.c
+++ b/tools/testing/selftests/arm64/fp/za-fork.c
@@ -9,42 +9,9 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 
-#define EXPECTED_TESTS 1
-
-static void putstr(const char *str)
-{
-	write(1, str, strlen(str));
-}
-
-static void putnum(unsigned int num)
-{
-	char c;
-
-	if (num / 10)
-		putnum(num / 10);
-
-	c = '0' + (num % 10);
-	write(1, &c, 1);
-}
+#include "kselftest.h"
 
-static int tests_run;
-static int tests_passed;
-static int tests_failed;
-static int tests_skipped;
-
-static void print_summary(void)
-{
-	if (tests_passed + tests_failed + tests_skipped != EXPECTED_TESTS)
-		putstr("# UNEXPECTED TEST COUNT: ");
-
-	putstr("# Totals: pass:");
-	putnum(tests_passed);
-	putstr(" fail:");
-	putnum(tests_failed);
-	putstr(" xfail:0 xpass:0 skip:");
-	putnum(tests_skipped);
-	putstr(" error:0\n");
-}
+#define EXPECTED_TESTS 1
 
 int fork_test(void);
 int verify_fork(void);
@@ -63,22 +30,21 @@ int fork_test_c(void)
 	if (newpid == 0) {
 		/* In child */
 		if (!verify_fork()) {
-			putstr("# ZA state invalid in child\n");
+			ksft_print_msg("ZA state invalid in child\n");
 			exit(0);
 		} else {
 			exit(1);
 		}
 	}
 	if (newpid < 0) {
-		putstr("# fork() failed: -");
-		putnum(-newpid);
-		putstr("\n");
+		printf("# fork() failed: %d\n", newpid);
+
 		return 0;
 	}
 
 	parent_result = verify_fork();
 	if (!parent_result)
-		putstr("# ZA state invalid in parent\n");
+		ksft_print_msg("ZA state invalid in parent\n");
 
 	for (;;) {
 		waiting = waitpid(newpid, &child_status, 0);
@@ -86,18 +52,16 @@ int fork_test_c(void)
 		if (waiting < 0) {
 			if (errno == EINTR)
 				continue;
-			putstr("# waitpid() failed: ");
-			putnum(errno);
-			putstr("\n");
+			printf("# waitpid() failed: %d\n", errno);
 			return 0;
 		}
 		if (waiting != newpid) {
-			putstr("# waitpid() returned wrong PID\n");
+			printf("# waitpid() returned wrong PID\n");
 			return 0;
 		}
 
 		if (!WIFEXITED(child_status)) {
-			putstr("# child did not exit\n");
+			printf("# child did not exit\n");
 			return 0;
 		}
 
@@ -105,29 +69,14 @@ int fork_test_c(void)
 	}
 }
 
-#define run_test(name)			     \
-	if (name()) {			     \
-		tests_passed++;		     \
-	} else {			     \
-		tests_failed++;		     \
-		putstr("not ");		     \
-	}				     \
-	putstr("ok ");			     \
-	putnum(++tests_run);		     \
-	putstr(" " #name "\n");
-
 int main(int argc, char **argv)
 {
 	int ret, i;
 
-	putstr("TAP version 13\n");
-	putstr("1..");
-	putnum(EXPECTED_TESTS);
-	putstr("\n");
+	ksft_print_header();
+	ksft_set_plan(EXPECTED_TESTS);
 
-	putstr("# PID: ");
-	putnum(getpid());
-	putstr("\n");
+	printf("# PID: %d\n", getpid());
 
 	/*
 	 * This test is run with nolibc which doesn't support hwcap and
@@ -136,21 +85,16 @@ int main(int argc, char **argv)
 	 */
 	ret = open("/proc/sys/abi/sme_default_vector_length", O_RDONLY, 0);
 	if (ret >= 0) {
-		run_test(fork_test);
+		ksft_test_result(fork_test(), "fork_test");
 
 	} else {
-		putstr("# SME support not present\n");
-
+		ksft_print_msg("SME not supported\n");
 		for (i = 0; i < EXPECTED_TESTS; i++) {
-			putstr("ok ");
-			putnum(i);
-			putstr(" skipped\n");
+			ksft_test_result_skip("fork_test\n");
 		}
-
-		tests_skipped += EXPECTED_TESTS;
 	}
 
-	print_summary();
+	ksft_finished();
 
 	return 0;
 }

-- 
2.30.2

