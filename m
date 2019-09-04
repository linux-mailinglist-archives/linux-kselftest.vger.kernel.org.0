Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 059DBA806E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Sep 2019 12:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbfIDKhl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Sep 2019 06:37:41 -0400
Received: from foss.arm.com ([217.140.110.172]:51514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726304AbfIDKhl (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Sep 2019 06:37:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA54A337;
        Wed,  4 Sep 2019 03:37:40 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 10B453F246;
        Wed,  4 Sep 2019 03:37:39 -0700 (PDT)
Subject: Re: [PATCH v3 06/11] kselftest: arm64: fake_sigreturn_bad_magic
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     andreyknvl@google.com, shuah@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-7-cristian.marussi@arm.com>
 <20190813162523.GD10425@arm.com>
 <245a3d64-2790-1768-94ab-d1ea56aa3d3d@arm.com>
 <20190904100516.GN27757@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <1ae402d4-4fe0-9541-4e18-d432f88fc6bb@arm.com>
Date:   Wed, 4 Sep 2019 11:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904100516.GN27757@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 04/09/2019 11:05, Dave Martin wrote:
> On Fri, Aug 30, 2019 at 03:29:29PM +0100, Cristian Marussi wrote:
>> Hi
>>
>> On 13/08/2019 17:25, Dave Martin wrote:
>>> On Fri, Aug 02, 2019 at 06:02:55PM +0100, Cristian Marussi wrote:
> 
> [...]
> 
>>>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_bad_magic.c
> 
> [...]
> 
>>>> +static int fake_sigreturn_bad_magic_run(struct tdescr *td,
>>>> +					siginfo_t *si, ucontext_t *uc)
>>>> +{
>>>> +	size_t resv_sz, offset;
>>>> +	struct _aarch64_ctx *shead = GET_SF_RESV_HEAD(sf), *head;
>>>> +
>>>> +	/* just to fill the ucontext_t with something real */
>>>> +	if (!get_current_context(td, &sf.uc))
>>>> +		return 1;
>>>> +
>>>> +	resv_sz = GET_SF_RESV_SIZE(sf);
>>>> +	/*
>>>> +	 * find the terminator, preserving existing headers
>>>> +	 * and verify amount of spare room in __reserved area.
>>>> +	 */
>>>> +	head = get_terminator(shead, resv_sz, &offset);
>>>> +	/*
>>>> +	 * try stripping extra_context header when low on space:
>>>> +	 * we need at least 2*HDR_SZ space ... one for the KSFT_BAD_MAGIC
>>>> +	 * and the other for the usual terminator.
>>>> +	 */
>>>> +	if (head && resv_sz - offset < HDR_SZ * 2) {
>>>
>>> Can we factor out this logic for finding space in the signal frame?
>>>
>>> We do pretty much the same thing in all the fake_sigreturn tests...
>>
>> Ok
>>>
>>>> +		fprintf(stderr, "Low on space:%zd. Discarding extra_context.\n",
>>>> +			resv_sz - offset);
>>>> +		head = get_header(shead, EXTRA_MAGIC, resv_sz, &offset);
>>>> +	}
>>>> +	/* just give up and timeout if still not enough space */
>>>
>>> Do we actually time out?  I don't see where we actually wait, so doesn't
>>> test_run() just fail immediately?
>>>
>>> The same applies to all the other fake_sigreturn tests too.
>>>
>> Right. It is probably a leftover.
>>
>> SIGALRM is used as an extreme measure to kill tests gone bad, but this
>> can happen only once the fake sigframe has been effectively placed on the stack
>> and sigreturned.
> 
> OK, so this gets reported as a test failure because with no SIGSEGV,
> nothing ever sets td->pass?

Yes exactly. End result is based on value on td->pass, in case of abrupt
termination or timeout nobody sets td->pass ever.
> 
> This is probably OK for now, though I wonder whether this should be
> reported as a skipped test instead.
> 
> In case of doubt, reporting a failure is preferable anyway, since that
> will encourage people actually to investigate what went wrong.
> 

As of now I never skip a test in fact...also tests for unsupported features
are built and run expecting a SIGILL, and reported as PASS in that case.

Cristian
> [...]
> 
> Cheers
> ---Dave
> 

