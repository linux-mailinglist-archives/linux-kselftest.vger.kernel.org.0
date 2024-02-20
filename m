Return-Path: <linux-kselftest+bounces-5063-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2551485C4A2
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 20:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F80D1F2522A
	for <lists+linux-kselftest@lfdr.de>; Tue, 20 Feb 2024 19:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F47A14D42E;
	Tue, 20 Feb 2024 19:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYf+tgXH"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5353C14C5BB;
	Tue, 20 Feb 2024 19:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456969; cv=none; b=BLW4u1t7w7tcPB3uVxukheTRNX4Aw2JJJv1fT6O7O516cADqIf2U/i4NU/jQC6XKQKlYYqf1dmuhqmtf0zUAIMK7dKweJuGpPtKDkx8aISLpXzWOvvjmdAyzTBFWfLT9HRYMSNEE+pxCt2oANaKS6hA3azR1VK4bjf9YKoar4RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456969; c=relaxed/simple;
	bh=sSNbyi4vVMgE8gCscNKhi1u1ZHd/Rxrt/+4HOyAonzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NO5GDyF4GiP8Jf3G44RouW+eiYG0M3pVOciBOuC74aLVnbcUJt/LVuyWPR0Z7gNiRoBS/apRzuIbNLUjpzAqch2pOEO+sJlmf4aux2fyCOriOYCY1FsPjU9q02HKvHaXpiK+zAPaRRKMRe9pYW6084IGzcyN3HPq6z/FQMVVYLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYf+tgXH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A61C433F1;
	Tue, 20 Feb 2024 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708456968;
	bh=sSNbyi4vVMgE8gCscNKhi1u1ZHd/Rxrt/+4HOyAonzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HYf+tgXHQir3ByUdTyEObjAfzBqhsP1aI4UifIcriyBjndKzcuztQ1PNHQC3LTvRO
	 Z49VPPtt5o99Uec3fpxyce1xLFd7qz+pjtV9Qd3k4XOdVY4UWcP1OZK2jFOvZQuFaH
	 M6qvC0wxIXh8Pzb8FW46XN1tPE9SBTIG2vNwjDpg7QILrJcFw1+2q99MaR4S6BlqQP
	 8aRIk5+Zbl2ti9VL6UusSobEZgBIngNwboMfUbjdFU542/h1XZtTh/AOMUk+3gL9Or
	 4pwy4fCS+gn+veHjnAJ4Y/Cmm4HtnVWHSzed8kKxWy6XYYYjp9ZbUoMmgywJj9AdmP
	 vpNb+0JpEm30A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	mic@digikod.net,
	linux-security-module@vger.kernel.org,
	keescook@chromium.org,
	jakub@cloudflare.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 04/11] selftests: kselftest_harness: save full exit code in metadata
Date: Tue, 20 Feb 2024 11:22:28 -0800
Message-ID: <20240220192235.2953484-5-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240220192235.2953484-1-kuba@kernel.org>
References: <20240220192235.2953484-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of tracking passed = 0/1 rename the field to exit_code
and invert the values so that they match the KSFT_* exit codes.
This will allow us to fold SKIP / XFAIL into the same value.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/kselftest_harness.h   | 48 +++++++++++--------
 tools/testing/selftests/landlock/base_test.c  |  2 +-
 tools/testing/selftests/landlock/common.h     | 14 ++----
 tools/testing/selftests/landlock/fs_test.c    |  4 +-
 tools/testing/selftests/landlock/net_test.c   |  4 +-
 .../testing/selftests/landlock/ptrace_test.c  |  7 +--
 tools/testing/selftests/net/tls.c             |  2 +-
 tools/testing/selftests/seccomp/seccomp_bpf.c |  9 ++--
 8 files changed, 46 insertions(+), 44 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 8fc24a728240..bbb339642a72 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -136,7 +136,7 @@
 		fprintf(TH_LOG_STREAM, "#      SKIP      %s\n", \
 			_metadata->results->reason); \
 	} \
-	_metadata->passed = 1; \
+	_metadata->exit_code = KSFT_PASS; \
 	_metadata->skip = 1; \
 	_metadata->trigger = 0; \
 	statement; \
