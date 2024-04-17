Return-Path: <linux-kselftest+bounces-8259-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF168A87E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63A4528796F
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Apr 2024 15:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707C415E1F7;
	Wed, 17 Apr 2024 15:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZLrwoXJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45CE913C3EF;
	Wed, 17 Apr 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368241; cv=none; b=kAbAlJhW6JJ3AXajOZci6jVrl+sVxONMwIYAHp2uji9AKDy2lV7oM6BRzvra59qLKjGoniZsj4ywSXQlD4OV5Q3eBPebBlRAEjXXcdYu2pNCbCaaO4s0juGaQ6OJfgc+xoQ8Njp+ddPdCfhrhJMN3f+Iuz/estSt7R98F6WpQ1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368241; c=relaxed/simple;
	bh=JfzOhH8Ke+eMa566lzerBe6MT2M+20uBK6LSEGG2Q7Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BhHSd60zgj0a2KwyjdDJIt7YcfUWVQo5UsAxpa1hXSdpLAKo2iZxZvgYiuHvxQnhjz+E+L9fjfks6H9zmN67fhFP0WQF2KrC0R5Ya6xGFmERmCuM4tN6GdVXjWGPBTjuKVBoMJaQkcB1zEcXdjTxrsHV1hyQBfLar1jD4a28tuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZLrwoXJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611FFC072AA;
	Wed, 17 Apr 2024 15:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368240;
	bh=JfzOhH8Ke+eMa566lzerBe6MT2M+20uBK6LSEGG2Q7Q=;
	h=From:Date:Subject:To:Cc:From;
	b=iZLrwoXJguugmazh+Me3UvuAcfWXx8tys3VGVdsgRV53QpsUs4PWHpjqOc3Ujl5Vj
	 IFGmpeImVEqw9QHq2Ebczu0kI8Xfxvx5fnCjR0bWOebATdQTy1tM2cmOYY6gEP5q5Y
	 x2TWrE+7DMMye+0JdPyIbvJfsXk+U16exIZdvzS0y8dagYEu9PUdrQyHcAaW1KHuMV
	 e+LIz++5oclQsTeSAqT60owP7Tv6RCjs71P+jKrvb4S6pyodWGM6TAqZJefIdPQCoC
	 YERpEzRJNnT+3dhOjzjRWjTsqkR/xDeEhWS+zA04jS4XK+phd/39zS77L/MGH6dUWG
	 c/3K9af7sTYMg==
From: Nathan Chancellor <nathan@kernel.org>
Date: Wed, 17 Apr 2024 08:37:15 -0700
Subject: [PATCH] selftests: Make ksft_exit functions return void instead of
 int
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-ksft-exit-int-to-void-v1-1-eff48fdbab39@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKrsH2YC/x3MTQqAIBBA4avErBvItN+rRAvLqYZAQyWE6O5Jy
 2/x3gOBPFOAsXjA082Bnc0QZQHroe1OyCYb6qpWlRItnmGLSIkjso0YHd6ODTZaD2aRvZDdALm
 9PG2c/u80v+8HxkCz5WcAAAA=
