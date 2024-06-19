Return-Path: <linux-kselftest+bounces-12243-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B667D90EAAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 14:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13795B24F92
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 12:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BE8143736;
	Wed, 19 Jun 2024 12:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hu/x6v7I"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8190142E75
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799379; cv=none; b=KmteDLXg1e/RhVpY+OmeiaSj4djU1AZnUuFrxCAtlOXVwlR8Q+38kcAyro4qretHqHXsDbACWdNkHsoNiB9+ljYGhsJi+cqjY4a/yAaU7hezPerNUQiIwkEc7t0EBAxKPXsvoqZWUKXi7EnB4uml7GXCkOefx8ir+WQLMgvxUNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799379; c=relaxed/simple;
	bh=a0k12ps/Ero26lL60qAq0WYYwBXuwHm7ZsGbLXMWdls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GCM0vufO7CYOQ4jCCGAIGKW94cXXi+i4eAzrplel1iC7WcDzQFbZDhrNSLo2neAlGVUNzH+XGfm6TrmSIJ7eaFuHtDjUTO5in9LkeGG7p+LREwld6GlPi1JOEYuKtFT5odT0DpkZpAj0tp7oOgnBktIPJ02mF9uVVLYY1Kg3sRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hu/x6v7I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718799376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+CVGzV0WgyAWVjh7om6sIr5XcC5MzMlHd83b2E272eU=;
	b=hu/x6v7I6F+w3M7Rdw/ndwwWeoS2Wwyt4KKUrxDslJNW7tA2KWNuyD1Pgj5vVHs5pbajHf
	pe1NMmrXD0cWOG8Pn5oY4czGzum42jgHIwlhQeBHbZKlF2YnmoF/mMHrqEKx7IOrLsEyun
	Nvy3x28tFvvSJhCqieK6MeSTbGtX/5U=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-xEtn73FcO3KsJDIGOiVbKw-1; Wed, 19 Jun 2024 08:16:15 -0400
X-MC-Unique: xEtn73FcO3KsJDIGOiVbKw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2ec063ce179so57346361fa.0
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Jun 2024 05:16:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718799374; x=1719404174;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+CVGzV0WgyAWVjh7om6sIr5XcC5MzMlHd83b2E272eU=;
        b=DiebjK+CApI5636SM9TBEICEupuFROygKKIC3YbVgEJWoQOes5TzMMK50xNjMMB9cf
         XqmiDZIHzWyDRrTnnCeyy+yPNEz5VxfKrd48nzvRDsfI16eEEFXisbZwgJZodElHvzGA
         XwVtpRRhBQ7uwvm5QsxQEEYvllOrnOL8ysQxVyraZlilCKXWqyiDpLOKjiWn0yjkvfTS
         iMUNHLz6SdNVbBcYekWO5cZ5Crz6qk5Nywmv1KI/9K31g+zPr1uhYCqWQnKP5qukYMMf
         hC2x/lEOr/kSEYkPLFYAhEjp0bm232oEn7d8ypILNgjuATiCmdyljh2ZUAmvnR9NOJZJ
         j/eQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfrO5OGjkQeVldubbhMtDe8M4oxEuwGsAY52R4syVkRHh6mw3uCiDBd3la089bcc7TJ2qUH/rq1qZYToSqmBY5pZ12LTqSxRE13OaokapE
X-Gm-Message-State: AOJu0YwDyVibRWKAYuAa+26rVMtC+ri9pKkhmwU0StOPdmLMg81cOu7p
	iD5YVssre7EU0NCEmomU+cWDMfLWYpSfn/wAPppj/l3Ajh/uQKMV4YaE6/XUrd7TM46K1gl8AUP
	THsi/ZLSlT2RPh7OsR1eiRQpGZ/FF2YLeekiDhIw4K+nedqjn7NTI9JxThYCJlFwoLQ==
