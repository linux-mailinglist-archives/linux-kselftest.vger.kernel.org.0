Return-Path: <linux-kselftest+bounces-27059-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5F6A3D607
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 11:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A35427ACB24
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Feb 2025 10:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAD21F0E3A;
	Thu, 20 Feb 2025 10:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZJicPt1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB52C286295
	for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 10:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740045791; cv=none; b=pQIfaygcLYeHmEzdntMPW5pZLr5em8GJ0MGhW9+b9LN9EPiRH/iHBAcKjEwvB/0+DfFrN3OKvJ5itwCPD9UaHRFuZr9xy88jAGqfjiO2rCejGL0NYLi3OXw5J0c3CT8ArRSreRxWF44GqSVBaqv9l/wC6llkQC3MZbSVJvw+VPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740045791; c=relaxed/simple;
	bh=SBBn2UYvblwcq+tBRo29UULpxF9ovy4PTYY97hhd8Yc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sHogmBt21Kr5mF+XF8NM34MR76nFyEV2mXrSyf5dgFinEafOt4QMbT1fFd/KeEOFCvwi5ItL4KGMMBW/HB0Pm999/bARsRfP2xcyQ4FFTs06THd8FL3mlhqkLhdRJqEsXqaYlZB+1CKkKRn2bPjklBXannljnrtgRqjoHJhNhdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YZJicPt1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740045788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9nUyWvqcklnp2OI5prl7ETjXTJjb3fHnOT/VSvj7+A=;
	b=YZJicPt10CERJ+Iv/B+zumzMWde3Os5FW2+sE7KFneNu4c7K+sCgtilM4jvD5+dnRt9sz/
	fw2rIMSymVLkwgVu4DJUAiQxO43mifNJjNAkj4ayw47cvFpHzh4ozTWUp2zLHMHNVSxadw
	wr45708ztEjtCU87ufdJVIjT7cmsRhM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-IhD7thHDO2yg-IIKDTuS6w-1; Thu, 20 Feb 2025 05:03:07 -0500
X-MC-Unique: IhD7thHDO2yg-IIKDTuS6w-1
X-Mimecast-MFC-AGG-ID: IhD7thHDO2yg-IIKDTuS6w_1740045786
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f628ff78eso322604f8f.1
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Feb 2025 02:03:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740045786; x=1740650586;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d9nUyWvqcklnp2OI5prl7ETjXTJjb3fHnOT/VSvj7+A=;
        b=YAZM1qIIwJs0SaneAdik9mDDBuKywO94tPfanIcpwtXhFa7ZB+ZnxgGdSk7Rn/YoB3
         yvW0S+TBvsdQz424hGT7FK44JNDmSLDm/3rEt/cu9PiitDPBUz3+4hptXhfg3uAJoEzc
         uDKt6oEFUrXBQ5wUf5ej5BofvQm2di3aA0KCjq38jxmC9F9N+stmOWTnfwiPKTvNgglb
         0/4zqusvz0mqXxkb5z/vBvxQAxsjhMnWaD46IJXWDH0tgJikozMN/+yqAQnvf5f1MRt4
         ksWh8D4vpd4c+AY9/BBL5pKupz/2qm7gTAMSIZEKHjRhedXdXg6nTZ4YwIm4uAg51kn7
         a1Hw==
X-Forwarded-Encrypted: i=1; AJvYcCVwm0lSnoPUVf//RNdjwQ6V1YHrWlePeh992MwLr6mBJSjSV8J/let1nV+toViQpTzo0TuzbzNnCyGDZlgnmzg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6rEMwD896+fv5wEYIGI/IL7ZnLSKr9k3UMRV1mOhYQHQh5v0
	loXgEabZyPeqtAMB+9rfqoHdOrhgJBP/pEjXthclhRxBwxfN7P7ebqjl8qtPAsCRO56LcapLFRC
	NOOv4p5BTws1ITcMBugshMf1P2LWH7G1WUJnhQ1Mm/chMUA2RQAxln4/10Vw7JyBAsg==
X-Gm-Gg: ASbGncv/cLjmAtdoRh+4x/h9shKpa8H6TKXpTeAR1obRxGcXZ5mLVDQPXAy6xoopDKo
	3bPzD8WnleXwhkYPhhzyy6Ax2EK/zKB/FoPbWe/rIzTwReOWOkX9eYcdOCw7fcMhpsJlK8hF0jl
	yLOz1YBaQ+0O8xWXkwfRQCJ+BaijpOhgG2wPD4KHOwsvnWNrZ0U238QhqrxhkKnk9NzHsudpn0c
	0scwNxJtJqEMiil2my7ImV90hhqb9tVE7IvBwU8YnoKY9ucbTVvKx5Akpht/nC2PGHIJRoyt+qR
	aXMEeK7ZDzX11f/EbBI1gvTr17syx6jnXej27g1ZR3qB5AQ+MPgYtl/HI/lYTDoIYrGeYxuVTbR
	WqLusEW9qL0CMeuBO3qlrxoTp0UnHVw==
