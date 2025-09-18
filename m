Return-Path: <linux-kselftest+bounces-40286-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A19B3BBFC
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 15:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5D03A426E
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 13:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3121A31A07F;
	Fri, 29 Aug 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W77Nk43K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7C22EBBA9
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 13:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756472994; cv=none; b=TNC19orE/cSjGV6J0iBNCLuEjEyUEg3xOu9D3831TCikaDpwJ0lsCFkP8l2ne8BM0LQBXoE4bxaq4x0vbEc91c/auXJscL+Ulb5S2dxfeTNQvb5QcJvSNExIILNj3Bt1r5TTBxNf/YsXqW5Me4YGj1BSRDn4Rmv16ZtNW4yl3RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756472994; c=relaxed/simple;
	bh=FHp1+ZSlsyZvFpLyoPCQZLe6PCr3uA+m/9iJFPC2eto=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnqxlXpczkKwbPcSXPW2g9WiZuXOPv7f0lwBEjsjkxbyOjAMnYgnw2shmO4rl3u9lrdQm6pzG1MDKI/Tzf5Nnyenbod/m3pIEl12gBrfCtpe0N6dbW13zK88tUrRQk/5wvKhYF64UZZn13di/RyWZn2kKH1vqnIg5+P3yJJdDwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W77Nk43K; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756472991;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GMW9HLrWQaKZG+KlEEwhYfHDFt7S0jSgL0MHJQucZHQ=;
	b=W77Nk43KwapZ/PN0ppI9OkDMdzLsFzdvdC/b/yuaZStPv6TCKRiXmhD2gEpACpEqlmSoKQ
	fy9xiqvIe1vDK8ht/CfBha8BW6l+aSX7H/TeOc7MddY2QJvJrVVLKSezxtvsS8nnv4OHpT
	nov6559jhkbkP27pl4yoFG8ggSJpcFc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-25-TKJoGTw4PpuKyvGz9q95ag-1; Fri, 29 Aug 2025 09:09:49 -0400
X-MC-Unique: TKJoGTw4PpuKyvGz9q95ag-1
X-Mimecast-MFC-AGG-ID: TKJoGTw4PpuKyvGz9q95ag_1756472989
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3cf48ec9fc1so629656f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 06:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756472988; x=1757077788;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMW9HLrWQaKZG+KlEEwhYfHDFt7S0jSgL0MHJQucZHQ=;
        b=Xmqy5Hl3oV5N+Go4kMzFPGUEi2p+kZJgQmYzxd73oXPvXgqV5NAo1lD08+ogM6TOqI
         ZZSAdJffs1RLucL9YrD5MoDiHxa5vOfhMiOKC9IeKBcyakoeBJJrAwVkpIEChmdkOg3K
         uCYLfoAD/MO3ih9Nb4lUmD80ae7tDgFVYzCZDOhq831Eu2EZ6CTUT/+XI8pApRBuuVXT
         vQ1M39brb3SZZOOdZLW0ZHei4WTZ4goWHWPq3MVV98q7ejpmIzLGXcTncq6POyRt4jp7
         v/u5YSQUFiMSZhWeiK7jleQv1NpDT2yMtdgGi9DXs3vBkWdpOUPi5f5whmB38ojIwjL8
         Hq4g==
X-Forwarded-Encrypted: i=1; AJvYcCV2EcptWY87FBoyTsThrxXwa7FT24eNA3D2k7przSi0dU0RQHCy+NxpVnQg/2wxvBkEkvhZmHzoJwanVddhui8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrs5O9OwWAtZOWaHsUaiL7PKbcV68CaOxh00qXbGi/K73Hxm2N
	yCaVUejkEEKB19tENhq5PHLgdnoysXMW/cqhb+2tpix0FvD9Hfl/ND2Ugc4f7MtC4QttSw0DHB5
	/oThkMgRrXEtg+mygSF7Gr9UQbhYDEA8LIEg7gRE20BzECE5cGc5NW/bSGlTQMdoCh9fJNw==
X-Gm-Gg: ASbGncthBwgiReaar0/RPvJzNgsY66JAVJf+YtHyzwdy/8Wrj7M3wgnPQ9HeoUMUZH5
	ovyQVzCKI0XikDFo9/bUYhQrIXYE5hfRTVgoMpP2cyI7eZwUJ61d/T2z9xb/n5vXcvE8rYTmqIm
	TqwQK0Lw1OXnPcyUSGSXV1wla7R+nCcYQ3Xi/USrBU25ihuhHnUWfwJq9m3SqLvP1c76Vyj8XrZ
	vQlF08b8DwJUaOjCa+wCVa62LjLm4DQ1JjtSAdr8aBBIns0SfTLbZX7pCTVI8O6dQ1bqNqtjQe1
	HsVKNiFcpYqILuumDQ0nb/O2A54xMl5KyRyVnFWqlwwbho8GZsqp+hD/ZHewfcjfYI7xB5hknNV
	np9n6P4/awZb7wklflNILD3HhcqupejEHuAz/HW9b+7WQA8AfbBbIS744+MnN887J
