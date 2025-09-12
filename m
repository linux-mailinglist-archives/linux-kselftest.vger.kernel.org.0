Return-Path: <linux-kselftest+bounces-41386-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1048B54F88
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 15:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE3C1CC70CF
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Sep 2025 13:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2836130E853;
	Fri, 12 Sep 2025 13:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X5I+cn03"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBD130E0D1
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757683716; cv=none; b=iRU8y6p5ARk8EUmgd5w6Y+xpPG4W8S12Icf2gzUUmmpZASFGiMoKrLOlqwjdK09fUHkaDqZeLgFR9vlBkWb1yoCckey7KgR81STriGL0NfJ3ypIusOvPTlwRORfP8SBXNJqlh1Wjray6O12vxcTkMgBvFb9SvTjXs02foezuBAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757683716; c=relaxed/simple;
	bh=EJFBmnMMl7+8ZnshHepxbUjX3FTPr5HVqRAu8UgUhvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QHNTSdSXMlEJyC/kfn+JP/63/oBEcuxbwfpyroYNwzEVbzfYb9jlFQtdq/N4BkpismSlN9p1dEgOElrCTRP/dpjdnOA39xzyQJxOKXqaOfIWGm/oNibxdvcvYT3C+ddU4NisMnMH8AL2RRT+23BaRpKMElwNdZPPCaNaaAy4qhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X5I+cn03; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757683713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=TxCuVeKIYByX83ELv08YQNod/eiQVC5gVFgMvw8risQ=;
	b=X5I+cn03pwz0xcNVp/7hMikhRn748AoomX19RoC1+A7oqvRdb2LxD4CLdp4lPirEpWCEZ+
	DLCU66svhIsSGZazdXRfkUvMIvJIiCAt5+6d66EYr6QsWwVVSkuqvcjvme+BBiMazCra+w
	h0fvQqqP2JKXVEYsJH1s7/4uGeddQxY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-i5Unhq5sNNOXDarnK3NZGg-1; Fri, 12 Sep 2025 09:28:32 -0400
X-MC-Unique: i5Unhq5sNNOXDarnK3NZGg-1
X-Mimecast-MFC-AGG-ID: i5Unhq5sNNOXDarnK3NZGg_1757683711
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3e7696b36d9so383888f8f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 12 Sep 2025 06:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757683711; x=1758288511;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TxCuVeKIYByX83ELv08YQNod/eiQVC5gVFgMvw8risQ=;
        b=jjclmVlQKyndY2G8q/iVn0FMlH6anmPDSGPktvI7OD95gW9XqurVJl3nR3f0w+B7X0
         MuhvATDfJSL3MCuirZ1yPftm8ZOC1SkAufT0IzpaSbuGsyj71gi0NMublyQK0iAnblOS
         FdbjNTf1G1zR5HBH/xG6Tm2OuCkYuCiFQ9NaMsrOWhBdRZHt/UtwK32eJwXTvuGQc7s1
         mQBQRyWtaAXW2fPcrmoPRq+AhwBP0VIERCMVNV8bKIeEdl9e+vL+1L5v0NqM7X981VbQ
         Lj692qPf68OzW9yAk1iKGjSlaEDQlL1gc9Sca6XqkVxhW8K9DxWBalCxenosy5ie2iA/
         RjPA==
X-Forwarded-Encrypted: i=1; AJvYcCXcNNA6uNL30CcCQKE4vxInUOUdEKH7jJ9PN3W0/ekAbQaPSAv4O4dJn4V7H/CEmr14N+ci4pBwP10HT2bwLHA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw50UCWEvhL0CKWHT9hWavRJFxn5vgeA0sQD/sv+XJUDCIoBqLD
	H9f/L3UWzSxRAROeNuzh0Ulc7TPDoxDygMePa9oC4mug5K3Uu2lZ1JlN0S5jrvKXnaILc0K2GZ4
	B03gt5X5gnpqf4ZFp/O0+Eqt7Hy2w0MdR7qxwE1558i+3vtQWsELDO+iwNmGD7l/KTPQ+4g==
