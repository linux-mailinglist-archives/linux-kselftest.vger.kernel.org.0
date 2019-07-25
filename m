Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C785274D08
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jul 2019 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391422AbfGYL0B (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Jul 2019 07:26:01 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36564 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391453AbfGYL0A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Jul 2019 07:26:00 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so49925556edq.3
        for <linux-kselftest@vger.kernel.org>; Thu, 25 Jul 2019 04:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WEyRmkVEOhbCidFA/vuD+08ymbEUCrNcC1FlwBWlNvU=;
        b=Z44WeL2IgALPub8m1//8lGs/Cy9HjnAR3/QntgGnpnZJeDt9nmtrvldMs4mX7DugWk
         3ZzFRsW4KWFbsNsT2IqgSEn5bKRnsbYaNfPEBTkoqljdUElGtxJzkOA/cWySyCZSALP/
         kxynbogPFGmp+bb9rhnK8h5X4fb+lC3OjGIpESVVvmA3gICHHQEiZygh8Cu0Gr2zB+4K
         zWMT7hw9Tchh/vctd/Mpj9AAT5nVhn4sz+5rnjECkHni6s5yRY9L3pPR7MT/ujksk8Pc
         fRBMaW1MYDEINYCem2qAeDRBlU/3oyxaqumnZFg8A4FT90scF9pu7xY5ac4fcs/ZQJif
         pRXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WEyRmkVEOhbCidFA/vuD+08ymbEUCrNcC1FlwBWlNvU=;
        b=XMqhZN6F4RBsIID5iBQpJgKLaWH4NzzL3BbPnq9dwiivtydkhZ7+CNt1o+sVZxMJZN
         ETe/QiQnVzeg3DY5pTKC0Z1WhgifgoHHZqVYrvLvelDjwQpTlBkQWpjYH3r1hCoBraic
         cP3mQ9m7q3Th37T5UppuU1rbBWX8zf47qLQ8ATBZ6dnn5dBjWwMfND8qDYoTAoBuL1yK
         DZ/dSIBsUws68/iKwAfY+1lzyqToAvtEiSioDsFJjqzba1fFlwrSqtyuOjdtIWDvXpu6
         6bLWVFaXb6dT3mwMuQqIS7ROHZJgcW5jgivVUhFujiTd0jELr2r9UXNLDfHzPl5mGsWH
         6VKg==
X-Gm-Message-State: APjAAAXRscI7aRF1SE529k9R3ItIWLBkgAglYdLqrF9ksIwqv3WxCNjC
        daXoyKpuEYRJyQeYCzlD2jU=
X-Google-Smtp-Source: APXvYqzdJF3uuYSmNVrexhnBJVZDV8LubJU6KLLdYy+8y9OwRMK8CS7CUQ8jNgLDBpyr6KB7AUoGvA==
X-Received: by 2002:a17:906:af86:: with SMTP id mj6mr22060265ejb.157.1564053958749;
        Thu, 25 Jul 2019 04:25:58 -0700 (PDT)
Received: from brauner.io (ip5b40f7ec.dynamic.kabel-deutschland.de. [91.64.247.236])
        by smtp.gmail.com with ESMTPSA id j16sm9809808ejq.66.2019.07.25.04.25.57
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 25 Jul 2019 04:25:58 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:25:57 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     arnd@arndb.de, ebiederm@xmission.com, keescook@chromium.org,
        joel@joelfernandes.org, dancol@google.com, tglx@linutronix.de,
        jannh@google.com, dhowells@redhat.com, mtk.manpages@gmail.com,
        luto@kernel.org, akpm@linux-foundation.org, oleg@redhat.com,
        cyphar@cyphar.com, torvalds@linux-foundation.org,
        viro@zeniv.linux.org.uk, linux-api@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/2] tests: add pidfd poll tests
