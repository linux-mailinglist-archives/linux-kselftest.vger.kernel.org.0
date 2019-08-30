Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C934A3A0D
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2019 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727434AbfH3PLR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 30 Aug 2019 11:11:17 -0400
Received: from foss.arm.com ([217.140.110.172]:33748 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbfH3PLR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 30 Aug 2019 11:11:17 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5FF8344;
        Fri, 30 Aug 2019 08:11:16 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DAFFC3F703;
        Fri, 30 Aug 2019 08:11:15 -0700 (PDT)
Subject: Re: [PATCH v3 09/11] kselftest: arm64:
 fake_sigreturn_duplicated_fpsimd
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-10-cristian.marussi@arm.com>
 <20190813162633.GG10425@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <303594b8-9cb5-5271-0a10-6c9eec0fa6e8@arm.com>
Date:   Fri, 30 Aug 2019 16:11:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813162633.GG10425@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/08/2019 17:26, Dave Martin wrote:
> On Fri, Aug 02, 2019 at 06:02:58PM +0100, Cristian Marussi wrote:
>> Added a simple fake_sigreturn testcase which builds a ucontext_t
> 
> Add

Ok
> 
>> with an anomalous additional fpsimd_context and place it onto the stack.
>> Expects a SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>  .../arm64/signal/testcases/.gitignore         |  1 +
>>  .../fake_sigreturn_duplicated_fpsimd.c        | 62 +++++++++++++++++++
>>  2 files changed, 63 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> index 17d1c5e73319..94f9baaf638c 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> @@ -7,3 +7,4 @@ mangle_pstate_ssbs_regs
>>  fake_sigreturn_bad_magic
>>  fake_sigreturn_bad_size_for_magic0
>>  fake_sigreturn_missing_fpsimd
>> +fake_sigreturn_duplicated_fpsimd
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
>> new file mode 100644
>> index 000000000000..09af7a0f8776
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/fake_sigreturn_duplicated_fpsimd.c
>> @@ -0,0 +1,62 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
> 
> signal.h?
Ok
> 
>> +#include <stdio.h>
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
>> +	size_t resv_sz, offset;
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
>> +	 * we need at least space for one additional fpsimd_context
>> +	 */
>> +	if (head && resv_sz - offset < sizeof(struct fpsimd_context)) {
>> +		fprintf(stderr, "Low on space:%zd. Discarding extra_context.\n",
>> +			resv_sz - offset);
>> +		head = get_header(shead, EXTRA_MAGIC, resv_sz, &offset);
>> +	}
>> +
>> +	/* just give up and timeout if still not enough space */
>> +	if (head &&
>> +	    resv_sz - offset >= sizeof(struct fpsimd_context) + HDR_SZ) {
>> +		fprintf(stderr, "Mangling template header. Spare space:%zd\n",
>> +			resv_sz - offset);
>> +		/* Add a spurios fpsimd_context */
>> +		head->magic = FPSIMD_MAGIC;
>> +		head->size = sizeof(struct fpsimd_context);
>> +		/* and terminate */
>> +		write_terminator_record(GET_RESV_NEXT_HEAD(head));
>> +
>> +		ASSERT_BAD_CONTEXT(&sf.uc);
>> +		fake_sigreturn(&sf, sizeof(sf), 16);
>> +	}
>> +
>> +	return 1;
>> +}
> 

I'll convert to use new helper get_starting_head() to make space in __reserved.

Cheers

Cristian

> [...]
> 
> Otherwise looks ok.
> 
> Cheers
> ---Dave
> 

