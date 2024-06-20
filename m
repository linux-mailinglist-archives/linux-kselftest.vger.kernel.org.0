Return-Path: <linux-kselftest+bounces-12363-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A11B911398
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 22:48:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05A931F2177C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jun 2024 20:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8020A7350E;
	Thu, 20 Jun 2024 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WYn0I2HR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1E74BE2
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 20:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718916486; cv=none; b=cHbYR8YUrM/tOj4XYvkwxZMPBmbbRz7ADEOHOYqLhq3VsmQqXet7RXWOGR0Q8f9nqRMx1v5GWykw03jV7Of05ioz2vYqs34010+4AAwIZBKjt0cEiU5ABthcPyLssLOo7juS5TCBQ3i2wEn69JuhMT5wYfXdrW7pf1RCg5CcP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718916486; c=relaxed/simple;
	bh=sEH3T6yutnlLK2D0OreUCPnRYL26DdDE6U/Zb8vYt2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mAKKMkbuYBrmX+1Lc6niHpamxxmPrWBv0dU9J8GR5x6gyNXMzEhahHlForTj+n4UhZD1agrwv1Cnsv00OSqz1d9U1JX65qEWIkpkXk1SxWxXEY7GdIXZn6kBDKejuCdKDd3lA1oecis5KB7BXrJZz/qmaPi1D+ifDX/VSSvAbFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WYn0I2HR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718916483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=725sMhwzSeqjmupxLu0hwJ7+pZtvicrTuC9XsgQTBK8=;
	b=WYn0I2HR0/fxGHx1hZbgY7HnHIi97B1WGCO9YCgp5VCAOoraQcY8WGJVyCfVtgAcYkJF8h
	JfgvQTQ8akHtQyMPbDu5SUMkKcOtbSRwLNxT5x1Fewxoy0RzUofK6bz+nB26qwRBhIyLdv
	p9ZvdF8ojLJuECRgaTaRyD+4ytjZSRw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-pk1Yw7XyNCGa4dnMqjIMNQ-1; Thu, 20 Jun 2024 16:48:02 -0400
X-MC-Unique: pk1Yw7XyNCGa4dnMqjIMNQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-364b75a8194so634893f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jun 2024 13:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718916481; x=1719521281;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=725sMhwzSeqjmupxLu0hwJ7+pZtvicrTuC9XsgQTBK8=;
        b=kkFlI1hl+ziZdQ47+Tv1dsPmxdw3/woGRALRnj7g3f/0Lzn5IYoIe0rIkuGFkw/1K0
         0+YLB+gkH4wEq3IkPLTubOeyz9Y1jkMe7QeTIUSOmu+VlIprl7myzrs31yT0A37z0eIf
         UbJEfRXG4J/HdSMHFwcGhTOXQMZD507L5PQ0tWnBLV8mS99XNwlQERdd9Q7fCxXUy0NG
         3MhAz4Vte4D3Ktc2zzmfJlwDxq6wNH7tf7x138F3d90HF7mQms4WulLoZefS4kZzfgdx
         2iF+P8vr7+/IXq/bkWdyi3O2phRQuQeom6ggbP4uQ8LWrS+moLmCa+dMFNB6njf9RLAi
         yhjw==
X-Forwarded-Encrypted: i=1; AJvYcCWzh7l/bXUufdAE+R2xowQZn+YLIea0UNqU9JfoGTGS6HD5kabBBR6m4H5bJGqWROUMNjUQNlxpsRoWbDN6sPgwhCx9vo8gIhAe50nZ44nf
X-Gm-Message-State: AOJu0Yyr8E95Uc5XdYeSiOnkwquyYyJKOEBC0eUjWCrwmLNmUGQ6MzMJ
	FgRA+o/izgcqY8XZpUNBlg8v8SeYkIYdK7GczTULd8y+3SzJQN3LASA0Ox4Ss1Ty6g1syjJNU1W
	uhFxFwOY0oB08WNCJisgFT8J/UiebZX2vkVWqP/fOTnMwHbhvxby+UR8x0k6OJgpZPQ==