Message-ID: <20190725112556.f7t5natdomohzm2u@brauner.io>
References: <20190725002204.185225-1-surenb@google.com>
 <20190725002204.185225-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190725002204.185225-2-surenb@google.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 24, 2019 at 05:22:04PM -0700, Suren Baghdasaryan wrote:
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
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Reviewed-by: Christian Brauner <christian@brauner.io>

> ---
>  tools/testing/selftests/pidfd/.gitignore      |   1 +
>  tools/testing/selftests/pidfd/Makefile        |   2 +-
>  .../testing/selftests/pidfd/pidfd_poll_test.c | 112 ++++++++++++++++++
>  3 files changed, 114 insertions(+), 1 deletion(-)
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
> index 000000000000..d45c612a0fe5
> --- /dev/null
> +++ b/tools/testing/selftests/pidfd/pidfd_poll_test.c
> @@ -0,0 +1,112 @@
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
> +static bool timeout;
> +
> +static void handle_alarm(int sig)
> +{
> +	timeout = true;
> +}
> +
> +int main(int argc, char **argv)
> +{
> +	struct pollfd fds;
> +	int iter, nevents;
> +	int nr_iterations = 10000;
> +
> +	fds.events = POLLIN;
> +
> +	if (argc > 2)
> +		ksft_exit_fail_msg("Unexpected command line argument\n");
> +
> +	if (argc == 2) {
> +		nr_iterations = atoi(argv[1]);
> +		if (nr_iterations <= 0)
> +			ksft_exit_fail_msg("invalid input parameter %s\n",
> +					argv[1]);
> +	}
> +
> +	ksft_print_msg("running pidfd poll test for %d iterations\n",
> +		nr_iterations);
> +
> +	for (iter = 0; iter < nr_iterations; iter++) {
> +		int pidfd;
> +		int child_pid = fork();
> +
> +		if (child_pid < 0) {
> +			if (errno == EAGAIN) {
> +				iter--;
> +				continue;
> +			}
> +			ksft_exit_fail_msg(
> +				"%s - failed to fork a child process\n",
> +				strerror(errno));
> +		}
> +
> +		if (!child_pid) {
> +			/* Child process just sleeps for a min and exits */
> +			sleep(60);
> +			exit(EXIT_SUCCESS);
> +		}
> +
> +		/* Parent kills the child and waits for its death */
> +		pidfd = sys_pidfd_open(child_pid, 0);
> +		if (pidfd < 0)
> +			ksft_exit_fail_msg("%s - pidfd_open failed\n",
> +					strerror(errno));
> +
> +		/* Setup 3 sec alarm - plenty of time */
> +		if (signal(SIGALRM, handle_alarm) == SIG_ERR)
> +			ksft_exit_fail_msg("%s - signal failed\n",
> +					strerror(errno));
> +		alarm(3);
> +
> +		/* Send SIGKILL to the child */
> +		if (sys_pidfd_send_signal(pidfd, SIGKILL, NULL, 0))
> +			ksft_exit_fail_msg("%s - pidfd_send_signal failed\n",
> +					strerror(errno));
> +
> +		/* Wait for the death notification */
> +		fds.fd = pidfd;
> +		nevents = poll(&fds, 1, -1);
> +
> +		/* Check for error conditions */
> +		if (nevents < 0)
> +			ksft_exit_fail_msg("%s - poll failed\n",
> +					strerror(errno));
> +
> +		if (nevents != 1)
> +			ksft_exit_fail_msg("unexpected poll result: %d\n",
> +					nevents);
> +
> +		if (!(fds.revents & POLLIN))
> +			ksft_exit_fail_msg(
> +				"unexpected event type received: 0x%x\n",
> +				fds.revents);
> +
> +		if (timeout)
> +			ksft_exit_fail_msg(
> +				"death notification wait timeout\n");
> +
> +		close(pidfd);
> +	}
> +
> +	ksft_test_result_pass("pidfd poll test: pass\n");
> +	return ksft_exit_pass();
> +}
> -- 
> 2.22.0.709.g102302147b-goog
> 
