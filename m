Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B108B36D783
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 14:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237712AbhD1Mjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 08:39:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58810 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237704AbhD1Mjq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 08:39:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619613541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Adfym8klH+5tYEalET56TZJSSzxtb4r5UMa5Cv/WfQY=;
        b=IRuU2N15QlXIcB7k3kkpPFdmVgcU8pTylDMGx4TzDQjFmel3v0UOY2HIiahVLnNXXyJ9k+
        yoBAlsgUCqRSJzWryQxLqukzLyVR6KFwb12BPKllw98EZQXytLCYZpon58f3J3RgE6gBTf
        gMAeMBX2vaDPNmkdgIuVfdVJ2L+EzUU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-hEX2bmCnOg6oqRv3AqLQqg-1; Wed, 28 Apr 2021 08:39:00 -0400
X-MC-Unique: hEX2bmCnOg6oqRv3AqLQqg-1
Received: by mail-ej1-f71.google.com with SMTP id yh1-20020a17090706e1b029038d0f848c7aso3035983ejb.12
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 05:38:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Adfym8klH+5tYEalET56TZJSSzxtb4r5UMa5Cv/WfQY=;
        b=ODxu6jYjtHiwaVvIxte4IBNIvUC05FIiiwLELgAzzWsF38u45kS7aZPsqBW7uJQ5n5
         sT7JPhk06YYW6aijgW8RUZDoU5JJWc+nWeheLQm752t+K+3BnbNLOiaahQdBrUluXXRe
         xejMb4ZsjLRiZ0qNzuRvEq/P0PqlL6FqA0gaLwdtm104EN8wRn92TFd4r1MkWF4k3uHD
         KHwfbGry37XwEsAakt33MJSpFuNov8n/ioDy9R6Tsgxf8QqrtQ6/s/eq4g/CKWqafraB
         /G4tnXjIw3hv9SANxijyymQsMuFmOYAQm4s9V6oW9u3s4r4qWyKo/SJbuTddrknA3uAO
         QJbg==
X-Gm-Message-State: AOAM530oVxD+PFyunmC+N2CNDyaOEBjJQWUwW5VVQHSpKxP3YbHf+TFe
        z1MnU7WQnB2FgP9iuDYt8Ql/XETziLkun2zgXvyMwr4Z/Uf9GLx4ZCF0XXxfqfCaFL06R3Z+BU+
        O4zz7+VPXGWrJpQrsWQML7M/c68xjEPsH8688tvyxsUK5eAuqJA9JTBCj1JNn+rDf58mkudey7+
        lkOCzx
X-Received: by 2002:a17:906:6a41:: with SMTP id n1mr29126517ejs.401.1619613538805;
        Wed, 28 Apr 2021 05:38:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzM7yUm1BKlNC1iK3OfUA70Fr0wQFbfb2WyKUUYOLARDyyEnrh62rWqtS9ykhJkwSv1JTJIIg==
X-Received: by 2002:a17:906:6a41:: with SMTP id n1mr29126479ejs.401.1619613538594;
        Wed, 28 Apr 2021 05:38:58 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u1sm4785519edv.90.2021.04.28.05.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 05:38:58 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>,
        linux-kernel@vger.kernel.org
Cc:     Denis Lunev <den@openvz.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Shuah Khan <shuah@kernel.org>,
        Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Like Xu <like.xu@linux.intel.com>,
        Oliver Upton <oupton@google.com>,
        Andrew Jones <drjones@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix KVM_GET_CPUID2 ioctl to return cpuid
 entries count
In-Reply-To: <20210428113655.26282-1-valeriy.vdovin@virtuozzo.com>
References: <20210428113655.26282-1-valeriy.vdovin@virtuozzo.com>
Date:   Wed, 28 Apr 2021 14:38:57 +0200
Message-ID: <871raueg7y.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Valeriy Vdovin <valeriy.vdovin@virtuozzo.com> writes:

> KVM_GET_CPUID2 kvm ioctl is not very well documented, but the way it is
> implemented in function kvm_vcpu_ioctl_get_cpuid2 suggests that even at
> error path it will try to return number of entries to the caller. But
> The dispatcher kvm vcpu ioctl dispatcher code in kvm_arch_vcpu_ioctl
> ignores any output from this function if it sees the error return code.
>
> It's very explicit by the code that it was designed to receive some
> small number of entries to return E2BIG along with the corrected number.
>
> This lost logic in the dispatcher code has been restored by removing the
> lines that check for function return code and skip if error is found.
> Without it, the ioctl caller will see both the number of entries and the
> correct error.
>
> In selftests relevant function vcpu_get_cpuid has also been modified to
> utilize the number of cpuid entries returned along with errno E2BIG.
>
> Signed-off-by: Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
> ---
>  arch/x86/kvm/x86.c                            | 10 +++++-----
>  .../selftests/kvm/lib/x86_64/processor.c      | 20 +++++++++++--------
>  2 files changed, 17 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index efc7a82ab140..df8a3e44e722 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -4773,14 +4773,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
>  		r = -EFAULT;
>  		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
>  			goto out;
> +
>  		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
>  					      cpuid_arg->entries);
> -		if (r)
> -			goto out;
> -		r = -EFAULT;
> -		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))

It may make sense to check that 'r == -E2BIG' before trying to write
anything back. I don't think it is correct/expected to modify nent in
other cases (e.g. when kvm_vcpu_ioctl_get_cpuid2() returns -EFAULT)

> +
> +		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid))) {
> +			r = -EFAULT;
>  			goto out;
> -		r = 0;
> +		}
>  		break;

How is KVM userspace supposed to know if it can trust the 'nent' value
(KVM is fixed case) or not (KVM is not fixed case)? This can probably be
resolved with adding a new capability (but then I'm not sure the change
is worth it to be honest). Also, if making such a change, API
documentation in virt/kvm/api.rst needs updating.

>  	}
>  	case KVM_GET_MSRS: {
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> index a8906e60a108..a412b39ad791 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
> @@ -727,17 +727,21 @@ struct kvm_cpuid2 *vcpu_get_cpuid(struct kvm_vm *vm, uint32_t vcpuid)
>  
>  	cpuid = allocate_kvm_cpuid2();
>  	max_ent = cpuid->nent;
> +	cpuid->nent = 0;
>  
> -	for (cpuid->nent = 1; cpuid->nent <= max_ent; cpuid->nent++) {
> -		rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
> -		if (!rc)
> -			break;
> +	rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
> +	TEST_ASSERT(rc == -1 && errno == E2BIG,
> +		    "KVM_GET_CPUID2 should return E2BIG: %d %d",
> +		    rc, errno);
>  
> -		TEST_ASSERT(rc == -1 && errno == E2BIG,
> -			    "KVM_GET_CPUID2 should either succeed or give E2BIG: %d %d",
> -			    rc, errno);
> -	}
> +	TEST_ASSERT(cpuid->nent,
> +		    "KVM_GET_CPUID2 failed to set cpuid->nent with E2BIG");
> +
> +	TEST_ASSERT(cpuid->nent < max_ent,
> +		"KVM_GET_CPUID2 has %d entries, expected maximum: %d",
> +		cpuid->nent, max_ent);
>  
> +	rc = ioctl(vcpu->fd, KVM_GET_CPUID2, cpuid);
>  	TEST_ASSERT(rc == 0, "KVM_GET_CPUID2 failed, rc: %i errno: %i",
>  		    rc, errno);

-- 
Vitaly

