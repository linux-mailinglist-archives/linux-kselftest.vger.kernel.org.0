Return-Path: <linux-kselftest+bounces-18189-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F3197DB87
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 05:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6E91C20F6D
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Sep 2024 03:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF84C8E0;
	Sat, 21 Sep 2024 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3a1Zjq4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867981392;
	Sat, 21 Sep 2024 03:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726888090; cv=none; b=U7b0RY6L0q9S9tAJ40XIjBnOMe+sKQkBbzJrjUXPed7HITAS57+88xScTSeRzcchBjLFv/+RPQk5EGuE87eySrYZldgeQyg0ITzcNP15vvy/SPcJFk30HOcKJ7HeUUtVR56HZAXr2itYtLR41hJGTwHL2RgFT1r2ATGy9IYGj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726888090; c=relaxed/simple;
	bh=LZVbErFfdKReI9mkBeeh5ZXf6bErNE5bJsJsom7s8WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bDQVSccurclpDUAUa7/6AlGQyj4Zeo3blsv/rLPL9Ew3H/A/WbXGvBjFXVgz6saJO3Ay6CBRYc4udH0QNNqulKD3rJbyU9394rI2qSTvXbjw5dZxZjm1A+X/mXriWrTGAgFCh/nGfvk9OG1f2HTZMlIJIH9gc1dgKMU727QcwEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3a1Zjq4; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71971d2099cso2020989b3a.2;
        Fri, 20 Sep 2024 20:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726888088; x=1727492888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPprQAVUrVHm/tsPhdS3MV1vYtw/SA39EWRwyCJlFa8=;
        b=l3a1Zjq4735pisGMpokJH6lzUVvYSakQ3273GYc4XHPgMF6iSISiK1nG0tH/kyCoNV
         hFTnXe06cGad8G5PZKAwRztES+VkL0O9dnHCzxKlCynKlQjMaZoByWjLCRKuBTSVl5sj
         UiASSJ0LCWXFGU2equ+ftJ3GZCunPJqbX7kbV3a+zrQ0Yg3r3hIP33fqOIfMPciRw4Z3
         XHvuEOmltlmqbv5F/jXEUywNjXQ7vGtft1EyPfRDBOa8Si51AlWYBB9XV5gXxi6xYyaL
         rgrFTMA4NtMNQMXKEHz5DWt1gelhE0McMOla/ZOJVO9D6MV32p9S8l7ChdJ/NuAAxeD/
         wjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726888088; x=1727492888;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPprQAVUrVHm/tsPhdS3MV1vYtw/SA39EWRwyCJlFa8=;
        b=Yn7nsvjbfXQzgt6dIqjJldJy/adxNA1m5LuSSyPIG9WTNSKpqxL6a/c35qjiWwZ86P
         3ZEi/bLl5gK7eTKbY2BWdmi2S+LUk7BaLK9EIIA3ZQycetyKBWZMjrqQoLTCUg7fQeBX
         jN34eneBJOBPaBnHADF3HuNNqfoXeJ93NyZeQrmLw0oEBJ9YmGX8PkO73nlF214fXC4S
         j45RsaZgGo4iInXfCje1UcmL807QDrlOTRhONFyp1bGU9AaOqTHdOQR7bahXqsywMX0K
         TqoqqxrNJdbflny1WrNIUKtcZ/lCJFAWWts2TZqp3R2wyEkzQcH6WFAYA5GuXdYCl5+l
         0zDg==
X-Forwarded-Encrypted: i=1; AJvYcCVO7IGkEhq5H0TtRG957vKQRytlR5SBk1ZIeylMX6NKsHjtkBMxOuB71Zsd/WCHCUaX6bVnt9z9S5nBuss=@vger.kernel.org, AJvYcCVargJgOtaUIvsWzDzKbmGafGZWewxE5ipCityD1UaWUK4J9cF78zUTSJWRR811l1PzjytpQjxru0ouP2JVrbz0@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp5M625b07ywoQ8cPHOAWBaaEutvAhHmT14Xz8lXe9u4opxxsK
	7Iy5lzED0Xq+vC00bYUn86ggsjVnUyL0/s2jDuca65pj86TSa4Ik
X-Google-Smtp-Source: AGHT+IGud+/cz2OldIIDXbv/r7jevJ8fNdwPc07GJiHTkcSOJWKBWyvy0GWD6HR8I1bMhawIFMeSnA==
X-Received: by 2002:a05:6a21:3318:b0:1d2:e889:1513 with SMTP id adf61e73a8af0-1d30a900ce7mr7850720637.17.1726888057927;
        Fri, 20 Sep 2024 20:07:37 -0700 (PDT)
