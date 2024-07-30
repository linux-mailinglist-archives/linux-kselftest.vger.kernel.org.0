Return-Path: <linux-kselftest+bounces-14499-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC5EC942326
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2024 00:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0A601C21EDD
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 22:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57B821917E6;
	Tue, 30 Jul 2024 22:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fGPdAVwv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CCBD18FC9A
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 22:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722380104; cv=none; b=EtkxFq5viiOa1zvJX0K++deWh1cGbIQ0ORw55HAWgVsKxf0Q05c8BePbPflB/8waB4qz8id0SuQzkVG3jzTycSn7p/w0gosT0qPsNx2SRIKTcQn+r/4a7z4I0+IPpbLqIk4EAuK5iC3NR27sFtZWJfJR2V1w0TyI1d0s5y2T9UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722380104; c=relaxed/simple;
	bh=WZ3/rWEXG8g86e90yrwydrXqWQuW6onnuGzyWKbn2Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NadkZXbqTto6ccmKWqoXD0ZZ2zXcizJCaln3d16sfEx0/cvIsHfx/WfmHjCnBp8xG7NkHWErPiPc65Y2g/DNAOKxkKVa33Jf9eckb2GqFMX80e+7ro0Lj6kOAcB8xQqu/TffgNZSJWJCvP0TYmFl7crMff88oSv7C9SGRWzIVZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fGPdAVwv; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-39aeccc64e8so1144575ab.2
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 15:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722380102; x=1722984902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qoyRtMzVDOTOSVMcNBNPwWShL7yqzSfNXIrJBWdDdno=;
        b=fGPdAVwvg8Te6xkdzyuFDRlTbtmI5s01ZjNmo5X02i2TP34fY9zgVSDaXxRP9jvIWV
         rrJX31cpLOO7UyimW1qaD/BLiEsJqpKpby1QUQaVBjW5XP8Npwx7UoHnof3xNmHldkIa
         xp0HGB0g6zjysS5vENlwPPxa7Oz8T4ERSXQuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722380102; x=1722984902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qoyRtMzVDOTOSVMcNBNPwWShL7yqzSfNXIrJBWdDdno=;
        b=Hm+mZtuV15bvVNDkQsocS9VLNWGSzgcjYUHZS9cl16wd35/fhl1AGX1r/oMEWzAxOn
         zMbbkFNNeawaeW2atZZeuDmB5wCIUuq4+5cJfExS/FaDbWitRDQfwJlR0+R8yssIAlCK
         84SIJxb57k76vv33kV3k4DWe/JVInium0mMKnDd7GK/RVtxX8FQlAVKGvMJ25/55Yz73
         PJVPAltvtAojXwkxaXb7HxxmLYgT4cEgqf8jpVQY5r4efST8cF9TaN1fk+h83hg3jWke
         p8O7cdks9661jhqK/9Xl5d7GtoB7gOcjZtipINPqhdW2PltPDpSy6OvwBSxLKXmf2ODW
         ySVg==
X-Gm-Message-State: AOJu0YwSTTW8psTIbf/8Bekttd5cbdFROoDtbQJozpw58lEd3AteH8TE
	oEOz/hr52KLewbNJuXT2XVHjyMFYibf0rbk56187XoUqNA1IpMkIEfBDQRLkDdc2Baa0gdjCcWZ
	W
X-Google-Smtp-Source: AGHT+IE0J88IPs6PTLB5D2s6BzsB0tgWoXin9ud9y3oLV0lml4OOF8/cS9mwwDY/V0gR4AHkSVf9iw==
X-Received: by 2002:a05:6e02:1fcf:b0:381:c5f0:20d5 with SMTP id e9e14a558f8ab-39a22c4add5mr127399165ab.0.1722380101694;
        Tue, 30 Jul 2024 15:55:01 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39af7929ba2sm25175015ab.3.2024.07.30.15.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:55:01 -0700 (PDT)
Message-ID: <f1a6d13b-a5b8-45c2-bd45-b44b5b70a25d@linuxfoundation.org>
Date: Tue, 30 Jul 2024 16:55:00 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Converting kselftest test modules to kunit
To: Muhammad Usama Anjum <usama.anjum@collabora.com>,
 Kees Cook <keescook@chromium.org>, davidgow@google.com
Cc: "open list : KERNEL SELFTEST FRAMEWORK"
 <linux-kselftest@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 kunit-dev@googlegroups.com, "kernel@collabora.com" <kernel@collabora.com>,
 Shuah Khan <shuah@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>
References: <327831fb-47ab-4555-8f0b-19a8dbcaacd7@collabora.com>
 <533826b3-8bc4-40f8-a491-5bb5614469c3@linuxfoundation.org>
 <a3083ad4-e9dc-40da-bf57-8391bcd96a6c@collabora.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <a3083ad4-e9dc-40da-bf57-8391bcd96a6c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/29/24 01:55, Muhammad Usama Anjum wrote:
> On 7/27/24 12:35 AM, Shuah Khan wrote:
>> On 7/15/24 04:09, Muhammad Usama Anjum wrote:
>>> Hi Kees and All,
>>>
>>> There are several tests in kselftest subsystem which load modules to tests
>>> the internals of the kernel. Most of these test modules are just loaded by
>>> the kselftest, their status isn't read and reported to the user logs. Hence
>>> they don't provide benefit of executing those tests.
>>>
>>> I've found patches from Kees where he has been converting such kselftests
>>> to kunit tests [1]. The probable motivation is to move tests output of
>>> kselftest subsystem which only triggers tests without correctly reporting
>>> the results. On the other hand, kunit is there to test the kernel's
>>> internal functions which can't be done by userspace.
>>>
>>> Kselftest:    Test user facing APIs from userspace
>>> Kunit:        Test kernel's internal functions from kernelspace
>>>
>>> This brings me to conclusion that kselftest which are loading modules to
>>> test kernelspace should be converted to kunit tests. I've noted several
>>> such kselftests.
>>>
>>> This is just my understanding. Please mention if I'm correct above or more
>>> reasons to support kselftest test modules transformation into kunit test.
>>>
>>> [1] https://lore.kernel.org/all/20221018082824.never.845-kees@kernel.org/
>>>
>>
>> Please make sure you aren't taking away the ability to run these tests during
>> boot.
> The kunit tests are usually run at boot time. They can be run later as
> well. So I'm not trying to remove any functionality. Rather adding a way
> where failures would actually be detected.
> 
>> It doesn't make sense to convert every single test especially when it
>> is intended to be run during boot without dependencies - not as a kunit test
>> but a regression test during boot.
> I started investigating when these lib kselftests were just loading the
> test module without checking if test actually passed/failed (which proves
> that this type of kselftests can never detect regression as it doesn't
> process the results). It was strange. Hence I found out the conversion of
> such kselftests to kunit tests done by Kees and started this thread for
> discussion before doing actual work and sending patches.
> 
>>

I explained this on two other threads. If you don't know how this test
is used why are you making this change?

>> bitmap is one example - pay attention to the config help test - bitmap
>> one clearly states it runs regression testing during boot. Any test that
>> says that isn't a candidate for conversion.
> Please can you explain what do you mean by bitmap testing during boot? As
> far as I understand, the kselftests are usespace tests and are run after
> kernel has booted completely and userspace has started. It cannot be
> regarded as testing during boot.
> 

I responded to David - let me know you would like me to repeat it.

thanks,
-- Shuah


