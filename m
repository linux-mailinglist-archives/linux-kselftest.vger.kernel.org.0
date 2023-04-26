Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98476EEE0A
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Apr 2023 08:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbjDZGID (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 26 Apr 2023 02:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239315AbjDZGIC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 26 Apr 2023 02:08:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D13F2D50;
        Tue, 25 Apr 2023 23:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682489247; x=1714025247;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=KFNleya7xt94i466EISgoBljuoJrw5ZOHnzA6qkSr10=;
  b=DrpJqvGRL80jT52KUS+8PR9sJ5knlUNda9lj/6QfcZcCcWPM8wCJ5r+j
   jCGg+hVG5tZVn8h0JPyyiOQ9xouDqaGnQKEnPXF2CM0mnsYWs/EHEad1b
   EqDefloCUyxM6oNNj4FbpQW8gyQGflHzRIb3VG8LP/DNWOUlgbXPfDAOb
   stSs2txt7BE/+VcrAvfzDAUTFjxxeW/Fuc3vk3RFXB23qqDaOOLAV++aV
   0rTm70L8wuy9JBeelzZqBaOjAZAfYZqRHwPJimhpPBEQrMFIX/9Ei02AU
   NWZowwY4yOh4b9teXx7K0XXCGgCwaZAHYS9IY2DhFfcLEHr84TmjNjlcE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="326618284"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="326618284"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 23:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10691"; a="817987264"
X-IronPort-AV: E=Sophos;i="5.99,227,1677571200"; 
   d="scan'208";a="817987264"
Received: from mmhacket-mobl.amr.corp.intel.com (HELO [10.209.15.30]) ([10.209.15.30])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2023 23:07:18 -0700
Message-ID: <80718d6c-9e53-d549-bfe2-6c10d618acb1@linux.intel.com>
Date:   Tue, 25 Apr 2023 23:07:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/3] x86/tdx: Add TDX Guest event notify interrupt
 support
Content-Language: en-US
To:     "Huang, Kai" <kai.huang@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "shuah@kernel.org" <shuah@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>
Cc:     "Yu, Guorui" <guorui.yu@linux.alibaba.com>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "wander@redhat.com" <wander@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "chongc@google.com" <chongc@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "qinkun@apache.org" <qinkun@apache.org>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Aktas, Erdem" <erdemaktas@google.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Du, Fan" <fan.du@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20230413034108.1902712-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20230413034108.1902712-2-sathyanarayanan.kuppuswamy@linux.intel.com>
 <632a9a27abb5da053caedbbc6bcb7d5e15b2322c.camel@intel.com>
 <0da37de8-6036-f475-d80d-92c77fb7cbaa@linux.intel.com>
 <40b6ca5df5988305fea734e559fe5c8b3a22df78.camel@intel.com>
From:   Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <40b6ca5df5988305fea734e559fe5c8b3a22df78.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



