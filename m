Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7C7664045
	for <lists+linux-kselftest@lfdr.de>; Tue, 10 Jan 2023 13:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238245AbjAJMTZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 10 Jan 2023 07:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238361AbjAJMSU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 10 Jan 2023 07:18:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3DB1CB2B
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 04:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673353011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/VBegRFUI9M946r5K4XKBTlecjNtq9+i9FsUOMeXf0I=;
        b=A8bMxJiE/XL3j6vBFB5eGWUjp1PpRCdt4axVFNCPQWcFsGxUugV6ttxI527NBsUmGTCgpV
        Ma4OKY0YENos/sFxOkcdj9IF60puz22mng083P/icadU8M+vGGGHgA03Mt/8i7NN+osF8z
        IcvM9jdkgHr3F7/aTn+rqrHG+Jh/zXA=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-488-NTHtqzWuN3ugGNtDmi21hg-1; Tue, 10 Jan 2023 07:16:50 -0500
X-MC-Unique: NTHtqzWuN3ugGNtDmi21hg-1
Received: by mail-ua1-f72.google.com with SMTP id o43-20020ab0596e000000b0038421e4c7deso5432222uad.19
        for <linux-kselftest@vger.kernel.org>; Tue, 10 Jan 2023 04:16:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/VBegRFUI9M946r5K4XKBTlecjNtq9+i9FsUOMeXf0I=;
        b=nQBkHgZmjq7WN+Uny75JOzsN9F8NuacxmBxhDACpdJdReB3XgFCeEdv87uwmvZSzSm
         yt5I+Z/IYjtw/aluTrWLcjg2E+/H/Ggvl2yv0TFSmO3h0i7hWUMxjPgAx45wDrp6Y/hO
         +uQWsrK6Nlej8xz7v/xpFCyhttDJBcyYzN2MHpNJC7q9/JZnpfTGE7ML/ytWFXhivLHj
         31Uf0nLDGPoa2Yr+js3ucIIH52sChnbju7juNUvm3CGssZ+WYHpE5ih9EcFB6UNW9IhC
         Gbb+cw9v93/g5sCqC7ceB58+JvKQ4gjfapAzMen2e2T6VYYeaY//8WJahkaxpROVnde3
         naQg==
X-Gm-Message-State: AFqh2koMJDyhlM4sdAegpfr//2NFRmNZohYQa7+musulv7MboXUgxlXJ
        5wUvbPLh9p9ZcxM0g7QeIiEL3VlrvAJ4TXthxVzXD89KbscFhBj3UwjC4ZsBJ+8V5R1eLZxVuvb
        FW93nF6L2gU+rk1sn4XsKEX+a00O7
X-Received: by 2002:a67:f455:0:b0:3ca:6d6b:bcaf with SMTP id r21-20020a67f455000000b003ca6d6bbcafmr26834244vsn.29.1673353009740;
        Tue, 10 Jan 2023 04:16:49 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuUTKcI/fRyAlKDhNxr3HKrEFM4cjfX+H6/x9o1D6WHwkRTwjoaVbwT1FFiguCw9h2GsrAX8g==
X-Received: by 2002:a67:f455:0:b0:3ca:6d6b:bcaf with SMTP id r21-20020a67f455000000b003ca6d6bbcafmr26834220vsn.29.1673353009415;
        Tue, 10 Jan 2023 04:16:49 -0800 (PST)
Received: from [192.168.149.123] (58.254.164.109.static.wline.lns.sme.cust.swisscom.ch. [109.164.254.58])
        by smtp.gmail.com with ESMTPSA id bm39-20020a05620a19a700b00704d8ad2e11sm7001400qkb.42.2023.01.10.04.16.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 04:16:48 -0800 (PST)
Message-ID: <5664d006-9452-2033-5605-48aa0ee77ca8@redhat.com>
Date:   Tue, 10 Jan 2023 13:16:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [RFC PATCH 1/2] KVM: x86: update APIC_ID also when disabling
 x2APIC in kvm_lapic_set_base
To:     Sean Christopherson <seanjc@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Content-Language: de-CH
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
In-Reply-To: <Y7w/bYP4VGqoVcjH@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org