X-Received: by 2002:a5d:5509:0:b0:362:e357:5ceb with SMTP id ffacd0b85a97d-363175b8d26mr4451517f8f.18.1718916480942;
        Thu, 20 Jun 2024 13:48:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrzrquPG/94lKhzK3aDSpYVSMtKUQthY8gwE3WdilMXHD1TiygK87vbYj5UA8qzbVrakNlew==
X-Received: by 2002:a5d:5509:0:b0:362:e357:5ceb with SMTP id ffacd0b85a97d-363175b8d26mr4451498f8f.18.1718916480436;
        Thu, 20 Jun 2024 13:48:00 -0700 (PDT)
Received: from ?IPV6:2003:cb:c719:5b00:61af:900f:3aef:3af3? (p200300cbc7195b0061af900f3aef3af3.dip0.t-ipconnect.de. [2003:cb:c719:5b00:61af:900f:3aef:3af3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-362cd0d79fdsm6839188f8f.77.2024.06.20.13.47.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jun 2024 13:47:59 -0700 (PDT)
Message-ID: <53d1e7c5-3e77-467b-be33-a618c3bb6cb3@redhat.com>
Date: Thu, 20 Jun 2024 22:47:58 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/5] mm/gup: Introduce exclusive GUP pinning
To: Sean Christopherson <seanjc@google.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Fuad Tabba <tabba@google.com>,
 Christoph Hellwig <hch@infradead.org>, John Hubbard <jhubbard@nvidia.com>,
 Elliot Berman <quic_eberman@quicinc.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, maz@kernel.org, kvm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pbonzini@redhat.com
References: <CA+EHjTxWWEHfjZ9LJqZy+VCk43qd3SMKiPF7uvAwmDdPeVhrvQ@mail.gmail.com>
 <20240619115135.GE2494510@nvidia.com> <ZnOsAEV3GycCcqSX@infradead.org>
 <CA+EHjTxaCxibvGOMPk9Oj5TfQV3J3ZLwXk83oVHuwf8H0Q47sA@mail.gmail.com>
 <20240620135540.GG2494510@nvidia.com>
 <6d7b180a-9f80-43a4-a4cc-fd79a45d7571@redhat.com>
 <20240620142956.GI2494510@nvidia.com>
 <385a5692-ffc8-455e-b371-0449b828b637@redhat.com>
 <20240620163626.GK2494510@nvidia.com>
 <66a285fc-e54e-4247-8801-e7e17ad795a6@redhat.com>
 <ZnSRZcap1dc2_WBV@google.com>
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
In-Reply-To: <ZnSRZcap1dc2_WBV@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.24 22:30, Sean Christopherson wrote:
> On Thu, Jun 20, 2024, David Hildenbrand wrote:
>> On 20.06.24 18:36, Jason Gunthorpe wrote:
>>> On Thu, Jun 20, 2024 at 04:45:08PM +0200, David Hildenbrand wrote:
>>>
>>>> If we could disallow pinning any shared pages, that would make life a lot
>>>> easier, but I think there were reasons for why we might require it. To
>>>> convert shared->private, simply unmap that folio (only the shared parts
>>>> could possibly be mapped) from all user page tables.
>>>
>>> IMHO it should be reasonable to make it work like ZONE_MOVABLE and
>>> FOLL_LONGTERM. Making a shared page private is really no different
>>> from moving it.
>>>
>>> And if you have built a VMM that uses VMA mapped shared pages and
>>> short-term pinning then you should really also ensure that the VM is
>>> aware when the pins go away. For instance if you are doing some virtio
>>> thing with O_DIRECT pinning then the guest will know the pins are gone
>>> when it observes virtio completions.
>>>
>>> In this way making private is just like moving, we unmap the page and
>>> then drive the refcount to zero, then move it.
>> Yes, but here is the catch: what if a single shared subpage of a large folio
>> is (validly) longterm pinned and you want to convert another shared subpage
>> to private?
>>
>> Sure, we can unmap the whole large folio (including all shared parts) before
>> the conversion, just like we would do for migration. But we cannot detect
>> that nobody pinned that subpage that we want to convert to private.
>>
>> Core-mm is not, and will not, track pins per subpage.
>>
>> So I only see two options:
>>
>> a) Disallow long-term pinning. That means, we can, with a bit of wait,
>>     always convert subpages shared->private after unmapping them and
>>     waiting for the short-term pin to go away. Not too bad, and we
>>     already have other mechanisms disallow long-term pinnings (especially
>>     writable fs ones!).
> 
> I don't think disallowing _just_ long-term GUP will suffice, if we go the "disallow
> GUP" route than I think it needs to disallow GUP, period.  Like the whole "GUP
> writes to file-back memory" issue[*], which I think you're alluding to, short-term
> GUP is also problematic.  But unlike file-backed memory, for TDX and SNP (and I
> think pKVM), a single rogue access has a high probability of being fatal to the
> entire system.

