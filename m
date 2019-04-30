Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 952021003D
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbfD3TVD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 15:21:03 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35041 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbfD3TVD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 15:21:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id y67so13325140ede.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Apr 2019 12:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LCKlak7FYJZjHkPSI2bbY7nJMWKoi5EZ2NHkq7EYp70=;
        b=dXZuiMiiQ1YMov/LL6PvqoHhbYAEkbFRRTdKzHCifnKtNK49fwX4yNeXShQCtXqBOq
         yEQRlwiAeEJw7VuTA8jnSMvlQl2Xoc3cvXkBaOlZhRyoq28JoPA1jywWiFdjdtxmfFAR
         RM0uhHa/Gyftu5bXDoR0R36KiYhF9Kb5ap+b9IHYd2BWafL05z3dhBw/T34+TPxV/Jr+
         wRYvCOWsuko9wIIKhUvRCDj6p6AqrBLtb879xe5QfxEoMWA0oOP2AwXEqBkl56B94VY7
         RVkJRfzKUJgTd8eOv00cyyC84J2r7ru7ucAdfhi147L2rrXQJkb66WRlfrHwubi2WwoX
         IvWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCKlak7FYJZjHkPSI2bbY7nJMWKoi5EZ2NHkq7EYp70=;
        b=nOidZMM2F7lqA1rMmYMGcdOJYBXgUY0ptf33NEUIJSEKv/Hp6SL8ThHacUMco6xFtd
         zlsMvSneAZy8xofX2/awAUVUi+deW5YSlowx9YhfbaJJ/JE6IvoWNV4JRPvKIbUSg7Hj
         1RgqABbs+BtLv+9aTvunOHsz/fr8FaAqKWpSV5gfMftZy9dMS+cw7SqdaHkVi2/YVqle
         VQ9jOdTserRBBNsbeZ/GpPPbF1+n20qSiPrLiH1CQxZIHxHIcIynRaiSY8GKdhDBk5if
         +frLsPyd9amNXjWRu/TJcGWZ4mYyo0AwgLQ/XAQbWxAkz238ivB73m11Ff9xJ08rjf0v
         1LVA==
X-Gm-Message-State: APjAAAWvAsFHWXIW/nW1CK2YylhIcMz9GNYeI1nr/hTIrNFwTEYHZiTn
        V2/hZKK/HwOOK1OefAgYZ0/9Vw==
X-Google-Smtp-Source: APXvYqwDoqoVx9/kf4i17lKyFZP6mfr/4+nawYEcxbpCJgPlhw7TcpaW3Q7lps7JmWOn03CRFGAzQw==
X-Received: by 2002:a17:906:69d6:: with SMTP id g22mr2631702ejs.124.1556652061112;
        Tue, 30 Apr 2019 12:21:01 -0700 (PDT)
Received: from brauner.io ([212.91.227.56])
        by smtp.gmail.com with ESMTPSA id 44sm1386526eds.90.2019.04.30.12.20.59
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 30 Apr 2019 12:21:00 -0700 (PDT)
Date:   Tue, 30 Apr 2019 21:20:59 +0200
From:   Christian Brauner <christian@brauner.io>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Colascione <dancol@google.com>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Jonathan Kowalski <bl0pbl33p@gmail.com>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        KJ Tsanaktsidis <ktsanaktsidis@zendesk.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kselftest@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
        Nadav Amit <namit@vmware.com>, Oleg Nesterov <oleg@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Serge Hallyn <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Murray <timmurray@google.com>,
        Tycho Andersen <tycho@tycho.ws>
Subject: Re: [PATCH v2 2/2] Add selftests for pidfd polling
Message-ID: <20190430192057.ocevexvebfq2we3d@brauner.io>
References: <20190430162154.61314-1-joel@joelfernandes.org>
 <20190430162154.61314-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190430162154.61314-2-joel@joelfernandes.org>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 30, 2019 at 12:21:54PM -0400, Joel Fernandes (Google) wrote:
