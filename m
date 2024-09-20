Return-Path: <linux-kselftest+bounces-18169-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A149997D732
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 16:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621D52844B1
	for <lists+linux-kselftest@lfdr.de>; Fri, 20 Sep 2024 14:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3062317C22E;
	Fri, 20 Sep 2024 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KAvxvmtG"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3F917C21B
	for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 14:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726844357; cv=none; b=VDsSCXNBW4tNuoxzxWIdZ+sPSeemtxkciQ+VK9zmtd6N6UoT1SvjwVBXISnH0JhOM7X0Z+9L5/r+OjIruCM2daZVWotZdfPa8qtJkQeAmFqumrjNDRBAaJmXFBR8qpsmOYZ5aF3mQtAAWba36/B5NZ0Nbx7HCzDH3aInQIB8aqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726844357; c=relaxed/simple;
	bh=sKDpkDMkerixzA6Cw6aEtvJMOjylAkUEtEbo9QU2oQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PlKWfQfYz1zyZrVwhsXr1+5OBWO+kRvaaC8VB6bFld9zJMyugC8rq4rsbe/N5waX4bSmc1xjpgw8cIkgzALclr/MhDA24A8vcr5EN73m8JBzLD27nTbePGnkZA16vVGEQYPx/8C3tq2A2C7fgMfDQ6EJXuX791bVU/BH2bfs3Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KAvxvmtG; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-831e62bfa98so112410239f.1
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Sep 2024 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726844354; x=1727449154; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WYxe9kwrqo1GfeH3C0KfOo+V1SDp2i8OljG3N7NL5wA=;
        b=KAvxvmtGBjV1aY5p/t4zUUgPBvFAyHZgLjomiC6K/XVk9X8Ww+ECJe/HH0DUoXZR/s
         DgonTj+PP8yADz4ySZkK3vxu7cPe+rQ1GwcRA+seENc3p37N5G+tfw3XELXTJOXVdNNx
         N5Jw7kZqjAsL9HDl36knG8qy7eKuTRX0bS2+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726844354; x=1727449154;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WYxe9kwrqo1GfeH3C0KfOo+V1SDp2i8OljG3N7NL5wA=;
        b=fpp2YmoIPeE6Zdb3U7atuLse1ihRHRHhtr4nClAJb77sr7GgiOG1++Ta7I+omUp4Z6
         2X2falQutp3jZObUGa+44JAqetitz/rsMf6ghgQdwzNl8YF1jn6q8A4Bw41IJWmk6nW3
         I+LVUANgoRE8MvB6pl71P/RoQR4EtTkGNDT1W9D81/On4VnWdxbhOyzhTMtJ6mbjmJRp
         Su/uzv+Bhd1cV+vck8KuTIOTWWpyx9fn+AiH3jjGpSLIdMtrHW3hLFKS7q3jiUTlHe1X
         N0XrgxJTCdqPWLlxrLrs/bnHlvoKFhblDkKKf0XBNJcAESsaRYtHGPsRK5RSq0vtdbsV
         gI8g==
X-Forwarded-Encrypted: i=1; AJvYcCXIMRCabeIsY0wRbipEmyzjt6VzYRSWCL3X1Juh+3vXTdpvZo+TcSAEHqZbjsKPPoJUZXg+fJVGcrBaMz7+25I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/jcLQv9kt4SB0h3T9UyA4p0ZjO9s7WZpC/1LhWyMKZcDI5yl2
	gzI1g3hD1lagzAEChXdhmrL7QQTH56ktZAhH77C5NYjvvYwW1qTGYfOYbxoMl9o=
X-Google-Smtp-Source: AGHT+IFR1dxehC1DeauIKJjZxKxCtU9ZHfRiqWSorqoWsZuZa7+canQ6L2+MemljTc3siNvr4bdfdg==
X-Received: by 2002:a05:6e02:1c49:b0:3a0:c88c:e668 with SMTP id e9e14a558f8ab-3a0c8cba344mr35924225ab.14.1726844354353;
        Fri, 20 Sep 2024 07:59:14 -0700 (PDT)
