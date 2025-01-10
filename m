Return-Path: <linux-kselftest+bounces-24219-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BCBA0960D
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 16:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE4DC16B1D5
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Jan 2025 15:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3266212B0C;
	Fri, 10 Jan 2025 15:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fBaOYBwL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DA7211A3F
	for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 15:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736523674; cv=none; b=tc55X+uCjVa4mXWQ6gX2U1pz7+yMl4pPZAUC88FZ13e8oGEfTxWtbdreP8k5mLtpC/BPZ8jASGK4Wg3NLWGX0wLHTNz1UNjeS+AGpvQylmgXCJHc81KIDctuS5yxCP0KoVNY67ytl3AS+GTCT3jPz3hCXvBErr+vsXFke9ilSCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736523674; c=relaxed/simple;
	bh=Y0JfIGgZQSFdjMecb+H9yvyI/+E54IzeewgGziw+bkM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q7gkS3+fhf7oJwenJ7FyOyABh3QI6QXkBdnMKC67a0XPr6RPspZINyUJP9SyD/+tcyPE2nB5HRG+bjeV1yusavRnCh/zLy1a2SE1SNN6dB3CEWfH8FSpfi/e1UEFWarc5MOw6HGNn0tI8mAt6K5QxrqHntX5oyJrahsRjtBo9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fBaOYBwL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736523672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5yIGkbqejGa8BA3qWHg1c28D6Q7b3/Kgi7rVuOzpup4=;
	b=fBaOYBwLtWF9ICuZEylqOpKaOz2DNrR+k3ZKPCtO09waSiu4JfZJH3Fk//AZyvmdkN4THN
	Dllej66E1F59NlPBNQDiSQdOrFO5ijxsXq4x+JJJo9MkqVMSfkL+axd/7q8D6n7MolDykv
	5eiTU/Zdw3TFWqxUPOJSmkbIsn6/KkE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-SNXbXYkyNPyTesv9-D8qFw-1; Fri, 10 Jan 2025 10:41:07 -0500
X-MC-Unique: SNXbXYkyNPyTesv9-D8qFw-1
X-Mimecast-MFC-AGG-ID: SNXbXYkyNPyTesv9-D8qFw
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-385d52591d6so995517f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 10 Jan 2025 07:41:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736523666; x=1737128466;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5yIGkbqejGa8BA3qWHg1c28D6Q7b3/Kgi7rVuOzpup4=;
        b=sXbdrJQm6pfKk9HUkyvDTu3KaFJMxeXHiFJcoFpp98G29HL9V7HF/P1COuqaX1hhRg
         3b93JuuuRga1Rluhb20gJeIvM6opBCOyOO5bATpbhZaWIj0vu8CRnBRBEovo6dTDpu0W
         oxtJytGYCp9pCg57rO0COoCtEszWAuSZpxoNxLSpjiuXuRe9aBa+rk4PhUE+M7QsOqg/
         IthVG8FGinssmHrsDUyxD/Mr6kaaQMXaGMlL+F2HEfzKBhib72dujKmUsxKXjxDGdJRS
         tk0TtMoXLn3TWti/ALbNNcmMutDUeDp8wtYosorsGl4OWKVxPONgMTDFaZpAbV8eFUot
         bpYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIZwOo6w15+Yk+/7PPfXHXoRDzERGtInEX7QSYs1avxDSw2b23JZiYcIYXXpmn3NEStMnqktXR/vM2l713to0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfHuGnDyb/jjtI78IB1Pzp1R3K/5hHwS7pu4UQa+fam2LG1BF2
	W9V7KKQvyP2mb4j3UM4ilYqQ7HHJDSGthhaVjz0CwJnDFH8sxPpuaVhSmNyUyMTUe4O6OPdRlzA
	tN0i58kmxvGATUW9RMGhIQxp6rlx8kNy3O6oE0RjvHmGqgwiyWU6vqepKBI3pDKgg6w==