> Other than verifying pidfd based polling, the tests make sure that
> wait semantics are preserved with the pidfd poll. Notably the 2 cases:
> 1. If a thread group leader exits while threads still there, then no
>    pidfd poll notifcation should happen.
> 2. If a non-thread group leader does an execve, then the thread group
>    leader is signaled to exit and is replaced with the execing thread
>    as the new leader, however the parent is not notified in this case.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> ---
>  tools/testing/selftests/pidfd/Makefile     |   2 +-
>  tools/testing/selftests/pidfd/pidfd_test.c | 210 +++++++++++++++++++++
>  2 files changed, 211 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index deaf8073bc06..4b31c14f273c 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -1,4 +1,4 @@
> -CFLAGS += -g -I../../../../usr/include/
> +CFLAGS += -g -I../../../../usr/include/ -lpthread
>  
>  TEST_GEN_PROGS := pidfd_test
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
> index d59378a93782..8b404ccbc4ff 100644
> --- a/tools/testing/selftests/pidfd/pidfd_test.c
> +++ b/tools/testing/selftests/pidfd/pidfd_test.c
> @@ -4,18 +4,47 @@
>  #include <errno.h>
>  #include <fcntl.h>
>  #include <linux/types.h>
> +#include <pthread.h>
>  #include <sched.h>
>  #include <signal.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
>  #include <syscall.h>
> +#include <sys/epoll.h>
> +#include <sys/mman.h>
>  #include <sys/mount.h>
>  #include <sys/wait.h>
> +#include <time.h>
>  #include <unistd.h>
>  
>  #include "../kselftest.h"
>  
> +#define str(s) _str(s)
> +#define _str(s) #s
> +#define CHILD_THREAD_MIN_WAIT 3 /* seconds */
> +
> +#define MAX_EVENTS 5
> +#ifndef __NR_pidfd_send_signal
> +#define __NR_pidfd_send_signal 424
> +#endif
> +
> +#ifndef CLONE_PIDFD
> +#define CLONE_PIDFD 0x00001000
> +#endif
> +
> +static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
> +{
> +	size_t stack_size = 1024;
> +	char *stack[1024] = { 0 };
> +
> +#ifdef __ia64__
> +	return __clone2(fn, stack, stack_size, flags | SIGCHLD, NULL, pidfd);
> +#else
> +	return clone(fn, stack + stack_size, flags | SIGCHLD, NULL, pidfd);
> +#endif
> +}
> +
>  static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
>  					unsigned int flags)
>  {
> @@ -368,10 +397,191 @@ static int test_pidfd_send_signal_syscall_support(void)
>  	return 0;
>  }
>  
> +static void *test_pidfd_poll_exec_thread(void *priv)
> +{
> +	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
> +			getpid(), syscall(SYS_gettid));
> +	ksft_print_msg("Child Thread: doing exec of sleep\n");
> +
> +	execl("/bin/sleep", "sleep", str(CHILD_THREAD_MIN_WAIT), (char *)NULL);
> +
> +	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n",
> +			getpid(), syscall(SYS_gettid));
> +	return NULL;
> +}
> +
> +static void poll_pidfd(const char *test_name, int pidfd)
> +{
> +	int c;
> +	int epoll_fd = epoll_create1(EPOLL_CLOEXEC);
> +	struct epoll_event event, events[MAX_EVENTS];
> +
> +	if (epoll_fd == -1)
> +		ksft_exit_fail_msg("%s test: Failed to create epoll file descriptor "
> +				   "(errno %d)\n",
> +				   test_name, errno);
> +
> +	event.events = EPOLLIN;
> +	event.data.fd = pidfd;
> +
> +	if (epoll_ctl(epoll_fd, EPOLL_CTL_ADD, pidfd, &event)) {
> +		ksft_exit_fail_msg("%s test: Failed to add epoll file descriptor "
> +				   "(errno %d)\n",
> +				   test_name, errno);
> +	}
> +
> +	c = epoll_wait(epoll_fd, events, MAX_EVENTS, 5000);
> +	if (c != 1 || !(events[0].events & EPOLLIN))
> +		ksft_exit_fail_msg("%s test: Unexpected epoll_wait result (c=%d, events=%x) ",
> +				   "(errno %d)\n",
> +				   test_name, c, events[0].events, errno);
> +
> +	close(epoll_fd);
> +	return;

nit: Function with void usually do not do an explicit return at the end. :)

> +
> +}
> +
> +static int child_poll_exec_test(void *args)
> +{
> +	pthread_t t1;
> +
> +	ksft_print_msg("Child (pidfd): starting. pid %d tid %d\n", getpid(),
> +			syscall(SYS_gettid));
> +	pthread_create(&t1, NULL, test_pidfd_poll_exec_thread, NULL);
> +	/*
> +	 * Exec in the non-leader thread will destroy the leader immediately.
> +	 * If the wait in the parent returns too soon, the test fails.
> +	 */
> +	while (1)
> +		sleep(1);
> +}
> +
> +static int test_pidfd_poll_exec(int use_waitpid)

Please make int use_waitpid a proper bool and make the function void as
it's return value is never checked in main.

(I know the other ones in the test file here do the same thing and I
should switch them to void soon at some point.)

> +{
> +	int pid, pidfd = 0;
> +	int status, ret;
> +	pthread_t t1;
> +	time_t prog_start = time(NULL);
> +	const char *test_name = "pidfd_poll check for premature notification on child thread exec";
> +
> +	ksft_print_msg("Parent: pid: %d\n", getpid());
> +	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_exec_test);
> +	if (pid < 0)
> +		ksft_exit_fail_msg("%s test: pidfd_clone failed (ret %d, errno %d)\n",
> +				   test_name, pid, errno);
> +
> +	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
> +
> +	if (use_waitpid) {
> +		ret = waitpid(pid, &status, 0);
> +		if (ret == -1)
> +			ksft_print_msg("Parent: error\n");
> +
> +		if (ret == pid)
> +			ksft_print_msg("Parent: Child process waited for.\n");
> +	} else {
> +		poll_pidfd(test_name, pidfd);
> +	}
> +
> +	time_t prog_time = time(NULL) - prog_start;
> +
> +	ksft_print_msg("Time waited for child: %lu\n", prog_time);
> +
> +	close(pidfd);
> +
> +	if (prog_time < CHILD_THREAD_MIN_WAIT || prog_time > CHILD_THREAD_MIN_WAIT + 2)

