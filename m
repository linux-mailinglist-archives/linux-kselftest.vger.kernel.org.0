Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A8943F8D8
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Oct 2021 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232351AbhJ2Idq convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 29 Oct 2021 04:33:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:43862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232433AbhJ2Idn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 29 Oct 2021 04:33:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA6CF6115B;
        Fri, 29 Oct 2021 08:31:12 +0000 (UTC)
Date:   Fri, 29 Oct 2021 10:31:10 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        Philip Li <philip.li@intel.com>,
        yang xu <xuyang2018.jy@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] kselftest: signal all child processes
Message-ID: <20211029083110.syhqfc3ivaj53ygl@wittgenstein>
References: <20211029024528.8086-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20211029024528.8086-1-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Oct 29, 2021 at 10:45:27AM +0800, Li Zhijian wrote:
> We have some many cases that will create child process as well, such as
> pidfd_wait. Previously, we will signal/kill the parent process when it
> is time out, but this signal will not be sent to its child process. In
> such case, if child process doesn't terminate itself, ksefltest framework
> will hang forever.
> 
> below ps tree show the situation when ksefltest is blocking:
> root      1172  0.0  0.0   5996  2500 ?        S    07:03   0:00  \_ /bin/bash /lkp/lkp/src/tests/kernel-selftests
> root      1216  0.0  0.0   4392  1976 ?        S    07:03   0:00      \_ make run_tests -C pidfd
> root      1218  0.0  0.0   2396  1652 ?        S    07:03   0:00          \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftests-x86_64-rhel-8.
> root     12491  0.0  0.0   2396   132 ?        S    07:03   0:00              \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftests-x86_64-rhe
> root     12492  0.0  0.0   2396   132 ?        S    07:03   0:00                  \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftests-x86_64
> root     12493  0.0  0.0   2396   132 ?        S    07:03   0:00                      \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftests-x8
> root     12496  0.0  0.0   2396   132 ?        S    07:03   0:00                          \_ /bin/sh -c BASE_DIR="/usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests"; . /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/runner.sh; if [ "X" != "X" ]; then per_test_logging=1; fi; run_many  /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_fdinfo_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_open_test /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/pidfd/pidfd_poll_test /usr/src/perf_selftest
> root     12498  0.0  0.0  10564  6116 ?        S    07:03   0:00                              \_ perl /usr/src/perf_selftests-x86_64-rhel-8.3-kselftests-519d81956ee277b4419c723adfb154603c2565ba/tools/testing/selftests/kselftest/prefix.pl
> root     12503  0.0  0.0   2452   112 ?        T    07:03   0:00 ./pidfd_wait
> root     12621  0.0  0.0   2372  1600 ?        SLs  07:04   0:00 /usr/sbin/watchdog
> root     19438  0.0  0.0    992    60 ?        Ss   07:39   0:00 /lkp/lkp/src/bin/event/wakeup activate-monitor
> 
> Here we group all its child processes so that kill() can signal all of
> them in timeout.
> 
> CC: Kees Cook <keescook@chromium.org>
> CC: Andy Lutomirski <luto@amacapital.net>
> CC: Will Drewry <wad@chromium.org>
> CC: Shuah Khan <shuah@kernel.org>
> CC: Christian Brauner <christian@brauner.io>
> CC: Philip Li <philip.li@intel.com>
> Suggested-by: yang xu <xuyang2018.jy@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

Seems sensible. Is it guaranteed that t->pid is neither 0 nor 1? If not
then maybe sanity check t->pid at least for not being 1 as negating that
would mean "signal everything that you have permission to signal". :)

Otherwise,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

>  tools/testing/selftests/kselftest_harness.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
> index ae0f0f33b2a6..c7251396e7ee 100644
> --- a/tools/testing/selftests/kselftest_harness.h
> +++ b/tools/testing/selftests/kselftest_harness.h
> @@ -875,7 +875,8 @@ static void __timeout_handler(int sig, siginfo_t *info, void *ucontext)
>  	}
>  
>  	t->timed_out = true;
> -	kill(t->pid, SIGKILL);
> +	// signal process group
> +	kill(-(t->pid), SIGKILL);
>  }
>  
>  void __wait_for_test(struct __test_metadata *t)
> @@ -985,6 +986,7 @@ void __run_test(struct __fixture_metadata *f,
>  		ksft_print_msg("ERROR SPAWNING TEST CHILD\n");
>  		t->passed = 0;
>  	} else if (t->pid == 0) {
> +		setpgrp();
>  		t->fn(t, variant);
>  		if (t->skip)
>  			_exit(255);
> -- 
> 2.33.0
> 
> 
> 
