Return-Path: <linux-kselftest+bounces-24811-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A8F2A17385
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 21:17:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327B0169C42
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Jan 2025 20:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515071DFDB8;
	Mon, 20 Jan 2025 20:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZKnTCFb4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B819155A52
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 20:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737404218; cv=none; b=mtNmu7+ElxVH8DXEzHdjg9GrsqY374DGrwKOqxk53OyaypQ5eKDzgdayvu3tmHKT3IGY4hpmPtmrZehyIcu3DAn56CCw0VQ4POfrxYi9jsA+OX5UUn8wr99jD49ONTELK1ayKsa+UXRgOm9QmKemrL4FOZlfLHdsHryCjMJjEH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737404218; c=relaxed/simple;
	bh=e+kEZyr1RVHsuGELrmRbRFS7qupW+20p6+FHJt3KzSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T4OLNNXiEh9N8Ua5ZWh2Qd4C5Nr1FtwPaW0dc5xpYMERxRl/P5RhC/9A+bySTHM7G3v5gtPyYmdHxqjEZrej+CuCFPGI0Elup+TTqAAYI5rqqJsgnjMnsd49mpLWHcxGBweyMSGGrA/6x2kCvse6t1TK4ERpe7CkuPKRAVcb1vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZKnTCFb4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737404215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rxNZDgHHpNg2/W+/DtkEp4r5rDDnZBfDci05R81CKvM=;
	b=ZKnTCFb4UzFJq8ET0V6aGevIz9O19A3z0Jt6nrOE9+h9nruJZvNiiQDiPAocvp60rBjHKG
	/liXEya76ILTAooDowUblc8KHehmJYJeEGKvEwgM8GxH3Kmc+tbN9HPNr+LmmERn8k6F7A
	8XWjU7DLABarssABaBI5+KF611PeiWs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-ifY5THK4NS6-DksBbanDDw-1; Mon, 20 Jan 2025 15:16:54 -0500
X-MC-Unique: ifY5THK4NS6-DksBbanDDw-1
X-Mimecast-MFC-AGG-ID: ifY5THK4NS6-DksBbanDDw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361b090d23so25424105e9.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Jan 2025 12:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737404213; x=1738009013;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rxNZDgHHpNg2/W+/DtkEp4r5rDDnZBfDci05R81CKvM=;
        b=DWnZuMLXpjx7s53sbQXMNTaNvNSQzmtrDJiWNej5/UDzdbmFNZDpRr3rfXjOwt45k8
         b0RrySyAGqLl3Q4eMVKCBxsA7jCNBrNRdlAnnpyvEc6WoqmAPQw7rT7kdZiH9VxPCuDH
         +v89MljdZ2DudvjaqRg3u6gGqqVDGDqn8aCWKkbgHXpLDoregVXPkuxIPYNrQgO4eTM7
         RproTC2j/mOeuRD+yaP/EKjiY5CY4eWbw4U4WJWerWaW9+PsOBCga/EZgJqnHyi8JbbV
         Vx4qpJH0ZWqjZ73oHnUOwmBPBaek6OcTulzztTvS/hadej0ZXdyePesxGOj9h0d2GV3S
         CEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSkvpctiPjq41+mdMhqFl/oKN9jbadO2s0/qYBSfCtO/jhvTTACdG3RZUpSG5AfBL91fp9Csm6vuQdlSKQuoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySekiL06fYYSMgsOJhXv/pfOcqCNmTxoScf/e/y1mb31dydWLc
	hE9OifOdXTElRkRH8HsVj2tZtnCK/TIh/ix00ZdVCoOYQj6qkN5iIA4aGP6/jbRGh4xqu6v522D
	xJDs+Sv5LjLWEiLg1TcVA0qirhS7b5vsmmYU8loIAQH4NJd9QVjScGGfMfTxccKy44Q==
X-Gm-Gg: ASbGncsZCgU77MN9I+KGyYSoIcy59ujdfdiYGrU5o7tAiAq9yv7+vRaLVWmH8amxFk1
	+k68GMuQ6blvwKJIXh6VE3tUNK63/lBrr/dSFsm98uSEcQPIPYSkVaWOKtyBJTvBC179p3FVAIB
	/pcn4Th32C0RPcPLn2+WcQuS1Aqg0Ylt4ZN6Xaz5Mz2kLoCkQ3rMlUmqYWW9tJcyTwLAPyzNNZv
	Q7fIJBkZTQysjwQcn0yt2jBGudskWYgo7NLPVUYyaGxRhfviTO2nn9YMQkkrIZjqKLfsUkstqJw
	p+57fJBnljGyPd6UHElGHGXV
X-Received: by 2002:a05:600c:4e0c:b0:434:a802:e9b2 with SMTP id 5b1f17b1804b1-438913bd972mr131386065e9.4.1737404212719;
        Mon, 20 Jan 2025 12:16:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHhXW3eC8X/Z3zk3Q5/MJeYpypdZKm5hACpaMl4+QVG94buci3CHFN5dgx/2XA2nw5mlfIleQ==
