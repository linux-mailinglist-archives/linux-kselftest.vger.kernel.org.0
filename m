Return-Path: <linux-kselftest+bounces-27485-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 923FCA4471E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 17:59:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEBCF17512E
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Feb 2025 16:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F4A19CCEC;
	Tue, 25 Feb 2025 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDZezrhO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E00819C556
	for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740502372; cv=none; b=KtqvOELSnbggz/upemobOy92Fb74TGGB5qDjvTk0q+C2vMibe5hnrYN8QppycZq9kRW5g3Ipp1QjTpgz/oTcaAdSPs9nswFgjEiU+TtdCyqAQzw055/3IW5FCtKqq5ubqHvdBDMkuIzrmUriXPtcl1BYN9ExSQGWxJt7CbsIVGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740502372; c=relaxed/simple;
	bh=C+tFZN9mWiR7ZHbPkAa5+JvBoxMYFnFbyHOCCfPiQTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CpZXO6+zTbR7f934n9D1Pzm4GRd0UxcHuqPlcQKm1xp8vcy/Yz1lhgrMo3AP1CyDu14+HYovBXgo0sbew4FJXQ1+HJ/ZO68IUu1wyx1330zxJaMHXV1m1HZ4U5dkHVh0adA8abfF8+EoM3VEKMszvwWkxvw2OuoDzi5JKQQQZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XDZezrhO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740502369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ybxboWusnqyTjKvs03gdfQgRYiuSjJraiMkFJv9TEnw=;
	b=XDZezrhOsWknMAzcJtBBOyRhNu5xuRpofBldrODUbIymPpkPf2Jk9BdWb0y0ZB/MvDyIJC
	trdptuj7VZ5l8/Mj5GAaTJ5Cc9bj0fgsvDedQd/Q8AfQaqEWHJA7XS+BWn5AX2PNd3OCul
	X0qQ2kseaqA0uMcgCbUtyVsCJGJweqE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-93-jImKW3DsPi-_0RLwTtkJEA-1; Tue, 25 Feb 2025 11:52:47 -0500
X-MC-Unique: jImKW3DsPi-_0RLwTtkJEA-1
X-Mimecast-MFC-AGG-ID: jImKW3DsPi-_0RLwTtkJEA_1740502367
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43998ec3733so29889515e9.2
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Feb 2025 08:52:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740502367; x=1741107167;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ybxboWusnqyTjKvs03gdfQgRYiuSjJraiMkFJv9TEnw=;
        b=mABrsgHVQiMIBERhm4w3Bq8HxyKr99pjoh7PXTZRWIl/OTGq3QEW8ozUPdOQXelpe/
         EeL4cIhYgoqkmIqIAVAFBVzGGa9g0aBb1nVM5cYjiLqHDTO4C0YuOCLFOimK2W6NbfAv
         9srT9YzTDlfPp5qd1KMM1Y6Kkd2ZGdMR+L3hEq6Vq4pt9hY81juk4Bb2hULr0rkYrLcI
         bitFEguSIJy3ni0pmQg7Js80VAABAzG3mAzWoHovWkuS0YhHtZW2EHY71JntpDkALsMo
         PEfQoKlzJD/US6+MW1QO28/3sqQ1Aw1ut0YCXXIcSDFSfkNAZ9DWDJAfAcQxjSkZe60H
         uuHg==
X-Forwarded-Encrypted: i=1; AJvYcCXa6Arnbs3XIhUpYDssa8oClIR2N3rJMeTRKjEH+ptVumV6uawis7Aq71l0BaY7uhgXmwBv5XkrExysRJoD+jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYQToLg3UIUSGTGAeaYzod7ncVDfsN4yiaLZgVXjVqk/6CGCGJ
	kCkSeZaEHQV5UDKVWoiNfM4fAJOsRj07AOvaG0oY94xibtVaDNI86wxdwMJWxRMeY5ASznL3d7A
	hEVLxFyUtSWopLH3NbGBl2ZwfOiBqrGips9Z7171iiKFh7kiu/eDF/LP+U8C1ZhutAw==
