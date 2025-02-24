Return-Path: <linux-kselftest+bounces-27331-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCAFEA4192F
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 10:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8FFC3ADAE4
	for <lists+linux-kselftest@lfdr.de>; Mon, 24 Feb 2025 09:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E7244EA1;
	Mon, 24 Feb 2025 09:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXKLkZzC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B8D23E229
	for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 09:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740389258; cv=none; b=PylLn8bYc9Ompz5hW8k1yAcXDZH/RRgQ3UlTJ9wI9cmkDIHlJY0OAh7UFAfHj024YTAdqnSBvmdm33hmbfj3Nw5glrjSxl67YLoeIMbdk8CiCHhOdFT3Op/mAvcxIL9xfMWvpixsaOW/Ql2zPUX7X2n4xHgUirs6JcfRKS0XiBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740389258; c=relaxed/simple;
	bh=I8ik0VnxEst77sjXmH68GWfeYOl9b9AYZW0gqNH3qq0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M197QYONGtskM2gk/vqawlm29tkPrQLTXxf0Nud/C/EGiWYBXgu7aZls5KQTR5uA5h91y77nkp06jnLtdCLGjYJQ9E0MdevXeuVdO6f5tfk9klMuft0DcF0ESww9qqCXAGFSsS6SUg3au8quLDZ15Dvcz51oNYPJN+U1gqtH1oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXKLkZzC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740389255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7Zn6SZZblvU2KN6afeUfX6cSk2JfetNjQceFn+mshcA=;
	b=cXKLkZzCcrdcFaQAXzz7y2XLVJIixKylM2+nGEj/Zbx1QJcL7FtBWcR5QuK4zW8EskEcgv
	9Dsz7qMPUJ0CZtPwA/ejZxvdsTXE+D4kQtRVaEU09FT0yp4z1/j24l3n0i4Lry3UTYIaVY
	pv78WMyBvy7SkZ/dDoMlo+xnTrE+g24=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-fs84U0o7OOGsQBea1jfBDA-1; Mon, 24 Feb 2025 04:27:32 -0500
X-MC-Unique: fs84U0o7OOGsQBea1jfBDA-1
X-Mimecast-MFC-AGG-ID: fs84U0o7OOGsQBea1jfBDA_1740389251
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38f51a3a833so1586513f8f.2
        for <linux-kselftest@vger.kernel.org>; Mon, 24 Feb 2025 01:27:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740389251; x=1740994051;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7Zn6SZZblvU2KN6afeUfX6cSk2JfetNjQceFn+mshcA=;
        b=rrKwUVkLfUABEzsyNgwFsmpRAogVE8PMOarFLLJr3EEtSs9NDlIBY+X1ZMSBx7aCGM
         H9wt81TE219VdWvDkiaSHcyVv1icYBdVCix0D11X940p+1C/vlgtWMOyon/bg5rCh6MM
         Yj7CQqYmW1Z37jXzhMuK2wqHBx3l2oP9xMf2yUTEiUcZcOUPVnJmU3Dkfqar1kCWLy4b
         fxpmsSQMvZL0pm+QAZGdGq+SUF1qRJOpCju7QSY+5mMeCFD3uaDybJrzYk2o72TfeAwP
         3ThW1li7hc0Z76gMbW9O7LBsQlEt6XVMdEalezh3hHgCrVCX7p7im1byzp/EcSobC370
         ZCcw==
X-Forwarded-Encrypted: i=1; AJvYcCV9X4QypCJfy78d8nChNAOZiNGymNpeXyhkYfY6HmXQBqMHQFq/woAuCJyjfEyXWu9ESHZ2dHL+mbfwqhDy8Y8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRLCAjvPOtM3RC9pxsI0T3mtXatmav+fE/u2h8uqkUpQELMqtX
	ENyejoFe+IGrBX73ats8APIzaFQk30YZ2xb2vp/4+TzlChQJ/SFCC6xqFrMRqDRUO+hW7Y/SFDw
	P7hl0ogvgtSJFkjroKGod/nmjMAWaPpW4feqcxbAaqudoE+TCD1OUKwkMGiJu5FWZcQ==