I'm sorry, can you please either briefly explain or comment where
this +2 comes from? Why is that the cut-off?

> +		ksft_exit_fail_msg("%s test: Failed\n", test_name);
> +	else
> +		ksft_test_result_pass("%s test: Passed\n", test_name);
> +}
> +
> +static void *test_pidfd_poll_leader_exit_thread(void *priv)
> +{
> +	ksft_print_msg("Child Thread: starting. pid %d tid %d ; and sleeping\n",
> +			getpid(), syscall(SYS_gettid));
> +	sleep(CHILD_THREAD_MIN_WAIT);
> +	ksft_print_msg("Child Thread: DONE. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
> +	return NULL;
> +}
> +
> +static time_t *child_exit_secs;
> +static int child_poll_leader_exit_test(void *args)
> +{
> +	pthread_t t1, t2;
> +
> +	ksft_print_msg("Child: starting. pid %d tid %d\n", getpid(), syscall(SYS_gettid));
> +	pthread_create(&t1, NULL, test_pidfd_poll_leader_exit_thread, NULL);
> +	pthread_create(&t2, NULL, test_pidfd_poll_leader_exit_thread, NULL);
> +
> +	/*
> +	 * glibc exit calls exit_group syscall, so explicity call exit only
> +	 * so that only the group leader exits, leaving the threads alone.
> +	 */
> +	*child_exit_secs = time(NULL);

Why is child_exit_secs a pointer?


> +	syscall(SYS_exit, 0);
> +}
> +
> +static int test_pidfd_poll_leader_exit(int use_waitpid)

Should be void as it's return value isn't checked at all.

(I know the other ones in the test file here do the same thing and I
should switch them to void soon at some point.)

> +{
> +	int pid, pidfd = 0;
> +	int status, ret;
> +	time_t prog_start = time(NULL);
> +	const char *test_name = "pidfd_poll check for premature notification on non-empty"
> +				"group leader exit";
> +
> +	child_exit_secs = mmap(NULL, sizeof *child_exit_secs, PROT_READ | PROT_WRITE,
> +			MAP_SHARED | MAP_ANONYMOUS, -1, 0);
> +
> +	if (child_exit_secs == MAP_FAILED)
> +		ksft_exit_fail_msg("%s test: mmap failed (errno %d)\n",
> +				   test_name, errno);
> +
> +	ksft_print_msg("Parent: pid: %d\n", getpid());
> +	pid = pidfd_clone(CLONE_PIDFD, &pidfd, child_poll_leader_exit_test);
> +	if (pid < 0)
> +		ksft_exit_fail_msg("%s test: pidfd_clone failed (ret %d, errno %d)\n",
> +				   test_name, pid, errno);
> +
> +	ksft_print_msg("Parent: Waiting for Child (%d) to complete.\n", pid);
> +
> +	if (use_waitpid) {
> +		ret = waitpid(pid, &status, 0);
> +		if (ret == -1)
> +			ksft_print_msg("Parent: error\n");
> +	} else {
> +		/*
> +		 * This sleep tests for the case where if the child exits, and is in
> +		 * EXIT_ZOMBIE, but the thread group leader is non-empty, then the poll
> +		 * doesn't prematurely return even though there are active threads
> +		 */
> +		sleep(1);
> +		poll_pidfd(test_name, pidfd);
> +	}
> +
> +	if (ret == pid)
> +		ksft_print_msg("Parent: Child process waited for.\n");
> +
> +	time_t since_child_exit = time(NULL) - *child_exit_secs;
> +
> +	ksft_print_msg("Time since child exit: %lu\n", since_child_exit);
> +
> +	close(pidfd);
> +
> +	if (since_child_exit < CHILD_THREAD_MIN_WAIT ||
> +			since_child_exit > CHILD_THREAD_MIN_WAIT + 2)

Same question as above.

> +		ksft_exit_fail_msg("%s test: Failed\n", test_name);
> +	else
> +		ksft_test_result_pass("%s test: Passed\n", test_name);
> +}
> +
>  int main(int argc, char **argv)
>  {
>  	ksft_print_header();
>  
> +	test_pidfd_poll_exec(0);

test_pidfd_poll_exec(false);

> +	test_pidfd_poll_exec(1);

test_pidfd_poll_exec(true);

> +	test_pidfd_poll_leader_exit(0);

test_pidfd_poll_leader_exit(false);

> +	test_pidfd_poll_leader_exit(1);

test_pidfd_poll_leader_exit(true);

>  	test_pidfd_send_signal_syscall_support();
>  	test_pidfd_send_signal_simple_success();
>  	test_pidfd_send_signal_exited_fail();
> -- 
> 2.21.0.593.g511ec345e18-goog
> 
