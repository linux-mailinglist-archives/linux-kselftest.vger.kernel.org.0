Return-Path: <linux-kselftest+bounces-14478-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0B9941605
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 17:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0C31C23125
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Jul 2024 15:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96951BA862;
	Tue, 30 Jul 2024 15:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BTMYePbX"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321271B5839
	for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 15:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354926; cv=none; b=CZZNcDSQEETZrNOlb3xKMAARtLr13BPe/AjVHT1c2g/s7G2TIovGlQYkctLF3mV+z4YdaAfPWt8XK9tMp/5FONjoHYCY1hHVd2GSTNtatJ2VznYzRoFb7d+4X5bXxp2s0gPOWdLiRNT7pJE2yKXGQbb4AqeuNp21v9vrguqRkm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354926; c=relaxed/simple;
	bh=vWmqf+DZ6yy7uefW9kB1OXmHEFwi0VcF0uleWNg69dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sa3kQ+WL+lYoHbQ/8qDQe1vheqCmKvxQJMFTMmBduoMgLGvYtUhQRgWlgObsLdLCpqzD5ghGRCAR7lfXUafenkuv+YPmARKOIwOd5hJloUJ1MgRBnzjoQ61m8+G3B94kxALq/TRSlS07wM1XwhMn3Pl8zTwmCIyioI+pX/Y+rxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BTMYePbX; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-81f861f36a8so24902339f.0
        for <linux-kselftest@vger.kernel.org>; Tue, 30 Jul 2024 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1722354924; x=1722959724; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PzCaghtWJkWwHrbcMiszDi+qmsX7TBq8ffoDMqJhL1o=;
        b=BTMYePbXq0tPGbhaW4vRXZ1gc/9bf8MtYyrdJZO7wVBIcf7EzMPy2tuE9Q/onuiAfR
         L1WHSKI8jfkMMnXtmJklEnEY6+/rzrK/L4t/G4NMaNhnxPK547CQNyt0s4NbL2Kf3nfF
         PuWGGgAh3hxYV4FPl3fKmxpcaphg3HBdyt0EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722354924; x=1722959724;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzCaghtWJkWwHrbcMiszDi+qmsX7TBq8ffoDMqJhL1o=;
        b=degwXDb2qyhlle91NROROBPnMWoIjokZ6oVfVfEgDTXdMIdKDpgQTBDCaG5PfAeDPV
         0p6gmVs12XuryAE/ebBcXIOwM9zSzUO9PtWYIpnrRQTv8i0mzwfqp0TnBQ7yQZul7Xpy
         RB1eqvgXAaeNVDc3sHw2gPF1kodG4WAGwPaaQApLTGzupMll8VlkNhQEe6tH6FerYi7B
         V9ekFVq3rEHDXrZEBzw5RlytxmNG31ttq1d04c5SD1ZRyQQi805Bq57IH+VA9AA6l9gO
         ORKrFXOAcQ+y6CuDYegfwEQ3RLQvjiJEuWpTVfDdS52LIeLKTSzS+bIJsuOPmfLLWgvL
         bj1A==
X-Forwarded-Encrypted: i=1; AJvYcCWVlOOCCpeMs+e9uUwvEpccMyR25HDDvR37kct6cy/e8RxsT3wrsaAiwG5fwbyarIo1VKv9EmyGZn/QeE/GiyY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymA/DlDIugba6Kr18ALThQrGCxaaGK8kvKeLvowc+Jm6ZKB7OR
	mNhbGlCJ9i1i87yh4ulF9IBpJnjR1SDSr91TD2ixVKbInxRkDSFDf0aGBElMf2X8qgafMfAKCej
	j
X-Google-Smtp-Source: AGHT+IGuQMM6gxKKpjFLk13+wgKSCeu7d/MaJ7gUsdzsTKePVhPCSVaQL3WB7bTmQo5YaG+Bs9e4GA==
X-Received: by 2002:a05:6602:1ccb:b0:81f:bf02:fd0a with SMTP id ca18e2360f4ac-81fbf0301ccmr96363439f.3.1722354924184;
        Tue, 30 Jul 2024 08:55:24 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29fc42b48sm2721593173.157.2024.07.30.08.55.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 08:55:23 -0700 (PDT)
