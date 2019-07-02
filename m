Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93455D316
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Jul 2019 17:39:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbfGBPjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Jul 2019 11:39:47 -0400
Received: from foss.arm.com ([217.140.110.172]:52066 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfGBPjr (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Jul 2019 11:39:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65E4B28;
        Tue,  2 Jul 2019 08:39:46 -0700 (PDT)
Received: from [10.1.26.178] (unknown [10.1.26.178])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97B63F246;
        Tue,  2 Jul 2019 08:39:45 -0700 (PDT)
Subject: Re: [PATCH 03/13] kselftest: arm64: mangle_sp_misaligned
To:     Dave Martin <Dave.Martin@arm.com>
Cc:     linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, shuah@kernel.org,
        andreyknvl@google.com
References: <20190613111335.7645-1-cristian.marussi@arm.com>
 <20190613111335.7645-4-cristian.marussi@arm.com>
 <20190621103518.GK2790@e103592.cambridge.arm.com>
From:   Cristian Marussi <cristian.marussi@arm.com>
Message-ID: <68cc7940-4ee0-b06c-7bd3-b1fbfbc9e142@arm.com>
Date:   Tue, 2 Jul 2019 16:39:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190621103518.GK2790@e103592.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi

On 6/21/19 11:35 AM, Dave Martin wrote:
> On Thu, Jun 13, 2019 at 12:13:25PM +0100, Cristian Marussi wrote:
>> Added a simple mangle testcase which messes with the ucontext_t
>> from within the sig_handler, trying to badly modify and misalign the SP.
>> Expects SIGBUS on test PASS.
>>
>> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
>> ---
>>   .../arm64/signal/testcases/.gitignore         |  1 +
>>   .../signal/testcases/mangle_sp_misaligned.c   | 24 +++++++++++++++++++
>>   2 files changed, 25 insertions(+)
>>   create mode 100644 tools/testing/selftests/arm64/signal/testcases/.gitignore
>>   create mode 100644 tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c
>>
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/.gitignore b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> new file mode 100644
>> index 000000000000..7f7414d241f2
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/.gitignore
>> @@ -0,0 +1 @@
>> +mangle_sp_misaligned
>> diff --git a/tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c b/tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c
>> new file mode 100644
>> index 000000000000..41bd27312e54
>> --- /dev/null
>> +++ b/tools/testing/selftests/arm64/signal/testcases/mangle_sp_misaligned.c
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019 ARM Limited */
>> +
>> +#include "test_signals_utils.h"
>> +#include "testcases.h"
>> +
>> +static int mangle_misaligned_sp_run(struct tdescr *td, siginfo_t *si,
>> +				    ucontext_t *uc)
>> +{
>> +	ASSERT_GOOD_CONTEXT(uc);
>> +
>> +	uc->uc_mcontext.sp += 3;
> 
> What are we testing here?
> 
> It is archietcturally permitted (if unusual) to have a misaligned sp in
> userspace.
> 
> So are we just getting a SIGBUS after the sigreturn, when the thread
> tries to dereference sp?  If so, we aren't really testing anything about
> sigreturn here -- I don't see any check in the kernel when restoring sp
> in sigreturn.
> 
> Even if there were no SIGBUS, the thread stack is now corrupt (due to
> wrong sp), so the interrupted code is unlikely to continue running
> successfully.
> 
> Am I missing something?
> 

The initial (flawed) attempt was to test the check in arm64 rt_sigreturn 
kernel code:

if (regs->sp & 15)
	goto badframe;

BUT in fact such initial check happens at the start of rt_sigreturn 
syscall well before the regs are restored from the uc context in the 
sigframe which I mangled

i.e.
restore_sigframe() -->> __get_user_error(regs->sp...)

==>> uc.uc_mcontext.sp --> regs->sp

happens AFTER the above regs->sp alignment check.

So the check is performed on the effective SP value at the time of 
kernel entry of sigreturn NOT on the uc.uc_mcontext.sp MANGLED value, so 
this is not really a sigreturn related test at this point. (and hence 
the SIGBUS instead of the SEGV).

So an option could be as you proposed in another similarly flawed test 
to mangle uc.uc_mcontext.sp to point to something unreasonable and in 
Kernel space (at least virtually)

I'll give it a try.

Cristian

> [...]
> 
> Cheers
> ---Dave
> 
