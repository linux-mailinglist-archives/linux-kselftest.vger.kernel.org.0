Return-Path: <linux-kselftest+bounces-22308-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 606B59D2EEC
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 20:40:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9CDE1F21E8A
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0984D1D0F7D;
	Tue, 19 Nov 2024 19:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DxXBPVYz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971B1547C8
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 19:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732045244; cv=none; b=AT7PF9moSho1KOZBKhS4gnX680zawxNXfKJMSjBwli1Wc7D9Y9uG12W5IC9D/8Oqakj9po55e5aFFrM1t22Gtl5S/CO/v9/hE/pMdM6/gN85ebi0iwrM8v7AR37o7Xol29CZqe5wA2AepyXzxiy0yMyCddD314r/6tyPJPvPwjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732045244; c=relaxed/simple;
	bh=rLn42420PR3cBXKYRrILAJ/Ba8HaQJluwG+HTNjJAbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MoPJNRK/5yYZ1Ej5dhDbyd9gw3dqKYa2al7t0nnZiw/IEGj2v7t4lEzv4BJDpe8Kl/pUU+uBesMzMrdXgmomO0IIVCxXpCrXzdhhMQV+EexjM89GzY58TcsDWd7SHbVrZKVl5VbzVUwqAfzNOgng9SncWV70/moVcXi5SGGkrOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DxXBPVYz; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3a77980fe3aso492845ab.0
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 11:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1732045241; x=1732650041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jed5BIT1Uf7HptS4teRoLgsU00tH0pqRyA/9bRO44a0=;
        b=DxXBPVYzARYES8x2sC2P/8viWMD7gKUFmDymeitkWRVdcVAH8QZ2E6CkgkbjQSqhX5
         KMriSABG2COCONJgZzhZ/iRE3xuWhDW5WeFHWHiviTp3qLv7vbZZMgkiSDlzkPXUWeo/
         AThvFVm646cRTSMCeK9yrMrp0tsPls7zki+XU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732045241; x=1732650041;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jed5BIT1Uf7HptS4teRoLgsU00tH0pqRyA/9bRO44a0=;
        b=aeUMYsQI2dA/UMPxvF+v9mgfYyUbyisujNh/WAdqtr3kbshatnLkeWJpcaZyO2Gq7Z
         lPZlk9nomQjlxxRWUgh8cAJ9DBC2L8hoZl2mYDyq3R0+eGhunnSnVS5KGemUj49/vSBb
         vGR3Wo4Ltfgkh9BqvC19Y7+L5SlsA+llgVg3jhRysAPYIs1EsJ+twq2QzpY5XWLn4rPl
         qgd4AKL5gMlGej3hcEHVMSVSLtq7CqOVgY8lIzk4SupUUdcYZclHZ8SX4frdtIcXvve4
         OOhVYWSvJg2/3uTu48Tjrxxr9U/kYVzFK1y17tVwBYKgqmdRlSZwdQApmvDgR/Rphnw+
         EiTw==
X-Forwarded-Encrypted: i=1; AJvYcCVAqhDgjBoOD84tfiVzi4VoVXbBD28zwodlqJAMhmeA8kMaO+PZZ7c9Yt015KGNQj1JCOdL8FBMHb+wfOPkFLs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi29T/b58MZzZ0wevJ/xG65nkEms0z700roPG0DB/86Dqtvpf5
	qQ18BMtXnzgg7A0qm/M/3yWKxkJuZSYIOasEFNHschfndaW77nm5tgMFu2uGCLbswkHsIn9cG5L
	/
X-Google-Smtp-Source: AGHT+IFdyMljszmhAxhspk9Gqkcwx+WFsNUJblHDzu5UUDJyptA19EkhXf2mUtpeKtM2WrlngFK/Ww==
X-Received: by 2002:a05:6e02:ca2:b0:3a7:68fa:2fc8 with SMTP id e9e14a558f8ab-3a7774c83eamr38919675ab.8.1732045241053;
        Tue, 19 Nov 2024 11:40:41 -0800 (PST)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a76229999fsm16806205ab.77.2024.11.19.11.40.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Nov 2024 11:40:40 -0800 (PST)
Message-ID: <e35963f3-6861-46c9-a977-07620da0dd37@linuxfoundation.org>
Date: Tue, 19 Nov 2024 12:40:39 -0700
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GIT PULL] KUnit update for Linux 6.13-rc1
To: Kuan-Wei Chiu <visitorckw@gmail.com>, David Gow <davidgow@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: shuah <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Brendan Higgins <brendan.higgins@linux.dev>,
 Shuah Khan <skhan@linuxfoundation.org>
