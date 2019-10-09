Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6441D08D3
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Oct 2019 09:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbfJIHwE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 9 Oct 2019 03:52:04 -0400
Received: from foss.arm.com ([217.140.110.172]:55204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbfJIHwE (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 9 Oct 2019 03:52:04 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F6BC337;
        Wed,  9 Oct 2019 00:52:03 -0700 (PDT)
Received: from [10.37.8.60] (unknown [10.37.8.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7C8893F68E;
        Wed,  9 Oct 2019 00:52:02 -0700 (PDT)
Subject: Re: [PATCH v7 05/11] kselftest: arm64: mangle_pstate_ssbs_regs
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20191007182954.25730-1-cristian.marussi@arm.com>
 <20191007182954.25730-6-cristian.marussi@arm.com>
 <20191008180112.GY27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <13183627-4451-f6ee-35b0-2c12108de579@arm.com>
Date:   Wed, 9 Oct 2019 08:52:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191008180112.GY27757@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 10/8/19 7:01 PM, Dave Martin wrote:
> On Mon, Oct 07, 2019 at 07:29:48pm +0100, Cristian Marussi wrote:
>> Add a simple mangle testcase which messes with the ucontext_t from within
>> the signal handler, trying to set the PSTATE SSBS bit and verify that
>> SSBS bit set is preserved across sigreturn.
>> Lookup PSTATE.SSBS directly using dedicated helper to grab PSTATE from a
>> live sigframe.
>>
>> Additionally, in order to support this test specific needs:
>> - extend signal testing framework to allow the definition of a custom
>>    per test initialization function to be run at the end of test setup
>>    and before test run routine. This will support also test SKIP.
>> - introduce also a new common utility function: get_current_context()
>>    which can be used to grab a ucontext without the help of libc, and
>>    detect if such ucontext has been actively used to jump back.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v6 --> v7
>> - fixed missing header for memcpy
>> - fixed misleading comment in get_current_context()
>> - fixed retvalue checks on get_current_context() invocation
>> - extend test_init()/test_result() and .init to report KSFT_SKIP
>> - SKIP mangle_pstate_ssbs_regs if SSBS not supported at all
>> - check SSBS support looking up ID_AA64PFR1_EL1.SSBS in test_init()
>>    instead of using MRS/MSR
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals.c b/tools/testing/selftests/arm64/signal/test_signals.c
>> index cb970346b280..416b1ff43199 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals.c
>> +++ b/tools/testing/selftests/arm64/signal/test_signals.c
>> @@ -19,11 +19,11 @@ int main(int argc, char *argv[])
>>   	current = &tde;
>>   
>>   	ksft_print_msg("%s :: %s\n", current->name, current->descr);
>> -	if (test_setup(current)) {
>> +	if (test_setup(current) && test_init(current)) {
>>   		test_run(current);
>> -		test_result(current);
>>   		test_cleanup(current);
>>   	}
>> +	test_result(current);
>>   
>> -	return current->pass ? KSFT_PASS : KSFT_FAIL;
>> +	return current->result;
>>   }
>> diff --git a/tools/testing/selftests/arm64/signal/test_signals.h b/tools/testing/selftests/arm64/signal/test_signals.h
>> index f712b5daa10b..ad8175806034 100644
>> --- a/tools/testing/selftests/arm64/signal/test_signals.h
>> +++ b/tools/testing/selftests/arm64/signal/test_signals.h
>> @@ -27,13 +27,25 @@
>>   	: "memory");					\
>>   }
>>   
>> +#define set_regval(regname, in)				\
>> +{							\
>> +	asm volatile("msr " __stringify(regname) ", %0" \
>> +	:						\
>> +	: "r" (in)					\
>> +	: "memory");					\
>> +}
> 
> Unused macro?  Now that the test doesn't try to change the SSBS state
> via MSR, I don't think anything else is using this.
> 
> [...]
> 

Removing that in V8 (I left it on purpose since it's general and maybe could
have been used again for other tests...but now is effectively unused)

>> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
>> new file mode 100644
>> index 000000000000..780161dbd7c0
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_ssbs_regs.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 ARM Limited
>> + *
>> + * Try to mangle the ucontext from inside a signal handler, setting the
>> + * SSBS bit to 1 and veryfing that such modification is preserved.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <stdlib.h>
>> +#include <signal.h>
>> +#include <ucontext.h>
>> +
>> +#include <kselftest.h>
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +static bool mangle_invalid_pstate_ssbs_init(struct tdescr *td)
>> +{
>> +	bool ret;
>> +
>> +	ret = feats_ok(td);
>> +	if (!ret) {
>> +		fprintf(stderr, "%s: unsupported feature - SKIP.\n", td->name);
>> +		td->result = KSFT_SKIP;
>> +	}
>> +
>> +	return ret;
>> +}
>> +
>> +static int mangle_invalid_pstate_ssbs_run(struct tdescr *td,
>> +					  siginfo_t *si, ucontext_t *uc)
>> +{
>> +	ASSERT_GOOD_CONTEXT(uc);
>> +
>> +	/* set bit value ... should NOT be cleared by Kernel on sigreturn */
>> +	uc->uc_mcontext.pstate |= PSR_SSBS_BIT;
>> +	fprintf(stderr, "SSBS set to 1 -- PSTATE: 0x%016llX\n",
>> +		uc->uc_mcontext.pstate);
>> +	/* Save after mangling...it should be preserved */
>> +	td->saved_uc = *uc;
> 
> Hmmm, now I'm wondering about how things like
> prctl(PR_SET_SPECULATION_CTRL) are supposed to interact with other ways
> of manipulating PSTATE.SSBS.  Before we've answered this, we don't know
> what result to expect from this test in various configurations...
> 
> To avoid this series depending on answering that question immediately,
> can we drop this test from the series for now?
> 
> To reduce rework effort, maybe keep this patch in its current position
> in the series, with just the utility code, but drop the testcase.

Ok, but I'll split the remnants of this patch in two distinct patches:
one containing the get_current_context() and the other containing some test
initialization improvements that was also part of this patch.

Thanks

Cristian
  
> 
> Sorry for the churn -- I didn't think of this issue earlier :(
> 
> [...]
> 
> Cheers
> ---Dave
> 
