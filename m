Return-Path: <linux-kselftest+bounces-40831-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5CB45694
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 13:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925FF5A747B
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Sep 2025 11:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5098034AAF9;
	Fri,  5 Sep 2025 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAtz4rNY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E45A346A13
	for <linux-kselftest@vger.kernel.org>; Fri,  5 Sep 2025 11:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072323; cv=none; b=n8U7KOLLw4Xl4FNINYqkC8/4/3t2cikoVh3YTuEB+Vemy5EnjS0ILAVErlhB9OUNruEizES4RPp/zemI/tryuzFo0aB0zYjzKxIl8wPmtpuiZ/FfWkDgb8M49Nwn0Nl0fm4RTMkFzSV6L849USPdXlouJwM6ovyBzaL8534X5aU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072323; c=relaxed/simple;
	bh=gMTwdBYGR4qzcIDWfYqeVKqJ5Hz/aktnEvyMtqn6SAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckZyJl14oBP7Kj5axEmsfdG0g9Bhtxq+jGKihfgI/rNKHGTou9ZiguOKbY3ChxgjbZvvHChokC73LbKEM9FCUCr8MhRtbIQrcR3U0fztu0loNfoKIOLjvtfbNj8O7NBAteqSUZSb+VbaTHmvYJG0d9LUKp+kxhapFOl5WeFUrYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAtz4rNY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757072319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=luQGhz3W9bQvvWBMkQH/XO40AxL9T26r0ebxy/p3+ys=;
	b=SAtz4rNYr7w0xIU/eORxNcydcn09buyBgdrIjsws6k4FTEKWITdv/RG7E8PisbwcxKQk27
	VTA02f7eYOvqG7RR7RmsTkN8/7MvUpN5OOpWpbc8bwPhFjpteMggqxLXE42DYXsVyP3l/X
	ddDE10dEkaZiHq9pSW+k0TH0VBdA598=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-l2UOCVigNsiyt2E1Gju8Pg-1; Fri, 05 Sep 2025 07:38:38 -0400
X-MC-Unique: l2UOCVigNsiyt2E1Gju8Pg-1
X-Mimecast-MFC-AGG-ID: l2UOCVigNsiyt2E1Gju8Pg_1757072317
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3df07c967e9so1059985f8f.2
        for <linux-kselftest@vger.kernel.org>; Fri, 05 Sep 2025 04:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757072317; x=1757677117;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=luQGhz3W9bQvvWBMkQH/XO40AxL9T26r0ebxy/p3+ys=;
        b=S6+1TZAsF2RISRfW/MKupO6tX7QPCQt51TKJIyDUHjzZmyhJqDMX9vfXwuCXUT0HWp
         vV0WQb2PbL6QdVIe43Vcp7oK7JBhz+s/L0WL5TGeuogDj5nM/pvIH0/xu/7IeKSZcV/S
         dEEGLRctfM4aOjWw0zwkWeOnab5ONKXXmlzVlzc9RxJn20OF1n5wj4GmdQdOcl/s65u3
         EPZDJmnt0ypSM3jf9ZaekA/daUpBRMfjs06H+/0LabxvTAUDEr2VxyfNnfaSg1oTbIY1
         Nbrn5u/LthpD56GwYzqIwHwvJqceQ5N+i2tm6fnKq3UNinLtkF9cAj981w/GvabHoXM1
         9MHw==
X-Forwarded-Encrypted: i=1; AJvYcCUYK/Vj2r5VJq6ePub2d9WWHZZSJSPH+sSoVnLkLyIsRy5CgP4d/6LUpC0vlBkQKcGTWRv+loVoMnihRxTeIUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy46ZoxtgUhjrdqRAN1gVmCeOUFy1q8FqNXiuhI6hLirAL7XUKs
	dyD2YCIS2PuKFhewrKRo5ipWskOWrj5SWvLTA/GvQjjVjijkafwSNWvHkj2mBAHccSjdPMfkL1A
	yz0iIkEbr07IJgMNcjpPZWeoDCQ2X++FzIaekSIvBR/x/YVDF+Jg2qSlW5woks4tQ1fbq8Q==
