Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6FB85EAE4
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 19:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCRvv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 13:51:51 -0400
Received: from foss.arm.com ([217.140.110.172]:54344 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCRvu (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 13:51:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 42A1D344;
        Wed,  3 Jul 2019 10:51:50 -0700 (PDT)
Received: from [10.1.35.169] (majettta.cambridge.arm.com [10.1.35.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 871D53F718;
        Wed,  3 Jul 2019 10:51:49 -0700 (PDT)
Subject: Re: [PATCH 13/13] kselftest: arm64: fake_sigreturn_overflow_reserved
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-14-cristian.marussi@arm.com>
 <20190621103623.GU2790@e103592.cambridge.arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <8f0e0026-43ab-5907-d599-d1c48acccf97@arm.com>
Date:   Wed, 3 Jul 2019 18:51:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190621103623.GU2790@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 6/21/19 11:36 AM, Dave Martin wrote:
> On Thu, Jun 13, 2019 at 12:13:35PM +0100, Cristian Marussi wrote:
>> Added a simple fake_sigreturn testcase which builds a ucontext_t
>> with the whole __reserved area overflowed with ESR_MAGIC headers
>> and place it onto the stack.
>> Expects a SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>   .../arm64/signal/testcases/.gitignore         |  1 +
>>   .../fake_sigreturn_overflow_reserved.c        | 48 +++++++++++++++++++
>>   2 files changed, 49 insertions(+)
>>   create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> index 66ba865b3b7e..69a18391c220 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> @@ -10,3 +10,4 @@ fake_sigreturn_misaligned
>>   fake_sigreturn_bad_magic
>>   fake_sigreturn_bad_size
>>   fake_sigreturn_bad_size_for_magic0
>> +fake_sigreturn_overflow_reserved
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c
>> new file mode 100644
>> index 000000000000..eba109453a65
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_overflow_reserved.c
>> @@ -0,0 +1,48 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#include <asm/sigcontext.h>
>> +#include <ucontext.h>
>> +#include <stdio.h>
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +struct a_sigframe sf;
>> +
>> +static int fake_sigreturn_overflow_reserved_run(struct tdescr *td,
>> +						siginfo_t *si,
>> +						ucontext_t *uc)
>> +{
>> +	size_t offset = 0;
>> +	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
>> +
>> +	/* just to fill the ucontext_t with something real */
>> +	if (!get_current_context(td, &sf.uc))
>> +		return 1;
>> +
>> +	/* find the terminator, preserving existig headers */
>> +	head = get_terminator(head, GET_SF_RESV_SIZE(sf), &offset);
>> +	if (head) {
>> +		/* fill the __reserved area till the end */
>> +		do {
>> +			head->magic = ESR_MAGIC;
> 
> Comment on why this magic is chosen.
> 
> Since it is useful for test purposes to have a record that the kernel
> ignores completely, it might be worth dropping in comment in
> parse_user_sigframe() so that we don't add stricter checks by accident.
> 
> We could alternatively add a special-purpose dummy record with its own
> magic.  This might be better than abusing esr_context ... but I could be
> persuaded either way.
> 
>> +			head->size = sizeof(struct esr_context);
> 
> Can we end up with a hole at the end of the frame that is smaller than
> esr_context and so can't be filled properly?  If not, why not?
> 
>> +			offset += head->size;
>> +			head = GET_RESV_NEXT_HEAD(head);
>> +		} while (offset < GET_SF_RESV_SIZE(sf));
>> +
>> +		ASSERT_BAD_CONTEXT(&sf.uc);
>> +		fake_sigreturn(&sf, sizeof(sf), 16);
> 
> We should have something that looks like a valid terminator after the
> end of the signal frame, so that we can be sure the overrun is
> detected, rather than the kernel just rejecting the garbage after the
> last record.
>

This testcase issues still to be addressed. Disabled in V2...want to 
re-enable in V3.

Cristian

>> +	}
>> +
>> +	return 1;
>> +}
> 
> [...]
> 
> Cheers
> ---Dave
> 
