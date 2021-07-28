Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C97113D8AFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Jul 2021 11:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235421AbhG1JnG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Jul 2021 05:43:06 -0400
Received: from foss.arm.com ([217.140.110.172]:54042 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231408AbhG1JnF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Jul 2021 05:43:05 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 012271FB;
        Wed, 28 Jul 2021 02:43:04 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 19AA13F73D;
        Wed, 28 Jul 2021 02:43:02 -0700 (PDT)
Date:   Wed, 28 Jul 2021 10:41:30 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v1 1/3] kselftest/arm64: Provide a helper binary and
 "library" for SVE RDVL
Message-ID: <20210728094117.GA1724@arm.com>
References: <20210727180649.12943-1-broonie@kernel.org>
 <20210727180649.12943-2-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727180649.12943-2-broonie@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 27, 2021 at 07:06:47PM +0100, Mark Brown wrote:
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
> +rdvl_sve:
> +	rdvl	x0, #1
> +	ret

This works, but can we use an ACLE intrinsic for this?  I'm pretty GCC
and LLVM have been up to date with that stuff for some time, though
you'd have to check with the compiler folks.

Alternatively:

static int rvdl_sve(void)
{
	int vl;

	asm ("rvdl %0, #1" : "=r" (vl));

	return vl;
}

would also work.

&rdvl_sve would not be the same in different translation units, but I
don't think the tests care about that(?)

[...]

Cheers
---Dave
