Return-Path: <linux-kselftest+bounces-11315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8B88FF675
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 23:09:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39628288A11
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 21:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6478B78C96;
	Thu,  6 Jun 2024 21:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1LtSPOY"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFE3482E9
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Jun 2024 21:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717708152; cv=none; b=d0IToZZzaZew/moJUbC9+qrh0EpIuvyXryG3q2GnoYrQLrVhpRnmjhZ44YYxSF2mcKKxHHLq7MzVOOSdBqVNzYX3Dh9gi/gLAHr9V3VZI3UesMcDU3AEqR66D96kkM2fL0YGYOvL+YdsrDG5u2Lz/diPkoET0a5ftbj7CwG9mHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717708152; c=relaxed/simple;
	bh=vd72+i9IOop1WRsgQ7GOfVXd9Qn8aVpm6W5TlvVlchI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UegwsGr3keBs1HOv6yDqxfoLFP4XxYVfkHlX9ovVjB1Lzi8ivpQzORUrrGauZVTZLU3nSkXFIC/OTglrY2kjBxYq0o3DZL5ZfK4iD+JdyVWafgIGbugZN7+490Yx4cCOKF8L1Svn2KXkajcIOMS4Z8lfxfJKf9Q0wpkuahs+gW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1LtSPOY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717708149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0d9wa2tUiLeydTsK/bRiFAun7s9SzD56w8Sh96B9vMc=;
	b=f1LtSPOYD6MdF9sDtMOWwj/TvEhbBz+G2l9kR3kED9Msk8jDDu3hOOucWZItAnM3M0mm0n
	OFCtDKRCK92rVP67u0Zx/gFp34SnByXh2Pi6aQntmMxOcUcPj2Z9v9EnsRpfKAUOe5rA+5
	JZfQ8SyYF4kauKmvow1/snylEHkKZ00=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-352-zE9KxF-WMy2Yz7gI4l1cCg-1; Thu, 06 Jun 2024 17:09:07 -0400
X-MC-Unique: zE9KxF-WMy2Yz7gI4l1cCg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35e0f445846so1005086f8f.0
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jun 2024 14:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717708146; x=1718312946;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0d9wa2tUiLeydTsK/bRiFAun7s9SzD56w8Sh96B9vMc=;
        b=L9kqLkHVNtB+dna5/yti7sg7nGcuCp5GICsAhun8U2Xf9hXLcM1A9QfR+Intz+fJk8
         1Ywyr8XaNtpMFM20+HFripYp44iTr6BfFjGhMLzOVWYYgn98Ijgr0Qrg0QCUORaZ4RdH
         o4spu6a/Hnhem0Iu7+0RsXh0rfUQlFB6En0ziORcNagzQ1eacFvCuOUwrXqGzR/6L2Id
         XRGOtpQ/CCFQqeZUy5cmLOIlJXsh3PUojMAq861PumxQyh9+WZvQ5ePsoDpuHt6zAJsK
         S/beCH0zA4hNdrdJ4JGf4Omieu20npoVocQY9lO2bzjqHA2HRtF3+SiY/+vhsYPJi25O
         S5Rw==
X-Forwarded-Encrypted: i=1; AJvYcCVBCr2F66DfKKkWp0LxA5XCqAAVO/P8XygXOd3Wu8NMDs2dEfa5MJU/y7FOg0RHtnGT8eVTFTVBu1Z6NsmBZZn28pNR1jkp0VzHFI4vSZzG
X-Gm-Message-State: AOJu0YzQAva99V+gXTU3Q2vqxLd9UkgLhsKgB05IYuKM9YmK0AndWoTz
	TrRa0uqxPEDQys383zOhWG97SnA+YjooDmszf16tSY2cpOTz3FzNujUtM/qpNDN5FvQkfnW+18k
	WBFqUGHK8wfOm6l9MubDgBWDL0GDRnzdtdpaJVj5zm3R7FtSwaxc8xEXYH3xnhJ4AYA==
X-Received: by 2002:a5d:4382:0:b0:35e:7cde:6555 with SMTP id ffacd0b85a97d-35efedf8ab7mr528909f8f.65.1717708146237;
        Thu, 06 Jun 2024 14:09:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4+2TuwNzjexYtTZSUr13zN4OhgjkBZspp7z35TrgrdwM7A/PUXN8U8HCWrnKSy7NPEcsvMQ==
X-Received: by 2002:a5d:4382:0:b0:35e:7cde:6555 with SMTP id ffacd0b85a97d-35efedf8ab7mr528897f8f.65.1717708145796;
        Thu, 06 Jun 2024 14:09:05 -0700 (PDT)
Received: from [192.168.3.108] (p4ff23231.dip0.t-ipconnect.de. [79.242.50.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35ef5fc11e9sm2443792f8f.93.2024.06.06.14.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 14:09:05 -0700 (PDT)
Message-ID: <172b608c-ce59-4096-b5b0-d403eb772c85@redhat.com>
Date: Thu, 6 Jun 2024 23:09:04 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] selftests/mm: use asm volatile to not optimize mmap
 read variable
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, gost.dev@samsung.com, willy@infradead.org,
 mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zi Yan <zi.yan@sent.com>,
 Pankaj Raghav <p.raghav@samsung.com>
References: <20240606203619.677276-1-kernel@pankajraghav.com>
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
In-Reply-To: <20240606203619.677276-1-kernel@pankajraghav.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 22:36, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> create_pagecache_thp_and_fd() in split_huge_page_test.c used the
> variable dummy to perform mmap read.
> 
> However, this test was skipped even on XFS which has large folio
> support. The issue was compiler (gcc 13.2.0) was optimizing out the
> dummy variable, therefore, not creating huge page in the page cache.
> 
> Use asm volatile() trick to force the compiler not to optimize out
> the loop where we read from the mmaped addr. This is similar to what is
> being done in other tests (cow.c, etc)
> 
> As the variable is now used in the asm statement, remove the unused
> attribute.
> 
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
> Changes since v2:
> - Use the asm volatile trick to force the compiler to not optimize the
>    read into dummy variable. (David)
> 
>   tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index d3c7f5fb3e7b..e5e8dafc9d94 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>   		char **addr)
>   {
>   	size_t i;
> -	int __attribute__((unused)) dummy = 0;
> +	int dummy = 0;
>   
>   	srand(time(NULL));
>   
> @@ -341,6 +341,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>   
>   	for (size_t i = 0; i < fd_size; i++)
>   		dummy += *(*addr + i);
> +	asm volatile("" : "+r" (dummy));
>   
>   	if (!check_huge_file(*addr, fd_size / pmd_pagesize, pmd_pagesize)) {
>   		ksft_print_msg("No large pagecache folio generated, please provide a filesystem supporting large folio\n");
> 
> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd

Acked-by: David Hildenbrand <david@redhat.com>

I was wondering if we should factor that out into a mm-selftest helper 
function, but that can be done later.

-- 
Cheers,

David / dhildenb