To: shuah@kernel.org
Cc: tglx@linutronix.de, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=27467; i=nathan@kernel.org;
 h=from:subject:message-id; bh=JfzOhH8Ke+eMa566lzerBe6MT2M+20uBK6LSEGG2Q7Q=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGnybzZEb9cv+daqxHvyerXWVO4A1tqblZ8n1dbWiCRt9
 bqquW5nRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZiIrz7D/6JdZ4+w/Ht8bsVb
 zwiXgzK39sfM5xCKXun2cO28Hz8e1Ckx/NO/4MpbWDkt5d/FHYFFS9i0gs/FPrjn2Z7MV6UoMld
 wExsA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Commit f7d5bcd35d42 ("selftests: kselftest: Mark functions that
unconditionally call exit() as __noreturn") marked functions that call
exit() as __noreturn but it did not change the return type of these
functions from 'void' to 'int' like it should have (since a noreturn
function by definition cannot return an integer because it does not
return...) because there are many tests that return the result of the
ksft_exit function, even though it has never been used due to calling
exit().

Prior to adding __noreturn, the compiler would not know that the functions
that call exit() will not return, so code like

  void ksft_exit_fail(void)
  {
    exit(1);
  }

  void ksft_exit_pass(void)
  {
    exit(0);
  }

  int main(void)
  {
    int ret;

    ret = foo();
    if (ret)
      ksft_exit_fail();
    ksft_exit_pass();
  }

would cause the compiler to complain that main() does not return an
integer, even though when ksft_exit_pass() is called, exit() will cause
the program to terminate. So ksft_exit_...() returns int to make the
compiler happy.

  int ksft_exit_fail(void)
  {
    exit(1);
  }

  int ksft_exit_pass(void)
  {
    exit(0);
  }

  int main(void)
  {
    int ret;

    ret = foo();
    if (ret)
      return ksft_exit_fail();
    return ksft_exit_pass();
  }

While this results in no warnings, it is weird semantically and it has
issues as noted in the aforementioned __noreturn change. Now that
__noreturn has been added to these functions, it is much cleaner to
change the functions to 'void' and eliminate the return statements, as
it has been made clear to the compiler that these functions terminate
the program. Drop the return before all instances of ksft_exit_...() in
a mechanical way. Only two manually changes were made to transform

  return !ret ? ksft_exit_pass() : ksft_exit_fail();

into the more idiomatic

  if (ret)
    ksft_exit_fail();
  ksft_exit_pass();

as well as a few style clean ups now that the code is shorter.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 tools/testing/selftests/clone3/clone3_clear_sighand.c        |  2 +-
 tools/testing/selftests/clone3/clone3_set_tid.c              |  4 +++-
 tools/testing/selftests/ipc/msgque.c                         | 11 +++++------
 tools/testing/selftests/kselftest.h                          | 12 ++++++------
 .../selftests/membarrier/membarrier_test_multi_thread.c      |  2 +-
 .../selftests/membarrier/membarrier_test_single_thread.c     |  2 +-
 tools/testing/selftests/mm/compaction_test.c                 |  6 +++---
 tools/testing/selftests/mm/cow.c                             |  2 +-
 tools/testing/selftests/mm/gup_longterm.c                    |  2 +-
 tools/testing/selftests/mm/gup_test.c                        |  4 ++--
 tools/testing/selftests/mm/ksm_functional_tests.c            |  2 +-
 tools/testing/selftests/mm/madv_populate.c                   |  2 +-
 tools/testing/selftests/mm/mkdirty.c                         |  2 +-
 tools/testing/selftests/mm/pagemap_ioctl.c                   |  4 ++--
 tools/testing/selftests/mm/soft-dirty.c                      |  2 +-
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c            |  2 +-
 tools/testing/selftests/pidfd/pidfd_open_test.c              |  4 +++-
 tools/testing/selftests/pidfd/pidfd_poll_test.c              |  2 +-
 tools/testing/selftests/pidfd/pidfd_test.c                   |  2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c              |  6 +++---
 tools/testing/selftests/sync/sync_test.c                     |  3 +--
 tools/testing/selftests/timers/adjtick.c                     |  4 ++--
 tools/testing/selftests/timers/alarmtimer-suspend.c          |  4 ++--
 tools/testing/selftests/timers/change_skew.c                 |  4 ++--
 tools/testing/selftests/timers/freq-step.c                   |  4 ++--
 tools/testing/selftests/timers/leap-a-day.c                  | 10 +++++-----
 tools/testing/selftests/timers/leapcrash.c                   |  4 ++--
 tools/testing/selftests/timers/mqueue-lat.c                  |  4 ++--
 tools/testing/selftests/timers/posix_timers.c                | 12 ++++++------
 tools/testing/selftests/timers/raw_skew.c                    |  6 +++---
 tools/testing/selftests/timers/set-2038.c                    |  4 ++--
 tools/testing/selftests/timers/set-tai.c                     |  4 ++--
 tools/testing/selftests/timers/set-timer-lat.c               |  4 ++--
 tools/testing/selftests/timers/set-tz.c                      |  4 ++--
 tools/testing/selftests/timers/skew_consistency.c            |  4 ++--
 tools/testing/selftests/timers/threadtest.c                  |  2 +-
 tools/testing/selftests/timers/valid-adjtimex.c              |  6 +++---
 tools/testing/selftests/x86/lam.c                            |  2 +-
 38 files changed, 81 insertions(+), 79 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index 54a8b2445be9..ce0426786828 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -120,5 +120,5 @@ int main(int argc, char **argv)
 
 	test_clone3_clear_sighand();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index fbf813a5a06f..bfb0da2b4fdd 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -412,5 +412,7 @@ int main(int argc, char *argv[])
 out:
 	ret = 0;
 
-	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 656c43c24044..c75ea4094870 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -198,13 +198,12 @@ int main(int argc, char **argv)
 	struct msgque_data msgque;
 
 	if (getuid() != 0)
-		return ksft_exit_skip(
-				"Please run the test as root - Exiting.\n");
+		ksft_exit_skip("Please run the test as root - Exiting.\n");
 
 	msgque.key = ftok(argv[0], 822155650);
 	if (msgque.key == -1) {
 		printf("Can't make key: %d\n", -errno);
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 
 	msgque.msq_id = msgget(msgque.key, IPC_CREAT | IPC_EXCL | 0666);
@@ -243,13 +242,13 @@ int main(int argc, char **argv)
 		printf("Failed to test queue: %d\n", err);
 		goto err_out;
 	}
-	return ksft_exit_pass();
+	ksft_exit_pass();
 
 err_destroy:
 	if (msgctl(msgque.msq_id, IPC_RMID, NULL)) {
 		printf("Failed to destroy queue: %d\n", -errno);
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 err_out:
-	return ksft_exit_fail();
+	ksft_exit_fail();
 }
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 9bb1664bcf95..f4221691a7da 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -327,13 +327,13 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 		break;						\
 	} } while (0)
 
