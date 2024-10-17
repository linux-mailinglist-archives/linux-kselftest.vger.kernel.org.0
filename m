Return-Path: <linux-kselftest+bounces-20081-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5AC9A3139
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Oct 2024 01:17:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C95C1F22B64
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Oct 2024 23:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB86B1DC07B;
	Thu, 17 Oct 2024 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WW5e5zZe"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ECB1DB52D
	for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 23:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729207013; cv=none; b=B5Q2qN+q0GGQRn8hF2bV43EaPj4fOEa9HiqtrQI462DG9QqR/LtHNRi/fEe4jSWOvoSLLx0PAYMSr7aD0IB5xnIcEPi0wSEadr1VcW4afroHrTdooNUwlomcd1NoglASIgBL6lLHby6jDAIZd0NvFUNpLPtS78HvFra5O7Z8cfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729207013; c=relaxed/simple;
	bh=CO0aJ2bY3OsdoAPHAL3+Tvt6FE0uEF/LdS+FrYf7Ccg=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ILnpAoZnqDtgNOITmaKAscnJ3MVaJr0THNpqv9ssQGoF1hLxtGDUa3sqDnsGQsmw3gQw163E+Myc1Q523DZJRMJtNn9DJ7qHoWsB/FNoLMB00Os8U/dWvkrH7xoUNr0pl4FkCXY4HEzHrncuS5VhbLveCeZJDp5t6kAkVJ5+zxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WW5e5zZe; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ackerleytng.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e355f1ff4bso27037857b3.2
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Oct 2024 16:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729207011; x=1729811811; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+zYjnaVq7JQQfvY4k20WgcRhuiQAGDSrTu1qY7s0RHI=;
        b=WW5e5zZeKj+O3IT8aN3gqZJjF+7dNkxIMhxDxCyQXBvYR6/fSCNYpkb+q9FQucrPOU
         MnCjxXssIRrbicWpxFFSna1jdK6g0nIw4nAXu6YDYp095tL+4+JorDk38+eguwt994Uw
         jPcsjc4YbS9ohDHKLVZUhoGC0FZwY2sV6nmJsEL+wRvN4lntPOGlUdpqZFrvoyEuzeer
         HiT9ad6B4c9HCKN0IB2WqNzydvMxShNOAWMq+tTtoHYdGRR7EHM7+yvZGeNPh8kNQATq
         dT7NYY6rue2k8zLgFfHdduirKczg9Pq+8YWHDjXdyM0XDI4iPI+nBlo+b16bxGoHaOyX
         DHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729207011; x=1729811811;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+zYjnaVq7JQQfvY4k20WgcRhuiQAGDSrTu1qY7s0RHI=;
        b=A0eI3r1n7fLpuBslaJ2L85WAczJMb04QXrwh7B9Twb2ZCup2Q45miqlkDJtj0zCpRV
         76BJbtZA03/bu/jp59VaQu696KSH4EotoFvTBScblYMfLDDS9u/DJmOBi9r02UQRfSGP
         e3yMLzKryr2ThNCwmZstjuKXcdUwaEXlmod5VKKkYIdFgZIIJDt5UbuUM3q87djgsI8e
         C5I80JggUAwBCE4qGgYymEcwG7XhW+DsJZ9s6cws1rsA0uHDEiTvubzn4cyx2hZpSj43
         /CfnwIQplti83VSqwWhKiqPoaxup+xrTGZoIBMI5nG9u483Kngugp++0rpKKClOc5peh
         Tukw==
X-Forwarded-Encrypted: i=1; AJvYcCXkOntuEk2HrAfO12GRVgk6NdwQM+/YxR2H4atJ4WYdokWRdcQx4/22V4ygSIbWzySDV9bPem5bAP7wcP/c1eg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiarfPHzPTvwr+eWIi56F2vniEOt5pmt014mxfcaaeg1wZQlZ
	xAiFp9K5MhNRzNuqPmhbS1topMtYSRnfDLcUMT6gMsJB0wmmFdP5ExxSCH8NRGCOYVhXRdAJNWq
	UrGw0Ndg4XZAd3aVBmO62SQ==
