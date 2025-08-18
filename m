Return-Path: <linux-kselftest+bounces-39209-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB67CB29C50
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 10:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB22B201986
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 08:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408752777E4;
	Mon, 18 Aug 2025 08:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AGRqV7/O"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A60230981
	for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505996; cv=none; b=f5qUSVtyH31vf2HgKz0JgT2qoghvqPc1rDCDC8LJC6aCSAfqJ4+z/CrLj2hUqDA2Ip6wgXDN5DUs25qGCD53OpiyzAR03fjDHNGiKgeOh8lzTEBfUSRIWYPGb0cz4MfKE1//89nnhkz29RameuKMUzlKqfpN3Je4+B4lvk50cXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505996; c=relaxed/simple;
	bh=DzLINjQM7wMjJEmMii1KwC7R+Gks6NXWJECHeTe8bJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nvXOY9/BJfoyH3Zl6v69LmQKSuUWvENKxYVDSNL438mUI8c+/08JHdKe71IniGaGGYWz/5QjRgTEJv3FiuWnLvrZvIXB64/y7JZsuxUEX5OmTQeWczRTc2V6HWNL9vNoXh541JSMKiL7l9NaKfvUAQhS99QONfJOpJMtFSVcekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AGRqV7/O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755505993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+ieVfejLYp5z3U5Is6XG6mFRNxluEHCpmXjf1mF6lHw=;
	b=AGRqV7/Od1pkK8WGh8OJMq6zC1j64UHzFZlsBTGgxp7u8hyL7MqYcbzbhgxrYHNmkZSZhQ
	VE6/wHXpsOJZWtNqww8zuQX5UZnnTJyfr/FGh9/TjBzj0bboXj178EqS2N+6k5UwOeSZuB
	cX0nInUB+Ylysgr7stFEQb8ulDXOd50=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-YhzkIB0aNDKV6HnSHmSbRA-1; Mon, 18 Aug 2025 04:33:11 -0400
X-MC-Unique: YhzkIB0aNDKV6HnSHmSbRA-1
X-Mimecast-MFC-AGG-ID: YhzkIB0aNDKV6HnSHmSbRA_1755505990
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3b9d41bd50aso1922601f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Aug 2025 01:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755505990; x=1756110790;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+ieVfejLYp5z3U5Is6XG6mFRNxluEHCpmXjf1mF6lHw=;
        b=RE01WfW2sQSVCTYJ25+aool5aB+pxW9XzRA99w738s+ukm1GsGVYmnNqHy+mm0+KqS
         /Erw1Zthz2PAN1h6wxHdSYTeM5BTtf4p9rv0pMAiKrmhUV3N14OQ72y/0iNKTdUH0pO1
         onE/Kltb3iTI2Pn3t3jbYloFtuJ6U5eg2qa+A3GvdUK0dwB5r2w8voUrHscwLiBrtpBf
         fy8S86vSeOTP0LJED6iHzfCoG3qBXublB4PxaaWgM96VUKDuIVXKugHPKZqgoiFH58+a
         sQ5hrDug24PtLJh4WJpO8cQZcwK3i41d4DruVsxMaBSJvCO12C/2DtFRwZGgvZzBWTAd
         OO9w==
X-Forwarded-Encrypted: i=1; AJvYcCU4pvYFIH3vzZcTw+bG2MtkGPO+hPX28yfcMH1ACJCJkSoR1lyDL2EudZF0Ojx5cJZmR+46KXMEZNG8xkqQ1Io=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH+9PE7VodnnRKOQWcscI3LnYI8DBJd8BNiIPLD7vyJGvGsXNK
	wDuxM/yGBhvdPTDTOvcjxLnncFd+CcFU6EWpTxvf8KH6PC/q6CCdtxW/lb+K2o9I1X8P+uwuy6T
	orVZHEqmD9LV4ysUcaurq+rQjlODKRKKzuS1bkslBwp740cLhrnPcWIWqvrfTleQzsIVHtw==
