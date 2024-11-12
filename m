Return-Path: <linux-kselftest+bounces-21872-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BEA9C5AB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 15:43:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082D828A387
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Nov 2024 14:43:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1E5200C8D;
	Tue, 12 Nov 2024 14:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="jlJP+DXD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EF41FF5EB;
	Tue, 12 Nov 2024 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731422452; cv=none; b=HpnvSyYZOMmjmwAHr3FUAaijoKmn6SfvQN2Fay0xWeCaCrgM4V8fht6PESIXRH1OBsUevy+Wpvj6c6UHwHMj7SCzVeWdTU16utGtkAU/CxW4WQ8bN6mMRpTwVsKiA8rmhkITEaJlPj3vKuuRQw1Pe6MrpRyZHtJM3142wqn3kqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731422452; c=relaxed/simple;
	bh=86/oEwhJaaqF1ro8RpdbRVewta890HkENWKQJqjYIk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=R8jLu/Sbt1v0KU78vRRhiPM6zGuRj7XRI08f81VSZJF7mqKAmf3xUCjcwmPo7r8SkWyiWIGu75V+1NKvNsKW1hkN2siV3ZpSWc6p+0PPss4LlR/B0WxgcIk1EL6R6ID5rcLTXtkmZZtgNdwk9qcxCXwluveRj9jHGrntq04Aofk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=jlJP+DXD; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1731422451; x=1762958451;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nb3ZPMcPqSuSW35JdPXTP3uJnDnzKc6cTb8i3ccTWUQ=;
  b=jlJP+DXDxawhnMCz2rxBBhLvKEs2pL4wyDrbwO8p9evpBLc48cv8QQog
   2dOdxfob4ni6rVgBoHbWksvILH9BeUPpLpLwlyWwVLxC7lWSUGdjnlVdY
   jhngP3Ql/Bnf10JX3Y28Va+/auv1YbZGMjqcrHpl0tzVpN2PCy+tMvBMC
   g=;
X-IronPort-AV: E=Sophos;i="6.12,148,1728950400"; 
   d="scan'208";a="351640181"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 14:40:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:63790]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.163:2525] with esmtp (Farcaster)
 id 26affe4d-b14b-4016-968a-2de60122a39b; Tue, 12 Nov 2024 14:40:47 +0000 (UTC)
