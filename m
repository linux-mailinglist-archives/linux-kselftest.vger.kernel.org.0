Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05A872C70
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Jul 2019 12:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfGXKiw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 24 Jul 2019 06:38:52 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38810 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727218AbfGXKiv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 24 Jul 2019 06:38:51 -0400
Received: by mail-ed1-f65.google.com with SMTP id r12so11885617edo.5
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Jul 2019 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tjY9nE9968Ntch0u6iReN6FuAbMsQopxOYWKjAGnkbA=;
        b=Yq2cS775kikY+d71EzDiFevayszTdsQrx0Ai1GKpm+S5MrPiang2f11vcvFCq1hI0K
         QdgX67kmZK+ZSrKw93oGa16GEwdhZ4c5f9s/RKtduYIfWHwiJK/iLUwmh7FyDNXgCsPT
         +OVMBMYLfFYibrCkQ6PX5QogprrDCB/otJpc5z06fnEPV31vpORN7uBLNIt/6bwBvtEl
         G3SBx5Rjc4qzBq795BzvRAxHue18TUh0ay4bF08oc4XFYrm0zEU3SA/Dj3iw9GEHyUXd
         b9mXL0rV9GunBrv5N+onBpAWarAMwhqr5zb6aEQvlWCCXNOCt+cYtKGPdueZwqAbvFKA
         n7Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tjY9nE9968Ntch0u6iReN6FuAbMsQopxOYWKjAGnkbA=;
        b=QzCYRreAnS4RwmqBQSWOaoBnVXJZZfRJjmVnJf1vxcBtDxmmHlpjjsUE5In4SQ+hIz
         c/SA140fnU3vAJrvYc1SN7BkCUgIX5UtJK8VHYItvclgGJ/PGWuuOaOZfCdtCt3e2h1I
         cuOeoevBh+1+V1v4ryEqAKqwToHsQDSHh8bd5G6Tj/h9NoHb7RwtejrgXgBtXlHNMPuK
         v6dkK2HyvVTkRQLSsELYnua/0/UOGUZWAonPb5CGrvmEPzE+/AQQXT7RMlZqiuP7gENd
         hMMDWWfXgPWsoAmZ77i8kVvEt6PKiTqxKJSdwzUR3g+d0rQsquXoSOlIdkFWzGHAQok/
         rowg==
X-Gm-Message-State: APjAAAUeB3LYL0uTNPT96Q25/u1xWOXM0BowsJBATvJAbxi8lz9UVEB3
        f+acQbIG/t/xYJLLfG8GB88=
X-Google-Smtp-Source: APXvYqwRkGDYcIejJAFECSIW4cz/gSOl2l7GUACOtqmNU8HBYkOsbTeQTP/ulT8XC/NL7Ah1lm6Fcg==
X-Received: by 2002:aa7:cd17:: with SMTP id b23mr71131459edw.278.1563964728775;
        Wed, 24 Jul 2019 03:38:48 -0700 (PDT)
Received: from brauner.io ([178.19.218.101])
        by smtp.gmail.com with ESMTPSA id l35sm12607281edc.2.2019.07.24.03.38.47
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 03:38:48 -0700 (PDT)
Date:   Wed, 24 Jul 2019 12:38:46 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, dancol@google.com, tglx@linutronix.de,
        jannh@google.com, dhowells@redhat.com, mtk.manpages@gmail.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH 1/1] tests: add pidfd poll tests
Message-ID: <20190724103845.pxhpx7n6ih2byrsm@brauner.io>
References: <20190723173907.196488-1-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190723173907.196488-1-surenb@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 23, 2019 at 10:39:07AM -0700, Suren Baghdasaryan wrote:
> This adds testing for polling on pidfd of a process being killed. Test runs
> 10000 iterations by default to stress test pidfd polling functionality.
> It accepts an optional command-line parameter to override the number or
> iterations to run.
> Specifically, it tests for:
> - pidfd_open on a child process succeeds
> - pidfd_send_signal on a child process succeeds
> - polling on pidfd succeeds and returns exactly one event
> - returned event is POLLIN
> - event is received within 3 secs of the process being killed
> 
> 10000 iterations was chosen because of the race condition being tested
> which is not consistently reproducible but usually is revealed after less
> than 2000 iterations.
> Reveals race fixed by commit b191d6491be6 ("pidfd: fix a poll race when setting exit_state")

Thanks for upstreaming the stress-tester. A few comments below.

> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  tools/testing/selftests/pidfd/.gitignore      |   1 +
>  tools/testing/selftests/pidfd/Makefile        |   2 +-
>  .../testing/selftests/pidfd/pidfd_poll_test.c | 137 ++++++++++++++++++
>  3 files changed, 139 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/pidfd/pidfd_poll_test.c
> 
> diff --git a/tools/testing/selftests/pidfd/.gitignore b/tools/testing/selftests/pidfd/.gitignore
> index 16d84d117bc0..a67896347d34 100644
> --- a/tools/testing/selftests/pidfd/.gitignore
> +++ b/tools/testing/selftests/pidfd/.gitignore
> @@ -1,2 +1,3 @@
>  pidfd_open_test
> +pidfd_poll_test
>  pidfd_test
> diff --git a/tools/testing/selftests/pidfd/Makefile b/tools/testing/selftests/pidfd/Makefile
> index 720b2d884b3c..ed58b7108d18 100644
> --- a/tools/testing/selftests/pidfd/Makefile
> +++ b/tools/testing/selftests/pidfd/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  CFLAGS += -g -I../../../../usr/include/ -lpthread
>  
> -TEST_GEN_PROGS := pidfd_test pidfd_open_test
> +TEST_GEN_PROGS := pidfd_test pidfd_open_test pidfd_poll_test
>  
>  include ../lib.mk
>  
> diff --git a/tools/testing/selftests/pidfd/pidfd_poll_test.c b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> new file mode 100644
> index 000000000000..f2934aa070ae
> --- /dev/null
> +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <linux/types.h>
> +#include <linux/wait.h>
> +#include <poll.h>
> +#include <signal.h>
> +#include <stdbool.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <syscall.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +
> +#include "pidfd.h"
> +#include "../kselftest.h"
> +
> +#define __NR_pidfd_send_signal 424
> +#define __NR_pidfd_open 434

