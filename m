Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94134ADE6A
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2019 20:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730859AbfIISLL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 9 Sep 2019 14:11:11 -0400
Received: from foss.arm.com ([217.140.110.172]:54466 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730049AbfIISLL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Sep 2019 14:11:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32E041000;
        Mon,  9 Sep 2019 11:11:11 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E53D3F71F;
        Mon,  9 Sep 2019 11:11:10 -0700 (PDT)
Subject: Re: [PATCH v5 10/11] kselftest: arm64: fake_sigreturn_bad_size
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        amit.kachhap@arm.com, andreyknvl@google.com
References: <20190902112932.36129-1-cristian.marussi@arm.com>
 <20190902112932.36129-11-cristian.marussi@arm.com>
 <20190904114933.GA27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <eadec3f3-279c-28a8-a894-c0e6082cdb14@arm.com>
Date:   Mon, 9 Sep 2019 19:11:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904114933.GA27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/09/2019 12:49, Dave Martin wrote:
> On Mon, Sep 02, 2019 at 12:29:31pm +0100, Cristian Marussi wrote:
>> Add a simple fake_sigreturn testcase which builds a ucontext_t with a
>> badly sized header that causes a overrun in the __reserved area and
>> place it onto the stack. Expects a SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>> v3 --> v4
>> - fix commit
>> - missing include
>> - using new get_starting_head() helper
>> - added test description
>> ---
>>  .../testcases/fake_sigreturn_bad_size.c       | 77 +++++++++++++++++++
>>  1 file changed, 77 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>> new file mode 100644
>> index 000000000000..b1156afdb691
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>> @@ -0,0 +1,77 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright (C) 2019 ARM Limited
>> + *
>> + * Place a fake sigframe on the stack including a bad record overflowing
>> + * the __reserved space: on sigreturn Kernel must spot this attempt and
>> + * the test case is expected to be terminated via SEGV.
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
>> +#define MIN_SZ_ALIGN	16
>> +
>> +static int fake_sigreturn_bad_size_run(struct tdescr *td,
>> +				       siginfo_t *si, ucontext_t *uc)
>> +{
>> +	size_t resv_sz, need_sz, offset;
>> +	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
>> +
>> +	/* just to fill the ucontext_t with something real */
>> +	if (!get_current_context(td, &sf.uc))
>> +		return 1;
>> +
>> +	resv_sz = GET_SF_RESV_SIZE(sf);
>> +	/* at least HDR_SZ + bad sized esr_context needed */
>> +	need_sz = HDR_SZ + sizeof(struct esr_context);
> 
> Nit: can we write this sum the other way round (see comment on patch 9)?
> 

Ok
>> +	head = get_starting_head(shead, need_sz, resv_sz, &offset);

I'll also fail straight away too here on !head (no timeout) like in others

>> +	if (head) {
>> +		/*
>> +		 * Use an esr_context to build a fake header with a
>> +		 * size greater then the free __reserved area minus HDR_SZ;
>> +		 * using ESR_MAGIC here since it is not checked for size nor
>> +		 * is limited to one instance.
>> +		 *
>> +		 * At first inject an additional normal esr_context
>> +		 */
>> +		head->magic = ESR_MAGIC;
>> +		head->size = sizeof(struct esr_context);
>> +		/* and terminate properly */
>> +		write_terminator_record(GET_RESV_NEXT_HEAD(head));
>> +		ASSERT_GOOD_CONTEXT(&sf.uc);
>> +
>> +		/*
>> +		 * now mess with fake esr_context size: leaving less space than
>> +		 * needed while keeping size value 16-aligned
>> +		 *
>> +		 * It must trigger a SEGV from Kernel on:
>> +		 *
>> +		 *	resv_sz - offset < sizeof(*head)
>> +		 */
>> +		/* at first set the maximum good 16-aligned size */
>> +		head->size =
>> +			(resv_sz - offset - need_sz + MIN_SZ_ALIGN) & ~0xfUL;
>> +		/* plus a bit more of 16-aligned sized stuff */
>> +		head->size += MIN_SZ_ALIGN;
> 
> Can we also have versions of this test that try:
> 
>  a) a size that doesn't overflow __reserved[], but is not a multiple of 16
>  b) a size that is less than 16
>  c) a size that does overflow __reserved[], but by less than 16 bytes?
> 
> These tests are all closely related and can probably be macro-ised
> easily.  They can go on the TODO list for now anyway: let's get this
> series settled in its current form first.
> 
Ok

> In any case:
> 
> Reviewed-by: Dave Martin <Dave.Martin@arm.com>
> 

Thanks

Cristian
