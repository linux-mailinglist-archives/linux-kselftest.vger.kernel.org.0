Return-Path: <linux-kselftest+bounces-38327-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40A3B1BB9C
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 23:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EC246275F7
	for <lists+linux-kselftest@lfdr.de>; Tue,  5 Aug 2025 21:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF5B246335;
	Tue,  5 Aug 2025 21:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eTn6mdnm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5C878F2F
	for <linux-kselftest@vger.kernel.org>; Tue,  5 Aug 2025 21:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754427957; cv=none; b=Ac4AXQ6+qt3GzTb5hvyiqdbHgL29Bm0IVVsCba5/Okj9bMh1M4Ca8TuZLv5yLuVCNcpkF9Kl7niXvLlZpOgipgh/R3n/X1GSF0ZaGDW46nNI3TM6DeBn/wfwzCPUuo2TVs3txfO8JTfFQHskKlH6jei0Q02zO4/bFTok3W0iC18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754427957; c=relaxed/simple;
	bh=9e/lP0asTGntqiEPgqegzLOtEtQILHHgJTMM5RKj8Bg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DU/RSEIDyCZk1OZZ7L/dYhiQ7Gg6vwgYmzlBXUUf+d7DXpcgfCRoytOhRuPQo1LA/kvO9s9iHrHsvw3f1Z/jezMP4cnJKO5s6yZaww8O+qv+13+nDhNFUOTC/EhpG/UCNTBXt4k+O6mRb6191ll/FoxmBdvOSOWhA5OSPktClF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eTn6mdnm; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754427954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kqRftw6bnCaiUsG4UzgVQFaWyDy/FQcqP1mg9FWcAs8=;
	b=eTn6mdnmQZX7geTCdKAUh91bnQNbJTNLUPCCBjI7OcCB7qxqIlDGm1QjHKFKsVVGbS90dz
	lzq2LmFkWYDnBXsJ5D1NH8+e5u7a4dVYQVAVpWFp1FIJ84x/W0I0BYkKqIIjLRYaULIFFi
	VBkH2PoaIaL8l7ftJJf3vOPI3SP3hCE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-5T5em_noPDyeInz8LSp6UQ-1; Tue, 05 Aug 2025 17:05:53 -0400
X-MC-Unique: 5T5em_noPDyeInz8LSp6UQ-1
X-Mimecast-MFC-AGG-ID: 5T5em_noPDyeInz8LSp6UQ_1754427952
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-459e068b5f4so10022445e9.3
        for <linux-kselftest@vger.kernel.org>; Tue, 05 Aug 2025 14:05:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754427952; x=1755032752;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kqRftw6bnCaiUsG4UzgVQFaWyDy/FQcqP1mg9FWcAs8=;
        b=qeJKlzmPfuZQsLWKzgkjYjRIZecAw5PxhyJm2YA7TRQ80bEJ2dwgszQMnwsxM1jeXz
         ehp3F2hLJwOwM1o0sLpcoULgFB/QJrQPwmkrOf1bUgG8eXdU0NCPKWiZPKepLB000BsK
         qc2yn++nHab7sWye9EEJEJkfTSH2XHob4NBwC7AFmxauzunXMWzkClI93M9jt675Bacj
         D+BVg8+qWtkuJh485Rg4/037Y2Jxely/YrIbMz/nnoS8/TxL76QzvQBnhDqC8kDsuWr4
         LxqiTYsrWmSKWM6UUlwDbr9tNiC4diQ4/kPLgZyYFSG0okzfOfAq91QXPsuN9kyjYsb8
         Oq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVSLJlmWRNhjmPlwOKJOc1/dsVdykWars5yWYRqHdUqXTvieDXe/f3ttw79gIxILqsK2PSkRwsCE3HbGTKjclQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZPgXkMS4PwQUo6fDRmnrG8RbKim6qxOQz05mmk8KJFkDLxPF
	ZxRGH2KttoiRRFcrdjpdzkGtd2bTeGkMJxCaffDm9ZmG3zPJugDwcnlRepG/9XdfI6CKx84xlM9
	zVFA5ywSMxAFAVWaovCOL80+zy+DlYINgzywUoR9IIxK7sA1Ve66ZdvxpUy87KiSBGw6pxQ==
X-Gm-Gg: ASbGncv4dO2QwEiEFzeOyuuCDNtrNilXMsgtakuMWs4kpPdcuI+3H5xeIah/tyvC6oX
	EahgZrEjfJPEKwLlNCGRyo/xoUpPghV1/mPY5bxNzQOAbUTk7jKhY3dQF4Nzags7xzd5daA506R
	PI58PCSurfqyngJdlWcOHm61emlalsyY10LSP/5vqgpsjiAwpIzBlBr87Pzqh2pRz3+Jv/LldM7
	0woyf4gNF+sonFlqYFQeHJ5ygFrZXpYh8XYFZlZUAq4HTiMromBoM9FQVMRfoiuInUR+Dj9MusM
	SaMfQv5j8ljFbIWPwl05eD7Jo3C7PrIOIVjLJJYjfSzGEtmtmQEPj5Eo/tf8RXVAJE+k5mO9suA
	D9/dYvb+UCXBHqTg2rjetmYwL4uA1s0U1veMQ1CN6R2wmOl5yvz5c3CnoqGORPWuaXAA=
X-Received: by 2002:a05:600c:1546:b0:459:e165:2661 with SMTP id 5b1f17b1804b1-459e746f7aemr793715e9.23.1754427951909;
        Tue, 05 Aug 2025 14:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5ovmpQA6VuHrG0lBxw9kWz1GZEQp6ylYtVCMl9eYwZWu5JTPAOqCzL2hWks9vBLR4tNTzEA==