@@ -389,7 +389,7 @@
 		if (setjmp(_metadata->env) == 0) { \
 			fixture_name##_setup(_metadata, &self, variant->data); \
 			/* Let setup failure terminate early. */ \
-                       if (!_metadata->passed || _metadata->skip) \
+			if (!__test_passed(_metadata) || _metadata->skip) \
 				return; \
 			_metadata->setup_completed = true; \
 			fixture_name##_##test_name(_metadata, &self, variant->data); \
@@ -696,7 +696,7 @@
 			__bail(_assert, _metadata))
 
 #define __INC_STEP(_metadata) \
-	if (_metadata->passed) \
+	if (__test_passed(_metadata))	\
 		_metadata->results->step++;
 
 #define is_signed_type(var)       (!!(((__typeof__(var))(-1)) < (__typeof__(var))1))
@@ -742,7 +742,7 @@
 			break; \
 			} \
 		} \
-		_metadata->passed = 0; \
+		_metadata->exit_code = KSFT_FAIL; \
 		/* Ensure the optional handler is triggered */ \
 		_metadata->trigger = 1; \
 	} \
@@ -754,7 +754,7 @@
 	if (_assert) __INC_STEP(_metadata); \
 	if (!(strcmp(__exp, __seen) _t 0))  { \
 		__TH_LOG("Expected '%s' %s '%s'.", __exp, #_t, __seen); \
-		_metadata->passed = 0; \
+		_metadata->exit_code = KSFT_FAIL; \
 		_metadata->trigger = 1; \
 	} \
 } while (0); OPTIONAL_HANDLER(_assert)
