Return-Path: <linux-kselftest+bounces-35685-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE97AE63D8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 13:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1A3188C1B8
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Jun 2025 11:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D608286D4E;
	Tue, 24 Jun 2025 11:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EEd0+qEI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E7D27AC3C
	for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 11:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750765738; cv=none; b=qUFGSg+novWU7mxksZFsBLLRkaM4FleVsWVOMInk1xhNxCbccFE+R+xNjQLwDil3TUKvU9SPq6FTJxuBLlAysqjvIiAPlHEFOQOd0qBiACZdMMJ1Xp2bwvzkYmmVwYopuua+C+FhIXEwF4SbD2x5Iw2/chRLX3ykUZE9RfKzPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750765738; c=relaxed/simple;
	bh=14u+W+cQcCXUs9xJ9ptflndPkrK5G2sfasI5M9OUgug=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GlIkn5tti9T6iepAC4MGWqCL/vKZqlSkawx29H8sYKKAEfB7BHxArPUtk6rVXwa642+l/FwpoYLcUJpkDPBXcuuVvSR7v27CPQyZJjosDRJQ134jpRKp32IuSXrKuRHMXvVpSvwQG5o9/fF7JNmZgkrH2kwyqjhN1bxZlC9vEyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EEd0+qEI; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750765736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BjJpxF1LECO1PRi8kqM/ATCIsmTz38nbps9nkRr6Q/o=;
	b=EEd0+qEIsEftbBqHYfnd/BBvt0UggScheOe4dwDI08E4sHWHSN7tgBzSgjVqTNR1nyXGWM
	wKoMhQ7+7m9yyT1z9gHp9r6pD6GBVpZ4OGYH7dXoJtF0fO9TKoGWpf8dcgfln1XLUuVF0m
	aSOD44J/gs2hra8phMTWLHVZ7j4L734=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-142-7CyZ3EUONWWiq9m-TkeQYw-1; Tue, 24 Jun 2025 07:48:54 -0400
X-MC-Unique: 7CyZ3EUONWWiq9m-TkeQYw-1
X-Mimecast-MFC-AGG-ID: 7CyZ3EUONWWiq9m-TkeQYw_1750765733
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a3696a0d3aso2365832f8f.2
        for <linux-kselftest@vger.kernel.org>; Tue, 24 Jun 2025 04:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750765733; x=1751370533;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BjJpxF1LECO1PRi8kqM/ATCIsmTz38nbps9nkRr6Q/o=;
        b=EX5FkDTWaIoDetA93WA5J64PIZvDzxKc3689aZk4moPH/FTeEMyS0u17173ZLEDZB3
         du98vR3e/nXMj7lJVKAapaSQXuwc20eDA4xFqpFPZXfC2cLlFghEBuDVbRwUEW0u8A4g
         vnavI7HZGeJYCerJmQASf6IFMoG7ty6kxpUxlCbGX+OaqtzMU9Lvm66XgwVm+uDguyuS
         JtHUbGE7nrVwP2sh0yMjPVKRyxSucJzRtOvXDynhwl2w8qxA7pSGlJUzl0sq0umgWEuh
         hbVmAb6qgyjJG65R47xUZ27qTv2ZdWZjaRqjW3rx9XY9BaSYjIkCk402ZA+0liGmNPtv
         BDcQ==
X-Forwarded-Encrypted: i=1; AJvYcCU75xjdPFD6E78lB8O9SRGalwAwJ+TMu0VtAFl8vp93MIHRJ4diabtQdoG98rYwG2gxSoya/Gm/rkyH43e5WNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Su1eVjXmRicwnXMBshhrcWZcuxhOkhPUYb3wDH++00lv+Fkl
	0Ecx95r0KZqkrMq/1tzP0uUofxvUJxQ9f5bZUWWb3C5ca8Poz1mrZ24zKmhAMSyGvKYwQOv9cmC
	oWF4G3cT9QiGIrlVZ69PY2kHCPGhoEt3euC8cybe2mbjgcjqBn4P/+iUMMGPgLyjfNcL30g==
X-Gm-Gg: ASbGncseJAGBDxzJ848qKgThJODV8FRMWzp+8u86bkftoVu6jXSr5jy6XrCq46koAES
	z2hWd27Y6in9afcLhuNwPRkaJ1tOrBJ7ipnxTjVU/3wn0otAYWk2Pr04XLhrjawWGRdWgYOAKkw
	qSAo2DPWiIuRnKnBXeRfHUkmN9tI5nBsXIBZjrWYnbAjg6c3Fc9Gv5HXbxSNH0TOPDOTlmLatKA
	OAzFmkbM0QCjH9l4jTyXKdadY1pC+wAkn81pxyD1wA5FG/lurxa8yqUpAqiJZBVUlEwebnt26EF
	Z2Rk87pnQ2ovX0k1zlIqYSaw8/hv699mQs+Zdcy+06HAX7tDTptBjC8=
X-Received: by 2002:a05:6000:3103:b0:3a4:f7af:b41 with SMTP id ffacd0b85a97d-3a6d128db06mr13100281f8f.15.1750765733455;
        Tue, 24 Jun 2025 04:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkmLPYuaxXT2XxgaacTu86F8qbQot0I4+8jm38oh1duDAsrGuV6aY8E5RgTpgxNjpCM1xP1w==
