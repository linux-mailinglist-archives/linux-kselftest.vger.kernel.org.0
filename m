Return-Path: <linux-kselftest+bounces-27604-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A80DA45DD5
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 12:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 508283AE623
	for <lists+linux-kselftest@lfdr.de>; Wed, 26 Feb 2025 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84F2165E9;
	Wed, 26 Feb 2025 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ahTLmZ2h"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774BB216397
	for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 11:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570757; cv=none; b=bM+oyqwhABnVVmFZXo0pa1QLhzOkVHrXIDzOdeJc8RN2undlbmlO9GgTimQw/NqpvKOSCHA4ErxdGcDFE98Tv0PUjxliF7eM6QvvkO/AA7xuFmRXahxX1/m0JXkyvzIVi7sdGOOs0MXdvMeWXViu0/pepipCJAXjzh69ZpihbrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570757; c=relaxed/simple;
	bh=lAP5jCkkR0TPWw9dGfqZRBeM8Juv+VZLV55JUEKWdDo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sfrgrq8HO6ktv66vdX3mPZDdSntCFTwpzdraj94A/1/QwaUmUTFT9b1sfLWhwQeYTS60r2pi8GREuRmnGlmAJlHUdKxXEXZAXEbsjb85Zjkq5RH/WRC55d2c4zvTtSGgi2m14Un+ujxj4ntGMpDRF16cXZuf8HtRmGClgS5uFCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ahTLmZ2h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740570754;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0p71Bc+tSNk19U8eoW67nNiNmqlLTYbFS9i3TH6hlEU=;
	b=ahTLmZ2hKw5nqPhQEik4b4bnFJZbbqulVoCu2bANMp26FFZJShY2AY9Kpa7zwIP3jQUD3H
	Z7Hso02Wh9RLUHM0WS71HEKoqlXsWLmFXvz1SDNVC/5ROKkJ1FQBREP4HjBQj4zrJUPYS6
	kLxRb3ng6uuKjYAjHx2JBhreVEGKbAk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-N84lSM0_P3CM9N9id3gRHg-1; Wed, 26 Feb 2025 06:52:32 -0500
X-MC-Unique: N84lSM0_P3CM9N9id3gRHg-1
X-Mimecast-MFC-AGG-ID: N84lSM0_P3CM9N9id3gRHg_1740570752
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f44be93a8so3323982f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 26 Feb 2025 03:52:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740570751; x=1741175551;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0p71Bc+tSNk19U8eoW67nNiNmqlLTYbFS9i3TH6hlEU=;
        b=GFSTSXnVCUCXoMDeVkC4cUzUdyWXDF5laTQHDN+MM6yu/yuvt/Se06rkBehPbKFDGx
         x0GK+6g7vZXXgiuZ1B6lM5ju5iGgNJBkj9Ge37tveWe/9TlEHYZI81rrCgCdCtp9lbXq
         CXpRPQ5KvihjUObArDQPSBYolfbS3RoVGqPE1N/oi4fNIHaspwedCJWo7U2jJU/AHpi6
         bHJpgmMe2mWYZkydie4GmcoCqyXwGFPPrMwgsQ6zwRTzFhrLhRdPWNYOivegPCmqKhb4
         LMWkNFeEkQ2TOvk0/EZXe/ST6PVCM2tylnLTnxpgrULGyCSCTrmurI0piPka5ZgNV1JI
         IXfg==
X-Forwarded-Encrypted: i=1; AJvYcCVPN1pbe86bNiSWRrKJoXUfhn2jZ1hxLrsnfFb3xyhBuBaWRtJfK3t+/eH58cHTnofxfDG97J86hZPUc1xLDBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+q3SRDG+pU9O835Uf3BPgZLSlEjywFnI/+7Wqx8O4+AOjlzV
	N6mackfK9vVegP3x6BCDQr3l1lkweNMRU8PE7giu29SQn/LIvmrKI2vuzKKNdYC7SeGJhLQwu9r
	W9cNHNCgPU8vn3SMmAL9oinM7tTQW7ifZmAHXsoFXdL6BC70L9gaeIF/2YFcduJfwnA==
X-Gm-Gg: ASbGncv894TcLxmp67fT8fF5hXBHEvu+Fj0V97/3uelWNuDryJgsNFt7ngwjHjeb+oP
	JPmVS1QJPDjUvgVUavo+iz1+wdwRFl/AMu9/FQYbY66quuI8cPwPj4UU7DNHrjxhfsTJNbdKV3B
	vGKOtjRXaEknWFLIJ9uydWSXUkhs+Lm8nnG2y39EGiJNj13oUkaJ3gpbygYGt55MLw1u61uva/R
	B0ASHYDZmLt+jxaOZkEO1VM+8lLUeAEFNzARHdSNqXojGENFQaNidI9cmp14minSgatK4+pcEIu
	HinMHokCsBxgxdvI6HpLfGdSiecIgnd4oXpjqBgETeLU/miDLkJFSmAH9gOOpHcraTzIydv0+0v
	RIt6RqNPWVhFOvvhaSeMIFPXJV1Dn9WD7eOGgf99HtXU=
X-Received: by 2002:a05:6000:2a7:b0:38f:4fa6:e641 with SMTP id ffacd0b85a97d-390d4f84740mr3006490f8f.43.1740570751449;
        Wed, 26 Feb 2025 03:52:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEw6LTiRCfqsNc3pw3LySJCXKQPJIe6Q8/sql2dmRjbzjqWwsMFFiGxlF1FuddtHIXqDIK76Q==