Am 09/01/2023 um 17:23 schrieb Sean Christopherson:
> On Mon, Jan 09, 2023, Maxim Levitsky wrote:
>> On Mon, 2023-01-09 at 08:06 -0500, Emanuele Giuseppe Esposito wrote:
>>> If KVM_SET_MSR firstly enables and then disables x2APIC, make sure
>>> APIC_ID is actually updated correctly, since bits and offset differ from
>>> xAPIC and x2APIC.
>>>
>>> Currently this is not handled correctly, as kvm_set_apic_base() will
>>> have msr_info->host_initiated, so switching from x2APIC to xAPIC won't
>>> fail, but kvm_lapic_set_base() does not handle the case.
>>>
>>> Fixes: 8d860bbeedef ("kvm: vmx: Basic APIC virtualization controls have three settings")
>>> Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
>>> ---
>>>  arch/x86/kvm/lapic.c | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
>>> index 4efdb4a4d72c..df0a50099aa2 100644
>>> --- a/arch/x86/kvm/lapic.c
>>> +++ b/arch/x86/kvm/lapic.c
>>> @@ -2394,8 +2394,12 @@ void kvm_lapic_set_base(struct kvm_vcpu *vcpu, u64 value)
>>>  		}
>>>  	}
>>>  
>>> -	if (((old_value ^ value) & X2APIC_ENABLE) && (value & X2APIC_ENABLE))
>>> -		kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
>>> +	if ((old_value ^ value) & X2APIC_ENABLE) {
>>> +		if (value & X2APIC_ENABLE)
>>> +			kvm_apic_set_x2apic_id(apic, vcpu->vcpu_id);
>>> +		else
>>> +			kvm_apic_set_xapic_id(apic, vcpu->vcpu_id);
>>> +	}
>>>  
>>>  	if ((old_value ^ value) & (MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE)) {
>>>  		kvm_vcpu_update_apicv(vcpu);
>>
>>
>> I don't think that this patch is 100% needed in a strict sense, but I don't
>> object to it either.
> 
> I'd prefer not to go this route, I assume/suspect there's a diffferent underlying
> issue that is the real problem.
> 
>> The switch between x2apic and xapic mode is not allowed by X86 spec, while
>> vise versa is allowed and I think that the spec says that in this case APIC
>> ID is restored to its default value.
> 
> No, APIC ID is initialized on RESET, but AFAIK it's preserved for all other
> transitions.  It's definitely preserved on INIT (doesn't touch the enable bit),
> and this snippet from the SDM more or less says the APIC ID is preserved when it's
> disabled in IA32_APIC_BASE.
> 
>   From the disabled state, the only valid x2APIC transition using IA32_APIC_BASE
>   is to the xAPIC mode (EN= 1, EXTD = 0). Thus the only means to transition from
>   x2APIC mode to xAPIC mode is a two-step process:
> 
>    - first transition from x2APIC mode to local APIC disabled mode (EN= 0, EXTD = 0),
>    - followed by another transition from disabled mode to xAPIC mode (EN= 1, EXTD= 0).
> 
>   Consequently, all the APIC register states in the x2APIC, except for the x2APIC ID
>   (32 bits), are not preserved across mode transitions.
> 
> And for RESET vs. INIT
> 
>   A reset in this state places the x2APIC in xAPIC mode. All APIC registers
>   (including the local APIC ID register) are initialized as described in Section
>   10.12.5.1.
> 
>   An INIT in this state keeps the x2APIC in the x2APIC mode. The state of the
>   local APIC ID register is preserved (all 32 bits). However, all the other APIC
>   registers are initialized as a result of the INIT transition.
> 
> Emanuele, what is the actual issue you are trying to fix?  E.g. is APICv left
> inihibited after an emulated RESET?  Something else?

I think the test in patch 2 I wrote gives a better idea on what I am
trying to fix: if we are transitioning from x2APIC to xAPIC (RESET I
would say, even though I am not sure if userspace really does it in the
way I do it in the test, ie through KVM_SET_MSRS), the APIC_ID is not
updated back in the right bits, and we can see that by querying the ID
with KVM_GET_LAPIC after disabling x2APIC.

Now, if the way I reproduce this issue is correct, it is indeed a bug
and needs to be fixed with the fix in patch 1 or something similar.
I think it won't really make any difference if instead following what
the doc says (x2APIC -> disabled -> xAPIC) we directly do x2APIC -> xAPIC.

The test in patch 2 started being developed to test ef40757743b47 ("KVM:
x86: fix APICv/x2AVIC disabled when vm reboot by itself") even though I
honestly didn't really understand how to replicate that bug (see cover
letter) and instead I found this other possibility that still manages to
screw APIC_ID.

Hope this clarifies it a little,
Emanuele

  Stuffing APIC state from
> userspace should do the right thing after commit ef40757743b4 ("KVM: x86: fix
> APICv/x2AVIC disabled when vm reboot by itself") and this patch:
> 
>   https://lore.kernel.org/all/20230106011306.85230-33-seanjc@google.com
> 

