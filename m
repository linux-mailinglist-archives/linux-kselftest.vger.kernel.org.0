Return-Path: <linux-kselftest+bounces-18062-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2409197AA4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 03:57:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ECF51C2712B
	for <lists+linux-kselftest@lfdr.de>; Tue, 17 Sep 2024 01:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F095175A6;
	Tue, 17 Sep 2024 01:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TiIWzgFI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB468A31
	for <linux-kselftest@vger.kernel.org>; Tue, 17 Sep 2024 01:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726538222; cv=none; b=lqb+eOnXMWJvqbVXP1catGovHbFm+4MpWVW4x1NUtrifOvG8jQWMikTF54TL4Wy5ooRENmOBTLcvnQ7U8Vhu9Ju1eBTQT386VYSsr13I+lFzIXte8wrmZ32/ofYpXaRvBzaIQyYM5Vh+IYzSlSTVyWv9FgapTaXRr/ZaQL3kjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726538222; c=relaxed/simple;
	bh=KE499mZiY3UEKk4plgaOrtU4SZKyL2HV8NZ9fIKQRCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gELm+kKwj80MSUdvHHBnUTc/r4XxXTiazFhCmOVq5705EbA1qtNPfPmC3Vds1Mn3j4e8/akRsUviIQzACiOH5ry54vgWV/BohynykCaz+l67i5Tz04G4aa76EjnS2TZJEMna0nnXaeuMM6VL8EYUO3VPg9hNhe4lk2R5V3GHVQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TiIWzgFI; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3e03e9d1f8dso2697831b6e.2
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Sep 2024 18:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726538220; x=1727143020; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WmMcTLc+P7iBUKnVGPTlOrPlGv0NpqcT1SQCN2LOIk=;
        b=TiIWzgFILSO9AQ1sJ8LG8AHYuAyTtumdKYnpJY3cpuFrJFtdz2vxhMWxdGOZOe0d5F
         cHUlNT5wO9bptBg21WMKpXS5D3zBYLxeRn4+aVMa9q5wRdS6hyjt60hOogeNWBfR+S9s
         ZMSVyJ8Y+DK99Mcf0sjfTZXk1UxuMTLBaBEq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726538220; x=1727143020;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7WmMcTLc+P7iBUKnVGPTlOrPlGv0NpqcT1SQCN2LOIk=;
        b=WICXXyNmWgCqRI1YILD4fdj/dtQ32s2ch7rhzW7qa3VKYDOvFZtRAhHfdHf775gVvG
         WMDn3WR5taI/SfdYkq8txQnbRpOrAPuA9yY1i/T/6FwBZofFFpRGFWq5L86TP4th8EBy
         bBmjHyQRqpE5PlRXqjs7fbIQ/dBzxq8PfgBh6PAsJF5T35aBbT0Wmimx/BwHceMWosyH
         DDm/olrW8L46iuJZNR4EjBALkzJQ5/2DXDL6/OMhDT0V/hAy5Y+PPDzm8cgXvxmpXR28
         xmucpOOdLJu6immdpG4fL775OG7ZNwcrHzjblAJmD/60Xskq6bUeJEt8z4U74TBdX4+Z
         goYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxEv2625xSrrz1NMioaYx2WVS3X+13FF9u/8X3mFJ09xOL4VVpifaKbIxGSnRtAwQKZfn3DvpY8FCI/J5vddk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/aqKDjr2NtZFrJ5bQkPk/n83tGn83768UIX24k53uD2rx2hi1
	pb6+dcXB7jQx1wwajur6vuNDqjKq2mHCRimShamm4r3OD5327/nN9INr/KfGfzo=
X-Google-Smtp-Source: AGHT+IFlytWyNbdJdTLUjZkQ39Po3xQqLCVh9Etwt4uiH/F/t4s66dLjJoHmw5ETmH73XVSKw4t8BA==
X-Received: by 2002:a05:6830:34a6:b0:703:676a:5bb0 with SMTP id 46e09a7af769-71109483836mr13863708a34.16.1726538219663;
        Mon, 16 Sep 2024 18:56:59 -0700 (PDT)
Received: from [172.20.0.160] ([50.202.43.9])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b0e29dadsm1102929eaf.36.2024.09.16.18.56.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Sep 2024 18:56:58 -0700 (PDT)
Message-ID: <b3caeb96-2f48-4efd-a56c-e91dae891b48@linuxfoundation.org>
Date: Mon, 16 Sep 2024 19:56:54 -0600
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
 John Hubbard <jhubbard@nvidia.com>, David Hildenbrand <david@redhat.com>
Cc: kernel@collabora.com, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240912103151.1520254-1-usama.anjum@collabora.com>
 <a9ae7dc4-275d-43c3-bf4c-b0090cb6bb12@linuxfoundation.org>
 <3cb9d266-4d4b-4031-8603-da7fd9e3ad47@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <3cb9d266-4d4b-4031-8603-da7fd9e3ad47@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/16/24 00:32, Muhammad Usama Anjum wrote:
> On 9/12/24 8:44 PM, Shuah Khan wrote:
>> On 9/12/24 04:31, Muhammad Usama Anjum wrote:
>>> The value of __NR_userfaultfd was changed to 282 when
>>> asm-generic/unistd.h was included. It makes the test to fail every time
>>> as the correct number of this syscall on x86_64 is 323. Fix the header
>>> to asm/unistd.h.
>>>
>>
>> "please elaborate every time" - I just built on my x86_64 and built
>> just fine.
> The build isn't broken.
> 
>> I am not saying this isn't a problem, it is good to
>> understand why and how it is failing before making the change.
> I mean to say that the test is failing at run time because the correct
> userfaultfd syscall isn't being found with __NR_userfaultfd = 282.
> _NR_userfaultfd's value depends on the header. When asm-generic/unistd.h
> is included, its value (282) is wrong. I've tested on x86_64.
> 

Okay - how do you know this is wrong? can you provide more details.

git grep _NR_userfaultfd
include/uapi/asm-generic/unistd.h:#define __NR_userfaultfd 282
include/uapi/asm-generic/unistd.h:__SYSCALL(__NR_userfaultfd, sys_userfaultfd)
tools/include/uapi/asm-generic/unistd.h:#define __NR_userfaultfd 282

> The fix is simple. Add the correct header which has _NR_userfaultfd = 323.

I need more details on this number.

thanks,
-- Shuah

