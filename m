Return-Path: <linux-kselftest+bounces-40433-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 267B4B3E3BD
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 14:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECAF97A37A7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Sep 2025 12:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE632C336;
	Mon,  1 Sep 2025 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X0SKeGWL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A943112B3
	for <linux-kselftest@vger.kernel.org>; Mon,  1 Sep 2025 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756731254; cv=none; b=JHzyKk4KmwztxHMDBk0C4ZfyFAzwHbt8qw+VIqKknxF3Va5OjwP78cqDy+b4pTzLFVjyO9uhGWfI1Y/5jaTo5UMSr1k25Mi2t/3YPhuke9cYZpOOEg6XZEk18x0n521CdGmRwD/Fy7xEABEXwIXw2F/LsvOKRjLz5Jwg1U+WqlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756731254; c=relaxed/simple;
	bh=9IbQNg92VX62WaLyO3aM+RL9AqnbJzMbusdNdjhixT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTIWAlnLC5AVYyiUJuQBzRizgNnl289LlZWn4yEeCNcGs01RuuHS89yUJqI4XOXkNAYveOJCg+caUWP3wpsuRiiL5Qks86Q5DNZBdkIUrJZWIIao6lEe/Jt4g/yC6Rk+q2uAlU+i+RTdd9Bg/a9PtfS5BkAkbe0yxnye9ZTAmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X0SKeGWL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756731252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Vyych5IUQLtEu/xa/A0XqGkr8fWN8lrWcKM9TaSPFq0=;
	b=X0SKeGWLtObJctGkY9WhMJkErpz58K9CmgCeLVyqYKaz3pi+MlmEec18mmY5kzzQPiBEol
	O/sbTZOd2L5a1LfN2jAYeWrCsnNVliyn5+Q2pg6Hdo6wDMsper6axUDImSg7r/hnQDpJbW
	vYlg92fjgxCzollHd1PRbK4kZZeRILw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-JIv1lw-8NuiT9h8n62YHJw-1; Mon, 01 Sep 2025 08:54:10 -0400
X-MC-Unique: JIv1lw-8NuiT9h8n62YHJw-1
X-Mimecast-MFC-AGG-ID: JIv1lw-8NuiT9h8n62YHJw_1756731249
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-45b87bc6869so12096465e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 01 Sep 2025 05:54:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756731249; x=1757336049;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vyych5IUQLtEu/xa/A0XqGkr8fWN8lrWcKM9TaSPFq0=;
        b=m54t9Rs3LjmWr4+1RyywsRq2E9X5ZrzUApJc16TJ0QXQg5mtvJl85FMXbcP65qX0mZ
         LYvqCKg8i22YJ02K4VEcPWTw9+DSIojJ906e4gnoVtZzEzdA6k6QlU1PW9o4kS4lwcrY
         82/DsQQ7v6AgNExjOyV057DiAjGB60kbw/P79RSoMKn44+TK4FlO0ZA8vLbG4d9p/Ud8
         XvID6djjq1n3u8y4wTmUxf8I1/0nBoPV3JBiI0QeQk48Jz7UAK1XVpp+f0WuaZFBDu9q
         ivOgcPsN3xUzfjSbdYmxTLE9dmxUO54L0HC7SppvzCizDNg2uTvkDRyrVBAPu4wifTHN
         6lfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgmpwlT1c5MWuKrnTRTvZznA9QKM9RS0Ysgt0b9XI2HQT3RgkHp2UnFwcBZLopCia71aVi013luros38GsYK4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDASmXOtTkEXsBMpj6kAkasbchfyVcsj5W9+iek7gQMv+Zjuja
	cSyenTBaYxQPOrwwSbfzacO4L7Cf+IogwNut5fzDMvB5lW/orIcaNz15aB65EhkIyMsf/LvROE9
	sLgv4x9tkAQYPovUpIKAu8/+iAVHeMsxOjEbOj/yBsdzKgY5l5u7KotVNUTHfRgQ1A3u8FA==
X-Gm-Gg: ASbGncsv1iVfM4ixuOTnXtLYXkZ69ulCG8rEHq5HBHA9xJ9K9JrmU5UtjAs8AlA1OOt
	JnXgaLOnqS/rr9cJI8SRyXW/mZxAtXnxaSkM6eA2+eQZmP4CxYLG0zJ1KMJKm++TiQdSjayJU+3
	RhboFzf7+h95o4v6bAdPcqQY/kCg/DLVQh0CnlSWEewUB0E4B7mCvbUyMZfWthNrgG5JkomVoBW
	02ZgAO+Pry+zBntVFDE2+RCsiD23DO9B8HKxPioEp2hUgZGu8Ce3b8X7jl3RRcFjRKjCyp9qMfz
	+mIv69JUNgkzIu8Ikm6TNgA0ivdaJLmEhX1WNqc++rFMt+IevcxvnyNMmc+BpUUnHnc1zBN/qtP
	jSMESEagpLUuTJWerwUV3uok7XWv3hCoL0ifNgoV5p695iN1MkS/K9FDt0Vu5lM403KI=
