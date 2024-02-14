Return-Path: <linux-kselftest+bounces-4620-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A67854564
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 10:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB54B1C21ED9
	for <lists+linux-kselftest@lfdr.de>; Wed, 14 Feb 2024 09:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26B9F12B93;
	Wed, 14 Feb 2024 09:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M0DyIO7r"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5414F168D9
	for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 09:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707903259; cv=none; b=P/YK66gZyg41mWiXM3a42rLj28qNoZE+ugPP1Nlt+0Fj30APPIhjl2KS7ddVvFDUBdHQhMo8FGmQrnWDg+Ih+fXHH8CDMAfTcYmfKSw3qdqVwlOPdzPT49AaxVR8OwPINoodERZZ2sER/QuxKY6oOZWkw5ZrBFEu7LoT4sP9FWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707903259; c=relaxed/simple;
	bh=FxSgUwsnEmLismW7KZS+woIOBL3X3s8QTre4gaV0ORU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hGg7DhKpb8zCh/hU3PV3uz9Em6QYwCw6FRY/FLXdqMw6uPLBjAUuL8rLSM1LVPk7rcSoFY0tDrKAIwXQgcL7FHhOBNNSyKDU2eWUIpgneMl1WJexofeQkkbivhSp744CdzT2JWCiwazssP4C/VkcE+fdK3AFPgmhGwBtPVaXj1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M0DyIO7r; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707903256;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=qgy6GGYXXuaVuritCAHxcL8acV3jG8qW6OTkGDcq1DM=;
	b=M0DyIO7r/QF5NP7xbpaHT6hEkfiN9C6ZsBmye3RF3lK/xJkfXgkDTmPpJDsosMbhQbvBu6
	6HXQ5EPdieZFNtwjk4WyV0BOC/Zk/05kx0E8w7+M0QMcA/6BMjEaKIZWqnjJMfVaaHloV2
	9rcAixnBI/FGqCjqslm0JfXu8AItUYo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-576-hgC4Bw3oNruz8yrqvoTaPQ-1; Wed, 14 Feb 2024 04:34:14 -0500
X-MC-Unique: hgC4Bw3oNruz8yrqvoTaPQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-411db41915bso3747195e9.0
        for <linux-kselftest@vger.kernel.org>; Wed, 14 Feb 2024 01:34:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707903253; x=1708508053;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgy6GGYXXuaVuritCAHxcL8acV3jG8qW6OTkGDcq1DM=;
        b=o92L0IXJZ4hu69zMY4HyyBJvwSGZQB+JdgBa7HfSCdXccKnv8Y0pS6dFlkpOTECbDM
         C/dk+vs9tad/1Q595mFZU2MF71jl0++FAhUOjmEcF5YofxXz/Fq08ybT5jZvpLt1min7
         CxM86eN05LtCgZCmBTHmiPeuoMz+Rjfh3rtXKdLZMWhuGry2MRJKCtMjKY0akD04jWgJ
         21FuM10+ZjeJOVwlbONuz5pj7EjDUOQEQSxZGvyE5LqUN6BSMs6jgMwOvcyMWcoLyo+V
         SxRZf133RwYyF3R2gF8nLQjtafB0+NaX69uN8AmOZV9+JgC9uZveVurkkoSvRN+zuOV8
         N1jQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKInq3r65dN81R7VOJiCXMrClaa0lnKVblt4cumC2sTWbP2rhswsizSPkAty38q27bC6DcXwoP4ZTMIrAxbVzG4giAJ7ZFJ5Oxt8itLbDp
X-Gm-Message-State: AOJu0Yz4t3RWuHUpzpSBselEtnXowfU+F0R4ocj3Zq0ZrrTkDq/v7/xx
	en0aXCPqVIKpMCPwlSu2lcJyN0pkkPZflXXstkFBMqLW2JXci+Be852FqTgf93ZH8zmW5iXAtzq
	5IwHsj8bOYccyqlRgRMAZ+OGdzYPgakeUamZlTpOlrkV9fu0MI5QKHg7fzbIFcB6LQg==
X-Received: by 2002:a5d:5001:0:b0:33b:68bc:6e73 with SMTP id e1-20020a5d5001000000b0033b68bc6e73mr1241979wrt.42.1707903253633;
        Wed, 14 Feb 2024 01:34:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHTKmko1G9G/pee2ZiIe9NSxdTOYkWa8OLYM08WwbRBQZV9vdrjk9NQvxiRYAK2xGkX0Z9PEw==