X-Google-Smtp-Source: AGHT+IFfV6eQbYhNulYjT+WCqGWPQRoZrQ0tbhfX4Hz/hMhhogXLArIjar7wjJ6r+VUqZczFoagDpAxBGwKDnqHV4g==
X-Received: from ackerleytng-ctop-specialist.c.googlers.com
 ([fda3:e722:ac3:cc00:7f:e700:c0a8:1612]) (user=ackerleytng job=sendgmr) by
 2002:a05:690c:700d:b0:6db:c34f:9e4f with SMTP id 00721157ae682-6e5bfc716e3mr161057b3.8.1729207011089;
 Thu, 17 Oct 2024 16:16:51 -0700 (PDT)
Date: Thu, 17 Oct 2024 23:16:49 +0000
In-Reply-To: <6bca3ad4-3eca-4a75-a775-5f8b0467d7a3@amazon.co.uk> (message from
 Patrick Roy on Thu, 10 Oct 2024 17:21:11 +0100)
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <diqzr08exqu6.fsf@ackerleytng-ctop-specialist.c.googlers.com>
Subject: Re: [RFC PATCH 30/39] KVM: guest_memfd: Handle folio preparation for
 guest_memfd mmap
From: Ackerley Tng <ackerleytng@google.com>
To: Patrick Roy <roypat@amazon.co.uk>
Cc: seanjc@google.com, quic_eberman@quicinc.com, tabba@google.com, 
	jgg@nvidia.com, peterx@redhat.com, david@redhat.com, rientjes@google.com, 
	fvdl@google.com, jthoughton@google.com, pbonzini@redhat.com, 
	zhiquan1.li@intel.com, fan.du@intel.com, jun.miao@intel.com, 
	isaku.yamahata@intel.com, muchun.song@linux.dev, mike.kravetz@oracle.com, 
	erdemaktas@google.com, vannapurve@google.com, qperret@google.com, 
	jhubbard@nvidia.com, willy@infradead.org, shuah@kernel.org, 
	brauner@kernel.org, bfoster@redhat.com, kent.overstreet@linux.dev, 
	pvorel@suse.cz, rppt@kernel.org, richard.weiyang@gmail.com, 
	anup@brainfault.org, haibo1.xu@intel.com, ajones@ventanamicro.com, 
	vkuznets@redhat.com, maciej.wieczor-retman@intel.com, pgonda@google.com, 
	oliver.upton@linux.dev, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-fsdevel@kvack.org, 
	jgowans@amazon.com, kalyazin@amazon.co.uk, derekmn@amazon.com
Content-Type: text/plain; charset="UTF-8"

Patrick Roy <roypat@amazon.co.uk> writes:

> On Tue, 2024-10-08 at 20:56 +0100, Sean Christopherson wrote:
>> On Tue, Oct 08, 2024, Ackerley Tng wrote:
>>> Patrick Roy <roypat@amazon.co.uk> writes:
>>>> For the "non-CoCo with direct map entries removed" VMs that we at AWS
>>>> are going for, we'd like a VM type with host-controlled in-place
>>>> conversions which doesn't zero on transitions,
>> 
>> Hmm, your use case shouldn't need conversions _for KVM_, as there's no need for
>> KVM to care if userspace or the guest _wants_ a page to be shared vs. private.
>> Userspace is fully trusted to manage things; KVM simply reacts to the current
>> state of things.
>> 
>> And more importantly, whether or not the direct map is zapped needs to be a
>> property of the guest_memfd inode, i.e. can't be associated with a struct kvm.
>> I forget who got volunteered to do the work,
>
> I think me? At least we talked about it briefly
>
>> but we're going to need similar
>> functionality for tracking the state of individual pages in a huge folio, as
>> folio_mark_uptodate() is too coarse-grained.  I.e. at some point, I expect that
>> guest_memfd will make it easy-ish to determine whether or not the direct map has
>> been obliterated.
>> 
>> The shared vs. private attributes tracking in KVM is still needed (I think), as
>> it communicates what userspace _wants_, whereas he guest_memfd machinery will
>> track what the state _is_.
>
> If I'm understanding this patch series correctly, the approach taken
> here is to force the KVM memory attributes and the internal guest_memfd
> state to be in-sync, because the VMA from mmap()ing guest_memfd is
> reflected back into the userspace_addr of the memslot.