Message-ID: <714e7642-6f92-4e41-aa36-c854668e0bb0@linuxfoundation.org>
Date: Tue, 30 Jul 2024 09:55:22 -0600
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] bitmap: Rename module
To: David Gow <davidgow@google.com>, Randy Dunlap <rdunlap@infradead.org>,
 kees@kernel.org, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Yury Norov <yury.norov@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>, kernel@collabora.com,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240726110658.2281070-1-usama.anjum@collabora.com>
 <20240726110658.2281070-3-usama.anjum@collabora.com>
 <ZqUvy_h4YblYkIXU@yury-ThinkPad>
 <85f575b4-4842-4189-9bba-9ee1085a5e80@collabora.com>
 <c0e5978b-7c11-4657-bd07-9962cd04bf9a@infradead.org>
 <CABVgOSnkxgeXXXm9xp5_PvBxtMGbyFN-Jmd6YJ1u6g81MF_fyw@mail.gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <CABVgOSnkxgeXXXm9xp5_PvBxtMGbyFN-Jmd6YJ1u6g81MF_fyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 04:10, David Gow wrote:
> On Mon, 29 Jul 2024 at 22:09, Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 7/29/24 1:07 AM, Muhammad Usama Anjum wrote:
>>> On 7/27/24 10:35 PM, Yury Norov wrote:
>>>> On Fri, Jul 26, 2024 at 04:06:57PM +0500, Muhammad Usama Anjum wrote:
>>>>> Rename module to bitmap_kunit and rename the configuration option
>>>>> compliant with kunit framework.
>>>>
>>>> ... , so those enabling bitmaps testing in their configs by setting
>>>> "CONFIG_TEST_BITMAP=y" will suddenly get it broken, and will likely
>>>> not realize it until something nasty will happen.
>>> CONFIG_TEST_BITMAP was being enabled by the kselftest suite lib. The bitmap
>>> test and its config option would disappear. The same test can be run by
>>> just enabling KUNIT default config option:
>>>
>>> KUNIT_ALL_TESTS=y enables this bitmap config by default.
>>>
>>>>
>>>> Sorry, NAK for config rename.
>>>>
>>
>> I agree with Yury. Using KUNIT takes away test coverage for people who
>> are willing to run selftests but not use KUNIT.

This is incorrect. There are selftest that are used to

- regression test a subsystem or a abi during boot
- spot check on a running system to debug and test by loading
   a test module.

> 
> I can see the point that renaming the config option is just churn, but
> is there a reason people would run the bitmap selftest but be unable
> or unwilling to use KUnit?
> 
> Beyond a brief period of adjustment (which could probably be made
> quite minimal with a wrapper script or something), there shouldn't
> really be any fundamental difference: KUnit tests can already run at
> boot, be configured with a config option, and write output to the
> kernel log. There's nothing really being taken away here, and the
> bonus of having easier access to run the tests with KUnit's tooling
> (or have them automatically run by systems which run KUnit tests)
> would seem worthwhile to me, especially since it's optional. And
> CONFIG_KUNIT shouldn't be heavy enough to cause problems.
> 
> Obviously I can't force people to use KUnit, but this is exactly the
> sort of test which would fit KUnit well, and -- forgive me if I'm
> missing something -- the only real argument against it I'm hearing is
> "it's different". And while that's valid (as I said, churn for churn's
> sake isn't great), none of the "people who are willing to run
> selftests but not use KUnit" have given reasons why. Especially since
> this is the sort of test (testing in-kernel functions) we're
> encouraging people to write with KUnit in
> Documentation/dev-tools/testing-overview.rst -- if there are good
> reasons people are refusing to run these, maybe we need to fix those
> or change the recommendation.

It isn't about kunit vs. kselftest. It is about overall kernel validation
and ability to test effectively by developers and users.

KUnit isn't ideal for cases where people would want to check a subsystem
on a running kernel - KUnit covers some use-cases and kselftest covers
others.

What happens if we are debugging a problem that requires us to debug on
a running system? Please don't go converting kselftest into kunit without
understanding how these frameworks are intended to be used.

Yes kselftest results need to be looked at. Write a parser which can
be improved. What you are doing is reducing the coverage and talking
away the ability to debug and test on running system.

Fix what needs to be fixed instead of deleting tests.

Think through the use-cases before advocating KUnit is suitable for
all testing needs and talking about being able to force or not force
people to use one or the other.

Reports aren't everything. The primary reason we have these tests is for
developers to be able to test. Reports can be improved and shouldn't
come at the expense of coverage and testing. Any patch that does that
will be NACKed.

thanks,
-- Shuah



