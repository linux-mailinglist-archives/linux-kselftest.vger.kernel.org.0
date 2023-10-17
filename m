Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AD17CD02E
	for <lists+linux-kselftest@lfdr.de>; Wed, 18 Oct 2023 01:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJQXCO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 17 Oct 2023 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235038AbjJQXCM (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 17 Oct 2023 19:02:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D91119;
        Tue, 17 Oct 2023 16:02:09 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F511C433C8;
        Tue, 17 Oct 2023 23:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697583728;
        bh=08Z7nfsNuUeGcZqJevhbDVWfnyFzmgKni4CQnDVUlWE=;
        h=From:Date:Subject:To:Cc:From;
        b=MpBpXvBRPsYNsSdXre9jY3VKJaIqz+umB0rmjNmBopI9FgEUOTyapIDf/o9tBNfvH
         5o/ZXk5HhhDr0VfLFf122yFAW+/JZZbDsrBEWsI1JqZsdxzEKKQCk2zaWrlbtjxYJ+
         U74sx+tJX/bl1yeVzbEEvSDfOl4U0fFl2LGEcO1VtISNJwyY+LPFqd2pvndNeOuQmI
         zWS6CXSsnFiJljv5QVPBt3d13XcXNQS5XjBfmkX+c/3QiZ5rVJJlyb0gKXsW8DRVid
         B9958LzqoIwpr1WB8lh/by9byC/CEuCJ8svN5Q9SoTCJaKKlqAYzWcdnuODHKWEjkl
         hiEl7ZTJ/S1dg==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 18 Oct 2023 00:01:56 +0100
Subject: [PATCH] selftests/clone3: Report descriptive test names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231018-kselftest-clone3-output-v1-1-12b7c50ea2cf@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGMSL2UC/x3MQQqDMBBG4avIrDtgomjxKtJFo786VBLJxCKId
 ze4/BbvnaSIAqWuOCniLyrBZ5hXQcPy9TNYxmyypa1MaVr+KdYpQRMPa/CoOOxp2xO3eLumbqw
 bjaNcbxGTHM+5/1zXDbjttx9pAAAA
To:     Christian Brauner <brauner@kernel.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-0438c
X-Developer-Signature: v=1; a=openpgp-sha256; l=10722; i=broonie@kernel.org;
 h=from:subject:message-id; bh=08Z7nfsNuUeGcZqJevhbDVWfnyFzmgKni4CQnDVUlWE=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlLxJuD9cdI9dJO3/6fxga8NFfD+cuYtVTpIPpktlO
 MTe3p3+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZS8SbgAKCRAk1otyXVSH0Ev4B/
 482LyXZkFlSPGw4LPM886+T7oIf4xwjFY3HgH2vVSINf9YBzTDtM2FwUSZLI0Cca2ojJ5obM2yAkid
 65taxBdS6x+O1CabS+X4HNJIRZ6I6J2U1wOc2WrZ4mHecNvmtnftuZT8gMeWF9uU+mLYyKHOk6YOAk
 qq/mdvvl0GrXkxeaF7WzVvz9j0AAW90nRGKO6YmiEl6btXT/V1HzOZqaMpFJVxNKeQbtfGuVuSzxCO
 1jLcZuX4zdAw/nK7U+Q+HPuPCB3lIncJ+V+e7ttKCZdm+vHavntzbJAZ2CrtYjnC43uTxD+ur4hFPD
 D/Wv5pbhtXiXiYuF3ygb8WsodIC0Zi
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The clone3() selftests currently report test results in a format that does
not mesh entirely well with automation. They log output for each test such
as:

  # [1382411] Trying clone3() with flags 0 (size 0)
  # I am the parent (1382411). My child's pid is 1382412
  # I am the child, my PID is 1382412
  # [1382411] clone3() with flags says: 0 expected 0
  ok 1 [1382411] Result (0) matches expectation (0)

This is not ideal for automated parsers since the text after the "ok 1" is
treated as the test name when comparing runs by a lot of automation (tests
routinely get renumbered due to things like new tests being added based on
logical groupings). The PID means that the test names will frequently vary
and the rest of the name being a description of results means several tests
have identical text there.

Address this by refactoring things so that we have a static descriptive
name for each test which we use when logging passes, failures and skips
and since we now have a stable name for the test to hand log that before
starting the test to address the common issue reading logs where the test
name is only printed after any diagnostics. The result is:

 # Running test 'simple clone3()'
 # [1562777] Trying clone3() with flags 0 (size 0)
 # I am the parent (1562777). My child's pid is 1562778
 # I am the child, my PID is 1562778
 # [1562777] clone3() with flags says: 0 expected 0
 ok 1 simple clone3()

In order to handle skips a bit more neatly this is done in a moderately
invasive fashion where we move from a sequence of function calls to having
an array of test parameters. This hopefully also makes it a little easier
to see what the tests are doing when looking at both the source and the
logs.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/clone3/clone3.c | 265 +++++++++++++++++++++++---------
 1 file changed, 192 insertions(+), 73 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index e60cf4da8fb0..9429d361059e 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -7,6 +7,7 @@
 #include <inttypes.h>
 #include <linux/types.h>
 #include <linux/sched.h>
+#include <stdbool.h>
 #include <stdint.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -103,8 +104,8 @@ static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
 	return 0;
 }
 