Received: from [10.0.0.100] (201-0-94-15.dsl.telesp.net.br. [201.0.94.15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71944ab54f4sm10468681b3a.56.2024.09.20.20.07.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 20:07:37 -0700 (PDT)
Message-ID: <0e349fb3-857c-48b9-87f3-8865fe2d42f1@gmail.com>
Date: Sat, 21 Sep 2024 00:07:32 -0300
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] Add KUnit tests for llist
To: Shuah Khan <skhan@linuxfoundation.org>, David Gow <davidgow@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
 Brendan Higgins <brendan.higgins@linux.dev>, Rae Moar <rmoar@google.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 n@nfraprado.net, andrealmeid@riseup.net, vinicius@nukelet.com,
 diego.daniel.professional@gmail.com
References: <20240917005116.304090-1-arturacb@gmail.com>
 <bd5eb792-124f-4eaa-9ff9-a99765d1ef73@linuxfoundation.org>
 <CABVgOSmNcmnRCn5Q05U1wBebSGTM=OdUXuT7SA-poHXUgKubaQ@mail.gmail.com>
 <f641378c-e729-4c5d-bf55-24a7fc96b623@linuxfoundation.org>
Content-Language: en-US
From: Artur Alves Cavalcante de Barros <arturacb@gmail.com>
In-Reply-To: <f641378c-e729-4c5d-bf55-24a7fc96b623@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/20/24 12:10 PM, Shuah Khan wrote:
> On 9/20/24 01:10, David Gow wrote:
>> On Fri, 20 Sept 2024 at 00:01, Shuah Khan <skhan@linuxfoundation.org> 
>> wrote:
>>>
>>> On 9/16/24 18:51, Artur Alves wrote:
>>>> Hi all,
>>>>
>>>> This is part of a hackathon organized by LKCAMP[1], focused on writing
>>>> tests using KUnit. We reached out a while ago asking for advice on what
>>>> would be a useful contribution[2] and ended up choosing data structures
>>>> that did not yet have tests.
>>>>
>>>> This patch adds tests for the llist data structure, defined in
>>>> include/linux/llist.h, and is inspired by the KUnit tests for the 
>>>> doubly
>>>> linked list in lib/list-test.c[3].
>>>>
>>>> It is important to note that this patch depends on the patch referenced
>>>> in [4], as it utilizes the newly created lib/tests/ subdirectory.
>>>>
>>>> [1] https://lkcamp.dev/about/
>>>> [2] https://lore.kernel.org/all/Zktnt7rjKryTh9-N@arch/
>>>> [3] https://elixir.bootlin.com/linux/latest/source/lib/list-test.c
>>>> [4] https://lore.kernel.org/all/20240720181025.work.002- 
>>>> kees@kernel.org/
>>>>
>>>> ---
>>>> Changes in v3:
>>>>       - Resolved checkpatch warnings:
>>>>           - Renamed tests for macros starting with 'for_each'
>>>
>>> Shouldn't this a separate patch to make it easy to review?
>>>
>>
>> I think that, if this were renaming these in an already existing test
>> (like the confusingly similar list test), then yes. But since it's
>> only a change from v2, I think we're okay.
>>
>>>>           - Removed link from commit message
>>>>       - Replaced hardcoded constants with ENTRIES_SIZE
>>>
>>> Shouldn't this a separate patch to make it easy to review?
>>
>> Again, if we want to change this in other tests (list, hlist) we
>> should split it into a separate patch, but I think it's okay for llist
>> to go in with these already cleaned up.
>>
>>>
>>>>       - Updated initialization of llist_node array
>>>>       - Fixed typos
>>>>       - Update Kconfig.debug message for llist_kunit
>>>
>>> Are these changes to existing code or warnings on your added code?
>>
>> I think these are all changes to the added code since v2. Artur, is 
>> that right?
>>
>>>>
>>>> Changes in v2:
>>>>       - Add MODULE_DESCRIPTION()
>>>>       - Move the tests from lib/llist_kunit.c to lib/tests/ 
>>>> llist_kunit.c
>>>>       - Change the license from "GPL v2" to "GPL"
>>>>
>>>> Artur Alves (1):
>>>>     lib/llist_kunit.c: add KUnit tests for llist
>>>>
>>>>    lib/Kconfig.debug       |  11 ++
>>>>    lib/tests/Makefile      |   1 +
>>>>    lib/tests/llist_kunit.c | 358 +++++++++++++++++++++++++++++++++++ 
>>>> +++++
>>>>    3 files changed, 370 insertions(+)
>>>>    create mode 100644 lib/tests/llist_kunit.c
>>>>
>>>
>>> You are combining lot of changes in one single patch. Each change as 
>>> a separate
>>> patch will help reviewers.
>>>
>>> Adding new test should be a separate patch.
>>>
>>> - renaming as a separate patch
>>>
>>
>> I think given that these are just changes between patch versions, not
>> renaming/modifying already committed code, that this is okay to go in
>> as one patch?
>>
>> The actual patch is only doing one thing: adding a test suite for the
>> llist structure. I don't see the point in committing a version of it
>> only to immediately rename things and clean bits up separately in this
>> case.
> 
> I do think it will help to separate the renaming and adding a new test.
> It makes it easier to follow.
> 
> thanks,
> -- Shuah
> 

Hi, Shuah!

The renaming is in the test suite that I'm adding, as suggested by Rae 
Moar[1]. I'm not modifying any existing code; all my changes are in the 
new code that I'm adding.

I'm sorry, but it isn't clear to me. Could you please provide an example 
of what you're suggesting?

Would you prefer that I undo the renaming, submit the patch with the 
checkpatch warnings, and then follow up with a new patch to rename the 
test cases and resolve the warnings?

[1]
https://lore.kernel.org/all/20240903214027.77533-1-arturacb@gmail.com/T/#mc29a53b120d2f8589f8bd882ab972d15c8a3d202

Thanks for your time,
- Artur

