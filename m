Return-Path: <linux-kselftest+bounces-27423-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D243FA43AD8
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 11:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5855D188CE24
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 10:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6172676C3;
	Tue, 25 Feb 2025 10:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eQfpxtIF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEBA26739B
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740477717; cv=none; b=SoR7cWzCL5Tj59JDTDf3KPNZhA7/ncZjOmOI3uK3N/WUaZtwvXQePD+kA/qleugNZOCePEL22VQtsHImb2u5l4QaaCS5QzK1I3NBMr9uj12ZvhjTtKKzuuRPIuZ4J4oEv4CClZCieyzqvLpFy0IvlR7iZQ1lMAih76vz14P/52M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740477717; c=relaxed/simple;
	bh=WbTYhd6foXSyOnfHVbKms0+sMhqGA+RO5PTab0PSDIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtGnEhNAly85Wn5WXj2xQmBwLckKv4EZqphwFzpj/zYAZnSLVx2T7vOv1n38LQfGlpXVq7he4dabrAHIo3CWcQCrReiBRFvFNY0FdyKZYhOylaFgO0jHXaBZy3UrPyQWVv3ZUc01DkEBoj2GihBPzV7bVLpspyAH6xBPsy54jYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eQfpxtIF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740477714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/+h+fPj09zWYTw7qPd+IesJvhzV1Nb7N0plz81q+GsY=;
	b=eQfpxtIFUDIYiVdseB0fpJh6noj3yRMtLm7Fq/hiSiBWxqPtE7xNPpwsHJeYbUN2AnrB5n
	F2C5hsWqEucaUNMfHXGWYbYo3InHhrh9VKSLixBnxeMvcCAvUpdcYdC55fds/B7nUn8Qr4
	6bcQkmaYhZRnH6TqnU0pgcyYhSd62Yw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-2T5UgiAjO1iHcXO7Ncwugw-1; Tue, 25 Feb 2025 05:01:51 -0500
X-MC-Unique: 2T5UgiAjO1iHcXO7Ncwugw-1
X-Mimecast-MFC-AGG-ID: 2T5UgiAjO1iHcXO7Ncwugw_1740477710
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-38f62a0ec3fso3861039f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 02:01:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740477710; x=1741082510;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/+h+fPj09zWYTw7qPd+IesJvhzV1Nb7N0plz81q+GsY=;
        b=OiuwhPsQ/ZMaoPcLo+ZO3CX4HnclBJg0GbA2DnlhJzDWwZ1f/0bPNfAVvFy6vAdNVv
         b/p8vKujaqmwfCgXjMMoNqCk69vtcY2GtRYulwUY01exzPPw07iojQGQd1qVGYZUdnbr
         FeZ9Y6Gmrpug0cDaPrrjpcq6Qfvao+36gsaIffdFJBiTCQ4Fv6daySAlrWVw+scHWoXE
         VFDwB2Cvq4ghPuf2wT+uJs3v+JTBwi8ssFwHt5Fewraa7QtJ057UYay5Nbazc2pHyXJ5
         r5pXOby99AG+mV9k2eshAWwhzOyOIcd+C0/7B4A51Ne+VsHZH8slE+JNU69b7hRJoHmI
         n/3A==
X-Forwarded-Encrypted: i=1; AJvYcCU/iTc6+c4fFKXUu1W6991AfDpaNEBS43MqkwI90KQbXgZlxLkV9u1ZqS0Wr+xUa9lvHciECatFPuJgxb0xw1E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlyr65kUzTmCk5WrFBRuynqbYNIUFRcIZ49vvvNklB9AzKax0h
	p1Tan5qwnTWBjAdqWt956nDD2GWz91ph0NWn1UIn/Dp0bS0+AuMDY63aA32mV/08K1pRB06SYFI
	8LGbTBor+HBRgutOD0OMU4gW6jiEq8rP9vKSNjskhJSonI/X9T/CYdliw+jo3JS21wQ==
X-Gm-Gg: ASbGncsZmsLrw935Ej7yt4P8tixM4hZO40BHzFfZJFO91OBSXhIIj6+LuR1quDJPw06
	sm/24dA3b2mwUhgu/I4iYYD7QA19KjN9vHjQyPt0B28eSOKOtYt984P9MpOX5Qn1tCE+4CUn0XE
	5SYt+pZM5NvVDXkakrdju/CqOeTjV4DNaUsVbnpMnV8PmfDlNBiKcucbsUjxGAP/qe9nFy62tsA
	6+yc1o3XH6XCgTvIhuh/q4MfOKi2ji0OCRRY8z3wVj9nKxjPygo4r5vYZYlDQcyGH1WRoOu+yQC
	fRrzuUyf26vMXUeF6U06SCIKDyVbUpcEQO/MGSE/VCGp