X-Received: by 2002:a5d:5001:0:b0:33b:68bc:6e73 with SMTP id e1-20020a5d5001000000b0033b68bc6e73mr1241961wrt.42.1707903253189;
        Wed, 14 Feb 2024 01:34:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVOVgPexUBHiz71w0Ncw2wb5WblHGZcjzqljN+RKJvXEV26t3QZyu3Q/2CF52LOfzIlIVzJz9WuCDV9iTj0/AXsUvkibhf190GgJnJqKyUyJQ8HyxoHcv8u0nr/9FggrkpZaTADQ4zuu/P4D0hfOhBJoASA1J3dZkqNQTP3g6YoLm/RQxx4Yd2OCL6K1zX856PT46s1Pr4P0awOpzSDed6PhBTCYbs8hROATCFL5jlXXdsrS0/QWhNgM48wX1SS9TsGGuuUta/5t4X3CWSP4cI6vkA3/KCyZlPp3bSq1dHsw+3eDE7EGgvMoAJbq0TEHL9trc+jpZxe+AK6z+kOixjfRG2KSr/kcaD0wjVKqHFyRvXrnpj5KuvLhIIfafwwBgUUKhWl0LhM4IgAcX0XqUJLXkw5SkA6cNKtTQIX/sJuB0GEh3ETe5fX4jfXnUBwPhYOpczYXJ1BXODwfx8efnnz3FakvU6i9wuXseIea6Mf2BARrbDnsvflq7h7xAA5rnXJtjkFYJG0UYMXLyF8JQsP9yScItNqdrAWx9AY4sQscsz/TyCzKwcvZoweCe8+cy32
Received: from ?IPV6:2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e? (p200300d82f3c3f007177eb0cd3d24b0e.dip0.t-ipconnect.de. [2003:d8:2f3c:3f00:7177:eb0c:d3d2:4b0e])
        by smtp.gmail.com with ESMTPSA id bj5-20020a0560001e0500b0033b2799815csm12156827wrb.86.2024.02.14.01.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 01:34:12 -0800 (PST)
Message-ID: <48219ffc-62dc-430a-8055-6fb9ab533e7f@redhat.com>
Date: Wed, 14 Feb 2024 10:34:11 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] mm: page_owner: add support for splitting to any
 order in split page_owner.