X-Gm-Gg: ASbGncu8hR5YA1vbLVFEv1ALS4YJYNBB1+JztyO4PByy+u5NZfdDDnphi8HA56JhKIs
	sPn8g8TzmcCjyYk7ujWonZMdv8jhHrrVNVVE8tnDRfzlSri+rSVBdpNpQV/JsQ5km6a+FOgbNSM
	dv7M20waFmAyUmCjNVZii1YR6qlV8myYojD/W6+htLeNaNEVUPePoDTabAXxgZzwVuIKp/AvjbI
	ayi01OHbhBPeMR6Vilfagzuqu2HWvW5oI0pQtKhOK4kr2GhnFJYHvrDbF8aLZvrFNH6/VoAbb37
	WtMyb+92rUYHkyEpK855Ba1xhnbX/UMZQt5sIx6WneMHWNjy20Nc5IjjulDQ/6cXchtvFoqWCIh
	j7b5Eq2/m
X-Received: by 2002:a5d:59a9:0:b0:386:3958:2ec5 with SMTP id ffacd0b85a97d-38a8b0faaccmr6028344f8f.28.1736523666441;
        Fri, 10 Jan 2025 07:41:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbc+g5+K7U7vbcDG96TnJZxZ4Dqa0b827MQwcuborGfLRGxzbaFboDvSK88tGlqBSpB21X/A==
X-Received: by 2002:a5d:59a9:0:b0:386:3958:2ec5 with SMTP id ffacd0b85a97d-38a8b0faaccmr6028320f8f.28.1736523666088;
        Fri, 10 Jan 2025 07:41:06 -0800 (PST)
Received: from ?IPV6:2003:cb:c708:e100:4f41:ff29:a59f:8c7a? (p200300cbc708e1004f41ff29a59f8c7a.dip0.t-ipconnect.de. [2003:cb:c708:e100:4f41:ff29:a59f:8c7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436dcc8ddddsm79915705e9.0.2025.01.10.07.41.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jan 2025 07:41:04 -0800 (PST)
Message-ID: <9243dd8e-3f03-4ed5-bdcf-95c947c57849@redhat.com>
Date: Fri, 10 Jan 2025 16:41:03 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] selftests/mm: virtual_address_range: Avoid reading
 VVAR mappings
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Dev Jain <dev.jain@arm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
References: <20250110-virtual_address_range-tests-v2-0-262a2bf3c3d0@linutronix.de>
 <20250110-virtual_address_range-tests-v2-3-262a2bf3c3d0@linutronix.de>
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
In-Reply-To: <20250110-virtual_address_range-tests-v2-3-262a2bf3c3d0@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.01.25 14:05, Thomas Weißschuh wrote:
> The virtual_address_range selftest reads from the start of each mapping
> listed in /proc/self/maps.
> However not all mappings are valid to be arbitrarily accessed.
> For example the vvar data used for virtual clocks on x86 [vvar_vclock]
> can only be accessed if 1) the kernel configuration enables virtual
> clocks and 2) the hypervisor provided the data for it.
> Only the VDSO itself has the necessary information to know this.
> Since commit e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
> the virtual clock data was split out into its own mapping, leading
> to EFAULT from read() during the validation.
> 
> Skip the various vvar mappings in virtual_address_range to avoid the issue.
> 
> Fixes: e93d2521b27f ("x86/vdso: Split virtual clock pages into dedicated mapping")
> Fixes: 010409649885 ("selftests/mm: confirm VA exhaustion without reliance on correctness of mmap()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202412271148.2656e485-lkp@intel.com
> Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 4fc1c21a5e218eaec4d059b75c31a21dd4e8a215..993990aba56fc986c42084ffa91973558aa07e87 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -152,6 +152,10 @@ static int validate_complete_va_space(void)
>   		if (prot[0] != 'r')
>   			continue;
>   
> +		/* Only the VDSO can know if a VVAR mapping is really readable */
> +		if (vma_name && !strncmp(vma_name, "[vvar", 5))
> +			continue;

I'm wondering if there is a more generic way ... but likely not when 
staring at /proc/self/maps.

/proc/self/smaps would indicate this as

VM_IO: "io"
VM_DONTDUMP: "dd"
VM_PFNMAP: "pf"

Especially checking for VM_IO sounds reasonable ...

-- 
Cheers,

David / dhildenb


