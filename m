Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B2D043FB9E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 13:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229816AbhJ2LqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 07:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbhJ2LqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 07:46:03 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478DFC061714
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 04:43:34 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 1so10506762ljv.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Oct 2021 04:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5WkLmfrwcMvzT+1amjEkrvNeOySadFVVFrWgstIwuw=;
        b=PTGMWwWoA2G/FRo8HRr7ln9jv+qObIggGPbMLbv59zougO37xmRAFApYqAyRIjmpEh
         P5oM/hC/xfVkSfFqJ57Une1FqZd+EEZhaBH2auxoD16fAm+Bi9hhJDQQo5Yz1ntlaDDA
         EpyiR3fj/DZvgrDIYQBwc+OjMBZo0qpcYUZT6WFpxC6wLlYXmsEVGjCzSkEmQHlje89x
         GPw3xiR/xLdS6C12Q5ttczJ007HadSAZFtskwoMNZkiYBHIa4ZhAFr8ir0ZGdpgBzxV9
         MDe7Byk/YnKITHMAP7n5JWieHYbDwE9FXNEujR9bDhtLwhcW33mqRk8YKn0FiZohdR5/
         WYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Z5WkLmfrwcMvzT+1amjEkrvNeOySadFVVFrWgstIwuw=;
        b=qPbBj3+mwRIGFTGE0UokN8lwkDlYXVf1hMsLP8y/spXA8R5K5RLrjPCB7ylKdwGajm
         e2XcHirEmU9t+B4THxj/31t9HrOMqqXHabGagknydeV60SxdvINnZFDZ1nZ9ncLKQEHK
         XdUW85U5puZKVdAcjve4pBuIWzxpizSRlv1Bn5FLlBVozI3Bjd7AKVgnOtre7yoZ40sd
         NNjvCZNsau1Mb0psOM2KWV7OrdZhQc1fVnzakkmQuY5EVaMDmfMSkC5gE/IbpgqA4wFh
         NPU8oHfo6H5Hi/8NR+YKwt4S7RKZBgZnyXinng0/nKPH6xgFTeccBUVYIkwzToWj8aE1
         /4jQ==
X-Gm-Message-State: AOAM532kUdMnGUdoSCdGNSPLfLo7lMTNYjPsWPlEHGqgStob1wMRpdUu
        YhYWEsbZCdF296BPQCIULRlp+A==
X-Google-Smtp-Source: ABdhPJxPHjiT5tEJRJWi7aj3Z5bqj4CXAW0N05utMssTmprN/C8ivuOL56+CKt2QmgonxV94KqKuyw==
X-Received: by 2002:a2e:7607:: with SMTP id r7mr1946246ljc.451.1635507812492;
        Fri, 29 Oct 2021 04:43:32 -0700 (PDT)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id r3sm587982lfc.169.2021.10.29.04.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:43:31 -0700 (PDT)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     shuah@kernel.org
Cc:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        john.stultz@linaro.org, tglx@linutronix.de,
        akpm@linux-foundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        llvm@lists.linux.dev, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: kselftest.h: mark functions with 'noreturn'
Date:   Fri, 29 Oct 2021 13:43:12 +0200
Message-Id: <20211029114312.1921603-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When building kselftests/capabilities the following warning shows up:

clang -O2 -g -std=gnu99 -Wall    test_execve.c -lcap-ng -lrt -ldl -o test_execve
test_execve.c:121:13: warning: variable 'have_outer_privilege' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
        } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
test_execve.c:136:9: note: uninitialized use occurs here
        return have_outer_privilege;
               ^~~~~~~~~~~~~~~~~~~~
