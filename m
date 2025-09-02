Return-Path: <linux-kselftest+bounces-40619-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C854B4093C
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCB216CAAD
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 15:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C45E20485B;
	Tue,  2 Sep 2025 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A0XEad38"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A660E28C01E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 15:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827632; cv=none; b=te4IRwP8IN0kacThHhBQKI9DFw3WjXDzFrCuw7Bm+YD0ZEql15JWTJmqmxfhSaLkV0zBeYHqL6VbducqSQbuMWyF03FDliSZJKP40yXDyQ02rWkbhonYg8bS5Kh75rYmMcM7sfT7sKhfCHC2w4n3bwcQ5BNXsVX6cXE07VVRH5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827632; c=relaxed/simple;
	bh=H4LboTSKBotmDdZD1aaNHt6QQNjUuabH97PCS3M6LLE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mKyIoBwpoj5OU58aWRmAQJcqs8GFs51s9hQ0stssdeGvS4wyLzSx10xRZ7eA5diU5o2ldxskUlDMxo5vYNcWw1TvHwM81qbDNnCMffAd7nXESfSVp4rxZdwXHiPEE8LKVUnsG8cBUda/UTzx3pTTiSZ1IYwXa5GwE2IfDUqpWYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A0XEad38; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756827629;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4PQsDee9NYIXTDUeC3sILYClfZwEF/KcDfxyRjS+bzM=;
	b=A0XEad38UCHStmiUumi0MOOydtssjFbaR6K9gI0M8OFUT4Mfmf1k5AWl77XmhehgEz8ZJj
	Y2pFPH9HqklOX31nxYDzAPcWPdX73LxGgwe2gAiep9vfhmnNV2vi+77gHnhcmg6SEdJdNH
	D32paygb+TWIzKFPVExbz4RRvNWw6bA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-j6AyIgxPNGW9583r4xowLA-1; Tue, 02 Sep 2025 11:40:28 -0400
X-MC-Unique: j6AyIgxPNGW9583r4xowLA-1
X-Mimecast-MFC-AGG-ID: j6AyIgxPNGW9583r4xowLA_1756827627
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3d2edf6af18so1600932f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 08:40:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827627; x=1757432427;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4PQsDee9NYIXTDUeC3sILYClfZwEF/KcDfxyRjS+bzM=;
        b=rN6rDoB+0hxU7i5fk7TCsyYdV6dU9HH0ksw+YC9XeeapH5kinaA9WQ5gYjmxMlrfRc
         g1eqMtTbpVJU/XU2Q69g/iN45NeV0dkH0jgx+x/a3JayUHTAiWt47/1QiPLrtRmUIY33
         STROtUMD5OkQ79u5GgAIuvrAxtL84iUuBdn8IQj0KfL5caA0/h00ej2Qr7mrKZ8pdMbY
         RIB/9tS9PNT/v3XDVupkau0O6TM87Y+N+OOTf1XPIvwnzx65g2npxzah/eR3umKflpxc
         LFcOz/SQwuLMwLPegUDiga91RZKaxoLjKQQdir4f28/pKA9qMPojA+UgGzk+p8WQTf9h
         L5Ew==
X-Forwarded-Encrypted: i=1; AJvYcCVA0MgQBQ/89RU1XRJFjXzH05H247XuEzzmaFsvg1s+y1KJ6+2QGfkIIvmsmzPPoEgQH6Vp6DYr1E6tfpo5rVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/lWiYQBOY0oS3vAXf8ced6CI1JndIIOdOtszYZwlGzU9liBBk
	lQsssTLqZZsQVSad+wPgb1XfMCs1AoN7dxo6TRoUpMwlUeV2UE0tSoi1CFMr7DZ1VfW+kshVFPg
	5sOpH5ESRGXHALvzKGw7u4FUgZL0MpfqOrOv3SLpJ3rOdLygNBuvpyg/IyTffHCiK0hHWog==
X-Gm-Gg: ASbGncs5RimAlGNDscbBgL4iGSncN/QNtlfQ04U0V6iTs9oF5eF5ivGt49OQDYjj/Eg
	E5YffmEdlustwYBwY4sbv/fzmu2IgSS3YPfM+hfA1mdMV3w6DBJDcDEhr5ugYs3bVvXO4O7w5+r
	FEPMpvy2eXxpTZuwfW9o22BWQxbSlhIUzhJGzkODjaAEIBkfrWeNMUjqDLMOcX+fbg+g4G6XGc1
	Fi7nGPeHQQVUDw3R96e+9jY8xyBlRbYW29YjvQc3Qzxc+HbBbjU8bGFeoeaPnhi/IOg3/gE4rUo
	CVv43mbbA57BhnLaNAAZ55PjSsilpkfbxeMj9ZOm3gg3acprgyL7vIhM64FX4BYHD48i2q50Y3s
	b8qlbz/nf/0B5aSmiCrP5Y9kJtoNP91D3gkUrpwXPm2l+aeskhlaCDApMfc47K13VDNA=
