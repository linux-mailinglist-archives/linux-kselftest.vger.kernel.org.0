Return-Path: <linux-kselftest+bounces-7710-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33AF8A1A4E
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 18:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD0A1C20BC0
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Apr 2024 16:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5716A1D4284;
	Thu, 11 Apr 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WB9pt5su"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295741D4280;
	Thu, 11 Apr 2024 15:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849988; cv=none; b=qijKxSS+Q2m2rq+XJqY+Q3SXGGpFiWTN0Vehmef0E+QOozm/tqS1bumYABTK2SYuT9V+9w64PW+nu59JlCxD7NNtE5QYaTy1yUvIxgCaLXq4X8PxTqMJMfx+7tivvsLY+J3NHoI6lm04Fy1p1oRdSFcCykiJT50ccEyRzKq0f2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849988; c=relaxed/simple;
	bh=BAaUVpCnVLVHiTGwbzDBqzGX029scJjx0KK1ilZVLbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idq/7VxW/6IBBCVk+dzOWW9OIjFxqDC+AdOCT1phN/7AcJiSwXYj8wHKNmgLT98sY3nCXe8DqteVoN7PpgBE/qfgQ9yGLZhsmDWeOd6rQD+JBcmnNzY4u/GLDQNxWMS1awKWF4c0pHwKXVy+cI8jKaJKa/Hs9dd4tX48nYquxB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WB9pt5su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD1CC072AA;
	Thu, 11 Apr 2024 15:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712849987;
	bh=BAaUVpCnVLVHiTGwbzDBqzGX029scJjx0KK1ilZVLbM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WB9pt5suMDCAZ+xxIXJxK9uDd7v0cMO1K2Y4ucIbBGO8Zaf8PQTbLSvsHZ3YQoisE
	 PHwvD+U/QBFUeEhGXeQlOxlHO0AyeLynSlilsv6NtidFwvk1m6m+xnkX5LRXuX7ENf
	 THdjOeZ0iOIV/Vv0eiuvTz3MNz4dyNRqtZ+GLUi30sFczshA3hKVfoyjSGFC80Ad+F
	 Ni21755PZqbAYz12ggyuS+YnYlXdDOkAf9XcxdjL7HCmboTIQXlvBLTFlFQ4k8bvi8
	 KPVwqYC4jQno1yKDQMxNs0X/grVOYt1ffexNVoexNSLCGQEGAz56gVyVVFp8dAS8zF
	 BhmGTvR7EObrQ==
Date: Thu, 11 Apr 2024 08:39:45 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Stephen Boyd <sboyd@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Edward Liaw <edliaw@google.com>,
	Carlos Llamas <cmllamas@google.com>, kernel-team@android.com,
	linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] selftests: timers: Fix uninitialized variable
 warning in ksft_min_kernel_version
Message-ID: <20240411153945.GA2507795@dev-arch.thelio-3990X>
References: <20240410232637.4135564-1-jstultz@google.com>
 <20240410232637.4135564-2-jstultz@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410232637.4135564-2-jstultz@google.com>

On Wed, Apr 10, 2024 at 04:26:29PM -0700, John Stultz wrote:
> Building with clang, I see the following warning:
> 
> In file included from posix_timers.c:17:
> ./../kselftest.h:398:6: warning: variable 'major' is used uninitialized whenever '||' condition is true [-Wsometimes-uninitialized]
>         if (uname(&info) || sscanf(info.release, "%u.%u.", &major, &minor) != 2)
>             ^~~~~~~~~~~~
> ./../kselftest.h:401:9: note: uninitialized use occurs here
>         return major > min_major || (major == min_major && minor >= min_minor);
>                ^~~~~
> 
> This is a bit of a red-herring as if the uname() call did fail,
> we would hit ksft_exit_fail_msg() which should exit.

Correct, although we have not really conveyed that to the compiler,
right? exit() is noreturn, which means all functions that call exit()
unconditionally are also noreturn, such as ksft_exit_fail_msg(). LLVM
will figure this out once it performs inlining and such but that happens
after clang's static analysis phase that this warning occurs in. I think
a better solution would be to add __noreturn to the functions in
tools/testing/selftests/kselftest.h that call exit(), so that the
compiler is aware of this through all pipeline phases, maybe something
like this? It resolves the wawrning for me.

diff --git a/tools/testing/selftests/kselftest.h b/tools/testing/selftests/kselftest.h
index 050c5fd01840..29364c9f3332 100644
--- a/tools/testing/selftests/kselftest.h
+++ b/tools/testing/selftests/kselftest.h
@@ -83,6 +83,7 @@
 #define KSFT_XPASS 3
 #define KSFT_SKIP  4
 
+#define __noreturn       __attribute__((__noreturn__))
 #define __printf(a, b)   __attribute__((format(printf, a, b)))
 
 /* counters */
@@ -324,13 +325,13 @@ void ksft_test_result_code(int exit_code, const char *test_name,
 		break;						\
 	} } while (0)
 
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
@@ -357,7 +358,7 @@ static inline int ksft_exit_fail(void)
 		  ksft_cnt.ksft_xfail +	\
 		  ksft_cnt.ksft_xskip)
 
-static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
+static inline __noreturn __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 {
 	int saved_errno = errno;
 	va_list args;
@@ -372,7 +373,7 @@ static inline __printf(1, 2) int ksft_exit_fail_msg(const char *msg, ...)
 	exit(KSFT_FAIL);
 }
 
-static inline void ksft_exit_fail_perror(const char *msg)
+static inline __noreturn void ksft_exit_fail_perror(const char *msg)
 {
 #ifndef NOLIBC
 	ksft_exit_fail_msg("%s: %s (%d)\n", msg, strerror(errno), errno);
@@ -385,19 +386,19 @@ static inline void ksft_exit_fail_perror(const char *msg)
 #endif
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

