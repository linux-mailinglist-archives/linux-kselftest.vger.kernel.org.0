Return-Path: <linux-kselftest+bounces-7719-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FB438A1F49
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 21:15:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CC7CB34FDC
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F57D205E15;
	Thu, 11 Apr 2024 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p3B6pkBa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685D314A9F;
	Thu, 11 Apr 2024 18:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712861150; cv=none; b=HcyuPN3rNShttYycCZrJsdmmeYPz628JFwxGhlTYlRMQmouOpjKE5lFZOcQ+HIS195fHkxIg0KJdUrJurAMtwkebE5UQTW8+E+zxBUKXpQ7SONqtRPc8zzLiMBCvfBNRZgACSs33by7LzroRWus/2ZmbRn7lW5DO4/5toRAhljs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712861150; c=relaxed/simple;
	bh=3J9KwOZ8VsQ0/GJ7lg9iQ4h/nYIgnKWTHARE6B+5FCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jSsnRCjb4+L3e46L4S2MxMZE6dxqToMbfwi2t2Fz9FFw/rrEfyB8qodnQAiadCqWeiqMf/5UxA/92CGqXGJyECfyxLqaF5SR/GGyCMGBZka4H4okkmJW+0k7SQre2cXVT0PzfdEwqTn7NtwbqqnlnKlBlyVl8UHCennTC2RbL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p3B6pkBa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F0F5C072AA;
	Thu, 11 Apr 2024 18:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712861150;
	bh=3J9KwOZ8VsQ0/GJ7lg9iQ4h/nYIgnKWTHARE6B+5FCo=;
	h=From:Date:Subject:To:Cc:From;
	b=p3B6pkBaCq00VhNmJ52+mGzQlu8zn1zqfs+z97qHqFk0h3vwoeMThLDKndm10X8kU
	 wMzURSiapu5/IiVqMuEaGb5RBdkp/bS1wRCfOAzmAugCs+KUaQhuN6jgEnc2Tg4YHE
	 sV5YVGRQSNSLu3oq98xbAFLP35RVKqZ1S84mHoPcuzzuH3Yh98NhNfLKqf10DoVOb4
	 KJQJHF+vLun7Wl1+27WUkY+PWNmCwHR9bEM5YKpSBTsIMQGpjnwVIcorqammL/1YFv
	 sVS9BMX38YQkOrvWLvaHnH0Rzelf4BAAjA/rwxaEwTqjN6dO7xrPVTLmVIgE7AmoX3
	 D0LQlJLz1Q2fA==
From: Nathan Chancellor <nathan@kernel.org>
Date: Thu, 11 Apr 2024 11:45:40 -0700
Subject: [PATCH] kselftest: Mark functions that unconditionally call exit()
 as __noreturn
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-mark-kselftest-exit-funcs-noreturn-v1-1-b027c948f586@kernel.org>
X-B4-Tracking: v=1; b=H4sIANMvGGYC/x3NQQqDQAxA0atI1gacQZjaqxQXgyZt0MaSjEUQ7
 96hy7f5/wQnE3K4NycYfcVl04rQNjC9sj4JZa6G2MW+60PAd7YFF6eVC3lBOqQg7zo56mZUdlM
 Mab4xpzjklKGGPkYsx3/yGK/rB/dzO1p0AAAA
To: tglx@linutronix.de, shuah@kernel.org
Cc: oleg@redhat.com, anna-maria@linutronix.de, frederic@kernel.org, 
 ndesaulniers@google.com, morbo@google.com, justinstitt@google.com, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, patches@lists.linux.dev, 
 John Stultz <jstultz@google.com>, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=5035; i=nathan@kernel.org;
 h=from:subject:message-id; bh=3J9KwOZ8VsQ0/GJ7lg9iQ4h/nYIgnKWTHARE6B+5FCo=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDGkS+nfLRXd8jN7zsOrXlfr8pKf94ef91P9yMPIvC+l/N
 7N9DUNvRykLgxgXg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZhIbwUjw+WSvR4MHkZbA5s4
 xZ9Upk1Xe1uvK624+ZxSvxb/hdtahowMq3Uas7P+O012m+8sZL3p9dw3u6ec8rpt+tJJOuaC4PU
 qJgA=
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

