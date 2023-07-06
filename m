Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FDC749B43
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jul 2023 14:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232002AbjGFMAn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 6 Jul 2023 08:00:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjGFMAm (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 6 Jul 2023 08:00:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C99128;
        Thu,  6 Jul 2023 05:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688644841; x=1720180841;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZDJycbQzQdGx49/hXHpAZTUVfY/mTPwVhJwoARAumb0=;
  b=TbXY5GGsZkc+uP+9Op4eLSa/BQwi0JzARu2NdlnBWpDuvQG4imqW2Wv9
   PFLFi95SNlXr2/Y/Sprn4oe0xqSQenaASKf76PK8Q6F3y6chfO/LkTfRM
   jMejne1uVpGZr47j2qrmf42kUBeCGFi8q061WS83SgYsnJA0JZg8lubC7
   LnPWGrI3MzD6YYmz68P4yJNkjet3dMWddZMCzCC12+y4U10cPRjakma1H
   RrOjruT+Tr/EzTsg3pU/SkdljkC//bNmqRqBOaa1S7jKrZ063mHGJgNp5
   7NxZdMmIorVopBAHNY5R/XqqhyUjN7i2IkhILTNl8b1L2Vfu024p6MFtT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="394339449"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="394339449"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:00:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="784907215"
X-IronPort-AV: E=Sophos;i="6.01,185,1684825200"; 
   d="scan'208";a="784907215"
Received: from azsigmon-mobl.ger.corp.intel.com (HELO [10.249.33.88]) ([10.249.33.88])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 05:00:38 -0700
Message-ID: <45c8ebd7-c394-49f9-ca2b-39755c867f7e@linux.intel.com>
Date:   Thu, 6 Jul 2023 15:00:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] x86/tsc: Add new BPF helper call bpf_rdtsc
Content-Language: en-US
To:     Yonghong Song <yhs@meta.com>, shuah@kernel.org, tglx@linutronix.de,
        x86@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com,
        mingo@redhat.com
Cc:     ast@kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, bpf@vger.kernel.org
References: <20230703105745.1314475-1-tero.kristo@linux.intel.com>
 <20230703105745.1314475-2-tero.kristo@linux.intel.com>
 <0ec3be00-1be1-540b-7598-a693c5a92c8a@meta.com>
From:   Tero Kristo <tero.kristo@linux.intel.com>
In-Reply-To: <0ec3be00-1be1-540b-7598-a693c5a92c8a@meta.com>
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


On 04/07/2023 07:49, Yonghong Song wrote:
>
>
> On 7/3/23 3:57 AM, Tero Kristo wrote:
>> Currently the raw TSC counter can be read within kernel via 
>> rdtsc_ordered()
>> and friends, and additionally even userspace has access to it via the
>> RDTSC assembly instruction. BPF programs on the other hand don't have
>> direct access to the TSC counter, but alternatively must go through the
>> performance subsystem (bpf_perf_event_read), which only provides 
>> relative
>> value compared to the start point of the program, and is also much 
>> slower
>> than the direct read. Add a new BPF helper definition for bpf_rdtsc() 
>> which
>> can be used for any accurate profiling needs.
>>
>> A use-case for the new API is for example wakeup latency tracing via
>> eBPF on Intel architecture, where it is extremely beneficial to be able
>> to get raw TSC timestamps and compare these directly to the value
>> programmed to the MSR_IA32_TSC_DEADLINE register. This way a direct
>> latency value from the hardware interrupt to the execution of the
>> interrupt handler can be calculated. Having the functionality within
>> eBPF also has added benefits of allowing to filter any other relevant
>> data like C-state residency values, and also to drop any irrelevant
>> data points directly in the kernel context, without passing all the
>> data to userspace for post-processing.
>>
>> Signed-off-by: Tero Kristo <tero.kristo@linux.intel.com>
>> ---
>>   arch/x86/include/asm/msr.h |  1 +
>>   arch/x86/kernel/tsc.c      | 23 +++++++++++++++++++++++
>>   2 files changed, 24 insertions(+)
>>
>> diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
>> index 65ec1965cd28..3dde673cb563 100644
>> --- a/arch/x86/include/asm/msr.h
>> +++ b/arch/x86/include/asm/msr.h
>> @@ -309,6 +309,7 @@ struct msr *msrs_alloc(void);
>>   void msrs_free(struct msr *msrs);
>>   int msr_set_bit(u32 msr, u8 bit);
>>   int msr_clear_bit(u32 msr, u8 bit);
>> +u64 bpf_rdtsc(void);
>>     #ifdef CONFIG_SMP
>>   int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
>> diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
>> index 344698852146..ded857abef81 100644
>> --- a/arch/x86/kernel/tsc.c
>> +++ b/arch/x86/kernel/tsc.c
>> @@ -15,6 +15,8 @@
>>   #include <linux/timex.h>
>>   #include <linux/static_key.h>
>>   #include <linux/static_call.h>
>> +#include <linux/btf.h>
>> +#include <linux/btf_ids.h>
>>     #include <asm/hpet.h>
>>   #include <asm/timer.h>
>> @@ -29,6 +31,7 @@
>>   #include <asm/intel-family.h>
>>   #include <asm/i8259.h>
>>   #include <asm/uv/uv.h>
>> +#include <asm/tlbflush.h>
>>     unsigned int __read_mostly cpu_khz;    /* TSC clocks / usec, not 
>> used here */
>>   EXPORT_SYMBOL(cpu_khz);
>> @@ -1551,6 +1554,24 @@ void __init tsc_early_init(void)
>>       tsc_enable_sched_clock();
>>   }
>>   +u64 bpf_rdtsc(void)
>
> Please see kernel/bpf/helpers.c. For kfunc definition, we should have
>
> __diag_push();
> __diag_ignore_all("-Wmissing-prototypes",
>                   "Global functions as their definitions will be in 
> vmlinux BTF");
>
> _bpf_kfunc u64 bpf_rdtsc(void)
> {
>     ...
> }
>
> __diag_pop();
Thanks, I'll modify this for next rev.
>
>
>> +{
>> +    /* Check if Time Stamp is enabled only in ring 0 */
>> +    if (cr4_read_shadow() & X86_CR4_TSD)
>> +        return 0;
>> +
>> +    return rdtsc_ordered();
>> +}
>> +
>> +BTF_SET8_START(tsc_bpf_kfunc_ids)
>> +BTF_ID_FLAGS(func, bpf_rdtsc)
>> +BTF_SET8_END(tsc_bpf_kfunc_ids)
>> +
>> +static const struct btf_kfunc_id_set tsc_bpf_kfunc_set = {
>> +    .owner        = THIS_MODULE,
>> +    .set        = &tsc_bpf_kfunc_ids,
>> +};
>> +
>>   void __init tsc_init(void)
>>   {
>>       if (!cpu_feature_enabled(X86_FEATURE_TSC)) {
>> @@ -1594,6 +1615,8 @@ void __init tsc_init(void)
>>         clocksource_register_khz(&clocksource_tsc_early, tsc_khz);
>>       detect_art();
>> +
>> +    register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, 
>> &tsc_bpf_kfunc_set);
>
> register_btf_kfunc_id_set() could fail, maybe you at least wants to
> have a warning so bpf prog users may be aware that kfunc bpf_rdtsc()
> not really available to bpf programs?

Yes, I'll add a warning print.

-Tero

>
>>   }
>>     #ifdef CONFIG_SMP
