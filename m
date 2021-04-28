Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8D136DACB
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Apr 2021 17:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbhD1PDW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 28 Apr 2021 11:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhD1PCy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Apr 2021 11:02:54 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A12C061263
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 07:59:05 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id s20so17138177plr.13
        for <linux-kselftest@vger.kernel.org>; Wed, 28 Apr 2021 07:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jz7qPymMOFiVOAXZnP4Er6B1ezJAfu0fq5a7KpaKKQU=;
        b=tJmUpYMlpVzCzA6fjWQAPQT8pJlmuQQJyP65wBc4SobpHYKgSjjw7PSOs+hrWxJfWb
         S9/I6rpyxY795lojvfRjKS8iIGjOqOPQnaDnZyI4sEPHgMus7cVRTId5sUXOxvDhxRY7
         iD1+csPryZ0Fl35FqzelVEtp4n0cGxmW4B8jH/E5CQvHsNNMEJrap/+TLT18S2DLjp4Y
         bdSoURtwbRKMeuPqDU42hhNoOZ4vj6bhzAQ6Q4VUEQqs318Ap4H3mb/WLGn/prWKCQFS
         NM+9JEldMbdZ6jDZql84b0qH51bF0B8CuYB0Qtd5GOfy2CtygMzKAMEC0wBSgzj8iGL2
         UahQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jz7qPymMOFiVOAXZnP4Er6B1ezJAfu0fq5a7KpaKKQU=;
        b=F56rIQyVHYURW87Jrsye5TudUMaVKibxUwcx9gaj5m36LdFm6k0c3mUkf2VEjdju5O
         VS37uh5kmgS7B76LP4CaTB+uFgvj6NMtJjTibU6Fecp2Woe8VPC7gr4yveb9glzkop76
         MlwJPJ8kWgAKzUfR0i6USsWg0M7a5CG6mtjs0MMftOwlKdhpCqP07ypHm7KwMhxuAIkd
         6Ry9FISx7Gp8b07u/tdmPXgp7eBYdp7bvqW5gKyjC0u6zk0e9MSfxvGSLBs99/hnGVjV
         uXdcaMkCrj4alT0EPG9BBZ7PynTdlObW5sFSfTq4Ki+uZ5NWK0vjXJasHc4AuxYBZuU/
         7oTQ==
X-Gm-Message-State: AOAM533QkWRc4758Fqr91tCQYwSObaT4BCMJ0+jmzJDbLSt+cpTjBsSc
        CGjAr11EncGhLLvhMA4kKkCxKw==
X-Google-Smtp-Source: ABdhPJyqXFkfR+iBHk8ipYJO7e2td0DCaeMFxvdNTPxJZHuA4UqEQCca9eBPOjtc0ufvhqon6y+8hw==
X-Received: by 2002:a17:902:10b:b029:ed:2b3e:beb4 with SMTP id 11-20020a170902010bb02900ed2b3ebeb4mr17868694plb.64.1619621944318;
        Wed, 28 Apr 2021 07:59:04 -0700 (PDT)
Received: from google.com (240.111.247.35.bc.googleusercontent.com. [35.247.111.240])
        by smtp.gmail.com with ESMTPSA id mn22sm4501399pjb.24.2021.04.28.07.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 07:59:03 -0700 (PDT)
