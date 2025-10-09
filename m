Return-Path: <linux-kselftest+bounces-42929-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 82258BC87F9
	for <lists+linux-kselftest@lfdr.de>; Thu, 09 Oct 2025 12:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 077A6350627
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Oct 2025 10:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1386A2C21E2;
	Thu,  9 Oct 2025 10:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhNlqUuE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62728D82A
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Oct 2025 10:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005839; cv=none; b=QLyUPHkx4UnQZ+nOBWYsbnjIx20L2M9SDN/9VgwOpD0ZEmNFMtBWaYNSMkvJN7ZD45BpYWMjmwh85TCKgfrAmTkxaJoTVY/h3kw0Vut6MHe4Htjy3qeXx53cvVFraCRh0LyMmQgEukv14yIf02pCHYZmSH2PknZ19BmoYoGSZvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005839; c=relaxed/simple;
	bh=pQkhHLuqz5FI6wkHW0gvcTQusPJLmVYgUYJXA/pKqVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aw8UjGvASG9S0tyebYNP3jFlGdoTTOWmhVamzHyvaC3kUWol1k3F+IE/a5r+f3Pj3T4Kmf+2ognNOjdvxJqXMAjuUYBN3aPQePiRPJOmU2hHqiexAjyJ0pVeGK7skbPAZarpghJIk9vmutmpUu9clo4F5dMbGq8ElqHSnchqjMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QhNlqUuE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760005835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5kNnaE3wosVbbZxnmP0sVKpcafEUi286yAMPQXV2QSw=;
	b=QhNlqUuEsZntvTKx/8um0mOXPrBTaocXHhJUBiXc0eBjqWRq2yTGClJBkTGOc2yp7VwzTy
	QjsteWnmZaTPA0KvttQcbt9UdhQhB5/iu4v2IN3rowl2TpF4BlKjApsiN7jS1ukF677+wu
	UOH+Qgx/PilnAElVViX2pOLP3CclQVw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-3w9bEOWtMGWOh3Zthb3iow-1; Thu, 09 Oct 2025 06:30:34 -0400
X-MC-Unique: 3w9bEOWtMGWOh3Zthb3iow-1
X-Mimecast-MFC-AGG-ID: 3w9bEOWtMGWOh3Zthb3iow_1760005833
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-46e36f9c651so5380265e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Oct 2025 03:30:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005833; x=1760610633;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5kNnaE3wosVbbZxnmP0sVKpcafEUi286yAMPQXV2QSw=;
        b=DzrEU8DyFHNtp2oqDHJiJXLC1i6YXsRNXzEf3bwGFw1+AmlcENphDtkR5bacpU17vr
         3Yi3UEosKqxBF4iHoZ5wnhl7Rmnrri+lT0ZQ6IWZiZWjs9tsjLWqdSZ6f1lKV5GMT0p8
         yVgSNAMI6dd71S3yjU5AddgqaHkWH86yr571kJqvkJy7mdsYR1IGEGcISiCnMjsCIXbv
         eH3C5zRhn6HHfCSVV1PM3E0e/XuLIw4SLQSpJ/gJ03xmM/1H8hhCs+X7onb4rTo7hsOU
         a4ao+ymNZG+RwGbZh+oHCJ20cCyf2kYe1n+OkHytWLxHC61ioitlCS5U4P21hdFqLUkO
         onwg==
X-Forwarded-Encrypted: i=1; AJvYcCVpiMCiF2A4/OfDfvCUFWQir8fB/ah9bMNmD1Xwr4WE2PqT4lOhyit8aJHq6m/nKEEhs+u8ZkWmZVpKXI+O/dU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJewQTCc/r2Y+SWpvrBmabfG8dA8GtwcevWd49MN5Hugpd3TFK
	1dwCjIJBa9fnt/rbN90hQgTVxVb4dfZPGq/16DMnZHOI27w737goGqa/c4X4kjiRwb4hWUnnGnV
	ExuSaf14BdIAVueLx9PtM2+qQiR2XXs+w1kJG7kxsmtPMf/GKCnAh5phSERH2WrkpSEoiJw==
