Return-Path: <linux-kselftest+bounces-19746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968199F22B
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 17:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C865282853
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Oct 2024 15:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10391FAEE9;
	Tue, 15 Oct 2024 15:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xKI1ie1X"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F661F9EA5
	for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729007885; cv=none; b=OQ6vpsVWotNCIUCGeit7bk/1znwKoqaHrR04YPwa81Q74uOi1Q3j/xV2B/UrTKZRRjzO+b7HbBOFDG8w2eW8nNwsYexr8aZzUZ4W/+yKknFETl8eR46jwQ6L9zNksqGZJRhXZgSIJOWEZhU22yoCx8gnq0hoGe/+FIph61+a01Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729007885; c=relaxed/simple;
	bh=aYJ3ScoRGgAobUtmWNW7wrrfHvNJK4QqvJ0rYbf6QwA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ghe9BsJP1B0anTXUWbbRud1OlkW9ZGCOyD9KyakhkDM7jQTSLjsqD8/Tffdfv0UYBEoWgvbYXeIR0DhAyRu3SLEhVOzHRdemHWr4rcEVsn8hMcTMM2k1+yLBaz0c8HvoSUrhM+buK3eKtT3qQbItkJfn9RBoZWzYWgODz4dTbjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xKI1ie1X; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-71930797560so5976202b3a.1
        for <linux-kselftest@vger.kernel.org>; Tue, 15 Oct 2024 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729007883; x=1729612683; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bpgcprPI+vvJsG2LB/Vt+V2mYjpRXDgXYo99nuQ4xLg=;
        b=xKI1ie1X40VczKlusr1XxD0YPkV2zZfe/6okKWD3+t8AFuC1QFITTSPGtfYAWW+NkP
         oD/2iSw3t5TyDU6xmFJ5lEdm0VK8bhpD9Lv6J8nT1eBicsyEIYv5GnR/JdABC/Ah1yEk
         ADV6mXe17tOE6Pyq0mR6YTrCsaSbyrgtSKTFSu55q8oyBpCYsI2v3D0zhpfrnc9cqH1I
         m7SaNxyMhPvljDrUfbQV7g2o5dBN8kccwLR1S/QYXaCsvLoKV3qxUhFrvr1L4y0mTMkd
         WVtbxGYXSq2vffsS6K12kSNTkmstcq7eDCyWUYm9gNUlOZYsvrCy6Jq2LczpUM8bVnq3
         a99g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729007883; x=1729612683;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bpgcprPI+vvJsG2LB/Vt+V2mYjpRXDgXYo99nuQ4xLg=;
        b=CQfhwqXR0iGx35A3rVI0NkCpHI1RlwxPHKygffynkPWxD2NkM5xzb2oo5d3mwmX4hy
         dXuUUKXoay0gKjQ+bmJHZl+c2Ij/twADX/H3vpocMWTXy8yEhAE+Vqm61Wtv4xHEYS0e
         oiZbZ4Tuea9JlQ10cxPlIsjt5nyedL95MZgVOXDb40pfUpap1BwheXEJ08SUxX3Ll14n
         BkSjCFMow9yykURB6d9HCKo/w7hb60RoN5Drfw64beKaiYTRs1T1Y7KejvEaMakWPT/M
         yco89Q9TdTupoir4O58c+w6iTo97lrt1q+q7sHHR7oVt7V4X7GF1lUQBkpvwNgt91OZa
         iAiQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1M918yp52eshyv2defaTF7TJGBH27zV+pJi1LpEvElfjUaejLfucS2kFJAzU8Q/vVarwIVhnzf/1UYLaWM7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMebN93uEsxsbKzpFn0by+WqzQ+w2QVjXoxPm2HfZV4WTwjRzQ
	1iD9j7YFHLlXrivZu9N6jhMFjih0mqaOi6BD78j9bE0d2yM8Ig5q+FxO8/q+3ObxkWLTqAAdGJt
	Vdg==
X-Google-Smtp-Source: AGHT+IEOMhUIEJb7HA5wBTCErVAFDrxkcdBMavuoBSriks4hlucPD3WdjFvME0Ck5+1DRkZ02jm1mHkhvMQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:9d:3983:ac13:c240])
 (user=seanjc job=sendgmr) by 2002:aa7:9d81:0:b0:71e:5bf6:fef0 with SMTP id
 d2e1a72fcca58-71e7db6d5b2mr1783b3a.6.1729007883292; Tue, 15 Oct 2024 08:58:03
 -0700 (PDT)
Date: Tue, 15 Oct 2024 08:58:01 -0700
In-Reply-To: <87h69dg4og.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241004140810.34231-1-nikwip@amazon.de> <20241004140810.34231-3-nikwip@amazon.de>
 <875xq0gws8.fsf@redhat.com> <9ef935db-459a-4738-ab9a-4bd08828cb60@gmx.de> <87h69dg4og.fsf@redhat.com>
Message-ID: <Zw6PlAv4H5rNZsBf@google.com>
Subject: Re: [PATCH 2/7] KVM: x86: Implement Hyper-V's vCPU suspended state
From: Sean Christopherson <seanjc@google.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Nikolas Wipper <nik.wipper@gmx.de>, Nikolas Wipper <nikwip@amazon.de>, 
	Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf <graf@amazon.de>, James Gowans <jgowans@amazon.com>, 
	nh-open-source@amazon.com, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Tue, Oct 15, 2024, Vitaly Kuznetsov wrote:
> Nikolas Wipper <nik.wipper@gmx.de> writes:
> 
> > On 10.10.24 10:57, Vitaly Kuznetsov wrote:
> 
> ...
> 
> >>>  int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
> >>> +
> >>> +static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
> >>> +{
> >>> +	return vcpu->arch.hyperv_enabled &&
> >>> +	       READ_ONCE(vcpu->arch.hyperv->suspended);
> >>
> >> I don't think READ_ONCE() means anything here, does it?
> >>
> >
> > It does prevent compiler optimisations and is actually required[1]. Also
> > it makes clear that this variable is shared, and may be accessed from
> > remote CPUs.
> >
> > [1] https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2018/p0124r6.html#Variable%20Access
> 
> It certainly does no harm but I think if we follow 'Loads from and
> stores to shared (but non-atomic) variables should be protected with the
> READ_ONCE(), WRITE_ONCE()' rule literally we will need to sprinkle them
> all over KVM/kernel ;-) And personally, this makes reading the code
> harder.
> 
> To my (very limited) knowledge, we really need READ_ONCE()s when we need
> to have some sort of a serialization, e.g. the moment when this read
> happens actually makes a difference. If we can e.g. use a local variable
> in the beginning of a function and replace all READ_ONCE()s with
> reading this local variable -- then we don't need READ_ONCE()s and are
> OK with possible compiler optimizations. Similar (reversed) thoughts go
> to WRITE_ONCE().
> 
> I think it's OK to keep them but it would be nice (not mandatory IMO,
> but nice) to have a comment describing which particular synchronization
> we are achieving (== the compiler optimization scenario we are protecting
> against). 
> 
> In this particular case, kvm_hv_vcpu_suspended() is inline so I briefly
> looked at all kvm_hv_vcpu_suspended() call sites (there are three) in
> your series but couldn't think of a place where the READ_ONCE() makes a
> real difference. kvm_hv_hypercall_complete() looks pretty safe
> anyway. kvm_hv_vcpu_unsuspend_tlb_flush() will be simplified
> significantly if we merge 'suspended' with 'waiting_on': instead of 
> 
>       kvm_for_each_vcpu(i, v, vcpu->kvm) {
>               vcpu_hv = to_hv_vcpu(v);
> 
>               if (kvm_hv_vcpu_suspended(v) &&
>                   READ_ONCE(vcpu_hv->waiting_on) == vcpu->vcpu_id) {
> ...
> 
> you will have just
> 
>       kvm_for_each_vcpu(i, v, vcpu->kvm) {
>               vcpu_hv = to_hv_vcpu(v);
> 
>               if (vcpu_hv && vcpu_hv->waiting_on == vcpu->vcpu_id) {
> ...
> (and yes, I also think that READ_ONCE() is superfluous here, as real
> (non-speculative) write below can't happen _before_ the check )
> 
> The last one, kvm_vcpu_running(), should also be indifferent to
> READ_ONCE() in kvm_hv_vcpu_suspended(). I may had missed something, of
> course, but I hope you got my line of thought.

I don't think you're missing anything.  In general, all of this code is more than
a bit heavy-handed and lacks any kind of precision, which makes it *really* hard
to see what actually guarantees a vCPU won't get stuck blocking.

Writers synchronize SRCU and readers are required to acquire SRCU, but there's
no actual data tagged as being protected by SRCU, i.e. tlb_flush_inhibit should
be __rcu.

All of the {READ,WRITE}_ONCE() stuff provides some implicit compiler barriers,
but the actual protection to ensure a vCPU either observes inhibit=false or a wake
event is provided by the smp_wmb() in __kvm_make_request().

And from a performance perspective, synchronizing on kvm->srcu is going to be
susceptible to random slowdowns, because writers will have to wait until all vCPUs
drop SRCU, even if they have nothing to do with PV TLB flushes.  E.g. if vCPUs
are faulting in memory from swap, uninhibiting a TLB flushes could be stalled
unnecessarily for an extended duration.

Lastly, KVM_REQ_EVENT is a big hammer (triggers a lot of processing) and semantically
misleading (there is no event to process).  At a glance, KVM_REQ_UNBLOCK is likely
more appropriate.

Before we spend too much time cleaning things up, I want to first settle on the
overall design, because it's not clear to me that punting HvTranslateVirtualAddress
to userspace is a net positive.  We agreed that VTLs should be modeled primarily
in userspace, but that doesn't automatically make punting everything to userspace
the best option, especially given the discussion at KVM Forum with respect to
mplementing VTLs, VMPLs, TD partitions, etc.

The cover letters for this series and KVM_TRANSLATE2 simply say they're needed
for HvTranslateVirtualAddress, but neither series nor Nicolas' patch to punt
HVCALL_TRANSLATE_VIRTUAL_ADDRESS[*] justifies the split between userspace and
KVM.  And it very much is a split, because there are obviously a lot of details
around TlbFlushInhibit that bleed into KVM.

Side topic, what actually clears HvRegisterInterceptSuspend.TlbFlushInhibit?  The
TLFS just says 

  After the memory intercept routine performs instruction completion, it should
  clear the TlbFlushInhibit bit of the HvRegisterInterceptSuspend register.

but I can't find anything that says _how_ it clears TlbFlushInhibit.

[*] https://lore.kernel.org/all/20240609154945.55332-8-nsaenz@amazon.com

