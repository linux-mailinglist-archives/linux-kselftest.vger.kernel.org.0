Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A2D3D8AFC
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 11:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235396AbhG1JnV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 05:43:21 -0400
Received: from foss.arm.com ([217.140.110.172]:54064 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231783AbhG1JnV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 05:43:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D6A71FB;
        Wed, 28 Jul 2021 02:43:20 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D0383F73D;
        Wed, 28 Jul 2021 02:43:19 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:41:58 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 3/3] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210728094158.GC1724@arm.com>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727180649.12943-4-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 27, 2021 at 07:06:49PM +0100, Mark Brown wrote:
> We provide interfaces for configuring the SVE vector length seen by
> processes using prctl and also via /proc for configuring the default
> values. Provide tests that exercise all these interfaces and verify that
> they take effect as expected, though at present no test fully enumerates
> all the possible vector lengths.

Does "at present" mean that this test doesn't do it either?

(It doesn't seem to try every VL, unless I've missed something?  Is this
planned?)

> A subset of this is already tested via sve-probe-vls but the /proc
> interfaces are not currently covered at all.
> 
> In preparation for the forthcoming support for SME, the Scalable Matrix
> Extension, which has separately but similarly configured vector lengths
> which we expect to offer similar userspace interfaces for, all the actual
> files and prctls used are parameterised and we don't validate that the
> architectural minimum vector length is the minimum we see.

This looks like a good addition overall...

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/.gitignore   |   1 +
>  tools/testing/selftests/arm64/fp/Makefile     |   3 +-
>  tools/testing/selftests/arm64/fp/vec-syscfg.c | 578 ++++++++++++++++++
>  3 files changed, 581 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/arm64/fp/vec-syscfg.c
> 
> diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
> index 6b53a7b60fee..b67395903b9b 100644
> --- a/tools/testing/selftests/arm64/fp/.gitignore
> +++ b/tools/testing/selftests/arm64/fp/.gitignore
> @@ -3,4 +3,5 @@ rdvl-sve
>  sve-probe-vls
>  sve-ptrace
>  sve-test
> +vec-syscfg
>  vlset
> diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
> index fa3a0167db2d..f2abdd6ba12e 100644
> --- a/tools/testing/selftests/arm64/fp/Makefile
> +++ b/tools/testing/selftests/arm64/fp/Makefile
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  
>  CFLAGS += -I../../../../../usr/include/
> -TEST_GEN_PROGS := sve-ptrace sve-probe-vls
> +TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
>  TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
>  	rdvl-sve \
>  	sve-test sve-stress \
> @@ -16,6 +16,7 @@ sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
>  sve-probe-vls: sve-probe-vls.o rdvl.o
>  sve-test: sve-test.o
>  	$(CC) -nostdlib $^ -o $@
> +vec-syscfg: vec-syscfg.o rdvl.o
>  vlset: vlset.o
>  
>  include ../../lib.mk
> diff --git a/tools/testing/selftests/arm64/fp/vec-syscfg.c b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> new file mode 100644
> index 000000000000..360c3a7cae26
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> @@ -0,0 +1,578 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 ARM Limited.
> + * Original author: Mark Brown <broonie@kernel.org>
> + */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <limits.h>

Not used? ^

> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>

Not used? ^

> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/auxv.h>
> +#include <sys/prctl.h>
> +#include <sys/ptrace.h>

Not used? ^

> +#include <sys/types.h>
> +#include <sys/uio.h>

Not used? ^

(This would have been for struct iovec, for ptrace regset access.
I'm guessing some of this #include list was pasted from the existing
ptrace tests?)

> +#include <sys/wait.h>
> +#include <asm/sigcontext.h>
> +#include <asm/ptrace.h>

Not used? ^

> +
> +#include "../../kselftest.h"
> +#include "rdvl.h"
> +
> +#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
> +
> +#define MIN_VL 16

<asm/sigcontext.h> has SVE_MIN_VL.  Maybe we can use that everywhere
these days?

