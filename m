Return-Path: <linux-kselftest+bounces-12133-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAFE90C5EC
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 12:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B09D281740
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Jun 2024 10:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E347A768E1;
	Tue, 18 Jun 2024 07:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BU0NFfs0"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5A47F489
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695930; cv=none; b=oyzJ59bxo7jP0hwpkEplAeiS5bEpSN6QvnIY8beKaHyPrAT0A2rPnk1p9aKUVDUQrTNPtVAy0CW/LwnSNf+AyX/Nt5Y+x2hwscJAqQrsehxVDKDTVO7oTyKqW37Xt9W1qrf9bAxbTGKVIYz3lSdsZ+zNnhL3YGkVl0mjDgGEmPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695930; c=relaxed/simple;
	bh=9peSSixWp5wz2Ypt0ExsmCHg0gpng6uj88KoSMi55Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fBOXYQ5oKSAaCy51RAz5zN5DlHsbLt6jEyQR7XSKf5YL+uLwEnG+B9BbtBS3yEohMBJKJjEVOroU8w9VndsVOVWSXhJ2pMgxYSOBOrllAW4J+YkJlyLkGkbk6zBjXHgK34A8lz1SKgQOKAx45PWozRFyn9lhw28+rFu+G2kqhGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BU0NFfs0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718695928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n0Vo8f+ZlGXIuWvuNgxoFmQ4o2l/ClYS3oJHfYkg9HA=;
	b=BU0NFfs0O1emmRCPrrVKz2R6jk54jaSK+bf8A9RlB3OufGFVPMWodAklRQm7a1RURqQp3r
	KexRI290Bc9r6cgYvpeOpDXUsE791kBzFx692w035tnH360RJz7WzgYlb2L2dGjsax4p+h
	JgvZ9HijxS/O7EIHEZ1JlVcZQlOqf48=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-4qfCCOASO8O40IjmartjAQ-1; Tue, 18 Jun 2024 03:31:59 -0400
X-MC-Unique: 4qfCCOASO8O40IjmartjAQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42196394b72so33879705e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Jun 2024 00:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718695918; x=1719300718;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n0Vo8f+ZlGXIuWvuNgxoFmQ4o2l/ClYS3oJHfYkg9HA=;
        b=u4M5oJSc1TD5VLSn0RaOo/hOGNW++pP91M8lNo2eYr9/y0pwObHAeaMSZOBeTulq9L
         3FGJsJqiPPoi/p2oRmWVgzogpXyoVOCY6pBUSoZfa7Y4NtGX65VrOV2FBHZcBUXsmcML
         NDIDNN7uqOaly5tiJTkX7WZekpCqAU684MvYgpcKGf8jLTd9d6IPwqNKEI1KvBJZEENy
         qeuhZ6EXugCWJsCnEWfqR0S4C8nfUdzOU/ImUTn6A3Rut2FZnclsD2LcPmYH0DilfdiB
         s/CNqcwIleZR6+FAicT8Y0MJ+Fxn1YHj3S76T6tRNAVNCKemlGL7aaydEgJyOfHntVqk
         iAIw==
X-Forwarded-Encrypted: i=1; AJvYcCVX7NrRM+9ElVhElzWB2/AxsvTHEuARvbx26/q4o7t1T09XUz7lemsOrHpxB5RWBLr3n+WEsu8ud4K176L+ipYqmVM+X4nsLju3JnAUGX28
X-Gm-Message-State: AOJu0YxLaYy2G4+oZ3Q7EZAQPxX6OS/25NQyKQvwxA4LBdSukm1LtQDm
	23rj3HmQXy5jMc37XzBNxn13TgRQbtZGC1MG9FR5EsMOQ8pnK4UWJvKojA1R/SOp1PavAoJPdZ9
	Bo4O8f4ZeeGHdsLG+HYscAxvS4mMmvryJI45pHQudiW914WkftH4fo7oHv0cauMHL6Q==
X-Received: by 2002:a05:600c:4444:b0:422:1705:7533 with SMTP id 5b1f17b1804b1-4230484e8c1mr111095775e9.26.1718695918066;
        Tue, 18 Jun 2024 00:31:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa7qSPMBk2S+EuQGlz0s4iMks91+fV6r6slBFHdvtQIXAlrV1iiRKznmQ/QJt8Jiw3ij4oOw==
X-Received: by 2002:a05:600c:4444:b0:422:1705:7533 with SMTP id 5b1f17b1804b1-4230484e8c1mr111095465e9.26.1718695917515;
        Tue, 18 Jun 2024 00:31:57 -0700 (PDT)
Received: from ?IPV6:2003:cb:c705:1400:78ba:c2d2:22a1:8858? (p200300cbc705140078bac2d222a18858.dip0.t-ipconnect.de. [2003:cb:c705:1400:78ba:c2d2:22a1:8858])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e0c2sm178612995e9.14.2024.06.18.00.31.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:31:56 -0700 (PDT)
Message-ID: <7421843a-43ba-467f-ac43-102f2e00e2ae@redhat.com>
Date: Tue, 18 Jun 2024 09:31:55 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] selftests/mm: kvm, mdwe fixes to avoid requiring
 "make headers"
To: John Hubbard <jhubbard@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jeff Xu <jeffxu@chromium.org>,
 Shuah Khan <shuah@kernel.org>
Cc: Andrei Vagin <avagin@google.com>,
 Axel Rasmussen <axelrasmussen@google.com>,
 Christian Brauner <brauner@kernel.org>, Kees Cook <kees@kernel.org>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Peter Xu <peterx@redhat.com>, Rich Felker <dalias@libc.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: <20240618022422.804305-1-jhubbard@nvidia.com>
 <20240618022422.804305-6-jhubbard@nvidia.com>
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
In-Reply-To: <20240618022422.804305-6-jhubbard@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18.06.24 04:24, John Hubbard wrote:
> On Ubuntu 23.04, the kvm and mdwe selftests/mm build fails due to
> missing a few items that are found in prctl.h. Here is an excerpt of the
> build failures:
> 
> ksm_tests.c:252:13: error: use of undeclared identifier 'PR_SET_MEMORY_MERGE'
> ...
> mdwe_test.c:26:18: error: use of undeclared identifier 'PR_SET_MDWE'
> mdwe_test.c:38:18: error: use of undeclared identifier 'PR_GET_MDWE'
> 
> Fix these errors by adding a new tools/include/uapi/linux/prctl.h . This
> file was created by running "make headers", and then copying a snapshot
> over from ./usr/include/linux/prctl.h, as per the approach we settled on
> in [1].
> 
> [1] commit e076eaca5906 ("selftests: break the dependency upon local
> header files")
> 
> Cc: David Hildenbrand <david@redhat.com>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