X-Gm-Gg: ASbGnctwvYv5X+u+u3pWuPCyjY8TXbwXH86vMQMwvyogsHMUGj7uu1l9wkckxVMkMBo
	vha+gbnv37TmxHoKg6bU47W9CFlu6VHc7tSgKDTlczi+GWCkgMdJIE/G3X4/TIcY5LLg4AjbMTt
	KC4MuvMG0zJ9vTzqDr7/gVLL/ce5SKckG3w0Ag754z74XXPrEpMhuqhxz0/NvtF5rM9OJSRPYH5
	K812NAkNmGRXv0dgUGM/Y1VLt2cX5AhhTyGUAnSkyFwQWabowVep/Hmr9hpKn4TrpuV96aHIoiA
	vj5oqqWqEya5rCNmUVaDy1DtoZ/i3TfQ8C48JpTuMizEvo95D558hwqgDwgRaNRdLOAkvKVL/Cl
	OfVlHh3/CI72zTfjuyQA3TOa9o5yMZukqjqlpTojqgz3E773bnKxb66Wf
X-Received: by 2002:a05:6000:1789:b0:3e0:43f0:b7b6 with SMTP id ffacd0b85a97d-3e043f0be07mr5028692f8f.52.1757072316756;
        Fri, 05 Sep 2025 04:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFo8MNleTLRHLacoeKcQ93i9Gk8ZDv5dPOPJ5nfQMIibIGfmFimYQBfp9bCIqgP6uhYUdcj5w==
X-Received: by 2002:a05:6000:1789:b0:3e0:43f0:b7b6 with SMTP id ffacd0b85a97d-3e043f0be07mr5028644f8f.52.1757072316181;
        Fri, 05 Sep 2025 04:38:36 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4d:e00:298:59cc:2514:52? (p200300d82f4d0e00029859cc25140052.dip0.t-ipconnect.de. [2003:d8:2f4d:e00:298:59cc:2514:52])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda2021dfsm19061165e9.24.2025.09.05.04.38.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Sep 2025 04:38:34 -0700 (PDT)
Message-ID: <9fe9f8c7-f59d-4a4b-9668-d3cd2c5a5fc9@redhat.com>
Date: Fri, 5 Sep 2025 13:38:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 19/37] mm/gup: remove record_subpages()
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
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
 linux-scsi@vger.kernel.org, Marco Elver <elver@google.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>, Michal Hocko <mhocko@suse.com>,
 Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 netdev@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
 Peter Xu <peterx@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 Suren Baghdasaryan <surenb@google.com>, Tejun Heo <tj@kernel.org>,
 virtualization@lists.linux.dev, Vlastimil Babka <vbabka@suse.cz>,
 wireguard@lists.zx2c4.com, x86@kernel.org, Zi Yan <ziy@nvidia.com>
References: <20250901150359.867252-1-david@redhat.com>
 <20250901150359.867252-20-david@redhat.com>
 <5090355d-546a-4d06-99e1-064354d156b5@redhat.com>
 <b7544f6d-beac-46af-aa43-27da6d96467e@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <b7544f6d-beac-46af-aa43-27da6d96467e@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.09.25 13:34, Lorenzo Stoakes wrote:
