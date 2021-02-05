Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DF36310A01
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Feb 2021 12:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbhBELLv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 5 Feb 2021 06:11:51 -0500
Received: from foss.arm.com ([217.140.110.172]:55996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230073AbhBELJp (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 5 Feb 2021 06:09:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 85037D6E;
        Fri,  5 Feb 2021 03:08:59 -0800 (PST)
Received: from [10.37.8.15] (unknown [10.37.8.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 54CB33F73B;
        Fri,  5 Feb 2021 03:08:58 -0800 (PST)
Subject: Re: [PATCH] selftests/vDSO: fix ABI selftest on riscv
To:     Palmer Dabbelt <palmer@dabbelt.com>, tklauser@distanz.ch,
        shuah@kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <mhng-1ed0f9e8-84ec-4f2e-ac42-5a608726e2fe@palmerdabbelt-glaptop>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <019fcafc-09b5-a13c-a83f-d6a0b1eb3224@arm.com>
Date:   Fri, 5 Feb 2021 11:12:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <mhng-1ed0f9e8-84ec-4f2e-ac42-5a608726e2fe@palmerdabbelt-glaptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 2/5/21 7:06 AM, Palmer Dabbelt wrote:
> On Thu, 04 Feb 2021 06:50:42 PST (-0800), tklauser@distanz.ch wrote:
>> Only older versions of the RISC-V GCC toolchain define __riscv__. Check
>> for __riscv as well, which is used by newer GCC toolchains. Also set
>> VDSO_32BIT based on __riscv_xlen.
>>
>> Before (on riscv64):
>>
>> $ ./vdso_test_abi
>> [vDSO kselftest] VDSO_VERSION: LINUX_4
>> Could not find __vdso_gettimeofday
>> Could not find __vdso_clock_gettime
>> Could not find __vdso_clock_getres
>> clock_id: CLOCK_REALTIME [PASS]
>> Could not find __vdso_clock_gettime
>> Could not find __vdso_clock_getres
>> clock_id: CLOCK_BOOTTIME [PASS]
>> Could not find __vdso_clock_gettime
>> Could not find __vdso_clock_getres
>> clock_id: CLOCK_TAI [PASS]
>> Could not find __vdso_clock_gettime
>> Could not find __vdso_clock_getres
>> clock_id: CLOCK_REALTIME_COARSE [PASS]
>> Could not find __vdso_clock_gettime
>> Could not find __vdso_clock_getres
>> clock_id: CLOCK_MONOTONIC [PASS]
>> Could not find __vdso_clock_gettime
>> Could not find __vdso_clock_getres
>> clock_id: CLOCK_MONOTONIC_RAW [PASS]
>> Could not find __vdso_clock_gettime
>> Could not find __vdso_clock_getres
>> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>> Could not find __vdso_time
>>
>> After (on riscv32):
>>
>> $ ./vdso_test_abi
>> [vDSO kselftest] VDSO_VERSION: LINUX_4.15
>> The time is 1612449376.015086
>> The time is 1612449376.18340784
>> The resolution is 0 1
>> clock_id: CLOCK_REALTIME [PASS]
>> The time is 774.842586182
>> The resolution is 0 1
>> clock_id: CLOCK_BOOTTIME [PASS]
>> The time is 1612449376.22536565
>> The resolution is 0 1
>> clock_id: CLOCK_TAI [PASS]
>> The time is 1612449376.20885172
>> The resolution is 0 4000000
>> clock_id: CLOCK_REALTIME_COARSE [PASS]
>> The time is 774.845491269
>> The resolution is 0 1
>> clock_id: CLOCK_MONOTONIC [PASS]
>> The time is 774.849534200
>> The resolution is 0 1
>> clock_id: CLOCK_MONOTONIC_RAW [PASS]
>> The time is 774.842139684
>> The resolution is 0 4000000
>> clock_id: CLOCK_MONOTONIC_COARSE [PASS]
>> Could not find __vdso_time
>>
>> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
>> ---
>>  tools/testing/selftests/vDSO/vdso_config.h | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/vDSO/vdso_config.h
>> b/tools/testing/selftests/vDSO/vdso_config.h
>> index 6a6fe8d4ff55..6188b16827d1 100644
>> --- a/tools/testing/selftests/vDSO/vdso_config.h
>> +++ b/tools/testing/selftests/vDSO/vdso_config.h
>> @@ -47,10 +47,12 @@
>>  #elif defined(__x86_64__)
>>  #define VDSO_VERSION        0
>>  #define VDSO_NAMES        1
>> -#elif defined(__riscv__)
>> +#elif defined(__riscv__) || defined(__riscv)
>>  #define VDSO_VERSION        5
>>  #define VDSO_NAMES        1
>> +#if __riscv_xlen == 32
>>  #define VDSO_32BIT        1
>> +#endif
>>  #else /* nds32 */
>>  #define VDSO_VERSION        4
>>  #define VDSO_NAMES        1
> 
> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
>

Acked-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> Not sure if you want this through the RISC-V tree, so I'm leaving it out for
> now and assuming it'll go through a kselftest tree.
> 
> Thanks!

-- 
Regards,
Vincenzo
