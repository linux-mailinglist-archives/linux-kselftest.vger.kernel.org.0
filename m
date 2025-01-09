Return-Path: <linux-kselftest+bounces-24128-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 759D5A07677
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 14:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17AA6188ADEA
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 Jan 2025 13:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60F1218ABC;
	Thu,  9 Jan 2025 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqTOlkDZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282FE21885B
	for <linux-kselftest@vger.kernel.org>; Thu,  9 Jan 2025 13:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736427953; cv=none; b=AsMrXUfJaKgvN6C5LBKljrveFSQRCsqu1SrtnOx+XB9q39HHTr8mOLjJEIzbWZwRDON81hnM58+6M9svFHGYCTiDKnwP34WHQ5vXA6GUpsHqZkNpmpERHBYdObPHQg+IAKUK6JhWlgjZ8Wgfby9vPI1wt/rRW4wZlKMBnUaqRu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736427953; c=relaxed/simple;
	bh=curNqgXUQNuUhOshq+8hDCnkqHQaxA4k+pwE9uSUrko=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDonO2U/JkAfrFcDCotSmNh2ukFE6NVy6PL43U6pCc4bti5T9lQFmRi9E2dQoEvu/g4HPwe/XxaHJ89HG5AqmEhV0ijqlVNvvC582L4WDuJx5dkUA/HEN42pWUC2Ahg6sJu5iEcj0hMklxXJpi9hZc8BRAItPDei0HAOuZcXt78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqTOlkDZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736427951;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RYyOisobOV+2GEps8qgootwJ53om8dGMQtS6YtO5WZ4=;
	b=VqTOlkDZKKUpRdqhjd5ig8LN9Bv8cbIk07qzOtlJrxjnTi6vvGwo0PEUZmb1rZdXTBJuk2
	NgFVQWBqGbqrOpGlM/x2YuDIVyGp83lAVnhLIoYOvTWxbqveRhaexsDm/yMz1mnO9jRA2x
	6IS3EXnM49wIpWCoaPxW+WTyj/KBxY4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-LK__pzcXPrSQqtIq1RIpIw-1; Thu, 09 Jan 2025 08:05:47 -0500
X-MC-Unique: LK__pzcXPrSQqtIq1RIpIw-1
X-Mimecast-MFC-AGG-ID: LK__pzcXPrSQqtIq1RIpIw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4362b9c1641so4525375e9.3
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Jan 2025 05:05:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736427946; x=1737032746;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RYyOisobOV+2GEps8qgootwJ53om8dGMQtS6YtO5WZ4=;
        b=YaoPDn5iZdnsP5jJjB4vy5l8N5umsVKmLV1b/bOnon/RxUK8BUX8EzATUzbulFpmD2
         TAVe53ilxCYvnKdVR1TD55Vv0S9skuISbBxdOMCDcZaBEurwLU9V672ms5x/OmV50BiV
         dJ19+dHlBmV9byDrDrxDiMtKaCfiuMRg9TYpuQnLiTZ7wHEjBV2y8I/jGPR0P1UIW6AY
         yq2SaFQiQlAeKcw9IR+1w9du8cWMkW650z6s/IGPTHj74+4L5OAYfHZe7J3ziFfg6/UR
         U1qgnRcN+YEAOSVlEMY67gcdmrVrACrXdFJPPiDQS7Ql+EKnTXuBuU1J9Al64xnq/52m
         cNcg==
X-Forwarded-Encrypted: i=1; AJvYcCVTGhFhKCPXP9J7i8qDc6Srof4FjoL8n5zzbi3mCyth/qVbB6lqlNEJGOM3UJZXVWGpOGHZHNBXnwW64nL1KTk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynk3YG7COY9SVz3NnEaKSV68+FX7dizcjNMOIXURYnWEPYJRwi
	XJKNj/asc9p1Ctjx9YmBoSUBf7epG2VdXd57KQLNKEZCFve1yLgNFE0h663yuyfeLIuJ6z1EjbR
	4FXjOf/GkHhaUO94tqd35cv3A3VHZyrJu8+rqZK6xF7XRqx6u9spy3qtLVmijV1fKow==
X-Gm-Gg: ASbGncuSTMbk8i6Ml5be0QYgGiSFNE+k4gDinskmFWFvagokwf+mezuKD5rs8Jcczhx
	NY7h6uORivIMvebMIQ5L4HSJ+AvQrJnqViBoXag6Nl9uBWBWgyXVEpd9hBTlAmfbDrHMPI60P3A
	ql3gmdD7uW1R9xvVjoxqnbIlf5d3nifoDbn6nd+f4SAVWo41/atBdC5G/zVAdtHV+ZudeMb/kJc
	oT6i+A5diyiEZux68d/tobZcigc76/+iCwDSQYbm7bxZLMFS3W+c92uXwg5qcanQx7ggsfdqLxI
	eyGTFA5kVvj/5hN+ZtsjjHcS1fhgslRqrBisXdNh1O3/+DCtikFk1wQkto3GtsIow1GBHKs+W0y
	lc1wAOw==
