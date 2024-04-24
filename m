Return-Path: <linux-kselftest+bounces-8776-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B77188B0CC5
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 16:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9E33B21BE0
	for <lists+linux-kselftest@lfdr.de>; Wed, 24 Apr 2024 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC9115EFC2;
	Wed, 24 Apr 2024 14:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mlNHTXKv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CC715EFA0
	for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969581; cv=none; b=m8EYBTHvXS5+PEukEXNcL6DTFQsG8JT/yuXoK0BbEcEPkTrjS30y7Nt9NaBHp4rn+Mwuv9jyRaF7HjT+cjCv6GgYXw4I/K/hh0Qg2olExWlD195ty4m3j7W4ef/9qbtMinNVUeVnB70TtfpvmycpW7p9aNCeYrTrGgQ3+mtBCU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969581; c=relaxed/simple;
	bh=T5BKJjSvvOmVV87OlPWfEi/EP0teOTg1hdzodl7DUC0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=p/UsAdpz4fTMX5CBNkaG/+IyvaIpbzP0UhfnOlgIFSXQJvD3I5Of+8p5vfM7XBVTI909ft/V725DN8b/dHPqnbqMEqHaLTrSVyJluMbQ3MncE5o3byrtB8pHUMZCqNp95ayBH2Cy3URCqnFVqrf1b6cOgWQU0flUGPnR3tNeMS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mlNHTXKv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61814249649so133117407b3.3
        for <linux-kselftest@vger.kernel.org>; Wed, 24 Apr 2024 07:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713969578; x=1714574378; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9iiaCPly7txqpV5xrsjcvYa7r1oSnb/9cSgMPGsvZnE=;
        b=mlNHTXKvEJaO1e6RZp3hmG6BMeGh24i7ng8xRCDLeEciSw5N3zALxjB4ZipnFYhJUG
         KkM0KJ6y8yRozodbm7heKurg7TcuvZu2XEIlx4Regl1Ge/9l+X+TgwdygxX2AcotS6wN
         QNfFSZiIjostSiPJGUZAufmMKahJ5m8KSDSQ5iOeS6RecA49tSR8kdmyfZ9kHaJ4HLpp
         dqUWvcfwkAIa4c3Mtl2BpgxjKpSc00uUcEagCdqTXDnZSU+7miUvANxedJjWv5A6w3T+
         JVMYS+TtlTzba0jXdW1GarQOoeU2RG6wH52FvnAo1DPenmzfjHT2o5adMykbpd2nYoRI
         8AlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713969578; x=1714574378;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9iiaCPly7txqpV5xrsjcvYa7r1oSnb/9cSgMPGsvZnE=;
        b=Q1GVsP9CvmwnfjapHDttYW75Xz2fvxlvMpn76cMP/dDAiFhCtRU3GK8RmijVnTbpVP
         5KIBAPLR3YfinwofCSaSW+FE4M+oGFBQpj88doae1PKvCaIkhvuDDhMXj9LOOC3k6rf4
         8pzdwwXnllvmGFPgO5n2HrZ+3h0nORyDjtUR7t8TlSJW1QqJqTeE8N7m/4r/dxt3cb7n
         nnzZaSOdNZM9iBS+frtD7dt4kR9Zj5xDdMmN1EzhyxXMcSM45A3IzhtOErnEnHw0i9qF
         EUb8gq/Ee7g3gKyBUYmQ7uPONqaZpUAT2rU3c2ZVGYGekMHiyTdK7rY7q94dKRVKfSuh
         foUA==
X-Forwarded-Encrypted: i=1; AJvYcCVWQoaBjGMUpQv1c91KW/0vn1cboY1rJst4INvuxXBMXkASnMk7FJYLCF5dQilKO2OcZ83pq52NoYSDMjv6QAl/X9Xw4UT/3fI5aNGkbrsn
X-Gm-Message-State: AOJu0YwKckieKCqPzMO4BiT4OhOAcpMo/0pdk/f/8Yh5Ch/ecdCSIa+p
	yQzF6DI6NGBI0SO2IrKLnvofyUNHkp447fQKZ0RwsZkXsZ5raRkhwvxsaxWoFXzPm9PhOgeG3o3
	JDw==
X-Google-Smtp-Source: AGHT+IFwI+NUBwgT4LFDfuVdz9Xo3ZIpDQDyL8ZT8aZdM2HzLnWPcne09NNC7ebB5WdlqxUK2nmaBs2zktg=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a0d:ccd8:0:b0:615:ca8:6058 with SMTP id
 o207-20020a0dccd8000000b006150ca86058mr525187ywd.5.1713969578601; Wed, 24 Apr
 2024 07:39:38 -0700 (PDT)