X-Gm-Gg: ASbGncuYm6fALSzl7r0Ed8/FdH/94UaEZT9yQVQnrqWOdCBNB/b56j1HpRRPzj4RW08
	5F+MozK0VAp44+5SNuHi9rQYj9n+GjPaWtx7Oattobb/hB4Ux1IyCBlmOF1pnva53Gt2AaDs5Pz
	n5BA6On04X81yNO4JCdZJI+jPnrubQlhGno+d80Z2f/qQlG91zPyBtBpJ0SxXLzAMDVmftmu8A0
	YtBEv2d7BBe8uZ2mdaqMHOCyZY4XqOEtX3OTZr4NfogzDaaFk1WjMqt7G7EY8kqxWy1CpOW1Van
	Dg9zggGh6eJi/cMWdYQhJXRTLIucL3QuifSGBxtt0VRGSLbsr+z+Dk2MgtIAm1C9mGjBgJYyzw/
	JiFBWV8sN
X-Received: by 2002:a05:600c:8b22:b0:46e:4882:94c7 with SMTP id 5b1f17b1804b1-46fa9b02c6amr45782465e9.28.1760005833101;
        Thu, 09 Oct 2025 03:30:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFU6FTiIKoa0UkBC9Zx589zDahv6+GU8nNOKIx+xH1kxdPK8/6eRVsJOlUDPEfHImp4fkFddw==
X-Received: by 2002:a05:600c:8b22:b0:46e:4882:94c7 with SMTP id 5b1f17b1804b1-46fa9b02c6amr45781975e9.28.1760005832588;
        Thu, 09 Oct 2025 03:30:32 -0700 (PDT)