X-Received: by 2002:a05:6000:4023:b0:3d0:d6e6:5d96 with SMTP id ffacd0b85a97d-3d0d6e6642emr1463724f8f.38.1756472988507;
        Fri, 29 Aug 2025 06:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE2EE1FdffCNgqV63lR4bEMYpCijk6Rt1WA7Ibu/9lrj3Iet7fHqrTgMv1xYGinJ39Wr3I/NQ==
X-Received: by 2002:a05:6000:4023:b0:3d0:d6e6:5d96 with SMTP id ffacd0b85a97d-3d0d6e6642emr1463686f8f.38.1756472987991;
        Fri, 29 Aug 2025 06:09:47 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d12c90a01bsm906716f8f.31.2025.08.29.06.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 06:09:47 -0700 (PDT)
Message-ID: <4f6e66a1-1747-402e-8f1a-f6b7783fc2e5@redhat.com>
Date: Fri, 29 Aug 2025 15:09:45 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/36] mm/page_alloc: reject unreasonable
 folio/compound page sizes in alloc_contig_range_noprof()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 SeongJae Park <sj@kernel.org>, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-arm-kernel@axis.com,
 linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mmc@vger.kernel.org, linux-mm@kvack.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-7-david@redhat.com>
 <f195300e-42e2-4eaa-84c8-c37501c3339c@lucifer.local>
 <547145e0-9b0e-40ca-8201-e94cc5d19356@redhat.com>
 <34edaa0d-0d5f-4041-9a3d-fb5b2dd584e8@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <34edaa0d-0d5f-4041-9a3d-fb5b2dd584e8@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> 
> It seems a bit arbitrary, like we open-code this (at risk of making a mistake)
> in some places but not others.

[...]

>>
>> One could argue that maybe one would want a order_to_pages() helper (that
>> could use BIT() internally), but I am certainly not someone that would
>> suggest that at this point ...  :)
> 
> I mean maybe.
> 
> Anyway as I said none of this is massively important, the open-coding here is
> correct, just seems silly.

Maybe we really want a ORDER_PAGES() and PAGES_ORDER().

But I mean, we also have PHYS_PFN() PFN_PHYS() and see how many "<< 
PAGE_SIZE" etc we are using all over the place.

> 
>>
>>>
>>>> +
>>>>    /*
>>>>     * compound_nr() returns the number of pages in this potentially compound
>>>>     * page.  compound_nr() can be called on a tail page, and is defined to
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index baead29b3e67b..426bc404b80cc 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -6833,6 +6833,7 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
>>>>    int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>>>    			      acr_flags_t alloc_flags, gfp_t gfp_mask)
> 
> Funny btw th
> 
>>>>    {
>>>> +	const unsigned int order = ilog2(end - start);
>>>>    	unsigned long outer_start, outer_end;
>>>>    	int ret = 0;
>>>>
>>>> @@ -6850,6 +6851,9 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>>>    					    PB_ISOLATE_MODE_CMA_ALLOC :
>>>>    					    PB_ISOLATE_MODE_OTHER;
>>>>
>>>> +	if (WARN_ON_ONCE((gfp_mask & __GFP_COMP) && order > MAX_FOLIO_ORDER))
>>>> +		return -EINVAL;
>>>
>>> Possibly not worth it for a one off, but be nice to have this as a helper function, like:
>>>
>>> static bool is_valid_order(gfp_t gfp_mask, unsigned int order)
>>> {
>>> 	return !(gfp_mask & __GFP_COMP) || order <= MAX_FOLIO_ORDER;
>>> }
>>>
>>> Then makes this:
>>>
>>> 	if (WARN_ON_ONCE(!is_valid_order(gfp_mask, order)))
>>> 		return -EINVAL;
>>>
>>> Kinda self-documenting!
>>
>> I don't like it -- especially forwarding __GFP_COMP.
>>
>> is_valid_folio_order() to wrap the order check? Also not sure.
> 
> OK, it's not a big deal.
> 
> Can we have a comment explaining this though? As people might be confused
> as to why we check this here and not elsewhere.

I can add a comment.

-- 
Cheers

David / dhildenb