-static inline __noreturn int ksft_exit_pass(void)
+static inline __noreturn void ksft_exit_pass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_PASS);
 }
 
-static inline __noreturn int ksft_exit_fail(void)
+static inline __noreturn void ksft_exit_fail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_FAIL);
@@ -360,7 +360,7 @@ static inline __noreturn int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline __noreturn __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
+static inline __noreturn __printf(1, 2) void ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -388,19 +388,19 @@ static inline __noreturn void ksft_exit_fail_perror(const char *msg)
 #endif
 }
 
-static inline __noreturn int ksft_exit_xfail(void)
+static inline __noreturn void ksft_exit_xfail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XFAIL);
 }
 
-static inline __noreturn int ksft_exit_xpass(void)
+static inline __noreturn void ksft_exit_xpass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XPASS);
 }
 
-static inline __noreturn __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
+static inline __noreturn __printf(1, 2) void ksft_exit_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index a9cc17facfb3..4e14dba81234 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -69,5 +69,5 @@ int main(int argc, char **argv)
 	/* Multi-threaded */
 	test_mt_membarrier();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index 4cdc8b1d124c..fa3f1d6c37a0 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -24,5 +24,5 @@ int main(int argc, char **argv)
 
 	test_membarrier_get_registrations(/*cmd=*/0);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/compaction_test.c b/tools/testing/selftests/mm/compaction_test.c
index 533999b6c284..4f42eb7d7636 100644
--- a/tools/testing/selftests/mm/compaction_test.c
+++ b/tools/testing/selftests/mm/compaction_test.c
@@ -177,7 +177,7 @@ int main(int argc, char **argv)
 	ksft_print_header();
 
 	if (prereq() || geteuid())
-		return ksft_exit_skip("Prerequisites unsatisfied\n");
+		ksft_exit_skip("Prerequisites unsatisfied\n");
 
 	ksft_set_plan(1);
 
@@ -225,7 +225,7 @@ int main(int argc, char **argv)
 	}
 
 	if (check_compaction(mem_free, hugepage_size) == 0)
-		return ksft_exit_pass();
+		ksft_exit_pass();
 
-	return ksft_exit_fail();
+	ksft_exit_fail();
 }
diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
index 363bf5f801be..fe078d6e1806 100644
--- a/tools/testing/selftests/mm/cow.c
+++ b/tools/testing/selftests/mm/cow.c
@@ -1779,5 +1779,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/gup_longterm.c b/tools/testing/selftests/mm/gup_longterm.c
index ad168d35b23b..d7eaca5bbe9b 100644
--- a/tools/testing/selftests/mm/gup_longterm.c
+++ b/tools/testing/selftests/mm/gup_longterm.c
@@ -456,5 +456,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/gup_test.c b/tools/testing/selftests/mm/gup_test.c
index 18a49c70d4c6..bd335cf9bc0e 100644
--- a/tools/testing/selftests/mm/gup_test.c
+++ b/tools/testing/selftests/mm/gup_test.c
@@ -228,7 +228,7 @@ int main(int argc, char **argv)
 			break;
 		}
 		ksft_test_result_skip("Please run this test as root\n");
-		return ksft_exit_pass();
+		ksft_exit_pass();
 	}
 
 	p = mmap(NULL, size, PROT_READ | PROT_WRITE, flags, filed, 0);
@@ -267,5 +267,5 @@ int main(int argc, char **argv)
 
 	free(tid);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
index d615767e396b..508287560c45 100644
--- a/tools/testing/selftests/mm/ksm_functional_tests.c
+++ b/tools/testing/selftests/mm/ksm_functional_tests.c
@@ -646,5 +646,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/madv_populate.c b/tools/testing/selftests/mm/madv_populate.c
index 17bcb07f19f3..ef7d911da13e 100644
--- a/tools/testing/selftests/mm/madv_populate.c
+++ b/tools/testing/selftests/mm/madv_populate.c
@@ -307,5 +307,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/mkdirty.c b/tools/testing/selftests/mm/mkdirty.c
index 301abb99e027..b8a7efe9204e 100644
--- a/tools/testing/selftests/mm/mkdirty.c
+++ b/tools/testing/selftests/mm/mkdirty.c
@@ -375,5 +375,5 @@ int main(void)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/pagemap_ioctl.c b/tools/testing/selftests/mm/pagemap_ioctl.c
index d59517ed3d48..2d785aca72a5 100644
--- a/tools/testing/selftests/mm/pagemap_ioctl.c
+++ b/tools/testing/selftests/mm/pagemap_ioctl.c
@@ -1484,7 +1484,7 @@ int main(int argc, char *argv[])
 	ksft_print_header();
 
 	if (init_uffd())
-		return ksft_exit_pass();
+		ksft_exit_pass();
 
 	ksft_set_plan(115);
 
@@ -1660,5 +1660,5 @@ int main(int argc, char *argv[])
 	userfaultfd_tests();
 
 	close(pagemap_fd);
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/mm/soft-dirty.c b/tools/testing/selftests/mm/soft-dirty.c
index 7dbfa53d93a0..d9dbf879748b 100644
--- a/tools/testing/selftests/mm/soft-dirty.c
+++ b/tools/testing/selftests/mm/soft-dirty.c
@@ -209,5 +209,5 @@ int main(int argc, char **argv)
 
 	close(pagemap_fd);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 01cc37bf611c..f062a986e382 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -307,5 +307,5 @@ int main(int argc, char **argv)
 	test_pidfd_fdinfo_nspid();
 	test_pidfd_dead_fdinfo();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index 8a59438ccc78..c62564c264b1 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -159,5 +159,7 @@ int main(int argc, char **argv)
 	if (pidfd >= 0)
 		close(pidfd);
 
-	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+	if (ret)
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
index 610811275357..55d74a50358f 100644
--- a/tools/testing/selftests/pidfd/pidfd_poll_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
@@ -112,5 +112,5 @@ int main(int argc, char **argv)
 	}
 
 	ksft_test_result_pass("pidfd poll test: pass\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index c081ae91313a..9faa686f90e4 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -572,5 +572,5 @@ int main(int argc, char **argv)
 	test_pidfd_send_signal_exited_fail();
 	test_pidfd_send_signal_recycled_pid_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 348d17cb2a84..ecbb7605a981 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -247,13 +247,13 @@ int main(int argc, char **argv)
 	 * 2. We execute perf commands
 	 */
 	if (geteuid() != 0)
-		return ksft_exit_skip("Not running as root. Skipping...\n");
+		ksft_exit_skip("Not running as root. Skipping...\n");
 
 	if (!check_resctrlfs_support())
-		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
+		ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
 	if (umount_resctrlfs())
-		return ksft_exit_skip("resctrl FS unmount failed.\n");
+		ksft_exit_skip("resctrl FS unmount failed.\n");
 
 	filter_dmesg();
 
diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
index 414a617db993..93db5aa246a3 100644
--- a/tools/testing/selftests/sync/sync_test.c
+++ b/tools/testing/selftests/sync/sync_test.c
@@ -109,6 +109,5 @@ int main(void)
 		ksft_exit_fail_msg("%d out of %d sync tests failed\n",
 					err, ksft_test_num());
 
-	/* need this return to keep gcc happy */
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 47e05fdc32c5..205b76a4abb4 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 	adjtimex(&tx1);
 
 	if (err)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index 4332b494103d..ad52e608b88e 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -173,6 +173,6 @@ int main(void)
 		timer_delete(tm1);
 	}
 	if (final_ret)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
