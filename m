Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7DFE25511
	for <lists+linux-kselftest@lfdr.de>; Tue, 21 May 2019 18:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbfEUQL4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 21 May 2019 12:11:56 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:38088 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727932AbfEUQL4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 21 May 2019 12:11:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 54C71374;
        Tue, 21 May 2019 09:11:55 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A65E63F718;
        Tue, 21 May 2019 09:11:54 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] kselftest: Extend vDSO selftest to clock_getres
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-6-vincenzo.frascino@arm.com>
Message-ID: <f07e07b0-4e53-96c8-ebe2-a0f5528fa329@arm.com>
Date:   Tue, 21 May 2019 17:11:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416161434.32691-6-vincenzo.frascino@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Shuah,

I did not see this patch in 5.2-rc1 and I was wondering if there is anything I
can do to help with upstraming it.

Please let me know.

Thanks,
Vincenzo

On 16/04/2019 17:14, Vincenzo Frascino wrote:
> The current version of the multiarch vDSO selftest verifies only
> gettimeofday.
> 
> Extend the vDSO selftest to clock_getres, to verify that the
> syscall and the vDSO library function return the same information.
> 
> The extension has been used to verify the hrtimer_resoltion fix.
> 
> Cc: Shuah Khan <shuah@kernel.org>
> Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> ---
>  tools/testing/selftests/vDSO/Makefile         |   2 +
>  .../selftests/vDSO/vdso_clock_getres.c        | 108 ++++++++++++++++++
>  2 files changed, 110 insertions(+)
>  create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c
> 
> diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
> index 9e03d61f52fd..d5c5bfdf1ac1 100644
> --- a/tools/testing/selftests/vDSO/Makefile
> +++ b/tools/testing/selftests/vDSO/Makefile
> @@ -5,6 +5,7 @@ uname_M := $(shell uname -m 2>/dev/null || echo not)
>  ARCH ?= $(shell echo $(uname_M) | sed -e s/i.86/x86/ -e s/x86_64/x86/)
>  
>  TEST_GEN_PROGS := $(OUTPUT)/vdso_test
> +TEST_GEN_PROGS += $(OUTPUT)/vdso_clock_getres
>  ifeq ($(ARCH),x86)
>  TEST_GEN_PROGS += $(OUTPUT)/vdso_standalone_test_x86
>  endif
> @@ -18,6 +19,7 @@ endif
>  
>  all: $(TEST_GEN_PROGS)
>  $(OUTPUT)/vdso_test: parse_vdso.c vdso_test.c
> +$(OUTPUT)/vdso_clock_getres: vdso_clock_getres.c
>  $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
>  	$(CC) $(CFLAGS) $(CFLAGS_vdso_standalone_test_x86) \
>  		vdso_standalone_test_x86.c parse_vdso.c \
> diff --git a/tools/testing/selftests/vDSO/vdso_clock_getres.c b/tools/testing/selftests/vDSO/vdso_clock_getres.c
> new file mode 100644
> index 000000000000..b1b9652972eb
> --- /dev/null
> +++ b/tools/testing/selftests/vDSO/vdso_clock_getres.c
> @@ -0,0 +1,108 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * vdso_clock_getres.c: Sample code to test clock_getres.
> + * Copyright (c) 2019 Arm Ltd.
> + *
> + * Compile with:
> + * gcc -std=gnu99 vdso_clock_getres.c
> + *
> + * Tested on ARM, ARM64, MIPS32, x86 (32-bit and 64-bit),
> + * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
> + * Might work on other architectures.
> + */
> +
> +#define _GNU_SOURCE
> +#include <elf.h>
> +#include <err.h>
> +#include <fcntl.h>
> +#include <stdint.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <sys/auxv.h>
> +#include <sys/mman.h>
> +#include <sys/time.h>
> +#include <unistd.h>
> +#include <sys/syscall.h>
> +
> +#include "../kselftest.h"
> +
> +static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
> +{
> +	long ret;
> +
> +	ret = syscall(SYS_clock_getres, _clkid, _ts);
> +
> +	return ret;
> +}
> +
> +const char *vdso_clock_name[12] = {
> +	"CLOCK_REALTIME",
> +	"CLOCK_MONOTONIC",
> +	"CLOCK_PROCESS_CPUTIME_ID",
> +	"CLOCK_THREAD_CPUTIME_ID",
> +	"CLOCK_MONOTONIC_RAW",
> +	"CLOCK_REALTIME_COARSE",
> +	"CLOCK_MONOTONIC_COARSE",
> +	"CLOCK_BOOTTIME",
> +	"CLOCK_REALTIME_ALARM",
> +	"CLOCK_BOOTTIME_ALARM",
> +	"CLOCK_SGI_CYCLE",
> +	"CLOCK_TAI",
> +};
> +
> +/*
> + * Macro to call clock_getres in vdso and by system call
> + * with different values for clock_id.
> + */
> +#define vdso_test_clock(clock_id)				\
> +do {								\
> +	struct timespec x, y;					\
> +	printf("clock_id: %s", vdso_clock_name[clock_id]);	\
> +	clock_getres(clock_id, &x);				\
> +	syscall_clock_getres(clock_id, &y);			\
> +	if ((x.tv_sec != y.tv_sec) || (x.tv_sec != y.tv_sec)) {	\
> +		printf(" [FAIL]\n");				\
> +		return KSFT_SKIP;				\
> +	} else {						\
> +		printf(" [PASS]\n");				\
> +	}							\
> +} while (0)
> +
> +int main(int argc, char **argv)
> +{
> +
> +#if _POSIX_TIMERS > 0
> +
> +#ifdef CLOCK_REALTIME
> +	vdso_test_clock(CLOCK_REALTIME);
> +#endif
> +
> +#ifdef CLOCK_BOOTTIME
> +	vdso_test_clock(CLOCK_BOOTTIME);
> +#endif
> +
> +#ifdef CLOCK_TAI
> +	vdso_test_clock(CLOCK_TAI);
> +#endif
> +
> +#ifdef CLOCK_REALTIME_COARSE
> +	vdso_test_clock(CLOCK_REALTIME_COARSE);
> +#endif
> +
> +#ifdef CLOCK_MONOTONIC
> +	vdso_test_clock(CLOCK_MONOTONIC);
> +#endif
> +
> +#ifdef CLOCK_MONOTONIC_RAW
> +	vdso_test_clock(CLOCK_MONOTONIC_RAW);
> +#endif
> +
> +#ifdef CLOCK_MONOTONIC_COARSE
> +	vdso_test_clock(CLOCK_MONOTONIC_COARSE);
> +#endif
> +
> +#endif
> +
> +	return 0;
> +}
> 

-- 
Regards,
Vincenzo
