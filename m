Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B3874ACE2
	for <lists+linux-kselftest@lfdr.de>; Fri,  7 Jul 2023 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjGGI2Q (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 7 Jul 2023 04:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232708AbjGGI2K (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 7 Jul 2023 04:28:10 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2AF1FC6;
        Fri,  7 Jul 2023 01:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688718489; x=1720254489;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GzxiFui6WFto9YwFpGhkmwPFzsKVDuUSVc9CcihpbgE=;
  b=MIWubbu8n0IMdGK+UNE9OB8V4Ftc2xbPDjZkQeC5j5vuMgBkcrVdprWZ
   yIFSp6A+1HLjHplZikzdlvgc1o+p4SX/DpFDCge4egAd8yxFPKBnVpG7Z
   XcVnfa7e7kQFMptqoVlPhc1+w7N68DLX+4aI/GnHSkET4a7cG0AQWEL2T
   EjnZBuhQZSKPq0pvLvAaHTgAlxyldk/eP2LETGDZTPh4kM+6ZYJXfyj8l
   mtJ6rN4xfZxfTEloGbHVw83PlmBIhKJAujPggJjLFFYFBMPG9hFslz/CK
   i+tGhyJkjMH5Pty1QHzPzh3pTnLilmid3ohsc+tPYWTE7/8lXlpeKCKt4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="363874282"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="363874282"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:28:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="723127389"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="723127389"
Received: from slisovsk-mobl2.ger.corp.intel.com (HELO [10.249.33.67]) ([10.249.33.67])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 01:28:05 -0700
Message-ID: <6b0c67e9-e806-200c-3af4-cfdd2e5c47d3@linux.intel.com>
Date:   Fri, 7 Jul 2023 11:27:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] x86/tsc: Add new BPF helper call bpf_rdtsc
Content-Language: en-US
To:     John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-2-tero.kristo@linux.intel.com>
 <CAADnVQL2Tn+2rP0hVB3kdB0At12qVu+vJ_WbJzrkxqOJ5va2vQ@mail.gmail.com>
 <64a64e46b7d5b_b20ce208de@john.notmuch>
 <4b874e4c-4ad3-590d-3885-b4a3b894524e@linux.intel.com>
 <CAADnVQK0rzHWxxx7LMFSTuBx18A+6H6AEkKFHNDkPwbPUbsk4Q@mail.gmail.com>
 <64a7a597b1e9e_dddea208db@john.notmuch>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <64a7a597b1e9e_dddea208db@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 07/07/2023 08:41, John Fastabend wrote:
> Alexei Starovoitov wrote:
>> On Thu, Jul 6, 2023 at 4:59 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>>>
>>> On 06/07/2023 08:16, John Fastabend wrote:
>>>> Alexei Starovoitov wrote:
>>>>> On Mon, Jul 3, 2023 at 3:58 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>>>>>> Currently the raw TSC counter can be read within kernel via rdtsc_ordered()
>>>>>> and friends, and additionally even userspace has access to it via the
>>>>>> RDTSC assembly instruction. BPF programs on the other hand don't have
>>>>>> direct access to the TSC counter, but alternatively must go through the
>>>>>> performance subsystem (bpf_perf_event_read), which only provides relative
>>>>>> value compared to the start point of the program, and is also much slower
>>>>>> than the direct read. Add a new BPF helper definition for bpf_rdtsc() which
>>>>>> can be used for any accurate profiling needs.
>>>>>>
>>>>>> A use-case for the new API is for example wakeup latency tracing via
>>>>>> eBPF on Intel architecture, where it is extremely beneficial to be able
>>>>>> to get raw TSC timestamps and compare these directly to the value
>>>>>> programmed to the MSR_IA32_TSC_DEADLINE register. This way a direct
>>>>>> latency value from the hardware interrupt to the execution of the
>>>>>> interrupt handler can be calculated. Having the functionality within
>>>>>> eBPF also has added benefits of allowing to filter any other relevant
>>>>>> data like C-state residency values, and also to drop any irrelevant
>>>>>> data points directly in the kernel context, without passing all the
>>>>>> data to userspace for post-processing.
>>>>>>
>>>>>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>>>>>> ---
>>>>>>    arch/x86/include/asm/msr.h |  1 +
>>>>>>    arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
>>>>>>    2 files changed, 24 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
>>>>>> index 65ec1965cd28..3dde673cb563 100644
>>>>>> --- a/arch/x86/include/asm/msr.h
>>>>>> +++ b/arch/x86/include/asm/msr.h
>>>>>> @@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
>>>>>>    void msrs_free(struct msr *msrs);
>>>>>>    int msr_set_bit(u32 msr, u8 bit);
>>>>>>    int msr_clear_bit(u32 msr, u8 bit);
>>>>>> +u64 bpf_rdtsc(void);
>>>>>>
>>>>>>    #ifdef CONFIG_SMP
>>>>>>    int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
>>>>>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>>>>>> index 344698852146..ded857abef81 100644
>>>>>> --- a/arch/x86/kernel/tsc.c
>>>>>> +++ b/arch/x86/kernel/tsc.c
>>>>>> @@ -15,6 +15,8 @@
>>>>>>    #include <linux/timex.h>
>>>>>>    #include <linux/static_key.h>
>>>>>>    #include <linux/static_call.h>
>>>>>> +#include <linux/btf.h>
>>>>>> +#include <linux/btf_ids.h>
>>>>>>
>>>>>>    #include <asm/hpet.h>
>>>>>>    #include <asm/timer.h>
>>>>>> @@ -29,6 +31,7 @@
>>>>>>    #include <asm/intel-family.h>
>>>>>>    #include <asm/i8259.h>
>>>>>>    #include <asm/uv/uv.h>
>>>>>> +#include <asm/tlbflush.h>
>>>>>>
>>>>>>    unsigned int __read_mostly cpu_khz;    /* TSC clocks / usec, not used here */
>>>>>>    EXPORT_SYMBOL(cpu_khz);
>>>>>> @@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
>>>>>>           tsc_enable_sched_clock();
>>>>>>    }
>>>>>>
>>>>>> +u64 bpf_rdtsc(void)
>>>>>> +{
>>>>>> +       /* Check if Time Stamp is enabled only in ring 0 */
>>>>>> +       if (cr4_read_shadow() & X86_CR4_TSD)
>>>>>> +               return 0;
>>>>> Why check this? It's always enabled in the kernel, no?
>>> It is always enabled, but there are certain syscalls that can be used to
>>> disable the TSC access for oneself. prctl(PR_SET_TSC, ...) and
>>> seccomp(SET_MODE_STRICT,...). Not having the check in place would in
>>> theory allow a restricted BPF program to circumvent this (if there ever
>>> was such a thing.) But yes, I do agree this part is a bit debatable
>>> whether it should be there at all.
>> What do you mean 'circumvent' ?
>> It's a tracing bpf prog running in the kernel loaded by root
>> and reading tsc for the purpose of the kernel.
>> There is no unprivileged access to tsc here.
This was based on some discussions with the security team at Intel, I 
don't pretend to know anything about security myself. But I can drop the 
check. It is probably not needed because of the fact that it is already 
possible to read the TSC counter with the approach I mention in the 
cover letter; via perf and bpf_core_read().
>>
>>>>>> +
>>>>>> +       return rdtsc_ordered();
>>>>> Why _ordered? Why not just rdtsc ?
>>>>> Especially since you want to trace latency. Extra lfence will ruin
>>>>> the measurements.
>>>>>
>>>> If we used it as a fast way to order events on multiple CPUs I
>>>> guess we need the lfence? We use ktime_get_ns() now for things
>>>> like this when we just need an order counter. We have also
>>>> observed time going backwards with this and have heuristics
>>>> to correct it but its rare.
>>> Yeah, I think it is better to induce some extra latency instead of
>>> having some weird ordering issues with the timestamps.
>> lfence is not 'some extra latency'.
>> I suspect rdtsc_ordered() will be slower than bpf_ktime_get_ns().
>> What's the point of using it then?
> I would only use it if its faster then bpf_ktime_get_ns() and
> have already figured out how to handle rare unordered events
> so I think its OK to relax somewhat strict ordering.

I believe that on x86-arch using bpf_ktime_get_ns() also ends up calling 
rdtsc_odered() under the hood.

I just did some measurements on an Intel(R) Xeon(R) Platinum 8360Y CPU @ 
2.40GHz, with a simple BPF code:

         t1 = bpf_ktime_get_ns();

         for (i = 0; i < NUM_CYC; i++) {
                 bpf_rdtsc(); // or bpf_ktime_get_ns() here
         }

         t2 = bpf_ktime_get_ns();

The results I got with the CPU locked at 2.4GHz (average execution times 
per a call within the loop, this with some 10M executions):

bpf_rdtsc() ordered : 45ns

bpf_rdtsc() un-ordered : 23ns

bpf_ktime_get_ns() : 49ns

Locking the CPU at 800MHz the results are:

bpf_rdtsc() ordered : 55ns

bpf_rdtsc() un-ordered : 33ns

bpf_ktime_get_ns() : 71ns

The bpf_rdtsc() in these results contains some extra latency caused by 
conditional execution, I added a flag to the call to select whether it 
should use _ordered() or not, and it also still contains the CR4_TSD 
check in place.

-Tero

>
>>> Also, things like the ftrace also use rdtsc_ordered() as its underlying
>>> clock, if you use x86-tsc as the trace clock (see
>>> arch/x86/kernel/trace_clock.c.)
>>>
>>> -Tero
>>>
>