test_execve.c:121:9: note: remove the 'if' if its condition is always true
        } else if (unshare(CLONE_NEWUSER | CLONE_NEWNS) == 0) {
               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
test_execve.c:94:27: note: initialize the variable 'have_outer_privilege' to silence this warning
        bool have_outer_privilege;
                                 ^
                                  = false

Rework so all the ksft_exit_*() functions have attribue
'__attribute__((noreturn))' so the compiler knows that there wont be
any return from the function. That said, without
'__attribute__((noreturn))' the compiler warns about the above issue
since it thinks that it will get back from the ksft_exit_skip()
function, which it wont.
Cleaning up the callers that rely on ksft_exit_*() return code, since
the functions ksft_exit_*() have never returned anything.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/clone3/clone3.c              |  2 +-
 .../testing/selftests/clone3/clone3_clear_sighand.c  |  2 +-
 tools/testing/selftests/clone3/clone3_set_tid.c      |  2 +-
 tools/testing/selftests/ipc/msgque.c                 | 10 +++++-----
 tools/testing/selftests/kcmp/kcmp_test.c             |  2 +-
 tools/testing/selftests/kselftest.h                  | 12 ++++++------
 .../membarrier/membarrier_test_multi_thread.c        |  2 +-
 .../membarrier/membarrier_test_single_thread.c       |  2 +-
 tools/testing/selftests/openat2/openat2_test.c       |  5 +----
 tools/testing/selftests/pidfd/pidfd_fdinfo_test.c    |  2 +-
 tools/testing/selftests/pidfd/pidfd_open_test.c      |  2 +-
 tools/testing/selftests/pidfd/pidfd_poll_test.c      |  2 +-
 tools/testing/selftests/pidfd/pidfd_test.c           |  2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c      |  6 +++---
 tools/testing/selftests/sync/sync_test.c             |  2 +-
 tools/testing/selftests/timers/adjtick.c             |  5 +----
 tools/testing/selftests/timers/alarmtimer-suspend.c  |  4 +---
 tools/testing/selftests/timers/change_skew.c         |  7 +------
 tools/testing/selftests/timers/clocksource-switch.c  |  4 +---
 tools/testing/selftests/timers/freq-step.c           |  5 +----
 tools/testing/selftests/timers/inconsistency-check.c |  4 ++--
 tools/testing/selftests/timers/leap-a-day.c          | 10 +++++-----
 tools/testing/selftests/timers/leapcrash.c           |  4 ++--
 tools/testing/selftests/timers/mqueue-lat.c          |  7 +------
 tools/testing/selftests/timers/nanosleep.c           |  4 ++--
 tools/testing/selftests/timers/nsleep-lat.c          |  4 ++--
 tools/testing/selftests/timers/posix_timers.c        | 12 ++++++------
 tools/testing/selftests/timers/raw_skew.c            |  6 +++---
 tools/testing/selftests/timers/set-2038.c            |  4 ++--
 tools/testing/selftests/timers/set-tai.c             |  4 ++--
 tools/testing/selftests/timers/set-timer-lat.c       |  4 ++--
 tools/testing/selftests/timers/set-tz.c              |  4 ++--
 tools/testing/selftests/timers/skew_consistency.c    |  4 ++--
 tools/testing/selftests/timers/threadtest.c          |  2 +-
 tools/testing/selftests/timers/valid-adjtimex.c      |  6 +++---
 tools/testing/selftests/vm/madv_populate.c           |  2 +-
 36 files changed, 69 insertions(+), 92 deletions(-)

diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
index 42be3b925830..1138a8159782 100644
--- a/tools/testing/selftests/clone3/clone3.c
+++ b/tools/testing/selftests/clone3/clone3.c
@@ -191,5 +191,5 @@ int main(int argc, char *argv[])
 	test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
 			CLONE3_ARGS_NO_TEST);
 
-	return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
+	ksft_exit(!ksft_get_fail_cnt());
 }
diff --git a/tools/testing/selftests/clone3/clone3_clear_sighand.c b/tools/testing/selftests/clone3/clone3_clear_sighand.c
index 47a8c0fc3676..dcd9448eaeec 100644
--- a/tools/testing/selftests/clone3/clone3_clear_sighand.c
+++ b/tools/testing/selftests/clone3/clone3_clear_sighand.c
@@ -124,5 +124,5 @@ int main(int argc, char **argv)
 
 	test_clone3_clear_sighand();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/clone3/clone3_set_tid.c b/tools/testing/selftests/clone3/clone3_set_tid.c
index 0229e9ebb995..c6f6625acba9 100644
--- a/tools/testing/selftests/clone3/clone3_set_tid.c
+++ b/tools/testing/selftests/clone3/clone3_set_tid.c
@@ -393,5 +393,5 @@ int main(int argc, char *argv[])
 out:
 	ret = 0;
 
-	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+	ksft_exit(!ret);
 }
