Return-Path: <linux-kselftest+bounces-18403-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F7AA98772E
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EE581F22114
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Sep 2024 16:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95421158210;
	Thu, 26 Sep 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F868qumm"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BC653368
	for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 16:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366636; cv=none; b=SH6lmExTPmn16qWerjp2St2UO20xS1xVo2QhV+HG9iGIH0dqx8/ayKt/RvCwhmf7J55GKQbFUXyP/C6tqAHfwdOShVM90N/iJb5bSI1PT83dR67HaucVflB20UJMn7NVZM2+lVDDooKJ6+XyIGtr8TTxKgsIo+OmPnYGG1SkGGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366636; c=relaxed/simple;
	bh=RCbWaVdkpNKmgGJq2L3D+EvSQFwN0XWkCmjsWGwaEww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5VRJtQd0wYVJcIQiuYmm5G1VvVBzFGsVA9pjQThjQGcjjv5sF4Mc8Yo5XFXZ2C8bKyqVqmoax+tvP1k3B9LjVLchPosBsdKbQRaaFBPCuz4gP+2UNyBW+O7xyLM4YEiFkdFxh3/ph7uxbNkdwlPEiF+iuaXxKAnYXn6tUqAwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F868qumm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2e0a74ce880so553111a91.2
        for <linux-kselftest@vger.kernel.org>; Thu, 26 Sep 2024 09:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727366633; x=1727971433; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7bPPk0kAmsAXYjb0/D93cH5UC48AsXEk9c6DNPfZ9Q=;
        b=F868qumm9tpJ2qqRbWddNPp3TGMKvpBu+wfVqjAwgXsQqLGMjIw1i1v0aUYg1BBAs6
         qW7bkXOIKsLU627+QRxDNHJLhCUePykaWdr62jhflaJoDx17EgpOzp+1hK9IM/JR7F1H
         qPyaeNYnwiYZyEYbM8SbcEexfY1Tr5AMqNH5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366633; x=1727971433;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7bPPk0kAmsAXYjb0/D93cH5UC48AsXEk9c6DNPfZ9Q=;
        b=uUEkE+IzzMu4b0utlL5L1TsYkhjsVyFFHvC6hPWtPIuFB1DerdKiJHqdoRO+7E+gLy
         dgOM/vepyrVKRnzKVS7vD3eXEzsbqPJ6FecXJ1n2cpieZFrORIjOCHYBITZ+bSDKR5ZK
         mGzia3qO0Hbh0cNZwZRqKyQASFOHvxRU3m0b5LX0gwE6Sm2pXv1RLBH77J7Td0lCv1sH
         lAWpU/TEtLv8nV2IPkzaVkpRPmNKVk//BsEeRBxYr78bYHeIV4mZPpcnShIMCNiqe/ty
         JgT8+6jeIWAmPjEsYtdx4Nt9gF5bvv5XfoazE34JYHHCcdK9oQulQkgjT/XDNM9Fx4Br
         1bzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWz4EmUnDmdXf7tmq9Ni1p6cxnv6CRYEdc2BbMr26EGlmffhmJPAyDxwaQYQSSU1UiuQHvsXzEQa1YuAFJPhYg=@vger.kernel.org
X-Gm-Message-State: AOJu0YykRxKJVTO8FwtOG9i+1S6Z1rzDYrQlBzNOBgU+pqW+feHniU4C
	fy82eIoGCyQkM9L7ZEWIurhNUpvbUETSRWXFeLf/ixoehEWnYFO0LDZvzVUxqHM=
X-Google-Smtp-Source: AGHT+IHTpMcYmF9z2kltnsJqkihXDzYulmllfE5WCQAP4YEs16N79sFK7tcp+DcdzifQ+u5hSHcozA==
X-Received: by 2002:a17:90a:8a8c:b0:2e0:94da:bfd2 with SMTP id 98e67ed59e1d1-2e0b899cc3amr225520a91.8.1727366632896;
        Thu, 26 Sep 2024 09:03:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d8888c33f8sm21149173.89.2024.09.26.09.03.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Sep 2024 09:03:52 -0700 (PDT)
Message-ID: <5d9c8052-e7ca-4819-bd0c-d7f88905c7a1@linuxfoundation.org>
Date: Thu, 26 Sep 2024 10:03:50 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] selftests/mm: hugetlb_fault_after_madv: use
 default hguetlb page size
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 Mario Casquero <mcasquer@redhat.com>, Breno Leitao <leitao@debian.org>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240926152044.2205129-1-david@redhat.com>
 <20240926152044.2205129-2-david@redhat.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240926152044.2205129-2-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/26/24 09:20, David Hildenbrand wrote:
> We currently assume that the hugetlb page size is 2 MiB, which is
> why we mmap() a 2 MiB range.
> 
> Is the default hugetlb size is larger, mmap() will fail because the
> range is not suitable. If the default hugetlb size is smaller (e.g.,
> s390x), mmap() will fail because we would need more than one hugetlb
> page, but just asserted that we have exactly one.
> 
> So let's simply use the default hugetlb page size instead of hard-coded
> 2 MiB, so the test isn't unconditionally skipped on architectures like
> s390x.
> 
> Before this patch on s390x:
> $ ./hugetlb_fault_after_madv
> 	1..0 # SKIP Failed to allocated huge page
> 
> With this change on s390x:
> 	$ ./hugetlb_fault_after_madv
> 
> While at it, make "huge_ptr" static.
> 
> Reported-by: Mario Casquero <mcasquer@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   .../selftests/mm/hugetlb_fault_after_madv.c        | 14 +++++++++-----
>   1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> index 73b81c632366..ff3ba675278d 100644
> --- a/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> +++ b/tools/testing/selftests/mm/hugetlb_fault_after_madv.c
> @@ -9,10 +9,10 @@
>   #include "vm_util.h"
>   #include "../kselftest.h"
>   
> -#define MMAP_SIZE (1 << 21)
>   #define INLOOP_ITER 100
>   
> -char *huge_ptr;
> +static char *huge_ptr;
> +static size_t huge_page_size;
>   
>   /* Touch the memory while it is being madvised() */
>   void *touch(void *unused)
> @@ -30,7 +30,7 @@ void *madv(void *unused)
>   	usleep(rand() % 10);
>   
>   	for (int i = 0; i < INLOOP_ITER; i++)
> -		madvise(huge_ptr, MMAP_SIZE, MADV_DONTNEED);
> +		madvise(huge_ptr, huge_page_size, MADV_DONTNEED);

Magical effects of hard-coded values :)

Thank you for fixing this

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

