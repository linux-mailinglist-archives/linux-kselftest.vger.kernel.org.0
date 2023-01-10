Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3BA6644DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 16:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjAJPbf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 10:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239046AbjAJPav (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 10:30:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B64872BD
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 07:29:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673364589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2YvoBqBHM/H9ePkUgnHNUObktHoE/7HQpdnLYVnf5Yw=;
        b=R26UXAoTK4VCSU4MBWXK10DgSgyGbQj7yqqp87my82vPMJIbBmhRQHPGn2OfT5scTbVIoK
        1yx+zBRm2b+Cuw0i0F6TFkuyiJQgBuuANH/MzPMmUIbOXf8xzc2QuZlnICoDlmTtPHqgSD
        /n2IXT8wqqD8DMYAh0mYZWVSzUUNjQk=
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-455-BRqGRZAiNr-JzuPDhD83jQ-1; Tue, 10 Jan 2023 10:29:47 -0500
X-MC-Unique: BRqGRZAiNr-JzuPDhD83jQ-1
Received: by mail-ua1-f70.google.com with SMTP id y19-20020ab048d3000000b004397143cdfeso5480632uac.2
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 07:29:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YvoBqBHM/H9ePkUgnHNUObktHoE/7HQpdnLYVnf5Yw=;
        b=Ovd89jgMqh0hlqTLC+YS/boaC5JIvhqKyuNG/lA+ImwkcDfRGhxaX8AxYpBczfdZC2
         8jetE+sgzqm4zZKXIi+ctGBQ0d4IYvSI11wR3Fq7Dia3O3K+LgwdD5/bvgXy1gcrSX4S
         Cd7JNemzbm0a/weVcMq8kb1/P2SVipLdFqmKurD3LNg7WgqDYbMOm4lH0sDPgEKkNtkA
         nyKOlOu5X04Br9yBBf8cpJ7qRL8dlg3hLfGGOekmVXBmhFzdUZYVMGy2mkik8HEOJ0J9
         JkcB6RNI29pKev4nDZSxDBxSEFnDK/5KcVe5gPoajAgm4/qW1lTsQ5cYrruAiA6ihNQO
         qQCw==
X-Gm-Message-State: AFqh2kos7K0h43yIvAP2ruwIOuMy2Y7OvjFd29lcoSGMpIi5kcnrRqBy
        dsXQVulRwwLy7PlQKzJnc+tOiulqXitu+6TKun81BYUjFchwU7sa92eGJoh4zsJ+iaQhUQi2wwz
        KY/werdC/MfOlFImqtIadssWbkaGA
X-Received: by 2002:a67:eb83:0:b0:3ce:9b05:89e1 with SMTP id e3-20020a67eb83000000b003ce9b0589e1mr17048904vso.13.1673364587023;
        Tue, 10 Jan 2023 07:29:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvkQG0C/xocySi6sYM8GJiBnFTDTumMw7Qc2QPzq9kgHJDBnel1Vdje88GkRqrC44xnk1RRLg==
X-Received: by 2002:a67:eb83:0:b0:3ce:9b05:89e1 with SMTP id e3-20020a67eb83000000b003ce9b0589e1mr17048875vso.13.1673364586748;
        Tue, 10 Jan 2023 07:29:46 -0800 (PST)
Received: from [192.168.149.123] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id bl19-20020a05620a1a9300b006fa9d101775sm6294279qkb.33.2023.01.10.07.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 07:29:46 -0800 (PST)
Message-ID: <6829dd22-c618-ae12-2bc6-752ea6cf6f3f@redhat.com>
Date:   Tue, 10 Jan 2023 16:29:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 1/2] KVM: x86: update APIC_ID also when disabling
 x2APIC in kvm_lapic_set_base
