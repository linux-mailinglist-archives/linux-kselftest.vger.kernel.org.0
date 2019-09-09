Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 170B4ADE54
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2019 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391435AbfIISDR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Sep 2019 14:03:17 -0400
Received: from foss.arm.com ([217.140.110.172]:54376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391382AbfIISDR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Sep 2019 14:03:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 455B31000;
        Mon,  9 Sep 2019 11:03:16 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 472953F71F;
        Mon,  9 Sep 2019 11:03:13 -0700 (PDT)
Subject: Re: [PATCH v5 09/11] kselftest: arm64:
 fake_sigreturn_duplicated_fpsimd
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-10-cristian.marussi@arm.com>
 <20190904114923.GZ27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <ecae359f-777f-7ddd-b9ec-3827ecf17d58@arm.com>
Date:   Mon, 9 Sep 2019 19:03:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904114923.GZ27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/09/2019 12:49, Dave Martin wrote:
> On Mon, Sep 02, 2019 at 12:29:30pm +0100, Cristian Marussi wrote:
>> Add a simple fake_sigreturn testcase which builds a ucontext_t with
>> an anomalous additional fpsimd_context and place it onto the stack.
>> Expects a SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v3 --> v4
>> - fix commit
>> - missing include
>> - using new get_starting_head() helper
>> - added test description
>> ---
>>  .../fake_sigreturn_duplicated_fpsimd.c        | 52 +++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
>> new file mode 100644
>> index 000000000000..c7122c44f53f
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
>> @@ -0,0 +1,52 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 ARM Limited
>> + *
>> + * Place a fake sigframe on the stack including an additional FPSIMD
>> + * record: on sigreturn Kernel must spot this attempt and the test
>> + * case is expected to be terminated via SEGV.
>> + */
>> +
>> +#include <signal.h>
>> +#include <ucontext.h>
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +struct fake_sigframe sf;
>> +
>> +static int fake_sigreturn_duplicated_fpsimd_run(struct tdescr *td,
>> +						siginfo_t *si, ucontext_t *uc)
>> +{
>> +	size_t resv_sz, need_sz;
>> +	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
>> +
>> +	/* just to fill the ucontext_t with something real */
>> +	if (!get_current_context(td, &sf.uc))
>> +		return 1;
>> +
>> +	resv_sz = GET_SF_RESV_SIZE(sf);
>> +	need_sz = HDR_SZ + sizeof(struct fpsimd_context);
> 
> Nit: Maybe write this sum in the same order as the records we're going 
> o append, i.e.:
> 
> 	need_sz = sizeof(struct fpsimd_context) + HDR_SZ; /* for terminator */
> 

Ok
> Also, maybe fail this test if there is no fpsimd_context in the initial
> frame from get_current_context(): that would be a kernel bug, but we
> wouldn't be giving fake_sigreturn() duplicate fpsimd_contexts in that
> case -- so this test wouldn't test the thing it's supposed to test.
> 

I've reviewed  ASSERT_BAD/GOOD_CONTEXT() macros in this series to use abort()
instead of assert(): this means any frame get with get_current_context() will
be checked to be GOOD before the test starts.

>> +
>> +	head = get_starting_head(shead, need_sz, resv_sz, NULL);
>> +	if (head) {
>> +		/* Add a spurios fpsimd_context */
>> +		head->magic = FPSIMD_MAGIC;
>> +		head->size = sizeof(struct fpsimd_context);
>> +		/* and terminate */
>> +		write_terminator_record(GET_RESV_NEXT_HEAD(head));
>> +
>> +		ASSERT_BAD_CONTEXT(&sf.uc);
>> +		fake_sigreturn(&sf, sizeof(sf), 0);
>> +	}
>> +
>> +	return 1;
> 

Here I'll avoid the timeout on !head and exit straight away (like in other fake_ tests)
> [...]
> 
> Cheers
> ---Dave
> 

Cheers

Cristian


