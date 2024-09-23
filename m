Return-Path: <linux-kselftest+bounces-18235-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CB897EEC9
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 18:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD975280D8A
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5175E19E97A;
	Mon, 23 Sep 2024 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Mit84Inw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9DD27715
	for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 16:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107375; cv=none; b=qVmTnDB67kNgR2wmnTryWRHTb8ZFCDmoJgBqFDD/Hx5rfcUAWK1rBHe6Kj3CtZPV54eIEwDnXiGXdXXFEc+cpSeCxoYfHvAK/ghdcNZn1cYQCM1eyLxQ57Pxb3D67EukVH3OeaxZV4FZwE3ozUvyGF2msME2jbMQJ5ZDzXlz1lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107375; c=relaxed/simple;
	bh=6TuVerOEXrd71O5paKQU3CUKJdwlYlsaDFlvF9rRkm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NeafymR5Z3xs1G1SIm3lH25KK2dz7SmtuA8sky9OZ5FgmZ6M+/fedJhwGmPSSXZzqq+TyL+0iqdYPj2Ll11fOWVEmcm9Ut5t1ojLbtIpl3jOeF6mTI6PEI+na4PZ9SKcV0b8Joy0Gz6jMFENQ+H2DYvfHfMiavgvO46EcwEGTQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Mit84Inw; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-82aa7c3b498so145382139f.1
        for <linux-kselftest@vger.kernel.org>; Mon, 23 Sep 2024 09:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1727107373; x=1727712173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U7TYhe1rpxxrqplqnvp9IfDZ+pr34hbFyuUI8EXCDkc=;
        b=Mit84InwB9n5c6VqFOdM/3q1ipZZhXwUcp4wN9GYsEkUAazp0zM3iDxDp2UvXMM3HN
         SMKeRaNwFa/Tt3YXvxuphcLPQoLS0ZuHz3Q6TLsH6btcxqHO0lgBwL644oBr8j4Y2CuY
         DIOJKltcdzmcHkACYWaLHwZwfkg1kLVm8lx18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727107373; x=1727712173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U7TYhe1rpxxrqplqnvp9IfDZ+pr34hbFyuUI8EXCDkc=;
        b=jHGBzWKsBkYiwKkD0yAEo8TR2t3o7fydkYICgIWCuOQDCBJ2xtzrliu/L/aDX01jYD
         Pkbk4pcZkMjbLmsjDQMcJ9SMHldNn4n3UATl7EWT10kQRRBAC86HKHB7iK3HsltZqUwg
         O5NxehgmJnGSWgrdWBIOoaneyZFIWtFNGPYhlOHvxtQXq1aBMsXanUfy11ReI/K2W0Vs
         bP664xyg6f34KKr6IT6F1ien3PQtvJNsRwRBx4dXFltHAnyCTkI5RCXmURfYzHD+7AZ4
         rarudy6+A4qWQMImNvOnaPfAWvRtuq/JSwmPgA8+b9v8ocrYFRagKVwv5USBFoamokc7
         DNHg==
X-Forwarded-Encrypted: i=1; AJvYcCWOulcSd4c2ubi0JknRpD1TmuHpqpuuc7CfH8ZRz8u946S+5+4gNLNKeimu+vUP2F8N3XvPwNFZovdeSCtKFrA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4mXuc0wb0h48XqiKjCOcYNQVloCqlX6pAaHiMKuQem1Xf+YWt
	pzl5Rdv7moeWSuCrLDTiu8/h/CacrpmqJ9LWKua7iKz7EAy8WuIpJTAss6lu5bQ=
X-Google-Smtp-Source: AGHT+IFbTlKf8TKMANszqjy1yElT6pwu6gCQvDIujsaJntV8C2slJwQVG9f9umm5t1EUKhexryb9bQ==
X-Received: by 2002:a05:6602:2c93:b0:82c:f7b1:a9fb with SMTP id ca18e2360f4ac-8323b9df004mr10698439f.5.1727107372503;
        Mon, 23 Sep 2024 09:02:52 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-82d492b34b6sm560153439f.23.2024.09.23.09.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 09:02:51 -0700 (PDT)
Message-ID: <db8b758e-9051-4ee0-b0e7-3b54eda0c71b@linuxfoundation.org>
Date: Mon, 23 Sep 2024 10:02:49 -0600
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
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Andrea Arcangeli <aarcange@redhat.com>, Kim Phillips <kim.phillips@arm.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, Shuah Khan <skhan@linuxfoundation.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
 <3cb9d266-4d4b-4031-8603-da7fd9e3ad47@collabora.com>
 <b3caeb96-2f48-4efd-a56c-e91dae891b48@linuxfoundation.org>
 <0b847784-a95f-4ed5-a0fb-1b7b4023df13@collabora.com>
 <e2a4d2b4-ca3f-4d21-82d5-b87bc9de9358@linuxfoundation.org>
 <e4e2095e-3280-4bfc-8129-80b8d00d146d@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <e4e2095e-3280-4bfc-8129-80b8d00d146d@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/24 23:35, Muhammad Usama Anjum wrote:
> ...
> 
>>> grep -rnIF "#define __NR_userfaultfd"
>>> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>>> arch/x86/include/generated/uapi/asm/unistd_32.h:374:#define
>>> __NR_userfaultfd 374
>>> arch/x86/include/generated/uapi/asm/unistd_64.h:327:#define
>>> __NR_userfaultfd 323
>>> arch/x86/include/generated/uapi/asm/unistd_x32.h:282:#define
>>> __NR_userfaultfd (__X32_SYSCALL_BIT + 323)
>>> arch/arm/include/generated/uapi/asm/unistd-eabi.h:347:#define
>>> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
>>> arch/arm/include/generated/uapi/asm/unistd-oabi.h:359:#define
>>> __NR_userfaultfd (__NR_SYSCALL_BASE + 388)
>>> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>>>
>>> The number is dependent on the architecture. The above data shows that:
>>> x86    374
>>> x86_64    323
>>
>> Correct and the generated header files do the right thing and it is good to
>> include them as this patch does.
>>
>> This is a good find and fix. I wish you explained this in your changelog.
>> Please add more details when you send v2.
> I'm sending v2
> 
>>
>> There could be other issues lurking based on what I found.
>>
>> The other two files are the problem where they hard code it to 282 without
>> taking the __NR_SYSCALL_BASE for the arch into consideration:
>>
>> tools/include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>> include/uapi/asm-generic/unistd.h:681:#define __NR_userfaultfd 282
>>
>>>
>>> I'm unable to find the history of why it is set to 282 in unistd.h and
>>> when this problem happened.
>>
>> According to git history it is added in the following commit to
>> include/uapi/asm-generic/unistd.h:
>>
>> 09f7298100ea9767324298ab0c7979f6d7463183
>> Subject: [PATCH] userfaultfd: register uapi generic syscall (aarch64)
>>
>> and it is added in the following commit to
>> tools/include/uapi/asm-generic/unistd.h
>> 34b009cfde2b8ce20a69c7bfd6bad4ce0e7cd970
>> Subject: [PATCH] tools include: Grab copies of arm64 dependent unistd.h
>> files
>>
>> I think, the above defines from include/uapi/asm-generic/unistd.h and
>> tools/include/uapi/asm-generic/unistd.h should be removed.
>>
>> Maybe others familiar with userfaultfd can determine the best course of
>> action.
>> We might have other NR_ defines in these two files that are causing
>> problems
>> for tests and tools that we haven't uncovered yet.
> Added authors of these patches.
> 

Thank you. Would you be able top follow up on this and send patches
to remove these defines if it deemed to be the correct solution?

thanks,
-- Shuah


