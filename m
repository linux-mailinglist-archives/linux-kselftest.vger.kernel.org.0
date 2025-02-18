Return-Path: <linux-kselftest+bounces-26865-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C5F5A3A1FB
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 17:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7383E3B1826
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Feb 2025 16:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6326A0FD;
	Tue, 18 Feb 2025 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ONwdfrKc"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF9917A5BE
	for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739894487; cv=none; b=jeToiV6NvAaZuMM7q8k4CubFy7BsX+i5P1nDUcoGWe7tDL4ErevymaL65CZ2PVTrEPcVtV6bDAx2yxgyFsJwaYAlf4sjX2oDOTU4UsQAFIbC8fatdjTENPyf+INE21BNyrbuwYF50bp7c8r/o1Ulqal3oavv0LaLoO7LEYVyt7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739894487; c=relaxed/simple;
	bh=UvuZtIGK9MeHMo2aRo3rjzHxvVtxuAGf5O8DSxBo45I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QxqkEfAMUw7g+F9P5+o0XI2wpesYgtKj3WtdVNVXmnD/Bs9GM1VlrYAoCy8mqZSE/W2qaAV1iX0HUZVxmh40edG4rQf2hGf1x/aqZS1x3R/WbRnVpYENipTMHPAAce11iQviOEItrSTf0+PJIFa/EgPIuMd0eXn2ejbls6k154g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ONwdfrKc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739894484;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OZALwbNO1anqS1IpJTNPIJALYFX/VMX5QzhlDdb1MKc=;
	b=ONwdfrKcryRgPc37ew5t623gda/PfrMwsr5JtPng391UxMZD/YpxvbW3E4mAvD1pfvGI/R
	V7nmuIHDBgqZsrl2V5UDZaWzXs+wrr27sZq2rn4I8YFeQhzc7lS4aAAmvPDh5RG0qrpnZO
	mYWI0XZe9UWr3XcWt1cZBOSOP9TZ4yg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-EBf6nM9fMmSfmdzOH1zowQ-1; Tue, 18 Feb 2025 11:01:23 -0500
X-MC-Unique: EBf6nM9fMmSfmdzOH1zowQ-1
X-Mimecast-MFC-AGG-ID: EBf6nM9fMmSfmdzOH1zowQ_1739894482
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43988b9ecfbso10415995e9.0
        for <linux-kselftest@vger.kernel.org>; Tue, 18 Feb 2025 08:01:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739894482; x=1740499282;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OZALwbNO1anqS1IpJTNPIJALYFX/VMX5QzhlDdb1MKc=;
        b=bEZuHR5Uc4Bra3nGzdmQzdsAaKWLGOGfqBzt/V41Qkhc1eyjCL6MbgkA0SGYhMzezk
         /SFgWZQlTQFSYy6/V3l8aswJFb6MmBFwy5dUNeDyoYbKRQm0N5WYojQG1nNylUuQHbrm
         OzyjUPuuy6xLNvxSli2GK/a9xFLmPvzhe8BJEP5zRQgg2EwXSywnWbaknwuMtuSao/0O
         FTJSP3dqhERET7YCAJbpS2ZA/4ppA9yuXKqEAiLITuRtr+W71CvXmbMr81rZgThgNGFF
         p2ORCdoWUGtWcHD21a7V2HeKUNP2h/XVVvae2DO+qdpEIqCMnTJ2ngXSq3EenZo0hRLl
         RCYg==
X-Forwarded-Encrypted: i=1; AJvYcCX2cjvdLvLYkUM1fr1ag3+GQkrEa0mBl6hob+IIhWPiXV0bnY6/X9uSmrCaZuBhh8V/MPUjtdK8mJyQ/qBUe5E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6TWBfxzkYyd4wcGPwBWCqVVu0FRjW6yLe4h7TmWVwq8rHBQt/
	J8Uw1LWvfCL45oULXveq/T+8CRcChK297CnC55pZpZ05IqTNZggyVP/JUZDvyxLwn8rZNRU5tZY
	cw5EjOZqUEnGxeRkz5KIQ7dfqmhZ8rK5UoMAmwFMYRzZVG6GRRw8Jc57hlbFg7b70wA==
