Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64751A3A35
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbfH3PVc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 11:21:32 -0400
Received: from foss.arm.com ([217.140.110.172]:33870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3PVc (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 11:21:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 81BA0344;
        Fri, 30 Aug 2019 08:21:31 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD0E43F703;
        Fri, 30 Aug 2019 08:21:30 -0700 (PDT)
Subject: Re: [PATCH v3 10/11] kselftest: arm64: fake_sigreturn_bad_size
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-11-cristian.marussi@arm.com>
 <20190813162646.GH10425@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <599bc78e-718d-0475-0ab0-79e1277e55ab@arm.com>
Date:   Fri, 30 Aug 2019 16:21:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813162646.GH10425@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/08/2019 17:26, Dave Martin wrote:
> On Fri, Aug 02, 2019 at 06:02:59PM +0100, Cristian Marussi wrote:
>> Added a simple fake_sigreturn testcase which builds a ucontext_t
> 
> Add

Ok

> 
>> with a badly sized header that causes a overrun in the __reserved
>> area and place it onto the stack. Expects a SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>  .../arm64/signal/testcases/.gitignore         |  1 +
>>  .../testcases/fake_sigreturn_bad_size.c       | 85 +++++++++++++++++++
>>  2 files changed, 86 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> index 94f9baaf638c..3408e0f5ba98 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> @@ -8,3 +8,4 @@ fake_sigreturn_bad_magic
>>  fake_sigreturn_bad_size_for_magic0
>>  fake_sigreturn_missing_fpsimd
>>  fake_sigreturn_duplicated_fpsimd
>> +fake_sigreturn_bad_size
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>> new file mode 100644
>> index 000000000000..1467fb534d8b
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>> @@ -0,0 +1,85 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
> 
> signal.h?
> 
Ok
>> +#include <stdio.h>
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
>> +	/*
>> +	 * find the terminator, preserving existing headers
>> +	 * and verify amount of spare room in __reserved area.
>> +	 */
>> +	head = get_terminator(shead, resv_sz, &offset);
>> +	/*
>> +	 * try stripping extra_context header when low on space:
>> +	 * we need at least  for the bad sized esr_context.
> 
> double space
> 
ok.
>> +	 */
>> +	need_sz = HDR_SZ + sizeof(struct esr_context);
>> +	if (head && resv_sz - offset < need_sz) {
>> +		fprintf(stderr, "Low on space:%zd. Discarding extra_context.\n",
>> +			resv_sz - offset);
>> +		head = get_header(shead, EXTRA_MAGIC, resv_sz, &offset);
>> +	}
>> +	/* just give up and timeout if still not enough space */
>> +	if (head && resv_sz - offset >= need_sz) {
>> +		fprintf(stderr, "Mangling template header. Spare space:%zd\n",
>> +			resv_sz - offset);
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
>> +		 * neededwhile keeping size value 16-aligned
>> +		 *
>> +		 * It must trigger a SEGV from Kernel on:
>> +		 *
>> +		 *	resv_sz - offset < sizeof(*head)
>> +		 */
>> +		/* at first set the maximum good 16-aligned size */
>> +		head->size = (resv_sz - offset - need_sz + MIN_SZ_ALIGN) & ~0xfUL;
>> +		/* plus a bit more of 16-aligned sized stuff */
>> +		head->size += MIN_SZ_ALIGN;
>> +		/* and terminate properly */
>> +		write_terminator_record(GET_RESV_NEXT_HEAD(head));
>> +		ASSERT_BAD_CONTEXT(&sf.uc);
>> +		fake_sigreturn(&sf, sizeof(sf), 16);
>> +	}
>> +
>> +	return 1;
>> +}
> 

I'll convert to use new helper get_starting_head() to make space in __reserved.

> [...]
> 
> Otherwise looks reasonable.
> 
> Cheers
> ---Dave

Cheers

Cristian
> 