Content-Language: de-CH
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Gautam Menghani <gautammenghani201@gmail.com>,
        Zeng Guang <guang.zeng@intel.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230109130605.2013555-1-eesposit@redhat.com>
 <20230109130605.2013555-2-eesposit@redhat.com>
 <c61ce1a6393a108c76e53cb99249aba5ab318e07.camel@redhat.com>
 <Y7w/bYP4VGqoVcjH@google.com>
 <5664d006-9452-2033-5605-48aa0ee77ca8@redhat.com>
 <fa0758f5-abd1-ad09-3878-adf296c7aac5@redhat.com>
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <fa0758f5-abd1-ad09-3878-adf296c7aac5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Am 10/01/2023 um 15:07 schrieb Paolo Bonzini:
> On 1/10/23 13:16, Emanuele Giuseppe Esposito wrote:
>> I think the test in patch 2 I wrote gives a better idea on what I am
>> trying to fix: if we are transitioning from x2APIC to xAPIC (RESET I
>> would say, even though I am not sure if userspace really does it in the
>> way I do it in the test, ie through KVM_SET_MSRS), the APIC_ID is not
>> updated back in the right bits, and we can see that by querying the ID
>> with KVM_GET_LAPIC after disabling x2APIC.
>>
>> Now, if the way I reproduce this issue is correct, it is indeed a bug
>> and needs to be fixed with the fix in patch 1 or something similar.
>> I think it won't really make any difference if instead following what
>> the doc says (x2APIC -> disabled -> xAPIC) we directly do x2APIC ->
>> xAPIC.
> 
> Yes, the default value at reset is xAPIC mode, so a reset will do a
> KVM_SET_MSRS that clears X2APIC_ENABLE but leaves
> MSR_IA32_APICBASE_ENABLE set.
> 
> So, if I understand correctly...
> 
>> The test in patch 2 started being developed to test ef40757743b47 ("KVM:
>> x86: fix APICv/x2AVIC disabled when vm reboot by itself") even though I
>> honestly didn't really understand how to replicate that bug (see cover
>> letter) and instead I found this other possibility that still manages to
>> screw APIC_ID.
> 
> ... what you're saying is that there were two different bugs, but one
> fixing any one of them was enough to prevent the symptoms shown by
> commit ef40757743b47?  That is:
> 
> - the APICv inhibit was set by KVM_GET_LAPIC because it called
> kvm_lapic_xapic_id_updated(), and the call was unnecessary as fixed in
> commit ef40757743b47;
> 
> - however, there is no reason for the vCPU ID to be mismatched.  It
> happened because the code didn't handle the host-initiated x2APIC->xAPIC
> case and thus lacked a call to kvm_apic_set_xapic_id().
> 
> If so, I think the idea of the patch is fine.

Yes :)
> 
> Just one thing: your patch also changes the APIC_ID on the
> x2APIC->disabled transition, not just the "forbidden" (i.e. host-
> initiated only) x2APIC->xAPIC transition.  I think  this is okay too: the
> manual says:
> 
>    10.4.3 Enabling or Disabling the Local APIC
> 
>    When IA32_APIC_BASE[11] is set to 0, prior initialization to the APIC
>    may be lost and the APIC may return to the state described in Section
>    10.4.7.1, “Local APIC State After Power-Up or Reset.”
> 
>    10.4.7.1 Local APIC State After Power-Up or Reset
> 
>    ... The local APIC ID register is set to a unique APIC ID. ...
> 
> (which must be an xAPIC ID) and this is what your patch does.
> 
> In fact perhaps you can change the code further to invoke
> kvm_lapic_reset() after static_branch_inc(&apic_hw_disabled.key)? 

Ok, it makes sense. In that case we are disabling lapic (X2APIC_ENABLE
should be 0 too, otherwise it would be invalid.

xAPIC global enable(IA32_APIC_BASE[11]) | x2APIC
enable(IA32_APIC_BASE[10]) | Description
0 0 local APIC is disabled
0 1 Invalid
1 0 local APIC is enabled in xAPIC mode
1 1 local APIC is enabled in x2APIC mode

Thank you,
Emanuele

 It's
> just a bit messy that you have a call back to kvm_lapic_set_base() in
> there, so perhaps something like this can help:
> 
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4efdb4a4d72c..24e5df23a4d9 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2433,9 +2436,7 @@ void kvm_apic_update_apicv(struct kvm_vcpu *vcpu)
>  
>  void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
>  {
> -    struct kvm_lapic *apic = vcpu->arch.apic;
>      u64 msr_val;
> -    int i;
>  
>      if (!init_event) {
>          msr_val = APIC_DEFAULT_PHYS_BASE | MSR_IA32_APICBASE_ENABLE;
> @@ -2444,8 +2445,14 @@ void kvm_lapic_reset(struct kvm_vcpu *vcpu, bool
> init_event)
>          kvm_lapic_set_base(vcpu, msr_val);
>      }
>  
> -    if (!apic)
> -        return;
> +    if (vcpu->arch.apic)
> +        __kvm_lapic_reset(vcpu, init_event);
> +}
> +
> +static void __kvm_lapic_reset(struct kvm_vcpu *vcpu, bool init_event)
> +{
> +    struct kvm_lapic *apic = vcpu->arch.apic;
> +    int i;
>  
>      /* Stop the timer in case it's a reset to an active apic */
>      hrtimer_cancel(&apic->lapic_timer.timer);
> 
> 
> (just a sketch to show the idea, of course __kvm_lapic_reset would have to
> go first).
> 
> Paolo
> 

