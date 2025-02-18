Return-Path: <linux-kselftest+bounces-26859-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A247A3A0F7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9A91666C7
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 15:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6794926B94A;
	Tue, 18 Feb 2025 15:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZO7HGirx"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD7226B943
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739892029; cv=none; b=gCG/Ts6ycoAyXHSYDrcUsJlukFMN/hD2KMfES1SLy7ZEeZ+rBn13ygRJCJ0rujnHByTLV+EBuU7pAu1id5xDYMkAjrYNX7L6R87cyzzQH37qK0zncNj2G8RNm5YKJJjD08hoYCyP0hY+x66MpwZ41cZcctistCEzuYXgryzeCZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739892029; c=relaxed/simple;
	bh=aEDqTdmziFf/CK92QAabcyli0LRaNHAI+Sgk8xpTOm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uaCM2kLSIJ8wEFQF+zRg6mCrXfvNOmvAlDQEmrmBUze83RjYLRpvUEzirq3vOLeJTYv+0QPvpG2PbiYjtWzud/1ZWLKvIHKTixE85wFyXxv6hEkyl1OYRRA0X1tNbN4XNoM1HC+EIxVKuY78SH94duKtX0sLmb+EqsOAr+1jJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZO7HGirx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739892026;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=WhNv10sgTPWImPGJDtp7CuiUxd0Y/eiyawh1eIHFiXc=;
	b=ZO7HGirxgrf+wkdADbeG7AEeD2N3ODIkFBh8WIoAeTG77UYKWuRPY0Q0jJAlWYCHV6OCoV
	OcKzjXWXyfZhnaQVKUJGepUPZpanP4p2IoVMklhwTXwc3sU+k0q5qnwcR4u5g2wE8xEuSJ
	Ga0f73Qr32qd2gJxX/UD/3+KiN78TqU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-pWNw3v0lOjWVw-7ZZJl9_A-1; Tue, 18 Feb 2025 10:20:25 -0500
X-MC-Unique: pWNw3v0lOjWVw-7ZZJl9_A-1
X-Mimecast-MFC-AGG-ID: pWNw3v0lOjWVw-7ZZJl9_A_1739892023
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4393e873962so30549845e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 07:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739892023; x=1740496823;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WhNv10sgTPWImPGJDtp7CuiUxd0Y/eiyawh1eIHFiXc=;
        b=GEm59GHion4TkasRES2HBScRiAdvKL+fi7oWB9kcCxhWWXfhOI2OK5HoGxXYkyATRV
         Ads0iYG5LOgambPArRtq+OOeybLEJnpd9rGewFdp2re0+t9IgYdlX4NeJU8flFVwzJQS
         thvAamRdEJtKGH/dBgUbwBDC1nIQO7mDqwIoth0ds+bgXMqIyWw/uC5YDw32qw1sRaV4
         ge9Ae6vNQgmwWNs/JNNdB3GPjTW+5M8oWDCDV5pHk3sl3OekWnVZEK/0oxgx0GO9xorA
         yu4faaCwRlVNzgzWxCJzWZ0aNE45vfHsx7dMBS5yIgLGdrqBuBfWEOakcTbqhgUYU4k/
         9qVA==
X-Forwarded-Encrypted: i=1; AJvYcCWpcXnKuo+hguAjsLfaf8XcXfJ6A9TuQrjHFutIaeFrBx7KKatmgea63x4K1rzZkn4mQeikPTn7SY2zJk2TtpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNL1/qXOSZzFPJYSmx618V09GAlXnZvMK1cYGnuLAXYeVgmCCL
	uscm/RJGxw8izCNxyOC3jh93jsrzxjGl6o0b+lBlu1X67yRc6x59wBtC0c59o48c4rZ+dD61Suk
	icxlbf2NgDIn9CFYq9eQ6bfwWu8UsDfalrDpUIUb7fNURDbwwVmPQwqGMcWn4BvHyfA==
X-Gm-Gg: ASbGncuSY6tv4rc5qWY5j9zakAUyrIDnjIVkXe+Uwq2bAf9qPnxP3/4IQ6LthKzRGzR
	/FKaZXJM+Gx8O4H9nFg9l/DXHmuT7FgmLNBetL2ENI9mDBH1SWWCHe1Va70Aw4X2LCd+tn+7cbX
	602E9n0uPzs01YWszKWzHfUB+BznYftfuYUfl9bBXRQ5AT1in9s+M2Tsyz0z6Y7sl3xcBJj6AI6
	8NAMcr6shSkFMSiowIKNrgW/4VZ0DWwsbK2J5xKNH5P7I/tPslmBHVQLqBto6S64C6RFxfOSFFs
	jjAS7pgL/G3S7XCuvAUNbnnVqZcjvE/Ue/uVrIhS2i+w9yNnBnKnx1qbA4EEj0+BXd+UqSEnodg
	XZXLypkQXSK2ZCGX3pv2zVxcTjeECCs2a