X-Received: by 2002:a05:600c:4e0c:b0:434:a802:e9b2 with SMTP id 5b1f17b1804b1-438913bd972mr131385905e9.4.1737404212333;
        Mon, 20 Jan 2025 12:16:52 -0800 (PST)
Received: from [192.168.3.141] (p4ff23481.dip0.t-ipconnect.de. [79.242.52.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499821sm212197915e9.2.2025.01.20.12.16.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jan 2025 12:16:51 -0800 (PST)
Message-ID: <3613bdb9-a933-4027-89e9-03a261410f68@redhat.com>
Date: Mon, 20 Jan 2025 21:16:50 +0100
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] selftests/mm/cow : Fix memory leak in
 child_vmsplice_memcmp_fn()
To: liuye <liuye@kylinos.cn>, akpm@linux-foundation.org, shuah@kernel.org
Cc: linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250114022929.46364-1-liuye@kylinos.cn>
 <4fd2fdca-ea98-499f-ba04-0f1140180ba4@redhat.com>
 <778941db-27fb-48b3-8d98-81d1673deffc@kylinos.cn>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <778941db-27fb-48b3-8d98-81d1673deffc@kylinos.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 15.01.25 06:45, liuye wrote:
> 
> 在 2025/1/14 18:23, David Hildenbrand 写道:
>> On 14.01.25 03:29, liuye wrote:
>>>       Release memory before exception branch returns to prevent memory
>>> leaks.
>>>
>>> Signed-off-by: liuye <liuye@kylinos.cn>
>>> ---
>>>    tools/testing/selftests/mm/cow.c | 21 ++++++++++++++++-----
>>>    1 file changed, 16 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/tools/testing/selftests/mm/cow.c
>>> b/tools/testing/selftests/mm/cow.c
>>> index 1238e1c5aae1..959327ba6258 100644
>>> --- a/tools/testing/selftests/mm/cow.c
>>> +++ b/tools/testing/selftests/mm/cow.c
>>> @@ -167,19 +167,30 @@ static int child_vmsplice_memcmp_fn(char *mem,
>>> size_t size,
>>>        /* Backup the original content. */
>>>        memcpy(old, mem, size);
>>>    -    if (pipe(fds) < 0)
>>> +    if (pipe(fds) < 0) {
>>> +        free(old);
>>> +        free(new);
>>>            return -errno;
>>> -
>>> +    }
>>>        /* Trigger a read-only pin. */
>>>        transferred = vmsplice(fds[1], &iov, 1, 0);
>>> -    if (transferred < 0)
>>> +    if (transferred < 0) {
>>> +        free(old);
>>> +        free(new);
>>>            return -errno;
>>> -    if (transferred == 0)
>>> +    }
>>> +    if (transferred == 0) {
>>> +        free(old);
>>> +        free(new);
>>>            return -EINVAL;
>>> +    }
>>>          /* Unmap it from our page tables. */
>>> -    if (munmap(mem, size) < 0)
>>> +    if (munmap(mem, size) < 0) {
>>> +        free(old);
>>> +        free(new);
>>>            return -errno;
>>> +    }
>>
>> We are immediately exiting the test in do_test_cow_in_parent()
>>      exit(fn(mem, size, &comm_pipes));
>>
>> Your changes make the code unnecessarily more complicated to read, so
>> I'm not in favor of this one to make some checker tool happy.
>>
> 
> It is indeed exiting the process. After the process exits, the memory
> will be reclaimed naturally.
> 
> As code in the kernel branch, it will be used by beginners, such as me,
> for learning. Modifications are recommended.
> 
> Regarding the readability of the code, is the following modification
> better than before?
> 
> 
> 
> diff --git a/tools/testing/selftests/mm/cow.c
> b/tools/testing/selftests/mm/cow.c
> index 1238e1c5aae1..db5e71c5bf2f 100644
> --- a/tools/testing/selftests/mm/cow.c
> +++ b/tools/testing/selftests/mm/cow.c
> @@ -167,19 +167,21 @@ static int child_vmsplice_memcmp_fn(char *mem,
> size_t size,
>           /* Backup the original content. */
>           memcpy(old, mem, size);
> 
> -       if (pipe(fds) < 0)
> -               return -errno;
> +       if (pipe(fds) < 0)
> +               goto free;
> 
>           /* Trigger a read-only pin. */
>           transferred = vmsplice(fds[1], &iov, 1, 0);
> -       if (transferred < 0)
> -               return -errno;
> -       if (transferred == 0)
> -               return -EINVAL;
> +       if (transferred < 0)
> +               goto free;
> +       if (transferred == 0) {
> +               error = EINVAL;
> +               goto free;
> +       }
> 
>           /* Unmap it from our page tables. */
>           if (munmap(mem, size) < 0)
> -               return -errno;
> +               goto free;
> 
>           /* Wait until the parent modified it. */
>           write(comm_pipes->child_ready[1], "0", 1);
> @@ -194,6 +196,10 @@ static int child_vmsplice_memcmp_fn(char *mem,
> size_t size,
>           }
> 
>           return memcmp(old, new, transferred);
> +free:
> +       free(old);
> +       free(new);
> +       return -error;
>    }

As an alternative, we can replace all return statements by explicit exit() ?

-- 
Cheers,

David / dhildenb


