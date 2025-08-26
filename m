Return-Path: <linux-kselftest+bounces-39972-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DDCB3710C
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 19:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69E4E8E3F46
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 17:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99452C17A3;
	Tue, 26 Aug 2025 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wj9xKgd9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1662D47E8
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 17:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756228585; cv=none; b=jgRpO6Jxhwa/vEtQpIh3iCMGvrhKjzc6ZAIErSvX49p0RDE7xxBoZAFddXRjxIuiQ5SyBWlzs5fzZGBpkjY82GlLu3/9uUdgphtjoE6qHIpfEwPus6CCcgeTGXtSNgF1ybto3rQLhTAdWvLtc8WBeTKzyBxK/bJbIfTHOBZdctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756228585; c=relaxed/simple;
	bh=fvjdVvqrVjKr0a5LTdg9nBk5vfBdc56Vo1TvHP111NU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dFOugoHzGqaBTp7T1m3WsR9G4wRsyCAg8hQQAOQzI2Zlz2NZl/tOfI8aNyHjyCNYiqgDQz0vWFcVa6xlfgz4TkW8UMaZ0cCqeVrio2geou1DHSpTC05xrJcyH/JGIjycZYkPw7/kTXYhQ4tIv5o2UZQOLVbFGCZ/YfZFQTsBqBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wj9xKgd9; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7705115a2a5so2353464b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 10:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756228583; x=1756833383; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPQkp4eLa51rgoZQsO5XmXkzCVyl1vzwf6yi1FF+7Hs=;
        b=wj9xKgd9fBgxYmukIeSSBdnF9nqOpbWHWj3J/y72rpcEOv2u9DPGjECgnmU+3oGsju
         IaqgSYBFkxIa0Ni9POfGW3nWEbKJqPzVpBc3O0UMpnCHDQHKqaEorG0Tr3WA77PKwR4J
         xI9Pb+GvWPBqjyvbswMKO3prqcUnR2wb1oHCcsfLJRoabpdalJN3yc9l+qI/UZwDHtmw
         zC8znhZTkKxpQGebunvOc7zh6Y0iv3ZbYNukvkC8AHcpwMU7u8rkdrn8oVglClq9Wu8u
         8qMGs9oGLxPRJHcChfVQSCsiSadGsSckobwpJThnKcWra3LY7M6dSs4UAiO/2HI2bd3k
         KxMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756228583; x=1756833383;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPQkp4eLa51rgoZQsO5XmXkzCVyl1vzwf6yi1FF+7Hs=;
        b=XiRhPfAuBlUcjqRNuvPiOLODsNItGaJZpSwSb8+ND+hc4FZt+ntHqXVjOyg4au5q5H
         o1lgyOU0rwP/OH07wHQL8fbSddZV3/RNudC8UX2EzJATBRbgLUrYIicykQspbqi3iYsA
         0w1v9VW9R3pd14botcsHzDjUisESu4WSs6fvrWKvXaIblVjVcvXxnqqhKu0suiCVdQ6t
         +BK8D3sWRA5gZK/Mxi0o+T9Kd/p5alnMD+Eill7EWyAH39HcNf8jFmPcUMio1ueSAVne
         8rUIKu5MX7RkEqCLEJCuNv+18OezyL+3XbfMbpWjtMDJSNhJz7rFMCIVcmW42f2y/SmI
         NziA==
X-Forwarded-Encrypted: i=1; AJvYcCVSYOdpKYBcGNyYV9ReJQl6FzAzJ+sSd4hHMvd0RRjBvWa8qeG6fQaGrqte6kRwONqRAPpHeFODbO7fS4xMWAw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6MuWQgZAheJYZili2z3xrvWoi10yFY0yFBfOe8HJYdGJHR0UJ
	KR4mNjLlAivYRFDAp3py2EWFbvr/b7a2r0AhjLQs62zq4ZgtNe0rJ8t0q2p28vmqYrZ9bui76Rr
	qkQeqfg==