X-Farcaster-Flow-ID: 26affe4d-b14b-4016-968a-2de60122a39b
Received: from EX19D003UWB002.ant.amazon.com (10.13.138.11) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 12 Nov 2024 14:40:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D003UWB002.ant.amazon.com (10.13.138.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 12 Nov 2024 14:40:40 +0000
Received: from email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Tue, 12 Nov 2024 14:40:40 +0000
Received: from [127.0.0.1] (dev-dsk-roypat-1c-dbe2a224.eu-west-1.amazon.com [172.19.88.180])
	by email-imr-corp-prod-pdx-all-2b-a57195ef.us-west-2.amazon.com (Postfix) with ESMTPS id 53DF2A0219;
	Tue, 12 Nov 2024 14:40:33 +0000 (UTC)
Message-ID: <02f77d32-e2a1-431b-bb67-33d36c06acd3@amazon.co.uk>
Date: Tue, 12 Nov 2024 14:40:32 +0000
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
	<linux-trace-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<faresx@amazon.com>
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <4aa0ccf4-ebbe-4244-bc85-8bc8dcd14e74@redhat.com>
 <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
 <d1a69eb7-85d5-4ffa-88e2-f4841713c1d7@redhat.com>
 <90c9d8c0-814e-4c86-86ef-439cb5552cb6@amazon.co.uk>
 <10e4d078-3cdb-4d1c-a1a3-80e91b247217@redhat.com>
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
In-Reply-To: <10e4d078-3cdb-4d1c-a1a3-80e91b247217@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit


Hi David, 

sorry for the late response, I ended up catching the flu last week and
was out of commission for a while :(

On Mon, 2024-11-04 at 21:30 +0000, David Hildenbrand wrote:
>>> We talked about shared (faultable) vs. private (unfaultable), and how it
>>> would interact with the directmap patches here.
>>>
>>> As discussed, having private (unfaultable) memory with the direct-map
>>> removed and shared (faultable) memory with the direct-mapping can make
>>> sense for non-TDX/AMD-SEV/... non-CoCo use cases. Not sure about CoCo,
>>> the discussion here seems to indicate that it might currently not be
>>> required.
>>>
>>> So one thing we could do is that shared (faultable) will have a direct
>>> mapping and be gup-able and private (unfaultable) memory will not have a
>>> direct mapping and is, by design, not gup-able.>
>>> Maybe it could make sense to not have a direct map for all guest_memfd
>>> memory, making it behave like secretmem (and it would be easy to
>>> implement)? But I'm not sure if that is really desirable in VM context.
>>
>> This would work for us (in this scenario, the swiotlb areas would be
>> "traditional" memory, e.g. set to shared via mem attributes instead of
>> "shared" inside KVM), it's kinda what I had prototyped in my v1 of this
>> series (well, we'd need to figure out how to get the mappings of gmem
>> back into KVM, since in this setup, short-circuiting it into
>> userspace_addr wouldn't work, unless we banish swiotlb into a different
>> memslot altogether somehow).
> 
> Right.

"right" as in, "yes we could do that"? :p

>> But I don't think it'd work for pKVM, iirc
>> they need GUP on gmem, and also want direct map removal (... but maybe,
>> the gmem VMA for non-CoCo usecase and the gmem VMA for pKVM could be
>> behave differently?  non-CoCo gets essentially memfd_secret, pKVM gets
>> GUP+no faults of private mem).
> 
> Good question. So far my perception was that the directmap removal on
> "private/unfaultable" would be sufficient.
> 
>>
>>> Having a mixture of "has directmap" and "has no directmap" for shared
>>> (faultable) memory should not be done. Similarly, private memory really
>>> should stay "unfaultable".
>>
>> You've convinced me that having both GUP-able and non GUP-able
>> memory in the same VMA will be tricky. However, I'm less convinced on
>> why private memory should stay unfaultable; only that it shouldn't be
>> faultable into a VMA that also allows GUP. Can we have two VMAs? One
>> that disallows GUP, but allows userspace access to shared and private,
>> and one that allows GUP, but disallows accessing private memory? Maybe
>> via some `PROT_NOGUP` flag to `mmap`? I guess this is a slightly
>> different spin of the above idea.
> 
> What we are trying to achieve is making guest_memfd not behave
> completely different on that level for different "types" of VMs. So one
> of the goals should be to try to unify it as much as possible.
> 
> shared -> faultable: GUP-able
> private -> unfaultable: unGUP-able
> 
> 
> And it makes sense, because a lot of future work will rely on some
> important properties: for example, if private memory cannot be faulted
> in + GUPed, core-MM will never have obtained valid references to such a
> page. There is no need to split large folios into smaller ones for
> tracking purposes; there is no need to maintain per-page refcounts and
> pincounts ...
> 
> It doesn't mean that we cannot consider it if really required, but there
> really has to be a strong case for it, because it will all get really messy.
> 
> For example, one issue is that a folio only has a single mapping
> (folio->mapping), and that is used in the GUP-fast path (no VMA) to
> determine whether GUP-fast is allowed or not.
> 
> So you'd have to force everything through GUP-slow, where you could
> consider VMA properties :( It sounds quite suboptimal.
> 
> I don't think multiple VMAs are what we really want. See below.

Ah, okay, I see. Thanks for explaining, this all makes a lot of sense to
me now!

>>
>>> I think one of the points raised during the bi-weekly call was that
>>> using a viommu/swiotlb might be the right call, such that all memory can
>>> be considered private (unfaultable) that is not explicitly
>>> shared/expected to be modified by the hypervisor (-> faultable, ->
>>> GUP-able).
>>>
>>> Further, I think Sean had some good points why we should explore that
>>> direction, but I recall that there were some issue to be sorted out
>>> (interpreted instructions requiring direct map when accessing "private"
>>> memory?), not sure if that is already working/can be made working in KVM.
>>
>> Yeah, the big one is MMIO instruction emulation on x86, which does guest
>> page table walks and instruction fetch (and particularly the latter
>> cannot be known ahead-of-time by the guest, aka cannot be explicitly
>> "shared"). That's what the majority of my v2 series was about. For
>> traditional memslots, KVM handles these via get_user and friends, but if
>> we don't have a VMA that allows faulting all of gmem, then that's
>> impossible, and we're in "temporarily restore direct map" land. Which
>> comes with significantly performance penalties due to TLB flushes.
> 
> Agreed.
> 
>> >> What's your opinion after the call and the next step for use cases
> like
>>> you have in mind (IIRC firecracker, which wants to not have the
>>> direct-map for guest memory where it can be avoided)?
>>
>> Yea, the usecase is for Firecracker to not have direct map entries for
>> guest memory, unless needed for I/O (-> swiotlb).
>>
>> As for next steps, let's determine once and for all if we can do the
>> KVM-internal guest memory accesses for MMIO emulation through userspace
>> mappings (although if we can't I'll have some serious soul-searching to
>> do, because all other solutions we talked about so far also have fairly
>> big drawbacks; on-demand direct map reinsertion has terrible
>> performance
> So IIUC, KVM would have to access "unfaultable" guest_memfd memory using
> fd+offset, and that's problematic because "no-directmap".
> 
> So you'd have to map+unmap the directmap repeatedly, and still expose it
> temporarily in the direct map to others. I see how that is undesirable,
> even when trying to cache hotspots (partly destroying the purpose of the
> directmap removal).
> 
> 
> Would a per-MM kernel mapping of these pages work, so KVM can access them?
> 
> It sounds a bit like what is required for clean per-MM allocations [1]:
> establish a per-MM kernel mapping of (selected?) pages. Not necessarily
> all of them.
> 
> Yes, we'd be avoiding VMAs, GUP, mapcounts, pincounts and everything
> involved with ordinary user mappings for these private/unfaultable
> thingies. Just like as discussed in, and similar to [1].
> 
> Just throwing it out there, maybe we really want to avoid the directmap
> (keep it unmapped) and maintain a per-mm mapping for a bunch of folios
> that can be easily removed when required by guest_memfd (ftruncate,
> conversion private->shared) on request.

I remember talking to someone at some point about whether we could reuse
the proc-local stuff for guest memory, but I cannot remember the outcome
of that discussion... (or maybe I just wanted to have a discussion about
it, but forgot to follow up on that thought?).  I guess we wouldn't use
proc-local _allocations_, but rather just set up proc-local mappings of
the gmem allocations that have been removed from the direct map.

I'm wondering, where exactly would be the differences to Sean's idea
about messing with the CR3 register inside KVM to temporarily install
page tables that contain all the gmem stuff, conceptually? Wouldn't we
run into the same interrupt problems that Sean foresaw for the CR3
stuff? (which, admittedly, I still don't quite follow what these are :(
).

(I've cc'd Fares Mehanna as well)

> [1] https://lore.kernel.org/all/20240911143421.85612-1-faresx@amazon.de/T/#u
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

Best,
Patrick

