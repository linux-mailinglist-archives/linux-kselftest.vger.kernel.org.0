Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B2C416384
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 18:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhIWQq1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 12:46:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50263 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229720AbhIWQq1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 12:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632415494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b3cKL1JgUfD96S3aQcdHQmja5cYQo5swp49YUwIJl7I=;
        b=bO63ql8IsBfC77Kbltn67ug5poqZUc4QhoWJVzm6xZ9g2CWfRf+iA5ScBPrOjom6kWNk8v
        QzZzypwPk5Zt4dnMOoyYZ/l/fKv823FOTciY104AJxsl33scadjPOBw8+fxxyean34s2cH
        roKBWBYCLxBshQ7EeK6qjo7wg7xPqmY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-544-alDzy9GdMTajFSPtA_Olag-1; Thu, 23 Sep 2021 12:44:53 -0400
X-MC-Unique: alDzy9GdMTajFSPtA_Olag-1
Received: by mail-ej1-f71.google.com with SMTP id k9-20020a17090632c900b005f9b0473b44so115655ejk.8
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 09:44:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b3cKL1JgUfD96S3aQcdHQmja5cYQo5swp49YUwIJl7I=;
        b=QnXZC0RP/RQtBv2lFLChgeGXkWKLVWlwSb8nLk0S1D/nLEAbgaeVKGREYKlSTV4ch3
         69e3j/+d6cBzVRjwSBSb3wPdC6vsyvTyN3Di/a/O8/glCwgnTapx060/2MI/U5KLovw2
         kL+qzNJdhplAvXYcYDqwi3S3hNxyYPUfbZsk3sD7B7fLcPWhZT+rM0kscVE7DuDUj/Yp
         aSWWnpsLnOEWlliMy2t7DEgOd/sPrDbuyYYrDa45D+V7GK+V7XvGQP2vYErt/OEQrlxi
         HL9SrKiP9mMRt/lchBOEWf2eQWMNVOw5+hu0U0MpSAp0xZu5igIv/VrYL4WrNqQXSca/
         lQog==
X-Gm-Message-State: AOAM530QDGCNkIc3o00glv+W/gDndL0ed+CJ3tG0uwRyq9rTXkMn2EwA
        6DK89MUAs0brMI1QgRy39Ie4YC4RpKIGxZVBxaA4c1V/cjXuY+BINLyLf52tWGS7Qsakew7oRCR
        HYqvcufi2YyZoYtwtr420JhmMjbVj
X-Received: by 2002:a05:6402:1352:: with SMTP id y18mr6644383edw.122.1632415492645;
        Thu, 23 Sep 2021 09:44:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzb0pdd2zsBYxzBKuRqu8tLTqE1ME1zAUyb78G1o0tA1cydtDx/eqtKTicaBwcf1AOWQhgWOg==
X-Received: by 2002:a05:6402:1352:: with SMTP id y18mr6644353edw.122.1632415492426;
        Thu, 23 Sep 2021 09:44:52 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id g9sm3414971ejo.60.2021.09.23.09.44.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:44:51 -0700 (PDT)
Subject: Re: [PATCH 07/14] KVM: x86: SVM: add warning for CVE-2021-3656
To:     Maxim Levitsky <mlevitsk@redhat.com>, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Borislav Petkov <bp@alien8.de>, Bandan Das <bsd@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Wei Huang <wei.huang2@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Wanpeng Li <wanpengli@tencent.com>
References: <20210914154825.104886-1-mlevitsk@redhat.com>
 <20210914154825.104886-8-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f0c0e659-23a8-59ab-edf8-5b380d723493@redhat.com>
Date:   Thu, 23 Sep 2021 18:44:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-8-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> Just in case, add a warning ensuring that on guest entry,
> either both VMLOAD and VMSAVE intercept is enabled or
> vVMLOAD/VMSAVE is enabled.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/svm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 861ac9f74331..deeebd05f682 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3784,6 +3784,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>   
>   	WARN_ON_ONCE(kvm_apicv_activated(vcpu->kvm) != kvm_vcpu_apicv_active(vcpu));
>   
> +	/* Check that CVE-2021-3656 can't happen again */
> +	if (!svm_is_intercept(svm, INTERCEPT_VMSAVE) ||
> +	    !svm_is_intercept(svm, INTERCEPT_VMSAVE))
> +		WARN_ON(!(svm->vmcb->control.virt_ext &
> +			  VIRTUAL_VMLOAD_VMSAVE_ENABLE_MASK));
> +
>   	sync_lapic_to_cr8(vcpu);
>   
>   	if (unlikely(svm->asid != svm->vmcb->control.asid)) {
> 

While it's nice to be "proactive", this does adds some extra work. 
Maybe it should be under CONFIG_DEBUG_KERNEL.  It could be useful to 
make it into its own function so we can add similar intercept invariants 
in the same place.

Paolo