Date: Wed, 24 Apr 2024 07:39:37 -0700
In-Reply-To: <ZihZOygvuDs1wIrh@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240409133959.2888018-1-pgonda@google.com> <20240409133959.2888018-5-pgonda@google.com>
 <ZihZOygvuDs1wIrh@google.com>
Message-ID: <ZikW-NjgaSMVm9uj@google.com>
Subject: Re: [PATCH 4/6] Add GHCB allocations and helpers
From: Sean Christopherson <seanjc@google.com>
To: Peter Gonda <pgonda@google.com>
Cc: linux-kernel@vger.kernel.org, Vishal Annapurve <vannapurve@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Carlos Bilbao <carlos.bilbao@amd.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Apr 23, 2024, Sean Christopherson wrote:
> On Tue, Apr 09, 2024, Peter Gonda wrote:
> > Add GHCB management functionality similar to the ucall management.
> > Allows for selftest vCPUs to acquire GHCBs for their usage.
> 
> Do we actually need a dedicated pool of GHCBs?  The conundrum with ucalls is that
> we have no place in the guest to store the pointer on all architectures.  Or rather,
> we were too lazy to find one. :-)
> 
> But for SEV-ES, we have MSR_AMD64_SEV_ES_GHCB, and any test that clobbers that
> obviously can't use ucalls anyways.  Argh, but we can't get a value in that MSR
> from the host.

...

> Anyways, back to selftests.  Since we apparently can't stuff MSR_AMD64_SEV_ES_GHCB
> from host userspace, what if we instead use a trampoline?  Instead having
> vcpu_arch_set_entry_point() point directly at guest_code, point it at a trampoline
> for SEV-ES guests, and then have the trampoline set MSR_AMD64_SEV_ES_GHCB to
> the vCPU-specific GHCB before invoking guest_code().
> 
> Then we just need a register to stuff the GHCB into.  Ah, and the actual guest 
> entry point.  GPRs are already part of selftest's "ABI", since they're set by
> vcpu_args_set().  And this is all 64-bit only, so we can use r10+.
> 
> Ugh, the complication is that the trampoline would need to save/restore RAX, RCX,
> and RDX in order to preserve the values from vcpu_args_set(), but that's just
> annoying, not hard.  And I think it'd be less painful overall than
> having to create a GHCB pool?
> 
> In rough pseudo-asm, something like this?
> 
> static void vcpu_sev_es_guest_trampoline(void)
> {
> 	asm volatile(<save rax, rcx, rdx>
> 		     "mov %%r15d, %%eax\n\t"
> 		     "shr %%r15, $32\n\t"
> 		     "mov %%r15d, %%eax\n\t"
> 		     "mov $MSR_AMD64_SEV_ES_GHCB, %%ecx\n\t"
> 		     <restore rax, rcx, rdx>
> 		     "jmp %%r14")
> }

Scratch using inline asm, it needs to be a proper asm subroutine, as it's possible
the compiler could clobber GPRs before emitting the asm.  But writing actual
assembly code is probably a good thing.

And we need assembly for TDX selftests, which forces vCPUs to start at the RESET
vector[*].  Rather than add a TDX specific td_boot.S, we can add a common-ish
entry.S to hold all of the CoCo entry points that need to be in assembly.

Then I think we'll eventually end up with something like:

diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index fd94a1bd82c9..03818d3c4669 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -597,7 +597,12 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
        struct kvm_regs regs;
 
        vcpu_regs_get(vcpu, &regs);
-       regs.rip = (unsigned long) guest_code;
+       if (<is sev-es guest>)
+               regs.r14 = guest_code;
+       else if (<is tdx guest>)
+               <guest_code gets shoved somewhere else>
+       else
+               regs.rip = (unsigned long) guest_code;
        vcpu_regs_set(vcpu, &regs);
 }
 
@@ -635,6 +640,10 @@ struct kvm_vcpu *vm_arch_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id)
        vcpu_regs_get(vcpu, &regs);
        regs.rflags = regs.rflags | 0x2;
        regs.rsp = stack_vaddr;
+       if (<is sev-es guest>) {
+               regs.rip = vcpu_sev_es_guest_trampoline;
+               regs.r15 = <allocate and map ghcb>();
+       }
        vcpu_regs_set(vcpu, &regs);
 
        /* Setup the MP state */
---

[*] https://lore.kernel.org/all/20231212204647.2170650-6-sagis@google.com



