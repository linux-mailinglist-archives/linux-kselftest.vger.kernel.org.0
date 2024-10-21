Return-Path: <linux-kselftest+bounces-20291-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE289A70FA
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 19:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 187DE280A10
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Oct 2024 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DF71EE006;
	Mon, 21 Oct 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+V8S9Uo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915841CBEBC
	for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 17:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531421; cv=none; b=Hhi89by9mumnSWjC6yDlwFyAYjqU9j7EIH4aQ+spNci7HwZAHP0Om+x7OCSadKZSMQdxRGIf3k+HfDvgBUxOv5t2B6RS+BQI+s5e90K2WagTlR7NejAXnwhrbbfOME06hgmtOMqN7luiR7K+i544w3ihSyas8ed0y7bzzog882Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531421; c=relaxed/simple;
	bh=oKEWf7RfP+QVQ2j4D3wNCFmA7AZfNFJWNtDM/GP2Y90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MTKiqW2+mvgw6zvTzKDjN7q2fYBsjstdPvwHmHt2N2zgH/GJiEoOGjAWUU6h6S+xvLM2JNEkICAsfv75JtmWtVi8oFevgTEbda9R00bAeK8MZ1x2zq8TFmJc0LQyqNMAG+wZjvKdV3RND46XgpJsV55km3lDLdT8O4xewV0LHbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+V8S9Uo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729531418;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rbtgwTTdsrp9C2vvtezGlmmInm+A/tBxzwCFhKgoKoU=;
	b=Y+V8S9UotZ9u0flnD8EpXXGsDpss+JjMi14gN8rik8flcUb9r3R8PgwF4B34Z0OHg33HmU
	d9lyrgKIMhvUuH+jnLHLP5OUIj1wAztg7swImFE8iCRuLPvfD9DwDL8fytB4JKR7yxKT75
	oI2katCZ/qKt+wZcq3g+osaISKxl3tQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-1s6NppvONPGYt7ab_Ajumg-1; Mon, 21 Oct 2024 13:23:37 -0400
X-MC-Unique: 1s6NppvONPGYt7ab_Ajumg-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315af466d9so32364515e9.3
        for <linux-kselftest@vger.kernel.org>; Mon, 21 Oct 2024 10:23:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729531416; x=1730136216;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rbtgwTTdsrp9C2vvtezGlmmInm+A/tBxzwCFhKgoKoU=;
        b=M23rBsbxqeFM09U6uze5tqvIJOiFivcKkTrqU+EcOAwxvUtbHQV0+Y72DIppIQoANC
         pJQjaFq85Fwsmejd+tM4Z0YN4HbXDfLRg89yqXqR4W8JeELja9jJd3B+CkTp4RXqAOGh
         IJIEI6t3nykFfcf++s+zliKaK7Eu3Uh4FhDXsIW3qY7eUUkr6cd6aWyWWIl6vPeDrwB4
         mEiJFW4tLYY9VpAO1qc35w8e5t1vTHJEXyCOJgkJzf0IcOSewDYXKseNUWK8Lz2vhoa5
         gtnGTAvD/yypYQ/RlC+2/9mMMw1Syekb5niru5wnPGubKEfQMzrkACK7PBLI4wNx8Koq
         P7GA==
X-Forwarded-Encrypted: i=1; AJvYcCUXjIaYZFic/vFqwjs91woMKPhGirlGpWiyXMA5hvNrvNtMQrDmMoaIhUhrSUxRHEhHI3Ko+EqcccZeIA0wmrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNAGJVwjhxeHmIxTtics5Cu+gPvX2Rd60xWcm++JP/Tplwzop1
	4g/tcVqtgnoEPZOr4T069FnqJ6CuaX78l6fnQOqoPnWq9NugKmXWkP+ph5nhwE752lRD3FkhwwN
	9gXSjWTpgFw8j82pnRTsvfcfhs4jei2dClp3yi6ZWWLccfD+z9S4LrJqI665o6f3KxQ==
X-Received: by 2002:a05:600c:1c1e:b0:431:5f3b:6ae4 with SMTP id 5b1f17b1804b1-4316165c74bmr97523555e9.17.1729531416358;
        Mon, 21 Oct 2024 10:23:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzP1uIzlXg5GGh+u/9IkOAPz8nGqfNtQ9p+gPX86cgcCut8zBrFia3MvvSCDy9Y4jnTClc5A==
X-Received: by 2002:a05:600c:1c1e:b0:431:5f3b:6ae4 with SMTP id 5b1f17b1804b1-4316165c74bmr97523135e9.17.1729531415890;
        Mon, 21 Oct 2024 10:23:35 -0700 (PDT)
