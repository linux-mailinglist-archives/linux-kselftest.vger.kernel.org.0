Return-Path: <linux-kselftest+bounces-35613-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 396CAAE3D19
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 12:46:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE0E418997EF
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Jun 2025 10:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0244623C4F1;
	Mon, 23 Jun 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fz1hdrnX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EE4230BCC
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 10:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750675385; cv=none; b=mBPbyAbNzhP+2bxw1tvZrVEmFMFJrRe6a2ZK47f/XTUamILYOoydWiQB8EBXmQph5kFXkh5OEZnMjm73WLNv2XWmjOrd+Mzfqp9Got9o7gMnM30WrbIqLX1rlzN38FVNYPOmUku6zgx4zB1IOlCY0RBA57dzRrx2m5lRzj+KXNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750675385; c=relaxed/simple;
	bh=OlZAXP14Dv0Zl/IHjji++X3q07BGRxGZC+h6X0X7Ips=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RsSrZ1EyF2DGLDT5HS5yWX383oKqOl8KfkPUsdXtkXFA/qI+EpCRj5FR+7bql/r3Z0OBQPqGix2rr0UcbnBwLyxqlUPXuxxhXZZuWgPOvMdtVvrqTyhyK1j6d6z1pETrLazLEXMOw1JfuPLjBC8H3csI4odQXAtClmlH3nkQyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fz1hdrnX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750675383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=EyhN9DEsVHNjG6Hkwy+ab647Z7bmmNxvZvKCrwuLQjo=;
	b=fz1hdrnXFX+KIT22RR+JMf5gJnB8wgQX9Y4gl7sYVy85og+ttURJclHrkgc0CW26u2WFBw
	aN6EZ0WoZ3uWDnnSFigDV1CrgntHR34Z1aaG1H0YvyIg5ikL3fh4Jbuv95WaiTvtECGXaM
	Pq66haQ9gxhuUT+EQmd30vLac5hXGmI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-245-ZHOplYTxPtuRW6LgelLXig-1; Mon, 23 Jun 2025 06:42:57 -0400
X-MC-Unique: ZHOplYTxPtuRW6LgelLXig-1
X-Mimecast-MFC-AGG-ID: ZHOplYTxPtuRW6LgelLXig_1750675376
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704cdbso27219835e9.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Jun 2025 03:42:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750675376; x=1751280176;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EyhN9DEsVHNjG6Hkwy+ab647Z7bmmNxvZvKCrwuLQjo=;
        b=gPuh64Tq9xIS4eVR3LMWslZ9wpewbuVy6xhCviZXeS+PzHR+F4F88mmu1n2+KJQKts
         otnaPHQWXe+Hr0+4ULVUg8BRzb4jXqeHghoW/jZpT4H6zqC8Q/qCRLuyXw4I0eYAP4Fx
         qVc5IRUSAkqWW5bUwCDTGQ5lyEj+qpUI0kBGK26339Y3gxcOAoNzlghaxgzTBtHpM+J2
         WL3f/ZM8N+llfc/rDerTOIq+OoaEdib4YnfVexecYh6JEs1UC1rV/c2AZ9zCctTnv3QF
         lKIoS+04h/sLGGdxEkkFmK9RvmPZLVKib42WrLGA6XuEOnOaJrq/HXVMaBV2pFAMeksO
         h6/g==
X-Gm-Message-State: AOJu0YxptGJjXW+kc20grk/VX05w65O4oiHEg/5C4jse1REyHVZVgjPV
	o4B5xqX9NcZ3O4MGRCw0ySDXDMyHlnuRdvivt7PMFLkYskbjH1UmPltkhrxF0AVlEyacjc4wsbd
	GQUXF7Gnyb4VkCioQ9RsFtqI+skKek4jFqJk35uYK5xKi94zRLjyW89teKOFqrh2hwQeyVQ==