X-Gm-Gg: ASbGncuwP3DW6RRBTuH1vCmg77Vlj8wAL0SAkRN3VONP6j0dUyKZp2B871ClGV/FSc7
	LyuxK9COnb0iHB1z/RseDq0Ot/I7A2em3h9h5HAmwcq8xidBc3b80vIHtKlaxRffqH0/wGAHaSS
	NcauNpwDAVnJ7lAp4UadYFgWC2RIV5YjTZXFfph1cZeUhpWtXRErIrM1b0UWoTcsbIt5HvT973N
	wUaoKoR+Lc7LLKBYPrAm9qZGGOa8SFKUs6xsajiMjeGy9yiFL1TDVFa47SsVzgurpftDFFe2apG
	JphUcHe95TNwuC13SBgEt7PeDKuupjGcFu8yAdxFwa/WX5nXzbE6PamoGfjcF5iTxLasHZMWUpJ
	TTN99s+WKSH9J+m6kpI1PDGmUhf/SVZ56bOPpAnDSFVMWznInKh1Iwx/20YwSzEj/i+U=
X-Received: by 2002:a05:6000:2384:b0:3d8:3560:59f4 with SMTP id ffacd0b85a97d-3e75e13caefmr6723699f8f.15.1757683711148;
        Fri, 12 Sep 2025 06:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb2l7aN1/8HIAcICiml5mSkrzckyj6yy2pKIKfzYSogTxvyEF5XddWuqkJ2hocBG9MnDZbvQ==
X-Received: by 2002:a05:6000:2384:b0:3d8:3560:59f4 with SMTP id ffacd0b85a97d-3e75e13caefmr6723659f8f.15.1757683710722;
        Fri, 12 Sep 2025 06:28:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f20:da00:b70a:d502:3b51:1f2d? (p200300d82f20da00b70ad5023b511f2d.dip0.t-ipconnect.de. [2003:d8:2f20:da00:b70a:d502:3b51:1f2d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e0156d40esm68008195e9.1.2025.09.12.06.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 06:28:30 -0700 (PDT)
Message-ID: <8ffb72f9-7d46-48da-833e-83ffd8e32a5b@redhat.com>
Date: Fri, 12 Sep 2025 15:28:28 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: centralize the __always_unused macro
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Antonio Quartulli <antonio@openvpn.net>, Sabrina Dubroca
 <sd@queasysnail.net>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: kernel@collabora.com, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250912125102.1309796-1-usama.anjum@collabora.com>
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
 ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwZoEEwEIAEQCGwMCF4ACGQEFCwkIBwICIgIG
 FQoJCAsCBBYCAwECHgcWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaJzangUJJlgIpAAKCRBN
 3hD3AP+DWhAxD/9wcL0A+2rtaAmutaKTfxhTP0b4AAp1r/eLxjrbfbCCmh4pqzBhmSX/4z11
 opn2KqcOsueRF1t2ENLOWzQu3Roiny2HOU7DajqB4dm1BVMaXQya5ae2ghzlJN9SIoopTWlR
 0Af3hPj5E2PYvQhlcqeoehKlBo9rROJv/rjmr2x0yOM8qeTroH/ZzNlCtJ56AsE6Tvl+r7cW
 3x7/Jq5WvWeudKrhFh7/yQ7eRvHCjd9bBrZTlgAfiHmX9AnCCPRPpNGNedV9Yty2Jnxhfmbv
 Pw37LA/jef8zlCDyUh2KCU1xVEOWqg15o1RtTyGV1nXV2O/mfuQJud5vIgzBvHhypc3p6VZJ
 lEf8YmT+Ol5P7SfCs5/uGdWUYQEMqOlg6w9R4Pe8d+mk8KGvfE9/zTwGg0nRgKqlQXrWRERv
 cuEwQbridlPAoQHrFWtwpgYMXx2TaZ3sihcIPo9uU5eBs0rf4mOERY75SK+Ekayv2ucTfjxr
 Kf014py2aoRJHuvy85ee/zIyLmve5hngZTTe3Wg3TInT9UTFzTPhItam6dZ1xqdTGHZYGU0O
 otRHcwLGt470grdiob6PfVTXoHlBvkWRadMhSuG4RORCDpq89vu5QralFNIf3EysNohoFy2A
 LYg2/D53xbU/aa4DDzBb5b1Rkg/udO1gZocVQWrDh6I2K3+cCs7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20250912125102.1309796-1-usama.anjum@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.09.25 14:51, Muhammad Usama Anjum wrote:
> This macro gets used in different tests. Add it to kselftest.h
> which is central location and tests use this header. Then use this new
> macro.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