X-Received: by 2002:a5d:5f44:0:b0:3d4:4a27:b1c with SMTP id ffacd0b85a97d-3d44a270e7fmr7177846f8f.28.1756827627146;
        Tue, 02 Sep 2025 08:40:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4FPky/sgy/N/Ry+JvGWmVxkdhlOkvKSYWJloSSkuJerelw+6xOcyYXqOq3BmCqi5iyUbw+w==
X-Received: by 2002:a5d:5f44:0:b0:3d4:4a27:b1c with SMTP id ffacd0b85a97d-3d44a270e7fmr7177818f8f.28.1756827626617;
        Tue, 02 Sep 2025 08:40:26 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3da13041bcasm3847253f8f.35.2025.09.02.08.40.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:40:26 -0700 (PDT)
Message-ID: <d987da2b-1b27-41fb-8e30-cbe9a9fe1cc0@redhat.com>
Date: Tue, 2 Sep 2025 17:40:25 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
From: David Hildenbrand <david@redhat.com>
To: Zi Yan <ziy@nvidia.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250831022701.2595-1-richard.weiyang@gmail.com>
 <f8e942de-1a50-412e-9020-1bc901b4243b@redhat.com>
 <61E58B7C-23D0-49FE-8D0C-CE0B672114E2@nvidia.com>
 <0a0b0018-9427-4201-bf53-6aeb251bc482@redhat.com>
 <1D88E773-C11E-4F28-A13A-1A681898198B@nvidia.com>
 <5a796574-0a3c-4040-b0bc-3ff757402759@redhat.com>
 <27A308FD-C7D8-4C65-90BA-9B1DC117B014@nvidia.com>
 <1d7e9c30-343e-41c4-814d-f6254b042509@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <1d7e9c30-343e-41c4-814d-f6254b042509@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02.09.25 17:28, David Hildenbrand wrote:
