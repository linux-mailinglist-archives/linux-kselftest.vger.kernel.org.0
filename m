Return-Path: <linux-kselftest+bounces-39300-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD89B2BC42
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 10:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B894E188A332
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 08:55:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76958311C1D;
	Tue, 19 Aug 2025 08:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaawjPJ8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C623BCEE
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 08:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593680; cv=none; b=PoG2j5IV/N8RbcX9JuOOvXuM24/TaScow5J35bCCJ2r39oxw1cQQT4EWFKKt6PoqN+Qf3zevMT/mC3i0x1FY35Chqv08bNBA+Cpzm01B7sH9DFK7GNc7enewc5MxMZ+obgPb8Ffiy67w7SxPATV8BxK2tXjs3eJ8wvpULmxr7QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593680; c=relaxed/simple;
	bh=ahPy955yuf0/YJQjyUtbxM/T6UpuukkyDDgU7xvCOTw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JTRHFEW4d6awIsNzoIvdIHVpzRDfq/nXtIkElYkLTxNfcXbNrlJPLXmAOXEz77uWdLXGZ1peJ68gTG0xwhxa4MLZgS/HVj4CsWk3HlnD5QKEutaB8xlBh7LnRN+KLhfU7lyaYlWmpeqj/JXfId89Z0sfBa4UE7YzyyUP9xaF1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaawjPJ8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755593677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=2GIAX6Nq7HAe3wQJY59KU2tqqiWvi4h1Hi421Hv5T8c=;
	b=ZaawjPJ8I23DF4+5LdovdTUG//UQDOJvWfgYdqWRM3veWlSMINJY5v9CapDWjQ92rqi4O7
	rP1R82OOitALn0t2lWMep5LrLek3lRfR8YUkEGNBdO544toCbARqkfUvuCEFewzwFhatQP
	Q/BL+mEBj/UHUSl2j4y6zs0VjSCDY7g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-6ovuo0AjN1ynpjdHG0fYWg-1; Tue, 19 Aug 2025 04:54:35 -0400
X-MC-Unique: 6ovuo0AjN1ynpjdHG0fYWg-1
X-Mimecast-MFC-AGG-ID: 6ovuo0AjN1ynpjdHG0fYWg_1755593674
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41b82beso4069075f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Aug 2025 01:54:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755593674; x=1756198474;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GIAX6Nq7HAe3wQJY59KU2tqqiWvi4h1Hi421Hv5T8c=;
        b=m91kva3+iYrUyhDWaiQev3FM6e6kbxr3varg5qYVqOjGnBLGyWE7/TGQ0XHOPgWMDg
         g/oN/RXnr59mUqHMDshI8IEWlRhTuED4Fkocc3rH+vqG7djDmL+lY/B3tSPKbE49LkPv
         lcG65b1kvfE7bUwv4Dony/7ZdoR1aJMBOT7MynGfFuNbAaOSMqduzf1Sxej0CFejg81n
         R/jDwwEjUJ/7oouc9zXy4OtHN3CUjrEqCdNAl1EyqEKJyUxsg/8dnl6tzY40+c8A9Nkq
         NUhNzPxxtA4DGNxmvfQCcoyrHiNB3Jz32QSdKTNkHXqNSNsxwHgn+mzyEOIJ7hmnqOoX
         NyHA==
X-Forwarded-Encrypted: i=1; AJvYcCUYjnCCG6KLx/w+daBVZbBurGOBkoEqp3MTqB6auvYwFLCaZ9XRNcuyC1AAHOQcnGYK2xqD/NZ+TCXWzbYnHeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1dlPgxpMS+WUPzpcPTHM7/66fum0IgOzkzG46Qwz2kzrkj3r8
	XgE4ulu484iKvQqmguroJH8hJICod38vdZrfX4X+HwaAeRDPDT4g8uiPdChL0KBcBBO8UW8kM+y
	ufiZWSq+Fg2SrdMpmgJZ3Bf9YtLQrhUdFPw8QaUczjLBgWxfNOsoCA7n6gZPBXHzesfPe+w==
