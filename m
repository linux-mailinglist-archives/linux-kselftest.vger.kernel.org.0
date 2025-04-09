Return-Path: <linux-kselftest+bounces-30407-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E84A821F5
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 12:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBE38841B0
	for <lists+linux-kselftest@lfdr.de>; Wed,  9 Apr 2025 10:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 443BA25DB0B;
	Wed,  9 Apr 2025 10:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBI+1Z0t"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC325DAF1
	for <linux-kselftest@vger.kernel.org>; Wed,  9 Apr 2025 10:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194118; cv=none; b=DxFxpMe+mlBN6tozPBmgE2Bl1c3Cqy4bfxBbsnp65tXkxk9IL1q8G8+bpC+YYEl8h3aQT1WbyyV6C2DeZZsLIXBa5NjoAEFGvqeoa6A2DOx3LokgHOzJwhXJUzFiKllKdsRZ14ASZi8uzB/NEOQNehot9yogWAbpdbkqj8qQnE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194118; c=relaxed/simple;
	bh=ozx1oE1Vb8XpTfuDxxiF82b96woefCQbdaPQvSNc+Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mHiF2B0mRQn87whhrGyBz7l+UmVL1hdx7d+oZ3V16qbP90eMh48SkAZzuJFNIpSvX53Gq00katPCHEMPe5Dz4GkAe9QoHYgCNlypxr9YtQ6m3XuylnR4HOssnxAeqED29Qe2/v4FC08AbAojXd4mKSCEsAqs7cZ+rZm4gk/yf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iBI+1Z0t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vax5kzNSRjJfsSUObj6oAwRYrGQvDWS+5kWRuE7ahLI=;
	b=iBI+1Z0tj00Eh+5jVG27bSDooQqy81h/wrXVgk7ICPBcmnjEZHALjlWNBP4Smvyk1zmE1a
	PTvx/nDqvWbUFMtiUzT39xwlNxmDk8zlldAhWfnAhGTcMvEXXq8kzKt10WL5XZlJqPX3rL
	SvqRqANcJ0l+Kp2huMMMH4LHb/g1RUM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-_Nw0zG3mMXmeM7t9-P5rpw-1; Wed, 09 Apr 2025 06:21:52 -0400
X-MC-Unique: _Nw0zG3mMXmeM7t9-P5rpw-1
X-Mimecast-MFC-AGG-ID: _Nw0zG3mMXmeM7t9-P5rpw_1744194111
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so53390545e9.2
        for <linux-kselftest@vger.kernel.org>; Wed, 09 Apr 2025 03:21:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194111; x=1744798911;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vax5kzNSRjJfsSUObj6oAwRYrGQvDWS+5kWRuE7ahLI=;
        b=j2WYH4RA5bYxsE+wXFkaRC0yYXG8CsQei99eqeeKi5FuK0Q9yyh6U9T5B0VBCvYnBl
         3j9fGrm+K0dB+PfmD00OwVHkdEym3Cb+c13F0B77H0dbdj57CspyS4GN3QpGxS1ShA0G
         NzjLDsMz21+PCVG5y4uB4hG7g5yR8FbZtRhV6yor6lBYphpelEaCio9TDs24+s14XFNL
         ciUv9SDsNSDhDgBMc7U76Ebc5W+cmCe2fkDjmGraGyg7EXjstOBGOkR6RBIJszLtCS8Y
         39FD/Zp6VTiyKnqrnS91SUGY0tUAtxSmUiPAehewkIIF5qID/DHjwdwRngYNU224x+I0
         /xxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcpie+kJnnY8lkaaE/8yyuMYJFNUq74YJE/4pZYZZyolBb90kRcmPsNVtZvVe+rGi0aO/nsPXGkaXr0J6wJwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOcJeRwnHA9IEbXQpd4/peh+nwLAfQunazkc8Qz/lgbO5EmsPH
	hfy5s/uvGcod6XTbYaIe4gDEd5zMEf4UVatpqp4Zi1t9w2dMgsCcdp6qhs9/Lp375L43+FbFb1V
	jM/ua9cPfNoVrgTjEpIdkAIa1uhvWfQLGS50u+ViZ+lWVjy8J307XUQY5yWLc9a8oqg==
