Return-Path: <linux-kselftest+bounces-40613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FBFB408EE
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 17:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B9D63ACF66
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 15:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE27320A03;
	Tue,  2 Sep 2025 15:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EC5UXrQ/"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81432038E
	for <linux-kselftest@vger.kernel.org>; Tue,  2 Sep 2025 15:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756826906; cv=none; b=ISGO9LcMr1VgokoYJtiTvNCZnt5q2ydJhlQCAMhi0R6OoQFVVtvKDoXo94od/7mlbj/Ek8FmvlbNnfmkvNzpk3HRB2RJtMS0sqKvg29ZTgGLA21aD8O4g01XjajxhFtuTntaLvz98TF5ahqHLqjuWvQpbfEt8RZr0DzItu6RJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756826906; c=relaxed/simple;
	bh=Qb8HkKFaIb9i/VlYP2RjmwPEvXqvY7UTCzUA24uVVGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F6ZQVTUthGCPYe6x1MQpwXiiyqM7eDAVDRyywXpn/+AzmI3oAE6gDGsSGQKvVOeeJi9C25ZeYhl/JqIH6gX21KOd6642lfcaiH2Ig+Bygce5wPrbt7smAkNDc3r22p2M59gb+mbr7ESr63byVIJ/yP08fGft6nFhOq5rbqOjuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EC5UXrQ/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756826903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hSh4ojjlck0In0Q+qbLzFlqnWtZCvC/pw08b7Fd5bkY=;
	b=EC5UXrQ/p44m2yw7STieSYjZD5gcX6hcH6NvqgLwCyQiiLdMcbqlD8EHELbPfUM/Ge5HGa
	/LEyljlBp9bAZ/Vy1C3kZd4lPTpsSFSOVnfaVD/1CakNZKjuDhp+krQ6zhMi1HnFrBUfqD
	f7HtAnsP3UjMKnw8rmvdDt2VVwGnmBc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-141-kF00R6W8Ozu9A0a4ROtG_Q-1; Tue, 02 Sep 2025 11:28:21 -0400
X-MC-Unique: kF00R6W8Ozu9A0a4ROtG_Q-1
X-Mimecast-MFC-AGG-ID: kF00R6W8Ozu9A0a4ROtG_Q_1756826901
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3cf48ec9fc1so2796722f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Sep 2025 08:28:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756826900; x=1757431700;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSh4ojjlck0In0Q+qbLzFlqnWtZCvC/pw08b7Fd5bkY=;
        b=FhH/Z+ChD4QPl1MF2+C0wkwR2eaDUgA4391k24r1zrS6vmogjPFlMGCJKz+HEjR61i
         h5+qkRvN6U6fgOdbfKxHYw76yNrZNmE93JwjzZRdP/W2JO1iht1Y3ULu0o7F+MNMW9/5
         g5z5zqo7cd+ExC/rPlIhDQugYe10rMBOQDHi38blJs5Opg8A6+fvy/bAUpl1rdT6trC9
         cGi8DPeqoz0YFAHSGGXGdPi1t40bMRmLOiKKp/oM1PkudUdNkdo6r3U/FqiCGRF3/4ib
         zPEFu3InI9/9SkIBQ9nhop5bB0BBhHH4yA7h/LhvI2o/Y/MJbz5mz1OgWkjbNxxDxC+J
         2XXA==
X-Forwarded-Encrypted: i=1; AJvYcCWgZjdo06f6rfS8Zh2FrmlZ4BkW4aricvkxH8Mgxm76yC115AkNJrb4K3F0PIaMXCGC5xtJTYPzgvG4xOORHFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwcBVWQsEqLSrzfyU2SCI2i2gvB3LD9CCSpu0No70yZhklFyil
	sS8vjwq3SwJeG9im4Ij+Ktq0fgF3VJQlxvxKFevKybboAkMad7goQWiiyHnWER60eAByfpmtecj
	tBpSwGbFcGyV/jn2uigdDk1tlhxdX+GgSfu6OfoBfYdIIE9BqWSsasL6wi9PEu0+cfBF9Sg==
