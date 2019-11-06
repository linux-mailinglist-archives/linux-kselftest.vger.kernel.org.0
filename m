Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5104DF1A9C
	for <lists+linux-kselftest@lfdr.de>; Wed,  6 Nov 2019 16:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfKFP7V (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 6 Nov 2019 10:59:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57005 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726926AbfKFP7U (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 6 Nov 2019 10:59:20 -0500
Received: from [213.220.153.21] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iSNiG-0003C8-BP; Wed, 06 Nov 2019 15:59:16 +0000
Date:   Wed, 6 Nov 2019 16:59:15 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests: add tests for clone3()
Message-ID: <20191106155914.hzolyolz2w4hcn7w@wittgenstein>
References: <20191104131846.1076814-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191104131846.1076814-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 04, 2019 at 02:18:46PM +0100, Adrian Reber wrote:
> This adds tests for clone3() with different values and sizes
> of struct clone_args.
> 
> This selftest was initially part of of the clone3() with PID selftest.
> After that patch was almost merged Eugene sent out a couple of patches
> to fix problems with these test.
> 
> This commit now only contains the clone3() selftest after the LPC
> decision to rework clone3() with PID to allow setting the PID in
> multiple PID namespaces including all of Eugene's patches.
> 
> Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
> Signed-off-by: Adrian Reber <areber@redhat.com>

Resending, since mutt messed-up the quoting due to a new configuration I
was testing.

A few more comments below.

Also, would you be open to adding tests here for the newly added .stack
and .stack_size API (cf. [1])?

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=fa729c4df558936b4a1a7b3e2234011f44ede28b

> ---
> v2:
>  - Applied Christian's suggestions
>  - Skip root-only tests when running as non-root
> ---
>  MAINTAINERS                               |   1 +
>  tools/testing/selftests/Makefile          |   1 +
>  tools/testing/selftests/clone3/.gitignore |   1 +
>  tools/testing/selftests/clone3/Makefile   |   7 +
>  tools/testing/selftests/clone3/clone3.c   | 225 ++++++++++++++++++++++
>  5 files changed, 235 insertions(+)
>  create mode 100644 tools/testing/selftests/clone3/.gitignore
>  create mode 100644 tools/testing/selftests/clone3/Makefile
>  create mode 100644 tools/testing/selftests/clone3/clone3.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index cba1095547fd..0040b7a6410b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12829,6 +12829,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git
>  F:	samples/pidfd/
>  F:	tools/testing/selftests/pidfd/
> +F:	tools/testing/selftests/clone3/
>  K:	(?i)pidfd
>  K:	(?i)clone3
>  K:	\b(clone_args|kernel_clone_args)\b
> diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
> index 4cdbae6f4e61..ad442364218a 100644
> --- a/tools/testing/selftests/Makefile
> +++ b/tools/testing/selftests/Makefile
> @@ -4,6 +4,7 @@ TARGETS += bpf
>  TARGETS += breakpoints
>  TARGETS += capabilities
>  TARGETS += cgroup
> +TARGETS += clone3
>  TARGETS += cpufreq
>  TARGETS += cpu-hotplug
>  TARGETS += drivers/dma-buf
> diff --git a/tools/testing/selftests/clone3/.gitignore b/tools/testing/selftests/clone3/.gitignore
> new file mode 100644
> index 000000000000..85d9d3ba2524
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/.gitignore
> @@ -0,0 +1 @@
> +clone3
> diff --git a/tools/testing/selftests/clone3/Makefile b/tools/testing/selftests/clone3/Makefile
> new file mode 100644
> index 000000000000..ea922c014ae4
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +CFLAGS += -I../../../../usr/include/
> +
> +TEST_GEN_PROGS := clone3
> +
> +include ../lib.mk
> diff --git a/tools/testing/selftests/clone3/clone3.c b/tools/testing/selftests/clone3/clone3.c
> new file mode 100644
> index 000000000000..a982d95189bf
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -0,0 +1,225 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/* Based on Christian Brauner's clone3() example */
> +
> +#define _GNU_SOURCE
> +#include <errno.h>
> +#include <inttypes.h>
> +#include <linux/types.h>
> +#include <linux/sched.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +#include <sys/un.h>
> +#include <sys/wait.h>
> +#include <unistd.h>
> +#include <sched.h>
> +
> +#include "../kselftest.h"
> +
> +/*
> + * Different sizes of struct clone_args
> + */
> +#ifndef CLONE3_ARGS_SIZE_V0
> +#define CLONE3_ARGS_SIZE_V0 64
> +#endif
> +
> +enum test_mode {
> +	CLONE3_ARGS_NO_TEST,
> +	CLONE3_ARGS_ALL_0,
> +	CLONE3_ARGS_ALL_1,
> +	CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG,
> +	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG,
> +	CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG,
> +	CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG,
> +};
> +
> +static pid_t raw_clone(struct clone_args *args, size_t size)
> +{
> +	return syscall(__NR_clone3, args, size);
> +}
> +
> +static int call_clone3(uint64_t flags, size_t size, enum test_mode test_mode)
> +{
> +	struct clone_args args = {
> +		.flags = flags,
> +		.exit_signal = SIGCHLD,
> +	};
> +
> +	struct clone_args_extended {
> +		struct clone_args args;
> +		__aligned_u64 excess_space[2];
> +	} args_ext;
> +
> +	pid_t pid = -1;
> +	int status;
> +
> +	memset(&args_ext, 0, sizeof(args_ext));
> +	if (size > sizeof(struct clone_args))
> +		args_ext.excess_space[1] = 1;
> +
> +	if (size == 0)
> +		size = sizeof(struct clone_args);
> +
> +	switch (test_mode) {
> +	case CLONE3_ARGS_ALL_0:
> +		args.flags = 0;
> +		args.exit_signal = 0;
> +		break;
> +	case CLONE3_ARGS_ALL_1:

I don't fully understand this test case. What is this for exactly?

> +		args.flags = 1;
> +		args.pidfd = 1;
> +		args.child_tid = 1;
> +		args.parent_tid = 1;
> +		args.exit_signal = 1;
> +		args.stack = 1;
> +		args. stack_size = 1;
> +		args.tls = 1;
> +		break;
> +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG:
> +		args.exit_signal = 0xbadc0ded00000000ULL;
> +		break;
> +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG:
> +		args.exit_signal = 0x0000000080000000ULL;
> +		break;
> +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG:
> +		args.exit_signal = 0x0000000000000100ULL;
> +		break;
> +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
> +		args.exit_signal = 0x00000000000000f0ULL;
> +		break;
> +	}
> +
> +	memcpy(&args_ext.args, &args, sizeof(struct clone_args));
> +
> +	pid = raw_clone((struct clone_args *)&args_ext, size);
> +	if (pid < 0) {
> +		ksft_print_msg("%s - Failed to create new process\n",
> +				strerror(errno));
> +		return -errno;
> +	}
> +
> +	if (pid == 0) {
> +		ksft_print_msg("I am the child, my PID is %d\n", getpid());
> +		_exit(EXIT_SUCCESS);
> +	}
> +
> +	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
> +			getpid(), pid);
> +
> +	if (wait(&status) < 0) {
> +		ksft_print_msg("Child returned %s\n", strerror(errno));
> +		return -errno;
> +	}
> +	if (WEXITSTATUS(status))
> +		return WEXITSTATUS(status);
> +
> +	return 0;
> +}
> +
> +static void test_clone3(uint64_t flags, size_t size, int expected,
> +		       enum test_mode test_mode)
> +{
> +	int ret;
> +
> +	ksft_print_msg(
> +		"[%d] Trying clone3() with flags %#" PRIx64 " (size %zu)\n",
> +		getpid(), flags, size);
> +	ret = call_clone3(flags, size, test_mode);
> +	ksft_print_msg("[%d] clone3() with flags says: %d expected %d\n",
> +			getpid(), ret, expected);
> +	if (ret != expected)
> +		ksft_test_result_fail(
> +			"[%d] Result (%d) is different than expected (%d)\n",
> +			getpid(), ret, expected);
> +	else
> +		ksft_test_result_pass(
> +			"[%d] Result (%d) matches expectation (%d)\n",
> +			getpid(), ret, expected);
> +}
> +int main(int argc, char *argv[])
> +{
> +	pid_t pid;
> +
> +	uid_t uid = getuid();
> +
> +	ksft_print_header();
> +	ksft_set_plan(17);
> +
> +	/* Just a simple clone3() should return 0.*/
> +	test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST);
> +
> +	/* Do a clone3() in a new PID NS.*/
> +	if (uid == 0)
> +		test_clone3(CLONE_NEWPID, 0, 0, CLONE3_ARGS_NO_TEST);
> +	else
> +		ksft_test_result_skip("Skipping clone3() with CLONE_NEWPID\n");
> +
> +	/* Do a clone3() with CLONE3_ARGS_SIZE_V0. */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0, 0, CLONE3_ARGS_NO_TEST);
> +
> +	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 - 8 */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0 - 8, -EINVAL, CLONE3_ARGS_NO_TEST);
> +
> +	/* Do a clone3() with sizeof(struct clone_args) + 8 */
> +	test_clone3(0, sizeof(struct clone_args) + 8, 0, CLONE3_ARGS_NO_TEST);
> +
> +	/* Do a clone3() with all members set to 1 */
> +	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_ALL_1);
> +
> +	/* Do a clone3() with exit_signal having highest 32 bits non-zero */
> +	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG);
> +
> +	/* Do a clone3() with negative 32-bit exit_signal */
> +	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG);
> +
> +	/* Do a clone3() with exit_signal not fitting into CSIGNAL mask */
> +	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG);
> +
> +	/* Do a clone3() with NSIG < exit_signal < CSIG */
> +	test_clone3(0, 0, -EINVAL, CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG);
> +
> +	/*
> +	 * Do a clone3() with sizeof(struct clone_args) + 8
> +	 * and all members set to 0. This resets exit_signal and wait()
> +	 * will not get a result.
> +	 */
> +	test_clone3(0, sizeof(struct clone_args) + 8, -ECHILD,
> +			CLONE3_ARGS_ALL_0);

