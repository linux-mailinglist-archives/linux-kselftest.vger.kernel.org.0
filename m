Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8532060A0
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jun 2020 22:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392056AbgFWUos (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 23 Jun 2020 16:44:48 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34879 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390082AbgFWUon (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 23 Jun 2020 16:44:43 -0400
Received: from ip5f5af08c.dynamic.kabel-deutschland.de ([95.90.240.140] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jnpmb-0002XV-Ib; Tue, 23 Jun 2020 20:44:41 +0000
Date:   Tue, 23 Jun 2020 22:44:41 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH v2 4/6] selftests: pidfd: do not use ksft_exit_skip after
 ksft_set_plan
Message-ID: <20200623204441.phngiwlj2idonpe6@wittgenstein>
References: <20200623001547.22255-1-pbonzini@redhat.com>
 <20200623001547.22255-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200623001547.22255-5-pbonzini@redhat.com>
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Jun 22, 2020 at 08:15:45PM -0400, Paolo Bonzini wrote:
> Calling ksft_exit_skip after ksft_set_plan results in executing fewer tests
> than planned.  Use ksft_test_result_skip instead.
> 
> The plan passed to ksft_set_plan was wrong, too, so fix it while at it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Thanks for the patch!
Hm, this series misses a bunch of Cces for the maintainers of these files...
(Also note that Kees has a/some series with most of us Cced that might
conflict with some of these changes. But not sure rn.)

A comment below.

>  tools/testing/selftests/pidfd/pidfd_test.c | 39 ++++++++++++++++++----
>  1 file changed, 33 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index 7aff2d3b42c0..380c6314e6a2 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -8,6 +8,7 @@
>  #include <sched.h>
>  #include <signal.h>
>  #include <stdio.h>
> +#include <stdbool.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <syscall.h>
> @@ -27,6 +28,8 @@
>  
>  #define MAX_EVENTS 5
>  
> +static bool have_pidfd_send_signal = false;
> +
>  static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
>  {
>  	size_t stack_size = 1024;
> @@ -56,6 +59,13 @@ static int test_pidfd_send_signal_simple_success(void)
>  	int pidfd, ret;
>  	const char *test_name = "pidfd_send_signal send SIGUSR1";
>  
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>  	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
>  	if (pidfd < 0)
>  		ksft_exit_fail_msg(
> @@ -86,6 +96,13 @@ static int test_pidfd_send_signal_exited_fail(void)
>  	pid_t pid;
>  	const char *test_name = "pidfd_send_signal signal exited process";
>  
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>  	pid = fork();
>  	if (pid < 0)
>  		ksft_exit_fail_msg("%s test: Failed to create new process\n",
> @@ -137,6 +154,13 @@ static int test_pidfd_send_signal_recycled_pid_fail(void)
>  	pid_t pid1;
>  	const char *test_name = "pidfd_send_signal signal recycled pid";
>  
> +	if (!have_pidfd_send_signal) {
> +		ksft_test_result_skip(
> +			"%s test: pidfd_send_signal() syscall not supported\n",
> +			test_name);
> +		return 0;
> +	}
> +
>  	ret = unshare(CLONE_NEWPID);
>  	if (ret < 0)
>  		ksft_exit_fail_msg("%s test: Failed to unshare pid namespace\n",
> @@ -325,13 +349,16 @@ static int test_pidfd_send_signal_syscall_support(void)
>  
>  	ret = sys_pidfd_send_signal(pidfd, 0, NULL, 0);
>  	if (ret < 0) {
> -		if (errno == ENOSYS)
> -			ksft_exit_skip(
> +		if (errno == ENOSYS) {
> +			ksft_test_result_skip(
>  				"%s test: pidfd_send_signal() syscall not supported\n",
>  				test_name);

If pidfd_send_signal() is not supported, you're falling through and then
you're reporting:

ok 5 # SKIP pidfd_send_signal check for support test: pidfd_send_signal() syscall not supported
ok 6 pidfd_send_signal check for support test: pidfd_send_signal() syscall is supported. Tests can be executed

which seems wrong.

> -
> -		ksft_exit_fail_msg("%s test: Failed to send signal\n",
> -				   test_name);
> +		} else {
> +			ksft_exit_fail_msg("%s test: Failed to send signal\n",
> +					   test_name);
> +		}
> +	} else {
> +		have_pidfd_send_signal = true;
>  	}
>  
>  	close(pidfd);
> @@ -521,7 +548,7 @@ static void test_pidfd_poll_leader_exit(int use_waitpid)
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
> -	ksft_set_plan(4);
> +	ksft_set_plan(8);
>  
>  	test_pidfd_poll_exec(0);
>  	test_pidfd_poll_exec(1);
> -- 
> 2.26.2
> 
> 