X-Received: by 2002:a05:6000:2a7:b0:38f:4fa6:e641 with SMTP id ffacd0b85a97d-390d4f84740mr3006423f8f.43.1740570751066;
        Wed, 26 Feb 2025 03:52:31 -0800 (PST)
Received: from ?IPV6:2003:cb:c747:ff00:9d85:4afb:a7df:6c45? (p200300cbc747ff009d854afba7df6c45.dip0.t-ipconnect.de. [2003:cb:c747:ff00:9d85:4afb:a7df:6c45])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd86cd10sm5467317f8f.37.2025.02.26.03.52.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Feb 2025 03:52:30 -0800 (PST)
Message-ID: <657f10ed-4e82-4048-98ab-1c4b65349298@redhat.com>
Date: Wed, 26 Feb 2025 12:52:29 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] mm: KUnit tests for the page allocator
To: Brendan Jackman <jackmanb@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador
 <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
 <0449ff75-0a6b-4c1e-bf12-ff052aad5287@redhat.com>
 <Z72-AP-yQ2hPwpKe@google.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z72-AP-yQ2hPwpKe@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.02.25 13:56, Brendan Jackman wrote:
> On Tue, Feb 25, 2025 at 11:01:47AM +0100, David Hildenbrand wrote:
>>> This is an RFC and not a PATCH because:
>>>
>>> 1. I have not taken much care to ensure the isolation is complete.
>>>      There are probably sources of flakiness and nondeterminism in here.
>>>
>>> 2. I suspect the the basic idea might be over-complicated: do we really
>>>      need memory hotplug here? Do we even need the instance of the
>>>      allocator we're testing to actual memory behind the pages it's
>>>      allocating, or could we just hallucinate a new region of vmemmap
>>>      without any of that awkwardness?
>>>
>>>      One significant downside of relying on memory hotplug is that the
>>>      test won't run if we can't hotplug anything out. That means you have
>>>      to fiddle with the platform to even run the tests - see the
>>>      --kernel_args and --qemu_args I had to add to my kunit.py command
>>>      above.
>>>
>>>      So yeah, other suggestions welcome.
>>>
>>>      2b. I'm not very confident I'm using the hotplug API properly.
>>
>> Me neither ;)
>>
>> Dynamically adding memory to that "fake" node is certainly interesting, but
>> which guarantees do we have that some other features (page migration, memory
>> offlining, page reporting ...) don't interact in weird ways with this "fake"
>> node? Adding special-casing all over the place for that feels wrong. I
>> assume this is point 1. you note above.
> 
> Yeah, basically this is the big downside. Changing the system we're
> trying to test in order to make it testable can't be avoided entirely,
> but I am also pretty unhappy with sprinkling "if (node_isolated(node))"
> everywhere.
> 
> I guess the ideal approach is one where, instead of having to modify
> the meaning of node_data, we just support replacing it completely,
> e.g:
> 
> struct page *__alloc_frozen_pages_noprof(gfp_t gfp, unsigned int order,
> 		int preferred_nid, nodemask_t *nodemask,
> 		struct pagelist_data *node_data)
> {
> 	struct alloc_context ac = { .node_data = node_data };
> 
> 	// ...
> }
> 
> Ideally this could be done in such a way that it disappears completely
> outside of KUnit builds, the interface should be private and we'd
> wanna get rid of any unnecessary pointer chasing with stuff like:
> 
> #ifdef CONFIG_PAGE_ALLOC_KUNIT_TESTS
> static inline struct ac_node_data(struct alloc_context *ac, int node)
> {
> 	return ac->node_data[node];
> }
> #else
> #define ac_node_data(ac, node) (NODE_DATA(node))
> #endif
> 
> I initially rejected this approach because it felt "too intrusive",
> but now that I've actually written this RFC I think it could be less
> intrusive than the node_isolated() thing I've proposed here.
> 
> The most obvious challenges I can see there are:
> 
> - There might be places that page_alloc.c calls out to that care about
>    node_data but where we really don't want to plumb the alloc_context
>    through (maybe vmscan.c is already such a place)?
> 
> - I dunno how many more such helpers we'd need beyond ac_node_data(),
>    like do we need ac_nodes_possible_mask() etc etc etc?
> 
> But maybe worth a try - can you see any obvious reason this idea is
> stupid?
> 
>> So I don't quite love the idea on first sight ... but I haven't grasped all
>> details of the full picture yet I'm afraid.
> 
> Do you have any thoughts about "making up" memory instead of
> hot-unplugging real memory for test usage? That might simplify things
> a bit?
 > > It seems possible that very little mm code cares if the memory we're
> managing actually exists. (For ASI code we did briefly experiment with
> tracking information about free pages in the page itself, but it's
> pretty sketchy and the presence of debug_pagealloc makes me think
> nobody does it today).

At least when it comes to the buddy, only page zeroing+poisoning should 
access actual page content.

So making up memory might actually work in quite some setups, assuming 
that it will never get allocated.

The "complicated" thing is still that we are trying to test parts of the 
buddy in a well-controlled way while other kernel infrastructure is 
using the buddy in rather uncontrolled ways.


> 
> There might be arch-specific issues there, but for unit tests it
> seems OK if they don't work on every ISA.

Just pointing it out: for memblock tests (tools/testing/memblock/) we 
actually compile memblock.c to be used in a user space application, 
stubbing all external function calls etc such that we get the basics 
running.

It'd probably be quite some work to get page_alloc.c into a similar 
shape, likely we'd have to move a lot of unrelated-for-the tests stuff, 
and think about how to handle some nasty details like pcp etc. Just 
wondering, did you think about that option as well?

The nice thing about such an approach is that we can test the allcator 
without any possible side effects from the running system.

-- 
Cheers,

David / dhildenb


