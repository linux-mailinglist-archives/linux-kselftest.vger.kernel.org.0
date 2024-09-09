Return-Path: <linux-kselftest+bounces-17537-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 422AE972166
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 19:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AD6AB20F03
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Sep 2024 17:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296791741EF;
	Mon,  9 Sep 2024 17:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTHwffMD"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69BBF43AA1
	for <linux-kselftest@vger.kernel.org>; Mon,  9 Sep 2024 17:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725904482; cv=none; b=elYDm/j39MORrveFk1eyrSUd49RE6gU/YOIeRmSpts+vBubjvz38wyvjrinspoXo3XebcgwQTX9HipfBl4A4vSk1SUmMeFTZENOH1Oksct2q5juWJTxczVHaf2dkKVpHJfKY4e7fq71LzcEOPvVwtbtxLQXtaY1LSPx1F33kscw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725904482; c=relaxed/simple;
	bh=vybxojdhchalVHu1c9HUem4NZbCfHP8ojkbpeFrXeog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Deg6QH9Wb+3b+gdSs8HXpxMSPWwJxwf9F3p9Re601LYR/pHA3/XEiMHZcTeC4ipdHp6w427d30zbK9qty5Vm0qT4YX7lXb52vwfg2BuCovKtLXwEpdYj0yxYIMWIWYjQbHgMzam/xLVCQaa2hXo1rXv3P86PyOKQbtZAhy7iwl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTHwffMD; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-82aa8c36eefso94359839f.3
        for <linux-kselftest@vger.kernel.org>; Mon, 09 Sep 2024 10:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1725904479; x=1726509279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRaCJ6v/oaioxUrBJqLm4j7ohLCqof9JLJBb+HhJo38=;
        b=eTHwffMDwC9Ij+wpPc6g1Lky4om2ANByxzEdg3aFU1Bw01wElEO9FjwbUOkpIjIVy0
         U64ACo5ErkvmW05mVZVwG14paeM56hwK2T77Dgsx1e/wpMfBdC9CEdPFiEwtNiyVmD7H
         hgv6g6W7scmPpeDn3mGf8DgcpOVUCKw1C9ECw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725904479; x=1726509279;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RRaCJ6v/oaioxUrBJqLm4j7ohLCqof9JLJBb+HhJo38=;
        b=hFPd+1/E/SUjMkLbA5wp32HZmo9IMFIvEsQn4Wn5wwi8p2XH3dAERO/GQnAmjlbyhs
         QvkG0qaEdFqF5J3kpTp5v6/rIE5g+a16FvVHRfjbfRqdmqcqO7McZS3x13iOK05rkMhW
         gE/KCtrDbv/wCDMYtah/QSCUrWVP+kUO2bh8ZESKbdCdd64Zp+lKU2DWan9s72HihenW
         ESYcpsy99EFXkhhsKL4KHf4nyR8bHcTj/sT+VFMRk4BnlLzfcH2WSSsH75JgtZjYyNeG
         MiGsKQoBB/RYSMupZHPrtnY4NrF1JgjqC3crho7nfSEXxw6/ffZlICj2WgkQDdPISFgh
         +sqg==
X-Forwarded-Encrypted: i=1; AJvYcCW/VZ1cisL8C7bm6nEK4OuLkr/Emg0TurmjJClWgDumkT+7VIwCvFYVBxaIAZ1tKqyiYBgRKbMBopUrV4TwYLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLe5cajznxFqJaw1tZbuX9U+iPe3aNF/bEOFORJ0C2qneB2cWf
	mpCluVcS+XJNOZDQN7yHOxLpuKIfv8bHZIxlF6e/OnppUtgkiy+vhRvWp2dOBC4=
X-Google-Smtp-Source: AGHT+IGAmw5+6pomdKtj5O6nZ0wxCHy73UXTlCExg5L0v7B++fc3NeX+rFRSF7k0Z8ynPqlNFs0oxw==
X-Received: by 2002:a05:6e02:1d94:b0:39d:2939:3076 with SMTP id e9e14a558f8ab-3a04f0ec140mr146019795ab.25.1725904479411;
        Mon, 09 Sep 2024 10:54:39 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a058fc840fsm15477755ab.6.2024.09.09.10.54.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Sep 2024 10:54:38 -0700 (PDT)