Content-Language: en-US
To: Zi Yan <ziy@nvidia.com>, "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>, linux-mm@kvack.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Yang Shi <shy828301@gmail.com>, Yu Zhao <yuzhao@google.com>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
 Ryan Roberts <ryan.roberts@arm.com>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Zach O'Keefe <zokeefe@google.com>, Hugh Dickins <hughd@google.com>,
 Mcgrof Chamberlain <mcgrof@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20240213215520.1048625-1-zi.yan@sent.com>
 <20240213215520.1048625-5-zi.yan@sent.com>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZgEEwEIAEICGwMGCwkIBwMCBhUIAgkKCwQW
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAl8Ox4kFCRKpKXgACgkQTd4Q
 9wD/g1oHcA//a6Tj7SBNjFNM1iNhWUo1lxAja0lpSodSnB2g4FCZ4R61SBR4l/psBL73xktp
 rDHrx4aSpwkRP6Epu6mLvhlfjmkRG4OynJ5HG1gfv7RJJfnUdUM1z5kdS8JBrOhMJS2c/gPf
 wv1TGRq2XdMPnfY2o0CxRqpcLkx4vBODvJGl2mQyJF/gPepdDfcT8/PY9BJ7FL6Hrq1gnAo4
 3Iv9qV0JiT2wmZciNyYQhmA1V6dyTRiQ4YAc31zOo2IM+xisPzeSHgw3ONY/XhYvfZ9r7W1l
 pNQdc2G+o4Di9NPFHQQhDw3YTRR1opJaTlRDzxYxzU6ZnUUBghxt9cwUWTpfCktkMZiPSDGd
 KgQBjnweV2jw9UOTxjb4LXqDjmSNkjDdQUOU69jGMUXgihvo4zhYcMX8F5gWdRtMR7DzW/YE
 BgVcyxNkMIXoY1aYj6npHYiNQesQlqjU6azjbH70/SXKM5tNRplgW8TNprMDuntdvV9wNkFs
 9TyM02V5aWxFfI42+aivc4KEw69SE9KXwC7FSf5wXzuTot97N9Phj/Z3+jx443jo2NR34XgF
 89cct7wJMjOF7bBefo0fPPZQuIma0Zym71cP61OP/i11ahNye6HGKfxGCOcs5wW9kRQEk8P9
 M/k2wt3mt/fCQnuP/mWutNPt95w9wSsUyATLmtNrwccz63XOwU0EVcufkQEQAOfX3n0g0fZz
 Bgm/S2zF/kxQKCEKP8ID+Vz8sy2GpDvveBq4H2Y34XWsT1zLJdvqPI4af4ZSMxuerWjXbVWb
 T6d4odQIG0fKx4F8NccDqbgHeZRNajXeeJ3R7gAzvWvQNLz4piHrO/B4tf8svmRBL0ZB5P5A
 2uhdwLU3NZuK22zpNn4is87BPWF8HhY0L5fafgDMOqnf4guJVJPYNPhUFzXUbPqOKOkL8ojk
 CXxkOFHAbjstSK5Ca3fKquY3rdX3DNo+EL7FvAiw1mUtS+5GeYE+RMnDCsVFm/C7kY8c2d0G
 NWkB9pJM5+mnIoFNxy7YBcldYATVeOHoY4LyaUWNnAvFYWp08dHWfZo9WCiJMuTfgtH9tc75
 7QanMVdPt6fDK8UUXIBLQ2TWr/sQKE9xtFuEmoQGlE1l6bGaDnnMLcYu+Asp3kDT0w4zYGsx
 5r6XQVRH4+5N6eHZiaeYtFOujp5n+pjBaQK7wUUjDilPQ5QMzIuCL4YjVoylWiBNknvQWBXS
 lQCWmavOT9sttGQXdPCC5ynI+1ymZC1ORZKANLnRAb0NH/UCzcsstw2TAkFnMEbo9Zu9w7Kv
 AxBQXWeXhJI9XQssfrf4Gusdqx8nPEpfOqCtbbwJMATbHyqLt7/oz/5deGuwxgb65pWIzufa
 N7eop7uh+6bezi+rugUI+w6DABEBAAHCwXwEGAEIACYCGwwWIQQb2cqtc1xMOkYN/MpN3hD3
 AP+DWgUCXw7HsgUJEqkpoQAKCRBN3hD3AP+DWrrpD/4qS3dyVRxDcDHIlmguXjC1Q5tZTwNB
 boaBTPHSy/Nksu0eY7x6HfQJ3xajVH32Ms6t1trDQmPx2iP5+7iDsb7OKAb5eOS8h+BEBDeq
 3ecsQDv0fFJOA9ag5O3LLNk+3x3q7e0uo06XMaY7UHS341ozXUUI7wC7iKfoUTv03iO9El5f
 XpNMx/YrIMduZ2+nd9Di7o5+KIwlb2mAB9sTNHdMrXesX8eBL6T9b+MZJk+mZuPxKNVfEQMQ
 a5SxUEADIPQTPNvBewdeI80yeOCrN+Zzwy/Mrx9EPeu59Y5vSJOx/z6OUImD/GhX7Xvkt3kq
 Er5KTrJz3++B6SH9pum9PuoE/k+nntJkNMmQpR4MCBaV/J9gIOPGodDKnjdng+mXliF3Ptu6
 3oxc2RCyGzTlxyMwuc2U5Q7KtUNTdDe8T0uE+9b8BLMVQDDfJjqY0VVqSUwImzTDLX9S4g/8
 kC4HRcclk8hpyhY2jKGluZO0awwTIMgVEzmTyBphDg/Gx7dZU1Xf8HFuE+UZ5UDHDTnwgv7E
 th6RC9+WrhDNspZ9fJjKWRbveQgUFCpe1sa77LAw+XFrKmBHXp9ZVIe90RMe2tRL06BGiRZr
 jPrnvUsUUsjRoRNJjKKA/REq+sAnhkNPPZ/NNMjaZ5b8Tovi8C0tmxiCHaQYqj7G2rgnT0kt
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240213215520.1048625-5-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.24 22:55, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> It adds a new_order parameter to set new page order in page owner.
> It prepares for upcoming changes to support split huge page to any
> lower order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   include/linux/page_owner.h | 10 +++++-----
>   mm/huge_memory.c           |  2 +-
>   mm/page_alloc.c            |  4 ++--
>   mm/page_owner.c            |  9 +++++----
>   4 files changed, 13 insertions(+), 12 deletions(-)
> 
> diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
> index d7878523adfc..a784ba69f67f 100644
> --- a/include/linux/page_owner.h
> +++ b/include/linux/page_owner.h
> @@ -11,7 +11,7 @@ extern struct page_ext_operations page_owner_ops;
>   extern void __reset_page_owner(struct page *page, unsigned short order);
>   extern void __set_page_owner(struct page *page,
>   			unsigned short order, gfp_t gfp_mask);
> -extern void __split_page_owner(struct page *page, int order);
> +extern void __split_page_owner(struct page *page, int old_order, int new_order);
>   extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
>   extern void __set_page_owner_migrate_reason(struct page *page, int reason);
>   extern void __dump_page_owner(const struct page *page);
> @@ -31,10 +31,10 @@ static inline void set_page_owner(struct page *page,
>   		__set_page_owner(page, order, gfp_mask);
>   }
>   
> -static inline void split_page_owner(struct page *page, int order)
> +static inline void split_page_owner(struct page *page, int old_order, int new_order)
>   {
>   	if (static_branch_unlikely(&page_owner_inited))
> -		__split_page_owner(page, order);
> +		__split_page_owner(page, old_order, new_order);
>   }
>   static inline void folio_copy_owner(struct folio *newfolio, struct folio *old)
>   {
> @@ -56,11 +56,11 @@ static inline void reset_page_owner(struct page *page, unsigned short order)
>   {
>   }
>   static inline void set_page_owner(struct page *page,
> -			unsigned int order, gfp_t gfp_mask)
> +			unsigned short order, gfp_t gfp_mask)
>   {
>   }
>   static inline void split_page_owner(struct page *page,
> -			int order)
> +			int old_order, int new_order)
>   {
>   }
>   static inline void folio_copy_owner(struct folio *newfolio, struct folio *folio)
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 3d30eccd3a7f..ad7133c97428 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2919,7 +2919,7 @@ static void __split_huge_page(struct page *page, struct list_head *list,
>   	unlock_page_lruvec(lruvec);
>   	/* Caller disabled irqs, so they are still disabled here */
>   
> -	split_page_owner(head, order);
> +	split_page_owner(head, order, 0);
>   
>   	/* See comment in __split_huge_page_tail() */
>   	if (PageAnon(head)) {
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 9d4dd41d0647..e0f107b21c98 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2652,7 +2652,7 @@ void split_page(struct page *page, unsigned int order)
>   
>   	for (i = 1; i < (1 << order); i++)
>   		set_page_refcounted(page + i);
> -	split_page_owner(page, order);
> +	split_page_owner(page, order, 0);
>   	split_page_memcg(page, order, 0);
>   }
>   EXPORT_SYMBOL_GPL(split_page);
> @@ -4837,7 +4837,7 @@ static void *make_alloc_exact(unsigned long addr, unsigned int order,
>   		struct page *page = virt_to_page((void *)addr);
>   		struct page *last = page + nr;
>   
> -		split_page_owner(page, order);
> +		split_page_owner(page, order, 0);
>   		split_page_memcg(page, order, 0);
>   		while (page < --last)
>   			set_page_refcounted(last);
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 1319e402c2cf..ebbffa0501db 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -292,19 +292,20 @@ void __set_page_owner_migrate_reason(struct page *page, int reason)
>   	page_ext_put(page_ext);
>   }
>   
> -void __split_page_owner(struct page *page, int order)
> +void __split_page_owner(struct page *page, int old_order, int new_order)
>   {
>   	int i;
>   	struct page_ext *page_ext = page_ext_get(page);
>   	struct page_owner *page_owner;
> -	unsigned int nr = 1 << order;
> +	unsigned int old_nr = 1 << old_order;
> +	unsigned int new_nr = 1 << new_order;
>   
>   	if (unlikely(!page_ext))
>   		return;
>   
> -	for (i = 0; i < nr; i++) {
> +	for (i = 0; i < old_nr; i += new_nr) {
>   		page_owner = get_page_owner(page_ext);
> -		page_owner->order = 0;
> +		page_owner->order = new_order;
>   		page_ext = page_ext_next(page_ext);

Staring at __set_page_owner_handle(), we do set all 1<<order page_exts 
(corresponding to 1<<order "struct page"s) to have ->order set.

Wouldn't you have to do the same here?

for (i = 0; i < 1 << old_order; i++) {
	page_owner = get_page_owner(page_ext);
	page_owner->order = new_order;
	page_ext = page_ext_next(page_ext);
}

-- 
Cheers,

David / dhildenb


