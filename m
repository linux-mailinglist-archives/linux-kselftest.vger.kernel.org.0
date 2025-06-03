Return-Path: <linux-kselftest+bounces-34222-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6A3ACC9CA
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 17:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328523A452B
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Jun 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512FE23BCE2;
	Tue,  3 Jun 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bbv35p9L"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830BE238C27
	for <linux-kselftest@vger.kernel.org>; Tue,  3 Jun 2025 15:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748963187; cv=none; b=IJ7+P2xJLm5nRWWnSRdbU9dUZ3l8YC3F04HTvNstrv0r/PNhiC//m7V2xxN4exk00GQq8F8C7D1QMW0LDo1eDaW4YfUEfC66gA6jNOR2t88BkmFjz8wxvbNL140ut9HS5E6wawla1eXjts4ED99++HP0TbFMas/7ObEfggJVgzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748963187; c=relaxed/simple;
	bh=Seyjc5vTxL1mkB7rjyOKB6ScVF1DZNG6ib5bKFof+bM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MHaBHesX9F0Yo0r6l2I6pBUvDAVEnZi+68KDljMSIOsRBTQr+UHHLv9gHeYxkumt/o4qfmcBrwK0bdLEcXQ+isQXvRQ1Yxh2aNC6gRFT38zMZsrREhTVg/lddeKApr7aQ0MmTpWBvRG42N3DOZr/8K1FqHOBbIekCG7nxhxuapg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bbv35p9L; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748963184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=+IDnu3HxZinHnGOlo/4w3jT7mB19VJYiXAiyvOcajjs=;
	b=Bbv35p9LIhVAhms3Ak6+lxy2Tn+AkeFbN6J+kfvZ3m0DrtgXRjKYtsbi+E471fMDFmReB/
	UMxBfxSYJS01AjiSPdBnmMS2Acx4NZP6g1pG8YC1R+FNhh2kWbeWIV8se4HUlmrsMeCE2d
	7nodQXAfnv/MP392qt0cJwPBTEjqwnU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-Zduo0Yu1OZWr2AF5ZUJvLA-1; Tue, 03 Jun 2025 11:06:22 -0400
X-MC-Unique: Zduo0Yu1OZWr2AF5ZUJvLA-1
X-Mimecast-MFC-AGG-ID: Zduo0Yu1OZWr2AF5ZUJvLA_1748963180
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f55ea44dso2526287f8f.1
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 08:06:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748963180; x=1749567980;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+IDnu3HxZinHnGOlo/4w3jT7mB19VJYiXAiyvOcajjs=;
        b=C/YhW4mva6sPfHiIDr+e5WFg5Io/SBSPa3meV7EbWh6N/F1HnY2FY+TWFWy3Z4YMXY
         fLkBYbaJabJ3ztByPMWu8+eW8HV/lfk/Z2XxLVpECkSNdxKhvPC9fsoaGvAYoRoqxABV
         uAHRQRVcebQhcWmmkpdWrOZY8wJNlNIwmICBMlyjkHhSw44gVd9BhyVDFcm5RWgnJHfg
         qlYmb5LOuNjsqIkG+SVgml76Ca0sExYmG9cfwHrqeVRbpwwRSY1HU4hE6XwZf5WC4fqr
         +vtvrXI88gtx+/8OoFpGCsutextho7TBYc8mpJWI3K/NE06JaEKAA/i4f79Zjr5xlU+q
         bn5A==
X-Forwarded-Encrypted: i=1; AJvYcCX+tDg+/JTzmdf85WpF4aTDERcKeIpOowZ79NhLQbfBQt5tDzBtaoxFLlWvu0Tm7lMWNFL835FYna6Eeg+d838=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHSte0L4nuwiTxXN3bBYigXc3SUpRlHLkVMPxpdX+jnpjL5oyG
	d0SDx+vV8ClEFzJ9/a4yJ4EuHZM7Aku0y7dQFivp3zGXVAdtMGxmKHOr+8K2f84boo8zuxPnPv+
	/U8pi2c8tJgxVahUImUGZYE43CTlIYjEB1sQu5ZiugSLS789/UgD1HOIjK0A9OIhP3MeJXQ==
