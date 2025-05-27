Return-Path: <linux-kselftest+bounces-33853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682BEAC4EB9
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 14:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB8BB7A2FD0
	for <lists+linux-kselftest@lfdr.de>; Tue, 27 May 2025 12:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB86426B970;
	Tue, 27 May 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XzZrfuJK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231CE269CF6
	for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 12:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748349247; cv=none; b=Rh/SycK99pBbM4Xg/MeFOoDFmnUWzsTjVuutF4r43DiNxHMO2BjXDqPsq93Slj9+XsO58ysy5KQbY6oo+yvofl9Xpt0mHNGjK2CyJLNMhmRBGZekmv6ntFdw5qOJui2qjviTPvW4pMs+GxxIHUHssoloOFo9tUTsEVXk3ZOnekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748349247; c=relaxed/simple;
	bh=GLQStpasjWjcjHZcmyqLKGTR//tmYDzkkLnTWed5tk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ms4+AjX5/ER+Isaj2Vp+uwsMFFth6+Tg+Vgmo3TGWRhuytNdkxuQRDOOAJhgKlT+OQTdk5JGII1UVLZG4VL7IQOqXecs1KEgi1ACYCRVpNmpqB3C4ozuHTe50dOpgvZGhK9p6cYX6wwHHBEP3mxNqQr0aQ+Pg0gc8t/VTo9p4+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XzZrfuJK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748349245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fmrg7Mz/N3KeXGspKAhAFZUUGtopHb5QnF04/Cn8Fgo=;
	b=XzZrfuJKubyOCcSb2CIBneX5L9KZmopg+ybVDpow1aDr0DHI22ASYiJ6bbRcGk/J7VXLDW
	yho+2eZzmt10qjUHT8wCD4RFUQkXUUtj+jVKr22kUoHBrICWaikVrPzHnfMoFVDorP0hkb
	vuObQdBQlwp7X2txz5TGhsvAYXKoveQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-FSumMYveNUeEs3uy2vCsgw-1; Tue, 27 May 2025 08:34:03 -0400
X-MC-Unique: FSumMYveNUeEs3uy2vCsgw-1
X-Mimecast-MFC-AGG-ID: FSumMYveNUeEs3uy2vCsgw_1748349242
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a34f19c977so1564842f8f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 27 May 2025 05:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748349242; x=1748954042;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fmrg7Mz/N3KeXGspKAhAFZUUGtopHb5QnF04/Cn8Fgo=;
        b=LcKdWmOXUObPDkCBHXPYSantytGngDk6/sw3Ct3LFHdPR9DTNY7e4QtP7/3DMkz/2N
         qeoimMX2rYn0apTXsytiDcZgwIAhxT1ptPtY35i+dUNgzaDLxruKEs7at3ET0rZGms5t
         2BfhYYj3eYlxmsw/CGMUbfiRKZXPQmCOqt07oR0kn6mtLwi3JQBeT67CXp0s4I8q8OL5
         UJfDVDPuW9PiiLWQUqFw75o8cv2yYt0nr8cXplXed+enQzJnMHE9zzUpQ66S4p+SPDz3
         7M5qsksTOTRJSYqHVk96u4p7jyBIa8FhGkDHyiZhiQr9Lh6xMbRqtVvV+8AXSbT9jXIs
         f+UA==
X-Forwarded-Encrypted: i=1; AJvYcCUgtJclFL0a3WeKqx4JP6YwRDFqLNxagMtoH89zibLl18FsRQJpKMyn2dCciUVqm+lCANV7YsbisvorkB8hfZw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1eznimGCLxhUDlx9BP+t932E7p0czau7jJEcEYN7k6n6WYMIM
	FG1oCV4hqfgoMEgWTdRAJYGmAkVOvVwgg2eVQoaF6lVO8YdovY84ZHRlmiI/ZSPaTuP0D4OP6+8
	9EhnKhUEZbKW3b4Mn2ne6n3Z9y+4IfWvK1atz7bhShh9hl+IQlFNmRw8AIruSQOKB/yitJMY5g3
	mUpng/
X-Gm-Gg: ASbGncsFvsumEcx7uXrl2hwktyJl0l+8vLJtIPJfZvMuMnjD6Fe6gxuBnVWAPXHbOa4
	BzO5YS3pbCtRXBmyXoo1bl0/OxW4RZ+7e7mjeETC+hFJnAxq3coFmfnY0Bzfpmtg+o7U/jx0W4X
	fVFqVqcHe2r8hzEimrHNP91M1gdswCX+xBZxWOGRgKhrAPPqRx7fnPTUdJ0UyJyMzbjSvgU2Efw
	+ze/61JrWSXl/Sj9NVM51f3+P7oYZ02z50YoB5f2XDCHA1I/z9rfDf9um4AgQWQaUAbLElwcLYI
	v+wVlJGt50JuDU/TapRYTLbVbQDfq7mdSxGFKafEjJ8B
X-Received: by 2002:a05:6000:420f:b0:3a4:de01:ff2b with SMTP id ffacd0b85a97d-3a4e5e6a7b5mr458469f8f.14.1748349242377;
        Tue, 27 May 2025 05:34:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHr+vEguSUIbqkCO4UypZwqDkKUDtCMMZ7AuyroOQyF+VP5SsKVEWUO8txTvaZseEvvbOBaGQ==
X-Received: by 2002:a05:6000:420f:b0:3a4:de01:ff2b with SMTP id ffacd0b85a97d-3a4e5e6a7b5mr458439f8f.14.1748349241987;
        Tue, 27 May 2025 05:34:01 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d2a7a317sm8125988f8f.24.2025.05.27.05.34.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 May 2025 05:34:01 -0700 (PDT)
Message-ID: <0f09b648-bf0e-4b7a-99ef-a7a42cb20054@redhat.com>
Date: Tue, 27 May 2025 14:34:00 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] selftests/mm: Use standard ksft_finished() in cow and
 gup_longterm
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250522-selftests-mm-cow-dedupe-v1-0-713cee2fdd6d@kernel.org>
 <20250522-selftests-mm-cow-dedupe-v1-1-713cee2fdd6d@kernel.org>
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
In-Reply-To: <20250522-selftests-mm-cow-dedupe-v1-1-713cee2fdd6d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.25 19:38, Mark Brown wrote:
> The cow and gup_longterm test programs open code something that looks a
> lot like the standard ksft_finished() helper to summarise the test
> results and provide an exit code, convert to use ksft_finished().
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