X-Received: by 2002:a05:600c:4f46:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-4396e779e07mr135001065e9.30.1739892022801;
        Tue, 18 Feb 2025 07:20:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGt/mUXG8WAW22lDb9RLP6A0RPrWq6SnCKfzdqbAchkIC5PCf6iyMWRH2dy/3bARKrtWEKYsQ==
X-Received: by 2002:a05:600c:4f46:b0:436:e3ea:4447 with SMTP id 5b1f17b1804b1-4396e779e07mr135000665e9.30.1739892022393;
        Tue, 18 Feb 2025 07:20:22 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-439872b5a46sm52873715e9.32.2025.02.18.07.20.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 07:20:21 -0800 (PST)
Message-ID: <0db666da-10d3-4b2c-9b33-781fb265343f@redhat.com>
Date: Tue, 18 Feb 2025 16:20:18 +0100
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
Cc: Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Juan Yescas <jyescas@google.com>,
 Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <fbfae348-909b-48fa-9083-67696b02f15e@suse.cz>
 <8d643393-ddc0-490d-8fad-ad0b2720afb1@lucifer.local>
 <37b606be-f1ef-4abf-83ff-c1f34567568e@redhat.com>
 <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <b5b9cfcb-341d-4a5a-a6b7-59526643ad71@lucifer.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

> Right yeah that'd be super weird. And I don't want to add that logic.
> 
>> Also not sure what happens if one does an mlock()/mlockall() after
>> already installing PTE markers.
> 
> The existing logic already handles non-present cases by skipping them, in
> mlock_pte_range():
> 
> 	for (pte = start_pte; addr != end; pte++, addr += PAGE_SIZE) {
> 		ptent = ptep_get(pte);
> 		if (!pte_present(ptent))
> 			continue;
> 
> 		...
> 	}

I *think* that code only updates already-mapped folios, to properly call 
mlock_folio()/munlock_folio().

It is not the code that populates pages on mlock()/mlockall(). I think 
all that goes via mm_populate()/__mm_populate(), where "ordinary GUP" 
should apply.

See populate_vma_page_range(), especially also the VM_LOCKONFAULT handling.

> 
> Which covers off guard regions. Removing the guard regions after this will
> leave you in a weird situation where these entries will be zapped... maybe
> we need a patch to make MADV_GUARD_REMOVE check VM_LOCKED and in this case
> also populate?

Maybe? Or we say that it behaves like MADV_DONTNEED_LOCKED.

> 
> Actually I think the simpler option is to just disallow MADV_GUARD_REMOVE
> if you since locked the range? The code currently allows this on the
> proviso that 'you aren't zapping locked mappings' but leaves the VMA in a
> state such that some entries would not be locked.
> 
> It'd be pretty weird to lock guard regions like this.
> 
> Having said all that, given what you say below, maybe it's not an issue
> after all?...
> 
>>
>> __mm_populate() would skip whole VMAs in case populate_vma_page_range()
>> fails. And I would assume populate_vma_page_range() fails on the first
>> guard when it triggers a page fault.
>>
>> OTOH, supporting the mlock-on-fault thingy should be easy. That's precisely where
>> MADV_DONTNEED_LOCKED originates from:
>>
>> commit 9457056ac426e5ed0671356509c8dcce69f8dee0
>> Author: Johannes Weiner <hannes@cmpxchg.org>
>> Date:   Thu Mar 24 18:14:12 2022 -0700
>>
>>      mm: madvise: MADV_DONTNEED_LOCKED
>>      MADV_DONTNEED historically rejects mlocked ranges, but with MLOCK_ONFAULT
>>      and MCL_ONFAULT allowing to mlock without populating, there are valid use
>>      cases for depopulating locked ranges as well.
> 
> ...Hm this seems to imply the current guard remove stuff isn't quite so
> bad, so maybe the assumption that VM_LOCKED implies 'everything is
> populated' isn't quite as stringent then.

Right, with MCL_ONFAULT at least. Without MCL_ONFAULT, the assumption is 
that everything is populated (unless, apparently one uses 
MADV_DONTNEED_LOCKED or population failed, maybe).

VM_LOCKONFAULT seems to be the sane case. I wonder why 
MADV_DONTNEED_LOCKED didn't explicitly check for that one ... maybe 
there is a history to that.

> 
> The restriction is as simple as:
> 
> 		if (behavior != MADV_DONTNEED_LOCKED)
> 			forbidden |= VM_LOCKED;
> 
>>
>>
>> Adding support for that would be indeed nice.
> 
> I mean it's sort of maybe understandable why you'd want to MADV_DONTNEED
> locked ranges, but I really don't understand why you'd want to add guard
> regions to mlock()'ed regions?

Somme apps use mlockall(), and it might be nice to just be able to use 
guard pages as if "Nothing happened".

E.g., QEMU has the option to use mlockall().

> 
> Then again we're currently asymmetric as you can add them _before_
> mlock()'ing...

Right.

-- 
Cheers,

David / dhildenb