> [...]
> 
>>> @@ -390,67 +390,88 @@ static void split_pmd_thp_to_order(int order)
>>>     static void split_pte_mapped_thp(void)
>>>    {
>>> -	char *one_page, *pte_mapped, *pte_mapped2;
>>> -	size_t len = 4 * pmd_pagesize;
>>> -	uint64_t thp_size;
>>> +	const size_t nr_thps = 4;
>>> +	const size_t thp_area_size = nr_thps * pmd_pagesize;
>>> +	const size_t page_area_size = nr_thps * pagesize;
>>> +	char *thp_area, *page_area = NULL, *tmp;
>>>    	size_t i;
>>>    -	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>>> +	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
>>>    			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>> -	if (one_page == MAP_FAILED)
>>> -		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>>> +	if (thp_area == MAP_FAILED) {
>>> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>>> +		goto out;
>>
>> thp_area mmap failed and out label will try to munmap MAP_FAILED, which is
>> (void *) -1. munmap will fail with -EINVAL.
> 
> Indeed, should just be a "return;"
> 
>>
>>> +	}
>>>    -	madvise(one_page, len, MADV_HUGEPAGE);
>>> +	madvise(thp_area, thp_area_size, MADV_HUGEPAGE);
>>>    -	for (i = 0; i < len; i++)
>>> -		one_page[i] = (char)i;
>>> +	for (i = 0; i < thp_area_size; i++)
>>> +		thp_area[i] = (char)i;
>>>    -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
>>> -		ksft_exit_fail_msg("No THP is allocated\n");
>>> +	if (!check_huge_anon(thp_area, nr_thps, pmd_pagesize)) {
>>> +		ksft_test_result_skip("Not all THPs allocated\n");
>>> +		goto out;
>>> +	}
>>>    -	/* remap the first pagesize of first THP */
>>> -	pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
>>> -
>>> -	/* remap the Nth pagesize of Nth THP */
>>> -	for (i = 1; i < 4; i++) {
>>> -		pte_mapped2 = mremap(one_page + pmd_pagesize * i + pagesize * i,
>>> -				     pagesize, pagesize,
>>> -				     MREMAP_MAYMOVE|MREMAP_FIXED,
>>> -				     pte_mapped + pagesize * i);
>>> -		if (pte_mapped2 == MAP_FAILED)
>>> -			ksft_exit_fail_msg("mremap failed: %s\n", strerror(errno));
>>> -	}
>>> -
>>> -	/* smap does not show THPs after mremap, use kpageflags instead */
>>> -	thp_size = 0;
>>> -	for (i = 0; i < pagesize * 4; i++)
>>> -		if (i % pagesize == 0 &&
>>> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>>> -			thp_size++;
>>> -
>>> -	if (thp_size != 4)
>>> -		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
>>> -
>>> -	/* split all remapped THPs */
>>> -	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
>>> -		      (uint64_t)pte_mapped + pagesize * 4, 0);
>>> -
>>> -	/* smap does not show THPs after mremap, use kpageflags instead */
>>> -	thp_size = 0;
>>> -	for (i = 0; i < pagesize * 4; i++) {
>>> -		if (pte_mapped[i] != (char)i)
>>> -			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>>> +	/*
>>> +	 * To challenge spitting code, we will mremap page[x] of the
>>> +	 * thp[x] into a smaller area, and trigger the split from that
>>> +	 * smaller area. This will end up replacing the PMD mappings in
>>> +	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
>>> +	 */
>>> +	page_area = mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
>>> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>>> +	if (page_area == MAP_FAILED) {
>>> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>>> +		goto out;
>>> +	}
>>>    -		if (i % pagesize == 0 &&
>>> -		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
>>> -			thp_size++;
>>> +	for (i = 0; i < nr_thps; i++) {
>>> +		tmp = mremap(thp_area + pmd_pagesize * i + pagesize * i,
>>> +			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
>>> +			     page_area + pagesize * i);
>>> +		if (tmp != MAP_FAILED)
>>> +			continue;
>>> +		ksft_test_result_fail("mremap failed: %s\n", strerror(errno));
>>> +		goto out;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Verify that our THPs were not split yet. Note that
>>> +	 * check_huge_anon() cannot be used as it checks for PMD mappings.
>>> +	 */
>>> +	for (i = 0; i < nr_thps; i++) {
>>> +		if (is_backed_by_folio(page_area + i * pagesize, pmd_order,
>>> +				       pagemap_fd, kpageflags_fd))
>>> +			continue;
>>> +		ksft_test_result_fail("THP %zu missing after mremap\n", i);
>>> +		goto out;
>>>    	}
>>>    -	if (thp_size)
>>> -		ksft_exit_fail_msg("Still %ld THPs not split\n", thp_size);
>>> +	/* Split all THPs through the remapped pages. */
>>> +	write_debugfs(PID_FMT, getpid(), (uint64_t)page_area,
>>> +		      (uint64_t)page_area + page_area_size, 0);
>>> +
>>> +	/* Corruption during mremap or split? */
>>> +	for (i = 0; i < page_area_size; i++) {
>>> +		if (page_area[i] == (char)i)
>>> +			continue;
>>> +		ksft_test_result_fail("%zu byte corrupted\n", i);
>>> +		goto out;
>>> +	}
>>> +
>>> +	/* Split failed? */
>>> +	for (i = 0; i < nr_thps; i++) {
>>> +		if (is_backed_by_folio(&page_area[i], 0, pagemap_fd, kpageflags_fd))
>> 			
>> page_area + i * pagesize, like Wei pointed out in another email.
>>
>>> +			continue;
>>> +		ksft_test_result_fail("THP %zu not split\n", i);
>>> +	}
>>>     	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
>>> -	munmap(one_page, len);
>>> +out:
>>> +	munmap(thp_area, thp_area_size);
>>> +	if (page_area)
>>> +		munmap(page_area, page_area_size);
>>>    }
>>>     static void split_file_backed_thp(int order)
>>> -- 
>>> 2.50.1
>>
>> Otherwise, LGTM. With all the changes in this email and other email,
>> feel free to add Reviewed-by: Zi Yan <ziy@nvidia.com> when you send it
>> out formally.
> 
> Thanks!
> 
> I'm currently chasing why I keep getting temporary
> 
> Bail out! Some THPs are missing during mremap
> 
> Already on the old test. Something doesn't work quite right as it seems.
> 

Ah, I think I know why:

  diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
index c94fd64066ef6..4051a5c98a97c 100644
--- a/tools/testing/selftests/mm/split_huge_page_test.c
+++ b/tools/testing/selftests/mm/split_huge_page_test.c
@@ -95,7 +95,7 @@ static bool is_backed_by_folio(char *vaddr, int order, int pagemap_fd,
                 return true;
  
         /* this folio is bigger than the given order */
-       if (pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL))
+       if (pfn_flags & (KPF_THP | KPF_COMPOUND_TAIL) == KPF_THP | KPF_COMPOUND_TAIL)
                 return false;
  
         return true;

Let me test with that.

-- 
Cheers

David / dhildenb