X-Received: by 2002:a5d:5985:0:b0:38d:d3e2:db32 with SMTP id ffacd0b85a97d-38f70783f03mr9711764f8f.7.1740477709849;
        Tue, 25 Feb 2025 02:01:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHCN1SYAAIz/pF5xUoJzar7+lMabbaLjjeF4ndao2dvfBcddNuVf6uQYJyuKutyCNt+md6VWA==
X-Received: by 2002:a5d:5985:0:b0:38d:d3e2:db32 with SMTP id ffacd0b85a97d-38f70783f03mr9711727f8f.7.1740477709379;
        Tue, 25 Feb 2025 02:01:49 -0800 (PST)
Received: from [192.168.3.141] (p5b0c6373.dip0.t-ipconnect.de. [91.12.99.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866dc4sm1753169f8f.11.2025.02.25.02.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 02:01:48 -0800 (PST)
Message-ID: <0449ff75-0a6b-4c1e-bf12-ff052aad5287@redhat.com>
Date: Tue, 25 Feb 2025 11:01:47 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] mm: KUnit tests for the page allocator
To: Brendan Jackman <jackmanb@google.com>,
 Brendan Higgins <brendan.higgins@linux.dev>, David Gow
 <davidgow@google.com>, Rae Moar <rmoar@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Oscar Salvador <osalvador@suse.de>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@kernel.org>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Yosry Ahmed <yosry.ahmed@linux.dev>
References: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
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
In-Reply-To: <20250224-page-alloc-kunit-v1-0-d337bb440889@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 24.02.25 15:47, Brendan Jackman wrote:
> The page allocator does a lot of stuff that is not visible to the user
> in any deterministic way. But this stuff is still important and it would
> be nice to test that behaviour.
> 
> KUnit is a tool for unit-testing kernel-internal APIs. This is an
> attempt to adopt it the page allocator.
> 
> I have been hacking on this as a way to try and test the code I'm
> writing for my ASI page_alloc integration proposal [0]. It's been
> extremely useful to be able to "just call it and see what it does". So I
> wanna gather some feedback on whether this basic idea is of interest
> before I invest too much more time in it.
> 
> You can run these tests like this:
> 
> tools/testing/kunit/kunit.py run \
> 	--arch=x86_64 --kernel_args="movablecore=2G" \
> 	--qemu_args="-m 4G" --kunitconfig mm/.kunitconfig
> 
> Unit-testing code that has mutable global variables can be a pain.
> Unit-testing code with mutable global variables _that can change
> concurrently with the tests_ is basically impossible. So, we need some
> way to isolate an "instance" of the allocator that doesn't refer to any
> such concurrently-mutated state.
> 
> Luckily, the allocator only has one really important global variable:
> node_data. So, the approach here is to carve out a subset of that
> variable which is as isolated as possible from the rest of rthe system,
> which can be used for deterministic testing. This is achieved by crating
> a fake "isolated" node at boot, and plugging in memory at test init
> time.
> 
> This is an RFC and not a PATCH because:
> 
> 1. I have not taken much care to ensure the isolation is complete.
>     There are probably sources of flakiness and nondeterminism in here.
> 
> 2. I suspect the the basic idea might be over-complicated: do we really
>     need memory hotplug here? Do we even need the instance of the
>     allocator we're testing to actual memory behind the pages it's
>     allocating, or could we just hallucinate a new region of vmemmap
>     without any of that awkwardness?
> 
>     One significant downside of relying on memory hotplug is that the
>     test won't run if we can't hotplug anything out. That means you have
>     to fiddle with the platform to even run the tests - see the
>     --kernel_args and --qemu_args I had to add to my kunit.py command
>     above.
> 
>     So yeah, other suggestions welcome.
> 
>     2b. I'm not very confident I'm using the hotplug API properly.

Me neither ;)

Dynamically adding memory to that "fake" node is certainly interesting, 
but which guarantees do we have that some other features (page 
migration, memory offlining, page reporting ...) don't interact in weird 
ways with this "fake" node? Adding special-casing all over the place for 
that feels wrong. I assume this is point 1. you note above.

So I don't quite love the idea on first sight ... but I haven't grasped 
all details of the full picture yet I'm afraid.

-- 
Cheers,

David / dhildenb