X-Received: by 2002:a05:6000:3103:b0:3a4:f7af:b41 with SMTP id ffacd0b85a97d-3a6d128db06mr13100242f8f.15.1750765732964;
        Tue, 24 Jun 2025 04:48:52 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453646d156esm141814525e9.11.2025.06.24.04.48.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 04:48:51 -0700 (PDT)
Message-ID: <495dc88a-c0b2-4090-a89c-00f000b62a2f@redhat.com>
Date: Tue, 24 Jun 2025 13:48:50 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] selftests/mm: Fix UFFDIO_API usage with proper
 two-step feature negotiation
From: David Hildenbrand <david@redhat.com>
To: Nadav Amit <nadav.amit@gmail.com>,
 Axel Rasmussen <axelrasmussen@google.com>
Cc: Li Wang <liwang@redhat.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-kselftest@vger.kernel.org,
 "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
 Peter Xu <peterx@redhat.com>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Joey Gouly <joey.gouly@arm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Keith Lucas <keith.lucas@oracle.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Shuah Khan <shuah@kernel.org>,
 Mike Rapoport <rppt@kernel.org>
References: <20250622081035.378164-1-liwang@redhat.com>
 <20250624042411.395285-1-liwang@redhat.com>
 <dfd7650d-1154-467d-ae70-c126610413f6@redhat.com>
 <4fd18a1c-aba2-468a-881f-0507953f2904@redhat.com>
 <611F9598-A1A4-47B6-B37E-09BF7B4D17D0@gmail.com>
 <239f75e4-1868-4ac9-882f-664a8863b781@redhat.com>
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
In-Reply-To: <239f75e4-1868-4ac9-882f-664a8863b781@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 24.06.25 13:39, David Hildenbrand wrote:
> On 24.06.25 13:29, Nadav Amit wrote:
>>
>>
>>> On 24 Jun 2025, at 11:22, David Hildenbrand <david@redhat.com> wrote:
>>>
>>> On 24.06.25 10:07, David Hildenbrand wrote:
>>>>>
>>>> Is that actually required?
>>>> The man page explicitly documents:
>>>> "       EINVAL A  previous  UFFDIO_API  call already enabled one or more
>>>> features for this userfaultfd.  Calling UFF‐
>>>>                  DIO_API twice, the first time with no features set, is
>>>> explicitly allowed as per the two-step  feature
>>>>                  detection handshake.
>>>> "
>>>> So if that doesn't work, something might be broken.
>>>
>>> CCing Nadav and Peter:
>>>
>>> Could it be that
>>>
>>> commit 22e5fe2a2a279d9a6fcbdfb4dffe73821bef1c90
>>> Author: Nadav Amit <nadav.amit@gmail.com>
>>> Date:   Thu Sep 2 14:58:59 2021 -0700
>>>
>>>      userfaultfd: prevent concurrent API initialization
>>>          userfaultfd assumes that the enabled features are set once and never
>>>      changed after UFFDIO_API ioctl succeeded.
>>>          However, currently, UFFDIO_API can be called concurrently from two
>>>      different threads, succeed on both threads and leave userfaultfd's
>>>      features in non-deterministic state.  Theoretically, other uffd operations
>>>      (ioctl's and page-faults) can be dispatched while adversely affected by
>>>      such changes of features.
>>>          Moreover, the writes to ctx->state and ctx->features are not ordered,
>>>      which can - theoretically, again - let userfaultfd_ioctl() think that
>>>      userfaultfd API completed, while the features are still not initialized.
>>>          To avoid races, it is arguably best to get rid of ctx->state.  Since there
>>>      are only 2 states, record the API initialization in ctx->features as the
>>>      uppermost bit and remove ctx->state.
>>>
>>> Accidentally broke the documented two-step handshake in the man page where we
>>> can avoid closing + reopening the fd?
>>
>> I agree the code is not correct (and my patch didn’t address this issue),
>> but I don’t see it broke it either.
>>
>> Unless I’m missing something the code before my patch, when
>> uffdio_api.features == 0, also set ctx->state to UFFD_STATE_RUNNING, which
>> meant another invocation would see (ctx->state != UFFD_STATE_WAIT_API) and
>> fail.
> 
> You might be right, I only checked the cmpxchg, assuming it was working
> before that.
> 
> ... but staring at the history of the "ctx->state =
> UFFD_STATE_RUNNING;", I am not sure if it ever behaved that way.
> 
> Do maybe, the man page is simply wrong (although I wonder why that case
> was described that detailed)

The man page was updated with

commit db3d5cc1a17b0ace008ebe1eaf0ac4d96b4b519a
Author: Axel Rasmussen <axelrasmussen@google.com>
Date:   Tue Oct 3 12:45:44 2023 -0700

     ioctl_userfaultfd.2: Correct and update UFFDIO_API ioctl error codes
     
     First, it is not correct that repeated UFFDIO_API calls result in
     EINVAL.  This is true *if both calls enable features*, but in the case
     where we're doing a two-step feature detection handshake, the kernel
     explicitly expects 2 calls (one with no features set).  So, correct this
     description.
     
     Then, some new error cases have been added to the kernel recently, and
     the man page wasn't updated to note these.  So, add in descriptions of
     these new error cases.

@Axel, did you ignore the automatically-set UFFD_FEATURE_INITIALIZED and the
repeated calls never worked, or was there actually a time where repeated
UFFDIO_API calls would not result in EINVAL?

-- 
Cheers,

David / dhildenb


