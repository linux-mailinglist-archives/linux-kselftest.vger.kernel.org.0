Return-Path: <linux-kselftest+bounces-12458-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 750E8912CF0
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 20:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0461E1F22E5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 21 Jun 2024 18:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3548B178CEC;
	Fri, 21 Jun 2024 18:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="YGHI9Wrr"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-8fae.mail.infomaniak.ch (smtp-8fae.mail.infomaniak.ch [83.166.143.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65B7178CCD
	for <linux-kselftest@vger.kernel.org>; Fri, 21 Jun 2024 18:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718993188; cv=none; b=ZJuYvUZj5lcU5wgkSx+GrplQZnNcpz3BG9wnh0qEouqzYFL7lrJEL8wnPdkaxl7JZZJ+3QsY5ygsnOALfP01eZJOuoOQP542IKyrUZSiGVvWKEt2k13nE7Xo+x7rgTQifrdF6Zzu//0BvkUbSd0ShruPL8CJ1+gad56BfrSFgzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718993188; c=relaxed/simple;
	bh=G1+LMnVYjuipUm7A53Qs1WbYqgdsKBtjjKsWuTWGXxE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uCAbRocPUjN8QWevZOwkjfmem4vAt2SyCI7YmGJLNL11V4/+wo62aI9O0GZXddsMnxNg/97iCprE775bNZ9COPLcB3UAQaJTyUNNmulmqfeJwluNoYvWxeLolIDvncKybbu1XIL2pxD88kgTK+SIdvfAZN8DZClfDg8lX/cZk7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=YGHI9Wrr; arc=none smtp.client-ip=83.166.143.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4W5QK92v4LzPFs;
	Fri, 21 Jun 2024 20:06:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1718993181;
	bh=6zm24rznEW9/wKRnfzUKzbrn4dwriuF/US2vViMaVSs=;
	h=From:To:Cc:Subject:Date:From;
	b=YGHI9WrrckgcP33dYfqWS92FX0inLWuu+RUeMrATGaGmqr0ZLJEmXUP5nzRBmZFO3
	 oZgAMU7R1BZVI1eiDu10BPeRfpEMMoGqryfFh+swMp9vuDfSF7r/llDi9vQBdjzoy+
	 vQLJSzdOS1bwkzNSzTEY1GnLCtyuIFjZlmTxJgqg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4W5QK65KCbzQTy;
	Fri, 21 Jun 2024 20:06:18 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mark Brown <broonie@kernel.org>,
	Sean Christopherson <seanjc@google.com>,
	Shengyu Li <shengyu.li.evgeny@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ron Economos <re@w6rz.net>,
	Ronald Warsow <rwarsow@gmx.de>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Will Drewry <wad@chromium.org>,
	kernel test robot <oliver.sang@intel.com>,
	kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v1] selftests/harness: Fix tests timeout and race condition
Date: Fri, 21 Jun 2024 20:06:05 +0200
Message-ID: <20240621180605.834676-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

We cannot use CLONE_VFORK because we also need to wait for the timeout
signal.

Restore tests timeout by using the original fork() call in __run_test()
but also in __TEST_F_IMPL().  Also fix a race condition when waiting for
the test child process.

Because test metadata are shared between test processes, only the
parent process must set the test PID (child).  Otherwise, t->pid may be
set to zero, leading to inconsistent error cases:

  #  RUN           layout1.rule_on_mountpoint ...
  # rule_on_mountpoint: Test ended in some other way [127]
  #            OK  layout1.rule_on_mountpoint
  ok 20 layout1.rule_on_mountpoint

As safeguards, initialize the "status" variable with a valid exit code,
and handle unknown test exits as errors.

The use of fork() introduces a new race condition in landlock/fs_test.c
which seems to be specific to hostfs bind mounts, but I haven't found
the root cause and it's difficult to trigger.  I'll try to fix it with
another patch.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Will Drewry <wad@chromium.org>
Cc: stable@vger.kernel.org
Closes: https://lore.kernel.org/r/9341d4db-5e21-418c-bf9e-9ae2da7877e1@sirena.org.uk
Fixes: a86f18903db9 ("selftests/harness: Fix interleaved scheduling leading to race conditions")
Fixes: 24cf65a62266 ("selftests/harness: Share _metadata between forked processes")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20240621180605.834676-1-mic@digikod.net
---
 tools/testing/selftests/kselftest_harness.h | 43 ++++++++++++---------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index b634969cbb6f..40723a6a083f 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -66,8 +66,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <setjmp.h>
-#include <syscall.h>
-#include <linux/sched.h>
 
 #include "kselftest.h"
 
@@ -82,17 +80,6 @@
 #  define TH_LOG_ENABLED 1
 #endif
 
-/* Wait for the child process to end but without sharing memory mapping. */
-static inline pid_t clone3_vfork(void)
-{
-	struct clone_args args = {
-		.flags = CLONE_VFORK,
-		.exit_signal = SIGCHLD,
-	};
-
-	return syscall(__NR_clone3, &args, sizeof(args));
-}
-
 /**
  * TH_LOG()
  *
@@ -437,7 +424,7 @@ static inline pid_t clone3_vfork(void)
 		} \
 		if (setjmp(_metadata->env) == 0) { \
 			/* _metadata and potentially self are shared with all forks. */ \
-			child = clone3_vfork(); \
+			child = fork(); \
 			if (child == 0) { \
 				fixture_name##_setup(_metadata, self, variant->data); \
 				/* Let setup failure terminate early. */ \
@@ -1016,7 +1003,14 @@ void __wait_for_test(struct __test_metadata *t)
 		.sa_flags = SA_SIGINFO,
 	};
 	struct sigaction saved_action;
-	int status;
+	/*
+	 * Sets status so that WIFEXITED(status) returns true and
+	 * WEXITSTATUS(status) returns KSFT_FAIL.  This safe default value
+	 * should never be evaluated because of the waitpid(2) check and
+	 * SIGALRM handling.
+	 */
+	int status = KSFT_FAIL << 8;
+	int child;
 
 	if (sigaction(SIGALRM, &action, &saved_action)) {
 		t->exit_code = KSFT_FAIL;
@@ -1028,7 +1022,15 @@ void __wait_for_test(struct __test_metadata *t)
 	__active_test = t;
 	t->timed_out = false;
 	alarm(t->timeout);
-	waitpid(t->pid, &status, 0);
+	child = waitpid(t->pid, &status, 0);
+	if (child == -1 && errno != EINTR) {
+		t->exit_code = KSFT_FAIL;
+		fprintf(TH_LOG_STREAM,
+			"# %s: Failed to wait for PID %d (errno: %d)\n",
+			t->name, t->pid, errno);
+		return;
+	}
+
 	alarm(0);
 	if (sigaction(SIGALRM, &saved_action, NULL)) {
 		t->exit_code = KSFT_FAIL;
@@ -1083,6 +1085,7 @@ void __wait_for_test(struct __test_metadata *t)
 				WTERMSIG(status));
 		}
 	} else {
+		t->exit_code = KSFT_FAIL;
 		fprintf(TH_LOG_STREAM,
 			"# %s: Test ended in some other way [%u]\n",
 			t->name,
@@ -1218,6 +1221,7 @@ void __run_test(struct __fixture_metadata *f,
 	struct __test_xfail *xfail;
 	char test_name[1024];
 	const char *diagnostic;
+	int child;
 
 	/* reset test struct */
 	t->exit_code = KSFT_PASS;
@@ -1236,15 +1240,16 @@ void __run_test(struct __fixture_metadata *f,
 	fflush(stdout);
 	fflush(stderr);
 
-	t->pid = clone3_vfork();
-	if (t->pid < 0) {
+	child = fork();
+	if (child < 0) {
 		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
 		t->exit_code = KSFT_FAIL;
-	} else if (t->pid == 0) {
+	} else if (child == 0) {
 		setpgrp();
 		t->fn(t, variant);
 		_exit(t->exit_code);
 	} else {
+		t->pid = child;
 		__wait_for_test(t);
 	}
 	ksft_print_msg("         %4s  %s\n",

base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
-- 
2.45.2