-static void test_clone3(uint64_t flags, size_t size, int expected,
-		       enum test_mode test_mode)
+static bool test_clone3(uint64_t flags, size_t size, int expected,
+			enum test_mode test_mode)
 {
 	int ret;
 
@@ -114,92 +115,210 @@ static void test_clone3(uint64_t flags, size_t size, int expected,
 	ret = call_clone3(flags, size, test_mode);
 	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
 			getpid(), ret, expected);
-	if (ret != expected)
-		ksft_test_result_fail(
+	if (ret != expected) {
+		ksft_print_msg(
 			"[%d] Result (%d) is different than expected (%d)\n",
 			getpid(), ret, expected);
-	else
-		ksft_test_result_pass(
-			"[%d] Result (%d) matches expectation (%d)\n",
-			getpid(), ret, expected);
-}
-
-int main(int argc, char *argv[])
-{
-	uid_t uid = getuid();
-
-	ksft_print_header();
-	ksft_set_plan(19);
-	test_clone3_supported();
-
-	/* Just a simple clone3() should return 0.*/
-	test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST);
-
-	/* Do a clone3() in a new PID NS.*/
-	if (uid == 0)
-		test_clone3(CLONE_NEWPID, 0, 0, CLONE3_ARGS_NO_TEST);
-	else
-		ksft_test_result_skip("Skipping clone3() with CLONE_NEWPID\n");
-
-	/* Do a clone3() with CLONE_ARGS_SIZE_VER0. */
-	test_clone3(0, CLONE_ARGS_SIZE_VER0, 0, CLONE3_ARGS_NO_TEST);
-
-	/* Do a clone3() with CLONE_ARGS_SIZE_VER0 - 8 */
-	test_clone3(0, CLONE_ARGS_SIZE_VER0 - 8, -EINVAL, CLONE3_ARGS_NO_TEST);
-
-	/* Do a clone3() with sizeof(struct clone_args) + 8 */
-	test_clone3(0, sizeof(struct __clone_args) + 8, 0, CLONE3_ARGS_NO_TEST);
-
-	/* Do a clone3() with exit_signal having highest 32 bits non-zero */
-	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG);
+		return false;
+	}
 
-	/* Do a clone3() with negative 32-bit exit_signal */
-	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG);
+	return true;
+}
 
-	/* Do a clone3() with exit_signal not fitting into CSIGNAL mask */
-	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG);
+typedef bool (*filter_function)(void);
+typedef size_t (*size_function)(void);
 
-	/* Do a clone3() with NSIG < exit_signal < CSIG */
-	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG);
+static bool not_root(void)
+{
+	if (getuid() != 0) {
+		ksft_print_msg("Not running as root\n");
+		return true;
+	}
 
-	test_clone3(0, sizeof(struct __clone_args) + 8, 0, CLONE3_ARGS_ALL_0);
+	return false;
+}
 
-	test_clone3(0, sizeof(struct __clone_args) + 16, -E2BIG,
-			CLONE3_ARGS_ALL_0);
+static size_t page_size_plus_8(void)
+{
+	return getpagesize() + 8;
+}
 
-	test_clone3(0, sizeof(struct __clone_args) * 2, -E2BIG,
-			CLONE3_ARGS_ALL_0);
+struct test {
+	const char *name;
+	uint64_t flags;
+	size_t size;
+	size_function size_function;
+	int expected;
+	enum test_mode test_mode;
+	filter_function filter;
+};
 
