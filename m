Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87433A15A7
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 12:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbfH2KTh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 06:19:37 -0400
Received: from foss.arm.com ([217.140.110.172]:41810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfH2KTh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 06:19:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C1DB28;
        Thu, 29 Aug 2019 03:19:36 -0700 (PDT)
Received: from [10.1.197.50] (e120937-lin.cambridge.arm.com [10.1.197.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 811FF3F59C;
        Thu, 29 Aug 2019 03:19:35 -0700 (PDT)
Subject: Re: [PATCH v3 03/11] kselftest: arm64:
 mangle_pstate_invalid_daif_bits
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190802170300.20662-1-cristian.marussi@arm.com>
 <20190802170300.20662-4-cristian.marussi@arm.com>
 <20190813162434.GA10425@arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <982361ab-c7bd-93af-f6c6-b6daba5505e7@arm.com>
Date:   Thu, 29 Aug 2019 11:19:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190813162434.GA10425@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 13/08/2019 17:24, Dave Martin wrote:
> On Fri, Aug 02, 2019 at 06:02:52PM +0100, Cristian Marussi wrote:
>> Added a simple mangle testcase which messes with the ucontext_t
> 
> Strange past tense?  How about "Add"?
> 
>> from within the sig_handler, trying to set PSTATE DAIF bits to an
> 
> "signal handler"?
> 

Ok I'll fix the commit message and use imperative mood.

Cheers

Cristian
>> invalid value (masking everything). Expects SIGSEGV on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>  .../arm64/signal/testcases/.gitignore         |  1 +
>>  .../mangle_pstate_invalid_daif_bits.c         | 28 +++++++++++++++++++
>>  2 files changed, 29 insertions(+)
>>  create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> index 8651272e3cfc..8a0a29f0cc2a 100644
>> --- a/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> @@ -1 +1,2 @@
>>  mangle_pstate_invalid_compat_toggle
>> +mangle_pstate_invalid_daif_bits
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c
>> new file mode 100644
>> index 000000000000..af899d4bb655
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_pstate_invalid_daif_bits.c
>> @@ -0,0 +1,28 @@
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
>> +	 * This config should trigger a SIGSEGV by Kernel when it checks
>> +	 * the sigframe consistency in valid_user_regs() routine.
>> +	 */
>> +	uc->uc_mcontext.pstate |= PSR_D_BIT | PSR_A_BIT | PSR_I_BIT | PSR_F_BIT;
>> +
>> +	return 1;
>> +}
> 
> Hmmm, there was a lot of common framework code, but it seems like a good
> investment if adding a new test is as simple as this :)
> 
> [...]
> 
> Cheers
> ---Dave
> 

