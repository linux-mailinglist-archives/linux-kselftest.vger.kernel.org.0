Return-Path: <linux-kselftest+bounces-33783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D8EAC3FE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 14:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 326D07A2A17
	for <lists+linux-kselftest@lfdr.de>; Mon, 26 May 2025 12:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34EC820297B;
	Mon, 26 May 2025 12:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO1cAbaq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1420298E
	for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 12:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748264281; cv=none; b=ScDY4LWCJaVVX0ATVaKEys61fSkw3TOjuzNogs3BRG/vxidcrcoqMgMOPDk8/fVM34hwiY+/9koIwddjsgabGOnuHWTV7HSWO831xZcf+F0UzBWh5+pfWAbQIlyAIp6zMdz5p8rDZ6eUAJKHFufAuXOscX3kW93o6F+UzMtaxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748264281; c=relaxed/simple;
	bh=BAtTg1IAz2Pq4xa5WP5MKDboCtbXwFTv3JIyx9SvTNQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=drc5nJBrxfqxlJBuxF3q1+N1QYK6see7dlcCj2IcVlwdKDvqCzmpRkvJ4EY1l8vfWgr4RK1QpFxvmegI564+Uy/mstKn/xF1r0x8JbvcPHtWQRWMrFXLxgLZRLQiM2G6ZCVi6idtsdzzxdamG/5CMSPOnJg+nu0TQ6owk5XfyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eO1cAbaq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748264278;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pWIfCfk8Tmt/gpieQtOyE1YH2gioYRnHCPB+QvtRvzo=;
	b=eO1cAbaqDKWPOP0xsih3oHb0JRXDlDGhTo1cPJzl1PY4Of8rjrSD+xbekHoRO2Qppe9n3l
	yWg4ogzrh7yYJYbTKvTCDoQ2uNTkLC/vQ+QpglMdqmTA2+r2EBYF+tTdu+Tsv2MruA4BKI
	HoR/BM0ubSb5KpXRpxoef2i2kPZDs3s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-580-G30zxMWEOceWTaOQuWcZzQ-1; Mon, 26 May 2025 08:57:57 -0400
X-MC-Unique: G30zxMWEOceWTaOQuWcZzQ-1
X-Mimecast-MFC-AGG-ID: G30zxMWEOceWTaOQuWcZzQ_1748264276
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3a4d95375c6so379130f8f.0
        for <linux-kselftest@vger.kernel.org>; Mon, 26 May 2025 05:57:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748264276; x=1748869076;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pWIfCfk8Tmt/gpieQtOyE1YH2gioYRnHCPB+QvtRvzo=;
        b=bVgtO78/4ymJ3A/X04feZX8qIuc2jiKZx7P7cv8qg8DEi6w62NmHlrCcGA8bzPqnAp
         AvEbwNtUNyTZ5NQcXkUu6y94n2Y24+V0nxjAVlzBe44jTcnH/vAZn54sByW5ywJ0d4tb
         I+3NZRT1udaXMbrNbHQbh8B23RtJj2M1cXRlgjJm+6rFMT1W4wEUeadKz3CV0DTNix0M
         HTXTaFLAMyDP1SJSWCAcyXxQp3Sb6upa0LPdnJwfmIVwZYqcuBzdOwQRVLp4EO5dC0Sh
         eZiT7a/M67QNRTksuGOSqVvnW8iKCtTGzl2ddrtt9owFGPILcYDiZGCfK+X2/oLjPXoG
         +2YA==
X-Forwarded-Encrypted: i=1; AJvYcCVQF7fD6wvYuX4fGaRR2KfJ3hGD1p2sBKHLGebgGBJHMPXVq4UmAb83XORHPCjb+eRbafZmHYhB4s3qBEDMRz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQFUkuO2TcOrCkSU5bNlDMyPp4Sy2hYg1FQHV75nJxbYJtxjjQ
	j6l9H/+5En0rSkcz+svXGQOTZxHm0kMa5V7Z/ATNAjVfOEtMXaM2kepFaHQ1g6IxOPgtKDu0RWm
	+6tultnO9U9Qwbb61SvYHc5dbLowQasU0ka3RiAQu9bAre3P9gfPgAXShNOgJVscdDJHM6A==
X-Gm-Gg: ASbGncs5meq9wS853Itx7O+DNGXchVZRJI9vvMJ8BBwVS5iancYXCZhl3iCf6kgygKw
	pnRobeqf/3FCQTwN9pof6ImXPznWuqjf/8smljWcVkK3MWAGEIUh2gQwdL3lIdmCes35+YDNsqc
	hcFp09BAv2VTAmq86BODBBERnT6Xt+X/oilwX6RCJMOYxKHtwd5iu9ri48uM2Zw6+GLQDta/zN3
	2azwQh9gNIhapWDWdJA6ZwhkQao87SLTyMyO0tZ7nGissLg5vCcmSYuGsECBn9Ia1ipBrrlogsy
	2NSJemW/zLm4tzzZjkY21pD4PtEiGnQl0EQ4xaMcfqEnqZ/yKQ/TWoclhf4z0MEhy9CE37zQI6k
	v6krqP0XxnLm5OxJviiNPxiD+ioFs2OgwtpF9XzM=
X-Received: by 2002:a05:6000:4203:b0:3a3:648e:17da with SMTP id ffacd0b85a97d-3a4cb449628mr6930392f8f.7.1748264275882;
        Mon, 26 May 2025 05:57:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjHzgu2wHsQTTM5XNjk6hrAMmOf9m3x1GeSPiXUCnbdAfJ+yu2Z2J7ENby+z8F/q3Gqcf27A==
X-Received: by 2002:a05:6000:4203:b0:3a3:648e:17da with SMTP id ffacd0b85a97d-3a4cb449628mr6930371f8f.7.1748264275515;
        Mon, 26 May 2025 05:57:55 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f19:6500:e1c1:8216:4c25:efe4? (p200300d82f196500e1c182164c25efe4.dip0.t-ipconnect.de. [2003:d8:2f19:6500:e1c1:8216:4c25:efe4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f6f0554fsm234468685e9.9.2025.05.26.05.57.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 05:57:55 -0700 (PDT)
Message-ID: <a360912b-4d07-47ce-bdaf-7125fc020e65@redhat.com>
Date: Mon, 26 May 2025 14:57:54 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Deduplicate test names in madv_populate
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250522-selftests-mm-madv-populate-dedupe-v1-1-fd1dedd79b4b@kernel.org>
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
In-Reply-To: <20250522-selftests-mm-madv-populate-dedupe-v1-1-fd1dedd79b4b@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22.05.25 18:29, Mark Brown wrote:
> The madv_populate selftest has some repetitive code for several different
> cases that it covers, included repeated test names used in ksft_test_result()
> reports. This causes problems for automation, the test name is used to both
> track the test between runs and distinguish between multiple tests within
> the same run. Fix this by tweaking the messages with duplication to be more
> specific about the contexts they're in.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