X-Received: by 2002:a05:6000:4608:b0:38d:dfdc:c874 with SMTP id ffacd0b85a97d-38f614b680cmr1912745f8f.10.1740045785931;
        Thu, 20 Feb 2025 02:03:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgdMJuANrEX/DzcqMwK/DuM0WtW+B2wskdlKuHER6vA01Xbh8Jx5M/rko52SdDDMVuRR6sqA==
X-Received: by 2002:a05:6000:4608:b0:38d:dfdc:c874 with SMTP id ffacd0b85a97d-38f614b680cmr1912713f8f.10.1740045785488;
        Thu, 20 Feb 2025 02:03:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c706:2000:e44c:bc46:d8d3:be5? (p200300cbc7062000e44cbc46d8d30be5.dip0.t-ipconnect.de. [2003:cb:c706:2000:e44c:bc46:d8d3:be5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b412esm19828134f8f.1.2025.02.20.02.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 02:03:04 -0800 (PST)
Message-ID: <4f5a9c19-9bdd-47eb-bb14-205e3dcced90@redhat.com>
Date: Thu, 20 Feb 2025 11:03:02 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] mm: permit guard regions for file-backed/shmem
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kalesh Singh <kaleshsingh@google.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Juan Yescas <jyescas@google.com>
References: <45297010-a0a4-4a42-84e8-6f4764eab3b3@lucifer.local>
 <41af4ffb-0383-4d00-9639-0bf16e1f5f37@redhat.com>
 <a2e12142-3eb2-48c9-b0d9-35a86cb56eec@lucifer.local>
 <CAC_TJvf6fOACObzR0ANFFrD+ecrP8MbXEZ_ZdzRu0Lg4RunS9g@mail.gmail.com>
 <e07dfd31-197c-49d0-92bd-12aad02daa7e@lucifer.local>
 <CAC_TJvfBvZZc=xyB0jez2VCDit-rettfQf7H4xhQbN7bYxKw-A@mail.gmail.com>
 <6e356431-5ac9-4363-b876-78a69ae7622a@lucifer.local>
 <4aa97b5c-3ddc-442b-8ec9-cc43ebe9e599@redhat.com>
 <b0a95f2c-093c-45fd-b4a2-2ba5cbc37e2c@lucifer.local>
 <387f3516-99f2-41e9-967e-4b051a8d21b8@redhat.com>
 <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local>
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
In-Reply-To: <72e044ba-64af-49c0-8b87-ead508654fb7@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

>> Your conclusion is 'did not participate with upstream'; I don't agree with
>> that. But maybe you and Kalesh have a history on that that let's you react
>> on his questions IMHO more emotionally than it should have been.
> 
> This is wholly unfair, I have been very reasonable in response to this
> thread. I have offered to find solutions, I have tried to understand the
> problem in spite of having gone to great lengths to try to discuss the
> limitations of the proposed approach in every venue I possibly could.
> 
> I go out of my way to deal professionally and objectively with what is
> presented. Nothing here is emotional. So I'd ask that you please abstain
> from making commentary like this which has no basis.

I appreciate everything you write below. But this request is just 
impossible. I will keep raising my opinion and misunderstandings will 
happen.

Note that the whole "Honestly David you and the naming. .." thing could 
have been written as "I don't think it's a naming problem."

>>
>>
>>>
>>>>
>>>> [...]
>>>>
>>>>>
>>>>> As I said to you earlier, the _best_ we could do in smaps would be to add a
>>>>> flag like 'Grd' or something to indicate some part of the VMA is
>>>>> guarded. But I won't do that unless somebody has an -actual use case- for
>>>>> it.
>>>>
>>>> Right, and that would limit where you have to manually scan. Something
>>>> similar is being done with uffd-wp markers IIRC.
>>>
>>> Yeah that's a good point, but honestly if you're reading smaps that reads
>>> the page tables, then reading /proc/$pid/pagemaps and reading page tables
>>> TWICE that seems inefficient vs. just reading /proc/$pid/maps, then reading
>>> /proc/$pid/pagemaps and reading page tables once.
>>
>> Right; I recently wished that we would have an interface to obtain more VMA
>> flags without having to go through smaps
> 
> Well maybe that lends itself to the idea of adding a whole new interface in
> general...

An extended "maps" interface might be reasonable, that allows for 
exposing more things without walking the page tables. (e.g., flags)

Maybe one could have an indicator that says "ever had guard regions in 
this mapping" without actually walking the page tables.

-- 
Cheers,

David / dhildenb