@@ -833,7 +833,7 @@ struct __test_metadata {
 	pid_t pid;	/* pid of test when being run */
 	struct __fixture_metadata *fixture;
 	int termsig;
-	int passed;
+	int exit_code;
 	int skip;	/* did SKIP get used? */
 	int trigger; /* extra handler after the evaluation */
 	int timeout;	/* seconds to wait for test timeout */
@@ -846,6 +846,12 @@ struct __test_metadata {
 	struct __test_metadata *prev, *next;
 };
 
+static inline bool __test_passed(struct __test_metadata *metadata)
+{
+	return metadata->exit_code != KSFT_FAIL &&
+	       metadata->exit_code <= KSFT_SKIP;
+}
+
 /*
  * Since constructors are called in reverse order, reverse the test
  * list so tests are run in source declaration order.
@@ -913,7 +919,7 @@ void __wait_for_test(struct __test_metadata *t)
 	int status;
 
 	if (sigaction(SIGALRM, &action, &saved_action)) {
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
 			"# %s: unable to install SIGALRM handler\n",
 			t->name);
@@ -925,7 +931,7 @@ void __wait_for_test(struct __test_metadata *t)
 	waitpid(t->pid, &status, 0);
 	alarm(0);
 	if (sigaction(SIGALRM, &saved_action, NULL)) {
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
 			"# %s: unable to uninstall SIGALRM handler\n",
 			t->name);
@@ -934,16 +940,16 @@ void __wait_for_test(struct __test_metadata *t)
 	__active_test = NULL;
 
 	if (t->timed_out) {
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test terminated by timeout\n", t->name);
 	} else if (WIFEXITED(status)) {
 		if (WEXITSTATUS(status) == KSFT_SKIP) {
 			/* SKIP */
-			t->passed = 1;
+			t->exit_code = KSFT_PASS;
 			t->skip = 1;
 		} else if (t->termsig != -1) {
-			t->passed = 0;
+			t->exit_code = KSFT_FAIL;
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test exited normally instead of by signal (code: %d)\n",
 				t->name,
@@ -952,11 +958,11 @@ void __wait_for_test(struct __test_metadata *t)
 			switch (WEXITSTATUS(status)) {
 			/* Success */
 			case KSFT_PASS:
-				t->passed = 1;
+				t->exit_code = KSFT_PASS;
 				break;
 			/* Other failure, assume step report. */
 			default:
-				t->passed = 0;
+				t->exit_code = KSFT_FAIL;
 				fprintf(TH_LOG_STREAM,
 					"# %s: Test failed at step #%d\n",
 					t->name,
@@ -964,13 +970,13 @@ void __wait_for_test(struct __test_metadata *t)
 			}
 		}
 	} else if (WIFSIGNALED(status)) {
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 		if (WTERMSIG(status) == SIGABRT) {
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test terminated by assertion\n",
 				t->name);
 		} else if (WTERMSIG(status) == t->termsig) {
-			t->passed = 1;
+			t->exit_code = KSFT_PASS;
 		} else {
 			fprintf(TH_LOG_STREAM,
 				"# %s: Test terminated unexpectedly by signal %d\n",
@@ -1113,7 +1119,7 @@ void __run_test(struct __fixture_metadata *f,
 	char test_name[LINE_MAX];
 
 	/* reset test struct */
-	t->passed = 1;
+	t->exit_code = KSFT_PASS;
 	t->skip = 0;
 	t->trigger = 0;
 	t->no_print = 0;
@@ -1132,13 +1138,13 @@ void __run_test(struct __fixture_metadata *f,
 	t->pid = fork();
 	if (t->pid < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
-		t->passed = 0;
+		t->exit_code = KSFT_FAIL;
 	} else if (t->pid == 0) {
 		setpgrp();
 		t->fn(t, variant);
 		if (t->skip)
 			_exit(KSFT_SKIP);
-		if (t->passed)
+		if (__test_passed(t))
 			_exit(KSFT_PASS);
 		/* Something else happened. */
 		_exit(KSFT_FAIL);
@@ -1146,13 +1152,13 @@ void __run_test(struct __fixture_metadata *f,
 		__wait_for_test(t);
 	}
 	ksft_print_msg("         %4s  %s\n",
-		       t->passed ? "OK" : "FAIL", test_name);
+		       __test_passed(t) ? "OK" : "FAIL", test_name);
 
 	if (t->skip)
 		ksft_test_result_skip("%s\n", t->results->reason[0] ?
 					t->results->reason : "unknown");
 	else
-		ksft_test_result(t->passed, "%s\n", test_name);
+		ksft_test_result(__test_passed(t), "%s\n", test_name);
 }
 
 static int test_harness_run(int argc, char **argv)
@@ -1200,7 +1206,7 @@ static int test_harness_run(int argc, char **argv)
 				t->results = results;
 				__run_test(f, v, t);
 				t->results = NULL;
-				if (t->passed)
+				if (__test_passed(t))
 					pass_count++;
 				else
 					ret = 1;
diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
index 646f778dfb1e..a6f89aaea77d 100644
--- a/tools/testing/selftests/landlock/base_test.c
+++ b/tools/testing/selftests/landlock/base_test.c
@@ -307,7 +307,7 @@ TEST(ruleset_fd_transfer)
 		dir_fd = open("/tmp", O_RDONLY | O_DIRECTORY | O_CLOEXEC);
 		ASSERT_LE(0, dir_fd);
 		ASSERT_EQ(0, close(dir_fd));
-		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
diff --git a/tools/testing/selftests/landlock/common.h b/tools/testing/selftests/landlock/common.h
index f5b40399a538..89f8183bd8f5 100644
--- a/tools/testing/selftests/landlock/common.h
+++ b/tools/testing/selftests/landlock/common.h
@@ -46,29 +46,25 @@
 		if (child == 0) { \
 			_metadata->no_print = 1; \
 			fixture_name##_##test_name##_child(_metadata, self, variant); \
-			if (_metadata->skip) \
-				_exit(KSFT_SKIP); \
-			if (_metadata->passed) \
-				_exit(KSFT_PASS); \
-			_exit(KSFT_FAIL); \
+			_exit(_metadata->exit_code); \
 		} \
 		if (child != waitpid(child, &status, 0)) \
 			abort(); \
 		if (WIFSIGNALED(status) || !WIFEXITED(status)) { \
-			_metadata->passed = 0; \
+			_metadata->exit_code = KSFT_FAIL; \
 			_metadata->results->step = 1; \
 			return; \
 		} \
 		switch (WEXITSTATUS(status)) { \
 		case KSFT_PASS: \
-			_metadata->passed = 1; \
+			_metadata->exit_code = KSFT_PASS; \
 			break; \
 		case KSFT_SKIP: \
-			_metadata->passed = 1; \
+			_metadata->exit_code = KSFT_PASS; \
 			_metadata->skip = 1; \
 			break; \
 		default: \
-			_metadata->passed = 0; \
+			_metadata->exit_code = KSFT_FAIL; \
 			break; \
 		} \
 	} \
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 2d6d9b43d958..98817a14c91b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1964,7 +1964,7 @@ static void test_execute(struct __test_metadata *const _metadata, const int err,
 			       strerror(errno));
 		};
 		ASSERT_EQ(err, errno);
-		_exit(_metadata->passed ? 2 : 1);
+		_exit(__test_passed(_metadata) ? 2 : 1);
 		return;
 	}
 	ASSERT_EQ(child, waitpid(child, &status, 0));