X-Google-Smtp-Source: AGHT+IGegMNQmVeWNpCzLcs4Xi46pfblu1Kifftbl1fWL6g5w/8bftTv67TFe6za5csVE4uK+DTIuwgIIwA=
X-Received: from pfva1.prod.google.com ([2002:a05:6a00:c81:b0:771:3e92:f3aa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:aa7:8251:0:b0:76e:8535:53d9
 with SMTP id d2e1a72fcca58-7702faac358mr17851538b3a.18.1756228583195; Tue, 26
 Aug 2025 10:16:23 -0700 (PDT)
Date: Tue, 26 Aug 2025 10:16:21 -0700
In-Reply-To: <9ef0d1f4-3257-4821-8241-aedae0957c6a@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com> <20250821042915.3712925-5-sagis@google.com>
 <9ef0d1f4-3257-4821-8241-aedae0957c6a@linux.intel.com>
Message-ID: <aK3r5cjLvF3vmJCi@google.com>
Subject: Re: [PATCH v9 04/19] KVM: selftests: Expose function to allocate
 guest vCPU stack
From: Sean Christopherson <seanjc@google.com>
To: Binbin Wu <binbin.wu@linux.intel.com>
Cc: Sagi Shahar <sagis@google.com>, linux-kselftest@vger.kernel.org, 
	Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Roger Wang <runanwang@google.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Aug 26, 2025, Binbin Wu wrote:
> 
> 
> On 8/21/2025 12:28 PM, Sagi Shahar wrote:
> > TDX guests' registers cannot be initialized directly using
> > vcpu_regs_set(), hence the stack pointer needs to be initialized by
> > the guest itself, running boot code beginning at the reset vector.
> > 
> > Expose the function to allocate the guest stack so that TDX
> > initialization code can allocate it itself and skip the allocation in
> > vm_arch_vcpu_add() in that case.
> > 
> > Signed-off-by: Sagi Shahar <sagis@google.com>
> > ---
> >   .../selftests/kvm/include/x86/processor.h       |  2 ++
> >   tools/testing/selftests/kvm/lib/x86/processor.c | 17 ++++++++++++-----
> >   2 files changed, 14 insertions(+), 5 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
> > index 5c16507f9b2d..8fcc5118683e 100644
> > --- a/tools/testing/selftests/kvm/include/x86/processor.h
> > +++ b/tools/testing/selftests/kvm/include/x86/processor.h
> > @@ -1111,6 +1111,8 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
> >   	vcpu_set_or_clear_cpuid_feature(vcpu, feature, false);
> >   }
> > +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm);
> > +
> >   uint64_t vcpu_get_msr(struct kvm_vcpu *vcpu, uint64_t msr_index);
> >   int _vcpu_set_msr(struct kvm_vcpu *vcpu, uint64_t msr_index, uint64_t msr_value);
> > diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
> > index b2a4b11ac8c0..1eae92957456 100644
> > --- a/tools/testing/selftests/kvm/lib/x86/processor.c
> > +++ b/tools/testing/selftests/kvm/lib/x86/processor.c
> > @@ -687,12 +687,9 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
> >   	vcpu_regs_set(vcpu, &regs);
> >   }
> > -struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> > +vm_vaddr_t kvm_allocate_vcpu_stack(struct kvm_vm *vm)
> >   {
> > -	struct kvm_mp_state mp_state;
> > -	struct kvm_regs regs;
> >   	vm_vaddr_t stack_vaddr;
> > -	struct kvm_vcpu *vcpu;
> >   	stack_vaddr = __vm_vaddr_alloc(vm, DEFAULT_STACK_PGS * getpagesize(),
> >   				       DEFAULT_GUEST_STACK_VADDR_MIN,
> > @@ -713,6 +710,15 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> >   		    "__vm_vaddr_alloc() did not provide a page-aligned address");
> >   	stack_vaddr -= 8;
> > +	return stack_vaddr;
> > +}
> > +
> > +struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> > +{
> > +	struct kvm_mp_state mp_state;
> > +	struct kvm_regs regs;
> > +	struct kvm_vcpu *vcpu;
> > +
> >   	vcpu = __vm_vcpu_add(vm, vcpu_id);
> >   	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
> >   	vcpu_init_sregs(vm, vcpu);
> > @@ -721,7 +727,8 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
> >   	/* Setup guest general purpose registers */
> >   	vcpu_regs_get(vcpu, &regs);
> >   	regs.rflags = regs.rflags | 0x2;
> > -	regs.rsp = stack_vaddr;
> > +	if (vm->type != KVM_X86_TDX_VM)
> > +		regs.rsp = kvm_allocate_vcpu_stack(vm);
> 
> I am wondering if this could be more generic.
> I.e, make vcpu_regs_get() return the error code.

It would need to be a double-underscores variant, i.e. __vcpu_regs_get().  But
even then, I don't think it's worth getting that clever, because then to ensure
selftests aren't hitting KVM bugs, we'd want to assert that failure only occurs
for a TDX VM, i.e. we'd end up with:

	if (__vcpu_regs_get(vcpu, &regs)) {
		TEST_ASERT(is_tdx_vm(vm), "blah blah blah"
	} else {

	}

which doesn't really "save" anything relative to Sagi's proposed version of:

	if (is_tdx_vm(vm)) {
        	vm_tdx_vcpu_add(vm, vcpu);
	} else {
        	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());

	        vcpu_init_sregs(vm, vcpu);
	        vcpu_init_xcrs(vm, vcpu);

        	/* Setup guest general purpose registers */
	        vcpu_regs_get(vcpu, &regs);
	        regs.rflags = regs.rflags | 0x2;
	        regs.rsp = kvm_allocate_vcpu_stack(vm);
	        vcpu_regs_set(vcpu, &regs);
	}

> If vcpu_regs_get() failed (for TDX, since it's guest state is protected, the
> ioctl will return -EINVAL), the vcpu_regs_set(), including the allocation for
> the vcpu stack, could be skipped.
> 
> >   	vcpu_regs_set(vcpu, &regs);
> >   	/* Setup the MP state */
> 

