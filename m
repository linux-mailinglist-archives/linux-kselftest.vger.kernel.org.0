Return-Path: <linux-kselftest+bounces-19429-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99770998143
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 11:00:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD051C20AB1
	for <lists+linux-kselftest@lfdr.de>; Thu, 10 Oct 2024 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950491C4627;
	Thu, 10 Oct 2024 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lf2yUXBs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63881C4623
	for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 08:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728550670; cv=none; b=CfUWtsLQr/LPgWh3TGHPXSEGVo23cpcOIa7ZsLQ2Co5GVDqUmiZsjVfONJFfBN0numtOO8C9EwRzh0IyHxVmjE+bYCQ9xiyootic6FcOWqyw+Ouctln+4vkCdWMVsaXSvLnzWr4LWkkyMPh5+ClW4hXSNasv6Q1VVZG650/R1d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728550670; c=relaxed/simple;
	bh=zhN2J78m1rEeFNTlYZmBtWXGEVXdyMiydT0kbesTDj8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hiTTw6g3UrxL8Hu7OAeLKwsTGQH8rm0Yw87n82pkmJIrheuJSXnvB94FDLxNb9XApyZEBIG77dgORNqu5YO72gGwGfcJy2dLaIrHu1wPS5by5mD7Y09usY7fq72U9rBubSnQT1RR8/qI9m/4sd9An0ep/sBKLSbtQ27YtvKpMvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Lf2yUXBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728550667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wiVa5edTwxgaEVFE4MTbk9agbR+b9XfHTQGm8DFBgok=;
	b=Lf2yUXBsnlQfZoRU76jAKx4xQ1+9a+v9XL+loeI5r5MYiR2JDzP5c/UvUVrZmtHTsiJ/W5
	uKRm9XQg58a+PIrBwZXLENdrJlEx+oIbRuuazvjlSu8NS8j/zNv11XxPPKRl1FoOJ05cCM
	e4j2xuM6gikCfqgxPTJWi1XjduR2EaU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-sdcc5mXUPZClDi9_g0brcw-1; Thu, 10 Oct 2024 04:57:46 -0400
X-MC-Unique: sdcc5mXUPZClDi9_g0brcw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d5016d21eso83966f8f.3
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Oct 2024 01:57:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728550665; x=1729155465;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wiVa5edTwxgaEVFE4MTbk9agbR+b9XfHTQGm8DFBgok=;
        b=qHZpqzTAuyLhPqVxRB5ws2tSqP+NznosM/Og3FvMWY9A0yAZ6bBQRTAk8EdHnVPZ1S
         1elp2Fa1FXSqTLUPNkWtol3n4UoUxRMH8mOtH7Peiqd7iigQ826er1jQO4Oo/yBMCcoq
         F47tbGJhkGfFShSItiYPv+sIStZ5+CZC79NBWUCNgUCMWGGlNiAYKGAgS9xh4xLTeEIO
         3X2q0UrRRimXTRLNm3d8oJkNCYqa52r4uwVtj6jcWZKBCx3oaj+kG2ZM1P9Mb09/Oc08
         K6rrtKY3HuosbZ+FDnQ0PCCtZ3iPbWg3uwxzFdH8d9i8c6P4nV2rbacaufbDcPNHiHIz
         R1hg==
X-Forwarded-Encrypted: i=1; AJvYcCWF26WNV1/YIbd40aRFkqpSztHdtvyrmGOmrUGVGnwTQH39A8GrS7UbtckSDQ1+Jx63HHpSB91qU9RJbzsw7+c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpFHZRZwMbk6KFcSYMHJkPK9CnqAkRGpyRO9P5Msut1RIPKRTe
	VmfmIy7rnkoRu/VcRwv2Gn/pgB+gitTTEZzdfnbg7Awl2TcEIZnCvrNGamTxfRWA1Iitgb1mQ3d
	eruhU8KXz2/jPdSkkNuSLTaLLfwROQyQzy6yKXp8uNmcpcu4o7UTJji7WnMMCfUqPT9ukzSkOne
	KRt8AWBAnNQ805D2mlYx11PiZ2ofcuMyxBl2ZU2bmF5wmj4MI1EQ==