X-Gm-Gg: ASbGncvL5U5cXEVHdDGS3VoOZw1KNqwUjne5COheCunoW4WAQ+RPgN0losL/GkhjBC+
	P/Ere6TB9ShDgHiHu7/2WXVBDwck9CJuQ0WvswdJtyq96rQCe9t+Kdp0RRwPPktMg/Qlc5rdGNI
	g1FBzplyHhy5Bss4Mbc4fiZqCGoUuU1HEuVjK8gyC/A3NmAF6MxrD5cqjLVU0Xhnap8B1NNCIVP
	lHj1Id0AolWLqMxL5KuVrBq27n9/KRIpELDQRgOgtNpq0Y4KFq3CXG2DVy3Lbp+VSNHGXyAxKVG
	N55TFpDT3Yzw29Dwk1duZ4k4g1qaCTz6nmkmwu687F661lMvJj28swnDXb810LxjpGKCPnuoRHZ
	werqwtFp3/s/BBpXLf747mRx8Y3PGMeDt
X-Received: by 2002:a05:600c:4e8c:b0:439:9274:81db with SMTP id 5b1f17b1804b1-43999d76ddcmr2054595e9.5.1739894480668;
        Tue, 18 Feb 2025 08:01:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFvBVXumXyfefgpbaVSjPbx3tHV6CAyNCsTaIbB11MfRh7efHMuXI3E3gi2t7deJ94wH3ij8A==
X-Received: by 2002:a05:600c:4e8c:b0:439:9274:81db with SMTP id 5b1f17b1804b1-43999d76ddcmr2053335e9.5.1739894479812;
        Tue, 18 Feb 2025 08:01:19 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af? (p200300cbc70dfb00d3ed5f441b2d12af.dip0.t-ipconnect.de. [2003:cb:c70d:fb00:d3ed:5f44:1b2d:12af])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38f258b4314sm15212358f8f.9.2025.02.18.08.01.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 08:01:18 -0800 (PST)
Message-ID: <6500a93f-aad1-4b21-a94e-feb493c344a3@redhat.com>
Date: Tue, 18 Feb 2025 17:01:16 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] mm: allow guard regions in file-backed and read-only
 mappings
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
 Juan Yescas <jyescas@google.com>, Kalesh Singh <kaleshsingh@google.com>
References: <cover.1739469950.git.lorenzo.stoakes@oracle.com>
 <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <d885cb259174736c2830a5dfe07f81b214ef3faa.1739469950.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13.02.25 19:17, Lorenzo Stoakes wrote:
> There is no reason to disallow guard regions in file-backed mappings -
> readahead and fault-around both function correctly in the presence of PTE
> markers, equally other operations relating to memory-mapped files function
> correctly.
> 
> Additionally, read-only mappings if introducing guard-regions, only
> restrict the mapping further, which means there is no violation of any
> access rights by permitting this to be so.
> 
> Removing this restriction allows for read-only mapped files (such as
> executable files) correctly which would otherwise not be permitted.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>   mm/madvise.c | 8 +-------
>   1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 6ecead476a80..e01e93e179a8 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1051,13 +1051,7 @@ static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_locked)
>   	if (!allow_locked)
>   		disallowed |= VM_LOCKED;
>   
> -	if (!vma_is_anonymous(vma))
> -		return false;
> -
> -	if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) != VM_MAYWRITE)
> -		return false;
> -
> -	return true;
> +	return !(vma->vm_flags & disallowed);
>   }
>   
>   static bool is_guard_pte_marker(pte_t ptent)

Acked-by: David Hildenbrand <david@redhat.com>

I assume these markers cannot completely prevent us from allocating 
pages/folios for these underlying file/pageache ranges of these markers 
in case of shmem during page faults, right?

-- 
Cheers,

David / dhildenb


