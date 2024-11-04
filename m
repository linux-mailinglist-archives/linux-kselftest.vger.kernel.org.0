Return-Path: <linux-kselftest+bounces-21407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D36AC9BC016
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 22:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 934C22828AE
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Nov 2024 21:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D041FCC75;
	Mon,  4 Nov 2024 21:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D2YttPEt"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F732199935
	for <linux-kselftest@vger.kernel.org>; Mon,  4 Nov 2024 21:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730755864; cv=none; b=scIpiY8i9pnI3PeuKHnmpijfHMMXAwvidi4qlkOmKV/Cikcp3AhkVoc8Obxxv8Q9X7ECyi1VjXctA40ODPjyHY6cPBsoFgWtrdn20yr/i/IGg2ioCBmoPdac2qGDLPXL/lc6LCZ2dwPL1GOukQva4Rix5q5JsdiEhrntC54evWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730755864; c=relaxed/simple;
	bh=L4YNKSkuZEV/hZj7pOw8iiKxbPrnNSbHsVLEZvSgA0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB9c6TAMlFCvirSQNwrGuNdYMC+/2wtS1oFjWdUtuJS/CtnIE1IpMWzUgvnL8zOz19TWhEHrzWW/AJA7YZwrnEfPxdcMF8dn0skNe37tbbC9K0ZW5DSg/xbcdp/JR0G6SkgHy+2xSe/3L5bxmvmtJieHfEpolkXBf6jwDxYQHD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D2YttPEt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730755861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=8gtfMet1sTXUCLzJyNvknJfnL40j6MbNvJoVn8lPrro=;
	b=D2YttPEtZHRKjYlwGGej9OzOBqWCIhLhHiByXn9EbE5I8jp1cpe6+gKGQst+D0I98GBdEn
	8BSDh8/Hh6mielGVvSqiMGjGmhf2H1bufwTFkKowK0wsPcHEJcNoBZMp99PDlRFAEFToZx
	3UygCMJg9SsdY+6P/s29MhwqL2LRdaE=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-wCPwmvOwOgeGTvMKj5oMIg-1; Mon, 04 Nov 2024 16:31:00 -0500
X-MC-Unique: wCPwmvOwOgeGTvMKj5oMIg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-539fb5677c9so4700308e87.0
        for <linux-kselftest@vger.kernel.org>; Mon, 04 Nov 2024 13:30:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730755858; x=1731360658;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8gtfMet1sTXUCLzJyNvknJfnL40j6MbNvJoVn8lPrro=;
        b=Zws0aZxB+vNPJ9KuJ1+HEEifRNrb9VFPBrxhwMUAtTWUFbNTTcSr8o7KENUpX2tIgh
         L1gss4+zHtC78Pp6pMXWGj7WmAjPt+eqpEi/d6EZaM4DJHStILR5hr+5Bz1MThhcrJ7y
         6bdRCsmtXhh+rdjq59pARjXEo9e+hqKg4CIBTv/OwuN1362RBGxWLveNYx/iqsRQOn7L
         H2HlsZDw4zFB7gf1K+RcAHaV1ShfMMZ1gcSkIRKfZhQTByvQ3aZF766QZWqtMvRr69sg
         Xm3k0BhgvIrJKZ+M6KT9zxRbV+aJ/oGhMvWy8nBhNsLsYaK+KCQaSEEb6+MeuSVjKkNZ
         Jhug==
X-Forwarded-Encrypted: i=1; AJvYcCUK4qRl4dmqXHjMVeqm2X5awUzA0AKjp1Q2CxDx76vvKKQDfSWUu+N7lsTu4fzh5RMBbVtjq616Vw8Tv6yJS44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr+NdkRnyc1OzocLOyvcmYVElWQqMpuAhaq4ko4+msKlPBjzAO
	JduOI9gAxtiz3Iw3uL+T/KyzspSWYGG7gLFv5RmJoMYG0bqmpuzlZl8RP/Wufk/c8IKqs5KBJbE
	6PkN+U7R0KFZL673Wlh4NQbFji6neCki7JTWMdiWnyKFgM7edn5IudM4Nv05ayITSRQ==
