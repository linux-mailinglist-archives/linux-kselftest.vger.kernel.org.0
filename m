Return-Path: <linux-kselftest+bounces-21383-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9B99BB577
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 14:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AD81F21D24
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 13:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26B11BD004;
	Mon,  4 Nov 2024 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="QoTIF90w"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D74A1BCA0A;
	Mon,  4 Nov 2024 13:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725836; cv=none; b=SdxEWwYhFu8XBOMhS+FwFcSwwEavDKuGVEaTJndb1gzXetXPc1yPtRtSnG6akP0GL+QTWEXZoXw2EYmNCkPEB8WZ7rpb9MQq9fNGgDBnl6F9FQHezWeZrryGDWuFhGAaLgHkTM5gLyomPNWjCEsikg0u86n6B9hTLCxYMu70Qwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725836; c=relaxed/simple;
	bh=Z2mbvpWFAdMTDdYcO4ugyL1b/eLURJbnO0cdjQkMi0g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aTxoXK6YzjHYIwg2lvQYUZlpXg8hVxTYtoup7yFB898d4uH9CKQhu3ayW/XbG4C0p0MYk3l6EVkjU88+++ctvWubTJI//rnpjv5UV2SR8NkFvHvOgxCQthGQPsjg8qYssd3W2bOp39AuryeopnRBPhwAGT9Lg/HqfFeRKbihgF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=QoTIF90w; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1730725835; x=1762261835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1btoMBa04UyDS7nxAQeta6RxSxmw/jW1eQwuNLcFWgs=;
  b=QoTIF90wZ8QEM6c9ZU1c6D0fCy/devysZRUFiMxBNaDETFcCS5TF0buN
   ySxxtWnlKlPf32IA5bfYodyMaJudiRTQRBTDk+pHfQX1kDo9YrHYf+PEz
   nip4s4G7eE/JK5iAUVs1d1cAILUXF5mKVrE/AHe/DprZ0wqumiJEKW/CR
   s=;
X-IronPort-AV: E=Sophos;i="6.11,257,1725321600"; 
   d="scan'208";a="1844949"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 13:10:06 +0000
Received: from EX19MTAEUB002.ant.amazon.com [10.0.10.100:54379]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.22.75:2525] with esmtp (Farcaster)
 id 22e5bca5-2878-4e31-8cc8-18fdd76ac967; Mon, 4 Nov 2024 13:10:04 +0000 (UTC)
