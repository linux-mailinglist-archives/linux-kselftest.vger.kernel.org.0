Return-Path: <linux-kselftest+bounces-37591-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13267B0AB47
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 23:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855051C27C8E
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jul 2025 21:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967B621CC4D;
	Fri, 18 Jul 2025 21:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N+tn9SBV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C449518E20
	for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 21:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873038; cv=none; b=n7TQkyhba+LDjgbyGVJc3dkk6DBlF0K5Dj9P3wEpJg8wwrhNI88G/AAo5S6kvXr6zC2MwY8CJliGE7l4o0K5iwVF4BzaZMgdi88yzwqouR4azH59AlJrxsBZICb1l2iESKySQcVYvgdmt8Qqvwgxyqk/5gOW2Wg/DwmQDyL90Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873038; c=relaxed/simple;
	bh=eoeq2lfkKQQfblu8s5uJwmmDlVAzN3yXJqVPP+2D0MY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4EewcXf82oW/DTCDPjEttCxfFaQGX3TmTTXrrAZC1rfxzOZMElsnvnxrSsfxDAtrZ+F19vP+eMpuTu8r3I9d7FWe5NYz4fLWuot+sIjjdWITWrD0E0EaCN+7jyH51kygi3JJ5YhASyTbicYwSXt2h1Poh6PQYZOFbKD1qkN0SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N+tn9SBV; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-879502274cfso85172339f.0
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jul 2025 14:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1752873035; x=1753477835; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGhXZyOJNCmIt8fGNKAY+r1NcPVJKPwyIQ57/sp4SqQ=;
        b=N+tn9SBV1LyRRQV23UL8H17kdtO6fGArP0dFg//ZCO0gwi2IZfv9r7o0rO7e4NowiJ
         l3gNVpbGeRRkRXDRAcLO0vuCz1MNVXdOQa85UGLw3i51INycRHpERSlQ3vTG5DYSEK4U
         UyHOX/n44SKEx/QzRZR7+qIuB+SxLQ2KOGp24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752873035; x=1753477835;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGhXZyOJNCmIt8fGNKAY+r1NcPVJKPwyIQ57/sp4SqQ=;
        b=MQfRfShsF9t8eJxCP2gDcpFqrvz2i+mIJCvLglJv7PjawNPTZ5nzRiTEZDo8MnWLFg
         heqxUzABOXgc4j58tyHsH6VKmofzZUIrO5v61qFheL2D36RNh8gOhU1SnTKuyIDEECUB
         GgR1VlOTWimRxNDlbPzhWFKA32tFDcp6TTwl/Mfw+RmcTtYA2GbSqXJzqi5F9KoGPxEP
         WRu14fYaRF1V/OzODzplu9IAqJ7OmR8KRe3EaEBEhfm+VhL2kRGF9GrOneC0H6whuvMS
         y2Eqs0/0PLB/BU2Bm7Lp49LE5V9yicl5REGOgVi6TFWSwQE1tnkY5epyC4UF1HoovQgi
         3oPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXca6iidalipitYynDsP3R0Ib3uJYDR2MNRNgTXONhR6S0Tq/XW5zAk1U8CFx6GB1dgrqX0XC03+ZnQwmvMDro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkZ2HKFCych/Lg5FWBTTTVJMX1W6D9YzZt85ewG/0Dc/pZE5cc
	N9Dil21uqsN3I7FY/v/zePGXG2jhevCdgIEPOMenkfc2avMd41WnszO3OsF1xsxL+Hw=
X-Gm-Gg: ASbGnct6TkRj5HlY4/+KkCb8F+HMeCv/r9AREU7gjxvwA/WX2YtxqHylNuPshY/tEIi
	aNobzRFnuhcs3hAaKwCXCgrWMeTq8pd5Sa9D4qX0ImvqkrXOYiQ0fHfCkv/2o/t2zRVUPV/S0P4
	Nq7TNhsTVmVMKJUqf01OF0G2stVwKjBkgT469mimIoZ8m48+cwblJmDdwdaDmV28nhZEz02PVK4
	LziU81oNYk4GocVVQiofr9uD/qEamK+tABRzRC+1bHbBXKp3CPGR7PNwfqAaH5siv/eFutBm0PU
	qvztCwOQNTYTubzCjrT1H1uo0nZubF4l0NGiJ7twgU11eV5kS47jSYTxeNT6L86/FzsJssY9vng
	fuuYdap9C3lxjo9HFkmSWBMNE4/FjyFiUtA==
X-Google-Smtp-Source: AGHT+IEzr9jrK3MqEFYKMgLIWYTjssE2U6iSeHK3JVv5WiuQYDYPp5VXlS4Rx6IaMtKrDNjdUXWfqA==
X-Received: by 2002:a05:6e02:4506:10b0:3e2:8e44:8240 with SMTP id e9e14a558f8ab-3e28e448353mr59141415ab.11.1752873034702;
        Fri, 18 Jul 2025 14:10:34 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084c7bce49sm520209173.28.2025.07.18.14.10.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 14:10:33 -0700 (PDT)