That won't work on Alpha where this number is unfortunately different so
I'm not sure which syscall you'd hit there (/me checks 
424	common	tgkill				sys_tgkill
)

The better option is to just place

#ifndef __NR_pidfd_send_signal
#define __NR_pidfd_send_signal -1
#endif

#ifndef __NR_pidfd_open
#define __NR_pidfd_open -1
#endif

into the pidfd.h header.

> +
> +static inline int sys_pidfd_open(pid_t pid, unsigned int flags)
> +{
> +	return syscall(__NR_pidfd_open, pid, flags);
> +}
> +
> +static inline int sys_pidfd_send_signal(int pidfd, int sig, siginfo_t *info,
> +					unsigned int flags)
> +{
> +	return syscall(__NR_pidfd_send_signal, pidfd, sig, info, flags);
> +}

Those can go into pidfd.h too.

> +
> +static bool timeout;
> +
> +static void handle_alarm(int sig)
> +{
> +	timeout = true;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	int ret = 1;
> +	int pidfd = -1;
> +	struct pollfd fds;
> +	int iter, nevents;
> +	int nr_iterations = 10000;
> +
> +	fds.events = POLLIN;

if (argc > 2)
	ksft_exit_fail_msg("Unexpected command line argument");

> +	if (argc > 1) {

	if (argc == 2)

> +		nr_iterations = atoi(argv[1]);
> +		if (!nr_iterations) {

You should probably also check for negative values.

> +			ksft_test_result_fail("invalid input parameter %s\n",
> +				argv[1]);
> +			return ksft_exit_fail();
> +		}
> +	}
> +
> +	ksft_print_msg("running pidfd poll test for %d iterations\n",
> +		nr_iterations);
> +
> +	for (iter = 0; iter < nr_iterations; iter++) {
> +		int child_pid = fork();
> +
> +		if (!child_pid) {
> +			/* Child process just sleeps for a min */
> +			sleep(60);
> +			exit(0);

Just for kicks, please use exit(EXIT_SUCCESS)

> +		}


You should switch the checkes, i.e.

	if (child_pid < 0)
		/* do stuff */

	if (child_pid == 0)
		/* do other stuff */

> +
> +		/* Parent kills the child and waits for its death */
> +		if (child_pid < 0) {
> +			if (errno == EAGAIN) {
> +				iter--;
> +				continue;
> +			}
> +			ksft_print_msg("%s - failed to fork a child process\n",
> +				strerror(errno));

Uhm, shouldn't you exit with an error here?, i.e.

		ksft_exit_fail_msg(...

> +		}
> +		pidfd = sys_pidfd_open(child_pid, 0);
> +		if (pidfd < 0) {
> +			ksft_print_msg("%s - pidfd_open failed\n",
> +				strerror(errno));
> +			goto on_error;

I think you honestly can just call ksft_exit_fail_msg() everywhere. The
fds will be cleaned up on process exit anyway and it's pretty
short-lived.

> +		}
> +		/* Setup 3 sec alarm - plenty of time */
> +		if (signal(SIGALRM, handle_alarm) == SIG_ERR) {
> +			ksft_print_msg("%s - signal failed\n",
> +				strerror(errno));
> +			goto on_error;
> +		}
> +		alarm(3);
> +		/* Send SIGKILL to the child */
> +		if (sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0)) {
> +			ksft_print_msg("%s - pidfd_send_signal failed\n",
> +				strerror(errno));
> +			goto on_error;
> +		}
> +		/* Wait for the death notification */
> +		fds.fd = pidfd;
> +		nevents = poll(&fds, 1, -1);
> +		if (nevents < 0) {
> +			ksft_print_msg("%s - poll failed\n",
> +				strerror(errno));
> +			goto on_error;
> +		}
> +		if (nevents != 1) {
> +			ksft_print_msg("unexpected poll result: %d\n",
> +				nevents);
> +			goto on_error;
> +		}
> +		if (!(fds.revents & POLLIN)) {
> +			ksft_print_msg(
> +				"unexpected event type received: 0x%x\n",
> +				fds.revents);
> +			goto on_error;
> +		}
> +		if (timeout) {
> +			ksft_print_msg("death notification wait timeout\n");
> +			goto on_error;
> +		}
> +		close(pidfd);
> +	}
> +	ret = 0;
> +
> +on_error:
> +	if (pidfd)
> +		close(pidfd);
> +
> +	if (ret) {
> +		ksft_test_result_fail("failed after %d retries\n", iter);
> +		return ksft_exit_fail();
> +	}
> +
> +	ksft_test_result_pass("pidfd poll test: pass\n");
> +	return ksft_exit_pass();
> +}
> -- 
> 2.22.0.657.g960e92d24f-goog
> 