Message-ID: <cb2f88e0-8e31-43a0-a5ea-03f0ab05417e@linuxfoundation.org>
Date: Mon, 9 Sep 2024 11:54:37 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] selftests: Rename sigaltstack to generic signal
To: Dev Jain <dev.jain@arm.com>, shuah@kernel.org, oleg@redhat.com
Cc: mingo@kernel.org, tglx@linutronix.de, mark.rutland@arm.com,
 ryan.roberts@arm.com, broonie@kernel.org, suzuki.poulose@arm.com,
 Anshuman.Khandual@arm.com, DeepakKumar.Mishra@arm.com,
 aneesh.kumar@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, sj@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240822121415.3589190-1-dev.jain@arm.com>
 <20240822121415.3589190-2-dev.jain@arm.com>
 <714f8eb4-b226-48f6-ab0d-75bdfbf83364@linuxfoundation.org>
 <42d0fa4b-eb67-42fd-a8e1-05d159d0d52f@arm.com>
 <806e4be0-4b1f-4818-806f-a844d952d54e@arm.com>
 <fff2b685-a7a5-4260-a293-f2abf55d9ce4@linuxfoundation.org>
 <514713eb-235c-40ee-8c25-f1f3e1ca7f7a@arm.com>
 <d5dc1bd9-4473-405f-99fc-192691f41c4f@linuxfoundation.org>
 <0b3af60f-0449-48a1-b228-f26618b9d50a@arm.com>
 <fcdbd8bc-9986-497e-8de4-86d3e619ca73@linuxfoundation.org>
 <03c5b10d-b81c-4074-9c27-8ffc8c7fc84a@arm.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <03c5b10d-b81c-4074-9c27-8ffc8c7fc84a@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/8/24 23:16, Dev Jain wrote:
> 
> On 9/7/24 01:29, Shuah Khan wrote:
>> On 9/4/24 23:56, Dev Jain wrote:
>>>
>>> On 9/4/24 22:35, Shuah Khan wrote:
>>>> On 9/3/24 22:52, Dev Jain wrote:
>>>>>
>>>>> On 9/4/24 03:14, Shuah Khan wrote:
>>>>>> On 8/30/24 10:29, Dev Jain wrote:
>>>>>>>
>>>>>>> On 8/27/24 17:16, Dev Jain wrote:
>>>>>>>>
>>>>>>>> On 8/27/24 17:14, Shuah Khan wrote:
>>>>>>>>> On 8/22/24 06:14, Dev Jain wrote:
>>>>>>>>>> Rename sigaltstack to generic signal directory, to allow adding more
>>>>>>>>>> signal tests in the future.
>>>>>>>>>
>>>>>>>>> Sorry - I think I mentioned I don't like this test renamed. Why are you sending
>>>>>>>>> this rename still included in the patch series?
>>>>>>>>
>>>>>>>> I am not renaming the test, just the directory. The directory name
>>>>>>>> is changed to signal, and I have retained the name of the test -
>>>>>>>> sas.c.
>>>>>>>
>>>>>>> Gentle ping: I guess there was a misunderstanding; in v5, I was
>>>>>>> also changing the name of the test, to which you objected, and
>>>>>>> I agreed. But, we need to change the name of the directory since
>>>>>>> the new test has no relation to the current directory name,
>>>>>>> "sigaltstack". The patch description explains that the directory
>>>>>>> should be generically named.
>>>>>>>
>>>>>>
>>>>>> Right. You are no longer changing the test name. You are still
>>>>>> changing the directory name. The problem I mentioned stays the
>>>>>> same. Any fixes to the existing tests in this directory can no
>>>>>> longer auto applied to stables releases.
>>>>>
>>>>> I understand your point, but commit baa489fabd01 (selftests/vm: rename
>>>>> selftests/vm to selftests/mm) is also present. That was a lot bigger change;
>>>>> sigaltstack contains just one test currently, whose fixes possibly would have
>>>>> to be backported, so I guess it should not be that much of a big problem?
>>>>>
>>>>>>
>>>>
>>>> So who does the backports whenevenr something changes? You are adding
>>>> work where as the automated process would just work without this
>>>> change. It doesn't matter if there is another test that changed
>>>> the name.
>>>>
>>>>>> Other than the desire to rename the directory to generic, what
>>>>>> other value does this change bring?
>>>>>
>>>>> Do you have an alternative suggestion as to where I should put my new test then;
>>>>> I do not see what is the value of creating another directory to just include
>>>>> my test. This will unnecessarily clutter the selftests/ directory with
>>>>> directories containing single tests. And, putting this in "sigaltstack" is just
>>>>> wrong since this test has no relation with sigaltstack.
>>>>>
>>>>
>>>> If this new test has no relation to sigaltstack, then why are you changing
>>>> and renaming the sigaltstack directory?
>>>
>>> Because the functionality I am testing is of signals, and signals are a superset
>>> of sigaltstack. Still, I can think of a compromise, if semantically you want to
>>> consider the new test as not testing signals, but a specific syscall "sigaction"
>>> and its interaction with blocking of signals, how about naming the new directory "sigaction"?
>>>> Adding a new directory is much better
>>>> than going down a path that is more confusing and adding backport overhead.
>>>>
>>
>> Okay - they are related except that you view signalstack as a subset
>> of signals. I saw Mark's response as well saying sigaction isn't
>> a good name for this.
>>
>> Rename usually wipe out git history as well based on what have seen
>> in the past.
>>
>> My main concern is backports. Considering sigstack hasn't changed
>> 2021 (as Mark's email), let's rename it.
>>
>> I am reluctantly agreeing to the rename as it seems to make sense
>> in this case.
> 
> Thanks! I guess there is no update required from my side, and you can
> pull this series?
>>

I can pull this with x86v maintainer ack.

Or to go through x86 tree:

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


