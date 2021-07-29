Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD20E3DA885
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 18:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbhG2QLH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 12:11:07 -0400
Received: from foss.arm.com ([217.140.110.172]:51752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232855AbhG2QII (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 12:08:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 95EC91FB;
        Thu, 29 Jul 2021 09:08:04 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 943F93F73D;
        Thu, 29 Jul 2021 09:08:03 -0700 (PDT)
Date:   Thu, 29 Jul 2021 17:06:42 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210729160642.GP1724@arm.com>
References: <20210729151518.46388-1-broonie@kernel.org>
 <20210729151518.46388-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729151518.46388-4-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, Jul 29, 2021 at 04:15:17PM +0100, Mark Brown wrote:
> We provide interfaces for configuring the SVE vector length seen by
> processes using prctl and also via /proc for configuring the default
> values. Provide tests that exercise all these interfaces and verify that
> they take effect as expected, though at present no test fully enumerates
> all the possible vector lengths.
> 
> A subset of this is already tested via sve-probe-vls but the /proc
> interfaces are not currently covered at all.
> 
> In preparation for the forthcoming support for SME, the Scalable Matrix
> Extension, which has separately but similarly configured vector lengths
> which we expect to offer similar userspace interfaces for, all the actual
> files and prctls used are parameterised and we don't validate that the
> architectural minimum vector length is the minimum we see.

Looks good except for the fscanf thing below.

The rest is really at the pedantic nit level, so I won't mind too much
if those are quietly dropped.

> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/.gitignore   |   1 +
>  tools/testing/selftests/arm64/fp/Makefile     |   3 +-
>  tools/testing/selftests/arm64/fp/vec-syscfg.c | 594 ++++++++++++++++++
>  3 files changed, 597 insertions(+), 1 deletion(-)
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
> index 000000000000..e8ba679aec29
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> @@ -0,0 +1,594 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2021 ARM Limited.
> + * Original author: Mark Brown <broonie@kernel.org>
> + */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stddef.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/auxv.h>
> +#include <sys/prctl.h>
> +#include <sys/types.h>
> +#include <sys/wait.h>
> +#include <asm/sigcontext.h>
> +#include <asm/hwcap.h>
> +
> +#include "../../kselftest.h"
> +#include "rdvl.h"
> +
> +#define ARRAY_SIZE(a) (sizeof(a) / sizeof(a[0]))
> +
> +#define ARCH_MIN_VL SVE_VL_MIN
> +
> +struct vec_data {
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
> +};
> +
> +
> +static struct vec_data vec_data[] = {
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
> +static int stdio_read_integer(FILE *f, const char *what, int *val)
> +{
> +	int ret;
> +
> +	ret = fscanf(f, "%d*1[\n]*n", val);

Argh, I mangled this in my last reply, though it was right in the
previous reply.  I think this should be

	int ret, n = 0;

	ret = fscanf(f, "%d%*1[\n]%n", val, &n);
	fclose(f);
	if (ret < 1 || n < 1) {
		/* ... */

The %n ... &n is needed because nobody knows whether the scanf return
value includes suppressed assignments, so we might get 1 whether or not
the %*1[\n] is matched...
	
> +	fclose(f);

It feels a bit unbalanced to have the fclose() in here, since the
fopen() is outside.  Can it be pushed back out into file_read_integer()
and get_child_rdvl()?

Or call this function stdio_read_integer_and_close(), I suppose.

> +	if (ret != 1) {
> +		ksft_print_msg("failed to parse VL from %s\n", what);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/* Start a new process and return the vector length it sees */
> +static int get_child_rdvl(struct vec_data *data)
> +{
> +	FILE *out;
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
> +
> +	fflush(stdout);
> +
> +	child = fork();
> +	if (child == -1) {
> +		ksft_print_msg("fork() failed: %d (%s)\n",
> +			       errno, strerror(errno));
> +		close(pipefd[0]);
> +		close(pipefd[1]);
> +		return -1;

Since nothing reopens pipefd[0] or pipefd[1], you could also follow the
"goto out" convention and just (re)close both fds at the end, rather
than having to repeat the close() multiple times.  But it works as-is.

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
> +			exit(EXIT_FAILURE);
> +		}
> +
> +		/* exec() a new binary which puts the VL on stdout */
> +		ret = execl(data->rdvl_binary, data->rdvl_binary, NULL);
> +		fprintf(stderr, "execl(%s) failed: %d\n",
> +			data->rdvl_binary, errno, strerror(errno));
> +
> +		exit(EXIT_FAILURE);
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
> +			close(pipefd[0]);
> +			return -1;
> +		}
> +
> +		if (pid != child)
> +			continue;
> +
> +		if (!WIFEXITED(ret)) {
> +			ksft_print_msg("child exited abnormally\n");
> +			close(pipefd[0]);
> +			return -1;
> +		}

The WEXITSTATUS() check could go outside the loop.

> +
> +		if (WEXITSTATUS(ret) != 0) {
> +			ksft_print_msg("child returned error %d\n",
> +				       WEXITSTATUS(ret));
> +			close(pipefd[0]);
> +			return -1;
> +		}
> +
> +		break;
> +	}

The break looks funny to me, since there is only one possible child
process anyway, perhaps this could be rewritten as

	do {
		pid = wait(&ret);
		if (pid == -1) {
			/* ... */
			return -1;
		}
	} while (pid != child);

	assert(pid == child);

	if (!WIFEXITED(ret))
		/* barf */

	if (WEXITSTATUS(ret) != 0)
		/* barf */

	out = fdopen( /* ... */
> +
> +	out = fdopen(pipefd[0], "r");
> +	if (!out) {
> +		ksft_print_msg("failed to open child stdout\n");
> +		close(pipefd[0]);
> +		return -1;
> +	}
> +
> +	ret = stdio_read_integer(out, "child", &read_vl);
> +	if (ret != 0)
> +		return ret;
> +
> +	return read_vl;
> +}
> +
> +static int file_read_integer(const char *name, int *val)
> +{
> +	FILE *f;
> +	int ret;
> +
> +	f = fopen(name, "r");
> +	if (!f) {
> +		ksft_test_result_fail("Unable to open %s: %d (%s)\n",
> +				      name, errno,
> +				      strerror(errno));
> +		return -1;
> +	}
> +
> +	return stdio_read_integer(f, name, val);
> +
> +	return 0;
> +}
> +
> +static int file_write_integer(const char *name, int val)
> +{
> +	FILE *f;
> +	int ret;
> +
> +	f = fopen(name, "w");
> +	if (!f) {
> +		ksft_test_result_fail("Unable to open %s: %d (%s)\n",
> +				      name, errno,
> +				      strerror(errno));
> +		return -1;
> +	}
> +
> +	fprintf(f, "%d", val);
> +	fclose(f);
> +	if (ret < 0) {
> +		ksft_test_result_fail("Error writing %d to %s\n",
> +				      val, name);
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Verify that we can read the default VL via proc, checking that it
> + * is set in a freshly spawned child.
> + */
> +static void proc_read_default(struct vec_data *data)
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
> +static void proc_write_min(struct vec_data *data)
> +{
> +	int ret, new_default, child_vl;
> +
> +	if (geteuid() != 0) {
> +		ksft_test_result_skip("Need to be root to write to /proc\n");
> +		return;
> +	}
> +
> +	ret = file_write_integer(data->default_vl_file, ARCH_MIN_VL);
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
> +static void proc_write_max(struct vec_data *data)
> +{
> +	int ret, new_default, child_vl;
> +
> +	if (geteuid() != 0) {
> +		ksft_test_result_skip("Need to be root to write to /proc\n");
> +		return;
> +	}
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
> +static void prctl_get(struct vec_data *data)
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
> +static void prctl_set_same(struct vec_data *data)
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
> +static void prctl_set(struct vec_data *data)
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
> +static void prctl_set_no_child(struct vec_data *data)
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
> +static void prctl_set_for_child(struct vec_data *data)
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
> +static void prctl_set_onexec(struct vec_data *data)
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
> +static const test_type tests[] = {
> +	/*
> +	 * The default/min/max tests must be first and in this order
> +	 * to provide data for other tests.
> +	 */
> +	proc_read_default,
> +	proc_write_min,
> +	proc_write_max,
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
> +		unsigned long supported;
> +
> +		supported = getauxval(data->hwcap_type) & data->hwcap;
> +
> +		for (j = 0; j < ARRAY_SIZE(tests); j++) {
> +			if (supported)
> +				tests[j](data);
> +			else
> +				ksft_test_result_skip("%s not supported\n",
> +						      data->name);
> +		}
> +	}
> +
> +	ksft_exit_pass();
> +}
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
