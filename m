Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD6749F5C5
	for <lists+linux-kselftest@lfdr.de>; Fri, 28 Jan 2022 09:58:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiA1I6H (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 28 Jan 2022 03:58:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:36444 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiA1I6G (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 28 Jan 2022 03:58:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9C870B824EA;
        Fri, 28 Jan 2022 08:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E563C340E6;
        Fri, 28 Jan 2022 08:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643360284;
        bh=VybN4pzch65oeAi5HDL+8lwtT0cmSDE01H8knqAz1I4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eenZ5YRl7LyQLTevsJfI1fCgyoQtVIXJR5MbbBTleOdl/EtGMroCvwYxgxEqnx1Vp
         GAGWMZoDRevJBqn1HGs52PgOPYagQ1nCVGKaoBEBjwvnkEfY6MWsn4Nw64ohiS4bbg
         4jy7S30AUDvZt1qd1cZcbAmKwKUiZ4kYzRfJM3eupsLGcyWuwlGeLofphxG6E6z77/
         hUk1gUrMmO4b8jLyqCH1hzend12wNy83S20a+xoS9tLYcEwYVnx2ww4+W7mMcS1VPZ
         zGk2Hhzr07GZkB64mKNr2RYQAdfEGjCyiDeGXY614sira832gTeO/D4W33i9KU79SC
         9rGxhdl/xCbYg==
Date:   Fri, 28 Jan 2022 09:57:59 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Zach O'Keefe <zokeefe@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] selftests: fixup build warnings in pidfd / clone3 tests
Message-ID: <20220128085759.qgn7o3w57d6oknzv@wittgenstein>
References: <20220127221115.3731388-1-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127221115.3731388-1-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jan 27, 2022 at 02:11:15PM -0800, Axel Rasmussen wrote:
> These are some trivial fixups, which were needed to build the tests with
> clang and -Werror. The following issues are fixed:
> 
> - Remove various unused variables.
> - In child_poll_leader_exit_test, clang isn't smart enough to realize
>   syscall(SYS_exit, 0) won't return, so it complains we never return
>   from a non-void function. Add an extra exit(0) to appease it.
> - In test_pidfd_poll_leader_exit, ret may be branched on despite being
>   uninitialized, if we have !use_waitpid. Initialize it to zero to get
>   the right behavior in that case.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
> ---

Thanks!
(Fwiw, all those tests should also be ported to use the TEST_*() harness
infra. Currently it's an annoying mix.)
Acked-by: Christian Brauner <brauner@kernel.org>

>  tools/testing/selftests/clone3/clone3.c    | 2 --
>  tools/testing/selftests/pidfd/pidfd_test.c | 6 +++---
>  tools/testing/selftests/pidfd/pidfd_wait.c | 5 ++---
>  3 files changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> index 076cf4325f78..cd4582129c7d 100644
> --- a/tools/testing/selftests/clone3/clone3.c
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -126,8 +126,6 @@ static void test_clone3(uint64_t flags, size_t size, int expected,
>  
>  int main(int argc, char *argv[])
>  {
> -	pid_t pid;
> -
>  	uid_t uid = getuid();
>  
>  	ksft_print_header();
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index 529eb700ac26..9a2d64901d59 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -441,7 +441,6 @@ static void test_pidfd_poll_exec(int use_waitpid)
>  {
>  	int pid, pidfd = 0;
>  	int status, ret;
> -	pthread_t t1;
>  	time_t prog_start = time(NULL);
>  	const char *test_name = "pidfd_poll check for premature notification on child thread exec";
>  
> @@ -500,13 +499,14 @@ static int child_poll_leader_exit_test(void *args)
>  	 */
>  	*child_exit_secs = time(NULL);
>  	syscall(SYS_exit, 0);
> +	/* Never reached, but appeases compiler thinking we should return. */
> +	exit(0);
>  }
>  
>  static void test_pidfd_poll_leader_exit(int use_waitpid)
>  {
>  	int pid, pidfd = 0;
> -	int status, ret;
> -	time_t prog_start = time(NULL);
> +	int status, ret = 0;
>  	const char *test_name = "pidfd_poll check for premature notification on non-empty"
>  				"group leader exit";
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd_wait.c b/tools/testing/selftests/pidfd/pidfd_wait.c
> index be2943f072f6..17999e082aa7 100644
> --- a/tools/testing/selftests/pidfd/pidfd_wait.c
> +++ b/tools/testing/selftests/pidfd/pidfd_wait.c
> @@ -39,7 +39,7 @@ static int sys_waitid(int which, pid_t pid, siginfo_t *info, int options,
>  
>  TEST(wait_simple)
>  {
> -	int pidfd = -1, status = 0;
> +	int pidfd = -1;
>  	pid_t parent_tid = -1;
>  	struct clone_args args = {
>  		.parent_tid = ptr_to_u64(&parent_tid),
> @@ -47,7 +47,6 @@ TEST(wait_simple)
>  		.flags = CLONE_PIDFD | CLONE_PARENT_SETTID,
>  		.exit_signal = SIGCHLD,
>  	};
> -	int ret;
>  	pid_t pid;
>  	siginfo_t info = {
>  		.si_signo = 0,
> @@ -88,7 +87,7 @@ TEST(wait_simple)
>  
>  TEST(wait_states)
>  {
> -	int pidfd = -1, status = 0;
> +	int pidfd = -1;
>  	pid_t parent_tid = -1;
>  	struct clone_args args = {
>  		.parent_tid = ptr_to_u64(&parent_tid),
> -- 
> 2.35.0.rc2.247.g8bbb082509-goog
> 
