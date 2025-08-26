Return-Path: <linux-kselftest+bounces-39941-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBDF6B35AB0
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 13:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FA487B76EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Aug 2025 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459F127707;
	Tue, 26 Aug 2025 11:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="canFekNU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D66222562
	for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 11:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756206285; cv=none; b=cwaYSzxUmV+v/JaWuv3X08tACTso2dkId8RKWgDgan0SLrnt2izy2RUakWNqPjFAuDvtzsCudaSSH6PHGz5VwnZzFWxe736+BQIWg0KdKnHchm8K5rR0u9wJ6lflt9VE/qkJFkvQzdIYXfmRLJ+hoS1Dj9xQGrAaQRICyVOoM/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756206285; c=relaxed/simple;
	bh=IQ5LDCs/IEmTXiQ4zdkXIkPVxNBQzfU++k5VF/Ufz7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TftiVUsO8IKKxYM4F2y0g104CkW3Y01fUEHpG1+O8hy/TRBeREnNg5HRgILO39F8oMzrItWKlxCzY0+lUjzRsTBNmjMWjMbn9aY5Lwgu6HbM6fgVO3NY2F4DGPzdIeb9WN30RYgAmGrSW1ff5oxzv+Z83F/6ZgEJRXfNNRILJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=canFekNU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756206281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jhHf33zPn8FMTc4V2Pm10xsHI1Kc6Z2Rv/ZWcei/RDk=;
	b=canFekNUPR0xC+PH5766rAfjaS0A7rpG1sWfH1J24eV5gKUCCWPn2aUpkG4g9qA1q3pFUO
	iIoqLx8q4zCIO3X3IjKKbYuFGh6tMbuPP1kyOrXOH7KsOHmYV19I8wZA535Sa1ICe7jDJk
	Jc2rsDjPQJVQqkYZSG4eDlCUiNq9oe8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-Bo0XKIweNv-IkBpPO6MaLA-1; Tue, 26 Aug 2025 07:04:39 -0400
X-MC-Unique: Bo0XKIweNv-IkBpPO6MaLA-1
X-Mimecast-MFC-AGG-ID: Bo0XKIweNv-IkBpPO6MaLA_1756206278
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-61c927d2bfeso668204a12.3
        for <linux-kselftest@vger.kernel.org>; Tue, 26 Aug 2025 04:04:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756206278; x=1756811078;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jhHf33zPn8FMTc4V2Pm10xsHI1Kc6Z2Rv/ZWcei/RDk=;
        b=NR2ReuGg6iMwR0YxXACz4sS7SaSCYci4spT2gFer4ex0qs1U6JCRENKqc0MdtPVZLz
         TB5ORrKWYxxt2mYXRzvGhCsoBRhP1PAmRwRE5LOAOvtxWgBb6hxC4iQLHMP9Rj/a/6a2
         VVGWqL47hcRPsVoo/yNh1egc8M9a4jWHh1Ur/osl5tVLzowUKak53uznYZdlrIP1o3YC
         R5s7v7x09VrYTD3rokJqdI4VwuXwbCJp6m8EcByE0jqw48Jub8uDSRPbWoOSvrGn+IRI
         0mLJLkzhELOBprSaHk16iJKDyDN6byVodZarck9dzaXl+BX9xxez6nGsTachZ1zA+qGK
         nxmw==
X-Forwarded-Encrypted: i=1; AJvYcCWMyz77Pjddic131rRRWpj+51INbKvLJQpu+6k6jTjFJ4YasRQh+ycAnRHQ0HZEAC/tPuZtv7EYp0n0c1LDJAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQCxkTf1OUDbor9hYRFs9v2135MqMdugN5VHP9oxIEA8dNbrUI
	ydQSnCDd/ybLnmQr1n0C6dBggnXTnJ9O8MgPt4zPvWh1De/L7ClTOxm5KTOLoIF6YRQR0XlaOqW
	qpdOr9TrIzkOmTtB6y9FqoktAGvh8RCCNP4ymFTz0Ip6c3Qamm4Xs7LyMNHElCQwB40wfyA==