Date:   Wed, 28 Apr 2021 14:58:59 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, Denis Lunev <den@openvz.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <YIl4M/GgaYvwNuXv@google.com>
References: <20210428113655.26282-1-valeriy.vdovin@virtuozzo.com>
 <871raueg7y.fsf@vitty.brq.redhat.com>
 <20210428134657.GA515794@dhcp-172-16-24-191.sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210428134657.GA515794@dhcp-172-16-24-191.sw.ru>
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Wed, Apr 28, 2021, Valeriy Vdovin wrote:
> On Wed, Apr 28, 2021 at 02:38:57PM +0200, Vitaly Kuznetsov wrote:
> > Valeriy Vdovin <valeriy.vdovin@virtuozzo.com> writes:
> > 
> > > KVM_GET_CPUID2 kvm ioctl is not very well documented, but the way it is
> > > implemented in function kvm_vcpu_ioctl_get_cpuid2 suggests that even at
> > > error path it will try to return number of entries to the caller. But
> > > The dispatcher kvm vcpu ioctl dispatcher code in kvm_arch_vcpu_ioctl
> > > ignores any output from this function if it sees the error return code.
> > >
> > > It's very explicit by the code that it was designed to receive some
> > > small number of entries to return E2BIG along with the corrected number.
> > >
> > > This lost logic in the dispatcher code has been restored by removing the
> > > lines that check for function return code and skip if error is found.
> > > Without it, the ioctl caller will see both the number of entries and the
> > > correct error.
> > >
> > > In selftests relevant function vcpu_get_cpuid has also been modified to
> > > utilize the number of cpuid entries returned along with errno E2BIG.
> > >
> > > Signed-off-by: Valeriy Vdovin <valeriy.vdovin@virtuozzo.com>
> > > ---
> > >  arch/x86/kvm/x86.c                            | 10 +++++-----
> > >  .../selftests/kvm/lib/x86_64/processor.c      | 20 +++++++++++--------
> > >  2 files changed, 17 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> > > index efc7a82ab140..df8a3e44e722 100644
> > > --- a/arch/x86/kvm/x86.c
> > > +++ b/arch/x86/kvm/x86.c
> > > @@ -4773,14 +4773,14 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
> > >  		r = -EFAULT;
> > >  		if (copy_from_user(&cpuid, cpuid_arg, sizeof(cpuid)))
> > >  			goto out;
> > > +
> > >  		r = kvm_vcpu_ioctl_get_cpuid2(vcpu, &cpuid,
> > >  					      cpuid_arg->entries);
> > > -		if (r)
> > > -			goto out;
> > > -		r = -EFAULT;
> > > -		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid)))
> > 
> > It may make sense to check that 'r == -E2BIG' before trying to write
> > anything back. I don't think it is correct/expected to modify nent in
> > other cases (e.g. when kvm_vcpu_ioctl_get_cpuid2() returns -EFAULT)
> > 
> That's a good point. The caller could expect and rely on the fact that nent
> is unmodified in any error case except E2BIG. I will add this in the next
> version.
> > > +
> > > +		if (copy_to_user(cpuid_arg, &cpuid, sizeof(cpuid))) {
> > > +			r = -EFAULT;
> > >  			goto out;
> > > -		r = 0;
> > > +		}
> > >  		break;
> > 
> > How is KVM userspace supposed to know if it can trust the 'nent' value
> > (KVM is fixed case) or not (KVM is not fixed case)? This can probably be
> > resolved with adding a new capability (but then I'm not sure the change
> > is worth it to be honest).
> 
> As I see it KVM userspace should set nent to 0, and then expect any non-zero
> value in return along with E2BIG. This is the same approach I've used in the
> modified test code in the same patch.

IMO, the current code is correct (well, least awful), albeit misleading.
Copying back the number of entries but not the entries themselves would be a bug.
That can obviously be remedied, but it adds even more complexity for no known
benefit, and training userspace to go spelunking on -E2BIG would likely yield
more bugs in the future.

I also think we should keep the -E2BIG behavior of KVM_GET_CPUID2 and
KVM_GET_{SUPPORTED,EMULATED,SUPPORTED_HV}_CPUID consistent.  Returning partial
information would make KVM_GET_CPUID2 an anomaly.


diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index c96f79c9fff2..c4dbc7c47b17 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -348,20 +348,15 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
                              struct kvm_cpuid2 *cpuid,
                              struct kvm_cpuid_entry2 __user *entries)
 {
-       int r;
-
-       r = -E2BIG;
        if (cpuid->nent < vcpu->arch.cpuid_nent)
-               goto out;
-       r = -EFAULT;
+               return -E2BIG;
+
        if (copy_to_user(entries, vcpu->arch.cpuid_entries,
                         vcpu->arch.cpuid_nent * sizeof(struct kvm_cpuid_entry2)))
-               goto out;
-       return 0;
+               return -EFAULT;

-out:
        cpuid->nent = vcpu->arch.cpuid_nent;
-       return r;
+       return 0;
 }

 /* Mask kvm_cpu_caps for @leaf with the raw CPUID capabilities of this CPU. */