@@ -3807,7 +3807,7 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 
 		ASSERT_EQ(0, close(socket_fds[0]));
 
-		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 936cfc879f1d..f21cfbbc3638 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -539,7 +539,7 @@ static void test_bind_and_connect(struct __test_metadata *const _metadata,
 		}
 
 		EXPECT_EQ(0, close(connect_fd));
-		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
@@ -834,7 +834,7 @@ TEST_F(protocol, connect_unspec)
 		}
 
 		EXPECT_EQ(0, close(connect_fd));
-		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
diff --git a/tools/testing/selftests/landlock/ptrace_test.c b/tools/testing/selftests/landlock/ptrace_test.c
index 55e7871631a1..a19db4d0b3bd 100644
--- a/tools/testing/selftests/landlock/ptrace_test.c
+++ b/tools/testing/selftests/landlock/ptrace_test.c
@@ -314,7 +314,7 @@ TEST_F(hierarchy, trace)
 	ASSERT_EQ(0, pipe2(pipe_parent, O_CLOEXEC));
 	if (variant->domain_both) {
 		create_domain(_metadata);
-		if (!_metadata->passed)
+		if (!__test_passed(_metadata))
 			/* Aborts before forking. */
 			return;
 	}
@@ -375,7 +375,7 @@ TEST_F(hierarchy, trace)
 
 		/* Waits for the parent PTRACE_ATTACH test. */
 		ASSERT_EQ(1, read(pipe_parent[0], &buf_child, 1));
-		_exit(_metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+		_exit(_metadata->exit_code);
 		return;
 	}
 
@@ -430,9 +430,10 @@ TEST_F(hierarchy, trace)
 	/* Signals that the parent PTRACE_ATTACH test is done. */
 	ASSERT_EQ(1, write(pipe_parent[1], ".", 1));
 	ASSERT_EQ(child, waitpid(child, &status, 0));
+
 	if (WIFSIGNALED(status) || !WIFEXITED(status) ||
 	    WEXITSTATUS(status) != EXIT_SUCCESS)
-		_metadata->passed = 0;
+		_metadata->exit_code = KSFT_FAIL;
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 49c84602707f..046d1ccedcf3 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -1882,7 +1882,7 @@ TEST_F(tls_err, poll_partial_rec_async)
 		pfd.events = POLLIN;
 		EXPECT_EQ(poll(&pfd, 1, 20), 1);
 
-		exit(!_metadata->passed);
+		exit(!__test_passed(_metadata));
 	}
 }
 
diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 38f651469968..1027e6170186 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -1576,7 +1576,7 @@ void start_tracer(struct __test_metadata *_metadata, int fd, pid_t tracee,
 		ASSERT_EQ(0, ret);
 	}
 	/* Directly report the status of our test harness results. */
-	syscall(__NR_exit, _metadata->passed ? EXIT_SUCCESS : EXIT_FAILURE);
+	syscall(__NR_exit, _metadata->exit_code);
 }
 
 /* Common tracer setup/teardown functions. */
@@ -1623,7 +1623,7 @@ void teardown_trace_fixture(struct __test_metadata *_metadata,
 		ASSERT_EQ(0, kill(tracer, SIGUSR1));
 		ASSERT_EQ(tracer, waitpid(tracer, &status, 0));
 		if (WEXITSTATUS(status))
-			_metadata->passed = 0;
+			_metadata->exit_code = KSFT_FAIL;
 	}
 }
 
@@ -3088,8 +3088,7 @@ TEST(syscall_restart)
 		}
 
 		/* Directly report the status of our test harness results. */
-		syscall(__NR_exit, _metadata->passed ? EXIT_SUCCESS
-						     : EXIT_FAILURE);
+		syscall(__NR_exit, _metadata->exit_code);
 	}
 	EXPECT_EQ(0, close(pipefd[0]));
 
@@ -3174,7 +3173,7 @@ TEST(syscall_restart)
 
 	ASSERT_EQ(child_pid, waitpid(child_pid, &status, 0));
 	if (WIFSIGNALED(status) || WEXITSTATUS(status))
-		_metadata->passed = 0;
+		_metadata->exit_code = KSFT_FAIL;
 }
 
 TEST_SIGNAL(filter_flag_log, SIGSYS)
-- 
2.43.0