On 4/25/23 6:59 PM, Huang, Kai wrote:
> On Tue, 2023-04-25 at 16:47 -0700, Sathyanarayanan Kuppuswamy wrote:
>> Hi Kai,
>>
>> On 4/14/23 6:34 AM, Huang, Kai wrote:
>>> On Wed, 2023-04-12 at 20:41 -0700, Kuppuswamy Sathyanarayanan wrote:
>>>> Host-guest event notification via configured interrupt vector is useful
>>>> in cases where a guest makes an asynchronous request and needs a
>>>> callback from the host to indicate the completion or to let the host
>>>> notify the guest about events like device removal. One usage example is,
>>>> callback requirement of GetQuote asynchronous hypercall.
>>>>
>>>> In TDX guest, SetupEventNotifyInterrupt hypercall can be used by the
>>>> guest to specify which interrupt vector to use as an event-notify
>>>> vector from the VMM. Details about the SetupEventNotifyInterrupt
>>>> hypercall can be found in TDX Guest-Host Communication Interface
>>>> (GHCI) Specification, section "VP.VMCALL<SetupEventNotifyInterrupt>".
>>>>
>>>> As per design, VMM will post the event completion IRQ using the same
>>>> CPU on which SetupEventNotifyInterrupt hypercall request is received.
>>>> So allocate an IRQ vector from "x86_vector_domain", and set the CPU
>>>> affinity of the IRQ vector to the CPU on which
>>>> SetupEventNotifyInterrupt hypercall is made.
>>>>
>>>> Add tdx_register_event_irq_cb()/tdx_unregister_event_irq_cb()
>>>> interfaces to allow drivers register/unregister event noficiation
>>> 			      ^
>>> 			      to register/unregister
>>>> handlers.
>>>>
>>>>
>>>
>>> [...]
>>>
>>
>> With suggested changes, the final version looks like below.
>>
>> +/**
>> + * tdx_event_irq_init() - Register IRQ for event notification from the VMM to
>> + *                       the TDX Guest.
>> + *
>> + * Use SetupEventNotifyInterrupt TDVMCALL to register the event notification
>> + * IRQ with the VMM, which is used by the VMM to notify the TDX guest when
>> + * needed, for instance, when VMM finishes the GetQuote request from the TDX
>> + * guest. The VMM always notifies the TDX guest via the same CPU on which the
>> + * SetupEventNotifyInterrupt TDVMCALL is called. For simplicity, just allocate
>> + * an IRQ (and a vector) directly from x86_vector_domain for such notification
>> + * and pin the IRQ to the same CPU on which TDVMCALL is called.
> 
> I think "for simplicity" applies to allocate IRQ/vector "from BSP using
> early_initcall()" (so TDVMCALL is easily guaranteed to be called on the same cpu
> where vector is allocated), but doesn't apply to allocate IRQ/vector from
> x86_vector_domain and "pin the IRQ to the same CPU on which TDVMCALAL is
> called".  The latter is something you must do (otherwise you need to allocate
> the same vector on all cpus), but not something that you do "for simplicity".
> 
>> + *
>> + * Since tdx_event_irq_init() is triggered via early_initcall(), it will be
>> + * called before secondary CPUs bring up, so no special logic is required to
>> + * ensure that the same CPU is used for SetupEventNotifyInterrupt TDVMCALL and
>> + * IRQ allocation.
> 
> IMHO the second paragraph is obvious and no need to mention.
> 
> As explained above, I guess you just need to at somewhere simply mention
> something like: "for simplicity use early_initcall() to allocate and pin the
> IRQ/vector on BSP and also call the TDVMCALL on BSP".  Or probably "also call
> the TDVMCALL on BSP" can also be omitted as it's kinda already explained in the
> nature of the TDVMCALL.

How about the following?

Use SetupEventNotifyInterrupt TDVMCALL to register the event notification
IRQ with the VMM, which is used by the VMM to notify the TDX guest when
needed, for instance, when VMM finishes the GetQuote request from the TDX
guest. The VMM always notifies the TDX guest via the same CPU that calls the
SetupEventNotifyInterrupt TDVMCALL. Allocate an IRQ/vector from the
x86_vector_domain and pin it on the same CPU on which TDVMCALL is called.
For simplicity, use early_initcall() to allow both IRQ allocation and
TDVMCALL to use BSP.

> 
>> + */
>> +static int __init tdx_event_irq_init(void)
>> +{
>> +       struct irq_affinity_desc desc;
>> +       struct irq_alloc_info info;
>> +       struct irq_cfg *cfg;
>> +       int irq;
>> +
>> +       if (!cpu_feature_enabled(X86_FEATURE_TDX_GUEST))
>> +               return 0;
>> +
>> +       init_irq_alloc_info(&info, NULL);
>> +
>> +       cpumask_set_cpu(smp_processor_id(), &desc.mask);
>> +
>> +       irq = __irq_domain_alloc_irqs(x86_vector_domain, -1, 1, cpu_to_node(0),
> 
> cpu_to_node(smp_processor_id())?
> 
>> +                                     &info, false, &desc);
>> +       if (irq <= 0) {
>> +               pr_err("Event notification IRQ allocation failed %d\n", irq);
>> +               return -EIO;
>> +       }
>> +
>> +       irq_set_handler(irq, handle_edge_irq);
>> +
>> +       /*
>> +        * The IRQ cannot be migrated because VMM always notifies the TDX
>> +        * guest on the same CPU on which the SetupEventNotifyInterrupt
>> +        * TDVMCALL is called. Set the IRQ with IRQF_NOBALANCING to prevent
>> +        * its affinity from being changed.
>> +        */
>> +       if (request_irq(irq, tdx_event_irq_handler, IRQF_NOBALANCING,
>> +                       "tdx_event_irq", NULL)) {
>> +               pr_err("Event notification IRQ request failed\n");
>> +               goto err_free_domain_irqs;
>> +       }
>> +
>> +       cfg = irq_cfg(irq);
>> +
>> +       if (_tdx_hypercall(TDVMCALL_SETUP_NOTIFY_INTR, cfg->vector, 0, 0, 0)) {
>> +               pr_err("Event notification hypercall failed\n");
>> +               goto err_free_irqs;
>> +       }
>> +
>> +       tdx_event_irq = irq;
>> +
>> +       return 0;
>> +
>> +err_free_irqs:
>> +       free_irq(irq, NULL);
>> +err_free_domain_irqs:
>> +       irq_domain_free_irqs(irq, 1);
>> +
>> +       return -EIO;
>> +}
>> +early_initcall(tdx_event_irq_init)
>>
>>
>>
>>
>> -- 
>> Sathyanarayanan Kuppuswamy
>> Linux Kernel Developer
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
