Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDF35EABD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2019 19:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727017AbfGCRqV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 3 Jul 2019 13:46:21 -0400
Received: from foss.arm.com ([217.140.110.172]:54184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726550AbfGCRqV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 3 Jul 2019 13:46:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E95A344;
        Wed,  3 Jul 2019 10:46:20 -0700 (PDT)
Received: from [10.1.35.169] (majettta.cambridge.arm.com [10.1.35.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 12FFD3F718;
        Wed,  3 Jul 2019 10:46:18 -0700 (PDT)
Subject: Re: [PATCH 11/13] kselftest: arm64: fake_sigreturn_bad_size
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-12-cristian.marussi@arm.com>
 <20190621103612.GS2790@e103592.cambridge.arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <ecac0d06-768a-e113-f3c4-debea97d6e1e@arm.com>
Date:   Wed, 3 Jul 2019 18:46:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190621103612.GS2790@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 6/21/19 11:36 AM, Dave Martin wrote:
> On Thu, Jun 13, 2019 at 12:13:33PM +0100, Cristian Marussi wrote:
>> Added a simple fake_sigreturn testcase which builds a ucontext_t
>> with a badly sized header and place it onto the stack.
>> Expects a SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>   .../arm64/signal/testcases/.gitignore         |  1 +
>>   .../testcases/fake_sigreturn_bad_size.c       | 40 +++++++++++++++++++
>>   2 files changed, 41 insertions(+)
>>   create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> index c353b7bd899d..9ad1735e0018 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> @@ -8,3 +8,4 @@ mangle_pstate_invalid_mode_el3
>>   mangle_pstate_ssbs_regs
>>   fake_sigreturn_misaligned
>>   fake_sigreturn_bad_magic
>> +fake_sigreturn_bad_size
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>> new file mode 100644
>> index 000000000000..d54f79d63bf6
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_size.c
>> @@ -0,0 +1,40 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#include <asm/sigcontext.h>
>> +#include <ucontext.h>
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +struct a_sigframe sf;
>> +
>> +static int fake_sigreturn_bad_size_run(struct tdescr *td,
>> +				       siginfo_t *si, ucontext_t *uc)
>> +{
>> +	struct _aarch64_ctx *head = GET_SF_RESV_HEAD(sf);
>> +
>> +	/* just to fill the ucontext_t with something real */
>> +	if (!get_current_context(td, &sf.uc))
>> +		return 1;
>> +
>> +	/* Tampering size to an unplausible number should cause a SEGV */
>> +	head = get_terminator(head, GET_SF_RESV_SIZE(sf), NULL);
>> +	if (head) {
>> +		head->magic = ESR_MAGIC;
> 
> Add a comment to say why we're using this magic?
> 
>> +		head->size = GET_SF_RESV_SIZE(sf) * 2;
> 
> If we have extra_context, this might not be an invalid size, because
> extra_context can be much larger than sizeof(__reserved) ... but also
> we will overrun anyway, because extra_context should already be only
> just large enough to accommodate the original terminator.
> 
> As with the previous test, we should probably throw away the
> extra_context record (if any) and replace it with this new record.
> 
> We should check the actual boundary condition here, rather than just
> testing with a giant size: we want to make the kernel detects any
> overrun, however small.
> 
> We should also write a valid terminator after the new record, so
> that we know the kernel is detecting the size overrun instead of
> rejecting the next record because it is garbage.
> 

Fixed in V2: throwing away the extra when needed, and adding a bogus 
ESR_MAGIC with a bogus size, large enough to fit all the remaining free 
__reserved (- NULL terminator space)  + 16 bytes (to be still aligned 
and crashing out on an overrun of the least minimum size) and terminated 
with another NULL

Cristian

>> +
>> +		ASSERT_BAD_CONTEXT(&sf.uc);
>> +		fake_sigreturn(&sf, sizeof(sf), 16);
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