Ah, I haven't caught this during the first review. No, that's not
correct. You don't get a signal since exit_signal is 0, that's correct
_but_ you still need to wait on the child. You don't see the child
because the kernel will by default not wait on clone()-children aka
processes created with exit_signal != SIGCHLD. To wait on
clone()-children as well,  you need to set __WCLONE or __WALL in the
options argument for wait{p}id(2).

> +
> +	/*
> +	 * Do a clone3() with sizeof(struct clone_args) + 8
> +	 * and all members set to 0.
> +	 */
> +	test_clone3(0, sizeof(struct clone_args) + 8, -EINVAL,
> +			CLONE3_ARGS_ALL_1);

The comment and the test don't line up. :)

> +
> +	/* Do a clone3() with > page size */
> +	test_clone3(0, getpagesize() + 8, -E2BIG, CLONE3_ARGS_NO_TEST);
> +
> +	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 in a new PID NS. */
> +	if (uid == 0)
> +		test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0, 0,
> +				CLONE3_ARGS_NO_TEST);
> +	else
> +		ksft_test_result_skip("Skipping clone3() with CLONE_NEWPID\n");
> +
> +	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 - 8 in a new PID NS */
> +	test_clone3(CLONE_NEWPID, CLONE3_ARGS_SIZE_V0 - 8, -EINVAL,
> +			CLONE3_ARGS_NO_TEST);
> +
> +	/* Do a clone3() with sizeof(struct clone_args) + 8 in a new PID NS */
> +	if (uid == 0)
> +		test_clone3(CLONE_NEWPID, sizeof(struct clone_args) + 8, 0,
> +				CLONE3_ARGS_NO_TEST);
> +	else
> +		ksft_test_result_skip("Skipping clone3() with CLONE_NEWPID\n");
> +
> +	/* Do a clone3() with > page size in a new PID NS */
> +	test_clone3(CLONE_NEWPID, getpagesize() + 8, -E2BIG,
> +			CLONE3_ARGS_NO_TEST);
> +
> +	return !ksft_get_fail_cnt() ? ksft_exit_pass() : ksft_exit_fail();
> +}
> -- 
> 2.23.0
> 