X-Received: by 2002:adf:f34d:0:b0:37d:387c:7092 with SMTP id ffacd0b85a97d-37d3a9b30c0mr3355766f8f.7.1728550665446;
        Thu, 10 Oct 2024 01:57:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHmtw5lNRPN7D0O/gu0LvAg0I4YsSYfUbUN9th8RijPdlAboCPM7bGCIkPFkE+eNC3oU9PhAw==
X-Received: by 2002:adf:f34d:0:b0:37d:387c:7092 with SMTP id ffacd0b85a97d-37d3a9b30c0mr3355727f8f.7.1728550664849;
        Thu, 10 Oct 2024 01:57:44 -0700 (PDT)
Received: from fedora (g2.ign.cz. [91.219.240.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6cffa5sm913858f8f.53.2024.10.10.01.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 01:57:44 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nikolas Wipper <nikwip@amazon.de>
Cc: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
 <graf@amazon.de>, James Gowans <jgowans@amazon.com>,
 nh-open-source@amazon.com, Sean Christopherson <seanjc@google.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, Nikolas Wipper <nik.wipper@gmx.de>,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/7] KVM: x86: Implement Hyper-V's vCPU suspended state
In-Reply-To: <20241004140810.34231-3-nikwip@amazon.de>
References: <20241004140810.34231-1-nikwip@amazon.de>
 <20241004140810.34231-3-nikwip@amazon.de>
Date: Thu, 10 Oct 2024 10:57:43 +0200
Message-ID: <875xq0gws8.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nikolas Wipper <nikwip@amazon.de> writes:

> Introduce a suspension state for Hyper-V enlightened vCPUs. Microsoft's
> "Hypervisor Top Level Functional Specification" (TLFS) introduces this
> state as a "vCPU that is stopped on a instruction guest boundary, either
> explicitly or implicitly due to an intercept". The only documented
> explicit suspension is caused in response to a TLB Flush hypercall, which
> will use the state switching API in subsequent patches.
>
> Each Hyper-V vCPU now has a 'suspended' boolean field, which is checked
> before entering the guest. When set, it forces the vCPU to block. Once in
> that state, the vCPU ignores any events. The vCPU is unsuspended by
> clearing 'suspend' and issuing a request to force the vCPU out of sleep.
>
> Suspensions are issued as a mechanism to halt execution until state change
> is observed on a remote vCPU. Hyper-V vCPUs track this with 'waiting_on',
> which holds the 'vcpu_id' of the remote vCPU that forced the vCPU to enter
> the suspended state. It's the remote vCPU's responsibility to wake up the
> suspended vCPUs when ready. 'waiting_on' ensures the remote vCPU can
> selectively unsuspend vCPUs that blocked on its behalf while leaving other
> suspended vCPUs undisturbed. One vCPU can only be suspended due to a
> single remote vCPU, but different vCPUs can be suspended on behalf of
> different or the same remote vCPU(s). The guest is responsible for
> avoiding circular dependencies between suspended vCPUs.
>
> Callers of the suspend API are responsible for ensuring that suspend and
> unsuspend aren't called in parallel while targeting the same pair of
> vCPUs. Otherwise kvm_hv_vcpu_{un}suspend_tlb_flush() ensure 'waiting_on'
> and 'suspended' are updated and accessed in the correct order. This, for
> example, avoids races where the unsuspended vCPU re-suspends before
> kvm_hv_vcpu_unsuspend_tlb_flush() is done updating 'waiting_on'.
>
> Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +++
>  arch/x86/kvm/hyperv.c           | 30 ++++++++++++++++++++++++++++++
>  arch/x86/kvm/hyperv.h           | 17 +++++++++++++++++
>  arch/x86/kvm/x86.c              |  4 +++-
>  4 files changed, 53 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 46e0a466d7fb..7571ac578884 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -695,6 +695,9 @@ struct kvm_vcpu_hv {
>  		u64 vm_id;
>  		u32 vp_id;
>  	} nested;
> +
> +	bool suspended;
> +	int waiting_on;

I don't quite understand why we need 'suspended' at all. Isn't it always
suspended when 'waiting_on != -1'? I can see we always update these two
in pair.

Also, I would suggest we use a more descriptive
name. 'waiting_on_vcpu_id', for example.

>  };
>  
>  struct kvm_hypervisor_cpuid {
> diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
> index 4f0a94346d00..6e7941ed25ae 100644
> --- a/arch/x86/kvm/hyperv.c
> +++ b/arch/x86/kvm/hyperv.c
> @@ -971,6 +971,7 @@ int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
>  
>  	vcpu->arch.hyperv = hv_vcpu;
>  	hv_vcpu->vcpu = vcpu;
> +	hv_vcpu->waiting_on = -1;
>  
>  	synic_init(&hv_vcpu->synic);
>  
> @@ -2915,3 +2916,32 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
>  
>  	return 0;
>  }
> +
> +void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id)