X-Gm-Gg: ASbGncuT71Y1JpgleEX5xnEUF7lsZOm/kUyHWUPkUhHbMR4Ki8vkvzVgmwddfaShpgh
	NftV6u32ZOJct3Ta4P3ip7hCBbfvtIwxN+qdCzOq5tpnXyoynKLcE8Hvc4S9EoKtQMezrCLgkHM
	R2YA8e0i1MGG+tr1oS3bsYP7sqTt7xafFs6sSLKnZ4p/AafdnnFS6Ug1oQQNhfH+I5kPhEwKk4M
	CUjTBqUSGzFT5QsVx2FAvByTtXAmHVI4CEzIwlTH8vHvXWFd/PmV2LeqDEXA3Dw3Lc1gAqSpKvM
	ea26Pe9lW82FFVDRm02tBGP3GMaeFDfiScFNpyHY9P6zk7QFLh0gumX56XkYVazSgnTP4cUx8Hq
	IAs1lAN4Rg9XAH+BDuXq+n1nqfSFIt/25+g==
X-Received: by 2002:a05:600c:354c:b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-43f1ed4d947mr16877885e9.32.1744194111012;
        Wed, 09 Apr 2025 03:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtPQukVggm6+Z/VAj1C5UvBBLlQxFOS1u8oW5XOUlYBxdmsZkESyrDqTdlbjzY2UeSZVgtlQ==
X-Received: by 2002:a05:600c:354c:b0:43e:ee80:c233 with SMTP id 5b1f17b1804b1-43f1ed4d947mr16877665e9.32.1744194110641;
        Wed, 09 Apr 2025 03:21:50 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:8400:ed9b:a3a:88e5:c6a? (p200300cbc70d8400ed9b0a3a88e50c6a.dip0.t-ipconnect.de. [2003:cb:c70d:8400:ed9b:a3a:88e5:c6a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f233a2a13sm11396975e9.10.2025.04.09.03.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 03:21:49 -0700 (PDT)
Message-ID: <dcf585d8-8293-42ea-9d31-23825cc2f658@redhat.com>
Date: Wed, 9 Apr 2025 12:21:48 +0200
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm: Fix compiler -Wmaybe-uninitialized warning
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250409095006.1422620-1-anshuman.khandual@arm.com>
 <9da46633-e9c1-42a7-b52b-16cf89836abc@redhat.com>
 <0ec536d2-4b82-4e97-9985-15cd431059ba@arm.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <0ec536d2-4b82-4e97-9985-15cd431059ba@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09.04.25 12:09, Anshuman Khandual wrote:
> 
> 
> On 4/9/25 15:27, David Hildenbrand wrote:
>> On 09.04.25 11:50, Anshuman Khandual wrote:
>>> Following build warning comes up for cow test as 'transferred' variable has
>>> not been initialized. Fix the warning via zero init for the variable.
>>>
>>>     CC       cow
>>> cow.c: In function ‘do_test_vmsplice_in_parent’:
>>> cow.c:365:61: warning: ‘transferred’ may be used uninitialized [-Wmaybe-uninitialized]
>>>     365 |                 cur = read(fds[0], new + total, transferred - total);
>>>         |                                                 ~~~~~~~~~~~~^~~~~~~
>>> cow.c:296:29: note: ‘transferred’ was declared here
>>>     296 |         ssize_t cur, total, transferred;
>>>         |                             ^~~~~~~~~~~
>>>     CC       compaction_test
>>>     CC       gup_longterm
>>>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Shuah Khan <shuah@kernel.org>
>>> Cc: linux-mm@kvack.org
>>> Cc: linux-kselftest@vger.kernel.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>> ---
>>>    tools/testing/selftests/mm/cow.c | 2 +-
>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/cow.c b/tools/testing/selftests/mm/cow.c
>>> index f0cb14ea8608..b6cfe0a4b7df 100644
>>> --- a/tools/testing/selftests/mm/cow.c
>>> +++ b/tools/testing/selftests/mm/cow.c
>>> @@ -293,7 +293,7 @@ static void do_test_vmsplice_in_parent(char *mem, size_t size,
>>>            .iov_base = mem,
>>>            .iov_len = size,
>>>        };
>>> -    ssize_t cur, total, transferred;
>>> +    ssize_t cur, total, transferred = 0;
>>>        struct comm_pipes comm_pipes;
>>>        char *old, *new;
>>>        int ret, fds[2];
>>
>>
>> if (before_fork) {
>>      transferred = vmsplice(fds[1], &iov, 1, 0);
>> ...
>>
>> if (!before_fork) {
>>      transferred = vmsplice(fds[1], &iov, 1, 0);
>> ...
>>
>> for (total = 0; total < transferred; total += cur) {
>> ...
>>
>>
>> And I don't see any jump label that could jump to code that would ve using transferred.
>>
>> What am I missing?
> 
> Probably because both those conditional statements are not mutually
> exclusive above with an if-else construct. Hence compiler flags it
> rather as a false positive ? Initializing with 0 just works around
> that false positive.

This is something the compiler should clearly be able to verify. 
before_fork is never changed in that function.

We should not work around wrong compilers.

Which compiler are you using such that you run into this issue?

-- 
Cheers,

David / dhildenb


