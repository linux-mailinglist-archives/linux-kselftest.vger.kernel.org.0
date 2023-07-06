Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83839749B3D
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 13:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGFL7c (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 07:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGFL7b (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 07:59:31 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB57128;
        Thu,  6 Jul 2023 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688644770; x=1720180770;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NrV0TuofPDABtI94QAID7aTJlhItAdkaYnK5xZhH56U=;
  b=YoWKsMExCdnKCLlTfTrvtdJwThC+rv+APsTan4NaMQ7fERGOt7K5qwLD
   UY0pdmvYcw6bau/Fs2Fjce5j5iArNbrqjPSZE6aSVojuMNgm5SpzPI1Rf
   RBgAP0n63H1gJ52Ou+VfvmGdg2FsUy6t0yDt3YATW/Bn4YxD8weTWJRwz
   5pnJUJIBVKTdWhAKd8wGc2xvW90Uk31YQcsJb1RzcqQ8w0ggzJ/VomnJg
   Wz4w2PD2V4VAK73B/IZiw6A+ByOPXi0OB5P3pPrNUtV4d0Q6V7z23kO4V
   7SM6DmGrVjDtUXhy5dEeuVFu4Pns/6KPEnzB1v8t71lXVo1nl9xgCiOj9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="394339218"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="394339218"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="784907101"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="784907101"
Received: from azsigmon-mobl.ger.corp.intel.com (HELO [10.249.33.88]) ([10.249.33.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 04:59:27 -0700
Message-ID: <4b874e4c-4ad3-590d-3885-b4a3b894524e@linux.intel.com>
Date:   Thu, 6 Jul 2023 14:59:24 +0300
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
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <64a64e46b7d5b_b20ce208de@john.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 06/07/2023 08:16, John Fastabend wrote:
> Alexei Starovoitov wrote:
>> On Mon, Jul 3, 2023 at 3:58 AM Tero Kristo <tero.kristo@linux.intel.com> wrote:
>>> Currently the raw TSC counter can be read within kernel via rdtsc_ordered()
>>> and friends, and additionally even userspace has access to it via the
>>> RDTSC assembly instruction. BPF programs on the other hand don't have
>>> direct access to the TSC counter, but alternatively must go through the
>>> performance subsystem (bpf_perf_event_read), which only provides relative
>>> value compared to the start point of the program, and is also much slower
>>> than the direct read. Add a new BPF helper definition for bpf_rdtsc() which
>>> can be used for any accurate profiling needs.
>>>
>>> A use-case for the new API is for example wakeup latency tracing via
>>> eBPF on Intel architecture, where it is extremely beneficial to be able
>>> to get raw TSC timestamps and compare these directly to the value
>>> programmed to the MSR_IA32_TSC_DEADLINE register. This way a direct
>>> latency value from the hardware interrupt to the execution of the
>>> interrupt handler can be calculated. Having the functionality within
>>> eBPF also has added benefits of allowing to filter any other relevant
>>> data like C-state residency values, and also to drop any irrelevant
>>> data points directly in the kernel context, without passing all the
>>> data to userspace for post-processing.
>>>
>>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>>> ---
>>>   arch/x86/include/asm/msr.h |  1 +
>>>   arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
>>>   2 files changed, 24 insertions(+)
>>>
>>> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
>>> index 65ec1965cd28..3dde673cb563 100644
>>> --- a/arch/x86/include/asm/msr.h
>>> +++ b/arch/x86/include/asm/msr.h
>>> @@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
>>>   void msrs_free(struct msr *msrs);
>>>   int msr_set_bit(u32 msr, u8 bit);
>>>   int msr_clear_bit(u32 msr, u8 bit);
>>> +u64 bpf_rdtsc(void);
>>>
>>>   #ifdef CONFIG_SMP
>>>   int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
>>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>>> index 344698852146..ded857abef81 100644
>>> --- a/arch/x86/kernel/tsc.c
>>> +++ b/arch/x86/kernel/tsc.c
>>> @@ -15,6 +15,8 @@
>>>   #include <linux/timex.h>
>>>   #include <linux/static_key.h>
>>>   #include <linux/static_call.h>
>>> +#include <linux/btf.h>
>>> +#include <linux/btf_ids.h>
>>>
>>>   #include <asm/hpet.h>
>>>   #include <asm/timer.h>
>>> @@ -29,6 +31,7 @@
>>>   #include <asm/intel-family.h>
>>>   #include <asm/i8259.h>
>>>   #include <asm/uv/uv.h>
>>> +#include <asm/tlbflush.h>
>>>
>>>   unsigned int __read_mostly cpu_khz;    /* TSC clocks / usec, not used here */
>>>   EXPORT_SYMBOL(cpu_khz);
>>> @@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
>>>          tsc_enable_sched_clock();
>>>   }
>>>
>>> +u64 bpf_rdtsc(void)
>>> +{
>>> +       /* Check if Time Stamp is enabled only in ring 0 */
>>> +       if (cr4_read_shadow() & X86_CR4_TSD)
>>> +               return 0;
>> Why check this? It's always enabled in the kernel, no?

It is always enabled, but there are certain syscalls that can be used to 
disable the TSC access for oneself. prctl(PR_SET_TSC, ...) and 
seccomp(SET_MODE_STRICT,...). Not having the check in place would in 
theory allow a restricted BPF program to circumvent this (if there ever 
was such a thing.) But yes, I do agree this part is a bit debatable 
whether it should be there at all.


>>> +
>>> +       return rdtsc_ordered();
>> Why _ordered? Why not just rdtsc ?
>> Especially since you want to trace latency. Extra lfence will ruin
>> the measurements.
>>
> If we used it as a fast way to order events on multiple CPUs I
> guess we need the lfence? We use ktime_get_ns() now for things
> like this when we just need an order counter. We have also
> observed time going backwards with this and have heuristics
> to correct it but its rare.

Yeah, I think it is better to induce some extra latency instead of 
having some weird ordering issues with the timestamps.

Also, things like the ftrace also use rdtsc_ordered() as its underlying 
clock, if you use x86-tsc as the trace clock (see 
arch/x86/kernel/trace_clock.c.)

-Tero

