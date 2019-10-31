Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 529E8EB0F6
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Oct 2019 14:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfJaNPb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Oct 2019 09:15:31 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52215 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726538AbfJaNPb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Oct 2019 09:15:31 -0400
Received: from [91.217.168.176] (helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1iQAIP-0006Fp-RK; Thu, 31 Oct 2019 13:15:25 +0000
Date:   Thu, 31 Oct 2019 14:15:25 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Adrian Reber <areber@redhat.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: add tests for clone3()
Message-ID: <20191031131524.wpv4j6erbtfgg7yx@wittgenstein>
References: <20191030112100.700087-1-areber@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191030112100.700087-1-areber@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Oct 30, 2019 at 12:21:00PM +0100, Adrian Reber wrote:
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
> ---
>  MAINTAINERS                               |   1 +
>  tools/testing/selftests/Makefile          |   1 +
>  tools/testing/selftests/clone3/.gitignore |   1 +
>  tools/testing/selftests/clone3/Makefile   |   7 +
>  tools/testing/selftests/clone3/clone3.c   | 195 ++++++++++++++++++++++
>  5 files changed, 205 insertions(+)
>  create mode 100644 tools/testing/selftests/clone3/.gitignore
>  create mode 100644 tools/testing/selftests/clone3/Makefile
>  create mode 100644 tools/testing/selftests/clone3/clone3.c

Thanks for the patch.
A few comments below.

> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c6c34d04ce95..d9426de8fb38 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12830,6 +12830,7 @@ S:	Maintained
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
> index 000000000000..a5a1ed91e550
> --- /dev/null
> +++ b/tools/testing/selftests/clone3/clone3.c
> @@ -0,0 +1,195 @@
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
> +#define CLONE3_ARGS_SIZE_V0 64

This is defined in include/uapi/sched.h and so should probably be
protected by an ifdef:

#ifndef CLONE3_ARGS_SIZE_V0
#define CLONE3_ARGS_SIZE_V0 64
#endif

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
> +	struct clone_args args = {0};

Nit:
If you want to, you could do

struct clone_args args = {
	.flags = flags,
	.exit_signal = SIGCHLD,
};

The rest of the structure (includ padding iirc) will then be zeroed.

> +	pid_t ppid = -1;
> +	pid_t pid = -1;
> +	int status;
> +
> +	args.flags = flags;
> +	args.exit_signal = SIGCHLD;
> +
> +	if (size == 0)
> +		size = sizeof(struct clone_args);
> +
> +	switch (test_mode) {
> +	case CLONE3_ARGS_ALL_0:
> +		args.flags = 0;
> +		args.pidfd = 0;
> +		args.child_tid = 0;
> +		args.parent_tid = 0;
> +		args.exit_signal = 0;
> +		args.stack = 0;
> +		args. stack_size = 0;
> +		args.tls = 0;

Hm, the explicit zeroing for _all_ fields here is not needed, right?
Would probably make sense to just do:

case CLONE3_ARGS_ALL_0:
	args.flags = 0;
	args.exit_signal = 0;
	break;

since the rest will have been zeroed when you initialized the struct
above.

> +		break;

Nit:
Can you please remove the \n between the break and case keywords.

> +
> +	case CLONE3_ARGS_ALL_1:
> +		args.flags = 1;
> +		args.pidfd = 1;
> +		args.child_tid = 1;
> +		args.parent_tid = 1;
> +		args.exit_signal = 1;
> +		args.stack = 1;
> +		args. stack_size = 1;
> +		args.tls = 1;
> +		break;
> +
> +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG:
> +		args.exit_signal = 0xbadc0ded00000000ULL;
> +		break;
> +
> +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG:
> +		args.exit_signal = 0x0000000080000000ULL;
> +		break;
> +
> +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG:
> +		args.exit_signal = 0x0000000000000100ULL;
> +		break;
> +
> +	case CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG:
> +		args.exit_signal = 0x00000000000000f0ULL;
> +		break;
> +	}
> +
> +	pid = raw_clone(&args, size);
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
> +	ppid = getpid();

Nit:
You don't need the additional ppid variable since you're only using it
once. You an just call getpid() and be done I think.

> +	ksft_print_msg("I am the parent (%d). My child's pid is %d\n",
> +			ppid, pid);
> +
> +	(void)wait(&status);
> +	if (WEXITSTATUS(status))
> +		return WEXITSTATUS(status);

This should probably be at least:

if (wait(&status) < 0)
	return <some-errno-value-you-find-reasonable>;
if (WEXITSTATUS(status))
	return WEXITSTATUS(status);

otherwise status is not meaningful.

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
> +	ksft_print_header();
> +	ksft_set_plan(17);
> +
> +	/* Just a simple clone3() should return 0.*/
> +	test_clone3(0, 0, 0, CLONE3_ARGS_NO_TEST);

Nit:
Can you place \n between all of those? I think that makes it more
readable here because all of the tests have comments.

> +	/* Do a clone3() in a new PID NS.*/
> +	test_clone3(CLONE_NEWPID, 0, 0, CLONE3_ARGS_NO_TEST);
> +	/* Do a clone3() with CLONE3_ARGS_SIZE_V0. */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0, 0, CLONE3_ARGS_NO_TEST);
> +	/* Do a clone3() with CLONE3_ARGS_SIZE_V0 - 8 */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0 - 8, -EINVAL, CLONE3_ARGS_NO_TEST);
> +	/* Do a clone3() with sizeof(struct clone_args) + 8 */
> +	test_clone3(0, sizeof(struct clone_args) + 8, 0, CLONE3_ARGS_NO_TEST);
> +	/* Do a clone3() with all members set to 1 */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL, CLONE3_ARGS_ALL_1);
> +	/* Do a clone3() with exit_signal having highest 32 bits non-zero */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
> +			CLONE3_ARGS_INVAL_EXIT_SIGNAL_BIG);
> +	/* Do a clone3() with negative 32-bit exit_signal */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
> +			CLONE3_ARGS_INVAL_EXIT_SIGNAL_NEG);
> +	/* Do a clone3() with exit_signal not fitting into CSIGNAL mask */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
> +			CLONE3_ARGS_INVAL_EXIT_SIGNAL_CSIG);
> +	/* Do a clone3() with NSIG < exit_signal < CSIG */
> +	test_clone3(0, CLONE3_ARGS_SIZE_V0, -EINVAL,
> +			CLONE3_ARGS_INVAL_EXIT_SIGNAL_NSIG);
> +	/*
> +	 * Do a clone3() with sizeof(struct clone_args) + 8
> +	 * and all members set to 0.
> +	 */
> +	test_clone3(0, sizeof(struct clone_args) + 8, 0, CLONE3_ARGS_ALL_0);
> +	/*
> +	 * Do a clone3() with sizeof(struct clone_args) + 8
> +	 * and all members set to 0.
> +	 */
> +	test_clone3(0, sizeof(struct clone_args) + 8, -EINVAL,
> +				CLONE3_ARGS_ALL_1);

Hm... All of those size checks do not change the actual struct size,
right? Only the size _argument_. Wouldn't it make more sense to also
perform size tests where you e.g. do

struct clone_args_extended {
	struct clone_args args;
	__aligned_u64 execess_space[2];
};

and then you can perform tests such as:

struct clone_args_extended args_ext;
memset(&args_exit, 0, sizeof(args_exit));
args_ext.excess_space[1] = 1;
pid = raw_clone(&args_ext.args, sizeof(clone_args_extended));

Christian