X-Farcaster-Flow-ID: 22e5bca5-2878-4e31-8cc8-18fdd76ac967
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19MTAEUB002.ant.amazon.com (10.252.51.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 4 Nov 2024 13:09:59 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D022EUA002.ant.amazon.com (10.252.50.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 4 Nov 2024 13:09:59 +0000
Received: from email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 4 Nov 2024 13:09:59 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-iad-all-1b-a03c1db8.us-east-1.amazon.com (Postfix) with ESMTPS id 238228042B;
	Mon,  4 Nov 2024 13:09:54 +0000 (UTC)
Message-ID: <90c9d8c0-814e-4c86-86ef-439cb5552cb6@amazon.co.uk>
Date: Mon, 4 Nov 2024 13:09:53 +0000
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
To: David Hildenbrand <david@redhat.com>, <tabba@google.com>,
	<quic_eberman@quicinc.com>, <seanjc@google.com>, <pbonzini@redhat.com>,
	<jthoughton@google.com>, <ackerleytng@google.com>, <vannapurve@google.com>,
	<rppt@kernel.org>
CC: <graf@amazon.com>, <jgowans@amazon.com>, <derekmn@amazon.com>,
	<kalyazin@amazon.com>, <xmarcalx@amazon.com>, <linux-mm@kvack.org>,
	<corbet@lwn.net>, <catalin.marinas@arm.com>, <will@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <paul.walmsley@sifive.com>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <gerald.schaefer@linux.ibm.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <luto@kernel.org>, <peterz@infradead.org>,
	<rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <shuah@kernel.org>, <kvm@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <loongarch@lists.linux.dev>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <4aa0ccf4-ebbe-4244-bc85-8bc8dcd14e74@redhat.com>
 <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
 <d1a69eb7-85d5-4ffa-88e2-f4841713c1d7@redhat.com>
From: Patrick Roy <roypat@amazon.co.uk>
Content-Language: en-US
Autocrypt: addr=roypat@amazon.co.uk; keydata=
 xjMEY0UgYhYJKwYBBAHaRw8BAQdA7lj+ADr5b96qBcdINFVJSOg8RGtKthL5x77F2ABMh4PN
 NVBhdHJpY2sgUm95IChHaXRodWIga2V5IGFtYXpvbikgPHJveXBhdEBhbWF6b24uY28udWs+
 wpMEExYKADsWIQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbAwULCQgHAgIiAgYVCgkI
 CwIEFgIDAQIeBwIXgAAKCRBVg4tqeAbEAmQKAQC1jMl/KT9pQHEdALF7SA1iJ9tpA5ppl1J9
 AOIP7Nr9SwD/fvIWkq0QDnq69eK7HqW14CA7AToCF6NBqZ8r7ksi+QLOOARjRSBiEgorBgEE
 AZdVAQUBAQdAqoMhGmiXJ3DMGeXrlaDA+v/aF/ah7ARbFV4ukHyz+CkDAQgHwngEGBYKACAW
 IQQ5DAcjaM+IvmZPLohVg4tqeAbEAgUCY0UgYgIbDAAKCRBVg4tqeAbEAtjHAQDkh5jZRIsZ
 7JMNkPMSCd5PuSy0/Gdx8LGgsxxPMZwePgEAn5Tnh4fVbf00esnoK588bYQgJBioXtuXhtom
 8hlxFQM=
In-Reply-To: <d1a69eb7-85d5-4ffa-88e2-f4841713c1d7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


Hi David,

On 11/4/24 12:18, David Hildenbrand wrote:
> On 31.10.24 11:42, Patrick Roy wrote:
>> On Thu, 2024-10-31 at 09:50 +0000, David Hildenbrand wrote:
>>> On 30.10.24 14:49, Patrick Roy wrote:
>>>> Unmapping virtual machine guest memory from the host kernel's direct map
>>>> is a successful mitigation against Spectre-style transient execution
>>>> issues: If the kernel page tables do not contain entries pointing to
>>>> guest memory, then any attempted speculative read through the direct map
>>>> will necessarily be blocked by the MMU before any observable
>>>> microarchitectural side-effects happen. This means that Spectre-gadgets
>>>> and similar cannot be used to target virtual machine memory. Roughly 60%
>>>> of speculative execution issues fall into this category [1, Table 1].
>>>>
>>>> This patch series extends guest_memfd with the ability to remove its
>>>> memory from the host kernel's direct map, to be able to attain the above
>>>> protection for KVM guests running inside guest_memfd.
>>>>
>>>> === Changes to v2 ===
>>>>
>>>> - Handle direct map removal for physically contiguous pages in arch code
>>>>     (Mike R.)
>>>> - Track the direct map state in guest_memfd itself instead of at the
>>>>     folio level, to prepare for huge pages support (Sean C.)
>>>> - Allow configuring direct map state of not-yet faulted in memory
>>>>     (Vishal A.)
>>>> - Pay attention to alignment in ftrace structs (Steven R.)
>>>>
>>>> Most significantly, I've reduced the patch series to focus only on
>>>> direct map removal for guest_memfd for now, leaving the whole "how to do
>>>> non-CoCo VMs in guest_memfd" for later. If this separation is
>>>> acceptable, then I think I can drop the RFC tag in the next revision
>>>> (I've mainly kept it here because I'm not entirely sure what to do with
>>>> patches 3 and 4).
>>>
>>> Hi,
>>>
>>> keeping upcoming "shared and private memory in guest_memfd" in mind, I
>>> assume the focus would be to only remove the direct map for private memory?
>>>
>>> So in the current upstream state, you would only be removing the direct
>>> map for private memory, currently translating to "encrypted"/"protected"
>>> memory that is inaccessible either way already.
>>>
>>> Correct?
>>
>> Yea, with the upcomming "shared and private" stuff, I would expect the
>> the shared<->private conversions would call the routines from patch 3 to
>> restore direct map entries on private->shared, and zap them on
>> shared->private.
> 
> I wanted to follow-up to the discussion we had in the bi-weekly call.

Thanks for summarizing!

> We talked about shared (faultable) vs. private (unfaultable), and how it
> would interact with the directmap patches here.
> 
> As discussed, having private (unfaultable) memory with the direct-map
> removed and shared (faultable) memory with the direct-mapping can make
> sense for non-TDX/AMD-SEV/... non-CoCo use cases. Not sure about CoCo,
> the discussion here seems to indicate that it might currently not be
> required.
>
> So one thing we could do is that shared (faultable) will have a direct
> mapping and be gup-able and private (unfaultable) memory will not have a
> direct mapping and is, by design, not gup-able.> 
> Maybe it could make sense to not have a direct map for all guest_memfd
> memory, making it behave like secretmem (and it would be easy to
> implement)? But I'm not sure if that is really desirable in VM context.

This would work for us (in this scenario, the swiotlb areas would be
"traditional" memory, e.g. set to shared via mem attributes instead of
"shared" inside KVM), it's kinda what I had prototyped in my v1 of this
series (well, we'd need to figure out how to get the mappings of gmem
back into KVM, since in this setup, short-circuiting it into
userspace_addr wouldn't work, unless we banish swiotlb into a different
memslot altogether somehow). But I don't think it'd work for pKVM, iirc
they need GUP on gmem, and also want direct map removal (... but maybe,
the gmem VMA for non-CoCo usecase and the gmem VMA for pKVM could be
behave differently?  non-CoCo gets essentially memfd_secret, pKVM gets
GUP+no faults of private mem).

> Having a mixture of "has directmap" and "has no directmap" for shared
> (faultable) memory should not be done. Similarly, private memory really
> should stay "unfaultable".

You've convinced me that having both GUP-able and non GUP-able
memory in the same VMA will be tricky. However, I'm less convinced on
why private memory should stay unfaultable; only that it shouldn't be
faultable into a VMA that also allows GUP. Can we have two VMAs? One
that disallows GUP, but allows userspace access to shared and private,
and one that allows GUP, but disallows accessing private memory? Maybe
via some `PROT_NOGUP` flag to `mmap`? I guess this is a slightly
different spin of the above idea.

> I think one of the points raised during the bi-weekly call was that
> using a viommu/swiotlb might be the right call, such that all memory can
> be considered private (unfaultable) that is not explicitly
> shared/expected to be modified by the hypervisor (-> faultable, ->
> GUP-able).
> 
> Further, I think Sean had some good points why we should explore that
> direction, but I recall that there were some issue to be sorted out
> (interpreted instructions requiring direct map when accessing "private"
> memory?), not sure if that is already working/can be made working in KVM.

Yeah, the big one is MMIO instruction emulation on x86, which does guest
page table walks and instruction fetch (and particularly the latter
cannot be known ahead-of-time by the guest, aka cannot be explicitly
"shared"). That's what the majority of my v2 series was about. For
traditional memslots, KVM handles these via get_user and friends, but if
we don't have a VMA that allows faulting all of gmem, then that's
impossible, and we're in "temporarily restore direct map" land. Which
comes with significantly performance penalties due to TLB flushes.

> What's your opinion after the call and the next step for use cases like
> you have in mind (IIRC firecracker, which wants to not have the
> direct-map for guest memory where it can be avoided)?

Yea, the usecase is for Firecracker to not have direct map entries for
guest memory, unless needed for I/O (-> swiotlb).

As for next steps, let's determine once and for all if we can do the
KVM-internal guest memory accesses for MMIO emulation through userspace
mappings (although if we can't I'll have some serious soul-searching to
do, because all other solutions we talked about so far also have fairly
big drawbacks; on-demand direct map reinsertion has terrible
performance, protection keys would limit us to 15 VMs on the host, and
the page table swapping runs into problems with NMIs if I understood
Sean correctly last Thursday :( ).

> -- 
> Cheers,
> 
> David / dhildenb

Best, 
Patrick