After commit 6d029c25b71f ("selftests/timers/posix_timers: Reimplement
check_timer_distribution()"), clang warns:

  tools/testing/selftests/timers/../kselftest.h:398:6: warning: variable 'major' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
    398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
        |             ^~~~~~~~~~~~
  tools/testing/selftests/timers/../kselftest.h:401:9: note: uninitialized use occurs here
    401 |         return major > min_major || (major == min_major && minor >= min_minor);
        |                ^~~~~
  tools/testing/selftests/timers/../kselftest.h:398:6: note: remove the '||' if its condition is always false
    398 |         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
        |             ^~~~~~~~~~~~~~~
  tools/testing/selftests/timers/../kselftest.h:395:20: note: initialize the variable 'major' to silence this warning
    395 |         unsigned int major, minor;
        |                           ^
        |                            = 0

This is a false positive because if uname() fails, ksft_exit_fail_msg()
will be called, which unconditionally calls exit(), a noreturn function.
However, clang does not know that ksft_exit_fail_msg() will call exit()
at the point in the pipeline that the warning is emitted because
inlining has not occurred, so it assumes control flow will resume
normally after ksft_exit_fail_msg() is called.

Make it clear to clang that all of the functions that call exit()
unconditionally in kselftest.h are noreturn transitively by marking them
explicitly with '__attribute__((__noreturn__))', which clears up the
warning above and any future warnings that may appear for the same
reason.

Fixes: 6d029c25b71f ("selftests/timers/posix_timers: Reimplement check_timer_distribution()")
Reported-by: John Stultz <jstultz@google.com>
Closes: https://lore.kernel.org/all/20240410232637.4135564-2-jstultz@google.com/
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
I have based this change on timers/urgent, as the commit that introduces
this particular warning is there and it is marked for stable, even
though this appears to be a generic kselftest issue. I think it makes
the most sense for this change to go via timers/urgent with Shuah's ack.
While __noreturn with a return type other than 'void' does not make much
sense semantically, there are many places that these functions are used
as the return value for other functions such as main(), so I did not
change the return type of these functions from 'int' to 'void' to
minimize the necessary changes for a backport (it is an existing issue
anyways).

I see there is another instance of this problem that will need to be
addressed in -next, introduced by commit f07041728422 ("selftests: add
ksft_exit_fail_perror()").
---
 tools/testing/selftests/kselftest.h | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 973b18e156b2..0591974b57e0 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -80,6 +80,9 @@
 #define KSFT_XPASS 3
 #define KSFT_SKIP  4
 
+#ifndef __noreturn
+#define __noreturn       __attribute__((__noreturn__))
+#endif
 #define __printf(a, b)   __attribute__((format(printf, a, b)))
 
 /* counters */
@@ -300,13 +303,13 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 	va_end(args);
 }
 
-static inline int ksft_exit_pass(void)
+static inline __noreturn int ksft_exit_pass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_PASS);
 }
 
-static inline int ksft_exit_fail(void)
+static inline __noreturn int ksft_exit_fail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_FAIL);
@@ -333,7 +336,7 @@ static inline int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
+static inline __noreturn __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -348,19 +351,19 @@ static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 	exit(KSFT_FAIL);
 }
 
-static inline int ksft_exit_xfail(void)
+static inline __noreturn int ksft_exit_xfail(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XFAIL);
 }
 
-static inline int ksft_exit_xpass(void)
+static inline __noreturn int ksft_exit_xpass(void)
 {
 	ksft_print_cnts();
 	exit(KSFT_XPASS);
 }
 
-static inline __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
+static inline __noreturn __printf(1, 2) int ksft_exit_skip(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;

---
base-commit: 076361362122a6d8a4c45f172ced5576b2d4a50d
change-id: 20240411-mark-kselftest-exit-funcs-noreturn-17d8ff729a7a

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


