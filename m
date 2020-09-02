Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB2325B20A
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Sep 2020 18:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgIBQtG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 2 Sep 2020 12:49:06 -0400
Received: from foss.arm.com ([217.140.110.172]:42474 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgIBQtG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 2 Sep 2020 12:49:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 742AB1045;
        Wed,  2 Sep 2020 09:49:04 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 240463F66F;
        Wed,  2 Sep 2020 09:49:03 -0700 (PDT)
Date:   Wed, 2 Sep 2020 17:49:01 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Boyan Karatotev <boyan.karatotev@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, boian4o1@gmail.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        amit.kachhap@arm.com, vincenzo.frascino@arm.com,
        Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 1/4] kselftests/arm64: add a basic Pointer Authentication
 test
Message-ID: <20200902164858.GI6642@arm.com>
References: <20200828131606.7946-1-boyan.karatotev@arm.com>
 <20200828131606.7946-2-boyan.karatotev@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828131606.7946-2-boyan.karatotev@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Aug 28, 2020 at 02:16:03PM +0100, Boyan Karatotev wrote:
> PAuth signs and verifies return addresses on the stack. It does so by
> inserting a Pointer Authentication code (PAC) into some of the unused top
> bits of an address. This is achieved by adding paciasp/autiasp instructions
> at the beginning and end of a function.
> 
> This feature is partially backwards compatible with earlier versions of the
> ARM architecture. To coerce the compiler into emitting fully backwards
> compatible code the main file is compiled to target an earlier ARM version.
> This allows the tests to check for the feature and print meaningful error
> messages instead of crashing.
> 
> Add a test to verify that corrupting the return address results in a
> SIGSEGV on return.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Signed-off-by: Boyan Karatotev <boyan.karatotev@arm.com>
> ---
>  tools/testing/selftests/arm64/Makefile        |  2 +-
>  .../testing/selftests/arm64/pauth/.gitignore  |  1 +
>  tools/testing/selftests/arm64/pauth/Makefile  | 22 ++++++++++++
>  tools/testing/selftests/arm64/pauth/helper.h  | 10 ++++++
>  tools/testing/selftests/arm64/pauth/pac.c     | 32 +++++++++++++++++
>  .../selftests/arm64/pauth/pac_corruptor.S     | 36 +++++++++++++++++++
>  6 files changed, 102 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/arm64/pauth/.gitignore
>  create mode 100644 tools/testing/selftests/arm64/pauth/Makefile
>  create mode 100644 tools/testing/selftests/arm64/pauth/helper.h
>  create mode 100644 tools/testing/selftests/arm64/pauth/pac.c
>  create mode 100644 tools/testing/selftests/arm64/pauth/pac_corruptor.S
> 
> diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
> index 93b567d23c8b..525506fd97b9 100644
> --- a/tools/testing/selftests/arm64/Makefile
> +++ b/tools/testing/selftests/arm64/Makefile
> @@ -4,7 +4,7 @@
>  ARCH ?= $(shell uname -m 2>/dev/null || echo not)
>  
>  ifneq (,$(filter $(ARCH),aarch64 arm64))
> -ARM64_SUBTARGETS ?= tags signal
> +ARM64_SUBTARGETS ?= tags signal pauth
>  else
>  ARM64_SUBTARGETS :=
>  endif
> diff --git a/tools/testing/selftests/arm64/pauth/.gitignore b/tools/testing/selftests/arm64/pauth/.gitignore
> new file mode 100644
> index 000000000000..b557c916720a
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/.gitignore
> @@ -0,0 +1 @@
> +pac
> diff --git a/tools/testing/selftests/arm64/pauth/Makefile b/tools/testing/selftests/arm64/pauth/Makefile
> new file mode 100644
> index 000000000000..785c775e5e41
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/Makefile
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2020 ARM Limited
> +
> +CFLAGS += -mbranch-protection=pac-ret
> +
> +TEST_GEN_PROGS := pac
> +TEST_GEN_FILES := pac_corruptor.o
> +
> +include ../../lib.mk
> +
> +# pac* and aut* instructions are not available on architectures berfore
> +# ARMv8.3. Therefore target ARMv8.3 wherever they are used directly
> +$(OUTPUT)/pac_corruptor.o: pac_corruptor.S
> +	$(CC) -c $^ -o $@ $(CFLAGS) -march=armv8.3-a
> +
> +# when -mbranch-protection is enabled and the target architecture is ARMv8.3 or
> +# greater, gcc emits pac* instructions which are not in HINT NOP space,
> +# preventing the tests from occurring at all. Compile for ARMv8.2 so tests can
> +# run on earlier targets and print a meaningful error messages
> +$(OUTPUT)/pac: pac.c $(OUTPUT)/pac_corruptor.o
> +	$(CC) $^ -o $@ $(CFLAGS) -march=armv8.2-a
> +
> diff --git a/tools/testing/selftests/arm64/pauth/helper.h b/tools/testing/selftests/arm64/pauth/helper.h
> new file mode 100644
> index 000000000000..f777f88acf0a
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/helper.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020 ARM Limited */
> +
> +#ifndef _HELPER_H_
> +#define _HELPER_H_
> +
> +void pac_corruptor(void);
> +
> +#endif
> +
> diff --git a/tools/testing/selftests/arm64/pauth/pac.c b/tools/testing/selftests/arm64/pauth/pac.c
> new file mode 100644
> index 000000000000..ed445050f621
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/pac.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Copyright (C) 2020 ARM Limited
> +
> +#include <sys/auxv.h>
> +#include <signal.h>
> +
> +#include "../../kselftest_harness.h"
> +#include "helper.h"
> +
> +/*
> + * Tests are ARMv8.3 compliant. They make no provisions for features present in
> + * future version of the arm architecture
> + */
> +
> +#define ASSERT_PAUTH_ENABLED() \
> +do { \
> +	unsigned long hwcaps = getauxval(AT_HWCAP); \
> +	/* data key instructions are not in NOP space. This prevents a SIGILL */ \


> +	ASSERT_NE(0, hwcaps & HWCAP_PACA) TH_LOG("PAUTH not enabled"); \
> +} while (0)
> +
> +
> +/* check that a corrupted PAC results in SIGSEGV */
> +TEST_SIGNAL(corrupt_pac, SIGSEGV)
> +{
> +	ASSERT_PAUTH_ENABLED();
> +
> +	pac_corruptor();
> +}
> +
> +TEST_HARNESS_MAIN
> +
> diff --git a/tools/testing/selftests/arm64/pauth/pac_corruptor.S b/tools/testing/selftests/arm64/pauth/pac_corruptor.S
> new file mode 100644
> index 000000000000..6a34ec23a034
> --- /dev/null
> +++ b/tools/testing/selftests/arm64/pauth/pac_corruptor.S
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020 ARM Limited */
> +
> +.global pac_corruptor
> +
> +.text
> +/*
> + * Corrupting a single bit of the PAC ensures the authentication will fail.  It
> + * also guarantees no possible collision. TCR_EL1.TBI0 is set by default so no
> + * top byte PAC is tested
> + */
> + pac_corruptor:
> +	paciasp
> +
> +	/* make stack frame */
> +	sub sp, sp, #16
> +	stp x29, lr, [sp]

Nit: if respinning, you can optimise a few sequences of this sort, e.g.

	stp	x29, lr, [sp, #-16]!

> +	mov x29, sp
> +
> +	/* prepare mask for bit to be corrupted (bit 54) */
> +	mov x1, xzr
> +	add x1, x1, #1
> +	lsl x1, x1, #54

Nit:

	mov	x1, #1 << 54

but anyway, the logic operations can encode most simple bitmasks
directly as immediate operands, so you can skip this and just do

> +
> +	/* get saved lr, corrupt selected bit, put it back */
> +	ldr x0, [sp, #8]
> +	eor x0, x0, x1

	eor	x0, x0, #1 << 54

> +	str x0, [sp, #8]
> +
> +	/* remove stack frame */
> +	ldp x29, lr, [sp]
> +	add sp, sp, #16

	ldp	x29, lr, [sp], #16

[...]

Actually, since there are no leaf nested function calls and no trap is
expected until the function returns (so backtracing in the middle of
this function is unlikely to be needed), could we optimise this whole
thing down to the following?

pac_corruptor:
	paciasp
	eor	lr, lr, #1 << 53
	autiasp
	ret

Cheers
---Dave
