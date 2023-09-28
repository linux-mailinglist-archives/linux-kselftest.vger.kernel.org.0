Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737637B1FDB
	for <lists+linux-kselftest@lfdr.de>; Thu, 28 Sep 2023 16:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230270AbjI1Oid (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 28 Sep 2023 10:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjI1Oia (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 28 Sep 2023 10:38:30 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EAA19E;
        Thu, 28 Sep 2023 07:38:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77B60C433C7;
        Thu, 28 Sep 2023 14:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695911907;
        bh=sOssdkEDOu+oIP+T5MSwmPgEXystV1oGz6QEO2yuBlw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=I97GdR3XyY/ltTQZT/rviiLJPoX0sl+qvjaUkaGpr+dt8Sx3caPcJgDF3+i9vIpUH
         UEQpU+6T7BaBloSLmoTeVB/ElkqrkI4rT8O0S2aOBMZtH5AhV/0V9o+FmK03MiC4h3
         PA39xZZ/4rE63fIM09OqrqGEtCUe46Dq0nPoBxQbfazh48cBP7KgeEFGO8u3pFBxWp
         9bkE72dqGo3LC0GFZh7GwOpWsnESK/+sFpA5K1bC75OIdrZ46ZTG8BeWp0Rwdiv7Uz
         lyba8iTWOxmCFbr9uZDNL2oolGido1i7bxn6zEbNOiG+/WRdIAWWilsi812RSpInqQ
         6du9RipFhe92w==
From:   Mark Brown <broonie@kernel.org>
Date:   Thu, 28 Sep 2023 16:38:12 +0200
Subject: [PATCH 2/2] selftests/exec: Convert execveat test to generate KTAP
 output
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-ktap-exec-v1-2-1013a2db0426@kernel.org>
References: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
In-Reply-To: <20230928-ktap-exec-v1-0-1013a2db0426@kernel.org>
To:     Shuah Khan <shuah@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-099c9
X-Developer-Signature: v=1; a=openpgp-sha256; l=7284; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sOssdkEDOu+oIP+T5MSwmPgEXystV1oGz6QEO2yuBlw=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlFY/exx+aGs0kTE5g6OXj8ApwZm43FD63znXZR
 F6AffJwc9SJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZRWP3gAKCRAk1otyXVSH
 0HwGCACBRHBT8cww7vfUB5X5v/kNEMKGqvcT34gJ7FjV5qKozSGvfJ2Lz6Ylcxqu8ri3q8WVZdQ
 K9KEzo7y+a015hv7U4cEdlokDVpd20LaQb2O5EfN0U1Ve/5eYO/481VpMMCIkBQnnipRNeP+V15
 lJrkWdwigTKGutND2V9CAwgYLDho0OG2RANWJHr14YaoowHQ1pcHOF42C2QAwNzronMhXy2YbWm
 EP2kP464BNTg4oSP9XqAWVATNoz9o1MAhxagyRAZSRkUfE2N8qwWgjPnC1/9X0z2TeWjJOkhakd
 mOUicmTdtxj2n6cYJpQnO5Yl6uDmmc0/lWERHkBRCAqjZg1e
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

Currently the execveat test does not produce KTAP output but rather a
custom format. This means that we only get a pass/fail for the suite, not
for each individual test that the suite does. Convert to using the standard
kselftest output functions which result in KTAP output being generated.

The main trick with this is that, being an exec() related test, the
program executes itself and returns specific exit codes to verify
success meaning that we need to only use the top level kselftest
header/summary functions when invoked directly rather than when run as
part of a test.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/exec/execveat.c | 87 ++++++++++++++++++++-------------
 1 file changed, 52 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/exec/execveat.c b/tools/testing/selftests/exec/execveat.c
index 67bf7254a48f..bf79d664c8e6 100644
--- a/tools/testing/selftests/exec/execveat.c
+++ b/tools/testing/selftests/exec/execveat.c
@@ -23,6 +23,9 @@
 
 #include "../kselftest.h"
 
+#define TESTS_EXPECTED 51
+#define TEST_NAME_LEN (PATH_MAX * 4)
+
 static char longpath[2 * PATH_MAX] = "";
 static char *envp[] = { "IN_TEST=yes", NULL, NULL };
 static char *argv[] = { "execveat", "99", NULL };
@@ -43,71 +46,85 @@ static int execveat_(int fd, const char *path, char **argv, char **envp,
 static int _check_execveat_fail(int fd, const char *path, int flags,
 				int expected_errno, const char *errno_str)
 {
+	char test_name[TEST_NAME_LEN];
 	int rc;
 
 	errno = 0;
-	printf("Check failure of execveat(%d, '%s', %d) with %s... ",
-		fd, path?:"(null)", flags, errno_str);
+	snprintf(test_name, sizeof(test_name),
+		 "Check failure of execveat(%d, '%s', %d) with %s",
+		 fd, path?:"(null)", flags, errno_str);
 	rc = execveat_(fd, path, argv, envp, flags);
 
 	if (rc > 0) {
-		printf("[FAIL] (unexpected success from execveat(2))\n");
+		ksft_print_msg("unexpected success from execveat(2)\n");
+		ksft_test_result_fail("%s\n", test_name);
 		return 1;
 	}
 	if (errno != expected_errno) {
-		printf("[FAIL] (expected errno %d (%s) not %d (%s)\n",
-			expected_errno, strerror(expected_errno),
-			errno, strerror(errno));
+		ksft_print_msg("expected errno %d (%s) not %d (%s)\n",
+			       expected_errno, strerror(expected_errno),
+			       errno, strerror(errno));
+		ksft_test_result_fail("%s\n", test_name);
 		return 1;
 	}
-	printf("[OK]\n");
+	ksft_test_result_pass("%s\n", test_name);
 	return 0;
 }
 
 static int check_execveat_invoked_rc(int fd, const char *path, int flags,
 				     int expected_rc, int expected_rc2)
 {
+	char test_name[TEST_NAME_LEN];
 	int status;
 	int rc;
 	pid_t child;
 	int pathlen = path ? strlen(path) : 0;
 
 	if (pathlen > 40)
-		printf("Check success of execveat(%d, '%.20s...%s', %d)... ",
-			fd, path, (path + pathlen - 20), flags);
+		snprintf(test_name, sizeof(test_name),
+			 "Check success of execveat(%d, '%.20s...%s', %d)... ",
+			 fd, path, (path + pathlen - 20), flags);
 	else
-		printf("Check success of execveat(%d, '%s', %d)... ",
-			fd, path?:"(null)", flags);
+		snprintf(test_name, sizeof(test_name),
+			 "Check success of execveat(%d, '%s', %d)... ",
+			 fd, path?:"(null)", flags);
+
 	child = fork();
 	if (child < 0) {
-		printf("[FAIL] (fork() failed)\n");
+		ksft_perror("fork() failed");
+		ksft_test_result_fail("%s\n", test_name);
 		return 1;
 	}
 	if (child == 0) {
 		/* Child: do execveat(). */
 		rc = execveat_(fd, path, argv, envp, flags);
-		printf("[FAIL]: execveat() failed, rc=%d errno=%d (%s)\n",
-			rc, errno, strerror(errno));
+		ksft_print_msg("execveat() failed, rc=%d errno=%d (%s)\n",
+			       rc, errno, strerror(errno));
+		ksft_test_result_fail("%s\n", test_name);
 		exit(1);  /* should not reach here */
 	}
 	/* Parent: wait for & check child's exit status. */
 	rc = waitpid(child, &status, 0);
 	if (rc != child) {
-		printf("[FAIL] (waitpid(%d,...) returned %d)\n", child, rc);
+		ksft_print_msg("waitpid(%d,...) returned %d\n", child, rc);
+		ksft_test_result_fail("%s\n", test_name);
 		return 1;
 	}
 	if (!WIFEXITED(status)) {
-		printf("[FAIL] (child %d did not exit cleanly, status=%08x)\n",
-			child, status);
+		ksft_print_msg("child %d did not exit cleanly, status=%08x\n",
+			       child, status);
+		ksft_test_result_fail("%s\n", test_name);
 		return 1;
 	}
 	if ((WEXITSTATUS(status) != expected_rc) &&
 	    (WEXITSTATUS(status) != expected_rc2)) {
-		printf("[FAIL] (child %d exited with %d not %d nor %d)\n",
-			child, WEXITSTATUS(status), expected_rc, expected_rc2);
+		ksft_print_msg("child %d exited with %d not %d nor %d\n",
+			       child, WEXITSTATUS(status), expected_rc,
+			       expected_rc2);
+		ksft_test_result_fail("%s\n", test_name);
 		return 1;
 	}
-	printf("[OK]\n");
+	ksft_test_result_pass("%s\n", test_name);
 	return 0;
 }
 
@@ -129,11 +146,9 @@ static int open_or_die(const char *filename, int flags)
 {
 	int fd = open(filename, flags);
 
-	if (fd < 0) {
-		printf("Failed to open '%s'; "
+	if (fd < 0)
+		ksft_exit_fail_msg("Failed to open '%s'; "
 			"check prerequisites are available\n", filename);
-		exit(1);
-	}
 	return fd;
 }
 
@@ -162,8 +177,7 @@ static int check_execveat_pathmax(int root_dfd, const char *src, int is_script)
 		char *cwd = getcwd(NULL, 0);
 
 		if (!cwd) {
-			printf("Failed to getcwd(), errno=%d (%s)\n",
-			       errno, strerror(errno));
+			ksft_perror("Failed to getcwd()");
 			return 2;
 		}
 		strcpy(longpath, cwd);
@@ -193,12 +207,12 @@ static int check_execveat_pathmax(int root_dfd, const char *src, int is_script)
 	 */
 	fd = open(longpath, O_RDONLY);
 	if (fd > 0) {
-		printf("Invoke copy of '%s' via filename of length %zu:\n",
-			src, strlen(longpath));
+		ksft_print_msg("Invoke copy of '%s' via filename of length %zu:\n",
+			       src, strlen(longpath));
 		fail += check_execveat(fd, "", AT_EMPTY_PATH);
 	} else {
-		printf("Failed to open length %zu filename, errno=%d (%s)\n",
-			strlen(longpath), errno, strerror(errno));
+		ksft_print_msg("Failed to open length %zu filename, errno=%d (%s)\n",
+			       strlen(longpath), errno, strerror(errno));
 		fail++;
 	}
 
@@ -405,28 +419,31 @@ int main(int argc, char **argv)
 		const char *in_test = getenv("IN_TEST");
 
 		if (verbose) {
-			printf("  invoked with:");
+			ksft_print_msg("invoked with:\n");
 			for (ii = 0; ii < argc; ii++)
-				printf(" [%d]='%s'", ii, argv[ii]);
-			printf("\n");
+				ksft_print_msg("\t[%d]='%s\n'", ii, argv[ii]);
 		}
 
 		/* Check expected environment transferred. */
 		if (!in_test || strcmp(in_test, "yes") != 0) {
-			printf("[FAIL] (no IN_TEST=yes in env)\n");
+			ksft_print_msg("no IN_TEST=yes in env\n");
 			return 1;
 		}
 
 		/* Use the final argument as an exit code. */
 		rc = atoi(argv[argc - 1]);
-		fflush(stdout);
+		exit(rc);
 	} else {
+		ksft_print_header();
+		ksft_set_plan(TESTS_EXPECTED);
 		prerequisites();
 		if (verbose)
 			envp[1] = "VERBOSE=1";
 		rc = run_tests();
 		if (rc > 0)
 			printf("%d tests failed\n", rc);
+		ksft_finished();
 	}
+
 	return rc;
 }

-- 
2.39.2

