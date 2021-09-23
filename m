Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D48B4163AD
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Sep 2021 18:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242363AbhIWQ40 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Sep 2021 12:56:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33181 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242239AbhIWQ4O (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Sep 2021 12:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632416082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0ReSgcM8F/l+G5HcK9Mo9o/CQ02oO2R9Ng8Sr4/ITM4=;
        b=HfWutbeU4gg+xxX/Chvgb7Y5MPixcVBCxrsxmbloiYRz2qIOEQM5soArd9goJlwxKKAuA1
        PMzCUfbEYO5pGJX757xnWLjWHAjyqbUa6aqMCKtRijFfc0jhS6sfRhKk46+dWCwRT17iwc
        bNoph+x5LsYS5xlkdqYNscFgufoBIbM=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-4xK00uLoN3O8Lvijng_dng-1; Thu, 23 Sep 2021 12:54:39 -0400
X-MC-Unique: 4xK00uLoN3O8Lvijng_dng-1
Received: by mail-ed1-f70.google.com with SMTP id h6-20020a50c386000000b003da01adc065so7342798edf.7
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Sep 2021 09:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0ReSgcM8F/l+G5HcK9Mo9o/CQ02oO2R9Ng8Sr4/ITM4=;
        b=pqa9euzqwGr6pFUSro4GAVVXPOCb3uEpvu396tbETV1rP/ePS9pzVv/mLIcyhxq8Tw
         WPh/kjZ3mO3ArtzUQQQmX7bIrcp0aXgWxOr6ZUYqjjoiVboTHCmvcCVgRCXQux9h8W0B
         5wlYrcnViQeM2+5ZV6CimzcMFqtLZnQR+q7CVHUXHyBA0n3itHYbLNCt0ng1sjP9avIl
         rgBiK1GPh4Inn2wELPj5Xlk/ZsIwhA1EeaP4wvgRBKtR/AyQX+WHrY7lEuAMxI8CnCx9
         QIjQtUBPjM2hRCJND+1ALnNrUfPfgeb412PLqzMtnrdMrD/Bk0du2VB6hO1+8N4FZPfy
         9ojA==
X-Gm-Message-State: AOAM530WZLGyoneMPPwnELq4H/lcIFK4YFfP2iDDGZtppDLXMBhZt+Pf
        ATRfOUlNTXTv0vkakC/QMhr+On6UuR0/w3AlX7XA77v2RqyL+Lu54lBNHiwLwDzhWhjQqH2cBjc
        kvmnmA6yep7ty0/Iege6BGIoevxFE
X-Received: by 2002:a17:906:584:: with SMTP id 4mr6200631ejn.56.1632416077494;
        Thu, 23 Sep 2021 09:54:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy5UQAxIm6jvDAIEJygeGZF/ewJKdpHxU6OT5aGqbBA5SNslschMbR9eHuS7enkJEmOlKUxtw==
X-Received: by 2002:a17:906:584:: with SMTP id 4mr6200592ejn.56.1632416077261;
        Thu, 23 Sep 2021 09:54:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b13sm4046822ede.97.2021.09.23.09.54.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Sep 2021 09:54:36 -0700 (PDT)
Subject: Re: [PATCH 00/14] nSVM fixes and optional features
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
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d04eb3d1-9f0c-3b2c-c78f-0f377caadcfc@redhat.com>
Date:   Thu, 23 Sep 2021 18:54:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210914154825.104886-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 14/09/21 17:48, Maxim Levitsky wrote:
> Those are few patches I was working on lately, all somewhat related
> to the two CVEs that I found recently.
> 
> First 7 patches fix various minor bugs that relate to these CVEs.
> 
> The rest of the patches implement various optional SVM features,
> some of which the guest could enable anyway due to incorrect
> checking of virt_ext field.
> 
> Last patch is somewhat an RFC, I would like to hear your opinion
> on that.
> 
> I also implemented nested TSC scaling while at it.
> 
> As for other optional SVM features here is my summary of few features
> I took a look at:
> 
> X86_FEATURE_DECODEASSISTS:
>     this feature should make it easier
>     for the L1 to emulate an instruction on MMIO access, by not
>     needing to read the guest memory but rather using the instruction
>     bytes that the CPU already fetched.
> 
>     The challenge of implementing this is that we sometimes inject
>     #PF and #NPT syntenically and in those cases we must be sure
>     we set the correct instruction bytes.
> 
>     Also this feature adds assists for MOV CR/DR, INTn, and INVLPG,
>     which aren't that interesting but must be supported as well to
>     expose this feature to the nested guest.
> 
> X86_FEATURE_VGIF
>     Might allow the L2 to run the L3 a bit faster, but due to crazy complex
>     logic we already have around int_ctl and vgif probably not worth it.
> 
> X86_FEATURE_VMCBCLEAN
>     Should just be enabled, because otherwise L1 doesn't even attempt
>     to set the clean bits. But we need to know if we can take an
>     advantage of these bits first.
> 
> X86_FEATURE_FLUSHBYASID
> X86_FEATURE_AVIC
>     These two features would be very good to enable, but that
>     would require lots of work, and will be done eventually.
> 
> There are few more nested SVM features that I didn't yet had a
> chance to take a look at.
> 
> Best regards,
> 	Maxim Levitsky
> 
> Maxim Levitsky (14):
>    KVM: x86: nSVM: restore int_vector in svm_clear_vintr
>    KVM: x86: selftests: test simultaneous uses of V_IRQ from L1 and L0
>    KVM: x86: nSVM: test eax for 4K alignment for GP errata workaround
>    KVM: x86: nSVM: don't copy pause related settings
>    KVM: x86: nSVM: don't copy virt_ext from vmcb12
>    KVM: x86: SVM: don't set VMLOAD/VMSAVE intercepts on vCPU reset
>    KVM: x86: SVM: add warning for CVE-2021-3656
>    KVM: x86: SVM: add module param to control LBR virtualization
>    KVM: x86: nSVM: correctly virtualize LBR msrs when L2 is running
>    KVM: x86: nSVM: implement nested LBR virtualization
>    KVM: x86: nSVM: implement nested VMLOAD/VMSAVE
>    KVM: x86: SVM: add module param to control TSC scaling
>    KVM: x86: nSVM: implement nested TSC scaling
>    KVM: x86: nSVM: support PAUSE filter threshold and count
> 
>   arch/x86/kvm/svm/nested.c                     | 105 +++++++--
>   arch/x86/kvm/svm/svm.c                        | 218 +++++++++++++++---
>   arch/x86/kvm/svm/svm.h                        |  20 +-
>   arch/x86/kvm/vmx/vmx.c                        |   1 +
>   arch/x86/kvm/x86.c                            |   1 +
>   tools/testing/selftests/kvm/.gitignore        |   1 +
>   tools/testing/selftests/kvm/Makefile          |   1 +
>   .../selftests/kvm/x86_64/svm_int_ctl_test.c   | 128 ++++++++++
>   8 files changed, 427 insertions(+), 48 deletions(-)
>   create mode 100644 tools/testing/selftests/kvm/x86_64/svm_int_ctl_test.c
> 

Queued more patches, with 9-10-11-14 left now.

Paolo