X-Received: by 2002:a05:600c:3543:b0:45b:87b6:1f65 with SMTP id 5b1f17b1804b1-45b87b62146mr51137805e9.21.1756731248940;
        Mon, 01 Sep 2025 05:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE0CKCVqu16gwWVYQD17Tvg0mK0Hr9EQxiFvygZkxb3jpFTWdzldhbTv1mVs1RCO3C49asHCQ==
X-Received: by 2002:a05:600c:3543:b0:45b:87b6:1f65 with SMTP id 5b1f17b1804b1-45b87b62146mr51137495e9.21.1756731248488;
        Mon, 01 Sep 2025 05:54:08 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f37:2b00:948c:dd9f:29c8:73f4? (p200300d82f372b00948cdd9f29c873f4.dip0.t-ipconnect.de. [2003:d8:2f37:2b00:948c:dd9f:29c8:73f4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b7e7d2393sm155934915e9.3.2025.09.01.05.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 05:54:08 -0700 (PDT)
Message-ID: <76079f7e-9874-41a5-ab00-9fa4765f8ee0@redhat.com>
Date: Mon, 1 Sep 2025 14:54:07 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: directly add pagesize instead of increase
 until page size
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Zi Yan <ziy@nvidia.com>, akpm@linux-foundation.org,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20250830023102.14981-1-richard.weiyang@gmail.com>
 <E0C570E7-C4CD-4E41-9590-DDB64757CA2C@nvidia.com>
 <c89a9096-716a-4bbb-a911-99096ff8f0a0@redhat.com>
 <20250901125126.furb4fkgim7adzhq@master>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250901125126.furb4fkgim7adzhq@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01.09.25 14:51, Wei Yang wrote:
> On Mon, Sep 01, 2025 at 11:32:11AM +0200, David Hildenbrand wrote:
>> On 31.08.25 03:32, Zi Yan wrote:
>>> On 29 Aug 2025, at 22:31, Wei Yang wrote:
>>>
>>>> The check of is_backed_by_folio() is done on each page.
>>>>
>>>> Directly move pointer to next page instead of increase one and check if
>>>> it is page size aligned.
>>>>
>>>> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
>>>> ---
>>>>    tools/testing/selftests/mm/split_huge_page_test.c | 5 ++---
>>>>    1 file changed, 2 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> index 10ae65ea032f..7f7016ba4054 100644
>>>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>>>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>>>> @@ -423,9 +423,8 @@ static void split_pte_mapped_thp(void)
>>>>
>>>>    	/* smap does not show THPs after mremap, use kpageflags instead */
>>>>    	thp_size = 0;
>>>> -	for (i = 0; i < pagesize * 4; i++)
>>>> -		if (i % pagesize == 0 &&
>>>> -		    is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>>>> +	for (i = 0; i < pagesize * 4; i += pagesize)
>>>> +		if (is_backed_by_folio(&pte_mapped[i], pmd_order, pagemap_fd, kpageflags_fd))
>>>>    			thp_size++;
>>>>
>>>>    	if (thp_size != 4)
>>>
>>> It might be better to add
>>>
>>> if (pte_mapped[i] != (char)i)
>>> 	ksft_exit_fail_msg("%ld byte corrupted\n", i);
>>>
>>> instead to make sure mremap() does not change pte_mapped[] values.
>>
>> We do have a corruption check later in that function, so I think we can just
>> keep it simple here.
>>
>> So this as is LGTM
>>
>> Acked-by: David Hildenbrand <david@redhat.com>
>>
>> As noted, we should just move from mremap() to mprotect() or sth like that
>> which has clearer semantics.
>>
> 
> If my understanding is correct, we should
> 
>     mmap 4 PMD_SIZE region with RW
>     madvise and fault in to allocate pmd-mapped thp
>     mprotect first page of each PMD to read-only to split to pte-mapped thp
>     check whether the page is backed by pmd-order folio
> 
> Is this the correct way?

Yeah, I would just mprotect(PROT_READ) the first page of each PMD. That 
will trigger a PTE-mapping of the THP reliably.

-- 
Cheers

David / dhildenb


