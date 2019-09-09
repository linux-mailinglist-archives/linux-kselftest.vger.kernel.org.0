Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C1BADE3F
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2019 19:51:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730568AbfIIRvY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Sep 2019 13:51:24 -0400
Received: from foss.arm.com ([217.140.110.172]:54222 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbfIIRvY (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Sep 2019 13:51:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D95BD1000;
        Mon,  9 Sep 2019 10:51:23 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EE7173F71F;
        Mon,  9 Sep 2019 10:51:22 -0700 (PDT)
Subject: Re: [PATCH v5 08/11] kselftest: arm64: fake_sigreturn_missing_fpsimd
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-9-cristian.marussi@arm.com>
 <20190904114910.GY27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <8cabc8ff-fe9f-f476-a58b-0bf0fb71c499@arm.com>
Date:   Mon, 9 Sep 2019 18:51:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904114910.GY27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/09/2019 12:49, Dave Martin wrote:
> On Mon, Sep 02, 2019 at 12:29:29pm +0100, Cristian Marussi wrote:
>> Add a simple fake_sigreturn testcase which builds a ucontext_t without
>> the required fpsimd_context and place it onto the stack.
>> Expects a SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v3 --> v4
>> - fix commit
>> - added signal.h
>> - added test description
>> ---
>>  .../testcases/fake_sigreturn_missing_fpsimd.c | 50 +++++++++++++++++++
>>  1 file changed, 50 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c
>> new file mode 100644
>> index 000000000000..08ecd8073a1a
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_missing_fpsimd.c
>> @@ -0,0 +1,50 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 ARM Limited
>> + *
>> + * Place a fake sigframe on the stack missing the mandatory FPSIMD
>> + * record: on sigreturn Kernel must spot this attempt and the test
>> + * case is expected to be terminated via SEGV.
>> + */
>> +
>> +#include <stdio.h>
>> +#include <signal.h>
>> +#include <ucontext.h>
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +struct fake_sigframe sf;
>> +
>> +static int fake_sigreturn_missing_fpsimd_run(struct tdescr *td,
>> +					     siginfo_t *si, ucontext_t *uc)
>> +{
>> +	size_t resv_sz, offset;
>> +	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
>> +
>> +	/* just to fill the ucontext_t with something real */
>> +	if (!get_current_context(td, &sf.uc))
>> +		return 1;
>> +
>> +	resv_sz = GET_SF_RESV_SIZE(sf);
>> +	head = get_header(head, FPSIMD_MAGIC, resv_sz, &offset);
>> +	if (head && resv_sz - offset >= HDR_SZ) {
>> +		fprintf(stderr, "Mangling template header. Spare space:%zd\n",
>> +			resv_sz - offset);
>> +		/* Just overwrite fpsmid_context */
>> +		write_terminator_record(head);
> 
> Strictly speaking, we may be throwing away more than just the
> fpsimd_context record here.
> 
> But I think the test works nonetheless.  fpsimd_context is the only
> record that's mandatory in any case.

Ok
> 
>> +
>> +		ASSERT_BAD_CONTEXT(&sf.uc);
>> +		fake_sigreturn(&sf, sizeof(sf), 0);
>> +	}
>> +
>> +	return 1;
>> +}
>> +
>> +struct tdescr tde = {
>> +		.name = "FAKE_SIGRETURN_MISSING_FPSIMD",
>> +		.descr = "Triggers a sigreturn with a missing fpsimd_context",
>> +		.sig_ok = SIGSEGV,
>> +		.timeout = 3,
>> +		.run = fake_sigreturn_missing_fpsimd_run,
>> +};
> 
> Assuming the comment I just posted on v3 of this patch makes sense to you,
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 
Thanks

Cheers

Cristian

