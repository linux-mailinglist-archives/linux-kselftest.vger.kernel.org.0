Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECBC243DE2
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jun 2019 17:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389388AbfFMPqD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jun 2019 11:46:03 -0400
Received: from foss.arm.com ([217.140.110.172]:43564 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389371AbfFMPqC (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jun 2019 11:46:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 35647367;
        Thu, 13 Jun 2019 08:46:01 -0700 (PDT)
Received: from [10.1.196.72] (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA3A53F246;
        Thu, 13 Jun 2019 08:45:55 -0700 (PDT)
Subject: Re: [PATCH v17 03/15] arm64: Introduce prctl() options to control the
 tagged user addresses ABI
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Dave Martin <Dave.Martin@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        linux-media@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Szabolcs Nagy <Szabolcs.Nagy@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Kostya Serebryany <kcc@google.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Leon Romanovsky <leon@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Evgeniy Stepanov <eugenis@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yishai Hadas <yishaih@mellanox.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Lee Smith <Lee.Smith@arm.com>,
        Alexander Deucher <Alexander.Deucher@amd.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        enh <enh@google.com>, Robin Murphy <robin.murphy@arm.com>,
        Christian Koenig <Christian.Koenig@amd.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <a7a2933bea5fe57e504891b7eec7e9432e5e1c1a.1560339705.git.andreyknvl@google.com>
 <20190613111659.GX28398@e103592.cambridge.arm.com>
 <20190613153505.GU28951@C02TF0J2HF1T.local>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <99cc257d-5e99-922a-fbe7-3bbaf3621e38@arm.com>
Date:   Thu, 13 Jun 2019 16:45:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190613153505.GU28951@C02TF0J2HF1T.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 13/06/2019 16:35, Catalin Marinas wrote:
> On Thu, Jun 13, 2019 at 12:16:59PM +0100, Dave P Martin wrote:
>> On Wed, Jun 12, 2019 at 01:43:20PM +0200, Andrey Konovalov wrote:
>>> From: Catalin Marinas <catalin.marinas@arm.com>
>>>
>>> It is not desirable to relax the ABI to allow tagged user addresses into
>>> the kernel indiscriminately. This patch introduces a prctl() interface
>>> for enabling or disabling the tagged ABI with a global sysctl control
>>> for preventing applications from enabling the relaxed ABI (meant for
>>> testing user-space prctl() return error checking without reconfiguring
>>> the kernel). The ABI properties are inherited by threads of the same
>>> application and fork()'ed children but cleared on execve().
>>>
>>> The PR_SET_TAGGED_ADDR_CTRL will be expanded in the future to handle
>>> MTE-specific settings like imprecise vs precise exceptions.
>>>
>>> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
>>> ---
>>>  arch/arm64/include/asm/processor.h   |  6 +++
>>>  arch/arm64/include/asm/thread_info.h |  1 +
>>>  arch/arm64/include/asm/uaccess.h     |  3 +-
>>>  arch/arm64/kernel/process.c          | 67 ++++++++++++++++++++++++++++
>>>  include/uapi/linux/prctl.h           |  5 +++
>>>  kernel/sys.c                         | 16 +++++++
>>>  6 files changed, 97 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/include/asm/processor.h b/arch/arm64/include/asm/processor.h
>>> index fcd0e691b1ea..fee457456aa8 100644
>>> --- a/arch/arm64/include/asm/processor.h
>>> +++ b/arch/arm64/include/asm/processor.h
>>> @@ -307,6 +307,12 @@ extern void __init minsigstksz_setup(void);
>>>  /* PR_PAC_RESET_KEYS prctl */
>>>  #define PAC_RESET_KEYS(tsk, arg)	ptrauth_prctl_reset_keys(tsk, arg)
>>>  
>>> +/* PR_TAGGED_ADDR prctl */
>>
>> (A couple of comments I missed in my last reply:)
>>
>> Name mismatch?
> 
> Yeah, it went through several names but it seems that I didn't update
> all places.
> 
>>> +long set_tagged_addr_ctrl(unsigned long arg);
>>> +long get_tagged_addr_ctrl(void);
>>> +#define SET_TAGGED_ADDR_CTRL(arg)	set_tagged_addr_ctrl(arg)
>>> +#define GET_TAGGED_ADDR_CTRL()		get_tagged_addr_ctrl()
>>> +
>>
>> [...]
>>
>>> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>>> index 3767fb21a5b8..69d0be1fc708 100644
>>> --- a/arch/arm64/kernel/process.c
>>> +++ b/arch/arm64/kernel/process.c
>>> @@ -30,6 +30,7 @@
>>>  #include <linux/kernel.h>
>>>  #include <linux/mm.h>
>>>  #include <linux/stddef.h>
>>> +#include <linux/sysctl.h>
>>>  #include <linux/unistd.h>
>>>  #include <linux/user.h>
>>>  #include <linux/delay.h>
>>> @@ -323,6 +324,7 @@ void flush_thread(void)
>>>  	fpsimd_flush_thread();
>>>  	tls_thread_flush();
>>>  	flush_ptrace_hw_breakpoint(current);
>>> +	clear_thread_flag(TIF_TAGGED_ADDR);
>>>  }
>>>  
>>>  void release_thread(struct task_struct *dead_task)
>>> @@ -552,3 +554,68 @@ void arch_setup_new_exec(void)
>>>  
>>>  	ptrauth_thread_init_user(current);
>>>  }
>>> +
>>> +/*
>>> + * Control the relaxed ABI allowing tagged user addresses into the kernel.
>>> + */
>>> +static unsigned int tagged_addr_prctl_allowed = 1;
>>> +
>>> +long set_tagged_addr_ctrl(unsigned long arg)
>>> +{
>>> +	if (!tagged_addr_prctl_allowed)
>>> +		return -EINVAL;
>>
>> So, tagging can actually be locked on by having a process enable it and
>> then some possibly unrelated process clearing tagged_addr_prctl_allowed.
>> That feels a bit weird.
> 
> The problem is that if you disable the ABI globally, lots of
> applications would crash. This sysctl is meant as a way to disable the
> opt-in to the TBI ABI. Another option would be a kernel command line
> option (I'm not keen on a Kconfig option).
>

Why you are not keen on a Kconfig option?

>> Do we want to allow a process that has tagging on to be able to turn
>> it off at all?  Possibly things like CRIU might want to do that.
> 
> I left it in for symmetry but I don't expect it to be used. A potential
> use-case is doing it per subsequent threads in an application.
> 
>>> +	if (is_compat_task())
>>> +		return -EINVAL;
>>> +	if (arg & ~PR_TAGGED_ADDR_ENABLE)
>>> +		return -EINVAL;
>>
>> How do we expect this argument to be extended in the future?
> 
> Yes, for MTE. That's why I wouldn't allow random bits here.
> 
>> I'm wondering whether this is really a bitmask or an enum, or a mixture
>> of the two.  Maybe it doesn't matter.
> 
> User may want to set PR_TAGGED_ADDR_ENABLE | PR_MTE_PRECISE in a single
> call.
> 
>>> +	if (arg & PR_TAGGED_ADDR_ENABLE)
>>> +		set_thread_flag(TIF_TAGGED_ADDR);
>>> +	else
>>> +		clear_thread_flag(TIF_TAGGED_ADDR);
>>
>> I think update_thread_flag() could be used here.
> 
> Yes. I forgot you added this.
> 

-- 
Regards,
Vincenzo