X-Received: by 2002:a05:6000:470d:b0:382:4b52:ffcc with SMTP id ffacd0b85a97d-38a870826d9mr6315572f8f.0.1736427946660;
        Thu, 09 Jan 2025 05:05:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHB3N96DhcA/zslHvED8A7bOQqnlFm6h5Y9J/8+74AahoNWEqj+ZFqcvUPpuqbx2wL5BfhP0w==
X-Received: by 2002:a05:6000:470d:b0:382:4b52:ffcc with SMTP id ffacd0b85a97d-38a870826d9mr6315514f8f.0.1736427946306;
        Thu, 09 Jan 2025 05:05:46 -0800 (PST)
Received: from ?IPV6:2003:cb:c72e:800:d383:9661:5934:2cfa? (p200300cbc72e0800d383966159342cfa.dip0.t-ipconnect.de. [2003:cb:c72e:800:d383:9661:5934:2cfa])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92794sm54178075e9.37.2025.01.09.05.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jan 2025 05:05:45 -0800 (PST)
Message-ID: <4e52d67c-e968-4cf6-9c9b-88646f0d3a23@redhat.com>
Date: Thu, 9 Jan 2025 14:05:43 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] selftests/mm: virtual_address_range: Fix error when
 CommitLimit < 1GiB
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Dev Jain <dev.jain@arm.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <shuah@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Ryan Roberts <ryan.roberts@arm.com>
References: <20250107-virtual_address_range-tests-v1-0-3834a2fb47fe@linutronix.de>
 <20250107-virtual_address_range-tests-v1-1-3834a2fb47fe@linutronix.de>
 <5811cf74-d333-4653-ab64-0e981eda7745@arm.com>
 <20250108083855-840c688b-003f-423b-8327-2a10a2b27d58@linutronix.de>
 <05edee1e-04f1-4f19-816f-db03c182a201@redhat.com>
 <20250108165052-c03470bd-6ff7-44c9-87b9-9145456bdea8@linutronix.de>
 <618798d5-71b2-43d6-8f5c-78d911c5dd43@redhat.com>
 <20250109083527-e3c77b5f-14f5-467b-9cee-f71c75b2d654@linutronix.de>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250109083527-e3c77b5f-14f5-467b-9cee-f71c75b2d654@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 >
> That is clear. The issue would be to figure which chunks are valid to
> unmap. If something critical like the executable file is unmapped,
> the process crashes. But see below.

Ah, now I see what you mean. Yes, also the stack etc. will be 
problematic. So IIUC, you want to limit the munmap optimization only to 
the manually mmap()ed parts.

> 
>>> Is it fine to rely on CONFIG_ANON_VMA_NAME?
>>> That would make it much easier to implement.
>>
>> Can you elaborate how you would do it?
> 
> First set the VMA name after mmap():
> 
> for (i = 0; i < NR_CHUNKS_LOW; i++) {
> 	ptr[i] = mmap(NULL, MAP_CHUNK_SIZE, PROT_READ | PROT_WRITE,
> 		     MAP_NORESERVE | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> 
> 	if (ptr[i] == MAP_FAILED) {
> 		if (validate_lower_address_hint())
> 			ksft_exit_fail_msg("mmap unexpectedly succeeded with hint\n");
> 		break;
> 	}
> 
> 	validate_addr(ptr[i], 0);
> 	if (prctl(PR_SET_VMA, PR_SET_VMA_ANON_NAME, ptr[i], MAP_CHUNK_SIZE, "virtual_address_range"))
> 		ksft_exit_fail_msg("prctl(PR_SET_VMA_ANON_NAME) failed: %s\n", strerror(errno));

Likely this would prevent merging of VMAs.

With a 1 GiB chunk size, and NR_CHUNKS_LOW == 128TiB, you'd already 
require 128k VMAs. The default limit is frequently 64k.

We could just scan the ptr / hptr array to see if this is a manual mmap 
area or not. If this takes too long, one could sort the arrays by 
address and perform a binary search.

Not the most efficient way of doing it, but maybe good enough for this test?

Alternatively, store the pointer in a xarray-like tree instead of two 
arrays. Requires a bit more memory ... and we'd have to find a simple 
implementation we could just reuse in this test. So maybe there is a 
simpler way to get it done.

-- 
Cheers,

David / dhildenb