diff --git a/tools/testing/selftests/ipc/msgque.c b/tools/testing/selftests/ipc/msgque.c
index 656c43c24044..21dd6af76b21 100644
--- a/tools/testing/selftests/ipc/msgque.c
+++ b/tools/testing/selftests/ipc/msgque.c
@@ -198,13 +198,13 @@ int main(int argc, char **argv)
 	struct msgque_data msgque;
 
 	if (getuid() != 0)
-		return ksft_exit_skip(
+		ksft_exit_skip(
 				"Please run the test as root - Exiting.\n");
 
 	msgque.key = ftok(argv[0], 822155650);
 	if (msgque.key == -1) {
 		printf("Can't make key: %d\n", -errno);
-		return ksft_exit_fail();
+		ksft_exit_fail();
 	}
 
 	msgque.msq_id = msgget(msgque.key, IPC_CREAT | IPC_EXCL | 0666);
@@ -243,13 +243,13 @@ int main(int argc, char **argv)
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
diff --git a/tools/testing/selftests/kcmp/kcmp_test.c b/tools/testing/selftests/kcmp/kcmp_test.c
index 6ea7b9f37a41..4e0776c044d1 100644
--- a/tools/testing/selftests/kcmp/kcmp_test.c
+++ b/tools/testing/selftests/kcmp/kcmp_test.c
@@ -162,5 +162,5 @@ int main(int argc, char **argv)
 
 	waitpid(pid2, &status, P_ALL);
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 8d50483fe204..e47f634bf5c0 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -207,13 +207,13 @@ static inline void ksft_test_result_error(const char *msg, ...)
 	va_end(args);
 }
 
-static inline int ksft_exit_pass(void)
+static inline void __attribute__((noreturn)) ksft_exit_pass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_PASS);
 }
 
-static inline int ksft_exit_fail(void)
+static inline void __attribute__((noreturn)) ksft_exit_fail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_FAIL);
@@ -231,7 +231,7 @@ static inline int ksft_exit_fail(void)
 		ksft_exit_fail();	\
 	} while (0)
 
-static inline int ksft_exit_fail_msg(const char *msg, ...)
+static inline void __attribute__((noreturn)) ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -246,19 +246,19 @@ static inline int ksft_exit_fail_msg(const char *msg, ...)
 	exit(KSFT_FAIL);
 }
 
-static inline int ksft_exit_xfail(void)
+static inline void __attribute__((noreturn)) ksft_exit_xfail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XFAIL);
 }
 
-static inline int ksft_exit_xpass(void)
+static inline void __attribute__((noreturn)) ksft_exit_xpass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XPASS);
 }
 
-static inline int ksft_exit_skip(const char *msg, ...)
+static inline void __attribute__((noreturn)) ksft_exit_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
diff --git a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
index ac5613e5b0eb..b055625e4eb5 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_multi_thread.c
@@ -69,5 +69,5 @@ int main(int argc, char **argv)
 	/* Multi-threaded */
 	test_mt_membarrier();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
index c1c963902854..daec48e0b6f2 100644
--- a/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
+++ b/tools/testing/selftests/membarrier/membarrier_test_single_thread.c
@@ -20,5 +20,5 @@ int main(int argc, char **argv)
 
 	test_membarrier_success();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/openat2/openat2_test.c b/tools/testing/selftests/openat2/openat2_test.c
index 1bddbe934204..b33f548bfca9 100644
--- a/tools/testing/selftests/openat2/openat2_test.c
+++ b/tools/testing/selftests/openat2/openat2_test.c
@@ -320,8 +320,5 @@ int main(int argc, char **argv)
 	test_openat2_struct();
 	test_openat2_flags();
 
-	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
-		ksft_exit_fail();
-	else
-		ksft_exit_pass();
+	ksft_exit(!(ksft_get_fail_cnt() + ksft_get_error_cnt()));
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
index 22558524f71c..d6c5cfd1c4c6 100644
--- a/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_fdinfo_test.c
@@ -292,5 +292,5 @@ int main(int argc, char **argv)
 	test_pidfd_fdinfo_nspid();
 	test_pidfd_dead_fdinfo();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index 8a59438ccc78..7cad4ccfc347 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -159,5 +159,5 @@ int main(int argc, char **argv)
 	if (pidfd >= 0)
 		close(pidfd);
 