X-Gm-Gg: ASbGncvW40ynzqE3I87eQFDJiBFQ7bId4nVsLLbxun+jIxsSPCS5tVobdwEAQ9fP04O
	6TJRzXSbbi+phnUofXGRTVYdDLV6d/ZP275F7O04eq8J4QhCM2/Q2JgB0C9OtKJtHl3LSmI4v3z
	Q5FlFcNeQeo/XZl3TBarEFk/RIfEItqdsmMRmHkt/AWoO1K20CtUUmpj/X/uh79y29Ap/G7G8E3
	c+YOz74BDFQWVgb5mtKSU3Vg2d/ORMF+84T/WPzkU6oKpujY29guhzwukuoo5adsS4IVf+Hozu4
	enK0jzgvzx6MP4H/XGUWFOzf9Nmkuvu0JtuPzNco69MwUZPmYXyt1Y5x8PreNoDU3DvPMVjup/V
	qbh1FTK1nh/jIfM6Wgj8ZX+xb9aFeLbEFq5+yhHgOTv2doODbzr8x1ePntvFfFMmX
X-Received: by 2002:a05:6000:2c11:b0:3b7:8fcd:d145 with SMTP id ffacd0b85a97d-3bc685cceddmr6728188f8f.5.1755505989880;
        Mon, 18 Aug 2025 01:33:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnT8cs4Rms+akYGBpJjatB4LatGCTIuMIO5Pi1mE/+LnBzXe+Ptq2nucAOqmCsTAOaOj1Cpw==
X-Received: by 2002:a05:6000:2c11:b0:3b7:8fcd:d145 with SMTP id ffacd0b85a97d-3bc685cceddmr6728147f8f.5.1755505989352;
        Mon, 18 Aug 2025 01:33:09 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39? (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de. [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9426sm12398835f8f.33.2025.08.18.01.33.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 01:33:08 -0700 (PDT)
Message-ID: <c31e9dfd-019a-4d54-8237-8c3501c730a7@redhat.com>
Date: Mon, 18 Aug 2025 10:33:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] selftests/mm: reimplement is_backed_by_thp() with
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
References: <20250815023915.1394655-1-ziy@nvidia.com>
 <20250815023915.1394655-4-ziy@nvidia.com>
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
In-Reply-To: <20250815023915.1394655-4-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15.08.25 04:39, Zi Yan wrote:
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
> ---
>   .../selftests/mm/split_huge_page_test.c       | 90 ++++++++++++++-----
>   tools/testing/selftests/mm/vm_util.c          | 13 +++
>   tools/testing/selftests/mm/vm_util.h          |  4 +
>   3 files changed, 84 insertions(+), 23 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index 89d3dc08fe4c..80f718ca21c7 100644
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
> @@ -34,27 +35,71 @@ uint64_t pmd_pagesize;
>   #define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>   
> -#define PFN_MASK     ((1UL<<55)-1)
> -#define KPF_THP      (1UL<<22)
>   #define GET_ORDER(nr_pages)    (31 - __builtin_clz(nr_pages))
>   
> -static int is_backed_by_thp(char *vaddr, int pagemap_file, int kpageflags_file)
> +static int is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
> +		int kpageflags_fd)

Could we convert this into a bool and simply return "false" on error 
instead of "-"? These tristate returns for a "is_*" function are a bit 
unfortunate.

>   {
> -	uint64_t paddr;
> -	uint64_t page_flags;
> +	unsigned long pfn_head;
> +	uint64_t pfn_flags;
> +	unsigned long pfn;
> +	unsigned long i;
>   
> -	if (pagemap_file) {
> -		pread(pagemap_file, &paddr, sizeof(paddr),
> -			((long)vaddr >> pageshift) * sizeof(paddr));
> +	if (pagemap_fd == -1 || kpageflags_fd == -1)
> +		goto fail;

Should we rather expect that callers make sure these are valid? In 
particular, because split_pte_mapped_thp() seems to ksft_exit_fail_msg() 
already.

>   
> -		if (kpageflags_file) {
> -			pread(kpageflags_file, &page_flags, sizeof(page_flags),
> -				(paddr & PFN_MASK) * sizeof(page_flags));
> +	pfn = pagemap_get_pfn(pagemap_fd, vaddr);

Hm, if it's swapped out we would get intermittent errors, but that just 
seems hard to avoid. The caller could mock to avoid swapout.

Memory migration is another possible problem ...

But this is nothing new regarding your patch, so no need to worry for now.

[...]

>   
> +int get_pfn_flags(unsigned long pfn, int kpageflags_fd, uint64_t *flags)
> +{
> +	size_t count;
> +
> +	count = pread(kpageflags_fd, flags, sizeof(*flags),
> +		      pfn * sizeof(*flags));
> +
> +	if (count != sizeof(*flags))
> +		return -1;
> +
> +	return 0;
> +}

I would have called this function "pageflags_get()" to resemble 
"pagemap_get"

-- 
Cheers

David / dhildenb


