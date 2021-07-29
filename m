Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20A853DA0A4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 11:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbhG2JyO (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 05:54:14 -0400
Received: from foss.arm.com ([217.140.110.172]:43778 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235058AbhG2JyN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 05:54:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C46F56D;
        Thu, 29 Jul 2021 02:54:10 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DEC423F73D;
        Thu, 29 Jul 2021 02:54:09 -0700 (PDT)
Date:   Thu, 29 Jul 2021 10:52:49 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/4] kselftest/arm64: Add tests for SVE vector
 configuration
Message-ID: <20210729095248.GJ1724@arm.com>
References: <20210728163318.51492-1-broonie@kernel.org>
 <20210728163318.51492-4-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728163318.51492-4-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 05:33:17PM +0100, Mark Brown wrote:
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
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  tools/testing/selftests/arm64/fp/.gitignore   |   1 +
>  tools/testing/selftests/arm64/fp/Makefile     |   3 +-
>  tools/testing/selftests/arm64/fp/vec-syscfg.c | 580 ++++++++++++++++++
>  3 files changed, 583 insertions(+), 1 deletion(-)
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
> index 000000000000..63d080537d21
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/vec-syscfg.c
> @@ -0,0 +1,580 @@
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
> +#include <sys/ptrace.h>

Nit: ^ also still not used? (I think you caught <asm/ptrace.h> already.)

(Hmm, there must be a tool for weeding #includes somewhere...)

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
> +/* Start a new process and return the vector length it sees */
> +int get_child_rdvl(struct vec_data *data)
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
> +		return -1;

Leaks pipefd[0], pipefd[1]?

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
> +			return -1;

Leaks pipefd[0]?

> +		}
> +
> +		if (pid != child)
> +			continue;
> +
> +		if (!WIFEXITED(ret)) {
> +			ksft_print_msg("child exited abnormally\n");
> +			return -1;

Same from here up to the fclose().


Although this looks like it might have been based on code I wrote
previously(?), I guess it might be better to move all the
post-child-exit code out of the loop, since it really only executes
once, and any mishap is treated as fatal anyway.  It looks kind of
weird to have close() in the loop (even if hidden now in fclose())
with pipe() outside.

There's only one child anyway, and we treat !WIFEXITED() as an error
(without WUNTRACED or similar and since we are not a tracer,
WIFSIGNALED is the only other possbility IIUC.)

> +		}
> +
> +		if (WEXITSTATUS(ret) != 0) {
> +			ksft_print_msg("child returned error %d\n",
> +				       WEXITSTATUS(ret));
> +			return -1;
> +		}
> +
> +		out = fdopen(pipefd[0], "r");
> +		if (!out) {
> +			ksft_print_msg("failed to open child stdout\n");
> +			return -1;
> +		}
> +
> +		ret = fscanf(out, "%d", &read_vl);

Is it still worth slurping the newline here?  That's the only way to
tell the difference between complete line and truncation of the stream.

The "%d%*1[\n]*n" trick from my previous reply would probably work for
that.  Or maybe just checking for the '\n' with an fgetc() after the
fscanf() would work.  I don't remember offhand whether scanf is allowed
to silently consume trailing whitespace after a conversion, which would
be a problem for the fgetc() approach.  Maybe not though.

OTOH this is a pipe, and with my suggestion on the sve-rdvl patch,
the child should report nonzero exit status if something goes wrong on
its end.  So there's not a lot that can actually go wrong that we
wouldn't detect somehow.

Either way, this still looks a lot like file_read_integer() and the
error detection discussion applies to both.

Could the code be factored out as

int ffile_read_integer(int *val, FILE *f) {
	...
}

int file_read_integer(const char *name, int val) {
	fopen() ... ffile_read_integer() ... fclose()
}

> +		fclose(out);
> +		if (ret != 1) {
> +			ksft_print_msg("failed to parse VL from '%s'\n",
> +				       data->rdvl_binary);
> +			return -1;
> +		}
> +
> +		return read_vl;
> +	}
> +}
> +
> +int file_read_integer(const char *name, int *val)
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
> +	ret = fscanf(f, "%d", val);
> +	fclose(f);
> +	if (ret != 1) {
> +		ksft_test_result_fail("Failed to parse %s\n", name);
> +		return -1;
> +	}
> +
> +	return 0;
> +}

[...]

> +typedef void (*test_type)(struct vec_data *);
> +
> +test_type tests[] = {
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

This can be static const too come to think of it, and every function
except main() can be static...

[...]

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

Did we commit to never defining hwcaps beyond bit 31?  It sort of looks
this way from arch/arm64/include/uapi/asm/hwcap.h, but I can't remember
the reason.  I'd say something to do with compat, only of course that
has its own hwcaps.

Since getauxval() returns an unsigned long, would it be a good idea to
make this:

		int supported = (getauxval(data->hwcap_type) & data->hwcap) != 0;

or

		unsigned long supported_hwcaps = getauxval(data->hwcap_type);

		/* ... */

			if (supported_hwcaps & data->hwcap)

just to avoid future surprises?

[...]

Cheers
---Dave
