Return-Path: <linux-kselftest+bounces-34699-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E43AD5521
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60A553AAD54
	for <lists+linux-kselftest@lfdr.de>; Wed, 11 Jun 2025 12:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DEE27BF80;
	Wed, 11 Jun 2025 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bXY97wLh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAA327780B
	for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 12:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749643889; cv=none; b=TwOrPR/l7uOmt7pmYeSs3GtU11WPW07DmBU9okNXDrMujLBCKWoSCqJInhp7b/OIM/Cag5Of2M550OMsFNDAPIG1XtPW8OeMcQadOaYND6KmjvMmJo9lH/n5Wy+a84mMKyewgUTFclLN+XMYafj407Nn7q3Dmjsfz6gh3eA81zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749643889; c=relaxed/simple;
	bh=wj+Lp1JIKeXO6eLYNmD4JrguUF/hcBihPWj9REmfNk4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQW7EUGv0dKWn8KZ+G6fy18KNusIiTwhPjgf7NZshtEdkN7ucO2nWcRk/YIpv4B3R9ZuBbkTtqD5AKgOwdv4N/tSoigRv3pc4X/BGQld7IyYHt88hCii2mIG5FqqW4dkLz4P/0Cl7AAO1fKNIBQUYILlmwih2owkJSkzVPwdFS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bXY97wLh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749643887;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=94fGjpgENkGfz8xm/0/MvEIE16LMoVi1/Ag2K5nPavY=;
	b=bXY97wLh2t8V5fillaBuMNWy1I6wyAo3zl7/lLOyLqAkQKgFn6bSM7HjPgk/71O/wpsvVA
	wPywQV+q2DbyJda56CIiAo/+ajTvpJndb7TXIK4F9CB7XmfsAh6jzx+2wXupi9pvLVZC3T
	s6hdp8Qbn1DYrSKFYUeUHEdgHOYPXdE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-bji0OqAyO3i27bEErUK1dw-1; Wed, 11 Jun 2025 08:11:26 -0400
X-MC-Unique: bji0OqAyO3i27bEErUK1dw-1
X-Mimecast-MFC-AGG-ID: bji0OqAyO3i27bEErUK1dw_1749643885
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6face1d593bso128753756d6.3
        for <linux-kselftest@vger.kernel.org>; Wed, 11 Jun 2025 05:11:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749643885; x=1750248685;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=94fGjpgENkGfz8xm/0/MvEIE16LMoVi1/Ag2K5nPavY=;
        b=Gf4Xz/V9jMHXQbe/Ym9iDMUoPZY/hT47J11qpxgD+du+O1DXgrFDkJeXwmGZ0QWjkb
         1WUmImK7fXxoaKjK9f0u023psc3yJ8aCMNLp/xashH42+N2UtdZQoaNy0oyZwiplzMtT
         bCG+d/7jkwpWeRJrmRn7GHQUCZbkJ6bbvpu2ZU2wW13/DxVlKYyTRo8yUkwkcqZa9JKx
         D6gG8wTnZvyoXDPVRUMgRLEwHRS4sHCYJ5kdmCE/M5H7sPXIKE3B3M6s+j9cZuv4faDd
         ajeAqLtkITf848mR8GTj/5290pyj3Vi+nRGjNElMEnBe3MrZxfyq+wIlcPx5tGWUl+MH
         foBA==
X-Forwarded-Encrypted: i=1; AJvYcCWVNxUk7hMK0NubWkGCl1t+KkgFLzmd6u5IEF3ZJ9E5McaL0LQ6LKguw5KUM6H/RG20PedpQx6WD/1AL4cyQWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyX4bxlVmVYC8u/3G92sPzz8DLcyAP64ZcncaQcol58fgfAkOJZ
	sjHdS3+zqb8HdLAUi/DnmTyjKOmxrhVFtb0DD6cSRQyTwxtPCF6ELOMy3xvo5/eLK4KCUUGiJHG
	dRA4KVb0cnfMcUeNefjvtUs8Ba/GdyPF885PVnxUhvlTa7323nE9c0S5Hz/iRz0XXhIVxoQ==
X-Gm-Gg: ASbGncu/SiFV23CyV3lEHvieSnSKZt/+ic2Pc6qpfsF0VsfE603BfPl3eITGMoJ2+dh
	4w1IYG9ijNUTGFft13o/XAuVQgyVMy3tN9Wkvb8e9r/u6M3FEBWPashlb2dGJtL/0+EdU1vwEzc
	rhz47YxXVUe3oHQ0kAajGAwvifOqn6xKbC0HKHENWQ/UrXKaDi2jE2lQL0UvmsIVcltXO0/dJoi
	XNbWqthkAcPIsME2mjYo6Hp/RRI9U8tHtjOVzr2Vet2jwE7ViZAaFd6lHcytXBJaWZFf/9jOXwf
	iG129Wrt5j1tqbF8Gc7fpZYTiORQmCYoOTgze58pY0AZ
X-Received: by 2002:a05:6214:76d:b0:6fa:cb72:955a with SMTP id 6a1803df08f44-6fb2d12a834mr42742556d6.4.1749643885366;
        Wed, 11 Jun 2025 05:11:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHphM2A40eqISPXj3+oqaa57yngTVVZHDTfJeB5+KzJ+lXgUMEjIOP5dF/qLwW0Zst1IP4Yw==
X-Received: by 2002:a05:6214:76d:b0:6fa:cb72:955a with SMTP id 6a1803df08f44-6fb2d12a834mr42742096d6.4.1749643884976;
        Wed, 11 Jun 2025 05:11:24 -0700 (PDT)
Received: from [10.32.64.156] (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d38f4cc6e3sm556234185a.42.2025.06.11.05.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jun 2025 05:11:24 -0700 (PDT)
Message-ID: <34a650a6-6885-4d86-8162-567ddf98fd02@redhat.com>
Date: Wed, 11 Jun 2025 14:11:22 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/mm: Add messages about test errors to the
 cow tests
To: Mark Brown <broonie@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250610-selftest-mm-cow-tweaks-v1-0-43cd7457500f@kernel.org>
 <20250610-selftest-mm-cow-tweaks-v1-4-43cd7457500f@kernel.org>
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
In-Reply-To: <20250610-selftest-mm-cow-tweaks-v1-4-43cd7457500f@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10.06.25 16:13, Mark Brown wrote:
> It is not sufficiently clear what the individual tests in the cow test
> program are checking so add messages for the failure cases.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---

Thanks!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