X-Received: by 2002:a2e:b1c2:0:b0:2ec:30cd:fd77 with SMTP id 38308e7fff4ca-2ec3cea5775mr20000271fa.5.1718799373700;
        Wed, 19 Jun 2024 05:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZnKQf538+rtlBWYEvMqpV6n2p014UkqRTYYzQlkS/1LKOgUQLm17e16oxBDMh1iNDucRN6w==
X-Received: by 2002:a2e:b1c2:0:b0:2ec:30cd:fd77 with SMTP id 38308e7fff4ca-2ec3cea5775mr20000091fa.5.1718799373135;
        Wed, 19 Jun 2024 05:16:13 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:ab00:f9b6:da12:cad4:6642? (p200300cbc705ab00f9b6da12cad46642.dip0.t-ipconnect.de. [2003:cb:c705:ab00:f9b6:da12:cad4:6642])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362e3e1abd5sm3048429f8f.47.2024.06.19.05.16.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jun 2024 05:16:12 -0700 (PDT)
Message-ID: <489d1494-626c-40d9-89ec-4afc4cd0624b@redhat.com>
Date: Wed, 19 Jun 2024 14:16:11 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Fuad Tabba <tabba@google.com>
Cc: John Hubbard <jhubbard@nvidia.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, maz@kernel.org, kvm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com, Jason Gunthorpe <jgg@nvidia.com>
References: <20240618-exclusive-gup-v1-0-30472a19c5d1@quicinc.com>
 <7fb8cc2c-916a-43e1-9edf-23ed35e42f51@nvidia.com>
 <14bd145a-039f-4fb9-8598-384d6a051737@redhat.com>
 <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.06.24 11:11, Fuad Tabba wrote:
> Hi John and David,
> 
> Thank you for your comments.
> 
> On Wed, Jun 19, 2024 at 8:38 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> Hi,
>>
>> On 19.06.24 04:44, John Hubbard wrote:
>>> On 6/18/24 5:05 PM, Elliot Berman wrote:
>>>> In arm64 pKVM and QuIC's Gunyah protected VM model, we want to support
>>>> grabbing shmem user pages instead of using KVM's guestmemfd. These
>>>> hypervisors provide a different isolation model than the CoCo
>>>> implementations from x86. KVM's guest_memfd is focused on providing
>>>> memory that is more isolated than AVF requires. Some specific examples
>>>> include ability to pre-load data onto guest-private pages, dynamically
>>>> sharing/isolating guest pages without copy, and (future) migrating
>>>> guest-private pages.  In sum of those differences after a discussion in
>>>> [1] and at PUCK, we want to try to stick with existing shmem and extend
>>>> GUP to support the isolation needs for arm64 pKVM and Gunyah.
>>
>> The main question really is, into which direction we want and can
>> develop guest_memfd. At this point (after talking to Jason at LSF/MM), I
>> wonder if guest_memfd should be our new target for guest memory, both
>> shared and private. There are a bunch of issues to be sorted out though ...
>>
>> As there is interest from Red Hat into supporting hugetlb-style huge
>> pages in confidential VMs for real-time workloads, and wasting memory is
>> not really desired, I'm going to think some more about some of the
>> challenges (shared+private in guest_memfd, mmap support, migration of
>> !shared folios, hugetlb-like support, in-place shared<->private
>> conversion, interaction with page pinning). Tricky.
>>
>> Ideally, we'd have one way to back guest memory for confidential VMs in
>> the future.
> 
> As you know, initially we went down the route of guest memory and
> invested a lot of time on it, including presenting our proposal at LPC
> last year. But there was resistance to expanding it to support more
> than what was initially envisioned, e.g., sharing guest memory in
> place migration, and maybe even huge pages, and its implications such
> as being able to conditionally mmap guest memory.

Yes, and I think we might have to revive that discussion, unfortunately. 
I started thinking about this, but did not reach a conclusion. Sharing 
my thoughts.

The minimum we might need to make use of guest_memfd (v1 or v2 ;) ) not 
just for private memory should be:

(1) Have private + shared parts backed by guest_memfd. Either the same,
     or a fd pair.
(2) Allow to mmap only the "shared" parts.
(3) Allow in-place conversion between "shared" and "private" parts.
(4) Allow migration of the "shared" parts.