X-Received: by 2002:a05:6512:118a:b0:53b:1526:3a4c with SMTP id 2adb3069b0e04-53b348d894amr16609363e87.26.1730755858338;
        Mon, 04 Nov 2024 13:30:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7ORituTFTzp2MdetjVSX333muBt/1oz+5gl2SMZriCSkTuHWz0TGj9Uec44RVhT9sC9SApw==
X-Received: by 2002:a05:6512:118a:b0:53b:1526:3a4c with SMTP id 2adb3069b0e04-53b348d894amr16609326e87.26.1730755857778;
        Mon, 04 Nov 2024 13:30:57 -0800 (PST)
Received: from ?IPV6:2003:cb:c72f:e500:e96a:8043:1211:8e6a? (p200300cbc72fe500e96a804312118e6a.dip0.t-ipconnect.de. [2003:cb:c72f:e500:e96a:8043:1211:8e6a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7435sm14249477f8f.52.2024.11.04.13.30.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 13:30:56 -0800 (PST)
Message-ID: <10e4d078-3cdb-4d1c-a1a3-80e91b247217@redhat.com>
Date: Mon, 4 Nov 2024 22:30:53 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 0/6] Direct Map Removal for guest_memfd
To: Patrick Roy <roypat@amazon.co.uk>, tabba@google.com,
 quic_eberman@quicinc.com, seanjc@google.com, pbonzini@redhat.com,
 jthoughton@google.com, ackerleytng@google.com, vannapurve@google.com,
 rppt@kernel.org
Cc: graf@amazon.com, jgowans@amazon.com, derekmn@amazon.com,
 kalyazin@amazon.com, xmarcalx@amazon.com, linux-mm@kvack.org,
 corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
 chenhuacai@kernel.org, kernel@xen0n.name, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 hpa@zytor.com, luto@kernel.org, peterz@infradead.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, shuah@kernel.org,
 kvm@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 loongarch@lists.linux.dev, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241030134912.515725-1-roypat@amazon.co.uk>
 <4aa0ccf4-ebbe-4244-bc85-8bc8dcd14e74@redhat.com>
 <27646c08-f724-49f7-9f45-d03bad500219@amazon.co.uk>
 <d1a69eb7-85d5-4ffa-88e2-f4841713c1d7@redhat.com>
 <90c9d8c0-814e-4c86-86ef-439cb5552cb6@amazon.co.uk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <90c9d8c0-814e-4c86-86ef-439cb5552cb6@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> We talked about shared (faultable) vs. private (unfaultable), and how it
>> would interact with the directmap patches here.
>>
>> As discussed, having private (unfaultable) memory with the direct-map
>> removed and shared (faultable) memory with the direct-mapping can make
>> sense for non-TDX/AMD-SEV/... non-CoCo use cases. Not sure about CoCo,
>> the discussion here seems to indicate that it might currently not be
>> required.
>>
>> So one thing we could do is that shared (faultable) will have a direct
>> mapping and be gup-able and private (unfaultable) memory will not have a
>> direct mapping and is, by design, not gup-able.>
>> Maybe it could make sense to not have a direct map for all guest_memfd
>> memory, making it behave like secretmem (and it would be easy to
>> implement)? But I'm not sure if that is really desirable in VM context.
> 
> This would work for us (in this scenario, the swiotlb areas would be
> "traditional" memory, e.g. set to shared via mem attributes instead of
> "shared" inside KVM), it's kinda what I had prototyped in my v1 of this
> series (well, we'd need to figure out how to get the mappings of gmem
> back into KVM, since in this setup, short-circuiting it into
> userspace_addr wouldn't work, unless we banish swiotlb into a different
> memslot altogether somehow).

Right.

> But I don't think it'd work for pKVM, iirc
> they need GUP on gmem, and also want direct map removal (... but maybe,
> the gmem VMA for non-CoCo usecase and the gmem VMA for pKVM could be
> behave differently?  non-CoCo gets essentially memfd_secret, pKVM gets
> GUP+no faults of private mem).

Good question. So far my perception was that the directmap removal on 
"private/unfaultable" would be sufficient.

> 
>> Having a mixture of "has directmap" and "has no directmap" for shared
>> (faultable) memory should not be done. Similarly, private memory really
>> should stay "unfaultable".
> 
> You've convinced me that having both GUP-able and non GUP-able
> memory in the same VMA will be tricky. However, I'm less convinced on
> why private memory should stay unfaultable; only that it shouldn't be
> faultable into a VMA that also allows GUP. Can we have two VMAs? One
> that disallows GUP, but allows userspace access to shared and private,
> and one that allows GUP, but disallows accessing private memory? Maybe
> via some `PROT_NOGUP` flag to `mmap`? I guess this is a slightly
> different spin of the above idea.

What we are trying to achieve is making guest_memfd not behave 
completely different on that level for different "types" of VMs. So one 
of the goals should be to try to unify it as much as possible.

shared -> faultable: GUP-able
private -> unfaultable: unGUP-able


And it makes sense, because a lot of future work will rely on some 
important properties: for example, if private memory cannot be faulted 
in + GUPed, core-MM will never have obtained valid references to such a 
page. There is no need to split large folios into smaller ones for 
tracking purposes; there is no need to maintain per-page refcounts and 
pincounts ...

It doesn't mean that we cannot consider it if really required, but there 
really has to be a strong case for it, because it will all get really messy.

For example, one issue is that a folio only has a single mapping 
(folio->mapping), and that is used in the GUP-fast path (no VMA) to 
determine whether GUP-fast is allowed or not.

So you'd have to force everything through GUP-slow, where you could 
consider VMA properties :( It sounds quite suboptimal.

I don't think multiple VMAs are what we really want. See below.

> 
>> I think one of the points raised during the bi-weekly call was that
>> using a viommu/swiotlb might be the right call, such that all memory can
>> be considered private (unfaultable) that is not explicitly
>> shared/expected to be modified by the hypervisor (-> faultable, ->
>> GUP-able).
>>
>> Further, I think Sean had some good points why we should explore that
>> direction, but I recall that there were some issue to be sorted out
>> (interpreted instructions requiring direct map when accessing "private"
>> memory?), not sure if that is already working/can be made working in KVM.
> 
> Yeah, the big one is MMIO instruction emulation on x86, which does guest
> page table walks and instruction fetch (and particularly the latter
> cannot be known ahead-of-time by the guest, aka cannot be explicitly
> "shared"). That's what the majority of my v2 series was about. For
> traditional memslots, KVM handles these via get_user and friends, but if
> we don't have a VMA that allows faulting all of gmem, then that's
> impossible, and we're in "temporarily restore direct map" land. Which
> comes with significantly performance penalties due to TLB flushes.

Agreed.

 > >> What's your opinion after the call and the next step for use cases 
like
>> you have in mind (IIRC firecracker, which wants to not have the
>> direct-map for guest memory where it can be avoided)?
> 
> Yea, the usecase is for Firecracker to not have direct map entries for
> guest memory, unless needed for I/O (-> swiotlb).
> 
> As for next steps, let's determine once and for all if we can do the
> KVM-internal guest memory accesses for MMIO emulation through userspace
> mappings (although if we can't I'll have some serious soul-searching to
> do, because all other solutions we talked about so far also have fairly
> big drawbacks; on-demand direct map reinsertion has terrible
> performance
So IIUC, KVM would have to access "unfaultable" guest_memfd memory using 
fd+offset, and that's problematic because "no-directmap".

So you'd have to map+unmap the directmap repeatedly, and still expose it 
temporarily in the direct map to others. I see how that is undesirable, 
even when trying to cache hotspots (partly destroying the purpose of the 
directmap removal).


Would a per-MM kernel mapping of these pages work, so KVM can access them?

It sounds a bit like what is required for clean per-MM allocations [1]: 
establish a per-MM kernel mapping of (selected?) pages. Not necessarily 
all of them.

Yes, we'd be avoiding VMAs, GUP, mapcounts, pincounts and everything 
involved with ordinary user mappings for these private/unfaultable 
thingies. Just like as discussed in, and similar to [1].

Just throwing it out there, maybe we really want to avoid the directmap 
(keep it unmapped) and maintain a per-mm mapping for a bunch of folios 
that can be easily removed when required by guest_memfd (ftruncate, 
conversion private->shared) on request.

[1] https://lore.kernel.org/all/20240911143421.85612-1-faresx@amazon.de/T/#u

-- 
Cheers,

David / dhildenb


