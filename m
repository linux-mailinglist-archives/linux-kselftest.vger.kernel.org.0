Return-Path: <linux-kselftest+bounces-37869-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8089CB0EEF4
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 11:58:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9042F6C4D70
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Jul 2025 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6469C28C016;
	Wed, 23 Jul 2025 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LqFGwRRs"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D9281351
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753264632; cv=none; b=PTeA0+x9W5aJ9fVXGgO9jV8+N8IAwpqGwizM8jvVIr6MrdPNmwWGeR8K6U4cDrOiZulIHRAgd1Ng7fNio/NE2yjAhEHmIsbaxfkRTuBMDCqXNpYBcESGNVQyuRRp1PTjiyIYgzpSKgzf8lTkFU/uUOGrQ/WJYMj9icHvq3viGYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753264632; c=relaxed/simple;
	bh=0wER1sdDpf0YByTkUTnsflZux/fcWM4DuADoOCL19vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RvW4elWCOaUlv4aw58Y+2zwpd9RuLQRGbZQMoUcfsFHy+2TXe9p/KXsrk/i2JKfZ1p7sdpYhue46RLeC40Yp47RSWwX9mXqmq9UHvHgixoiI2QIh7LgOcj8f2lduOf8qyPv5F9RYXDcGEgfwL/jBn6Pye2IaM27zjpqHI1Yk1Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LqFGwRRs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753264628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mSuQe5TZfFo2TDAjQDLuVsg6M8GZKLj4opJx5Te6VLQ=;
	b=LqFGwRRswXc6uPvnUMS/gkpjFKsdEOcocTR+AbqEP+Z13QkVnGLgeH+80WYfjuXVBupd6K
	NUpI0L/7iFK3S1WfxRp831n8E86EZ53BinYZni/tZIbNuEe4fequx6ck7JoyoaFr8Sx84Y
	XdzjngDLdf/ptA/USS5f9Mbu3EcySvo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-74hullokP4u_thSUKeNQqg-1; Wed, 23 Jul 2025 05:57:07 -0400
X-MC-Unique: 74hullokP4u_thSUKeNQqg-1
X-Mimecast-MFC-AGG-ID: 74hullokP4u_thSUKeNQqg_1753264626
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a4e713e05bso2777698f8f.3
        for <linux-kselftest@vger.kernel.org>; Wed, 23 Jul 2025 02:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753264626; x=1753869426;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mSuQe5TZfFo2TDAjQDLuVsg6M8GZKLj4opJx5Te6VLQ=;
        b=oFOkjP1djPTMDYwDNn5ix9AdiZaxA97gazET52nyHTpb0eRfm+zIJG1+l4lNYWal1r
         bFHTNE7Qa86DvgoLKBZk1c0jG+i9G7jaNNgjPn8NUwvU+fQ8fJ86ycIH0Xsc072mHO5x
         K5+chbmn2Tuzw6nF7A/JXXAJMZoPck7lYbu54TwE54wanbCdgkpsWLzqCOBhGIMwYBcL
         XGfEDTSdq61E8puBrNX5B3OrC+3r3LFR3R7wgrmxm3nVQyktijeBIg0yssAXs0t1tByx
         EtrQfjd9s4fz/fKoMD6ylbnOevfkSJ3hDdmrruA+3SDTeAr7n6/uF+AqetNPMr3uQ4LI
         BYow==
X-Forwarded-Encrypted: i=1; AJvYcCV77hU/1XjJ3hPZwAbqrw3TC/wM+MD3434jNfwtdYyoHyg/p41DnGkWkOGd/ATLFySKFBKRWUMFS/yE9zywYus=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW8Y+k1s1WDe2E0NXDxWE+j2krcPcW0mYIV4ur0fGS0oN+bYv1
	k+D8drvwtvQp9FWPGq0KOJZBn32WJDBjPaIFCLjBJwkK/spyahtDzfv9DNFmaabqXGFIp/JavSx
	jwKEjDKj/5jJ+ZIt01ZVQWgXvqEUk6963ZDpsvJ9T4QLv6uFYljY+KknLaYePLy5nNcw3/g==
X-Gm-Gg: ASbGncsqE/mnG9VBU7ZDAytRJ8MGe19MfOTDLUXRLDQaAH/0M5ju1PINqKlGgPCMinh
	hBaNu1tfIxwVyQdoIpUkbwXUHzz5gJZHXT3jFSP9DLODc7J0csQXiKEH9F4vFTPWhm5Rcgjdz+Z
	7sIFxk1haXvbhb1rRB5EaqlUV8J9qHTxlox+tQlzpkEojreh9yIZMvRSTNFfgFW3uuUxeGOTYiD
	77Zp+CGkA4imfwOX1RqWqpl8PX+m804iH0BudHWgEKiTBtPR4/pTkjRzPCJERe4Aa5ApFeuZJI5
	IfUzA+6Sb1L8rb5LC4Ws9PnTTd9nxXycNOabltWiry6BGIGooE+r8FUA+YYzGnIXUrFUOYrzpam
	b7uAxcy770rqs1VQWYKaRL1JbDt90ZmWl9Whd/zDUWnPGpcTm0suB0Me7A4cYZlHMPos=
X-Received: by 2002:a05:6000:2506:b0:3b4:9dfa:b7 with SMTP id ffacd0b85a97d-3b768ec1e6fmr2044929f8f.25.1753264625577;
        Wed, 23 Jul 2025 02:57:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGl73Vv5SZsEFpgMGgi837EdpzryiyNAai0v+xTUvEkF0zaqjrdbQ6xETFDhH2xtsYCmD/VEA==
X-Received: by 2002:a05:6000:2506:b0:3b4:9dfa:b7 with SMTP id ffacd0b85a97d-3b768ec1e6fmr2044895f8f.25.1753264625096;
        Wed, 23 Jul 2025 02:57:05 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f00:4000:a438:1541:1da1:723a? (p200300d82f004000a43815411da1723a.dip0.t-ipconnect.de. [2003:d8:2f00:4000:a438:1541:1da1:723a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458691aafadsm18545845e9.24.2025.07.23.02.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jul 2025 02:57:04 -0700 (PDT)
Message-ID: <1524727f-aa6d-4286-8ef4-bcd224c50c62@redhat.com>
Date: Wed, 23 Jul 2025 11:57:03 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] tools/testing/selftests: Fix spelling mistake
 "unnmap" -> "unmap"
To: Colin Ian King <colin.i.king@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250723095027.3999094-1-colin.i.king@gmail.com>
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
In-Reply-To: <20250723095027.3999094-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.07.25 11:50, Colin Ian King wrote:
> There is a spelling mistake in ksft_test_result_fail messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