X-Gm-Gg: ASbGncuyFEwsofjFOxLO/lP5v/cGy2/vpdH8HuQdac0b4gUziC8MbIiv/u75RLMuUCU
	N1VFLNGz8hLySh865BP9mcY59EFhIeWEGttbQiBu59DThFY9hl/zYtKcDElDqPu2KNY3R23iIIO
	TaSvkHPsglV63Xcpn8aGzmGZ1Bt9SW92YMEqx5EGBuz0YucW6zvHZ5l8cq8agzhRrEZPqVg6R2/
	jKqai9ZRO3tENqi/u3fJC0bBoAU2bgt3JyMVljJhrH7VTIB6HcjgwdJeFUwOw3Mpy0VF6QsORlu
	3mLzSoE9JSe3Pn9g1OguseOQEjYnomBaeTk6QXOcGQ89OoReFxRgPNC/uaZbfF8aE6l8FqMt+H6
	rWiAjxsHGI1YfT8aXa8ZCCcCsD5TphErtRDnFHejZDDk91ScOcA==
X-Received: by 2002:a05:6000:2511:b0:3a4:f6cc:a8c8 with SMTP id ffacd0b85a97d-3a4fe3a7decmr10116631f8f.51.1748963179708;
        Tue, 03 Jun 2025 08:06:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOWCebAzAqIR1f1Iem5WqF2v6FDj/UiOd99keJ5jx81zJTABKQoXYo+9VaL5cadMRmx4+O3w==
X-Received: by 2002:a05:6000:2511:b0:3a4:f6cc:a8c8 with SMTP id ffacd0b85a97d-3a4fe3a7decmr10116574f8f.51.1748963179132;
        Tue, 03 Jun 2025 08:06:19 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:f000:eec9:2b8d:4913:f32a? (p200300d82f0df000eec92b8d4913f32a.dip0.t-ipconnect.de. [2003:d8:2f0d:f000:eec9:2b8d:4913:f32a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c866sm18866643f8f.32.2025.06.03.08.06.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 08:06:18 -0700 (PDT)
Message-ID: <df85fba8-826f-41fb-8850-077a4e4dd240@redhat.com>
Date: Tue, 3 Jun 2025 17:06:17 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] selftests/mm: Report unique test names for each
 cow test
To: Mark Brown <broonie@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250527-selftests-mm-cow-dedupe-v2-0-ff198df8e38e@kernel.org>
 <20250527-selftests-mm-cow-dedupe-v2-3-ff198df8e38e@kernel.org>
 <c43347ce-433b-498e-bfd7-f09b8e781197@redhat.com>
 <9961082f-848d-43d3-b97d-3df675ca4415@sirena.org.uk>
 <4676a010-a977-4d5a-b42a-edbbea7d356d@redhat.com>
 <e3d584fe-6297-403d-84f3-397a0fe459c5@sirena.org.uk>
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
In-Reply-To: <e3d584fe-6297-403d-84f3-397a0fe459c5@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 03.06.25 16:58, Mark Brown wrote:
> On Tue, Jun 03, 2025 at 04:15:42PM +0200, David Hildenbrand wrote:
>> On 03.06.25 15:21, Mark Brown wrote:
> 
>>>>>     	} else {
>>>>> -		ksft_test_result_fail("Leak from parent into child\n");
> 
>>>> Same here and in other cases below (I probably didn't catch all).
> 
>>>> We should log that somehow to indicate what exactly is going wrong, likely
>>>> using ksft_print_msg().
> 
>>> Can you send a patch with the logging that you think would be clear
>>> please?
>>> I dropped these because they just seemed to be reporting the> overall
>> point of the test, unlike the cases where we ran into some error
>>> during the setup and didn't actually manage to perform the test we were
>>> trying to do.  Perhaps the tests should be renamed.
> 
>> ksft_print_msg("Leak from parent into child");
> 
> Can you send a patch showing when/where you want this printing please?

I'm really busy right now, unfortunately.

> Like I said I suspect the test name is just unclear here...

I would hope we find some mechanical replacement.

E.g.,

ksft_test_result_pass("No leak from parent into child\n");

becomes

ksft_print_msg("No leak from parent into child\n");
log_test_result(KSFT_PASS);

and

ksft_test_result_xfail("Leak from parent into child\n");

becomes

ksft_print_msg("Leak from parent into child\n");
log_test_result(KSFT_FAIL);

-- 
Cheers,

David / dhildenb