-	/* Do a clone3() with > page size */
-	test_clone3(0, getpagesize() + 8, -E2BIG, CLONE3_ARGS_NO_TEST);
+static const struct test tests[] = {
+	{
+		.name = "simple clone3()",
+		.flags = 0,
+		.size = 0,
+		.expected = 0,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+	{
+		.name = "clone3() in a new PID_NS",
+		.flags = CLONE_NEWPID,
+		.size = 0,
+		.expected = 0,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+		.filter = not_root,
+	},
+	{
+		.name = "CLONE_ARGS_SIZE_VER0",
+		.flags = 0,
+		.size = CLONE_ARGS_SIZE_VER0,
+		.expected = 0,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+	{
+		.name = "CLONE_ARGS_SIZE_VER0 - 8",
+		.flags = 0,
+		.size = CLONE_ARGS_SIZE_VER0 - 8,
+		.expected = -EINVAL,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+	{
+		.name = "sizeof(struct clone_args) + 8",
+		.flags = 0,
+		.size = sizeof(struct __clone_args) + 8,
+		.expected = 0,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+	{
+		.name = "exit_signal with highest 32 bits non-zero",
+		.flags = 0,
+		.size = 0,
+		.expected = -EINVAL,
+		.test_mode = CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG,
+	},
+	{
+		.name = "negative 32-bit exit_signal",
+		.flags = 0,
+		.size = 0,
+		.expected = -EINVAL,
+		.test_mode = CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
+	},
+	{
+		.name = "exit_signal not fitting into CSIGNAL mask",
+		.flags = 0,
+		.size = 0,
+		.expected = -EINVAL,
+		.test_mode = CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
+	},
+	{
+		.name = "NSIG < exit_signal < CSIG",
+		.flags = 0,
+		.size = 0,
+		.expected = -EINVAL,
+		.test_mode = CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
+	},
+	{
+		.name = "Arguments sizeof(struct clone_args) + 8",
+		.flags = 0,
+		.size = sizeof(struct __clone_args) + 8,
+		.expected = 0,
+		.test_mode = CLONE3_ARGS_ALL_0,
+	},
+	{
+		.name = "Arguments sizeof(struct clone_args) + 16",
+		.flags = 0,
+		.size = sizeof(struct __clone_args) + 16,
+		.expected = -E2BIG,
+		.test_mode = CLONE3_ARGS_ALL_0,
+	},
+	{
+		.name = "Arguments sizeof(struct clone_arg) * 2",
+		.flags = 0,
+		.size = sizeof(struct __clone_args) + 16,
+		.expected = -E2BIG,
+		.test_mode = CLONE3_ARGS_ALL_0,
+	},
+	{
+		.name = "Arguments > page size",
+		.flags = 0,
+		.size_function = page_size_plus_8,
+		.expected = -E2BIG,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+	{
+		.name = "CLONE_ARGS_SIZE_VER0 in a new PID NS",
+		.flags = CLONE_NEWPID,
+		.size = CLONE_ARGS_SIZE_VER0,
+		.expected = 0,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+		.filter = not_root,
+	},
+	{
+		.name = "CLONE_ARGS_SIZE_VER0 - 8 in a new PID NS",
+		.flags = CLONE_NEWPID,
+		.size = CLONE_ARGS_SIZE_VER0 - 8,
+		.expected = -EINVAL,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+	{
+		.name = "sizeof(struct clone_args) + 8 in a new PID NS",
+		.flags = CLONE_NEWPID,
+		.size = sizeof(struct __clone_args) + 8,
+		.expected = 0,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+		.filter = not_root,
+	},
+	{
+		.name = "Arguments > page size in a new PID NS",
+		.flags = CLONE_NEWPID,
+		.size_function = page_size_plus_8,
+		.expected = -E2BIG,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+	{
+		.name = "New time NS",
+		.flags = CLONE_NEWTIME,
+		.size = 0,
+		.expected = 0,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+	{
+		.name = "exit signal (SIGCHLD) in flags",
+		.flags = SIGCHLD,
+		.size = 0,
+		.expected = -EINVAL,
+		.test_mode = CLONE3_ARGS_NO_TEST,
+	},
+};
 
-	/* Do a clone3() with CLONE_ARGS_SIZE_VER0 in a new PID NS. */
-	if (uid == 0)
-		test_clone3(CLONE_NEWPID, CLONE_ARGS_SIZE_VER0, 0,
-				CLONE3_ARGS_NO_TEST);
-	else
-		ksft_test_result_skip("Skipping clone3() with CLONE_NEWPID\n");
+int main(int argc, char *argv[])
+{
+	size_t size;
+	int i;
 
-	/* Do a clone3() with CLONE_ARGS_SIZE_VER0 - 8 in a new PID NS */
-	test_clone3(CLONE_NEWPID, CLONE_ARGS_SIZE_VER0 - 8, -EINVAL,
-			CLONE3_ARGS_NO_TEST);
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(tests));
+	test_clone3_supported();
 
-	/* Do a clone3() with sizeof(struct clone_args) + 8 in a new PID NS */
-	if (uid == 0)
-		test_clone3(CLONE_NEWPID, sizeof(struct __clone_args) + 8, 0,
-				CLONE3_ARGS_NO_TEST);
-	else
-		ksft_test_result_skip("Skipping clone3() with CLONE_NEWPID\n");
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (tests[i].filter && tests[i].filter()) {
+			ksft_test_result_skip("%s\n", tests[i].name);
+			continue;
+		}
 
-	/* Do a clone3() with > page size in a new PID NS */
-	test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
-			CLONE3_ARGS_NO_TEST);
+		if (tests[i].size_function)
+			size = tests[i].size_function();
+		else
+			size = tests[i].size;
 
-	/* Do a clone3() in a new time namespace */
-	test_clone3(CLONE_NEWTIME, 0, 0, CLONE3_ARGS_NO_TEST);
+		ksft_print_msg("Running test '%s'\n", tests[i].name);
 
-	/* Do a clone3() with exit signal (SIGCHLD) in flags */
-	test_clone3(SIGCHLD, 0, -EINVAL, CLONE3_ARGS_NO_TEST);
+		ksft_test_result(test_clone3(tests[i].flags, size,
+					     tests[i].expected,
+					     tests[i].test_mode),
+				 "%s\n", tests[i].name);
+	}
 
 	ksft_finished();
 }

---
base-commit: 6465e260f48790807eef06b583b38ca9789b6072
change-id: 20231017-kselftest-clone3-output-7e8b6462bd1b

Best regards,
-- 
Mark Brown <broonie@kernel.org>