Disallowing short-term should work, in theory, because the 
writes-to-fileback has different issues (the PIN is not the problem but 
the dirtying).

It's more related us not allowing long-term pins for FSDAX pages, 
because the lifetime of these pages is determined by the FS.

What we would do is

1) Unmap the large folio completely and make any refaults block.
-> No new pins can pop up

2) If the folio is pinned, busy-wait until all the short-term pins are
    gone.

3) Safely convert the relevant subpage from shared -> private

Not saying it's the best approach, but it should be doable.

> 
> I.e. except for blatant bugs, e.g. use-after-free, we need to be able to guarantee
> with 100% accuracy that there are no outstanding mappings when converting a page
> from shared=>private.  Crossing our fingers and hoping that short-term GUP will
> have gone away isn't enough.

We do have the mapcount and the refcount that will be completely 
reliable for our cases.

folio_mapcount()==0 not mapped

folio_ref_count()==1 we hold the single folio reference. (-> no mapping, 
no GUP, no unexpected references)

(folio_maybe_dma_pinned() could be used as well, but things like 
vmsplice() and some O_DIRECT might still take references. 
folio_ref_count() is more reliable in that regard)

> 
> [*] https://lore.kernel.org/all/cover.1683235180.git.lstoakes@gmail.com
> 
>> b) Expose the large folio as multiple 4k folios to the core-mm.
>>
>>
>> b) would look as follows: we allocate a gigantic page from the (hugetlb)
>> reserve into guest_memfd. Then, we break it down into individual 4k folios
>> by splitting/demoting the folio. We make sure that all 4k folios are
>> unmovable (raised refcount). We keep tracking internally that these 4k
>> folios comprise a single large gigantic page.
>>
>> Core-mm can track for us now without any modifications per (previously
>> subpage,) now small folios GUP pins and page table mappings without
>> modifications.
>>
>> Once we unmap the gigantic page from guest_memfd, we recronstruct the
>> gigantic page and hand it back to the reserve (only possible once all pins
>> are gone).
>>
>> We can still map the whole thing into the KVM guest+iommu using a single
>> large unit, because guest_memfd knows the origin/relationship of these
>> pages. But we would only map individual pages into user page tables (unless
>> we use large VM_PFNMAP mappings, but then also pinning would not work, so
>> that's likely also not what we want).
> 
> Not being to map guest_memfd into userspace with 1GiB mappings should be ok, at
> least for CoCo VMs.  If the guest shares an entire 1GiB chunk, e.g. for DMA or
> whatever, then userspace can simply punch a hole in guest_memfd and allocate 1GiB
> of memory from regular memory.  Even losing 2MiB mappings should be ok.
> 
> For non-CoCo VMs, I expect we'll want to be much more permissive, but I think
> they'll be a complete non-issue because there is no shared vs. private to worry
> about.  We can simply allow any and all userspace mappings for guest_memfd that is
> attached to a "regular" VM, because a misbehaving userspace only loses whatever
> hardening (or other benefits) was being provided by using guest_memfd.  I.e. the
> kernel and system at-large isn't at risk.
> 
>> The downside is that we won't benefit from vmemmap optimizations for large
>> folios from hugetlb, and have more tracking overhead when mapping individual
>> pages into user page tables.
> 
> Hmm, I suspect losing the vmemmap optimizations would be acceptable, especially
> if we could defer the shattering until the guest actually tried to partially
> convert a 1GiB/2MiB region, and restore the optimizations when the memory is
> converted back.

We can only shatter/collapse if there are no unexpected folio 
references. So GUP would have to be handles as well ... so that is 
certainly problematic.

-- 
Cheers,

David / dhildenb