Can we make parameter's name 'waiting_on_vcpu_id' as well? Because as-is
I'm getting confused which CPU of these two is actually getting
suspended)

Also, why do we need '_tlb_flush' in the name? The mechanism seems to be
fairly generic, it's just that we use it for TLB flushes.

> +{
> +	/* waiting_on's store should happen before suspended's */
> +	WRITE_ONCE(vcpu->arch.hyperv->waiting_on, vcpu_id);
> +	WRITE_ONCE(vcpu->arch.hyperv->suspended, true);
> +}
> +
> +void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu)

And here someone may expect this means 'unsuspend vcpu' but in reality
this means 'unsuspend all vCPUs which are waiting on 'vcpu'). I guess we
need a rename. How about

void kvm_hv_unsuspend_vcpus(struct kvm_vcpu *waiting_on_vcpu)

?

> +{
> +	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
> +	struct kvm_vcpu_hv *vcpu_hv;
> +	struct kvm_vcpu *v;
> +	unsigned long i;
> +
> +	kvm_for_each_vcpu(i, v, vcpu->kvm) {
> +		vcpu_hv = to_hv_vcpu(v);
> +
> +		if (kvm_hv_vcpu_suspended(v) &&
> +		    READ_ONCE(vcpu_hv->waiting_on) == vcpu->vcpu_id) {
> +			/* waiting_on's store should happen before suspended's */
> +			WRITE_ONCE(v->arch.hyperv->waiting_on, -1);
> +			WRITE_ONCE(v->arch.hyperv->suspended, false);
> +			__set_bit(i, vcpu_mask);
> +		}
> +	}
> +
> +	kvm_make_vcpus_request_mask(vcpu->kvm, KVM_REQ_EVENT, vcpu_mask);
> +}
> diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
> index 913bfc96959c..a55832cea221 100644
> --- a/arch/x86/kvm/hyperv.h
> +++ b/arch/x86/kvm/hyperv.h
> @@ -265,6 +265,15 @@ static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu,
>  }
>  
>  int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
> +
> +static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
> +{
> +	return vcpu->arch.hyperv_enabled &&
> +	       READ_ONCE(vcpu->arch.hyperv->suspended);

I don't think READ_ONCE() means anything here, does it?

> +}
> +
> +void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id);
> +void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu);
>  #else /* CONFIG_KVM_HYPERV */
>  static inline void kvm_hv_setup_tsc_page(struct kvm *kvm,
>  					 struct pvclock_vcpu_time_info *hv_clock) {}
> @@ -321,6 +330,14 @@ static inline u32 kvm_hv_get_vpindex(struct kvm_vcpu *vcpu)
>  	return vcpu->vcpu_idx;
>  }
>  static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu, bool tdp_enabled) {}
> +
> +static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
> +{
> +	return false;
> +}
> +
> +static inline void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id) {}
> +static inline void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu) {}
>  #endif /* CONFIG_KVM_HYPERV */
>  
>  #endif /* __ARCH_X86_KVM_HYPERV_H__ */
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 15080385b8fe..18d0a300e79a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -135,6 +135,8 @@ static void store_regs(struct kvm_vcpu *vcpu);
>  static int sync_regs(struct kvm_vcpu *vcpu);
>  static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu);
>  
> +static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu);
> +
>  static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
>  static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
>  
> @@ -11107,7 +11109,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
>  static bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
>  {
>  	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
> -		!vcpu->arch.apf.halted);
> +		!vcpu->arch.apf.halted && !kvm_hv_vcpu_suspended(vcpu));
>  }
>  
>  static bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)

-- 
Vitaly