Received: from ?IPV6:2003:cb:c728:1600:e899:f836:758b:6fef? (p200300cbc7281600e899f836758b6fef.dip0.t-ipconnect.de. [2003:cb:c728:1600:e899:f836:758b:6fef])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f571201sm64618285e9.5.2024.10.21.10.23.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Oct 2024 10:23:34 -0700 (PDT)
Message-ID: <c8272b9d-5c33-4b44-9d6d-1d25c7ac23dd@redhat.com>
Date: Mon, 21 Oct 2024 19:23:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <b13a83f4-c31c-441d-b18e-d63d78c4b2fb@redhat.com>
 <b2bca752-77f3-4b63-abe9-348a5fc2a5cc@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b2bca752-77f3-4b63-abe9-348a5fc2a5cc@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.24 19:15, Lorenzo Stoakes wrote:
> On Mon, Oct 21, 2024 at 07:05:27PM +0200, David Hildenbrand wrote:
>> On 20.10.24 18:20, Lorenzo Stoakes wrote:
>>> Implement a new lightweight guard page feature, that is regions of userland
>>> virtual memory that, when accessed, cause a fatal signal to arise.
>>>
>>> Currently users must establish PROT_NONE ranges to achieve this.
>>>
>>> However this is very costly memory-wise - we need a VMA for each and every
>>> one of these regions AND they become unmergeable with surrounding VMAs.
>>>
>>> In addition repeated mmap() calls require repeated kernel context switches
>>> and contention of the mmap lock to install these ranges, potentially also
>>> having to unmap memory if installed over existing ranges.
>>>
>>> The lightweight guard approach eliminates the VMA cost altogether - rather
>>> than establishing a PROT_NONE VMA, it operates at the level of page table
>>> entries - poisoning PTEs such that accesses to them cause a fault followed
>>> by a SIGSGEV signal being raised.
>>>
>>> This is achieved through the PTE marker mechanism, which a previous commit
>>> in this series extended to permit this to be done, installed via the
>>> generic page walking logic, also extended by a prior commit for this
>>> purpose.
>>>
>>> These poison ranges are established with MADV_GUARD_POISON, and if the
>>> range in which they are installed contain any existing mappings, they will
>>> be zapped, i.e. free the range and unmap memory (thus mimicking the
>>> behaviour of MADV_DONTNEED in this respect).
>>>
>>> Any existing poison entries will be left untouched. There is no nesting of
>>> poisoned pages.
>>>
>>> Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
>>> unexpected behaviour, but are cleared on process teardown or unmapping of
>>> memory ranges.
>>>
>>> Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
>>> 'remedying' the poisoning. The ranges over which this is applied, should
>>> they contain non-poison entries, will be untouched, only poison entries
>>> will be cleared.
>>>
>>> We permit this operation on anonymous memory only, and only VMAs which are
>>> non-special, non-huge and not mlock()'d (if we permitted this we'd have to
>>> drop locked pages which would be rather counterintuitive).
>>>
>>> Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>>> Suggested-by: Jann Horn <jannh@google.com>
>>> Suggested-by: David Hildenbrand <david@redhat.com>
>>> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>> ---
>>>    arch/alpha/include/uapi/asm/mman.h     |   3 +
>>>    arch/mips/include/uapi/asm/mman.h      |   3 +
>>>    arch/parisc/include/uapi/asm/mman.h    |   3 +
>>>    arch/xtensa/include/uapi/asm/mman.h    |   3 +
>>>    include/uapi/asm-generic/mman-common.h |   3 +
>>>    mm/madvise.c                           | 168 +++++++++++++++++++++++++
>>>    mm/mprotect.c                          |   3 +-
>>>    mm/mseal.c                             |   1 +
>>>    8 files changed, 186 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi/asm/mman.h
>>> index 763929e814e9..71e13f27742d 100644
>>> --- a/arch/alpha/include/uapi/asm/mman.h
>>> +++ b/arch/alpha/include/uapi/asm/mman.h
>>> @@ -78,6 +78,9 @@
>>>    #define MADV_COLLAPSE	25		/* Synchronous hugepage collapse */
>>> +#define MADV_GUARD_POISON 102		/* fatal signal on access to range */
>>> +#define MADV_GUARD_UNPOISON 103		/* revoke guard poisoning */
>>
>> Just to raise it here: MADV_GUARD_INSTALL / MADV_GUARD_REMOVE or sth. like
>> that would have been even clearer, at least to me.
> 
> :)
> 
> It still feels like poisoning to me because we're explicitly putting
> something in the page tables to make a range have different fault behaviour
> like a HW poisoning, and 'installing' suggests backing or something like
> this, I think that's more confusing.

I connect "poison" to "SIGBUS" and "corrupt memory state", not to "there 
is nothing and there must not be anything". Thus my thinking. But again, 
not the end of the world, just wanted to raise it ...

> 
>>
>> But no strong opinion, just if somebody else reading along was wondering
>> about the same.
>>
>>
>> I'm hoping to find more time to have a closer look at this this week, but in
>> general, the concept sounds reasonable to me.
> 
> Thanks!

Thank you for implementing this and up-streaming it!

-- 
Cheers,

David / dhildenb