A) Convert shared -> private?
* Must not be GUP-pinned
* Must not be mapped
* Must not reside on ZONE_MOVABLE/MIGRATE_CMA
* (must rule out any other problematic folio references that could
    read/write memory, might be feasible for guest_memfd)

B) Convert private -> shared?
* Nothing to consider

C) Map something?
* Must not be private

For ordinary (small) pages, that might be feasible. 
(ZONE_MOVABLE/MIGRATE_CMA might be feasible, but maybe we could just not 
support them initially)

The real fun begins once we want to support huge pages/large folios and 
can end up having a mixture of "private" and "shared" per huge page. But 
really, that's what we want in the end I think.

Unless we can teach the VM to not convert arbitrary physical memory 
ranges on a 4k basis to a mixture of private/shared ... but I've been 
told we don't want that. Hm.


There are two big problems with that that I can see:

1) References/GUP-pins are per folio

What if some shared part of the folio is pinned but another shared part 
that we want to convert to private is not? Core-mm will not provide the 
answer to that: the folio maybe pinned, that's it. *Disallowing* at 
least long-term GUP-pins might be an option.

To get stuff into an IOMMU, maybe a per-fd interface could work, and 
guest_memfd would track itself which parts are currently "handed out", 
and with which "semantics" (shared vs. private).

[IOMMU + private parts might require that either way? Because, if we 
dissallow mmap, how should that ever work with an IOMMU otherwise].

2) Tracking of mappings will likely soon be per folio.

page_mapped() / folio_mapped() only tell us if any part of the folio is 
mapped. Of course, what always works is unmapping the whole thing, or 
walking the rmap to detect if a specific part is currently mapped.


Then, there is the problem of getting huge pages into guest_memfd (using 
hugetlb reserves, but not using hugetlb), but that should be solvable.


As raised in previous discussions, I think we should then allow the 
whole guest_memfd to be mapped, but simply SIGBUS/... when trying to 
access a private part. We would track private/shared internally, and 
track "handed out" pages to IOMMUs internally. FOLL_LONGTERM would be 
disallowed.

But that's only the high level idea I had so far ... likely ignore way 
too many details.

Is there broader interest to discuss that and there would be value in 
setting up a meeting and finally make progress with that?

I recall quite some details with memory renting or so on pKVM ... and I 
have to refresh my memory on that.

> 
> To be honest, personally (speaking only for myself, not necessarily
> for Elliot and not for anyone else in the pKVM team), I still would
> prefer to use guest_memfd(). I think that having one solution for
> confidential computing that rules them all would be best. But we do
> need to be able to share memory in place, have a plan for supporting
> huge pages in the near future, and migration in the not-too-distant
> future.

Yes, huge pages are also of interest for RH. And memory-overconsumption 
due to having partially used huge pages in private/shared memory is not 
desired.

> 
> We are currently shipping pKVM in Android as it is, warts and all.
> We're also working on upstreaming the rest of it. Currently, this is
> the main blocker for us to be able to upstream the rest (same probably
> applies to Gunyah).
> 
>> Can you comment on the bigger design goal here? In particular:
> 
> At a high level: We want to prevent a misbehaving host process from
> crashing the system when attempting to access (deliberately or
> accidentally) protected guest memory. As it currently stands in pKVM
> and Gunyah, the hypervisor does prevent the host from accessing
> (private) guest memory. In certain cases though, if the host attempts
> to access that memory and is prevented by the hypervisor (either out
> of ignorance or out of malice), the host kernel wouldn't be able to
> recover, causing the whole system to crash.
> 
> guest_memfd() prevents such accesses by not allowing confidential
> memory to be mapped at the host to begin with. This works fine for us,
> but there's the issue of being able to share memory in place, which
> implies mapping it conditionally (among others that I've mentioned).
> 
> The approach we're taking with this proposal is to instead restrict
> the pinning of protected memory. If the host kernel can't pin the
> memory, then a misbehaving process can't trick the host into accessing
> it.

Got it, thanks. So once we pinned it, nobody else can pin it. But we can 
still map it?

> 
>>
>> 1) Who would get the exclusive PIN and for which reason? When would we
>>      pin, when would we unpin?
> 
> The exclusive pin would be acquired for private guest pages, in
> addition to a normal pin. It would be released when the private memory
> is released, or if the guest shares that memory.