X-Gm-Gg: ASbGncu6r6inKvDRL81R80ePzPr9D18lkJFLvzKLvLEqTgipvT6oYsjiRaup9m0Rk27
	t1tZA9oCPnI9S0Sxs9M4Zn+zUUIYdoXRVL9mF8rcJ6OHOyIuVbMimTjo+3I5aOz9Uxxn58mZyAi
	hu7fXMeaOm2FMDlnQ32/j1F753/B8AKWPzS0soWCJBEdwf/mGVX6+JM4WqC3Y6tSSlunkXfBp7c
	Yr/uXdpWiVGtRhqSI82Whb+abGKtcAD/jKYcGipiSuq56VPYJht2zYO2eaP/TyoMON4oGSu3Vdg
	ZyM4YEmaTNVht2/jEQsAk/dYpVwnXxB1zkD++WThPOeH/mzXmJmuMrV04cSLTDE1gwz2zRs0bqE
	A25UwV/YKTPP24te+ehylwdGO0L06/YucSCRNLbeyXJKP5rLZkKLe3dSjC1kTQRJD/HI=
X-Received: by 2002:a05:6000:2887:b0:3b7:7680:35d3 with SMTP id ffacd0b85a97d-3c0ec09eedamr1193330f8f.37.1755593674439;
        Tue, 19 Aug 2025 01:54:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBx+g1KE59r6WAwYU95cz0a0anPGXIMLeDTaZZc18sEosWBDMgWHB5aYADzmqt0aRx3a0pHQ==
X-Received: by 2002:a05:6000:2887:b0:3b7:7680:35d3 with SMTP id ffacd0b85a97d-3c0ec09eedamr1193288f8f.37.1755593673846;
        Tue, 19 Aug 2025 01:54:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f07:8700:71be:5385:87b8:5a98? (p200300d82f07870071be538587b85a98.dip0.t-ipconnect.de. [2003:d8:2f07:8700:71be:5385:87b8:5a98])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1636sm2742820f8f.43.2025.08.19.01.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 01:54:33 -0700 (PDT)
Message-ID: <268d9c9b-4c48-449c-97c7-33534fb23fa3@redhat.com>
Date: Tue, 19 Aug 2025 10:54:31 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/5] selftests/mm: reimplement is_backed_by_thp() with
 more precise check
To: Zi Yan <ziy@nvidia.com>, Wei Yang <richard.weiyang@gmail.com>,
 wang lian <lianux.mm@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250818184622.1521620-1-ziy@nvidia.com>
 <20250818184622.1521620-4-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250818184622.1521620-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.08.25 20:46, Zi Yan wrote:
> and rename it to is_backed_by_folio().
> 
> is_backed_by_folio() checks if the given vaddr is backed a folio with
> a given order. It does so by:
> 1. getting the pfn of the vaddr;
> 2. checking kpageflags of the pfn;
> 
> if order is greater than 0:
> 3. checking kpageflags of the head pfn;
> 4. checking kpageflags of all tail pfns.
> 
> pmd_order is added to split_huge_page_test.c and replaces max_order.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reviewed-by: Wei Yang <richard.weiyang@gmail.com>
> Reviewed-by: wang lian <lianux.mm@gmail.com>
> ---
>   .../selftests/mm/split_huge_page_test.c       | 88 ++++++++++++++-----
>   tools/testing/selftests/mm/vm_util.c          | 13 +++
>   tools/testing/selftests/mm/vm_util.h          |  4 +
>   3 files changed, 81 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 089e146efeab..56d1eaf9a860 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -25,6 +25,7 @@
>   uint64_t pagesize;
>   unsigned int pageshift;
>   uint64_t pmd_pagesize;
> +unsigned int pmd_order;
>   
>   #define SPLIT_DEBUGFS "/sys/kernel/debug/split_huge_pages"
>   #define SMAP_PATH "/proc/self/smaps"
> @@ -34,26 +35,66 @@ uint64_t pmd_pagesize;
>   #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>   
> -#define PFN_MASK     ((1UL<<55)-1)
> -#define KPF_THP      (1UL<<22)
> -
> -static int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
> +static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
> +		int kpageflags_fd)
>   {
> -	uint64_t paddr;
> -	uint64_t page_flags;
> +	unsigned long pfn_head;
> +	uint64_t pfn_flags;
> +	unsigned long pfn;
> +	unsigned long i;

Final nit (sorry!) :)

const unsigned long nr_pages = 1ul << order;

so you can make some of the code below easier to read.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


