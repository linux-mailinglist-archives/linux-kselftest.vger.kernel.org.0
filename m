Return-Path: <linux-kselftest+bounces-40262-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA8BB3B7F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 11:59:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFCCF7A431F
	for <lists+linux-kselftest@lfdr.de>; Fri, 29 Aug 2025 09:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F752D24BA;
	Fri, 29 Aug 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZuCuHfoW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3AA3054E8
	for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756461540; cv=none; b=aJPTGhTzNviK+ieAINugUCEC4a4HPY5a5QzWIhEuInbOKVw3VHNlWZ9MhsR9m0+3gJFUYKH/qGWpyVMqlyIchlrBbfYPkGigJptdCSsPbGoxelwL0dULdQDVENC9JyuF7LCD92ITj8kjXQrhiDPFlL5CYx1ejDSPlZDVrm9MEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756461540; c=relaxed/simple;
	bh=/P8IImUFnzlRd/WrwNGlYa+2eilIKIPbwz+FnSVm0P0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gz1T+5qisdxvLJifu/oluXrUeltAB8GQDlJ6ONlRcQgpGI6iZP6rn/F0Kicn/r7n3WjLA8Aw9CQcngYyXxMmirgZ2KPln3Pt6yqc9GRw+oD1TB2x7FsqYsbYrRJ8+0t2QX3SVYcz/blkFW3EtCL7GoD8XBLSX0NFuxcKsZxLNmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZuCuHfoW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756461537;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CIYlE8yYA+z63gvbmepekc4lArepb/yuA3iZBVH5fy4=;
	b=ZuCuHfoWM+DPAvfvBHcIRdTtY2L6pP1Su3dK8TR6pSK6J2I5VF6RVSRxBXZl2xdV363iuV
	iZcZLIpLbXU7BVGQkkdXa/JqvnrZP7M/goJJQajp5bVMChaHF4E7us92KelCsa4nGKp9Rp
	CNh9+TodZftHpL6ZZvK86j4JHj1Tohg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-XtGK2dbZOvSmzyaM3Bas2A-1; Fri, 29 Aug 2025 05:58:54 -0400
X-MC-Unique: XtGK2dbZOvSmzyaM3Bas2A-1
X-Mimecast-MFC-AGG-ID: XtGK2dbZOvSmzyaM3Bas2A_1756461533
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-45b7a0d1a71so12207445e9.2
        for <linux-kselftest@vger.kernel.org>; Fri, 29 Aug 2025 02:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756461533; x=1757066333;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CIYlE8yYA+z63gvbmepekc4lArepb/yuA3iZBVH5fy4=;
        b=ljYST4UyG5RWCLh30uv7/O+OpXQOnJvczTYVTXSldV95MEBErzKkbkXO+GTPDfQ+8V
         40lXNCl/gJAIfKACeYZBCC+q864q5qZcVd37udybrfu0DLzVURSrHR+QlY/JgAoeE47T
         rPdurQeYnumA9r1RUnzz0Aen0Vl8B0xzFLrzNSBidolV/F4HRjh+mvOG7e5cWQqaLEnc
         jOS0KSihxZy3aPfEKRw5KfZNANyxAn4uXtLQIBevdElhjpym+VygqttSsntRBCVmcO3s
         eo7PKPEZNszmGwF1Mi8w7Dg36XjXw+SKlAnHrofRujD/ngkBZjoTWIWzKdfGh3AWMN3d
         DaoA==
X-Forwarded-Encrypted: i=1; AJvYcCUEJsFhUeIteClR9X0s0BR84SOCnn486/Qwq1IwdTiorPKxS/I0ozoVR7Sp0PBDFUKKB2lMa4bd/PCcmldo5Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF+Ehk78v7cYXGdZyi1DaNE+rYosGRHahM9x0+3As7CDtOtNOG
	J0m7pWhR0Gk2cBXC/xzlhuSAPAGFNM89GqEglQgrt9+b+AD/wb4P2sHEsE5bYozxBlR/6IHtlo7
	WKznttwnviIGZm5N+ySBazIZRX2JdQjl7NYmrmv/oWVQzvG5/9Xfx+kCx+cpVOhc+kOyv5w==
X-Gm-Gg: ASbGncvL+vhSb4hWcNWg6pkzYwHHX0vwFgC4DHuFC688ZGxIVjqwn+XUCk2XMuz6dhc
	q/DDxtwK2djjknyb+2yfXzTil+OSVYhSlv9FNux7ke/ob3SnId6eO96TX+4id70HSGVOzK1ce2L
	0DTf1dlIra2V5TD4A2gT7yTezgPqyxlrsAToRsHdo7GZuzyWQiXFmdlJ0mP3MHNaWCtxMEB+09F
	0t9nZhcFgqV0mVxwzGSBenIUxIHH/KpGeQM5dOD6OKnzqFf0B1VqxgjAp7mT+icHpPCPZKvwBcj
	SLpQKNeSSKL+827o/L6g/YzjGhwYFrWG/RiPLEhpNsF4wqlPEcegBNz2FntU51g37LHKPqbA0cI
	z9h2/6paD8ci1RYdzfTjDpmAdgOQQnsK21y6NcXEZd+YqsLar6Wd8fD4Ggj8tsz9M
X-Received: by 2002:a05:600c:35d0:b0:45b:7f72:340 with SMTP id 5b1f17b1804b1-45b7f720599mr16993735e9.25.1756461532907;
        Fri, 29 Aug 2025 02:58:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHP3EE2Ifsg5AHoStp93/zw+u97m2nZeBURa8lzMoGajSkuEytfaWCGtF8d2bBvl4JzWz9L2g==