-	return !ret ? ksft_exit_pass() : ksft_exit_fail();
+	ksft_exit(!ret);
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
index 529eb700ac26..4a4ab7e25796 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -569,5 +569,5 @@ int main(int argc, char **argv)
 	test_pidfd_send_signal_exited_fail();
 	test_pidfd_send_signal_recycled_pid_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 973f09a66e1e..e1cf5a73571b 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 	 * 2. We execute perf commands
 	 */
 	if (geteuid() != 0)
-		return ksft_exit_fail_msg("Not running as root, abort testing.\n");
+		ksft_exit_fail_msg("Not running as root, abort testing.\n");
 
 	/* Detect AMD vendor */
 	detect_amd();
@@ -235,7 +235,7 @@ int main(int argc, char **argv)
 	sprintf(bm_type, "fill_buf");
 
 	if (!check_resctrlfs_support())
-		return ksft_exit_fail_msg("resctrl FS does not exist\n");
+		ksft_exit_fail_msg("resctrl FS does not exist\n");
 
 	filter_dmesg();
 
@@ -255,5 +255,5 @@ int main(int argc, char **argv)
 
 	umount_resctrlfs();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/sync/sync_test.c b/tools/testing/selftests/sync/sync_test.c
index 414a617db993..aec7057696de 100644
--- a/tools/testing/selftests/sync/sync_test.c
+++ b/tools/testing/selftests/sync/sync_test.c
@@ -110,5 +110,5 @@ int main(void)
 					err, ksft_test_num());
 
 	/* need this return to keep gcc happy */
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/adjtick.c b/tools/testing/selftests/timers/adjtick.c
index 54d8d87f36b3..c917129f142f 100644
--- a/tools/testing/selftests/timers/adjtick.c
+++ b/tools/testing/selftests/timers/adjtick.c
@@ -204,8 +204,5 @@ int main(int argv, char **argc)
 
 	adjtimex(&tx1);
 
-	if (err)
-		return ksft_exit_fail();
-
-	return ksft_exit_pass();
+	ksft_exit(!err);
 }
diff --git a/tools/testing/selftests/timers/alarmtimer-suspend.c b/tools/testing/selftests/timers/alarmtimer-suspend.c
index 4da09dbf83ba..c7c175f3f918 100644
--- a/tools/testing/selftests/timers/alarmtimer-suspend.c
+++ b/tools/testing/selftests/timers/alarmtimer-suspend.c
@@ -172,7 +172,5 @@ int main(void)
 		}
 		timer_delete(tm1);
 	}
-	if (final_ret)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+	ksft_exit(!final_ret);
 }
diff --git a/tools/testing/selftests/timers/change_skew.c b/tools/testing/selftests/timers/change_skew.c
index c4eab7124990..afd65745e7c2 100644
--- a/tools/testing/selftests/timers/change_skew.c
+++ b/tools/testing/selftests/timers/change_skew.c
@@ -87,10 +87,5 @@ int main(int argv, char **argc)
 	tx.offset = 0;
 	adjtimex(&tx);
 
-	if (ret) {
-		printf("[FAIL]");
-		return ksft_exit_fail();
-	}
-	printf("[OK]");
-	return ksft_exit_pass();
+	ksft_exit(!ret);
 }
diff --git a/tools/testing/selftests/timers/clocksource-switch.c b/tools/testing/selftests/timers/clocksource-switch.c
index ef8eb3604595..41bce2ed8ef4 100644
--- a/tools/testing/selftests/timers/clocksource-switch.c
+++ b/tools/testing/selftests/timers/clocksource-switch.c
@@ -162,7 +162,5 @@ int main(int argv, char **argc)
 out:
 	change_clocksource(orig_clk);
 
-	if (status)
-		return ksft_exit_fail();
-	return ksft_exit_pass();
+	ksft_exit(!status);
 }
diff --git a/tools/testing/selftests/timers/freq-step.c b/tools/testing/selftests/timers/freq-step.c
index 4b76450d78d1..f060fa5450d1 100644
--- a/tools/testing/selftests/timers/freq-step.c
+++ b/tools/testing/selftests/timers/freq-step.c
@@ -256,8 +256,5 @@ int main(int argc, char **argv)
 
 	set_frequency(0.0);
 
-	if (fails)
-		return ksft_exit_fail();
-
-	return ksft_exit_pass();
+	ksft_exit(!fails);
 }
