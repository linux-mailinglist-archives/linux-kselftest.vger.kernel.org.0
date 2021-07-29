Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43E9C3DA09D
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Jul 2021 11:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235058AbhG2Jxu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Jul 2021 05:53:50 -0400
Received: from foss.arm.com ([217.140.110.172]:43752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231488AbhG2Jxt (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Jul 2021 05:53:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 92BF56D;
        Thu, 29 Jul 2021 02:53:46 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC38A3F73D;
        Thu, 29 Jul 2021 02:53:45 -0700 (PDT)
Date:   Thu, 29 Jul 2021 10:52:24 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 1/4] kselftest/arm64: Provide a helper binary and
 "library" for SVE RDVL
Message-ID: <20210729095222.GH1724@arm.com>
References: <20210728163318.51492-1-broonie@kernel.org>
 <20210728163318.51492-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210728163318.51492-2-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Jul 28, 2021 at 05:33:15PM +0100, Mark Brown wrote:
> SVE provides an instruction RDVL which reports the currently configured
> vector length. In order to validate that our vector length configuration
> interfaces are working correctly without having to build the C code for
> our test programs with SVE enabled provide a trivial assembly library
> with a C callable function that executes RDVL. Since these interfaces
> also control behaviour on exec*() provide a trivial wrapper program which
> reports the currently configured vector length on stdout, tests can use
> this to verify that behaviour on exec*() is as expected.
> 
> In preparation for providing similar helper functionality for SME, the
> Scalable Matrix Extension, which allows separately configured vector
> lengths to be read back both the assembler function and wrapper binary
> have SVE included in their name.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Reviewed-by: Dave Martin <Dave.Martin@arm.com>

(With or without a couple of trivial nits below.)

> ---
>  tools/testing/selftests/arm64/fp/.gitignore |  1 +
>  tools/testing/selftests/arm64/fp/Makefile   |  6 +++++-
>  tools/testing/selftests/arm64/fp/rdvl-sve.c | 14 ++++++++++++++
>  tools/testing/selftests/arm64/fp/rdvl.S     |  9 +++++++++
>  tools/testing/selftests/arm64/fp/rdvl.h     |  8 ++++++++
>  5 files changed, 37 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/arm64/fp/rdvl-sve.c
>  create mode 100644 tools/testing/selftests/arm64/fp/rdvl.S
>  create mode 100644 tools/testing/selftests/arm64/fp/rdvl.h
> 
> diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
> index d66f76d2a650..6b53a7b60fee 100644
> --- a/tools/testing/selftests/arm64/fp/.gitignore
> +++ b/tools/testing/selftests/arm64/fp/.gitignore
> @@ -1,4 +1,5 @@
>  fpsimd-test
> +rdvl-sve
>  sve-probe-vls
>  sve-ptrace
>  sve-test
> diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
> index a57009d3a0dc..ed62e7003b96 100644
> --- a/tools/testing/selftests/arm64/fp/Makefile
> +++ b/tools/testing/selftests/arm64/fp/Makefile
> @@ -2,12 +2,16 @@
>  
>  CFLAGS += -I../../../../../usr/include/
>  TEST_GEN_PROGS := sve-ptrace sve-probe-vls
> -TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress sve-test sve-stress vlset
> +TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
> +	rdvl-sve \
> +	sve-test sve-stress \
> +	vlset
>  
>  all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
>  
>  fpsimd-test: fpsimd-test.o
>  	$(CC) -nostdlib $^ -o $@
> +rdvl-sve: rdvl-sve.o rdvl.o
>  sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
>  sve-probe-vls: sve-probe-vls.o
>  sve-test: sve-test.o
> diff --git a/tools/testing/selftests/arm64/fp/rdvl-sve.c b/tools/testing/selftests/arm64/fp/rdvl-sve.c
> new file mode 100644
> index 000000000000..7f8a13a18f5d
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/rdvl-sve.c
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <stdio.h>
> +
> +#include "rdvl.h"
> +
> +int main(void)
> +{
> +	int vl = rdvl_sve();
> +
> +	printf("%d\n", vl);
> +
> +	return 0;

For consistency with the changes in vec-syscfg, we could use
EXIT_SUCCESS here.

Although it's hard to see what could go wrong I/O-wise that doesn't
involve vec-syscfg itself having gone wrong, it's probably good
practice to do the final error check:

	if (ferror(stdout) || fclose(stdout))
		return EXIT_FAILURE;

	return EXIT_SUCCESS;

(In reality, people rarely seem to bother with this, so I'm not going
to lose sleep if we don't do it...)

> +}
> diff --git a/tools/testing/selftests/arm64/fp/rdvl.S b/tools/testing/selftests/arm64/fp/rdvl.S
> new file mode 100644
> index 000000000000..6e76dd720b87
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/rdvl.S
> @@ -0,0 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (C) 2021 ARM Limited.
> +
> +.arch_extension sve
> +
> +.globl rdvl_sve

Should we stick a

	.type rdvl_sve, @function

here?  This may avoid surprises with future toolchain behaviours.
Probably doesn't matter, but I have bad memories of Thumb-2...

Lacking this annotation is widespread though, as well as being de facto
standard before awkward architectures came along.

If the selftests have access to the ENTRY() macro we could use that, but
I'm guessing that isn't exported for userspace.

> +rdvl_sve:
> +	rdvl	x0, #1
> +	ret
> diff --git a/tools/testing/selftests/arm64/fp/rdvl.h b/tools/testing/selftests/arm64/fp/rdvl.h
> new file mode 100644
> index 000000000000..7c9d953fc9e7
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/fp/rdvl.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +
> +#ifndef RDVL_H
> +#define RDVL_H
> +
> +int rdvl_sve(void);
> +
> +#endif
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