Message-ID: <c6dca956-d0ea-4c63-a48f-d02f21d38b9d@linuxfoundation.org>
Date: Fri, 18 Jul 2025 15:10:32 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH] selftests/pidfd: align stack to fix SP alignment
 exception
To: Shuai Xue <xueshuai@linux.alibaba.com>, brauner@kernel.org,
 shuah@kernel.org, will@kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: baolin.wang@linux.alibaba.com, tianruidong@linux.alibaba.com,
 catalin.marinas@arm.com, mark.rutland@arm.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250616050648.58716-1-xueshuai@linux.alibaba.com>
 <ee095fdd-b3c1-4c41-9b06-a8e3695c1863@linuxfoundation.org>
 <0a8d5fdb-28b9-41f5-a601-cf36641bddbf@linux.alibaba.com>
 <821acc51-1429-4625-bae5-daa67bddc7bc@linux.alibaba.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <821acc51-1429-4625-bae5-daa67bddc7bc@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/16/25 01:00, Shuai Xue wrote:
> 
> 
> 在 2025/6/19 10:26, Shuai Xue 写道:
>>
>>
>> 在 2025/6/19 05:36, Shuah Khan 写道:
>>> On 6/15/25 23:06, Shuai Xue wrote:
>>>> The pidfd_test fails on the ARM64 platform with the following error:
>>>>
>>>>      Bail out! pidfd_poll check for premature notification on child thread exec test: Failed
>>>>
>>>> When exception-trace is enabled, the kernel logs the details:
>>>>
>>>>      #echo 1 > /proc/sys/debug/exception-trace
>>>>      #dmesg | tail -n 20
>>>>      [48628.713023] pidfd_test[1082142]: unhandled exception: SP Alignment, ESR 0x000000009a000000, SP/PC alignment exception in pidfd_test[400000+4000]
>>>>      [48628.713049] CPU: 21 PID: 1082142 Comm: pidfd_test Kdump: loaded Tainted: G        W   E      6.6.71-3_rc1.al8.aarch64 #1
>>>>      [48628.713051] Hardware name: AlibabaCloud AliServer-Xuanwu2.0AM-1UC1P-5B/AS1111MG1, BIOS 1.2.M1.AL.P.157.00 07/29/2023
>>>>      [48628.713053] pstate: 60001800 (nZCv daif -PAN -UAO -TCO -DIT +SSBS BTYPE=-c)
>>>>      [48628.713055] pc : 0000000000402100
>>>>      [48628.713056] lr : 0000ffff98288f9c
>>>>      [48628.713056] sp : 0000ffffde49daa8
>>>>      [48628.713057] x29: 0000000000000000 x28: 0000000000000000 x27: 0000000000000000
>>>>      [48628.713060] x26: 0000000000000000 x25: 0000000000000000 x24: 0000000000000000
>>>>      [48628.713062] x23: 0000000000000000 x22: 0000000000000000 x21: 0000000000400e80
>>>>      [48628.713065] x20: 0000000000000000 x19: 0000000000402650 x18: 0000000000000000
>>>>      [48628.713067] x17: 00000000004200d8 x16: 0000ffff98288f40 x15: 0000ffffde49b92c
>>>>      [48628.713070] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
>>>>      [48628.713072] x11: 0000000000001011 x10: 0000000000402100 x9 : 0000000000000010
>>>>      [48628.713074] x8 : 00000000000000dc x7 : 3861616239346564 x6 : 000000000000000a
>>>>      [48628.713077] x5 : 0000ffffde49daa8 x4 : 000000000000000a x3 : 0000ffffde49daa8
>>>>      [48628.713079] x2 : 0000ffffde49dadc x1 : 0000ffffde49daa8 x0 : 0000000000000000
>>>>
>>>> According to ARM ARM D1.3.10.2 SP alignment checking:
>>>>
>>>>> When the SP is used as the base address of a calculation, regardless of
>>>>> any offset applied by the instruction, if bits [3:0] of the SP are not
>>>>> 0b0000, there is a misaligned SP.
>>>>
>>>> To fix it, align the stack with 16 bytes.
>>>>
>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>> ---
>>>
>>> Assuming this is going through Christian's tree.
>>>
>>> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
>>>
>>> Let me know if you would like me to pick it up.
>>>
>>> thanks,
>>> -- Shuah
>>
>> Hi, Shuah
>>
>> Thanks for your review.
>>
>> I send this fix in Mar, but it missed last linux version.
>> I think I need your help to pick it up.
>>
>> Thanks.
>> Shuai
>>
> 
> Hi, Shuah,
> 
> Gentle ping,
> 
> Thanks.
> Shuai
> 

Will, Christian,

Can you take a look at this and let me know if this change looks
good to you both.

I can take this through my tree after your reviews.

thanks,
-- Shuah