> +
> +struct vec_data {

Could be const; persumably also static?

Maybe split the struct definition from the definition of vec_data[],
since it's a bit long.

> +	const char *name;
> +	unsigned long hwcap_type;
> +	unsigned long hwcap;
> +	const char *rdvl_binary;
> +	int (*rdvl)(void);
> +
> +	int prctl_get;
> +	int prctl_set;
> +	const char *default_vl_file;
> +
> +	int default_vl;
> +	int min_vl;
> +	int max_vl;

Ah, mind you, these are written by the test.  Never mind.  Seems
overkill to split this up just to constify.

> +} vec_data[] = {
> +	{
> +		.name = "SVE",
> +		.hwcap_type = AT_HWCAP,
> +		.hwcap = HWCAP_SVE,
> +		.rdvl = rdvl_sve,
> +		.rdvl_binary = "./rdvl-sve",
> +		.prctl_get = PR_SVE_GET_VL,
> +		.prctl_set = PR_SVE_SET_VL,
> +		.default_vl_file = "/proc/sys/abi/sve_default_vector_length",
> +	},
> +};
> +
> +/* Start a new process and return the vector length it sees */
> +int get_child_rdvl(struct vec_data *data)
> +{
> +	char buf[10];

10?

> +	int pipefd[2];
> +	pid_t pid, child;
> +	int read_vl, ret;
> +
> +	ret = pipe(pipefd);
> +	if (ret == -1) {
> +		ksft_print_msg("pipe() failed: %d (%s)\n",
> +			       errno, strerror(errno));
> +		return -1;
> +	}

Hmm, come to think of it:

--8<--
#include <stdio.h>

int main(void)
{
	puts("Listen very carefully, I shall say zees only once!");
	fork();
	return 0;
}
-->8--

$ ./fork

->
	Listen very carefully, I shall say zees only once!

$ ./fork | cat

->
	Listen very carefully, I shall say zees only once!
	Listen very carefully, I shall say zees only once!

Funny that doesn't come up more often.  I don't seem to recall this
being described anywhere.

Since we are about to change fd 1 under stdout's feet, it's probably at
least a good idea to fflush(stdout) before forking here.  I wonder
whether this should really be up to libc, but it's a tricky call since
flushing a stream could cause the process to block if there are clogged
pipes hanging off it.

> +
> +	child = fork();
> +	if (child == -1) {
> +		ksft_print_msg("fork() failed: %d (%s)\n",
> +			       errno, strerror(errno));
> +		return -1;
> +	}
> +
> +	/* Child: put vector length on the pipe */
> +	if (child == 0) {
> +		/*
> +		 * Replace stdout with the pipe, errors to stderr from
> +		 * here as kselftest prints to stdout.
> +		 */
> +		ret = dup2(pipefd[1], 1);
> +		if (ret == -1) {
> +			fprintf(stderr, "dup2() %d\n", errno);
> +			exit(-1);

Should these exit(-1) be exit(1)?  The exit status always gets truncated
to 8 bits, but I don't like to deliberately tease the kernel.

Or use the EXIT_foo codes from <stdlib.h>.

> +		}
> +
> +		/* exec() a new binary which puts the VL on stdout */
> +		ret = execl(data->rdvl_binary, data->rdvl_binary, NULL);
> +		fprintf(stderr, "execl(%s) failed: %d\n",
> +			data->rdvl_binary, errno, strerror(errno));
> +
> +		exit(-1);
> +	}
> +
> +	close(pipefd[1]);
> +
> +	/* Parent; wait for the exit status from the child & verify it */
> +	while (1) {
> +		pid = wait(&ret);
> +		if (pid == -1) {
> +			ksft_print_msg("wait() failed: %d (%s)\n",
> +				       errno, strerror(errno));
> +			return -1;
> +		}
> +
> +		if (pid != child)
> +			continue;
> +
> +		if (!WIFEXITED(ret)) {
> +			ksft_print_msg("child exited abnormally\n");
> +			return -1;
> +		}
> +
> +		if (WEXITSTATUS(ret) != 0) {
> +			ksft_print_msg("child returned error %d\n",
> +				       WEXITSTATUS(ret));
> +			return -1;
> +		}
> +
> +		memset(buf, 0, sizeof(buf));
> +		ret = read(pipefd[0], buf, sizeof(buf) - 1);
> +		if (ret <= 0) {
> +			ksft_print_msg("read() failed: %d (%s)\n",
> +				       errno, strerror(errno));
> +			return -1;
> +		}
> +		close(pipefd[0]);
> +
> +		ret = sscanf(buf, "%d", &read_vl);

To be robust against truncation, we could do

	int n = 0;
	ret = sscanf(buf, "%d%*1[\n]%n", &read_vl, &n);
	if (ret < 1 || n < 1) { ...

Alternatively, can we just use fdopen() and fscanf()?  Then we don't
have to sweat details like buffer sizes at all.

This "read a single integer from an fd" thing is done a few times, maybe
it's worth wrapping up in a helper, or just use stdio everywhere
possible.

> +		if (ret != 1) {
> +			ksft_print_msg("failed to parse VL from '%s'\n",
> +				       buf);
> +			return -1;
> +		}
> +
> +		return read_vl;
> +	}
> +}
> +
> +int file_read_integer(const char *name, int *val)
> +{
> +	char buf[40];
> +	int f, ret;
> +
> +	f = open(name, O_RDONLY);
> +	if (f < 0) {
> +		ksft_test_result_fail("Unable to open %s: %d (%s)\n",
> +				      name, errno,
> +				      strerror(errno));
> +		return -1;
> +	}
> +
> +	memset(buf, 0, sizeof(buf));
> +	ret = read(f, buf, sizeof(buf) - 1);
> +	if (ret < 0) {
> +		ksft_test_result_fail("Error reading %s: %d (%s)\n",
> +				      name, errno, strerror(errno));
> +		return -1;
> +	}
> +	close(f);
> +
> +	ret = sscanf(buf, "%d", val);
> +	if (ret != 1) {
> +		ksft_test_result_fail("Failed to parse %s\n", name);
> +		return -1;
> +	}

Can all this be done with fopen+fscanf+fclose?

> +
> +	return 0;
> +}
> +
> +int file_write_integer(const char *name, int val)
> +{
> +	char buf[40];
> +	int f, ret;
> +
> +	f = open(name, O_WRONLY);
> +	if (f < 0) {
> +		ksft_test_result_fail("Unable to open %s: %d (%s)\n",
> +				      name, errno,
> +				      strerror(errno));
> +		return -1;
> +	}
> +
> +	snprintf(buf, sizeof(buf), "%d", val);
> +	ret = write(f, buf, strlen(buf));
> +	if (ret < 0) {
> +		ksft_test_result_fail("Error writing %d to %s: %d (%s)\n",
> +				      val, name, errno, strerror(errno));
> +		return -1;
> +	}
> +	close(f);

Similarly here.

> +
> +	return 0;
> +}
> +
> +/*
> + * Verify that we can read the default VL via proc, checking that it
> + * is set in a freshly spawned child.
> + */
> +void proc_read_default(struct vec_data *data)

Since we also check that the default takes effect, can this be renamed
proc_verify_default() or similar?

> +{
> +	int default_vl, child_vl, ret;
> +
> +	ret = file_read_integer(data->default_vl_file, &default_vl);
> +	if (ret != 0)
> +		return;
> +
> +	/* Is this the actual default seen by new processes? */
> +	child_vl = get_child_rdvl(data);
> +	if (child_vl != default_vl) {
> +		ksft_test_result_fail("%s is %d but child VL is %d\n",
> +				      data->default_vl_file,
> +				      default_vl, child_vl);
> +		return;
> +	}
> +
> +	ksft_test_result_pass("%s default vector length %d\n", data->name,
> +			      default_vl);
> +	data->default_vl = default_vl;
> +}
> +
> +/* Verify that we can write a minimum value and have it take effect */
> +void proc_write_min(struct vec_data *data)

Could be proc_write_check_min() (though the "check" is a bit more
redundant here; from "write" it's clear that this function actually
does something nontrivial).

> +{
> +	int ret, new_default, child_vl;
> +
> +	ret = file_write_integer(data->default_vl_file, MIN_VL);
> +	if (ret != 0)
> +		return;
> +
> +	/* What was the new value? */
> +	ret = file_read_integer(data->default_vl_file, &new_default);
> +	if (ret != 0)
> +		return;
> +
> +	/* Did it take effect in a new process? */
> +	child_vl = get_child_rdvl(data);
> +	if (child_vl != new_default) {
> +		ksft_test_result_fail("%s is %d but child VL is %d\n",
> +				      data->default_vl_file,
> +				      new_default, child_vl);
> +		return;
> +	}
> +
> +	ksft_test_result_pass("%s minimum vector length %d\n", data->name,
> +			      new_default);
> +	data->min_vl = new_default;
> +
> +	file_write_integer(data->default_vl_file, data->default_vl);
> +}
> +
> +/* Verify that we can write a maximum value and have it take effect */
> +void proc_write_max(struct vec_data *data)
> +{
> +	int ret, new_default, child_vl;
> +
> +	/* -1 is accepted by the /proc interface as the maximum VL */
> +	ret = file_write_integer(data->default_vl_file, -1);
> +	if (ret != 0)
> +		return;
> +
> +	/* What was the new value? */
> +	ret = file_read_integer(data->default_vl_file, &new_default);
> +	if (ret != 0)
> +		return;
> +
> +	/* Did it take effect in a new process? */
> +	child_vl = get_child_rdvl(data);
> +	if (child_vl != new_default) {
> +		ksft_test_result_fail("%s is %d but child VL is %d\n",
> +				      data->default_vl_file,
> +				      new_default, child_vl);
> +		return;
> +	}
> +
> +	ksft_test_result_pass("%s maximum vector length %d\n", data->name,
> +			      new_default);
> +	data->max_vl = new_default;
> +
> +	file_write_integer(data->default_vl_file, data->default_vl);
> +}
> +
> +/* Can we read back a VL from prctl? */

It's certainly possible.

I used to have a tool that found out the current VL of a running PID
using ptrace, but I didn't want people thinking that connecting to
random running processes just to find this out was a good idea...

For these tests you could just exec /bin/true (or even argv[0], to
avoid fs dependencies -- doesn't matter what is exec'd) and just read
the VL at the ptrace post-exec stop before throwing the child a SIGKILL.

Since this would test different kernel paths from getting the child
itself to do RVDL / PR_SVE_GET_VL, it would be a different test though.
I think this diff is still good, but beefing up the ptrace tests to do
the appropriate checks would be good too (if we don't have that already).

> +void prctl_get(struct vec_data *data)
> +{
> +	int ret;
> +
> +	ret = prctl(data->prctl_get);
> +	if (ret == -1) {
> +		ksft_test_result_fail("%s prctl() read failed: %d (%s)\n",
> +				      data->name, errno, strerror(errno));
> +		return;
> +	}
> +
> +	/* Mask out any flags */
> +	ret &= PR_SVE_VL_LEN_MASK;
> +
> +	/* Is that what we can read back directly? */
> +	if (ret == data->rdvl())
> +		ksft_test_result_pass("%s current VL is %d\n",
> +				      data->name, ret);
> +	else
> +		ksft_test_result_fail("%s prctl() VL %d but RDVL is %d\n",
> +				      data->name, ret, data->rdvl());
> +}
> +
> +/* Does the prctl let us set the VL we already have? */
> +void prctl_set_same(struct vec_data *data)
> +{
> +	int cur_vl = data->rdvl();
> +	int ret;
> +
> +	ret = prctl(data->prctl_set, cur_vl);
> +	if (ret < 0) {
> +		ksft_test_result_fail("%s prctl set failed: %d (%s)\n",
> +				      data->name, errno, strerror(errno));
> +		return;
> +	}
> +
> +	if (cur_vl != data->rdvl())
> +		ksft_test_result_pass("%s current VL is %d\n",
> +				      data->name, ret);
> +	else
> +		ksft_test_result_fail("%s prctl() VL %d but RDVL is %d\n",
> +				      data->name, ret, data->rdvl());
> +}
> +
> +/* Can we set a new VL for this process? */
> +void prctl_set(struct vec_data *data)
> +{
> +	int ret;
> +
> +	if (data->min_vl == data->max_vl) {
> +		ksft_test_result_skip("%s only one VL supported\n",
> +				      data->name);
> +		return;
> +	}
> +
> +	/* Try to set the minimum VL */
> +	ret = prctl(data->prctl_set, data->min_vl);
> +	if (ret < 0) {
> +		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
> +				      data->name, data->min_vl,
> +				      errno, strerror(errno));
> +		return;
> +	}
> +
> +	if ((ret & PR_SVE_VL_LEN_MASK) != data->min_vl) {
> +		ksft_test_result_fail("%s prctl set %d but return value is %d\n",
> +				      data->name, data->min_vl, data->rdvl());
> +		return;
> +	}
> +
> +	if (data->rdvl() != data->min_vl) {
> +		ksft_test_result_fail("%s set %d but RDVL is %d\n",
> +				      data->name, data->min_vl, data->rdvl());
> +		return;
> +	}
> +
> +	/* Try to set the maximum VL */
> +	ret = prctl(data->prctl_set, data->max_vl);
> +	if (ret < 0) {
> +		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
> +				      data->name, data->max_vl,
> +				      errno, strerror(errno));
> +		return;
> +	}
> +
> +	if ((ret & PR_SVE_VL_LEN_MASK) != data->max_vl) {
> +		ksft_test_result_fail("%s prctl() set %d but return value is %d\n",
> +				      data->name, data->max_vl, data->rdvl());
> +		return;
> +	}
> +
> +	/* The _INHERIT flag should not be present when we read the VL */
> +	ret = prctl(data->prctl_get);
> +	if (ret == -1) {
> +		ksft_test_result_fail("%s prctl() read failed: %d (%s)\n",
> +				      data->name, errno, strerror(errno));
> +		return;
> +	}
> +
> +	if (ret & PR_SVE_VL_INHERIT) {
> +		ksft_test_result_fail("%s prctl() reports _INHERIT\n",
> +				      data->name);
> +		return;
> +	}
> +
> +	ksft_test_result_pass("%s prctl() set min/max\n", data->name);
> +}
> +
> +/* If we didn't request it a new VL shouldn't affect the child */
> +void prctl_set_no_child(struct vec_data *data)
> +{
> +	int ret, child_vl;
> +
> +	if (data->min_vl == data->max_vl) {
> +		ksft_test_result_skip("%s only one VL supported\n",
> +				      data->name);
> +		return;
> +	}
> +
> +	ret = prctl(data->prctl_set, data->min_vl);
> +	if (ret < 0) {
> +		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
> +				      data->name, data->min_vl,
> +				      errno, strerror(errno));
> +		return;
> +	}
> +
> +	/* Ensure the default VL is different */
> +	ret = file_write_integer(data->default_vl_file, data->max_vl);
> +	if (ret != 0)
> +		return;
> +
> +	/* Check that the child has the default we just set */
> +	child_vl = get_child_rdvl(data);
> +	if (child_vl != data->max_vl) {
> +		ksft_test_result_fail("%s is %d but child VL is %d\n",
> +				      data->default_vl_file,
> +				      data->max_vl, child_vl);
> +		return;
> +	}
> +
> +	ksft_test_result_pass("%s vector length used default\n", data->name);
> +
> +	file_write_integer(data->default_vl_file, data->default_vl);
> +}
> +
> +/* If we didn't request it a new VL shouldn't affect the child */
> +void prctl_set_for_child(struct vec_data *data)
> +{
> +	int ret, child_vl;
> +
> +	if (data->min_vl == data->max_vl) {
> +		ksft_test_result_skip("%s only one VL supported\n",
> +				      data->name);
> +		return;
> +	}
> +
> +	ret = prctl(data->prctl_set, data->min_vl | PR_SVE_VL_INHERIT);
> +	if (ret < 0) {
> +		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
> +				      data->name, data->min_vl,
> +				      errno, strerror(errno));
> +		return;
> +	}
> +
> +	/* The _INHERIT flag should be present when we read the VL */
> +	ret = prctl(data->prctl_get);
> +	if (ret == -1) {
> +		ksft_test_result_fail("%s prctl() read failed: %d (%s)\n",
> +				      data->name, errno, strerror(errno));
> +		return;
> +	}
> +	if (!(ret & PR_SVE_VL_INHERIT)) {
> +		ksft_test_result_fail("%s prctl() does not report _INHERIT\n",
> +				      data->name);
> +		return;
> +	}
> +
> +	/* Ensure the default VL is different */
> +	ret = file_write_integer(data->default_vl_file, data->max_vl);
> +	if (ret != 0)
> +		return;
> +
> +	/* Check that the child inherited our VL */
> +	child_vl = get_child_rdvl(data);
> +	if (child_vl != data->min_vl) {
> +		ksft_test_result_fail("%s is %d but child VL is %d\n",
> +				      data->default_vl_file,
> +				      data->min_vl, child_vl);
> +		return;
> +	}
> +
> +	ksft_test_result_pass("%s vector length was inherited\n", data->name);
> +
> +	file_write_integer(data->default_vl_file, data->default_vl);
> +}
> +
> +/* _ONEXEC takes effect only in the child process */
> +void prctl_set_onexec(struct vec_data *data)
> +{
> +	int ret, child_vl;
> +
> +	if (data->min_vl == data->max_vl) {
> +		ksft_test_result_skip("%s only one VL supported\n",
> +				      data->name);
> +		return;
> +	}
> +
> +	/* Set a known value for the default and our current VL */
> +	ret = file_write_integer(data->default_vl_file, data->max_vl);
> +	if (ret != 0)
> +		return;
> +
> +	ret = prctl(data->prctl_set, data->max_vl);
> +	if (ret < 0) {
> +		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
> +				      data->name, data->min_vl,
> +				      errno, strerror(errno));
> +		return;
> +	}
> +
> +	/* Set a different value for the child to have on exec */
> +	ret = prctl(data->prctl_set, data->min_vl | PR_SVE_SET_VL_ONEXEC);
> +	if (ret < 0) {
> +		ksft_test_result_fail("%s prctl set failed for %d: %d (%s)\n",
> +				      data->name, data->min_vl,
> +				      errno, strerror(errno));
> +		return;
> +	}
> +
> +	/* Our current VL should stay the same */
> +	if (data->rdvl() != data->max_vl) {
> +		ksft_test_result_fail("%s VL changed by _ONEXEC prctl()\n",
> +				      data->name);
> +		return;
> +	}
> +
> +	/* Check that the child inherited our VL */
> +	child_vl = get_child_rdvl(data);
> +	if (child_vl != data->min_vl) {
> +		ksft_test_result_fail("%s is %d but child VL is %d\n",
> +				      data->default_vl_file,
> +				      data->min_vl, child_vl);
> +		return;
> +	}
> +
> +	ksft_test_result_pass("%s vector length set on exec\n", data->name);
> +
> +	file_write_integer(data->default_vl_file, data->default_vl);
> +}
> +
> +typedef void (*test_type)(struct vec_data *);
> +
> +test_type tests[] = {
> +	/*
> +	 * The default/min/max tests must be first to provide data for
> +	 * other tests.
> +	 */
> +	proc_read_default,
> +	proc_write_min,
> +	proc_write_max,

Can we also check what happens when writing unsupported values here?

e.g.

	vl where !sve_vl_valid();
	vl = 0;
	vl = max_supported_vl + 16;
	vl = SVE_VL_MAX;
	vl = INT_MAX / 16 * 16; (or possibly LONG_MAX.  What's the type in the
		kernel?)
	Any unsupported vl (on platforms where the set of supported vls is
		sparse, can be tested with qemu)

(As for what should happen, I can't remember for all cases -- check
sve.rst and the kernel code...)

If this patch is more about establishing the framework, these could be
TODOs for now.

> +
> +	prctl_get,
> +	prctl_set,
> +	prctl_set_no_child,
> +	prctl_set_for_child,
> +	prctl_set_onexec,
> +};
> +
> +int main(void)
> +{
> +	int i, j;
> +
> +	ksft_print_header();
> +	ksft_set_plan(ARRAY_SIZE(tests) * ARRAY_SIZE(vec_data));
> +
> +	for (i = 0; i < ARRAY_SIZE(vec_data); i++) {
> +		struct vec_data *data = &vec_data[i];
> +		int supported = getauxval(data->hwcap_type) & data->hwcap;
> +
> +		for (j = 0; j < ARRAY_SIZE(tests); j++) {
> +			if (supported)
> +				tests[j](data);
> +			else
> +				ksft_test_result_skip("%s not supported\n",
> +						      data->name);
> +		}
> +	}

Can we be a good citizen and restore sve_default_vector_length to its
original value?

Also, we should probably disable the default vector length writing tests
if not running with EUID==0.  Verifying that writing the default vector
length fails when non-root would be worth testing.  If running as root,
a temporary seteuid(nobody_uid) could be used for that.

(Not sure whether there's a correct way to get nobody_uid other than
with setpwent()/while { getpwent() ... }/endpwent(), but that's not too
hard.  Or just hardcode 65534 -- I'd be prepared to bet other tests do
that.  That would work fine without a proper filesystem.)

Cheers
---Dave