index 992a77f2a74c..4421cd562c24 100644
--- a/tools/testing/selftests/timers/change_skew.c
+++ b/tools/testing/selftests/timers/change_skew.c
@@ -89,8 +89,8 @@ int main(int argc, char **argv)
 
 	if (ret) {
 		printf("[FAIL]");
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 	printf("[OK]");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
index 4b76450d78d1..73b636f89fdc 100644
--- a/tools/testing/selftests/timers/freq-step.c
+++ b/tools/testing/selftests/timers/freq-step.c
@@ -257,7 +257,7 @@ int main(int argc, char **argv)
 	set_frequency(0.0);
 
 	if (fails)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/leap-a-day.c b/tools/testing/selftests/timers/leap-a-day.c
index 23eb398c8140..986abbdb1521 100644
--- a/tools/testing/selftests/timers/leap-a-day.c
+++ b/tools/testing/selftests/timers/leap-a-day.c
@@ -268,7 +268,7 @@ int main(int argc, char **argv)
 		if (ret < 0) {
 			printf("Error: Problem setting STA_INS/STA_DEL!: %s\n",
 							time_state_str(ret));
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 
 		/* Validate STA_INS was set */
@@ -277,7 +277,7 @@ int main(int argc, char **argv)
 		if (tx.status != STA_INS && tx.status != STA_DEL) {
 			printf("Error: STA_INS/STA_DEL not set!: %s\n",
 							time_state_str(ret));
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 
 		if (tai_time) {
@@ -295,7 +295,7 @@ int main(int argc, char **argv)
 		se.sigev_value.sival_int = 0;
 		if (timer_create(CLOCK_REALTIME, &se, &tm1) == -1) {
 			printf("Error: timer_create failed\n");
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 		its1.it_value.tv_sec = next_leap;
 		its1.it_value.tv_nsec = 0;
@@ -366,7 +366,7 @@ int main(int argc, char **argv)
 		if (error_found) {
 			printf("Errors observed\n");
 			clear_time_state();
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 		printf("\n");
 		if ((iterations != -1) && !(--iterations))
@@ -374,5 +374,5 @@ int main(int argc, char **argv)
 	}
 
 	clear_time_state();
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/leapcrash.c b/tools/testing/selftests/timers/leapcrash.c
index f70802c5dd0d..8fd065eec904 100644
--- a/tools/testing/selftests/timers/leapcrash.c
+++ b/tools/testing/selftests/timers/leapcrash.c
@@ -87,7 +87,7 @@ int main(void)
 		tv.tv_usec = 0;
 		if (settimeofday(&tv, NULL)) {
 			printf("Error: You're likely not running with proper (ie: root) permissions\n");
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 		tx.modes = 0;
 		adjtimex(&tx);
@@ -104,5 +104,5 @@ int main(void)
 		fflush(stdout);
 	}
 	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/mqueue-lat.c b/tools/testing/selftests/timers/mqueue-lat.c
index 7916cf5cc6ff..f3179a605bba 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -107,8 +107,8 @@ int main(int argc, char **argv)
 	ret = mqueue_lat_test();
 	if (ret < 0) {
 		printf("[FAILED]\n");
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index c001dd79179d..07c81c0093c0 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -260,16 +260,16 @@ int main(int argc, char **argv)
 	ksft_print_msg("based timers if other threads run on the CPU...\n");
 
 	if (check_itimer(ITIMER_VIRTUAL) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (check_itimer(ITIMER_PROF) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (check_itimer(ITIMER_REAL) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (check_timer_create(CLOCK_THREAD_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	/*
 	 * It's unfortunately hard to reliably test a timer expiration
@@ -281,10 +281,10 @@ int main(int argc, char **argv)
 	 * find a better solution.
 	 */
 	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (check_timer_distribution() < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	ksft_finished();
 }
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index 6eba203f9da7..030143eb09b4 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -137,11 +137,11 @@ int main(int argc, char **argv)
 		if (tx1.offset || tx2.offset ||
 		    tx1.freq != tx2.freq || tx1.tick != tx2.tick) {
 			printf("	[SKIP]\n");
-			return ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd or other time sync daemons\n");
+			ksft_exit_skip("The clock was adjusted externally. Shutdown NTPd or other time sync daemons\n");
 		}
 		printf("	[FAILED]\n");
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 	printf("	[OK]\n");
-	return  ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/set-2038.c b/tools/testing/selftests/timers/set-2038.c
index 688cfd81b531..f7d978721b9e 100644
--- a/tools/testing/selftests/timers/set-2038.c
+++ b/tools/testing/selftests/timers/set-2038.c
@@ -128,6 +128,6 @@ int main(int argc, char *argv[])
 	/* restore clock */
 	settime(start);
 	if (ret)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/set-tai.c b/tools/testing/selftests/timers/set-tai.c
index 8c4179ee2ca2..5b67462efcd6 100644
--- a/tools/testing/selftests/timers/set-tai.c
+++ b/tools/testing/selftests/timers/set-tai.c
@@ -61,9 +61,9 @@ int main(int argc, char **argv)
 		ret = get_tai();
 		if (ret != i) {
 			printf("[FAILED] expected: %i got %i\n", i, ret);
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 	}
 	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/set-timer-lat.c b/tools/testing/selftests/timers/set-timer-lat.c
index 50da45437daa..7ce240c89b21 100644
--- a/tools/testing/selftests/timers/set-timer-lat.c
+++ b/tools/testing/selftests/timers/set-timer-lat.c
@@ -278,6 +278,6 @@ int main(void)
 		ret |= do_timer_oneshot(clock_id, 0);
 	}
 	if (ret)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+		ksft_exit_fail();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/set-tz.c b/tools/testing/selftests/timers/set-tz.c
index 62bd33eb16f0..20daaf1782b7 100644
--- a/tools/testing/selftests/timers/set-tz.c
+++ b/tools/testing/selftests/timers/set-tz.c
@@ -102,9 +102,9 @@ int main(int argc, char **argv)
 	printf("[OK]\n");
 
 	set_tz(min, dst);
-	return ksft_exit_pass();
+	ksft_exit_pass();
 
 err:
 	set_tz(min, dst);
-	return ksft_exit_fail();
+	ksft_exit_fail();
 }
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 63913f75b384..c8e6bffe4e0a 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -70,8 +70,8 @@ int main(int argc, char **argv)
 
 	if (ret) {
 		printf("[FAILED]\n");
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/threadtest.c b/tools/testing/selftests/timers/threadtest.c
index 80aed4bf06fb..76b38e41d9c7 100644
--- a/tools/testing/selftests/timers/threadtest.c
+++ b/tools/testing/selftests/timers/threadtest.c
@@ -189,5 +189,5 @@ int main(int argc, char **argv)
 	/* die */
 	if (ret)
 		ksft_exit_fail();
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/valid-adjtimex.c b/tools/testing/selftests/timers/valid-adjtimex.c
index d13ebde20322..d500884801d8 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -320,10 +320,10 @@ int validate_set_offset(void)
 int main(int argc, char **argv)
 {
 	if (validate_freq())
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
 	if (validate_set_offset())
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/x86/lam.c b/tools/testing/selftests/x86/lam.c
index 215b8150b7cc..820db4864292 100644
--- a/tools/testing/selftests/x86/lam.c
+++ b/tools/testing/selftests/x86/lam.c
@@ -1237,5 +1237,5 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(tests_cnt);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }

---
base-commit: 00ab560eb0e3f9725521c9fec2e8992e9e7e6c29
change-id: 20240416-ksft-exit-int-to-void-5aa9db381379

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


