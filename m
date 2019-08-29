Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4CA195C
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 13:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727182AbfH2LuJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 07:50:09 -0400
Received: from foss.arm.com ([217.140.110.172]:44068 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727073AbfH2LuI (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 07:50:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5885360;
        Thu, 29 Aug 2019 04:50:07 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 366CC3F59C;
        Thu, 29 Aug 2019 04:50:07 -0700 (PDT)
Subject: Re: [PATCH v3 04/11] kselftest: arm64: mangle_pstate_invalid_mode_el
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-5-cristian.marussi@arm.com>
 <20190813162451.GB10425@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <91b30d04-e044-6b15-9435-0c1351e2af85@arm.com>
Date:   Thu, 29 Aug 2019 12:50:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813162451.GB10425@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/08/2019 17:24, Dave Martin wrote:
> On Fri, Aug 02, 2019 at 06:02:53PM +0100, Cristian Marussi wrote:
>> Added 3 simple mangle testcases that mess with the ucontext_t
> 
> Add
> 
>> from within the sig_handler, trying to toggle PSTATE mode bits to
> 
> signal handler
> 
>> trick the system into switching to EL1/EL2/EL3. Expects SIGSEGV
>> on test PASS.

Ok
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>  .../arm64/signal/testcases/.gitignore         |  3 ++
>>  .../mangle_pstate_invalid_mode_el1.c          | 29 +++++++++++++++++++
>>  .../mangle_pstate_invalid_mode_el2.c          | 29 +++++++++++++++++++
>>  .../mangle_pstate_invalid_mode_el3.c          | 29 +++++++++++++++++++
>>  4 files changed, 90 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el2.c
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el3.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> index 8a0a29f0cc2a..226bb179b673 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> @@ -1,2 +1,5 @@
>>  mangle_pstate_invalid_compat_toggle
>>  mangle_pstate_invalid_daif_bits
>> +mangle_pstate_invalid_mode_el1
>> +mangle_pstate_invalid_mode_el2
>> +mangle_pstate_invalid_mode_el3
> 
> What about having
> 
> 	!*.[ch]
> 	mangle_*
> 
> rather than having to update .gitignore to list every test executable?
> 
Yes it reduces inter-dependencies between testcases patches in fact,
and in fact I already know all the possible name patterns on this set of tests:
mangle_ fake_sigreturn_


>> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
>> new file mode 100644
>> index 000000000000..07aed7624383
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_mode_el1.c
>> @@ -0,0 +1,29 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +static int mangle_invalid_pstate_run(struct tdescr *td, siginfo_t *si,
>> +				     ucontext_t *uc)
>> +{
>> +	ASSERT_GOOD_CONTEXT(uc);
>> +
>> +	/*
>> +	 * This config should trigger a SIGSEGV by Kernel
>> +	 * when checking valid_user_regs()
>> +	 */
>> +	uc->uc_mcontext.pstate &= ~PSR_MODE_MASK;
>> +	uc->uc_mcontext.pstate |= PSR_MODE_EL1t;
>> +
>> +	return 1;
>> +}
>> +
>> +struct tdescr tde = {
>> +		.sanity_disabled = true,
>> +		.name = "MANGLE_PSTATE_INVALID_MODE_EL1t",
>> +		.descr = "Mangling uc_mcontext with INVALID MODE EL1t",
>> +		.sig_trig = SIGUSR1,
>> +		.sig_ok = SIGSEGV,
>> +		.run = mangle_invalid_pstate_run,
>> +};
> 
> These tests seem identical except for the EL number.
> Can we macro-ise them?
> 
> mangle_pstate_invalid_mode_el1.c could become
> 
> --8<--
> 
> #include "mangle_pstate_invalid_mode.h"
> 
> DEFINE_TESTCASE_MANGLE_PSTATE_INVALID_MODE(1)
> 
> -->8--
Yes I'll do, and I'll split these 3 testcases in 6 macro-ized test cases to cover
all EL_x h/t variants (something you already told me in V2 I think)

Cheers

Cristian
> 
> (for example).
> 
> [...]
> 
> Cheers
> ---Dave
> 