X-Gm-Gg: ASbGncuGY7vjuCvPUOLsUzD4IZIkYISB+eEJ3E81g7tWaO7x7AzTfPAKkTsNLmTS6u0
	ZdUafhSyYjKIemePd7ZmqdXDotWAp1mRAYY/485CG78eZhOTstNe09YrjXuGsxoVcXoMMPoWIK6
	9vKzBCHYdbgZsZLdtJ9QRrcaFT2UV8zHhyZ16lzaa3ivEDDz9GJJlebnrOT94VguBb11yVt/CNQ
	JedfZDQOz3tcFkCZUfF5y2Pvgz4aemb1mNeBJXD/PFonoLqgo0NrI1CRoUn48IoYVE00hye61F6
	vP0JzQUZAWF0VyWT/WtNaMBK3MRfv+tBGrAKPcmxJfQXjxcWzr186mAOrIE3sUHCm8n1s9DBdL6
	qjS/CCosD9yOwlqP6VgM4s5wM3JmsMKeVyaUjCBOvRm4=
X-Received: by 2002:a05:6000:1a8a:b0:38d:d0ca:fbd5 with SMTP id ffacd0b85a97d-390cc605518mr3098281f8f.22.1740502366822;
        Tue, 25 Feb 2025 08:52:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkp5nTxzC3mH+QfPQ2OcYNGz6wgylsGdXkNqE7sPvdo2LKF2uZNL9mmhTxt1LgwuC8gCNgdw==
X-Received: by 2002:a05:6000:1a8a:b0:38d:d0ca:fbd5 with SMTP id ffacd0b85a97d-390cc605518mr3098250f8f.22.1740502366450;
        Tue, 25 Feb 2025 08:52:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c73e:aa00:c9db:441d:a65e:6999? (p200300cbc73eaa00c9db441da65e6999.dip0.t-ipconnect.de. [2003:cb:c73e:aa00:c9db:441d:a65e:6999])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd866ec7sm2868347f8f.3.2025.02.25.08.52.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2025 08:52:45 -0800 (PST)
Message-ID: <d686092d-bc86-4a65-b580-04f0e42e96dc@redhat.com>
Date: Tue, 25 Feb 2025 17:52:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/12] mm/secretmem: set AS_NO_DIRECT_MAP instead of
 special-casing
To: Patrick Roy <roypat@amazon.co.uk>, rppt@kernel.org, seanjc@google.com
Cc: pbonzini@redhat.com, corbet@lwn.net, willy@infradead.org,
 akpm@linux-foundation.org, song@kernel.org, jolsa@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com,
 vbabka@suse.cz, jannh@google.com, shuah@kernel.org, kvm@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, tabba@google.com, jgowans@amazon.com,
 graf@amazon.com, kalyazin@amazon.com, xmarcalx@amazon.com,
 derekmn@amazon.com, jthoughton@google.com
References: <20250221160728.1584559-1-roypat@amazon.co.uk>
 <20250221160728.1584559-3-roypat@amazon.co.uk>
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
In-Reply-To: <20250221160728.1584559-3-roypat@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.02.25 17:07, Patrick Roy wrote:
> Make secretmem set AS_NO_DIRECT_MAP on its struct address_space, to drop
> all the vma_is_secretmem()/secretmem_mapping() checks that are based on
> checking explicitly for the secretmem ops structures.
> 
> This drops a optimization in gup_fast_folio_allowed() where
> secretmem_mapping() was only called if CONFIG_SECRETMEM=y. secretmem is
> enabled by default since commit b758fe6df50d ("mm/secretmem: make it on
> by default"), so the secretmem check did not actually end up elided in
> most cases anymore anyway.
> 
> Signed-off-by: Patrick Roy <roypat@amazon.co.uk>
> ---

Ah, there it is. Can both patches somehow be squashed?

-- 
Cheers,

David / dhildenb