> On Fri, Sep 05, 2025 at 08:41:23AM +0200, David Hildenbrand wrote:
>> On 01.09.25 17:03, David Hildenbrand wrote:
>>> We can just cleanup the code by calculating the #refs earlier,
>>> so we can just inline what remains of record_subpages().
>>>
>>> Calculate the number of references/pages ahead of times, and record them
>>> only once all our tests passed.
>>>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> So strange I thought I looked at this...!
> 
>>> ---
>>>    mm/gup.c | 25 ++++++++-----------------
>>>    1 file changed, 8 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/mm/gup.c b/mm/gup.c
>>> index c10cd969c1a3b..f0f4d1a68e094 100644
>>> --- a/mm/gup.c
>>> +++ b/mm/gup.c
>>> @@ -484,19 +484,6 @@ static inline void mm_set_has_pinned_flag(struct mm_struct *mm)
>>>    #ifdef CONFIG_MMU
>>>    #ifdef CONFIG_HAVE_GUP_FAST
>>> -static int record_subpages(struct page *page, unsigned long sz,
>>> -			   unsigned long addr, unsigned long end,
>>> -			   struct page **pages)
>>> -{
>>> -	int nr;
>>> -
>>> -	page += (addr & (sz - 1)) >> PAGE_SHIFT;
>>> -	for (nr = 0; addr != end; nr++, addr += PAGE_SIZE)
>>> -		pages[nr] = page++;
>>> -
>>> -	return nr;
>>> -}
>>> -
>>>    /**
>>>     * try_grab_folio_fast() - Attempt to get or pin a folio in fast path.
>>>     * @page:  pointer to page to be grabbed
>>> @@ -2967,8 +2954,8 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>>>    	if (pmd_special(orig))
>>>    		return 0;
>>> -	page = pmd_page(orig);
>>> -	refs = record_subpages(page, PMD_SIZE, addr, end, pages + *nr);
>>> +	refs = (end - addr) >> PAGE_SHIFT;
>>> +	page = pmd_page(orig) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
>>>    	folio = try_grab_folio_fast(page, refs, flags);
>>>    	if (!folio)
>>> @@ -2989,6 +2976,8 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>>>    	}
>>>    	*nr += refs;
>>> +	for (; refs; refs--)
>>> +		*(pages++) = page++;
>>>    	folio_set_referenced(folio);
>>>    	return 1;
>>>    }
>>> @@ -3007,8 +2996,8 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
>>>    	if (pud_special(orig))
>>>    		return 0;
>>> -	page = pud_page(orig);
>>> -	refs = record_subpages(page, PUD_SIZE, addr, end, pages + *nr);
>>> +	refs = (end - addr) >> PAGE_SHIFT;
>>> +	page = pud_page(orig) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
>>>    	folio = try_grab_folio_fast(page, refs, flags);
>>>    	if (!folio)
>>> @@ -3030,6 +3019,8 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
>>>    	}
>>>    	*nr += refs;
>>> +	for (; refs; refs--)
>>> +		*(pages++) = page++;
>>>    	folio_set_referenced(folio);
>>>    	return 1;
>>>    }
>>
>> Okay, this code is nasty. We should rework this code to just return the nr and receive a the proper
>> pages pointer, getting rid of the "*nr" parameter.
>>
>> For the time being, the following should do the trick:
>>
>> commit bfd07c995814354f6b66c5b6a72e96a7aa9fb73b (HEAD -> nth_page)
>> Author: David Hildenbrand <david@redhat.com>
>> Date:   Fri Sep 5 08:38:43 2025 +0200
>>
>>      fixup: mm/gup: remove record_subpages()
>>      pages is not adjusted by the caller, but idnexed by existing *nr.
>>      Signed-off-by: David Hildenbrand <david@redhat.com>
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index 010fe56f6e132..22420f2069ee1 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2981,6 +2981,7 @@ static int gup_fast_pmd_leaf(pmd_t orig, pmd_t *pmdp, unsigned long addr,
>>                  return 0;
>>          }
>> +       pages += *nr;
>>          *nr += refs;
>>          for (; refs; refs--)
>>                  *(pages++) = page++;
>> @@ -3024,6 +3025,7 @@ static int gup_fast_pud_leaf(pud_t orig, pud_t *pudp, unsigned long addr,
>>                  return 0;
>>          }
>> +       pages += *nr;
>>          *nr += refs;
>>          for (; refs; refs--)
>>                  *(pages++) = page++;
> 
> This looks correct.
> 
> But.
> 
> This is VERY nasty. Before we'd call record_subpages() with pages + *nr, where
> it was clear we were offsetting by this, now we're making things imo way more
> confusing.
> 
> This makes me less in love with this approach to be honest.
> 
> But perhaps it's the least worst thing for now until we can do a bigger
> refactor...
> 
> So since this seems correct to me, and for the sake of moving things forward
> (was this one patch dropped from mm-new or does mm-new just have an old version?
> Confused):
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> 
> For this patch obviously with the fix applied.
> 
> But can we PLEASE revisit this :)

Yeah, I already asked someone internally if he would have time to do 
some refactorings in mm/gup.c.

If that won't work out I shall do it at some point (and the same time 
reworking follow_page_mask() to just consume the array as well like gup 
does)

-- 
Cheers

David / dhildenb


