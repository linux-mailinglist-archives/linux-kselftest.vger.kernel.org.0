Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCE16CB454
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Mar 2023 04:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjC1Cui (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 27 Mar 2023 22:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232609AbjC1Cug (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 27 Mar 2023 22:50:36 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFE72717;
        Mon, 27 Mar 2023 19:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679971833; x=1711507833;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n2VgJtM3YVLe97n6BZzoF1luNuCvu30L97QOFMLacDY=;
  b=flkTSjEIMCkAELkoxNu4Fr9Ib3n2TPg6r7PYemwLFSNmg/6E4vCicolH
   Y5RQFm3M7G+uoh3LSk0HTHvypwYib6wkTuUZVcIClfKwko1E7i0aD6DB5
   KLC8Qo+ctOft5OIqYvBFmhF4kjd6D5OaNO9c5ySL3ngwEkilh8WA0uCD7
   GGh9qIdDPoRWVupGSgASvEgUZR3gsnAraSQ3EOEIsyDEcsDyiQvWgFdiS
   iEzzRUHmSnA7KVq1q20PtdIkXLaTMV/AXhHMJMTSjyK/5Wq4dS8LCrYz7
   zsRQn4/T4qXc+VesJu0rrmtqyVY50CDfgxu3J2R2zVYqbrI0OdfJto8DC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="337955448"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="337955448"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:50:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10662"; a="772963850"
X-IronPort-AV: E=Sophos;i="5.98,296,1673942400"; 
   d="scan'208";a="772963850"
Received: from arshowal-mobl1.amr.corp.intel.com (HELO [10.212.227.9]) ([10.212.227.9])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2023 19:50:31 -0700
Message-ID: <c49727dc-1fe8-2214-07c7-e3be269030af@linux.intel.com>
Date:   Mon, 27 Mar 2023 19:50:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Luck, Tony" <tony.luck@intel.com>, "Du, Fan" <fan.du@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20230326062039.341479-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230326062039.341479-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <3c88945515eba868056906f4a269e6ffcf49e1ec.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <3c88945515eba868056906f4a269e6ffcf49e1ec.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Kai,

On 3/27/23 7:38 PM, Huang, Kai wrote:
>> +/* Reserve an IRQ from x86_vector_domain for TD event notification */
>> +static int __init tdx_event_irq_init(void)
>> +{
>> +	struct irq_alloc_info info;
>> +	cpumask_t saved_cpumask;
>> +	struct irq_cfg *cfg;
>> +	int cpu, irq;
>> +
>> +	if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +		return 0;
>> +
>> +	init_irq_alloc_info(&info, NULL);
>> +
>> +	/*
>> +	 * Event notification vector will be delivered to the CPU
>> +	 * in which TDVMCALL_SETUP_NOTIFY_INTR hypercall is requested.
>> +	 * So set the IRQ affinity to the current CPU.
>> +	 */
>> +	cpu = get_cpu();
>> +	cpumask_copy(&saved_cpumask, current->cpus_ptr);
>> +	info.mask = cpumask_of(cpu);
>> +	put_cpu();
> The 'saved_cpumask' related code is ugly.  If you move put_cpu() to the end of
> this function, I think you can remove all related code:
> 
> 	cpu = get_cpu();
> 
> 	/*
> 	 * Set @info->mask to local cpu to make sure a valid vector is
> 	 * pre-allocated when TDX event notification IRQ is allocated
> 	 * from x86_vector_domain.
> 	 */
> 	init_irq_alloc_info(&info, cpumask_of(cpu));
> 
> 	// rest staff: request_irq(), hypercall ...
> 
> 	put_cpu();
> 	

init_irq_alloc_info() is a sleeping function. Since get_cpu() disables
preemption, we cannot call sleeping function after it. Initially, I
have implemented it like you have mentioned. However, I discovered the
following error.

[    2.400755] BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
[    2.404664] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1, name: swapper/0
[    2.408671] preempt_count: 1, expected: 0
[    2.412650] RCU nest depth: 0, expected: 0
[    2.412666] no locks held by swapper/0/1.
[    2.416650] Preemption disabled at:
[    2.416650] [<ffffffff83b8089f>] tdx_arch_init+0x38/0x117
[    2.420670] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 6.1.0-rc4-00117-g672ca073d9f9-dirty #2527
[    2.424650] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
[    2.424650] Call Trace:
[    2.424650]  <TASK>
[    2.424650]  dump_stack_lvl+0x6a/0x86
[    2.424650]  __might_resched.cold+0xf4/0x12f
[    2.424650]  __mutex_lock+0x50/0x810
[    2.424650]  ? lock_is_held_type+0xd8/0x130
[    2.424650]  ? __irq_alloc_descs+0xcf/0x310
[    2.424650]  ? find_held_lock+0x2b/0x80
[    2.424650]  ? __irq_alloc_descs+0xcf/0x310
[    2.424650]  __irq_alloc_descs+0xcf/0x310
[    2.424650]  irq_domain_alloc_descs.part.0+0x49/0xa0
[    2.424650]  __irq_domain_alloc_irqs+0x2a0/0x4f0
[    2.424650]  ? next_arg+0x129/0x1f0
[    2.424650]  ? tdx_guest_init+0x5b/0x5b
[    2.424650]  tdx_arch_init+0x8e/0x117
[    2.424650]  do_one_initcall+0x137/0x2ec
[    2.424650]  ? rcu_read_lock_sched_held+0x36/0x60
[    2.424650]  kernel_init_freeable+0x1e3/0x241
[    2.424650]  ? rest_init+0x1a0/0x1a0
[    2.424650]  kernel_init+0x17/0x170
[    2.424650]  ? rest_init+0x1a0/0x1a0
[    2.424650]  ret_from_fork+0x1f/0x30
[    2.424650]  </TASK>
-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