X-Gm-Gg: ASbGncv96PgtgyPWVk5U3ye/y0F9IdNdmAVHWJx19ZNrTkS6l2yk6VqVHXNP0y3Cq9S
	D+Jjr368LlBomb4g84F2Irn5GYtleDVqSdUskw0GDR9N3IKPKueWal0/5/anSEOP+jVARnDGRhW
	PcDyXkk3Am1C7CTpH//YvTsqDRs2pGUISG5T+Sq6DLyxfFmwBvNm6C5opqoTx7bkm49mt9ZvzxK
	ZtL4uhCtZ4mxIXw82BD8mJzKAOenHvWbWGt65BTWzJIRlg/w0s1NBlSsu9wMN9c+13QAd5Y3MSe
	n00geGD2qnDtPUOZPmpgwSHk1zWbBXTtahVuQdmSKAAbuKrFV1lKid8qBg85RlgOcnCeVp/oO7w
	MwTTL2iNy82xDWgdgU7ZE6Ksx/+Idco3TOGMSt5VuRpiIxTuTFP7FFMYt+6yvaOnv3AU=
X-Received: by 2002:a05:6000:1789:b0:3dc:1473:18f1 with SMTP id ffacd0b85a97d-3dc1473196cmr268166f8f.14.1756826900492;
        Tue, 02 Sep 2025 08:28:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnfEsLIQOhXITgQs5Nd0yn9CNhyySCm8tGdWnkDE1oq8HRfUeU1bl0fwY9TAfCj+Y9a/fGzQ==