X-Gm-Gg: ASbGnctB0mYie1UB9exX/72sKDQ2ylIRmRVtdSbaUal3007Zkf+gIwHDGq0I7Eu8PcG
	Ij+hrhDLHito6TkFf72gVYvhokSO5MGb9a2h672n+jwuElRJfvirW2LaXaJJwIrP3GPZcAKyPKz
	8jCuz8ngQlFeCe910iKluu3A9v5o/MYQNB+SX08vhp5quktwlCD6Iu7WVW8ogROSvKzqBO3ziRR
	dN4OilAIC2MHxffPTiKxJ+b4kcMUcW1bnFOQwtIA+m4E7sdb40KE3vhLvWQ3tnv4vxT9dwThv2E
	i4pk08FR1lyxXT4O5W84uTlpFmOWYvgYpYUlhlx+i9Z8STTqUz5le7JPK5xQ+JaoHyWwt3YqQYV
	osE4EcIMwKgBeb5H0oghPyN0lytLu6fGbS3muPwNfIZA=
X-Received: by 2002:a5d:59a7:0:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-38f7082b185mr12874184f8f.38.1740389251247;
        Mon, 24 Feb 2025 01:27:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE5HbPThRylS4ilKU1oY0b9sapnTNZTmqh2oQkysSGqBLm2fMAB+eMOTjT2FNPL02czMER6nQ==
X-Received: by 2002:a5d:59a7:0:b0:38d:e304:7478 with SMTP id ffacd0b85a97d-38f7082b185mr12874144f8f.38.1740389250835;
        Mon, 24 Feb 2025 01:27:30 -0800 (PST)
Received: from ?IPV6:2003:cb:c735:1900:ac8b:7ae5:991f:54fc? (p200300cbc7351900ac8b7ae5991f54fc.dip0.t-ipconnect.de. [2003:cb:c735:1900:ac8b:7ae5:991f:54fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f25a0fa38sm31629174f8f.98.2025.02.24.01.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 01:27:30 -0800 (PST)
Message-ID: <857b2c3f-7be7-44e8-a825-82a7353665fb@redhat.com>
Date: Mon, 24 Feb 2025 10:27:28 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] fs/proc/task_mmu: add guard region bit to pagemap
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kalesh Singh
 <kaleshsingh@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 Juan Yescas <jyescas@google.com>, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org
References: <cover.1740139449.git.lorenzo.stoakes@oracle.com>
 <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
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
In-Reply-To: <521d99c08b975fb06a1e7201e971cc24d68196d1.1740139449.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.25 13:05, Lorenzo Stoakes wrote:
> Currently there is no means by which users can determine whether a given
> page in memory is in fact a guard region, that is having had the
> MADV_GUARD_INSTALL madvise() flag applied to it.
> 
> This is intentional, as to provide this information in VMA metadata would
> contradict the intent of the feature (providing a means to change fault
> behaviour at a page table level rather than a VMA level), and would require
> VMA metadata operations to scan page tables, which is unacceptable.
> 
> In many cases, users have no need to reflect and determine what regions
> have been designated guard regions, as it is the user who has established
> them in the first place.
> 
> But in some instances, such as monitoring software, or software that relies
> upon being able to ascertain the nature of mappings within a remote process
> for instance, it becomes useful to be able to determine which pages have
> the guard region marker applied.
> 
> This patch makes use of an unused pagemap bit (58) to provide this
> information.
> 
> This patch updates the documentation at the same time as making the change
> such that the implementation of the feature and the documentation of it are
> tied together.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---


Acked-by: David Hildenbrand <david@redhat.com>

Something that might be interesting is also extending the PAGEMAP_SCAN 
ioctl.


See do_pagemap_scan().

The benefit here might be that one could effectively search/filter for 
guard regions without copying 64bit per base-page to user space.

But the idea would be to indicate something like PAGE_IS_GUARD_REGION as 
a category when we hit a guard region entry in pagemap_page_category().

(the code is a bit complicated, and I am not sure why we indicate 
PAGE_IS_SWAPPED for non-swap entries, likely wrong ...)

-- 
Cheers,

David / dhildenb