diff --git a/tools/testing/selftests/timers/inconsistency-check.c b/tools/testing/selftests/timers/inconsistency-check.c
index 022d3ffe3fbf..71362be52dc8 100644
--- a/tools/testing/selftests/timers/inconsistency-check.c
+++ b/tools/testing/selftests/timers/inconsistency-check.c
@@ -186,8 +186,8 @@ int main(int argc, char *argv[])
 		if (!clock_gettime(clockid, &ts)) {
 			printf("Consistent %-30s ", clockstring(clockid));
 			if (consistency_test(clockid, runtime))
-				return ksft_exit_fail();
+				ksft_exit_fail();
 		}
 	}
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
index 7916cf5cc6ff..66feb333ff98 100644
--- a/tools/testing/selftests/timers/mqueue-lat.c
+++ b/tools/testing/selftests/timers/mqueue-lat.c
@@ -105,10 +105,5 @@ int main(int argc, char **argv)
 	fflush(stdout);
 
 	ret = mqueue_lat_test();
-	if (ret < 0) {
-		printf("[FAILED]\n");
-		return ksft_exit_fail();
-	}
-	printf("[OK]\n");
-	return ksft_exit_pass();
+	ksft_exit(!ret);
 }
diff --git a/tools/testing/selftests/timers/nanosleep.c b/tools/testing/selftests/timers/nanosleep.c
index 71b5441c2fd9..40ff3d710d66 100644
--- a/tools/testing/selftests/timers/nanosleep.c
+++ b/tools/testing/selftests/timers/nanosleep.c
@@ -153,7 +153,7 @@ int main(int argc, char **argv)
 			}
 			if (ret < 0) {
 				printf("[FAILED]\n");
-				return ksft_exit_fail();
+				ksft_exit_fail();
 			}
 			length *= 100;
 		}
@@ -161,5 +161,5 @@ int main(int argc, char **argv)
 next:
 		ret = 0;
 	}
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/nsleep-lat.c b/tools/testing/selftests/timers/nsleep-lat.c
index eb3e79ed7b4a..4c201a06cb94 100644
--- a/tools/testing/selftests/timers/nsleep-lat.c
+++ b/tools/testing/selftests/timers/nsleep-lat.c
@@ -172,9 +172,9 @@ int main(int argc, char **argv)
 		}
 		if (ret < 0) {
 			printf("[FAILED]\n");
-			return ksft_exit_fail();
+			ksft_exit_fail();
 		}
 		printf("[OK]\n");
 	}
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/posix_timers.c b/tools/testing/selftests/timers/posix_timers.c
index 0ba500056e63..337424c5c987 100644
--- a/tools/testing/selftests/timers/posix_timers.c
+++ b/tools/testing/selftests/timers/posix_timers.c
@@ -194,16 +194,16 @@ int main(int argc, char **argv)
 	printf("based timers if other threads run on the CPU...\n");
 
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
@@ -215,7 +215,7 @@ int main(int argc, char **argv)
 	 * find a better solution.
 	 */
 	if (check_timer_create(CLOCK_PROCESS_CPUTIME_ID) < 0)
-		return ksft_exit_fail();
+		ksft_exit_fail();
 
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/timers/raw_skew.c b/tools/testing/selftests/timers/raw_skew.c
index b41d8dd0c40c..b58639a7d19d 100644
--- a/tools/testing/selftests/timers/raw_skew.c
+++ b/tools/testing/selftests/timers/raw_skew.c
@@ -138,11 +138,11 @@ int main(int argv, char **argc)
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
index 8066be9aff11..bfeaac8d870d 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -70,8 +70,8 @@ int main(int argv, char **argc)
 
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
index 5397de708d3c..48804223eb4d 100644
--- a/tools/testing/selftests/timers/valid-adjtimex.c
+++ b/tools/testing/selftests/timers/valid-adjtimex.c
@@ -321,10 +321,10 @@ int validate_set_offset(void)
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
diff --git a/tools/testing/selftests/vm/madv_populate.c b/tools/testing/selftests/vm/madv_populate.c
index 3ee0e8275600..5f2f8ad32248 100644
--- a/tools/testing/selftests/vm/madv_populate.c
+++ b/tools/testing/selftests/vm/madv_populate.c
@@ -325,5 +325,5 @@ int main(int argc, char **argv)
 	if (err)
 		ksft_exit_fail_msg("%d out of %d tests failed\n",
 				   err, ksft_test_num());
-	return ksft_exit_pass();
+	ksft_exit_pass();
 }
-- 
2.33.0