Received: from [10.212.145.178] ([12.216.155.19])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a092e72080sm41727115ab.68.2024.09.20.07.59.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 07:59:13 -0700 (PDT)
Message-ID: <e2a4d2b4-ca3f-4d21-82d5-b87bc9de9358@linuxfoundation.org>
Date: Fri, 20 Sep 2024 08:59:12 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kselftests: mm: Fix wrong __NR_userfaultfd value
To: Muhammad Usama Anjum <Usama.Anjum@collabora.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
 <3cb9d266-4d4b-4031-8603-da7fd9e3ad47@collabora.com>
 <b3caeb96-2f48-4efd-a56c-e91dae891b48@linuxfoundation.org>
 <0b847784-a95f-4ed5-a0fb-1b7b4023df13@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <0b847784-a95f-4ed5-a0fb-1b7b4023df13@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/24 23:46, Muhammad Usama Anjum wrote:
> On 9/17/24 6:56 AM, Shuah Khan wrote:
>> On 9/16/24 00:32, Muhammad Usama Anjum wrote:
>>> On 9/12/24 8:44 PM, Shuah Khan wrote:
>>>> On 9/12/24 04:31, Muhammad Usama Anjum wrote:
>>>>> The value of __NR_userfaultfd was changed to 282 when
>>>>> asm-generic/unistd.h was included. It makes the test to fail every time
>>>>> as the correct number of this syscall on x86_64 is 323. Fix the header
>>>>> to asm/unistd.h.
>>>>>
>>>>
>>>> "please elaborate every time" - I just built on my x86_64 and built
>>>> just fine.
>>> The build isn't broken.
>>>
>>>> I am not saying this isn't a problem, it is good to
>>>> understand why and how it is failing before making the change.
>>> I mean to say that the test is failing at run time because the correct
>>> userfaultfd syscall isn't being found with __NR_userfaultfd = 282.
>>> _NR_userfaultfd's value depends on the header. When asm-generic/unistd.h
>>> is included, its value (282) is wrong. I've tested on x86_64.
>>>
>>
>> Okay - how do you know this is wrong? can you provide more details.
>>
>> git grep _NR_userfaultfd
>> include/uapi/asm-generic/unistd.h:#define __NR_userfaultfd 282
>> include/uapi/asm-generic/unistd.h:__SYSCALL(__NR_userfaultfd,
>> sys_userfaultfd)
>> tools/include/uapi/asm-generic/unistd.h:#define __NR_userfaultfd 282
>>
>>> The fix is simple. Add the correct header which has _NR_userfaultfd =
>>> 323.
> 
> grep -rnIF "#define __NR_userfaultfd"
> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
> __NR_userfaultfd 374
> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
> __NR_userfaultfd 323
> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
> __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
> 
> The number is dependent on the architecture. The above data shows that:
> x86	374
> x86_64	323

Correct and the generated header files do the right thing and it is good to
include them as this patch does.

This is a good find and fix. I wish you explained this in your changelog.
Please add more details when you send v2.

There could be other issues lurking based on what I found.

The other two files are the problem where they hard code it to 282 without
taking the __NR_SYSCALL_BASE for the arch into consideration:

tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282

> 
> I'm unable to find the history of why it is set to 282 in unistd.h and
> when this problem happened.

According to git history it is added in the following commit to
include/uapi/asm-generic/unistd.h:

09f7298100ea9767324298ab0c7979f6d7463183
Subject: [PATCH] userfaultfd: register uapi generic syscall (aarch64)

and it is added in the following commit to tools/include/uapi/asm-generic/unistd.h
34b009cfde2b8ce20a69c7bfd6bad4ce0e7cd970
Subject: [PATCH] tools include: Grab copies of arm64 dependent unistd.h files

I think, the above defines from include/uapi/asm-generic/unistd.h and
tools/include/uapi/asm-generic/unistd.h should be removed.

Maybe others familiar with userfaultfd can determine the best course of action.
We might have other NR_ defines in these two files that are causing problems
for tests and tools that we haven't uncovered yet.

thanks,
-- Shuah