X-Received: by 2002:a05:600c:1546:b0:459:e165:2661 with SMTP id 5b1f17b1804b1-459e746f7aemr793515e9.23.1754427951433;
        Tue, 05 Aug 2025 14:05:51 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4b:5100:3004:3864:4049:722e? (p200300d82f4b5100300438644049722e.dip0.t-ipconnect.de. [2003:d8:2f4b:5100:3004:3864:4049:722e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c469093sm20686698f8f.51.2025.08.05.14.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 14:05:50 -0700 (PDT)
Message-ID: <9cfb5b1b-f565-4129-a3e3-fd16a38997da@redhat.com>
Date: Tue, 5 Aug 2025 23:05:49 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: fix FORCE_READ to read input value
 correctly.
To: Zi Yan <ziy@nvidia.com>, wang lian <lianux.mm@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Wei Yang <richard.weiyang@gmail.com>, Christian Brauner
 <brauner@kernel.org>, Jann Horn <jannh@google.com>,
 Kairui Song <ryncsn@gmail.com>, Liam Howlett <liam.howlett@oracle.com>,
 Mark Brown <broonie@kernel.org>, SeongJae Park <sj@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20250805175140.241656-1-ziy@nvidia.com>
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
 AgMBAh4BAheAAhkBFiEEG9nKrXNcTDpGDfzKTd4Q9wD/g1oFAmgsLPQFCRvGjuMACgkQTd4Q
 9wD/g1o0bxAAqYC7gTyGj5rZwvy1VesF6YoQncH0yI79lvXUYOX+Nngko4v4dTlOQvrd/vhb
 02e9FtpA1CxgwdgIPFKIuXvdSyXAp0xXuIuRPQYbgNriQFkaBlHe9mSf8O09J3SCVa/5ezKM
 OLW/OONSV/Fr2VI1wxAYj3/Rb+U6rpzqIQ3Uh/5Rjmla6pTl7Z9/o1zKlVOX1SxVGSrlXhqt
 kwdbjdj/csSzoAbUF/duDuhyEl11/xStm/lBMzVuf3ZhV5SSgLAflLBo4l6mR5RolpPv5wad
 GpYS/hm7HsmEA0PBAPNb5DvZQ7vNaX23FlgylSXyv72UVsObHsu6pT4sfoxvJ5nJxvzGi69U
 s1uryvlAfS6E+D5ULrV35taTwSpcBAh0/RqRbV0mTc57vvAoXofBDcs3Z30IReFS34QSpjvl
 Hxbe7itHGuuhEVM1qmq2U72ezOQ7MzADbwCtn+yGeISQqeFn9QMAZVAkXsc9Wp0SW/WQKb76
 FkSRalBZcc2vXM0VqhFVzTb6iNqYXqVKyuPKwhBunhTt6XnIfhpRgqveCPNIasSX05VQR6/a
 OBHZX3seTikp7A1z9iZIsdtJxB88dGkpeMj6qJ5RLzUsPUVPodEcz1B5aTEbYK6428H8MeLq
 NFPwmknOlDzQNC6RND8Ez7YEhzqvw7263MojcmmPcLelYbfOwU0EVcufkQEQAOfX3n0g0fZz
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
 AP+DWgUCaCwtJQUJG8aPFAAKCRBN3hD3AP+DWlDnD/4k2TW+HyOOOePVm23F5HOhNNd7nNv3
 Vq2cLcW1DteHUdxMO0X+zqrKDHI5hgnE/E2QH9jyV8mB8l/ndElobciaJcbl1cM43vVzPIWn
 01vW62oxUNtEvzLLxGLPTrnMxWdZgxr7ACCWKUnMGE2E8eca0cT2pnIJoQRz242xqe/nYxBB
 /BAK+dsxHIfcQzl88G83oaO7vb7s/cWMYRKOg+WIgp0MJ8DO2IU5JmUtyJB+V3YzzM4cMic3
 bNn8nHjTWw/9+QQ5vg3TXHZ5XMu9mtfw2La3bHJ6AybL0DvEkdGxk6YHqJVEukciLMWDWqQQ
 RtbBhqcprgUxipNvdn9KwNpGciM+hNtM9kf9gt0fjv79l/FiSw6KbCPX9b636GzgNy0Ev2UV
 m00EtcpRXXMlEpbP4V947ufWVK2Mz7RFUfU4+ETDd1scMQDHzrXItryHLZWhopPI4Z+ps0rB
 CQHfSpl+wG4XbJJu1D8/Ww3FsO42TMFrNr2/cmqwuUZ0a0uxrpkNYrsGjkEu7a+9MheyTzcm
 vyU2knz5/stkTN2LKz5REqOe24oRnypjpAfaoxRYXs+F8wml519InWlwCra49IUSxD1hXPxO
 WBe5lqcozu9LpNDH/brVSzHCSb7vjNGvvSVESDuoiHK8gNlf0v+epy5WYd7CGAgODPvDShGN
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250805175140.241656-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05.08.25 19:51, Zi Yan wrote:
> FORCE_READ() converts input value x to its pointer type then reads from
> address x. This is wrong. If x is a non-pointer, it would be caught it
> easily. But all FORCE_READ() callers are trying to read from a pointer and
> FORCE_READ() basically reads a pointer to a pointer instead of the original
> typed pointer. Almost no access violation was found, except the one from
> split_huge_page_test.
> 
> Fix it by implementing a simplified READ_ONCE() instead.
> 
> Fixes: 3f6bfd4789a0 ("selftests/mm: reuse FORCE_READ to replace "asm volatile("" : "+r" (XXX));"")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---

Ouch, thank!

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


