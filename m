Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E2D41637A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 18:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhIWQmj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 12:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53316 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242076AbhIWQm3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 12:42:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632415257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zP+bWc/dUYs2mSzQjaFxDbmITT9MtxhTtHRPh17NjHA=;
        b=cseyJwBy/WlO55bKikQ/s6GlUBARdmtveZARYsxMR15I8aq8WyRdMrC77nu7W8q2GoG6aN
        LKP6rk88nIy6M/lbMFHP3iKYvy6ju0AWHQNcty+0pZ1FbUUGi5g74rJPHHz+b8p0/nkGNS
        WGs3n6JcIbfRSpSM4IFHM4fEeWTdxMw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-205-XdAf9EHsNbie57KGGkvBxQ-1; Thu, 23 Sep 2021 12:40:56 -0400
X-MC-Unique: XdAf9EHsNbie57KGGkvBxQ-1
Received: by mail-ej1-f69.google.com with SMTP id v19-20020a170906b013b02905b2f1bbf8f3so109588ejy.6
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 09:40:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zP+bWc/dUYs2mSzQjaFxDbmITT9MtxhTtHRPh17NjHA=;
        b=XB6OIRyGTPPRhQFVAj4WyjrNkd51JnrCbSiA0DtM753c6MUAi5BwKeM39v/fud/yan
         fgnCjZJEQWgghMSdyXURQxu7DumhdLS1d5GrSMnHpTEvGo6c5maqC0oNRawXVj7B+7TF
         +65GcQp2S33Dtdy9tIxMKiRHaKmcQDBrrZobXJALAtr79X6aYffQ5C3ar3o8E82gFZPf
         lbBk/rTNXWlJjzUdzfH5Y4Ft8a82acmXL+jomOQcgvijsXmFfqc7st+kKS8hZx3uVpe6
         CblrefhZ9nes48J9Vl9SHzn2EmAo892qf+qWyJGYWCQbgm4e2mGPH+VcG05v6JT6RnTG
         mWag==
X-Gm-Message-State: AOAM531qo3CuXNs9OMktGkNETqUQlENps8/YHFlAoNprUAANodD3yQ6g
        8DHsNJEjtFt9worDI9ll1jPr42xsQnd8i+w7jn5Av1qdmKExgD3jA1hb8MJeDbAoK8pJnZgOQPf
        O4xWokEAtcV7CDs1/apSMSTk1b96H
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr6246842eji.261.1632415255514;
        Thu, 23 Sep 2021 09:40:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzA3H1NEO39c84G7G9Gxn0iDSuQcLqjCEqbpf1IdiajRyX3HzH0gKAc7QxjqWRW/ttMCGcB5A==
X-Received: by 2002:a17:906:2ed1:: with SMTP id s17mr6246826eji.261.1632415255330;
        Thu, 23 Sep 2021 09:40:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id kx17sm3255053ejc.51.2021.09.23.09.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:40:54 -0700 (PDT)
Subject: Re: [PATCH 06/14] KVM: x86: SVM: don't set VMLOAD/VMSAVE intercepts
 on vCPU reset
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
 <20210914154825.104886-7-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7289d070-152b-aece-1302-33e5a461657c@redhat.com>
Date:   Thu, 23 Sep 2021 18:40:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-7-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> commit adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD"),
> made init_vmcb set vmload/vmsave intercepts unconditionally,
> and relied on svm_vcpu_after_set_cpuid to clear them when possible.
> 
> However init_vmcb is also called when the vCPU is reset, and it is
> not followed by another call to svm_vcpu_after_set_cpuid because
> the CPUID is already set.
> 
> This mistake makes the VMSAVE/VMLOAD intercept to be set when
> it is not needed, and harms performance of the nested guest.
> 
> Fixes: adc2a23734ac ("KVM: nSVM: improve SYSENTER emulation on AMD")
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/svm.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 6645542df9bd..861ac9f74331 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1199,8 +1199,6 @@ static void init_vmcb(struct kvm_vcpu *vcpu)
>   	svm_set_intercept(svm, INTERCEPT_SHUTDOWN);
>   	svm_set_intercept(svm, INTERCEPT_VMRUN);
>   	svm_set_intercept(svm, INTERCEPT_VMMCALL);
> -	svm_set_intercept(svm, INTERCEPT_VMLOAD);
> -	svm_set_intercept(svm, INTERCEPT_VMSAVE);
>   	svm_set_intercept(svm, INTERCEPT_STGI);
>   	svm_set_intercept(svm, INTERCEPT_CLGI);
>   	svm_set_intercept(svm, INTERCEPT_SKINIT);
> @@ -1377,6 +1375,10 @@ static int svm_create_vcpu(struct kvm_vcpu *vcpu)
>   	svm->guest_state_loaded = false;
>   
>   	svm_switch_vmcb(svm, &svm->vmcb01);
> +
> +	svm_set_intercept(svm, INTERCEPT_VMLOAD);
> +	svm_set_intercept(svm, INTERCEPT_VMSAVE);
> +
>   	init_vmcb(vcpu);
>   
>   	svm_vcpu_init_msrpm(vcpu, svm->msrpm);
> 

This needs to be redone after the latest refactoring of svm_vcpu_reset. 
  I'll send a patch myself.

Paolo

