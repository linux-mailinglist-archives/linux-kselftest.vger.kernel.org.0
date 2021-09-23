Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1DBE41607A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241440AbhIWOGd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 10:06:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45899 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241386AbhIWOGc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 10:06:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632405901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VsAts9Q4cwqRnECWV/CpOEJx7x5ko4DvOI5TTEhPoyU=;
        b=HWe+CtaXpnMiGrX/XPJN+jstMirnjbwFvGJab+bWnNjJRVKHefGBhVd6/9Vi0HOLGP/Vzf
        xbMGWFAveHzldwPewFEUUdo1qtgZavLpqtIPJsOICGzUqbLarNRqqjgMgqdMSkzKfW1p2B
        WFVcbE9BK5aLwABGbJtE05cCILVCCfU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-k4UHuHBJPw-mVzD83QWIdg-1; Thu, 23 Sep 2021 10:04:59 -0400
X-MC-Unique: k4UHuHBJPw-mVzD83QWIdg-1
Received: by mail-wr1-f70.google.com with SMTP id z2-20020a5d4c82000000b0015b140e0562so5247182wrs.7
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 07:04:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VsAts9Q4cwqRnECWV/CpOEJx7x5ko4DvOI5TTEhPoyU=;
        b=4mE67Vq2DgCMAP9RaWUbEapSGjeYklK7BXY8uJTZI8k0W5trdCBrt4c1wINfLDkRHC
         DT1tuH1RlzKAr2xZgH+jII6vKQiqBRwFfHFbIkxRdisDOIa5bevi84W1wMReXp0yIJzH
         lDBsPifoiYa4GrGu7EATFXUGQttcksQq9GUAeXLV+gekt6s/2DPibbt5y2O9KIe2TtUu
         2AUzR46JELdCZ1xs36hzPncQQdnZo0S32BfiHwI/EQCLt1jV6I63X+PSjjALN05kf9Xy
         PpdBZguIo2j/xwYuJP8NEJziLkTwKR1CJQFIMwiqu4+Y4ZbyMp+3eZ2HZDkmFi1R4+8/
         EKhw==
X-Gm-Message-State: AOAM533q8YvWlMDp/Ag+EQULnC3ccsDZsKIseYcEiOe+1+w/oHCQ7C9G
        6oQFJx5PGFrohXaYkUofFRaKPGhT4vS9BGTCjaPTrXYINx2nAIC+wDGVvbaS9qyLicdnMIHhwnN
        zJwAiDKw7HiTc5tmX5FweWOZ1vcq2
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr16758898wmg.88.1632405898434;
        Thu, 23 Sep 2021 07:04:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxmPeUhckrz1cu6qABX4N/FH2VAW6CuQg+dvlzGXvc88NpDgdsJEVUaRU+ivTZuzMNimKwCg==
X-Received: by 2002:a05:600c:2046:: with SMTP id p6mr16758789wmg.88.1632405897446;
        Thu, 23 Sep 2021 07:04:57 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id e28sm5656512wrc.10.2021.09.23.07.04.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 07:04:56 -0700 (PDT)
Subject: Re: [PATCH 01/14] KVM: x86: nSVM: restore int_vector in
 svm_clear_vintr
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
 <20210914154825.104886-2-mlevitsk@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9c368022-aee6-3790-2c43-28035c7e44e6@redhat.com>
Date:   Thu, 23 Sep 2021 16:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-2-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> In svm_clear_vintr we try to restore the virtual interrupt
> injection that might be pending, but we fail to restore
> the interrupt vector.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>   arch/x86/kvm/svm/svm.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 05e8d4d27969..b2e710a3fff6 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -1566,6 +1566,8 @@ static void svm_clear_vintr(struct vcpu_svm *svm)
>   
>   		svm->vmcb->control.int_ctl |= svm->nested.ctl.int_ctl &
>   			V_IRQ_INJECTION_BITS_MASK;
> +
> +		svm->vmcb->control.int_vector = svm->nested.ctl.int_vector;
>   	}
>   
>   	vmcb_mark_dirty(svm->vmcb, VMCB_INTR);
> 

Queued, thanks.

Paolo

