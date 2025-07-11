Return-Path: <linux-kselftest+bounces-37104-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94DFB01D7A
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 15:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D81A43DD1
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 13:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7AA2D3750;
	Fri, 11 Jul 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LeMpy3Oa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF0C2D3746
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752240584; cv=none; b=ZLWb1/tCqWSH9ihVwI99e7Uo8MZkBbge2alynTbWJviJEmx8l8g9S3f/ASdqgQVRzZfwrTj+eZSSvhCGnEfeBVdchS42n/lbUxI4PgInug6Ao1VquvX4UCYxU/RwRqKABXdTTZ/p76oUlnhbsMLOXo5WAe28SUuQKq5x0jS5voQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752240584; c=relaxed/simple;
	bh=eYmplTCBSWmf+MNM6ID1QnTvrR+0cydgP05O/5AnqdE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=adcBbzdojpQyNSDh1cF9tVuoTb25pVUauoJQoIaHQyEgtl0YtFMLQ7N768bXpD6CvfO+KnzfOKH8/IJtXHiYL4rV5e220ET8uzXcOJwJU57oSp52nYJQ47yZ7+EfcM7xz9l0MVmiTv0qG/UlaLQdqyZhVwBgyNP/azlJOl4bhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LeMpy3Oa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752240582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=FWayNqEof3CPboKcwRiBzu8zVRh187wq4qLQtMB2hoc=;
	b=LeMpy3OaYYcnEHN0fl1SJ9kVeMYNvm2+34twkseKtuc27rbTj3v3fNb9/vpIh2ESU+Ybmg
	K+DZTTTAN+lzYiMlpZdVqLy3m9ZrbhZDulsnS3JPjY1Qn/3tXTBoIb5IH73imM6ApxUBtH
	ggV5iosYzZTtw8ybopHUpa+xNQxq4k8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-BL-CBGj2P_i8650KoiCWIg-1; Fri, 11 Jul 2025 09:29:39 -0400
X-MC-Unique: BL-CBGj2P_i8650KoiCWIg-1
X-Mimecast-MFC-AGG-ID: BL-CBGj2P_i8650KoiCWIg_1752240578
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704d1fso14243195e9.1
        for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 06:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752240578; x=1752845378;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FWayNqEof3CPboKcwRiBzu8zVRh187wq4qLQtMB2hoc=;
        b=QVl84paM5D5IUIM44fqXQkQ0ng3EIfGGLqEDfIT301hcJNbbc/ywr9AMN9/TtiHo3A
         4OrNPYHrefrtvV2YrpIGVY/ZS0ZghxAPyib2snJqj3PE/WklkPg76qL9QhAQJsNfz9jG
         5RPFCA+aXKhZ2XqJcz7enoJpIHcJqkQBcY781JUibKq3NGhE5VkNIobqajfi6jWhvITw
         3DzNkvoqzcsmrtAhChyDNfxcdV426gJNhnIy+tSnp4Ph/Q7f6tDLmLCJYCUZKU0j6Z38
         tdxDDnE/olceOob0nX4cYMqe/Ulxor9FNXju5AUCqGiwf0XFL0JdFqYJ3qo/MXCxn1Fx
         VjFA==
X-Forwarded-Encrypted: i=1; AJvYcCV2fRr3yQVSqaIqmoO2jzh5wJP0I3m7nBKLpt6TPb+6lzZbQJJFbzlrmupDh9/KYmhdkMk8vdYs3r4v99UkNp4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywdx2YuT5gLvjQ8GfNBbVcEA264awOb0F87touVs9GDb3beaVVO
	kC9ujqDVRYAmFngbH1k+NlLrPZqVkc9IZkMU6xPWsg0mjVb2g94Z/9LhC/IqlG6GbNpLxTJYLWi
	Dx719aXcqsWQArEd+kY0XvWvJaL7zXyMcGYlfuhdlzZpSS2Hyk0EADtGTS5ytIkuXt/Otvw==