In this patch series, we're also using guest_memfd state (faultability
xarray) to prevent any future faults before checking that there are no
mappings. Further explanation at [1].

Reason (a) at [1] is what Sean describes above to be what userspace
_wants_ vs what the state _is_.

> So, to me, in
> this world, "direct map zapped iff
> kvm_has_mem_attributes(KVM_MEMORY_ATTRIBUTES_PRIVATE)", with memory
> attribute changes forcing the corresponding gmem state change. That's
> why I was talking about conversions above.

I think if we do continue to have state in guest_memfd, then direct map
removal should be based on guest_memfd's state, rather than
KVM_MEMORY_ATTRIBUTE_PRIVATE in mem_attr_array.

> I've played around with this locally, and since KVM seems to generally
> use copy_from_user and friends to access the userspace_addr VMA, (aka
> private mem that's reflected back into memslots here), with this things
> like MMIO emulation can be oblivious to gmem's existence, since
> copy_from_user and co don't require GUP or presence of direct map
> entries (well, "oblivious" in the sense that things like kvm_read_guest
> currently ignore memory attributes and unconditionally access
> userspace_addr, which I suppose is not really wanted for VMs where
> userspace_addr and guest_memfd aren't short-circuited like this). The
> exception is kvm_clock, where the pv_time page would need to be
> explicitly converted to shared to restore the direct map entry, although
> I think we could just let userspace deal with making sure this page is
> shared (and then, if gmem supports GUP on shared memory, even the
> gfn_to_pfn_caches could work without gmem knowledge. Without GUP, we'd
> still need a tiny hack in the uhva->pfn translation somewhere to handle
> gmem vmas, but iirc you did mention that having kvm-clock be special
> might be fine).
>
> I guess it does come down to what you note below, answering the question
> of "how does KVM internally access guest_memfd for non-CoCo VMs".  Is
> there any way we can make uaccesses like above work? I've finally gotten
> around to re-running some performance benchmarks of my on-demand
> reinsertion patches with all the needed TLB flushes added, and my fio
> benchmark on a virtio-blk device suffers a ~50% throughput regression,
> which does not necessarily spark joy. And I think James H.  mentioned at
> LPC that making the userfault stuff work with my patches would be quite
> hard. All this in addition to you also not necessarily sounding too keen
> on it either :D
>
>>>> so if KVM_X86_SW_PROTECTED_VM ends up zeroing, we'd need to add another new
>>>> VM type for that.
>> 
>> Maybe we should sneak in a s/KVM_X86_SW_PROTECTED_VM/KVM_X86_SW_HARDENED_VM rename?
>> The original thought behind "software protected VM" was to do a slow build of
>> something akin to pKVM, but realistically I don't think that idea is going anywhere.
>
> Ah, admittedly I've thought of KVM_X86_SW_PROTECTED_VM as a bit of a
> playground where various configurations other VM types enforce can be
> mixed and matched (e.g. zero on conversions yes/no, direct map removal
> yes/no) so more of a KVM_X86_GMEM_VM, but am happy to update my
> understanding :) 
>

Given the different axes of possible configurations for guest_memfd
(zero on conversion, direct map removal), I think it's better to let
userspace choose, than to enumerate the combinations in VM types.

Independently of whether to use a flag or VM type to configure
guest_memfd, the "zeroed" state has to be stored somewhere.

For folios to at least be zeroed once, presence in the filemap could
indicated "zeroed".

Presence in the filemap may be awkward to use as an indication of
"zeroed" for the conversion case.

What else can we use to store "zeroed"? Suggestions: 

1. Since "prepared" already took the dirty bit on the folio, "zeroed"
   can use the checked bit on the folio. [2] indicates that it is for
   filesystems, which sounds like guest_memfd :)
2. folio->private (which we may already need to use)
3. Another xarray

>> <snip>

[1] https://lore.kernel.org/all/diqz1q0qtqnd.fsf@ackerleytng-ctop.c.googlers.com/T/#ma6f828d7a50c4de8a2f829a16c9bb458b53d8f3f
[2] https://elixir.bootlin.com/linux/v6.11.4/source/include/linux/page-flags.h#L147