Understood.

> 
>> 2) What would happen if there is already another PIN? Can we deal with
>>      speculative short-term PINs from GUP-fast that could introduce
>>      errors?
> 
> The exclusive pin would be rejected if there's any other pin
> (exclusive or normal). Normal pins would be rejected if there's an
> exclusive pin.

Makes sense, thanks.

> 
>> 3) How can we be sure we don't need other long-term pins (IOMMUs?) in
>>      the future?
> 
> I can't :)

:)

> 
>> 4) Why are GUP pins special? How one would deal with other folio
>>      references (e.g., simply mmap the shmem file into a different
>>      process).
> 
> Other references would crash the userspace process, but the host
> kernel can handle them, and shouldn't cause the system to crash. The
> way things are now in Android/pKVM, a userspace process can crash the
> system as a whole.

Okay, so very Android/pKVM specific :/

> 
>> 5) Why you have to bother about anonymous pages at all (skimming over s
>>      some patches), when you really want to handle shmem differently only?
> 
> I'm not sure I understand the question. We use anonymous memory for pKVM.
> 

"we want to support grabbing shmem user pages instead of using KVM's 
guestmemfd" indicated to me that you primarily care about shmem with 
FOLL_EXCLUSIVE?

>>>> To that
>>>> end, we introduce the concept of "exclusive GUP pinning", which enforces
>>>> that only one pin of any kind is allowed when using the FOLL_EXCLUSIVE
>>>> flag is set. This behavior doesn't affect FOLL_GET or any other folio
>>>> refcount operations that don't go through the FOLL_PIN path.
>>
>> So, FOLL_EXCLUSIVE would fail if there already is a PIN, but
>> !FOLL_EXCLUSIVE would succeed even if there is a single PIN via
>> FOLL_EXCLUSIVE? Or would the single FOLL_EXCLUSIVE pin make other pins
>> that don't have FOLL_EXCLUSIVE set fail as well?
> 
> A FOLL_EXCLUSIVE would fail if there's any other pin. A normal pin
> (!FOLL_EXCLUSIVE) would fail if there's a FOLL_EXCLUSIVE pin. It's the
> PIN to end all pins!
> 
>>>>
>>>> [1]: https://lore.kernel.org/all/20240319143119.GA2736@willie-the-truck/
>>>>
>>>
>>> Hi!
>>>
>>> Looking through this, I feel that some intangible threshold of "this is
>>> too much overloading of page->_refcount" has been crossed. This is a very
>>> specific feature, and it is using approximately one more bit than is
>>> really actually "available"...
>>
>> Agreed.
> 
> We are gating it behind a CONFIG flag :)

;)

> 
> Also, since pin is already overloading the refcount, having the
> exclusive pin there helps in ensuring atomic accesses and avoiding
> races.
> 
>>>
>>> If we need a bit in struct page/folio, is this really the only way? Willy
>>> is working towards getting us an entirely separate folio->pincount, I
>>> suppose that might take too long? Or not?
>>
>> Before talking about how to implement it, I think we first have to learn
>> whether that approach is what we want at all, and how it fits into the
>> bigger picture of that use case.
>>
>>>
>>> This feels like force-fitting a very specific feature (KVM/CoCo handling
>>> of shmem pages) into a more general mechanism that is running low on
>>> bits (gup/pup).
>>
>> Agreed.
>>
>>>
>>> Maybe a good topic for LPC!
>>
>> The KVM track has plenty of guest_memfd topics, might be a good fit
>> there. (or in the MM track, of course)
> 
> We are planning on submitting a proposal for LPC (see you in Vienna!) :)

Great!

-- 
Cheers,

David / dhildenb


