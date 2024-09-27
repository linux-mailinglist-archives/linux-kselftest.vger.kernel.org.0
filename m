Return-Path: <linux-kselftest+bounces-18468-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6409988420
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 14:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1242814DF
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C978618BC1C;
	Fri, 27 Sep 2024 12:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMnMmPVC"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2805F1779BD
	for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 12:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727439846; cv=none; b=fUX99eYDUD/eQ45ilCmS4S+nzpQnUUUmgMbXlVI/ubCrxvHdgFulHzJYrW8iOzOhnxTwT3vnWk5NP2OugR7opWHlol4XcAX1CAo8OINdRNQMr21e1w3gegfboynydWsmBgCzAMZDnY+5WTnmxEb26BlZQciHTs/csTMXRwhK1EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727439846; c=relaxed/simple;
	bh=5VuviB8DRyOt//s3opc9BHk1L7AlQ59EBBLa9N7Wmtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MdA4aqU4UBgJSfjtbAQ/dHa5CmPT94DrPF19Lg9RaF6T7ODzzxiaBVnsKic/+OcPHguT4W5/ciZoJQI3Qka5vIs2dz3sXnCrFwtbI87tREKUgwyotKO9FAYhoGKgYyCf/qGGhxhmLP3fP8DzbB7IiKRZhTVfmwmJyBLDzEbNv1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NMnMmPVC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727439844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rOO/RMJMndVoVeK71fgXzYzz13o8AL6/Nz/3/wUYT4k=;
	b=NMnMmPVCSWFkviPXAPLUP8BlmPVKKdIV/ElGoWDby65tSjovxmoPM7m35Yw9pJRdql6wcC
	OS/xqEBsZchhi40/+Z7x2LmFIeNAGNxyJK4d7LEDBe9A0hE3Zuz7wBZnhNA10fdb8/bADU
	azWx61ug6t+YQIZrkiHWtLRDXOh0I54=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-6R0V__-vP9CLYGrcLK7Akw-1; Fri, 27 Sep 2024 08:24:03 -0400
X-MC-Unique: 6R0V__-vP9CLYGrcLK7Akw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-378929f1a4eso1242361f8f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2024 05:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727439842; x=1728044642;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rOO/RMJMndVoVeK71fgXzYzz13o8AL6/Nz/3/wUYT4k=;
        b=HlMJ7ucUlI4wUtPO1oEeWG9iFyxuNyDgZtx4RoaTFdWFJXEZyksnhrIIaDl/p6qWzy
         IZr+aiXnnH0BlgIlxBmZ+i/3JhExGy+Nt0xxx8V8g2fmFFSDyImpJc1Ri1HgOEIU6qmn
         JnIIGd/e/PRKD27VfzN2jr0GPMIXFEUmYDmp9AqV1s6jnAePWMGhAa2YpeA8QSSEZDaz
         0wLNoGsEyUOzOkQfEhaALneM8GooMNt7VCwPe0kTBSM4zad6LT5MtTscTQXt/SBWShXj
         JSmxNLlpffjRLO2udLI9QtzGR1K4KBE8ELODO6qZ+uaoCATwgB6u8otpwkrWJ5Xu1fX4
         joqw==
X-Forwarded-Encrypted: i=1; AJvYcCXk3mgtbTSz2jVclcxViFDPMiCpBXCOsKRVsnbm30iYK/mw2aQ1bo+mN68CNtaojLY6AQjkdlnzuNnlcqrrnsg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbXry9xbw61aHJyncM6cOVudhMZrAkuAxPN+f0Pvf7bTrCc/Kn
	iZWysNDEgPLNJ4oOsTr9y8zOmzB34cZeKqVsPjDEMhZn+bmVIZWejg8OlG3MtxVx3O95b3/M33s
	E0shUdlO6m/8yQe8KBOcZGcGnwl8b5OzRiVKZQD5weJ0uXtweq0iqazk+ZbE4joJRkQ==
X-Received: by 2002:a05:6000:114a:b0:374:c8e5:d56a with SMTP id ffacd0b85a97d-37cd5b292a5mr2156776f8f.48.1727439841705;
        Fri, 27 Sep 2024 05:24:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMdCrEL1EFKHWG5H8TyNvUQTkzVSw/bWL4thDMZuabh4Ub793nN7dXmSmqfZoWUw/tqASgiA==
X-Received: by 2002:a05:6000:114a:b0:374:c8e5:d56a with SMTP id ffacd0b85a97d-37cd5b292a5mr2156751f8f.48.1727439841270;
        Fri, 27 Sep 2024 05:24:01 -0700 (PDT)
Received: from ?IPV6:2003:cb:c709:8000:b502:8c1c:3624:99d4? (p200300cbc7098000b5028c1c362499d4.dip0.t-ipconnect.de. [2003:cb:c709:8000:b502:8c1c:3624:99d4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a52915sm73471995e9.39.2024.09.27.05.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 05:24:00 -0700 (PDT)
Message-ID: <3ebf7c73-a575-4add-aca9-fb5079663ba4@redhat.com>
Date: Fri, 27 Sep 2024 14:23:59 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Add missing free.
To: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>, akpm@linux-foundation.org
Cc: shuah@kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240927030114.3792-1-zhangjiao2@cmss.chinamobile.com>
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
In-Reply-To: <20240927030114.3792-1-zhangjiao2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 27.09.24 05:01, zhangjiao2 wrote:
> From: zhang jiao <zhangjiao2@cmss.chinamobile.com>
> 
> There is a memory leak in mkdirty, just free src before return.

Now explain to me why we care. The program will return immediately 
afterwards?

-- 
Cheers,

David / dhildenb