X-Received: by 2002:a05:6000:1789:b0:3dc:1473:18f1 with SMTP id ffacd0b85a97d-3dc1473196cmr268139f8f.14.1756826900022;
        Tue, 02 Sep 2025 08:28:20 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f1f:3f00:731a:f5e5:774e:d40c? (p200300d82f1f3f00731af5e5774ed40c.dip0.t-ipconnect.de. [2003:d8:2f1f:3f00:731a:f5e5:774e:d40c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3cf33fb9d37sm20334663f8f.49.2025.09.02.08.28.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Sep 2025 08:28:19 -0700 (PDT)
Message-ID: <1d7e9c30-343e-41c4-814d-f6254b042509@redhat.com>
Date: Tue, 2 Sep 2025 17:28:18 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2] selftests/mm: check content to see whether mremap
 corrupt data
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
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <27A308FD-C7D8-4C65-90BA-9B1DC117B014@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[...]

>> @@ -390,67 +390,88 @@ static void split_pmd_thp_to_order(int order)
>>    static void split_pte_mapped_thp(void)
>>   {
>> -	char *one_page, *pte_mapped, *pte_mapped2;
>> -	size_t len = 4 * pmd_pagesize;
>> -	uint64_t thp_size;
>> +	const size_t nr_thps = 4;
>> +	const size_t thp_area_size = nr_thps * pmd_pagesize;
>> +	const size_t page_area_size = nr_thps * pagesize;
>> +	char *thp_area, *page_area = NULL, *tmp;
>>   	size_t i;
>>   -	one_page = mmap((void *)(1UL << 30), len, PROT_READ | PROT_WRITE,
>> +	thp_area = mmap((void *)(1UL << 30), thp_area_size, PROT_READ | PROT_WRITE,
>>   			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> -	if (one_page == MAP_FAILED)
>> -		ksft_exit_fail_msg("Fail to allocate memory: %s\n", strerror(errno));
>> +	if (thp_area == MAP_FAILED) {
>> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>> +		goto out;
> 
> thp_area mmap failed and out label will try to munmap MAP_FAILED, which is
> (void *) -1. munmap will fail with -EINVAL.

Indeed, should just be a "return;"

> 
>> +	}
>>   -	madvise(one_page, len, MADV_HUGEPAGE);
>> +	madvise(thp_area, thp_area_size, MADV_HUGEPAGE);
>>   -	for (i = 0; i < len; i++)
>> -		one_page[i] = (char)i;
>> +	for (i = 0; i < thp_area_size; i++)
>> +		thp_area[i] = (char)i;
>>   -	if (!check_huge_anon(one_page, 4, pmd_pagesize))
>> -		ksft_exit_fail_msg("No THP is allocated\n");
>> +	if (!check_huge_anon(thp_area, nr_thps, pmd_pagesize)) {
>> +		ksft_test_result_skip("Not all THPs allocated\n");
>> +		goto out;
>> +	}
>>   -	/* remap the first pagesize of first THP */
>> -	pte_mapped = mremap(one_page, pagesize, pagesize, MREMAP_MAYMOVE);
>> -
>> -	/* remap the Nth pagesize of Nth THP */
>> -	for (i = 1; i < 4; i++) {
>> -		pte_mapped2 = mremap(one_page + pmd_pagesize * i + pagesize * i,
>> -				     pagesize, pagesize,
>> -				     MREMAP_MAYMOVE|MREMAP_FIXED,
>> -				     pte_mapped + pagesize * i);
>> -		if (pte_mapped2 == MAP_FAILED)
>> -			ksft_exit_fail_msg("mremap failed: %s\n", strerror(errno));
>> -	}
>> -
>> -	/* smap does not show THPs after mremap, use kpageflags instead */
>> -	thp_size = 0;
>> -	for (i = 0; i < pagesize * 4; i++)
>> -		if (i % pagesize == 0 &&
>> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>> -			thp_size++;
>> -
>> -	if (thp_size != 4)
>> -		ksft_exit_fail_msg("Some THPs are missing during mremap\n");
>> -
>> -	/* split all remapped THPs */
>> -	write_debugfs(PID_FMT, getpid(), (uint64_t)pte_mapped,
>> -		      (uint64_t)pte_mapped + pagesize * 4, 0);
>> -
>> -	/* smap does not show THPs after mremap, use kpageflags instead */
>> -	thp_size = 0;
>> -	for (i = 0; i < pagesize * 4; i++) {
>> -		if (pte_mapped[i] != (char)i)
>> -			ksft_exit_fail_msg("%ld byte corrupted\n", i);
>> +	/*
>> +	 * To challenge spitting code, we will mremap page[x] of the
>> +	 * thp[x] into a smaller area, and trigger the split from that
>> +	 * smaller area. This will end up replacing the PMD mappings in
>> +	 * the thp_area by PTE mappings first, leaving the THPs unsplit.
>> +	 */
>> +	page_area = mmap(NULL, page_area_size, PROT_READ | PROT_WRITE,
>> +			MAP_ANONYMOUS | MAP_PRIVATE, -1, 0);
>> +	if (page_area == MAP_FAILED) {
>> +		ksft_test_result_fail("Fail to allocate memory: %s\n", strerror(errno));
>> +		goto out;
>> +	}
>>   -		if (i % pagesize == 0 &&
>> -		    !is_backed_by_folio(&pte_mapped[i], 0, pagemap_fd, kpageflags_fd))
>> -			thp_size++;
>> +	for (i = 0; i < nr_thps; i++) {
>> +		tmp = mremap(thp_area + pmd_pagesize * i + pagesize * i,
>> +			     pagesize, pagesize, MREMAP_MAYMOVE|MREMAP_FIXED,
>> +			     page_area + pagesize * i);
>> +		if (tmp != MAP_FAILED)
>> +			continue;
>> +		ksft_test_result_fail("mremap failed: %s\n", strerror(errno));
>> +		goto out;
>> +	}
>> +
>> +	/*
>> +	 * Verify that our THPs were not split yet. Note that
>> +	 * check_huge_anon() cannot be used as it checks for PMD mappings.
>> +	 */
>> +	for (i = 0; i < nr_thps; i++) {
>> +		if (is_backed_by_folio(page_area + i * pagesize, pmd_order,
>> +				       pagemap_fd, kpageflags_fd))
>> +			continue;
>> +		ksft_test_result_fail("THP %zu missing after mremap\n", i);
>> +		goto out;
>>   	}
>>   -	if (thp_size)
>> -		ksft_exit_fail_msg("Still %ld THPs not split\n", thp_size);
>> +	/* Split all THPs through the remapped pages. */
>> +	write_debugfs(PID_FMT, getpid(), (uint64_t)page_area,
>> +		      (uint64_t)page_area + page_area_size, 0);
>> +
>> +	/* Corruption during mremap or split? */
>> +	for (i = 0; i < page_area_size; i++) {
>> +		if (page_area[i] == (char)i)
>> +			continue;
>> +		ksft_test_result_fail("%zu byte corrupted\n", i);
>> +		goto out;
>> +	}
>> +
>> +	/* Split failed? */
>> +	for (i = 0; i < nr_thps; i++) {
>> +		if (is_backed_by_folio(&page_area[i], 0, pagemap_fd, kpageflags_fd))
> 			
> page_area + i * pagesize, like Wei pointed out in another email.
> 
>> +			continue;
>> +		ksft_test_result_fail("THP %zu not split\n", i);
>> +	}
>>    	ksft_test_result_pass("Split PTE-mapped huge pages successful\n");
>> -	munmap(one_page, len);
>> +out:
>> +	munmap(thp_area, thp_area_size);
>> +	if (page_area)
>> +		munmap(page_area, page_area_size);
>>   }
>>    static void split_file_backed_thp(int order)
>> -- 
>> 2.50.1
> 
> Otherwise, LGTM. With all the changes in this email and other email,
> feel free to add Reviewed-by: Zi Yan <ziy@nvidia.com> when you send it
> out formally.

Thanks!

I'm currently chasing why I keep getting temporary

Bail out! Some THPs are missing during mremap

Already on the old test. Something doesn't work quite right as it seems.

-- 
Cheers

David / dhildenb