X-Gm-Gg: ASbGncu6Hh7OEcRmH6gYTybu2hNhT0q/eOdSZ4Ixy4+hvfW1dtDXf4vvVlmeIfk9qhp
	tJcj4uJpmRglz1pe7LFCz+V9tovBHg8i8bdcfKW3jx5RX4WcnU3h4+NAzvu4zN3tEuBc5cTWXKi
	VQw5c4pd5JWQ0xLjO63xi499pd0ukvilC3uk+dlgxd5pdpcMr4nYvc1Pn9KZSXZO/y0Q6XmPcbc
	IbeqPn2XMtJ/M921NFz0m25+NTz3/1mXv8/PweDE2Z/AihKRJFCNR0Rc4B2NxEGGb2VlbW4IzBR
	kZC7AY4HD6ks0ivA12T2ru28+tXr7qJt9yrm3TLlDBnFt6E8gg3FCjl0LvTAYT7XIGFJnR5Ftqn
	p2q7QQmcRsL+Ve67665peoioue4BqeZJXojjp+9H9xa/6EKPaQA==
X-Received: by 2002:a05:600c:4f05:b0:442:e147:bea7 with SMTP id 5b1f17b1804b1-453659d4e59mr104632465e9.29.1750675375912;
        Mon, 23 Jun 2025 03:42:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVp4l3ubGdwDrXUOnj703CYW4osa1SswIz9bctk4z/HRlYpzl1dcKzi8W4vclU+XTijn44rA==
X-Received: by 2002:a05:600c:4f05:b0:442:e147:bea7 with SMTP id 5b1f17b1804b1-453659d4e59mr104632215e9.29.1750675375489;
        Mon, 23 Jun 2025 03:42:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159? (p200300d82f4efd008e13e3b590c81159.dip0.t-ipconnect.de. [2003:d8:2f4e:fd00:8e13:e3b5:90c8:1159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535eac8e19sm139994395e9.21.2025.06.23.03.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jun 2025 03:42:55 -0700 (PDT)
Message-ID: <65788262-c3c9-4be0-8097-9232febd09c0@redhat.com>
Date: Mon, 23 Jun 2025 12:42:53 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix validate_addr helper
To: Dev Jain <dev.jain@arm.com>, akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 anshuman.khandual@arm.com, ryan.roberts@arm.com, lorenzo.stoakes@oracle.com,
 donettom@linux.ibm.com
References: <20250620111150.50344-1-dev.jain@arm.com>
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
In-Reply-To: <20250620111150.50344-1-dev.jain@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.06.25 13:11, Dev Jain wrote:
> validate_addr() function checks whether the address returned by mmap()
> lies in the low or high VA space, according to whether a high addr hint
> was passed or not. The fix commit mentioned below changed the code in
> such a way that this function will always return failure when passed
> high_addr == 1; addr will be >= HIGH_ADDR_MARK always, we will fall
> down to "if (addr < HIGH_ADDR_MARK)" and return failure. Fix this.
> 
> Fixes: d1d86ce28d0f ("selftests/mm: virtual_address_range: conform to TAP format output")
> Signed-off-by: Dev Jain <dev.jain@arm.com>
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index b380e102b22f..169dbd692bf5 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -77,8 +77,11 @@ static void validate_addr(char *ptr, int high_addr)
>   {
>   	unsigned long addr = (unsigned long) ptr;
>   
> -	if (high_addr && addr < HIGH_ADDR_MARK)
> -		ksft_exit_fail_msg("Bad address %lx\n", addr);
> +	if (high_addr) {
> +		if (addr < HIGH_ADDR_MARK)
> +			ksft_exit_fail_msg("Bad address %lx\n", addr);
> +		return;
> +	}
>   
>   	if (addr > HIGH_ADDR_MARK)
>   		ksft_exit_fail_msg("Bad address %lx\n", addr);

LGTM, the logic corresponds to the way we would handle it pre d1d86ce28d0f

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