X-Gm-Gg: ASbGncunlaAg67pBFu8rY7GnH6G2XFxPxovdf7W2vMJgKyHnR0ptpYNNB1Lqja64hwD
	CxAVFjCRmF8jyjzk/95nudLwa23K2Yn3wIvwi8RKEk/3mfieb67/ARdjbSisQyBxaTWbU8bj//C
	QKZ150l7iiIDYg9HNbXJ9k8OjuXJK9aYk73lki9L30RhYHXSX6awknj6LLEKMoUhEy3YyuY5j+l
	joY30wwITW4HflkTjCg2H+9k1VGJJFkd/OMKVP5NZPwiPdQ/+PWguPbT1tIrm3gF9Bl70WBuREq
	mQ8rVqhoem+jANrZCCPghM8R//eafdAnhZTlhQ66/cm3drh81kUX1kQA4jlczqHLfxa8R6F4yw=
	=
X-Received: by 2002:a05:6402:510e:b0:61c:a1a6:52a2 with SMTP id 4fb4d7f45d1cf-61ca1a65d0amr110485a12.28.1756206278237;
        Tue, 26 Aug 2025 04:04:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJfWOpyeYnJbaHVglB9KfY+PTnQ4jI93qRAexOTMKIRVofYBVmmLclF7ZKvry/r0B75eD1FQ==
X-Received: by 2002:a05:6402:510e:b0:61c:a1a6:52a2 with SMTP id 4fb4d7f45d1cf-61ca1a65d0amr110409a12.28.1756206276561;
        Tue, 26 Aug 2025 04:04:36 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c3172bf4csm6850118a12.38.2025.08.26.04.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 04:04:36 -0700 (PDT)
Message-ID: <ad521f4f-47aa-4728-916f-3704bf01f770@redhat.com>
Date: Tue, 26 Aug 2025 13:04:33 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 21/35] mm/cma: refuse handing out non-contiguous page
 ranges
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: linux-kernel@vger.kernel.org, Alexander Potapenko <glider@google.com>,
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
 <20250821200701.1329277-22-david@redhat.com> <aK2QZnzS1ErHK5tP@raptor>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <aK2QZnzS1ErHK5tP@raptor>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>>   
>>   		pr_debug("%s(): memory range at pfn 0x%lx %p is busy, retrying\n",
>> -			 __func__, pfn, pfn_to_page(pfn));
>> +			 __func__, pfn, page);
>>   
>>   		trace_cma_alloc_busy_retry(cma->name, pfn, pfn_to_page(pfn),
> 
> Nitpick: I think you already have the page here.

Indeed, forgot to clean that up as well.

> 
>>   					   count, align);
>> -		/* try again with a bit different memory target */
>> -		start = bitmap_no + mask + 1;
>>   	}
>>   out:
>> -	*pagep = page;
>> +	if (!ret)
>> +		*pagep = page;
>>   	return ret;
>>   }
>>   
>> @@ -882,7 +892,7 @@ static struct page *__cma_alloc(struct cma *cma, unsigned long count,
>>   	 */
>>   	if (page) {
>>   		for (i = 0; i < count; i++)
>> -			page_kasan_tag_reset(nth_page(page, i));
>> +			page_kasan_tag_reset(page + i);
> 
> Had a look at it, not very familiar with CMA, but the changes look equivalent to
> what was before. Not sure that's worth a Reviewed-by tag, but here it in case
> you want to add it:
> 
> Reviewed-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks!

> 
> Just so I can better understand the problem being fixed, I guess you can have
> two consecutive pfns with non-consecutive associated struct page if you have two
> adjacent memory sections spanning the same physical memory region, is that
> correct?

Exactly. Essentially on SPARSEMEM without SPARSEMEM_VMEMMAP it is not 
guaranteed that

	pfn_to_page(pfn + 1) == pfn_to_page(pfn) + 1

when we cross memory section boundaries.

It can be the case for early boot memory if we allocated consecutive 
areas from memblock when allocating the memmap (struct pages) per memory 
section, but it's not guaranteed.

So we rule out that case.

-- 
Cheers

David / dhildenb