References: <589ea100-ee1b-4a37-8f18-a25d86fdb082@linuxfoundation.org>
 <ZzvwEUIVs0M+/3Yu@visitorckw-System-Product-Name>
 <ce995a53-7fbd-43a3-be4d-70fc57b07212@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <ce995a53-7fbd-43a3-be4d-70fc57b07212@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/19/24 08:36, Shuah Khan wrote:
> On 11/18/24 18:55, Kuan-Wei Chiu wrote:
>> Hi Shuah,
>>
>> On Mon, Nov 18, 2024 at 12:19:50PM -0700, Shuah Khan wrote:
>>> Hi Linus,
>>>
>>> Please pull the following kunit update for Linux 6.13-rc1.
>>>
>>> kunit update for Linux 6.13-rc1
>>>
>>> -- fixes user-after-free (UAF) bug in kunit_init_suite()
>>>
>>> -- adds option to kunit tool to print just the summary of test results
>>>
>>> -- adds option to kunit tool to print just the failed test results
>>>
>>> -- fixes kunit_zalloc_skb() to use user passed in gfp value instead of
>>>     hardcoding GFP_KERNEL
>>>
>>> -- fixes kunit_zalloc_skb() kernel doc to include allocation flags variable
>>>
>>> diff is attached.
>>>
>>> Tests passed on my kunit repo:
>>>
>>> - Build make allmodconfig
>>>
>>> ./tools/testing/kunit/kunit.py run
>>> ./tools/testing/kunit/kunit.py run --alltests
>>>
>>> ./tools/testing/kunit/kunit.py run --arch x86_64
>>> ./tools/testing/kunit/kunit.py run --alltests --arch x86_64
>>>
>>> thanks,
>>> -- Shuah
>>>
>>> ----------------------------------------------------------------
>>> The following changes since commit 2d5404caa8c7bb5c4e0435f94b28834ae5456623:
>>>
>>>    Linux 6.12-rc7 (2024-11-10 14:19:35 -0800)
>>>
>>> are available in the Git repository at:
>>>
>>>    git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest tags/linux_kselftest-kunit-6.13-rc1
>>>
>>> for you to fetch changes up to 67b6d342fb6d5abfbeb71e0f23141b9b96cf7bb1:
>>>
>>>    kunit: tool: print failed tests only (2024-11-14 09:38:19 -0700)
>>>
>>> ----------------------------------------------------------------
>>> linux_kselftest-kunit-6.13-rc1
>>>
>>> kunit update for Linux 6.13-rc1
>>>
>>> -- fixes user-after-free (UAF) bug in kunit_init_suite()
>>>
>>> -- adds option to kunit tool to print just the summary of test results
>>>
>>> -- adds option to kunit tool to print just the failed test results
>>>
>>> -- fixes kunit_zalloc_skb() to use user passed in gfp value instead of
>>>     hardcoding GFP_KERNEL
>>>
>>> -- fixes kunit_zalloc_skb() kernel doc to include allocation flags variable
>>>
>>> ----------------------------------------------------------------
>>> Dan Carpenter (2):
>>>        kunit: skb: use "gfp" variable instead of hardcoding GFP_KERNEL
>>>        kunit: skb: add gfp to kernel doc for kunit_zalloc_skb()
>>>
>>> David Gow (1):
>>>        kunit: tool: Only print the summary
>>>
>>> Jinjie Ruan (1):
>>>        kunit: string-stream: Fix a UAF bug in kunit_init_suite()
>>>
>> The patch [1] intended to address the UAF issue in kunit_init_suite()
>> is not correct and does not actually fix the problem. A v2 patch [2]
>> with the proper fix has been sent.
>>

Kuan-Wei, Thank you for spotting this.

> 
> Hmm. I picked this up because David reviewed it and added his
> Reviewed-by. I would like David's feedback on which patch we
> should be taking.
> 
>>
>> [1]: https://lore.kernel.org/lkml/20241024094303.1531810-1-ruanjinjie@huawei.com
>> [2]: https://lore.kernel.org/linux-kselftest/20241112080314.407966-1-ruanjinjie@huawei.com
> 
> David, Can you take you let me know. I don't mind redoing the PR
> for Linus. I just have to know which patch to take.
> 

David confirmed that v2 is the right one to take on a separate thread.
I will will redo the pull request dropping the UAF v1 patch.

Linus, I will send you pull request later this week. Please ignore this
one.

thanks,
-- Shuah