X-Received: by 2002:a05:600c:35d0:b0:45b:7f72:340 with SMTP id 5b1f17b1804b1-45b7f720599mr16993185e9.25.1756461532358;
        Fri, 29 Aug 2025 02:58:52 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1d:100:4f8e:bb13:c3c7:f854? (p200300d82f1d01004f8ebb13c3c7f854.dip0.t-ipconnect.de. [2003:d8:2f1d:100:4f8e:bb13:c3c7:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7271cd01sm102235695e9.23.2025.08.29.02.58.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 02:58:51 -0700 (PDT)
Message-ID: <6a2e2ba2-e5ea-4744-a66e-790216c1e762@redhat.com>
Date: Fri, 29 Aug 2025 11:58:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/36] mm/page_alloc: reject unreasonable
 folio/compound page sizes in alloc_contig_range_noprof()
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 linux-kernel@vger.kernel.org, Zi Yan <ziy@nvidia.com>,
 SeongJae Park <sj@kernel.org>, Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Brendan Jackman <jackmanb@google.com>, Christoph Lameter <cl@gentwo.org>,
 Dennis Zhou <dennis@kernel.org>, Dmitry Vyukov <dvyukov@google.com>,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 iommu@lists.linux.dev, io-uring@vger.kernel.org,
 Jason Gunthorpe <jgg@nvidia.com>, Jens Axboe <axboe@kernel.dk>,
 Johannes Weiner <hannes@cmpxchg.org>, John Hubbard <jhubbard@nvidia.com>,
 kasan-dev@googlegroups.com, kvm@vger.kernel.org,
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
 Vlastimil Babka <vbabka@suse.cz>, wireguard@lists.zx2c4.com, x86@kernel.org
References: <20250827220141.262669-1-david@redhat.com>
 <20250827220141.262669-7-david@redhat.com>
 <3hpjmfa6p3onfdv4ma4nv2tdggvsyarh7m36aufy6hvwqtp2wd@2odohwxkl3rk>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <3hpjmfa6p3onfdv4ma4nv2tdggvsyarh7m36aufy6hvwqtp2wd@2odohwxkl3rk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29.08.25 02:33, Liam R. Howlett wrote:
> * David Hildenbrand <david@redhat.com> [250827 18:04]:
>> Let's reject them early, which in turn makes folio_alloc_gigantic() reject
>> them properly.
>>
>> To avoid converting from order to nr_pages, let's just add MAX_FOLIO_ORDER
>> and calculate MAX_FOLIO_NR_PAGES based on that.
>>
>> Reviewed-by: Zi Yan <ziy@nvidia.com>
>> Acked-by: SeongJae Park <sj@kernel.org>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Nit below, but..
> 
> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> 
>> ---
>>   include/linux/mm.h | 6 ++++--
>>   mm/page_alloc.c    | 5 ++++-
>>   2 files changed, 8 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 00c8a54127d37..77737cbf2216a 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2055,11 +2055,13 @@ static inline long folio_nr_pages(const struct folio *folio)
>>   
>>   /* Only hugetlbfs can allocate folios larger than MAX_ORDER */
>>   #ifdef CONFIG_ARCH_HAS_GIGANTIC_PAGE
>> -#define MAX_FOLIO_NR_PAGES	(1UL << PUD_ORDER)
>> +#define MAX_FOLIO_ORDER		PUD_ORDER
>>   #else
>> -#define MAX_FOLIO_NR_PAGES	MAX_ORDER_NR_PAGES
>> +#define MAX_FOLIO_ORDER		MAX_PAGE_ORDER
>>   #endif
>>   
>> +#define MAX_FOLIO_NR_PAGES	(1UL << MAX_FOLIO_ORDER)
>> +
>>   /*
>>    * compound_nr() returns the number of pages in this potentially compound
>>    * page.  compound_nr() can be called on a tail page, and is defined to
>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>> index baead29b3e67b..426bc404b80cc 100644
>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -6833,6 +6833,7 @@ static int __alloc_contig_verify_gfp_mask(gfp_t gfp_mask, gfp_t *gfp_cc_mask)
>>   int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>   			      acr_flags_t alloc_flags, gfp_t gfp_mask)
>>   {
>> +	const unsigned int order = ilog2(end - start);
>>   	unsigned long outer_start, outer_end;
>>   	int ret = 0;
>>   
>> @@ -6850,6 +6851,9 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>   					    PB_ISOLATE_MODE_CMA_ALLOC :
>>   					    PB_ISOLATE_MODE_OTHER;
>>   
>> +	if (WARN_ON_ONCE((gfp_mask & __GFP_COMP) && order > MAX_FOLIO_ORDER))
>> +		return -EINVAL;
>> +
>>   	gfp_mask = current_gfp_context(gfp_mask);
>>   	if (__alloc_contig_verify_gfp_mask(gfp_mask, (gfp_t *)&cc.gfp_mask))
>>   		return -EINVAL;
>> @@ -6947,7 +6951,6 @@ int alloc_contig_range_noprof(unsigned long start, unsigned long end,
>>   			free_contig_range(end, outer_end - end);
>>   	} else if (start == outer_start && end == outer_end && is_power_of_2(end - start)) {
>>   		struct page *head = pfn_to_page(start);
>> -		int order = ilog2(end - start);
> 
> You have changed this from an int to a const unsigned int, which is
> totally fine but it was left out of the change log.  

Considered to trivial to document, but I can add a sentence about that.

> Probably not really
> worth mentioning but curious why the change to unsigned here?

orders are always unsigned, like folio_order().

Thanks!

-- 
Cheers

David / dhildenb


