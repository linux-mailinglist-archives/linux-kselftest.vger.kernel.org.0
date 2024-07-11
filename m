Return-Path: <linux-kselftest+bounces-13544-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9761492E042
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 08:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28425B20C1C
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Jul 2024 06:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A0112C54A;
	Thu, 11 Jul 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ue6IkGUh"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E8284DE9;
	Thu, 11 Jul 2024 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720679972; cv=none; b=UrVznhDHnNnCQ8x5+AzLKmefswTB1xnNTIA7NlT9WCnq/58d+0f3zCwJYmBV3YTRdRwCpn7pbUjFxVOmjz7+42sYvKxzst8AmFc1eGC/Q89z/P37znmFTtKMBwP6PDTrxg+LDDwmB3t8l3a/N3/wciV3g0xz2aHwT2+zQYo9a+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720679972; c=relaxed/simple;
	bh=5o6GS9CFJ3XzY5WS3VjXQZyHGmQWekxQIXP5NidKh0Q=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JR3w7oUgvnul8Wbe5vLnQEVaJdPsMnpFvaWVytE+7Lq2ki06vNRcLDkbw2yPHbubBYHbf2S9IHDchZa6k8ceD+yNswXslXIAYjpSy834Q5LNYhAvkrcVuNkw1+ASl0tSAnDylWO9glMsE29j4ISUAm/d4Le8fMbrWrsoy8eov74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ue6IkGUh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1720679968;
	bh=5o6GS9CFJ3XzY5WS3VjXQZyHGmQWekxQIXP5NidKh0Q=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=Ue6IkGUhsXxaKwC0b3SYMDQmDxY1ADssBHd2Hquwfn2sz2KSsRua1Y+Qol4Y9xn3M
	 BcA+9/JRkFTvisGXBe6WPOcLKfd4HuI0FLrx8vOiIIDKCkkco5Rm/hrwYvz0A8WE4A
	 z1BizDPXdu8R2e2VO1hR4+FvCsmBB2sWcAYvuAIkWIBs7mdhT5zZJurou4o4KH9knf
	 Q//skXCy/D5UB/DKFoGLUV3T/eLPVmtehgGHhmcjFdv5614XCP4zTRebGwxdhMukLY
	 4sSMzuiLSzTwXKQQebo3G0ThFUksNONG6HSQvkFME/W1HkrUgk/PVhuoT45Neaix0R
	 QZA4CFcmM74TQ==
Received: from [100.113.15.66] (ec2-34-240-57-77.eu-west-1.compute.amazonaws.com [34.240.57.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: usama.anjum)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3D4423780627;
	Thu, 11 Jul 2024 06:39:25 +0000 (UTC)
Message-ID: <bab6401b-56e0-4fb7-8ae7-90607c52c58d@collabora.com>
Date: Thu, 11 Jul 2024 11:39:23 +0500
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Al Viro <viro@zeniv.linux.org.uk>, kernel@collabora.com,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: openat2: don't print total number of tests and
 then skip
To: Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>,
 Aleksa Sarai <cyphar@cyphar.com>
References: <20240522214647.3568788-1-usama.anjum@collabora.com>
 <1fc06a15-f06e-4db1-ace5-b9d52250d0df@collabora.com>
 <20240701.085146-junky.rubs.mossy.crews-uyuNIdHgWxb@cyphar.com>
 <148d4c61-b60a-401f-96ee-b0291bcf87b3@collabora.com>
 <c0007f80-d44b-42fa-afd4-fdaeb3b89f70@collabora.com>
 <6d82fa16-ed2e-41f1-a466-c752032b6f68@linuxfoundation.org>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <6d82fa16-ed2e-41f1-a466-c752032b6f68@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/10/24 9:18 PM, Shuah Khan wrote:
> On 7/10/24 03:33, Muhammad Usama Anjum wrote:
>> Hi Shuah,
>>
>> Can you take the patch as is or by removing following from this patch:
>>
>> -    if (geteuid() != 0)
>> +    if (geteuid())
> 
> As Aleksa mentioned, geteuid() != 0 is preferred.
I can make the change after concluding the following discussion.

> 
>>
>> On 7/2/24 12:02 PM, Muhammad Usama Anjum wrote:
>>> On 7/1/24 2:14 PM, Aleksa Sarai wrote:
>>>> On 2024-07-01, Muhammad Usama Anjum <usama.anjum@collabora.com> wrote:
>>>>> Adding more people for review
>>>>>
>>>>> On 5/23/24 2:46 AM, Muhammad Usama Anjum wrote:
>>>>>> Don't print that 88 sub-tests are going to be executed. But then skip.
>>>>>> The error is printed that executed test was only 1 while 88 should have
>>>>>> run:
>>>>>>
>>>>>> Old output:
>>>>>>    TAP version 13
>>>>>>    1..88
>>>>>>    ok 2 # SKIP all tests require euid == 0
>>>>>>    # Planned tests != run tests (88 != 1)
>>>>>>    # Totals: pass:0 fail:0 xfail:0 xpass:0 skip:1 error:0
This would return FAIL exit code to kselftest executor as the planned tests
were 88 while executed tests are only 1. Hence FAIL error code would be
returned. This is completely wrong.

>>>>>>
>>>>>> New and correct output:
>>>>>>    TAP version 13
>>>>>>    1..0 # SKIP all tests require euid == 0
This would return SKIP exit code which is correct.


> 
> I think having total number tell you how many tests are there.
> I don't this this is good change.
Having "1..88" misrepresents the number of executed tests. This is against
the TAP specs. The total number of tests must be printed after finding out
that initial conditions are fulfilled. From specs: [1]

> A plan line of 1..0 indicates that the test set was completely skipped;
> no tests are expected to follow, and none should have come before.
> Harnesses should report on 1..0 test runs similarly to their handling of
> SKIP Test Points, treating any comment in the Plan as the reason for
> skipping.
>
> 1..0 # WWW::Mechanize not installed

[1] https://testanything.org/tap-version-14-specification.html

> 
> thanks,
> -- Shuah
> 

-- 
BR,
Muhammad Usama Anjum

