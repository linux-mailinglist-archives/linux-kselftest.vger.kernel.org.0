Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8647E436640
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Oct 2021 17:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231819AbhJUPcG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Oct 2021 11:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47483 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231847AbhJUPcG (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Oct 2021 11:32:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634830189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z7CxwAzzEIQOd3qBht/PpbJEZOuniLXSJ6BnX0TmD6o=;
        b=PBRBFRZ5GbIYceOMDtzy9xEstNzJEhUJGWcZoabvcHGqpqDhyj3rqIVUm6PhgCsiBwlxh4
        pcc+3TSdxEeu0SQpWyX5Ym5aC7AS93yV1S38S5VNBccvE6myEGh0e7+oZRHb4A2gS+iGny
        PYVl5X7pIawWGgb5YUcl76N0v4aTYa4=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-Bq8mPUxBNiGfb08rPfOE6g-1; Thu, 21 Oct 2021 11:29:48 -0400
X-MC-Unique: Bq8mPUxBNiGfb08rPfOE6g-1
Received: by mail-ed1-f72.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso25620edn.4
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Oct 2021 08:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=z7CxwAzzEIQOd3qBht/PpbJEZOuniLXSJ6BnX0TmD6o=;
        b=f5s6AmPyD1d5pZAnrNmC96VlZRt2m8YVX0I4PE3hldk/G2fqrqqSdhdJhPeqU516qy
         4rfORiQkUv70y02f4wxjk54Ceynf0SVFClGScZ0ekmUomoYb9Chl+slMHNzMKQ0CXnWu
         SCpaPlNg3gQ4/a2y3w6PXEsuJD9UizkLGA01mUMo/TFhkBS4xzlIEs1a0xA+DpIsiD4S
         MJl548gn8yZuzrUjUSCEruRudgeBgKIH1R8ZaIDKSfpy/CfxM9RWLauPWvNxF6W8d3ho
         gT/SoLWo5wOIrC6k9tk5xqoNbbyDa+BtJYjyQPAxS7XrjRYK6EMIh/cilAdaCjoAS+xb
         plYw==
X-Gm-Message-State: AOAM532Rwhz4HnlXWmHh6V9NR5g2erxKu7DqxXNpEScVAa+JlUS4BnaG
        U0oBU3PqlOY6xXvGQABZsn0udxU5ZLgz2ncwLv0JQe2861eEqb5/iHWOiyz3X5WcadSC6xpWs0l
        mCAMTN1cpBXYK1tAxeUmCWIBWtE1d
X-Received: by 2002:a17:907:118d:: with SMTP id uz13mr8613431ejb.382.1634830187151;
        Thu, 21 Oct 2021 08:29:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLl4bnSu/ecyBFmCmqDwOSad1YN+gCMCGaznQPYg2lJHMHg0E2A02UlfEVzgzecmsH1Ik+Ww==
X-Received: by 2002:a17:907:118d:: with SMTP id uz13mr8613378ejb.382.1634830186861;
        Thu, 21 Oct 2021 08:29:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.gmail.com with ESMTPSA id ke12sm2681160ejc.32.2021.10.21.08.29.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 08:29:45 -0700 (PDT)
Message-ID: <545b753f-a11f-b6fb-2c33-49a99875d72f@redhat.com>
Date:   Thu, 21 Oct 2021 17:29:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [RFC 04/16] KVM: selftests: set CPUID before setting sregs in
 vcpu creation
Content-Language: en-US
To:     Michael Roth <michael.roth@amd.com>,
        linux-kselftest@vger.kernel.org
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        Nathan Tempelman <natet@google.com>,
        Marc Orr <marcorr@google.com>,
        Steve Rutherford <srutherford@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Mingwei Zhang <mizhang@google.com>,
        Brijesh Singh <brijesh.singh@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Varad Gautam <varad.gautam@suse.com>,
        Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Ricardo Koller <ricarkol@google.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>
References: <20211005234459.430873-1-michael.roth@amd.com>
 <20211006203617.13045-1-michael.roth@amd.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20211006203617.13045-1-michael.roth@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 06/10/21 22:36, Michael Roth wrote:
> Recent kernels have checks to ensure the GPA values in special-purpose
> registers like CR3 are within the maximum physical address range and
> don't overlap with anything in the upper/reserved range. In the case of
> SEV kselftest guests booting directly into 64-bit mode, CR3 needs to be
> initialized to the GPA of the page table root, with the encryption bit
> set. The kernel accounts for this encryption bit by removing it from
> reserved bit range when the guest advertises the bit position via
> KVM_SET_CPUID*, but kselftests currently call KVM_SET_SREGS as part of
> vm_vcpu_add_default(), *prior* to vCPU creation, so there's no
> opportunity to call KVM_SET_CPUID* in advance. As a result,
> KVM_SET_SREGS will return an error in these cases.
> 
> Address this by moving vcpu_set_cpuid() (which calls KVM_SET_CPUID*)
> ahead of vcpu_setup() (which calls KVM_SET_SREGS).
> 
> While there, address a typo in the assertion that triggers when
> KVM_SET_SREGS fails.
> 
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Michael Roth <michael.roth@amd.com>
> ---
>   tools/testing/selftests/kvm/lib/kvm_util.c         | 2 +-
>   tools/testing/selftests/kvm/lib/x86_64/processor.c | 4 +---
>   2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
> index ef88fdc7e46b..646cffd86d09 100644
> --- a/tools/testing/selftests/kvm/lib/kvm_util.c
> +++ b/tools/testing/selftests/kvm/lib/kvm_util.c
> @@ -1906,7 +1906,7 @@ void vcpu_sregs_get(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
>   void vcpu_sregs_set(struct kvm_vm *vm, uint32_t vcpuid, struct kvm_sregs *sregs)
>   {
>   	int ret = _vcpu_sregs_set(vm, vcpuid, sregs);
> -	TEST_ASSERT(ret == 0, "KVM_RUN IOCTL failed, "
> +	TEST_ASSERT(ret == 0, "KVM_SET_SREGS IOCTL failed, "
>   		"rc: %i errno: %i", ret, errno);
>   }
>   
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index 0bbd88fe1127..1ab4c20f5d12 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -660,6 +660,7 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>   
>   	/* Create VCPU */
>   	vm_vcpu_add(vm, vcpuid);
> +	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
>   	vcpu_setup(vm, vcpuid);
>   
>   	/* Setup guest general purpose registers */
> @@ -672,9 +673,6 @@ void vm_vcpu_add_default(struct kvm_vm *vm, uint32_t vcpuid, void *guest_code)
>   	/* Setup the MP state */
>   	mp_state.mp_state = 0;
>   	vcpu_set_mp_state(vm, vcpuid, &mp_state);
> -
> -	/* Setup supported CPUIDs */
> -	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
>   }
>   
>   /*
> 

Queued, thanks.

Paolo