X-Gm-Gg: ASbGncvLn0Fy29E+o524KtJ7nYoBuHJ8FszWEq9jl4oTiqEIighWiM5N5PB3RUMiAA9
	Xs7HyxD2xMv4LYrWgNs8J1bx9qTsTicDfDBWJ29WFaNCPDaTpYCEf9lzF3ffnEGWN+q7y2GOaoG
	K9wa5o35Rjl96TvSVw+5D7wfGgKx4/eOI40rQLNXLvLe4RZs9RpDMdYDsNh52XcPNyIKQBIjH4m
	m4YAh/VBBDl8qZW9Yr8L72gj5QNskW0IYaJXfECe9RaT8TI8vHdPFUTypqHEnBCmrSoZAX+FOwj
	HpXqt5zYJO7j3z6zK4574Glyni8/H5xkYkxcYH05itYBTCr80DyVPiPOuOKgawmvzD5rSyGpV/J
	Bt8kzSDj9fLPezigeyHl3QfIcupNPSKw6L5I4SEYYboatYyPBJmWIqau4gjqxFab9tCo=
X-Received: by 2002:a05:600c:8289:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-454ec1516b8mr30227015e9.5.1752240577717;
        Fri, 11 Jul 2025 06:29:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHVapk8szymRwH8B2XrHeKjUHAvOctlqenT0WRp5OlN8BT5l3R1n4X9nsu/EyRKLbJS0bzhIw==
X-Received: by 2002:a05:600c:8289:b0:43d:26e3:f2f6 with SMTP id 5b1f17b1804b1-454ec1516b8mr30226815e9.5.1752240577292;
        Fri, 11 Jul 2025 06:29:37 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f3c:3a00:5662:26b3:3e5d:438e? (p200300d82f3c3a00566226b33e5d438e.dip0.t-ipconnect.de. [2003:d8:2f3c:3a00:5662:26b3:3e5d:438e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc9349sm4418063f8f.45.2025.07.11.06.29.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:29:36 -0700 (PDT)
Message-ID: <e2f32bdb-e4a4-447c-867c-31405cbba151@redhat.com>
Date: Fri, 11 Jul 2025 15:29:35 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: fix split_huge_page_test for folio_split()
 tests.
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 linux-mm@kvack.org
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250709012800.3225727-1-ziy@nvidia.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250709012800.3225727-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.07.25 03:27, Zi Yan wrote:
> PID_FMT does not have an offset field, so folio_split() tests are not
> performed. Add PID_FMT_OFFSET with an offset field and use it to perform
> folio_split() tests.
> 
> Fixes: 80a5c494c89f ("selftests/mm: add tests for folio_split(), buddy allocator like split")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>   tools/testing/selftests/mm/split_huge_page_test.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
> index aa7400ed0e99..f0d9c035641d 100644
> --- a/tools/testing/selftests/mm/split_huge_page_test.c
> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
> @@ -31,6 +31,7 @@ uint64_t pmd_pagesize;
>   #define INPUT_MAX 80
>   
>   #define PID_FMT "%d,0x%lx,0x%lx,%d"
> +#define PID_FMT_OFFSET "%d,0x%lx,0x%lx,%d,%d"
>   #define PATH_FMT "%s,0x%lx,0x%lx,%d"
>   
>   #define PFN_MASK     ((1UL<<55)-1)
> @@ -483,7 +484,7 @@ void split_thp_in_pagecache_to_order_at(size_t fd_size, const char *fs_loc,
>   		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
>   			      (uint64_t)addr + fd_size, order);
>   	else
> -		write_debugfs(PID_FMT, getpid(), (uint64_t)addr,
> +		write_debugfs(PID_FMT_OFFSET, getpid(), (uint64_t)addr,
>   			      (uint64_t)addr + fd_size, order, offset);
>   
>   	for (i = 0; i < fd_size; i++)

So I assume the tests still passed. Would there be a way to have made 
them fail? (IOW, detect that the wrong kind-of split was performed)

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


