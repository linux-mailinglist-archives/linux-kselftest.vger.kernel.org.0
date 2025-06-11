Return-Path: <linux-kselftest+bounces-34693-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF731AD550C
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86E8A1621EE
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731C427CB16;
	Wed, 11 Jun 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tlvs5bKa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A07273D68
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643781; cv=none; b=Uzi5Maa7tOwGm8t+Rj7lRswPjZfBKMy9PnwtOey7mzdZ+is+uIoZuWw2cVVsvb6ujVov4DBk+C5MYzR2zoafXN4mCBgtz6soAADBr3R97DKWHPOjIGjAWyoyxzLjf/w5KyXzENYiMGuO+JyUAEWXLb4795+Nhpx8gUybV1Q30do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643781; c=relaxed/simple;
	bh=1tDMKePeUmlMiIU1QyuyQIKUTqBrro9ueLtZjcltcDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ISCjmfcdYTZR9TWo3stmof8c+kLqJlY6vFeBXRc84lEUer/0vGjaZoGE4X3MS3mIo4yjQZFMms9d21sW7dTOab7vNU6ePiLq19w1IEt/ce+f4GoR+HBfDqots6ZriJxYJ1NNy/0wxeuahPg5/CbeKhQ/FsVRHaMWiUN1qXES/sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tlvs5bKa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749643777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iJysvH6GbWyXgfkZNDFvCAJBKuXVqV66Rj7a/cAeTAI=;
	b=Tlvs5bKaMIRiu7/b9Kx6QNzlbo1vVMAxpmX71DjP6LW2wHmB4iz+S8BXNnOlx7Qbx/bC4R
	D+Mqg4VATszWW1FqJyzktY98GIb+P5EULmmw4aoEG2M81vldGSAZbMzgTKC994sL8UCoLO
	DEvtENrieOUQoPVmeFm1MkpKN82lluA=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-PiwdVZ3POE6Rr1l7fYwc_w-1; Wed, 11 Jun 2025 08:09:35 -0400
X-MC-Unique: PiwdVZ3POE6Rr1l7fYwc_w-1
X-Mimecast-MFC-AGG-ID: PiwdVZ3POE6Rr1l7fYwc_w_1749643775
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6fad8b4c92cso170735686d6.0
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 05:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643775; x=1750248575;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iJysvH6GbWyXgfkZNDFvCAJBKuXVqV66Rj7a/cAeTAI=;
        b=bPFZY+abd7vPTSmzgWCrVyfPr3UwkZLEI0ETf1iw5dq9elE/IuoxTwgB6kfD5/r2Lx
         D2gVQP4sAOXas7MUCAN07raODDxMDTnYWcTGsi/n90TuiaBZj9+6yAFmePvMPuk1HbTK
         Z1dXkIn2o4DEJWqNaPkRpRhGfocz4ckf73BafrrmQLObTlh/qPKtNwxdKNvx3OR/dypp
         CPZks8xC9+sC96BcTFilZO1MutbyJCZ6wbujMma1vJl8rP/kRsTDVaqrYU9Uo0B6gJKV
         SMfCcFe+D93l9neLAsEbLr9k9wq7QMbcCMr5ZJdX4/6Srg56tdSSsR29VUbcEs9VeZc1
         xQ7w==
X-Forwarded-Encrypted: i=1; AJvYcCUyKVL3ohuwnVJ2s0gJFdiBW/qWKwQpFUkq9NJWZtht4Z1za5uSyXAzmGzE7AWyQlZfiOtu4SeNLc7AlHp/7WE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4YOYqP5uL4dglOn8EN6p50o/P/3bI9SuyBKNmegRUTeaHSjsg
	sBGCYBbLo1QCEEhlz16TWIT8kxaDgvxjjo2dccGO7jdnZfnPOLWa7hgCdISoZXDR+0EWFlWHDT5
	6uEPlYhuKUX6UEvtt4XwHQjSpfsiKMH/Ku0e4uR29uno0LQ7cS9Paj1YKOTHkvOFzh1gckg==
X-Gm-Gg: ASbGncslr5Ur1mbpTk+onDAqj1sWdFxuy+wgYRUd6JHr9mGCFKxgRw4np59YtXTX/z7
	UT9taQ/4xoPjfy3x4HCIYsAfA1zHzrHfDt4UA4KMl5aO0CETPjSnswMAJYFSScysIDZ5B+bziTQ
	iyjENilK6JvtOGMbIBar0QqHX2XiZ5yb4XgOI+6HOdJHVzyusBn1XEd6R0NHOIqEY1atrf/GDXL
	N7NeobgHzWdLTqsDuwVB+dEocOsOerVnw/52pVRJn98cf8kXE3CfEqZFsg58njPebWqJEq6SAAd
	PVaU0skbl3MBwMXpYmhrjBTPUIAOdvpqgoZj0TKDDMjq
X-Received: by 2002:a05:6214:e4c:b0:6fa:cdc9:8af7 with SMTP id 6a1803df08f44-6fb2d0ccab9mr43232846d6.7.1749643774985;
        Wed, 11 Jun 2025 05:09:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHMaoMTIa642I8RwMNstQhFDRdz8wxzppBgakC5WZX1PvM5z/Ea1SbCR8D34tOHYLF9z4au/g==
X-Received: by 2002:a05:6214:e4c:b0:6fa:cdc9:8af7 with SMTP id 6a1803df08f44-6fb2d0ccab9mr43232536d6.7.1749643774640;
        Wed, 11 Jun 2025 05:09:34 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fb09b1ce20sm80729166d6.67.2025.06.11.05.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:09:34 -0700 (PDT)
Message-ID: <a01bb9aa-eaa3-4de6-9ecd-8341fcfe265e@redhat.com>
Date: Wed, 11 Jun 2025 14:09:32 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kselftest/mm: Clarify errors for pipe()
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
 <20250610-selftest-mm-cow-tweaks-v1-1-43cd7457500f@kernel.org>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
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
In-Reply-To: <20250610-selftest-mm-cow-tweaks-v1-1-43cd7457500f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.25 16:13, Mark Brown wrote:
> Specify that errors reported from pipe() failures are the result of
> failures.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