Received: from [192.168.3.141] (tmo-083-189.customers.d1-online.com. [80.187.83.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fab3cc939sm34647705e9.1.2025.10.09.03.30.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 03:30:32 -0700 (PDT)
Message-ID: <7d82cf5e-f60c-4295-9566-c40f6897fce7@redhat.com>
Date: Thu, 9 Oct 2025 12:30:27 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 06/35] mm/page_alloc: reject unreasonable
 folio/compound page sizes in alloc_contig_range_noprof()
To: Balbir Singh <balbirs@nvidia.com>, linux-kernel@vger.kernel.org
Cc: Alexander Potapenko <glider@google.com>,
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
 linux-scsi@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Marco Elver <elver@google.com>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Muchun Song <muchun.song@linux.dev>, netdev@vger.kernel.org,
 Oscar Salvador <osalvador@suse.de>, Peter Xu <peterx@redhat.com>,
 Robin Murphy <robin.murphy@arm.com>, Suren Baghdasaryan <surenb@google.com>,
 Tejun Heo <tj@kernel.org>, virtualization@lists.linux.dev,
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org,
 Zi Yan <ziy@nvidia.com>
References: <20250821200701.1329277-1-david@redhat.com>
 <20250821200701.1329277-7-david@redhat.com>
 <fa2e262c-d732-48e3-9c59-6ed7c684572c@nvidia.com>
 <5a5013ca-e976-4622-b881-290eb0d78b44@redhat.com>
 <a04d8499-85ad-40b4-8173-dcc81a5a71bf@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <a04d8499-85ad-40b4-8173-dcc81a5a71bf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.10.25 12:25, Balbir Singh wrote:
> On 10/9/25 17:12, David Hildenbrand wrote:
>> On 09.10.25 06:21, Balbir Singh wrote:
>>> On 8/22/25 06:06, David Hildenbrand wrote:
>>>> Let's reject them early, which in turn makes folio_alloc_gigantic() reject
>>>> them properly.
>>>>
>>>> To avoid converting from order to nr_pages, let's just add MAX_FOLIO_ORDER
>>>> and calculate MAX_FOLIO_NR_PAGES based on that.
>>>>
>>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>    include/linux/mm.h | 6 ++++--
>>>>    mm/page_alloc.c    | 5 ++++-
>>>>    2 files changed, 8 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>> index 00c8a54127d37..77737cbf2216a 100644
>>>> --- a/include/linux/mm.h
>>>> +++ b/include/linux/mm.h
>>>> @@ -2055,11 +2055,13 @@ static inline long folio_nr_pages(const struct folio *folio)
>>>>      /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
>>>>    #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>>>> -#define MAX_FOLIO_NR_PAGES    (1UL << PUD_ORDER)
>>>> +#define MAX_FOLIO_ORDER        PUD_ORDER
>>>
>>> Do we need to check for CONTIG_ALLOC as well with CONFIG_ARCH_HAS_GIGANTIC_PAGE?
>>>
>>
>> I don't think so, can you elaborate?
>>
> 
> The only way to allocate a gigantic page is to use CMA, IIRC, which is covered by CONTIG_ALLOC

As we are discussing as part of v2 right now, there is the way to just 
obtain them from memblock during boot.

> 
>>>>    #else
>>>> -#define MAX_FOLIO_NR_PAGES    MAX_ORDER_NR_PAGES
>>>> +#define MAX_FOLIO_ORDER        MAX_PAGE_ORDER
>>>>    #endif
>>>>    +#define MAX_FOLIO_NR_PAGES    (1UL << MAX_FOLIO_ORDER)
>>>> +
>>>>    /*
>>>>     * compound_nr() returns the number of pages in this potentially compound
>>>>     * page.  compound_nr() can be called on a tail page, and is defined to
>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>> index ca9e6b9633f79..1e6ae4c395b30 100644
>>>> --- a/mm/page_alloc.c
>>>> +++ b/mm/page_alloc.c
>>>> @@ -6833,6 +6833,7 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
>>>>    int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>>>                      acr_flags_t alloc_flags, gfp_t gfp_mask)
>>>>    {
>>>> +    const unsigned int order = ilog2(end - start);
>>>
>>> Do we need a VM_WARN_ON(end < start)?
>>
>> I don't think so.
>>
> 
> end - start being < 0, completely breaks ilog2. But we would error out because ilog2 > MAX_FOLIO_ORDER, so we should fine

Right, and if we have code that buggy that does it, it probably 
shouldn't be our responsibility to sanity check that :)

It would have been completely buggy before this patch.

> 
>>>
>>>>        unsigned long outer_start, outer_end;
>>>>        int ret = 0;
>>>>    @@ -6850,6 +6851,9 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>>>                            PB_ISOLATE_MODE_CMA_ALLOC :
>>>>                            PB_ISOLATE_MODE_OTHER;
>>>>    +    if (WARN_ON_ONCE((gfp_mask & __GFP_COMP) && order > MAX_FOLIO_ORDER))
>>>> +        return -EINVAL;
>>>> +
>>>>        gfp_mask = current_gfp_context(gfp_mask);
>>>>        if (__alloc_contig_verify_gfp_mask(gfp_mask, (gfp_t *)&cc.gfp_mask))
>>>>            return -EINVAL;
>>>> @@ -6947,7 +6951,6 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>>>                free_contig_range(end, outer_end - end);
>>>>        } else if (start == outer_start && end == outer_end && is_power_of_2(end - start)) {
>>>>            struct page *head = pfn_to_page(start);
>>>> -        int order = ilog2(end - start);
>>>>              check_new_pages(head, order);
>>>>            prep_new_page(head, order, gfp_mask, 0);
>>>
>>> Acked-by: Balbir Singh <balbirs@nvidia.com>
>>
>> Thanks for the review, but note that this is already upstream.
>>
> 
> Sorry, this showed up in my updated mm thread and I ended up reviewing it, please ignore if it's upstream

I'm happy for any review (better in reply to v2), because any bug caught 
early is good!


-- 
Cheers

David / dhildenb


