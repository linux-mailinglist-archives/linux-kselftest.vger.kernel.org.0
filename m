Return-Path: <linux-kselftest+bounces-11302-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 016788FF173
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 17:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76CFD1F218C2
	for <lists+linux-kselftest@lfdr.de>; Thu,  6 Jun 2024 15:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44BA197A7B;
	Thu,  6 Jun 2024 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YT27w4da"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56FFC26ACB
	for <linux-kselftest@vger.kernel.org>; Thu,  6 Jun 2024 15:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717689448; cv=none; b=kD3X3Rphtfa1I76AQmF7xOrHogV/MNpGqUkIl7VWV0bYIyNdXsWPsqPWJbg9j6crvdRcmjqCkEA7z8zFvS3EFaane0rEvntXKB1krLuQ3IutxO5UxitW44jYxHQd6W3FBQgJlIBfXazAtzcf3XJlphK7WrhgwrnpgcG/9qlyNKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717689448; c=relaxed/simple;
	bh=e9zWBOR9qFpVS8sw2bNnQ0x9k2Yy36+5bbkqomE/RSI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=csPajnq9efrNjByu/Br8cyb1KVHokv7u5gX+qdl4FeQoPyX7Y29ZYtzEPXuV9bAIT0in+HrHrvhZN+e1aLa7EwzZYxJVsMjD+HR9r7FGqhY7a6xx+XBxFo5Z7JYxg70rbVEJ8hlF7WZhUanDsXMp6jGcgV6Q+Dad+rzC6tSh0hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YT27w4da; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717689446;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SC1/9LDY5BT6aCpZ61moOmkMqiCWJ7kUcV39vggIIMk=;
	b=YT27w4daU6cn0dU/Zsue82fo0kZynAplFd2YAaHAk9ib8wCkbPeg6AOKz3TWzyzoNqaWHe
	bvVWkJtPC+ZpQqqXSvZUiXXK3q/CH82/SDGXzGpEvhAc9xAkuxPyJX565gBpyNP9MaAnh3
	wuEFXkZh6QcSZrN9QsWzt73rS+otqgM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-fRvm7pStMKGSlbExfk_--g-1; Thu, 06 Jun 2024 11:57:24 -0400
X-MC-Unique: fRvm7pStMKGSlbExfk_--g-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4215a37801aso8330145e9.2
        for <linux-kselftest@vger.kernel.org>; Thu, 06 Jun 2024 08:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717689443; x=1718294243;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SC1/9LDY5BT6aCpZ61moOmkMqiCWJ7kUcV39vggIIMk=;
        b=X07jIe8cITeNwq8CK97bUQxUemDBmDNZ2EoSgLNhSaDpx8FmAq6qbfiYoGyzKD4oUx
         3m6nZQ0IQVWM9cIPPPBlftGOK19/2Vq7C6LVEoGvDrZ8v+wAolqBEiCr6rVwohd81FPb
         kTRy2Stc41OqSjQQZiUes5VND3pDgVNhWEHgeVa7MtXXKopj4hcj+9jpADyw+wRTz462
         DnWYGqNyJeKCeeZlTaPZKxqesNg9L8IW7FbQu2morTrbHB/cMX5eC0RU2/CfYkL8BSG0
         5OaXtWMsCy0RWGIOa2fPXH8FrB+TPAqW6EWXlZeicWnXX0O+dLlF4ml2XSz0kVMr/wQW
         h07A==
X-Forwarded-Encrypted: i=1; AJvYcCW0k4jWJENzgbElpw3lMgmUAcxWzw37431ojyGmTwH06OgQm6C/Z0wmTMjw4f1+XX0ZBKwSdNZEbavNLm1AKKTaELjEpMxHT8rXKC8YHb09
X-Gm-Message-State: AOJu0YwEsstGnp/kIu8hjfwOQR95kh2pRn0UjOYYoAUV00sbSaLNgFW8
	UaLG7KfIAHv8Dqh+hbRmXZuTeFWBQT/wjXc+D145ooX20kR0Dv2r1GfpsVbddpaRa9XQMXxNW3l
	65cDljjmaxyFWtNoL90++2nq8WpVxalslK5YhaqEIfGkCy4u+y7sy3bLjPKZfEKmu2g==
X-Received: by 2002:a05:600c:1907:b0:419:f241:633b with SMTP id 5b1f17b1804b1-421649ea685mr1084295e9.8.1717689443638;
        Thu, 06 Jun 2024 08:57:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk5zLo3YICJlxOU5MMINSR7YWvvw0UdWKmCe7wM+k92IrefCjUDz33sTgCiwbFQL06tJE/Wg==
X-Received: by 2002:a05:600c:1907:b0:419:f241:633b with SMTP id 5b1f17b1804b1-421649ea685mr1084145e9.8.1717689443344;
        Thu, 06 Jun 2024 08:57:23 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:8800:a73c:ec5b:c02c:5e0b? (p200300cbc7108800a73cec5bc02c5e0b.dip0.t-ipconnect.de. [2003:cb:c710:8800:a73c:ec5b:c02c:5e0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4215c19e97dsm26027125e9.5.2024.06.06.08.57.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jun 2024 08:57:22 -0700 (PDT)
Message-ID: <f199d120-2347-4bc0-8940-155c3c465de9@redhat.com>
Date: Thu, 6 Jun 2024 17:57:21 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: use volatile keyword to not optimize mmap
 read variable
From: David Hildenbrand <david@redhat.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 gost.dev@samsung.com, mcgrof@kernel.org, linux-kselftest@vger.kernel.org,
 Zi Yan <zi.yan@sent.com>, Pankaj Raghav <p.raghav@samsung.com>
References: <20240606135835.600022-1-kernel@pankajraghav.com>
 <5b4e7ef2-3ced-4d4a-989c-e99b06598d32@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <5b4e7ef2-3ced-4d4a-989c-e99b06598d32@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 17:56, David Hildenbrand wrote:
> On 06.06.24 15:58, Pankaj Raghav (Samsung) wrote:
>> From: Pankaj Raghav <p.raghav@samsung.com>
>>
>> create_pagecache_thp_and_fd() in split_huge_page_test.c used the
>> variable dummy to perform mmap read.
>>
>> However, this test was skipped even on XFS which has large folio
>> support. The issue was compiler (gcc 13.2.0) was optimizing out the
>> dummy variable, therefore, not creating huge page in the page cache.
>>
>> Add volatile keyword to force compiler not to optimize out the loop
>> where we read from the mmaped addr.
>>
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
>>    tools/testing/selftests/mm/split_huge_page_test.c | 2 +-
>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/testing/selftests/mm/split_huge_page_test.c b/tools/testing/selftests/mm/split_huge_page_test.c
>> index d3c7f5fb3e7b..c573a58f80ab 100644
>> --- a/tools/testing/selftests/mm/split_huge_page_test.c
>> +++ b/tools/testing/selftests/mm/split_huge_page_test.c
>> @@ -300,7 +300,7 @@ int create_pagecache_thp_and_fd(const char *testfile, size_t fd_size, int *fd,
>>    		char **addr)
>>    {
>>    	size_t i;
>> -	int __attribute__((unused)) dummy = 0;
>> +	volatile int __attribute__((unused)) dummy = 0;
>>    
>>    	srand(time(NULL));
>>    
>>
>> base-commit: d97496ca23a2d4ee80b7302849404859d9058bcd
> 
> The rick we do in some other tests is:
> 
> char *tmp;
> 
> tmp = *whatever;
> asm volatile("" : "+r" (tmp));

char tmp; of course. See cow.c as an example.

-- 
Cheers,

David / dhildenb


