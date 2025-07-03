Return-Path: <linux-kselftest+bounces-36400-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B3BAF6C5A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 10:03:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 990221888C6A
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jul 2025 08:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9011C28DEF0;
	Thu,  3 Jul 2025 08:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hid5h7Zo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BDC2989B2
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Jul 2025 08:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751529789; cv=none; b=nYlnYTFBIpyjdRC5MDUbySjWvzaL8mgdTMTcPtAurUSqS8pl65AOe+P8sr8S39REy9j3zFHtZGihg21ZbwkNuEXyHUt4FuWLArNIyviWRBSDfvC3G9SdYwB8bmnRUxXS86f5Fl/9mBBARgWpL/5J5pfSuv/e+lp8JB/CanpeoLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751529789; c=relaxed/simple;
	bh=2hIcxknYvwGEoobgwAOn7Jc5kfjLqpyk1kwt89ajjF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=koG4liBtqVBzgVuaW3TMYvDrOoEFkk9VrzeOg1/VqZK07g0RE65glcJnSmtcsnuvvh6AyEa+dWCR9dsnNcLASFC0W/ZCCwtmqkVwjarKn1BKpoNEkNTJnvMwyqnyvDVj3Jh0Ios8257Vt/bg5HrwwmCWRn1A8h1W5qAArtL8SzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hid5h7Zo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751529786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rU5Offe+0rSj19APlLiLOhHgLRiJXDUZDGfkGR8DMfM=;
	b=Hid5h7Zofu1MijQvdZD0TNjcf+GCNV4pam3CsL66iNJ5JQ+YBuKH1o6SHcwQR9J/kWIq+p
	Iq/026i5+73h6CWYrNYMEFWPSkeh2HReMt2yXGJpPjVZZnneym/+Da9peyRvZmiF6V+0cW
	AMVCEdz1la9iR5KSEqe0kXD0kz/+trU=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-2vsPDC3gP9WW_rjaOK-Ltw-1; Thu, 03 Jul 2025 04:03:05 -0400
X-MC-Unique: 2vsPDC3gP9WW_rjaOK-Ltw-1
X-Mimecast-MFC-AGG-ID: 2vsPDC3gP9WW_rjaOK-Ltw_1751529784
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-ae354979e7aso379183966b.0
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jul 2025 01:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751529784; x=1752134584;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rU5Offe+0rSj19APlLiLOhHgLRiJXDUZDGfkGR8DMfM=;
        b=Th6npD3NajRNgpvkiODoTLMWIUDPagnHXrxdeIaolkieNyFYtknk1ifjCl7XEJy16l
         gB6DUkonTymZrBVE3PW0D6O5w08MlutplRKIS8jGwUiUcrrexip6QuovDEoTScQ9icXN
         vGHEUWfDVNW0iUsWsVIlHb+xPx/hdwH6JWL12NXS3dtPdTn7p0MefKDKgg3W9sIqAm3r
         1LGQChiyy0h1rb4+ktEhPOWdLWjXnZmMmxKM42p7HDyKHT8JTu4irYr26n8GmTo0inR1
         48AyS/O3n2px6Tb9jGSt5Fv+jtZ5sekjVAZLp5Cf7tGo2spdxlClK6z2R22zCxaKj/Ja
         tYWg==
X-Forwarded-Encrypted: i=1; AJvYcCXbAjORKbESmDC6YyZkNgqQ2P884edT34yy5MeZzVHaoYfmZME5JuZEIxQBuDWSF0VVwYKZkMiXbNSlnFSjlqc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLD1feDLms3YGtl1W+jEfbLx2tfZiG+15wf/8ynM/nXpcJDcwC
	E0Z/ek8lec8ynbQrLodngjaXN2xUE/UqTWVV6ivhDiv3Zaa1/R//GqN49DaY7t6Aa4/L/bQIbM3
	v9bk+0QwWhQU6aK94fkx8L/D5aOay1IznEO/GmsEuKnj8Roa2vyihwE5vsObyI5GrpUGPVQ==
X-Gm-Gg: ASbGnctZwgf7ynfqfDWDmTcbVXSR2hdXolItkw8vw90L1/M0Ji+lvKfZ4ZD3or9jp1j
	ae+dj9J+zo/yeizlAzr9BPcz4PANxNhxET3vevG0psK22Iy75VHatEb9yStC2KTrzjUv8TgpjsY
	JuGt/x8LmVGuhMAd17YvWm5d4sleg4v0vflj0zZMhghDvk8LpmcVHUNmoM5AlSEPSQgBOK/GNqi
	ujHR3iPXEzf0vxxpGof5UcxLewLhvL5cXsaA52zGpb/vh130s/Vaj28WkDN0DRsXA/szsVeDXPN
	wfyGuOsW+yFOo827/DRrFYw/1PMbfm/xBUvDoa5aiIUs
X-Received: by 2002:a17:907:930a:b0:adf:7740:9284 with SMTP id a640c23a62f3a-ae3d8b956ecmr238112666b.57.1751529783992;
        Thu, 03 Jul 2025 01:03:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHN+d3U8Q/iQsyL2MRs8lXfAMehX7tLoN1mBKlzYUA4dzhVi2aypXBlEYkxHUC75seobjJ6gQ==
X-Received: by 2002:a17:907:930a:b0:adf:7740:9284 with SMTP id a640c23a62f3a-ae3d8b956ecmr238104766b.57.1751529783091;
        Thu, 03 Jul 2025 01:03:03 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae353c6b448sm1203266966b.127.2025.07.03.01.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 01:03:02 -0700 (PDT)
Message-ID: <adcdaa67-9eb4-47a8-86dd-56ccae0dd99b@redhat.com>
Date: Thu, 3 Jul 2025 10:03:01 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/7] mm/selftests: Fix incorrect pointer being passed
 to mark_range()
To: Aboorva Devarajan <aboorvad@linux.ibm.com>, akpm@linux-foundation.org,
 Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, shuah@kernel.org,
 pfalcato@suse.de, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, donettom@linux.ibm.com, ritesh.list@gmail.com
References: <20250703060656.54345-1-aboorvad@linux.ibm.com>
 <20250703060656.54345-2-aboorvad@linux.ibm.com>
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
In-Reply-To: <20250703060656.54345-2-aboorvad@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.07.25 08:06, Aboorva Devarajan wrote:
> From: Donet Tom <donettom@linux.ibm.com>
> 
> In main(), the high address is stored in hptr, but for mark_range(),
> the address passed is ptr, not hptr. Fixed this by changing ptr[i] to
> hptr[i] in mark_range() function call.
> 
> Fixes: b2a79f62133a ("selftests/mm: virtual_address_range: unmap chunks after validation")
> Signed-off-by: Donet Tom <donettom@linux.ibm.com>
> Signed-off-by: Aboorva Devarajan <aboorvad@linux.ibm.com>
> ---
>   tools/testing/selftests/mm/virtual_address_range.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/virtual_address_range.c b/tools/testing/selftests/mm/virtual_address_range.c
> index 169dbd692bf5..e24c36a39f22 100644
> --- a/tools/testing/selftests/mm/virtual_address_range.c
> +++ b/tools/testing/selftests/mm/virtual_address_range.c
> @@ -227,7 +227,7 @@ int main(int argc, char *argv[])
>   		if (hptr[i] == MAP_FAILED)
>   			break;
>   
> -		mark_range(ptr[i], MAP_CHUNK_SIZE);
> +		mark_range(hptr[i], MAP_CHUNK_SIZE);
>   		validate_addr(hptr[i], 1);
>   	}
>   	hchunks = i;

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


